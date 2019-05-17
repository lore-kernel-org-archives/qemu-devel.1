Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5F3C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 05:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDF020833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 05:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLCpoeNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDF020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRUzo-0005jS-B9
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 01:01:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqe-0006Tn-5U
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqb-0007su-NH
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:59 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRUqZ-0007pE-Oh
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:57 -0400
Received: by mail-pl1-x644.google.com with SMTP id a5so2720527pls.12
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 21:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=WENpD6z57jil0Q6qU82X9ejW3kFgTvoSzkolp2LuRcw=;
	b=tLCpoeNzLkHevuU7TEU6Xj9+oLKPIplbJxlVy5Ga3WlT7ZDTBwVnv1BzyhZEjET459
	f2vWUv/IR0sGtoTAZ41hmwuUKe2bmm6S83qwZ2YySW0fnkBROb51+LQYEeVnDiahgEeT
	MUzDQp3Pz+b9Pu7j9J6pVBAgUhKjk/WVkpToYen805jfTjez9SA9jkWgpXT8FXPm6Xee
	fCekM0zUthLdJKReSWiL+Dk06diGFpjEz37PtjrsfYjI2z66KaDPEqQM0DhrmO0025XQ
	yDLrL7ilEWql2YJ9x5pCwjNJGZPfOaXhkSQgACgpln8Trhmd/kov5VJQbvSxnA+AEPFZ
	ST4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=WENpD6z57jil0Q6qU82X9ejW3kFgTvoSzkolp2LuRcw=;
	b=uh7zO04USlWCj5ZBKVNfi1HPCQ7JfFoGEZozvLciAr0ogghixH7DCnSIoihzWuCQs0
	jH829WdGEfAulnGRxP60XniY678XKsER4Tzg/sWX4ZJz+mS9Wkr8iIsjqilvOKVg4TXg
	cXxoGMmZJt3DDvF1tRf3jGDPzgzZJ/QqVgzX+MZfqOepkIuxZ/5VFvQDYZaVQUKTKQXR
	ua0tlUyKFeGtWAoB+F+IyVqN8/D/89+lWWePa9iL0BCHK6VfCiXv0w/f/B6ZGbuXI4S9
	yIivXgM72xSb2N0p+F+QakKj514H/k2uf2raI58ethAivEqh8rRzzODLoFVgo2nfSu+R
	JOJQ==
X-Gm-Message-State: APjAAAWl+p3GRzG9yY7NdR8HvYGZrfMNC+/Ba+lMtub5tVWMgtUDU3i0
	es1NantJBY4tyAuTRfZsiSHRpZ7EYy8=
X-Google-Smtp-Source: APXvYqyODdVlOAEn2Agge8fzJPTDEZbiSU1R1SdL8DBjP4TMeHy4q9JMuHdZwXRt+PuJjPTGQVp3eQ==
X-Received: by 2002:a17:902:e708:: with SMTP id
	co8mr54102639plb.141.1558068713397; 
	Thu, 16 May 2019 21:51:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	132sm7709625pga.79.2019.05.16.21.51.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 21:51:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 21:51:36 -0700
Message-Id: <20190517045136.3509-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517045136.3509-1-richard.henderson@linaro.org>
References: <20190517045136.3509-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v14 13/13] MAINTAINERS: Add RX
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190516055244.95559-13-ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a73a61a546..ef6a02702e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -272,6 +272,13 @@ F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
 
+RENESAS RX
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+S: Maintained
+F: target/rx/
+F: hw/rx/
+F: include/hw/rx/
+
 S390
 M: Richard Henderson <rth@twiddle.net>
 M: David Hildenbrand <david@redhat.com>
@@ -1106,6 +1113,18 @@ F: pc-bios/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
 
+RX Machines
+-----------
+RX-QEMU
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+S: Maintained
+F: hw/rx/rxqemu.c
+F: hw/intc/rx_icu.c
+F: hw/timer/renesas_*.c
+F: hw/char/renesas_sci.c
+F: include/hw/timer/renesas_*.h
+F: include/hw/char/renesas_sci.h
+
 SH4 Machines
 ------------
 R2D
-- 
2.17.1


