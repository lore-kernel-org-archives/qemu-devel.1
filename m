Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAE0C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D015B20872
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecqYYTIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D015B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35934 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwY9-0007xM-47
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:51:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTl-00044V-5y
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTi-0003YL-KM
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTg-0003LY-DF
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id x17so3323788wrl.9
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=B1+wWB3rNTZOHORyna/i52K8oN8xz+ryKjDaxSUmMDA=;
	b=ecqYYTIQnIUj7UQd/KwDb1Q7NNl45yDpRczzlOxXe96+kym6+CWpNHlhxAATXAGPPY
	HTH0fzH/D70LcofczuEjlPSP1ZtQTF7sp7z6zbLf08RqYUk2nIiefCHLIEcST0/HyoYk
	FJapHVzRAtJIrm/ZkpjwGTNjg+vK1uczHF9iyPZhfOMjbMuYQh1F/xoZ7gwzEwsY04sw
	Zoj6gI7NGUCcdmvQlQHPpCbofqNSFoQeq+rkxjUoxZIEZlD88yJlaihDRu2p5hOxhi+g
	m6FEDiMGvGivOMEJ4uIAEjcDy2d9HxVUND44WntuG7Q01kOqf0jqHb+/xx/n5FbfeRqD
	zWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=B1+wWB3rNTZOHORyna/i52K8oN8xz+ryKjDaxSUmMDA=;
	b=nv9VTp7O2D2O9CVoQ7jDDmDfF9IL9a6XPfMKmbBhAnyWU/raQWlE++WmPgUJ7ahnuO
	NynZpB2BJYtm37kHCJZZ1n5lzvdIQfuNe8id9P37iLPxrtlKpsqPVAOXf0JeeqCmvnxY
	//uy2ogNm/Udu8kdtoyVMeUxi6Hq2tvOgwpmh5Zd8ey25P2hjzTC0OveWBPGHPl5+qaL
	dLt2t0KvNvU1xGe0En39t+B3D91GFrTgxklCV2uQjkpaGWXMxBVp5V8DG4/ChGNHSeTp
	n74UYVziiKEOotkXkYT4oX+M/+Dk3HVEZGzcRha8jYnSkK2hSepyzrcyyP1QPURTWJxH
	/DAA==
X-Gm-Message-State: APjAAAVtp+q+afvxJyZxH8O8rQYQn/Xb9nuvtCfpfxqBGLclehQirql6
	Cf/1BbdA2a7cwTjKBotMg9SoyU6EWm8qAg==
X-Google-Smtp-Source: APXvYqy2gYAMbTYLUsZEGJLLRaf+4m38k0LChRzw6LG18+Dmk+uaH4ugGAe0lzN8ojtpxUlixigaEw==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr15936279wrw.73.1559843213416; 
	Thu, 06 Jun 2019 10:46:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:46:05 +0100
Message-Id: <20190606174609.20487-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 38/42] target/arm: Convert integer-to-float
 insns to decodetree
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

Convert the VCVT integer-to-float instructions to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 58 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 12 +------
 target/arm/vfp.decode          |  6 ++++
 3 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index c4bf1249ee7..e5b5c3cd6a5 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2360,3 +2360,61 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     tcg_temp_free_i64(vm);
     return true;
 }
+
+static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
+{
+    TCGv_i32 vm;
+    TCGv_ptr fpst;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vm = tcg_temp_new_i32();
+    neon_load_reg32(vm, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    if (a->s) {
+        /* i32 -> f32 */
+        gen_helper_vfp_sitos(vm, vm, fpst);
+    } else {
+        /* u32 -> f32 */
+        gen_helper_vfp_uitos(vm, vm, fpst);
+    }
+    neon_store_reg32(vm, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
+static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
+{
+    TCGv_i32 vm;
+    TCGv_i64 vd;
+    TCGv_ptr fpst;
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vm = tcg_temp_new_i32();
+    vd = tcg_temp_new_i64();
+    neon_load_reg32(vm, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    if (a->s) {
+        /* i32 -> f64 */
+        gen_helper_vfp_sitod(vd, vm, fpst);
+    } else {
+        /* u32 -> f64 */
+        gen_helper_vfp_uitod(vd, vm, fpst);
+    }
+    neon_store_reg64(vd, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_i64(vd);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2902bb7488e..b98f8f103ae 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3050,7 +3050,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 15:
+                case 0 ... 17:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3063,10 +3063,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             if (op == 15) {
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
-                case 0x10: /* vcvt.fxx.u32 */
-                case 0x11: /* vcvt.fxx.s32 */
-                    rm_is_dp = false;
-                    break;
                 case 0x18: /* vcvtr.u32.fxx */
                 case 0x19: /* vcvtz.u32.fxx */
                 case 0x1a: /* vcvtr.s32.fxx */
@@ -3181,12 +3177,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 16: /* fuito */
-                        gen_vfp_uito(dp, 0);
-                        break;
-                    case 17: /* fsito */
-                        gen_vfp_sito(dp, 0);
-                        break;
                     case 19: /* vjcvt */
                         gen_helper_vjcvt(cpu_F0s, cpu_F0d, cpu_env);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 56b8b4e6046..6da9a7913da 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -214,3 +214,9 @@ VCVT_sp      ---- 1110 1.11 0111 .... 1010 11.0 .... \
              vd=%vd_dp vm=%vm_sp
 VCVT_dp      ---- 1110 1.11 0111 .... 1011 11.0 .... \
              vd=%vd_sp vm=%vm_dp
+
+# VCVT from integer to floating point: Vm always single; Vd depends on size
+VCVT_int_sp  ---- 1110 1.11 1000 .... 1010 s:1 1.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VCVT_int_dp  ---- 1110 1.11 1000 .... 1011 s:1 1.0 .... \
+             vd=%vd_dp vm=%vm_sp
-- 
2.20.1


