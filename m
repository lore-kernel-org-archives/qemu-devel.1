Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5A0C04AA6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973E62064A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnRP5CJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973E62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50471 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWLS-0003aP-RA
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:15:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW2I-00048Z-NP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzh-0000c7-T5
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzh-0000XL-Kx
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:37 -0400
Received: by mail-wm1-x343.google.com with SMTP id y5so4628095wma.2
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ggkcaTzzuYDH/ZORZV/VDUHUFe6Rd9N+H9lpwdVyMAg=;
	b=PnRP5CJPQirK1eiz/A/lQjSnl72phKg1YZ34xlaiUGLcVZ7Eu1KTcYklLsS0Jc/XUR
	AvJCfKef7aX0YU5v/jOzQ6AQG10eaHqcAchAoQS66b/ljsuZKF/O0DHHyCbpxPjzMp7u
	86/8gsTblHe5780Lnwt67cgZHbx9/jjCiIaiBQvu55O93koRL+ZtT3C0s9xpj/x9kOKm
	EgFneaoyJhqmEN72OMqFiCrZZwbGUZByxunFQBdv6wd7rT6WTOEl1X+XY1s6JbHJ2Clf
	BMb28o0SDSPRW2WPzz5pv6z6NB76rnMLvoEfy3rOp/YJ+kQ0vOTBMH+1dhAnaVvhVjva
	HhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ggkcaTzzuYDH/ZORZV/VDUHUFe6Rd9N+H9lpwdVyMAg=;
	b=JeeZmyy25j3vNgDxL1PX2efOEMK0zr5MRSCKgjvJ+T9uJJ6daMdHs5XP5BKvTd0oFF
	GzR0ElBY+KdTPqhNYke3qbwqxt1TPb8Ak9dDlU5S4Jj68rmMNVCx3RjHbfIY+3s1WibB
	1XCBhMIUU4IP/zDWN0Hd+h+wpxcKrdpQcpk4stdQNl5fK0wIUa39a0SmHtTK3Edrg07W
	14lFU92tuBaq1XQiUQ91bMRZDUVz3HTCDwc4Xbokwt4CP7jJ6nqFcXSNaDw3podclPZT
	z2dw/D74ROwRdbqgt6cXOfL7I/PofS+O7MsFTvMUjpmmPFIsq0XZh+wDQ9Du6SheDQbw
	VqaQ==
X-Gm-Message-State: APjAAAU7kmQX6P0MVbJ9mMa+pUPB1rGIQ1FKRv41BbtobzNurFAI0ok3
	1b+5Sjj+u8EgdDZwax9wMKCdJg==
X-Google-Smtp-Source: APXvYqyax06AvIqIALNOJE/SFwPoYeHnxYxtyqbsuBfctbSoO65WeYoqRO9WyVOxYHD3ov6N7FKSYA==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr3951584wmh.137.1556643156031; 
	Tue, 30 Apr 2019 09:52:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id z74sm3674409wmc.2.2019.04.30.09.52.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 09:52:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 981791FF8F;
	Tue, 30 Apr 2019 17:52:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 17:52:21 +0100
Message-Id: <20190430165234.32272-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v5 02/15] tests/tcg/multiarch: add hello world
 system test
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165221.rUFVYeS6qFBjL0uzH80ziN54kR2R4SoxtMYbUUZ5r04@z>

This is not really i386 only, we can have the same test for all
architectures supporting system tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/Makefile.softmmu-target       | 2 +-
 tests/tcg/{i386 => multiarch}/system/hello.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/{i386 => multiarch}/system/hello.c (100%)

diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index 53c9c5ece0..c31bbbf39a 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -27,7 +27,7 @@ CFLAGS+=-m32
 LINK_SCRIPT=$(I386_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
 # FIXME: move to common once x86_64 is bootstrapped
-TESTS+=$(X86_TESTS)
+TESTS+=$(X86_TESTS) $(MULTIARCH_TESTS)
 endif
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
diff --git a/tests/tcg/i386/system/hello.c b/tests/tcg/multiarch/system/hello.c
similarity index 100%
rename from tests/tcg/i386/system/hello.c
rename to tests/tcg/multiarch/system/hello.c
-- 
2.20.1


