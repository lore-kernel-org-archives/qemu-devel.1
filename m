Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A9D21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUUnghut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A9D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33221 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTl5l-0006Zc-86
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:36:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkv4-0005YS-8B
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkv0-000185-9P
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkv0-0000xP-1o
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id q15so5201896wmj.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=CBMu5m7eSFgVxsne/XtTOzzcwofGf1J0u9oREYxWAFw=;
	b=tUUnghut34aXiftRyh3GqNtRNX+FS1aOhZG4Mo5g42SKs/CO4JYGGcgYJRoxkXIDLI
	MJKshVJX7GJn8XhJ3DJhZuiqLICyuQHgHFnSoX2kjRKScGgnLoxanecFRfRmrftmUMf4
	0AldmnfYeLmwrutxcwHPNSCkJkLe4QPq9cx8xdNDfsM8KxuzkEHg72LJVh6CGRU6EfbE
	GwDbxuIbb3I7tnmal1fdvPCjUn82dhtoV75dcAaw3IHFBE8mOr24FHK0KuyqImO5xcco
	uh9ZYCvDsknN3w1SzpPy9btYbt4LHd4x2qg+6NvZ1kdYOe5UIqvwRHpJs37rTQsUrBMz
	2NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CBMu5m7eSFgVxsne/XtTOzzcwofGf1J0u9oREYxWAFw=;
	b=QwZXUXpO6OGNjzhEZYGquxbgDnmCu64WvrIES6Ivd22qpsGULPeyYXnDtLLl+kWGf9
	EteQYPlcJ9nByJl7S/7bPWNE3OYCbYOVC06QHeNk2mZf6hKmfa89wPYdYzFX8UqkSXdi
	FXnIBK0N/Yym10ATLVTd2bw/ufWvD0PmZlSxwvaw3KRPMab1/5fPxt0Zu4UZXziW+lIW
	6n7QqyUAOiSz813/1hfUrXGPNUbJilSY5jjd5Yf2eHim+Us8wBnJBj+BBvtLkG+CaQ+Y
	jS7BoRyschaTZh79rmUVpgpdEFYAU5wIp2xbcMIgqY3772AMLtWL32Z4w2jfnq555HI8
	bMiQ==
X-Gm-Message-State: APjAAAU59net5/iJ5ZpkVEXI4whRXoU1QMYuwQKqOxAaDUWAj+uRrf3Y
	Ytg8qBK/nsRz/uBEglQaUqM6hw==
X-Google-Smtp-Source: APXvYqxdunaT1ZXFV+IxbwCCvnOFfs41efizffc64GJAFN3ykJH4ii6kKtHxGHLvkfiRB8ZbIIFdQQ==
X-Received: by 2002:a1c:688a:: with SMTP id d132mr2610625wmc.131.1558607140945;
	Thu, 23 May 2019 03:25:40 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b136sm9875486wmg.1.2019.05.23.03.25.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 4A35B1FF98;
	Thu, 23 May 2019 11:25:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:13 +0100
Message-Id: <20190523102532.10486-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 09/28] target/mips: only build mips-semi for
 softmmu
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-arm@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The is_uhi gates all semihosting calls and always returns false for
CONFIG_USER_ONLY builds. There is no reason to build and link
mips-semi for these builds so lets fix that.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/Makefile.objs | 3 ++-
 target/mips/helper.h      | 2 ++
 target/mips/translate.c   | 8 ++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
index 651f36f5176..3448ad5e193 100644
--- a/target/mips/Makefile.objs
+++ b/target/mips/Makefile.objs
@@ -1,4 +1,5 @@
 obj-y += translate.o dsp_helper.o op_helper.o lmi_helper.o helper.o cpu.o
-obj-y += gdbstub.o msa_helper.o mips-semi.o
+obj-y += gdbstub.o msa_helper.o
+obj-$(CONFIG_SOFTMMU) += mips-semi.o
 obj-$(CONFIG_SOFTMMU) += machine.o cp0_timer.o
 obj-$(CONFIG_KVM) += kvm.o
diff --git a/target/mips/helper.h b/target/mips/helper.h
index a6d687e3405..90ab03b76e3 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -2,7 +2,9 @@ DEF_HELPER_3(raise_exception_err, noreturn, env, i32, int)
 DEF_HELPER_2(raise_exception, noreturn, env, i32)
 DEF_HELPER_1(raise_exception_debug, noreturn, env)
 
+#ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(do_semihosting, void, env)
+#endif
 
 #ifdef TARGET_MIPS64
 DEF_HELPER_4(sdl, void, env, tl, tl, int)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3cd5b11b16b..fb905c88b57 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -13726,6 +13726,14 @@ static inline bool is_uhi(int sdbbp_code)
 #endif
 }
 
+#ifdef CONFIG_USER_ONLY
+/* The above should dead-code away any calls to this..*/
+static inline void gen_helper_do_semihosting(void *env)
+{
+    g_assert_not_reached();
+}
+#endif
+
 static int decode_mips16_opc (CPUMIPSState *env, DisasContext *ctx)
 {
     int rx, ry;
-- 
2.20.1


