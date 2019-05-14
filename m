Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F660C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD862085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDpoQjdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD862085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50469 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZvy-00071F-GD
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:05:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjr-0004p4-Qz
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjq-0006Ll-IY
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQZjq-0006Iq-BT
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id o189so3432238wmb.1
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=U06wLwXAasasiurhZZxcEyeJ76fELq2p37jmN4PgTWk=;
	b=VDpoQjdjJpqv+U5DNs7MC4BPRsNXGv0ozijKDokDNKL0x3caANIo9R84k8QzHa0QCh
	6BmLy8z17jQKiHV5Hj7HYPHQAfqkrmgqiIqSIRUdg1+8B5QfmU1fq7b6OFyg5BvjnKHT
	VwJscLuuHnH5ZNUiGQ+v253h+gJFc7ukG0zmFxLSOQjYgIZyDzCJNPolJ+L60B/Vew4S
	UFmhECwyWsh/AcafCy6xEJ96z1df/tLcKc5G70iees5sNm2TnjWd/owiN1twiwQR3Aqv
	EZQ9ihWHt573Qqc/6IG/J0udH7GQERlCqO+6CLCP/SNQlC4V38LPnRIVD7j9hB+nmHHb
	7VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=U06wLwXAasasiurhZZxcEyeJ76fELq2p37jmN4PgTWk=;
	b=VQnD88UKEM9aR9vEiN8dVBRSf7JIBuJZ/2wJuKSNFi46VQVJYXX4g2C+zcVZR8UVBk
	GadYAq9dlkmElyR0iEhLpylr9hMD3A3PWE+zkAY5OGwaJtwfo2kZffOHL/wykqzrj1ek
	bfNMP5mh2duC8Xq/64dMujanmA0MUy9VQkJAlXuA+TdmGoLHu5868xTEqCsTvkdczXCY
	4QIgpkuYOFkVazegSbM3ysBswCnhko6DxrrT9WbB5oYwHjPO29LDhQ/H2Ua6P6UoIzL4
	RZ1xVTdCx33/qCa347iQTu4nzU4SAfr3ADENSpZerQ4V8254XSwL/pOD8OB1ullXiH+t
	qzxQ==
X-Gm-Message-State: APjAAAVXqga9qe5Wf7OrGHSldc7fRd7D/PHJg466VdH5vFh3gl2aUDbi
	Mtrbl7YcFvBHJxTgsTQfnOITsg==
X-Google-Smtp-Source: APXvYqzqxYSpNpfTBNkNShbjXnCSPYuJLHDDlfjNy1q7VkVFZpd9/L+MLb5paAyh5Atas8WPqwKVWQ==
X-Received: by 2002:a1c:2c89:: with SMTP id
	s131mr19508380wms.142.1557849189250; 
	Tue, 14 May 2019 08:53:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	y40sm19431367wrd.96.2019.05.14.08.53.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 08:53:05 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id CF5701FF99;
	Tue, 14 May 2019 16:53:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 16:52:59 +0100
Message-Id: <20190514155301.16123-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514155301.16123-1-alex.bennee@linaro.org>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [RFC PATCH 09/11] target/mips: only build mips-semi
 for softmmu
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The is_uhi gates all semihosting calls and always returns false for
CONFIG_USER_ONLY builds. There is no reason to build and link
mips-semi for these builds so lets fix that.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


