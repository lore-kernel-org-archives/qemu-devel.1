Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC919C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E5C2083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkQYzNXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E5C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36299 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwqa-0002pB-Tr
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:10:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUB-0004ad-LC
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU7-0004DC-OA
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU7-0003KM-D7
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id n9so3362841wru.0
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=fqQD45cISRBPqS8e6LTFUDKMsysfUAaIcXUmuocZRaE=;
	b=nkQYzNXNHDbWLrVXlPKFKH8LPdS9LPj+vnqLLyPUAAlocrmVHkUs+kd129b+gxnOE8
	BLfekcL4snvSKQVCkmzUKg0tYbnl6Cpyud01MJhGGJU8FuofNs1uTBgMuq/ROFmiJTdG
	WlYrkeDDOqaGQT374lN1X3AbCFsGOIetX29DbVAq2NypysWNp79jM0/Wn48kk8fJUj9Y
	Hmee2K90jE85soQnje5kP6RcLJWAQuzRQVI82PPzB7AqJytHt6UivCLmA5qh82TWQjEw
	Vxx0bYzW36jxRbYElZO4PnfhQvx/gdVoAcPBtVakfpYvibz2Df7zFE3CwgaCHOmoSIbV
	orng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=fqQD45cISRBPqS8e6LTFUDKMsysfUAaIcXUmuocZRaE=;
	b=gwsVA2aEePyouwqEIv5QyyjZTuRwUL0vzaGYo1C1oBWxaVGib9ROJOgm09cn0zFTUS
	EipNmdru1vk8g8LJs3y9+/AKIGdkayv4Jo00/d4YSlDETvGRq/rtWqxB5hW3f72p0O6I
	KyJobZfgf9HvWtp/ENQCU/rCIbGC9/oTizuQ+5B+qUeRFSTH+fsGd5NsLsgGu/01RJXL
	6oS+PdQNyqt2TMCNjPs4S/rRvqCw6LzT1VFyddsG6gb9fP2zLWtflPxiGc2CCp8M129g
	iRuRubTmgekjcQSzIeF4kJvUkFLBf/2KHFeAWN1wC18X7KrbrMe+af97S25cSUlcu/kR
	HQDg==
X-Gm-Message-State: APjAAAUf8H6/gNTvkFj8pimLX3z7ab0mKHASSZyy9ninLt3tbaRdcspz
	EpFBJwui+hkqEOuN41FRNWFWeQ==
X-Google-Smtp-Source: APXvYqylZxEi4Eu9XFYAYN1iyFEU1FOn+E00RTXKnqrw0zWDIW+K9r7gSCBPfx7nKZ+0aPC46dYsFA==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr7683795wrq.315.1559843212359; 
	Thu, 06 Jun 2019 10:46:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:46:04 +0100
Message-Id: <20190606174609.20487-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 37/42] target/arm: Convert double-single
 precision conversion insns to decodetree
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

Convert the VCVT double/single precision conversion insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 48 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 13 +--------
 target/arm/vfp.decode          |  6 +++++
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 5768be40c3e..c4bf1249ee7 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2312,3 +2312,51 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
     tcg_temp_free_i64(tmp);
     return true;
 }
+
+static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
+{
+    TCGv_i64 vd;
+    TCGv_i32 vm;
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
+    gen_helper_vfp_fcvtds(vd, vm, cpu_env);
+    neon_store_reg64(vd, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_i64(vd);
+    return true;
+}
+
+static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
+{
+    TCGv_i64 vm;
+    TCGv_i32 vd;
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
+    vd = tcg_temp_new_i32();
+    vm = tcg_temp_new_i64();
+    neon_load_reg64(vm, a->vm);
+    gen_helper_vfp_fcvtsd(vd, vm, cpu_env);
+    neon_store_reg32(vd, a->vd);
+    tcg_temp_free_i32(vd);
+    tcg_temp_free_i64(vm);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e7831bf8abb..2902bb7488e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3050,7 +3050,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 14:
+                case 0 ... 15:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3063,10 +3063,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             if (op == 15) {
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
-                case 0x0f: /* vcvt double<->single */
-                    rd_is_dp = !dp;
-                    break;
-
                 case 0x10: /* vcvt.fxx.u32 */
                 case 0x11: /* vcvt.fxx.s32 */
                     rm_is_dp = false;
@@ -3185,13 +3181,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 15: /* single<->double conversion */
-                        if (dp) {
-                            gen_helper_vfp_fcvtsd(cpu_F0s, cpu_F0d, cpu_env);
-                        } else {
-                            gen_helper_vfp_fcvtds(cpu_F0d, cpu_F0s, cpu_env);
-                        }
-                        break;
                     case 16: /* fuito */
                         gen_vfp_uito(dp, 0);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 9942d2ae7ad..56b8b4e6046 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -208,3 +208,9 @@ VRINTX_sp    ---- 1110 1.11 0111 .... 1010 01.0 .... \
              vd=%vd_sp vm=%vm_sp
 VRINTX_dp    ---- 1110 1.11 0111 .... 1011 01.0 .... \
              vd=%vd_dp vm=%vm_dp
+
+# VCVT between single and double: Vm precision depends on size; Vd is its reverse
+VCVT_sp      ---- 1110 1.11 0111 .... 1010 11.0 .... \
+             vd=%vd_dp vm=%vm_sp
+VCVT_dp      ---- 1110 1.11 0111 .... 1011 11.0 .... \
+             vd=%vd_sp vm=%vm_dp
-- 
2.20.1


