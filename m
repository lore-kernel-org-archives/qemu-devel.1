Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC01C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39372083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kO6gxBgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39372083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36365 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwui-00074h-5t
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:15:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUD-0004de-Tb
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU8-0004Fb-Ei
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU8-0003MC-12
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id x17so3323824wrl.9
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=wS5685L1Ipovmuag8NGIyla+uLm909fdDbELT7NCVTo=;
	b=kO6gxBgDunxYaZYyfKx8QunKxrUrtFymb5DZKMA+mF68gHnV4hwKkXnfMBI59daABS
	TZBOaekNzRVCX0ycFJJDphkMuE97oQmykGnSOaK/GnTc3OrRfS9j5Nt+yXjYWmDQu3TS
	l/76AYhz8P6dSaX6x+7UMGvWRVnTRtQxn7Z9XYt/Zxg6vhKARprQ31CK0oJ2amhX6gxm
	+v+29d7HIOeoJdLtHR94VfqqhrlKWVFgAn3I/PULwq6CIRFNFjHIcvTehds++sNyYF2A
	vz0By02ix9QAfEru/QnA/fXf7juJheAcpK6knH7VaMc2QkCDLeGBzK5l4SMB6lYKbv+c
	RqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=wS5685L1Ipovmuag8NGIyla+uLm909fdDbELT7NCVTo=;
	b=Z4U0wC+avdIjgplEq+AogN1LDCF2lDdi4PkErekV7n2kU1AnDS4j4g1V7bwmihIUxQ
	ZHQCmSn5oGYgeEq4TMotdHhrOTP3a5Gk2AUb4qGh+CbN94JwajVXnbtmOJt+N/MauTR3
	HlegVPC+K8SUrUlrhHLmWkSVbLxinkvNkUDSPs4g06K6BTtAOF5qCa3tD0D2ju5QPTlC
	9lHXIgb/lZrAdXF0LI6/IPznwkVPZKrDdpp+Gq+GzJEeeSzbXOad1Ydre6Rp+vqKmQvI
	zs+LZ9M7szKITlXBjPZBWgzlEWHU0gele0GNLiU1IaxTti3UBQHdo8AkHfbt5fwNjLRL
	ye7g==
X-Gm-Message-State: APjAAAW96NWYGW7lWxeXctA1FgAbwqbyXzLyCCbO/4L/ByX7S9U/0xYF
	hCH+Gmih9YY60JZbKD+yt5sNOg==
X-Google-Smtp-Source: APXvYqxbfAWoYXCI3CL0fLime6srXUnBOiQ36w4KNtyJYj3arxTKIHbhw+VF5yAxsnPKGdtJ6OG7Mg==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr6457485wrl.27.1559843214449;
	Thu, 06 Jun 2019 10:46:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:46:06 +0100
Message-Id: <20190606174609.20487-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 39/42] target/arm: Convert VJCVT to decodetree
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VJCVT instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 24 ++++++++++++++++++++++++
 target/arm/translate.c         | 12 +-----------
 target/arm/vfp.decode          |  4 ++++
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index e5b5c3cd6a5..9bc852076a0 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2418,3 +2418,27 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
+{
+    TCGv_i32 vd;
+    TCGv_i64 vm;
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vm = tcg_temp_new_i64();
+    vd = tcg_temp_new_i32();
+    neon_load_reg64(vm, a->vm);
+    gen_helper_vjcvt(vd, vm, cpu_env);
+    neon_store_reg32(vd, a->vd);
+    tcg_temp_free_i64(vm);
+    tcg_temp_free_i32(vd);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b98f8f103ae..687ef093f97 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3050,7 +3050,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 17:
+                case 0 ... 19:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3085,13 +3085,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     rm_is_dp = false;
                     break;
 
-                case 0x13: /* vjcvt */
-                    if (!dp || !dc_isar_feature(aa32_jscvt, s)) {
-                        return 1;
-                    }
-                    rd_is_dp = false;
-                    break;
-
                 default:
                     return 1;
                 }
@@ -3177,9 +3170,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 19: /* vjcvt */
-                        gen_helper_vjcvt(cpu_F0s, cpu_F0d, cpu_env);
-                        break;
                     case 20: /* fshto */
                         gen_vfp_shto(dp, 16 - rm, 0);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 6da9a7913da..1a7c9b533de 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -220,3 +220,7 @@ VCVT_int_sp  ---- 1110 1.11 1000 .... 1010 s:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_int_dp  ---- 1110 1.11 1000 .... 1011 s:1 1.0 .... \
              vd=%vd_dp vm=%vm_sp
+
+# VJCVT is always dp to sp
+VJCVT        ---- 1110 1.11 1001 .... 1011 11.0 .... \
+             vd=%vd_sp vm=%vm_dp
-- 
2.20.1


