Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFE9C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6790A20863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxiuXh9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6790A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37045 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToPX-0004UB-HQ
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:09:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToHc-0006IE-Rc
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToHb-0004YD-UF
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:24 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:39960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hToHb-0004Xz-Pf
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:23 -0400
Received: by mail-vs1-xe42.google.com with SMTP id c24so3638813vsp.7
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=W84fD2UDw9a9LmU00h2mTYcGOrNskf3otw0HP+RWaOg=;
	b=WxiuXh9CygRREcnOMOKzYlC6/bqNX7dtYcyM1XfFm+Kg6b2VKcHyci3YwJglXLywZm
	MdOMxRx6St4K4O84vOFhvgzjkNbWihngqXWSQi577AQuhi5I8QNr6ckLrCZOI+BAQcpC
	QanG1YGiy/GifZQ+sbA+Lgv/uAYuH2xPHjzp1yHUBjXjn4qjV3e2VtbZToGHtiyFRiTd
	HAjDfNuqMq0k+n8V1aGRiJ9kgyS2La0HN1gLN/ZOvLvmp7UNh9iXYoy9SY4d21YK+8By
	eGKaPuEfyZHBBOCN/gQhNzfXzCT64px2NVDhmbiM1x7BKHkynEsPIP298T7QLxxBl7L7
	0A4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=W84fD2UDw9a9LmU00h2mTYcGOrNskf3otw0HP+RWaOg=;
	b=YWG60uhYloH0VSx384XTRD8rUR7KnrxT9iYYoFqVtCz22KL8B8HxmBhuyO0nejQDXP
	rnHUuBPjg6BXggmJSaeH30loYQYBZPbns0DIxYUFEZRTObQxkXLfqVNelroKcb8Ee88y
	aLno3jass4cllsTwb6dHSYHp733dV4P4BgUgCQOhsRTtf2bK7gMptzCsKPg0lHV8ogeZ
	1mis8YsRicfITCgcvE2ncNXs6StJpkLAhIrwhlthW9WYw6Q7iHhPcR0u/Q2jQ6SU/on5
	4Ne5ZXK8U3RCNDAVqCjbADvgHeyaYRi24JD/Qmf+b5B8NmXkRi4EEHtUbD/KV75V17/O
	lQgA==
X-Gm-Message-State: APjAAAUV9wXTN2HT6yZuW3nQVSbP5pCvkI0wHzzYFfCEQ9M78fuV0Fkq
	+tT48HRgU4Y1IQY3AaQSqhxIukBPthqgog==
X-Google-Smtp-Source: APXvYqxlh6WnbqzM0zeW/4+JhZapnDdGHB4+ztuZA+FM0XY6eAvDIHX5cS2z+2Hs0uFlZ4AONykxGA==
X-Received: by 2002:a67:c885:: with SMTP id v5mr48602285vsk.49.1558620082847; 
	Thu, 23 May 2019 07:01:22 -0700 (PDT)
Received: from localhost.localdomain (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	v133sm1984166vkv.5.2019.05.23.07.01.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:01:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 10:00:59 -0400
Message-Id: <20190523140059.18548-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523140059.18548-1-richard.henderson@linaro.org>
References: <20190523140059.18548-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e42
Subject: [Qemu-devel] [PULL 13/13] MAINTAINERS: Add RX
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
Cc: peter.maydell@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>
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
index 73a0105082..5286970936 100644
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


