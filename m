Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12223C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6B326767
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wyfsCRtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6B326767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWhwZ-00056k-3s
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:51:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhov-0007aj-SW
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhou-0000Yl-R0
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:45 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhou-0000Xj-M7
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:44 -0400
Received: by mail-oi1-x241.google.com with SMTP id q186so7762827oia.0
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=RUr+Pnf/kjdPPqMva493lcCBJEKvLGVDvC3VvjxcpY8=;
	b=wyfsCRtdVv89WjvfOiXwU0uVzMtVPRY128FZXre+lcw/6IXIUSZ6I4zC8MXmoFRRcC
	WGW7sPgQmrMtx0GSXAs+s3LJnMIqCz35f+JsZG92lV2GF/3wkrz/3SboUjUO643bYwsc
	w9O8+1iSHGyrUiKgIQMftx9xWc0KVz2/Yso9BdQrtImPatZz48SvFQt6GJasWvKI9yDN
	cyfLnWIGyhwXYguXeQM4cZjljwbaAqfurWjayZJStkjdUNaXeC5JjMENZOD6B50q9lge
	nCkVwISlRyd5kXqOAgzdR4s3tehoL922oT4yRoZXT0fc/dMLrXhJkV17QQXmMwUC3bgP
	K0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=RUr+Pnf/kjdPPqMva493lcCBJEKvLGVDvC3VvjxcpY8=;
	b=ZoQ/ypHSjBOdIv3e0LkfBcjgk4n3t3BMf5tjgpKEqouRNBuPcGZLdI8mUOyoazk2gF
	bX6iGA+x1Vd4JnF2dRKk7RSfIj0+ClIex4IZQwV2jEb8kNwETLtsAUQAZTL9gbxmDgqS
	tAUuj2ePBy7VVHcrUfD6jAXPF0Ey+F2A2w4TwkCiLK+Lf2LBQeBUqDZ/RF0joxcPGESW
	nPmP89lbMR0a7K7BwmnOerk7urAYUMXdJ8XlwfRvsjn2O4y8Qe+aNG8aCr7U3wSXeeaY
	DB/m4zk4pf0PteYPOEfCyQwMI/X3OlT2fIyYBufi0V4IUYeV0VIGEnxe2zyXn8plFazX
	58Bw==
X-Gm-Message-State: APjAAAV0ZYeIG08l+WBQGQKejqjTI0CvGZ6SzpBeSTPGOg8fOfzpjYtf
	dd9+bcn09sE3enIz/9h6OvJB5fbOFLvbQg==
X-Google-Smtp-Source: APXvYqyVKtEtIBEWSQoV0cOYkIucm7YlE8uJTcctILQAntBbpNjoLGq/QlrDMVBleL4iiE1ci1IOnQ==
X-Received: by 2002:aca:4202:: with SMTP id p2mr6411382oia.85.1559310223850;
	Fri, 31 May 2019 06:43:43 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:09 -0500
Message-Id: <20190531134315.4109-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: [Qemu-devel] [PATCH v16 17/23] MAINTAINERS: Add RX
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
index a96829ea83..b65ba2447e 100644
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
@@ -1108,6 +1115,18 @@ F: pc-bios/canyonlands.dt[sb]
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


