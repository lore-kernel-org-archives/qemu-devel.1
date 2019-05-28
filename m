Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E50C072B1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B18208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjtP3iwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B18208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60062 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYu8-0006Ob-BE
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 06:00:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYkA-0006IF-V9
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk6-00007z-TH
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYk6-00005p-5i
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id b18so19436332wrq.12
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=afO8c5gpnfvt0aBAYWof1X05QoKKDVER3olU0OZ3Ft4=;
	b=RjtP3iwasgcd5Zj+tL+Sq+/0Bj7lnX+8o2cRf0FrGkw+awiJ8U7REgfHqquOPA3Exr
	vibhzmDRffqt/Tk2+jM2i8l1wM+bHScxb4P/8a1N9VoeV13zqLYdRKAySXLDZOgb3Qs0
	TjabRAWiwb7RCgJgNDpvKtnMDXU2JSSyfqqBkBawtTXZjmJ1OuhzGRfDUkFSM+neeWKe
	3S057Es93aWlb1eyVe8FQ5qGjHgNMwE/mhS7aRUqbQ7+RrgCRu475+Q7jK/JO65rbVd9
	aeS/5+iq73Bf52/3Sp8aJWOY5pZlhfbx2SQ9HfqtibBe/l8+zbGTdQRkKsnRnhtnGNyv
	I4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=afO8c5gpnfvt0aBAYWof1X05QoKKDVER3olU0OZ3Ft4=;
	b=oUG7sFOg855lYF/75/gpgB5+8DkN7s5k3fuKfNWrXGLGOzd0vU01zjzKO9NFKONA4S
	AqgVkNw2hxgveiZ5PFXWd2Hq9KyXnUT+4RjeggHtOx7htwFKxo/rm/QnspAggRq8AKgP
	KeXsjKNij0KSRXDQ8vzuYoJvnLuCz4xSWKgPGO4QHYAXigDPEvtkvqWs8GALKzryj+hr
	6JfI/5Nji4A6qdROLl9AyGFSmEBk943WReM0xB8xZfgavKlENqwdPllDLqYbRlOhbyxj
	mP0pcXo9Ejz6XIxnjSpvR1XgBWdmamfbPCuEUIGmJ94ps2Hdx7LxkS7C+c5NJizyCZMm
	uiCg==
X-Gm-Message-State: APjAAAXvvg5EkR5OyjKvhDE0UGiESbGiKL1Hnf2njZaGoIOc5+F+cLkq
	r8dKByWxrq1hfDRgeyoa+gaQFw==
X-Google-Smtp-Source: APXvYqxU5D5JtEHKYtgsRxCs5DOzC2rB9jXceLJ0MfwPGG0O/VdmgZSy/S8xexgA8v9fBQJu5bRJ3A==
X-Received: by 2002:adf:f041:: with SMTP id t1mr4698093wro.74.1559037000879;
	Tue, 28 May 2019 02:50:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h200sm3522991wme.11.2019.05.28.02.49.55
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:49:56 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 44D881FF87;
	Tue, 28 May 2019 10:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:34 +0100
Message-Id: <20190528094953.14898-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 09/28] target/mips: only build mips-semi for
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
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

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


