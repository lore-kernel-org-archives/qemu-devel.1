Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AF7C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A6B206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJxBi3eM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A6B206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoUr-0002SM-Be
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFq-0007xG-1Z
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFo-0008Rs-Ip
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:33 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFo-0008QN-CJ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:32 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so6732694wru.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cRpUuyaFQptJ3Uv0Xu4cqCnT035R8uR0+h+PEux3tSk=;
 b=kJxBi3eMG3gAURjx3AjJmUujNTnMMt4dCXDsiRp++duY8R7uG9Qn2UCfiZb2Mj0xuD
 NtnyIa3BrChR3Dhqyw1HEE24fTUz+b25/hPrQ/K65x7T7qMZ3wGrCyLOn7Dh0OHyyGce
 Ko0FuMcJhrPzMIDtQkA/ljJwlJ73HONZUCiOy22L6MNJ1p21MYKUuH/mr5wv6InnoMK3
 yMXhefdNSbIQmZOy1cTQY1+dGeF1lmKbN5p2dXFtsliDwY1+KgwLqhorTuRN+00LFgxV
 4r9lDgQyDc+NkKzXkeZmEf6X3M1ifwtjR7KifMz2svRMAKTOOC2XU1O6dAaHnagR2PZi
 SdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cRpUuyaFQptJ3Uv0Xu4cqCnT035R8uR0+h+PEux3tSk=;
 b=L0IGP1i/WGmxc/SA3q8ntA7iHhJzVwVICXdWgXKX/zB4q+dS4cyWgB7yowFB5P5+Pn
 06+Vl/fFQekxHq3i83ekEgzg7R5rhDEYg51SWDAjOnr6YgRUqMuGxHVQPsWrCdntcWB5
 cuAuOmU61OGP2OPfzz7zVIy0OHof6qTvHkesLjvF+nFWOqGFC0rMFR/eFOX0nMAoQkdW
 2TUdB67jjPfFrQRttJqCDV4B0u1UcYNDSmR5LAbhXo+h+obEIZjE/G8iJyIHHYb8JGth
 ooLmzBK8JIZM8W8yHKTiKrM4W5us2/Q/pRL7n0t3Wh3B2sS6PCgKd/W4j8YtbrVIsPRy
 j8sA==
X-Gm-Message-State: APjAAAUCQinkB8h6xFErrdcU1IVMPKoLh3xOcahpEBgBpec4zO6f0qpX
 i9RasB4X6E89csXDKqUIgfgd3INGQqSfiw==
X-Google-Smtp-Source: APXvYqwgaOrD4ZKd9l6rDcJRFE1xstn2CPy4Ccswh2mw6Dj1DSf7RN07xEN+a03C6gdFVA0rTKHSAw==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr27869845wrp.12.1576494571236; 
 Mon, 16 Dec 2019 03:09:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/34] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
Date: Mon, 16 Dec 2019 11:08:52 +0000
Message-Id: <20191216110904.30815-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc Zyngier <maz@kernel.org>

HCR_EL2.TID3 requires that AArch32 reads of MVFR[012] are trapped to
EL2, and HCR_EL2.TID0 does the same for reads of FPSID.
In order to handle this, introduce a new TCG helper function that
checks for these control bits before executing the VMRC instruction.

Tested with a hacked-up version of KVM/arm64 that sets the control
bits for 32bit guests.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191201122018.25808-4-maz@kernel.org
[PMM: move helper declaration to helper.h; make it
 TCG_CALL_NO_WG]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |  2 ++
 target/arm/translate-vfp.inc.c | 20 ++++++++++++++++----
 target/arm/vfp_helper.c        | 29 +++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 3d4ec267a2c..7ce5169afb5 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -226,6 +226,8 @@ DEF_HELPER_FLAGS_2(rintd, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(vjcvt, TCG_CALL_NO_RWG, i32, f64, env)
 DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, ptr)
 
+DEF_HELPER_FLAGS_3(check_hcr_el2_trap, TCG_CALL_NO_WG, void, env, i32, i32)
+
 /* neon_helper.c */
 DEF_HELPER_FLAGS_3(neon_qadd_u8, TCG_CALL_NO_RWG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(neon_qadd_s8, TCG_CALL_NO_RWG, i32, env, i32, i32)
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 85c5ef897be..bf90ac0e5b7 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -761,13 +761,25 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
     if (a->l) {
         /* VMRS, move VFP special register to gp register */
         switch (a->reg) {
-        case ARM_VFP_FPSID:
-        case ARM_VFP_FPEXC:
-        case ARM_VFP_FPINST:
-        case ARM_VFP_FPINST2:
         case ARM_VFP_MVFR0:
         case ARM_VFP_MVFR1:
         case ARM_VFP_MVFR2:
+        case ARM_VFP_FPSID:
+            if (s->current_el == 1) {
+                TCGv_i32 tcg_reg, tcg_rt;
+
+                gen_set_condexec(s);
+                gen_set_pc_im(s, s->pc_curr);
+                tcg_reg = tcg_const_i32(a->reg);
+                tcg_rt = tcg_const_i32(a->rt);
+                gen_helper_check_hcr_el2_trap(cpu_env, tcg_rt, tcg_reg);
+                tcg_temp_free_i32(tcg_reg);
+                tcg_temp_free_i32(tcg_rt);
+            }
+            /* fall through */
+        case ARM_VFP_FPEXC:
+        case ARM_VFP_FPINST:
+        case ARM_VFP_FPINST2:
             tmp = load_cpu_field(vfp.xregs[a->reg]);
             break;
         case ARM_VFP_FPSCR:
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 9710ef1c3e5..0ae7d4f34a9 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1322,4 +1322,33 @@ float64 HELPER(frint64_d)(float64 f, void *fpst)
     return frint_d(f, fpst, 64);
 }
 
+void HELPER(check_hcr_el2_trap)(CPUARMState *env, uint32_t rt, uint32_t reg)
+{
+    uint32_t syndrome;
+
+    switch (reg) {
+    case ARM_VFP_MVFR0:
+    case ARM_VFP_MVFR1:
+    case ARM_VFP_MVFR2:
+        if (!(arm_hcr_el2_eff(env) & HCR_TID3)) {
+            return;
+        }
+        break;
+    case ARM_VFP_FPSID:
+        if (!(arm_hcr_el2_eff(env) & HCR_TID0)) {
+            return;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    syndrome = ((EC_FPIDTRAP << ARM_EL_EC_SHIFT)
+                | ARM_EL_IL
+                | (1 << 24) | (0xe << 20) | (7 << 14)
+                | (reg << 10) | (rt << 5) | 1);
+
+    raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
+}
+
 #endif
-- 
2.20.1


