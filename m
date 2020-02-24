Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05EFC38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA1A2176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DqnWzbNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA1A2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MCR-0004fy-IS
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7n-0004UJ-DB
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7m-0005u6-5l
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:51 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7m-0005tc-0M
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:50 -0500
Received: by mail-pg1-x544.google.com with SMTP id 70so5836646pgf.8
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/XrE+Up+cXUxsM0gL0c1JdFdbzGsxHOx44lIg6PgF9w=;
 b=DqnWzbNxh8Dfu17ddDQn6T1OQZu7vWr0VryhkU2LOZ3wVTZveXG9VwFPACvyX+kotp
 luzQ7dsUURqJH7TyJ2FN3f2GeTRWagyzbhLScn88M+tTqxsOWaK1MtYglgqD5fcuMBXL
 lBt+Hfd8auzVoPlx62lOZK7HHNhECi3LWw+Wy75KwWRpex/bbKjlr6fWsG4im72D+yB0
 Oi3hAUYfD/rG3jVK5glITd5G7LkywlFAiLTU8jPPyr6bGmRTVFEGUsyRkhlXzzyADx72
 WBguXTUcEQFICZfq7KdmKtEE3hi8ZmfcU4lQDvo50Io5/5mI4LD/Nemrt/kbN5JfR3KP
 zgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/XrE+Up+cXUxsM0gL0c1JdFdbzGsxHOx44lIg6PgF9w=;
 b=HXuWHqOZ81acdgnMavu5KOeRrlnoLq90b33O80OZvghhX57baKDBFX7kkbkwi/6ne0
 NKM8heEzrAXs66eCWNYp/eI6TJlmLyC6J4k+1rPj/86dEN/LO7QJZh7LSosNymWUdB7P
 I/yX3LgZiRLyiKF23M8Wrs+1VYkxRl0SLEhIGzYmKtaE541wmaD2zY09i+i4TKadzUrI
 PJcHaM13tUYAsbxaxTwWq++cBy5xXthOEaX3c7ZLuiPJd7CPB86aj9Sm30ibhmFnfnew
 cwwoyNwKA5wDDBved6JskxrPsOlCiWc2OvqicyoPD5XTDGVK/jsIm0gPrGOtXZP8JayJ
 OWlw==
X-Gm-Message-State: APjAAAUqTsewjQUPgFQ5UfRcPN5qgpiW/n2K8yJturKROL0fGCINzvLr
 dzrCDU5VWsgiQvy2+LU1L+7T0+nj3nE=
X-Google-Smtp-Source: APXvYqwzigogDb0xYGr+ha/qjHvEmu6xH57rE2Zt3rLm8aMavqCSobdy0kx2nj40FYvNsBKIopuEpQ==
X-Received: by 2002:a62:7b93:: with SMTP id
 w141mr55183624pfc.226.1582582968607; 
 Mon, 24 Feb 2020 14:22:48 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/17] target/arm: Move VLLDM and VLSTM to vfp.decode
Date: Mon, 24 Feb 2020 14:22:26 -0800
Message-Id: <20200224222232.13807-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we no longer have an early check for ARM_FEATURE_VFP,
we can use the proper ISA check in trans_VLLDM_VLSTM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix !secure (pmm)
---
 target/arm/vfp.decode          |  2 ++
 target/arm/translate-vfp.inc.c | 39 +++++++++++++++++++++++++
 target/arm/translate.c         | 53 ++++++----------------------------
 3 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index a67b3f29ee..592fe9e1e4 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -242,3 +242,5 @@ VCVT_sp_int  ---- 1110 1.11 110 s:1 .... 1010 rz:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_dp_int  ---- 1110 1.11 110 s:1 .... 1011 rz:1 1.0 .... \
              vd=%vd_sp vm=%vm_dp
+
+VLLDM_VLSTM  1110 1100 001 l:1 rn:4 0000 1010 0000 0000
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 03ba8d7aac..1964af3ea5 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2828,3 +2828,42 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+/*
+ * Decode VLLDM and VLSTM are nonstandard because:
+ *  * if there is no FPU then these insns must NOP in
+ *    Secure state and UNDEF in Nonsecure state
+ *  * if there is an FPU then these insns do not have
+ *    the usual behaviour that vfp_access_check() provides of
+ *    being controlled by CPACR/NSACR enable bits or the
+ *    lazy-stacking logic.
+ */
+static bool trans_VLLDM_VLSTM(DisasContext *s, arg_VLLDM_VLSTM *a)
+{
+    TCGv_i32 fptr;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_M) ||
+        !arm_dc_feature(s, ARM_FEATURE_V8)) {
+        return false;
+    }
+    /* If not secure, UNDEF. */
+    if (!s->v8m_secure) {
+        return false;
+    }
+    /* If no fpu, NOP. */
+    if (!dc_isar_feature(aa32_vfp, s)) {
+        return true;
+    }
+
+    fptr = load_reg(s, a->rn);
+    if (a->l) {
+        gen_helper_v7m_vlldm(cpu_env, fptr);
+    } else {
+        gen_helper_v7m_vlstm(cpu_env, fptr);
+    }
+    tcg_temp_free_i32(fptr);
+
+    /* End the TB, because we have updated FP control bits */
+    s->base.is_jmp = DISAS_UPDATE;
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 893911fca7..5b7cad1ea2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10962,53 +10962,18 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 goto illegal_op; /* op0 = 0b11 : unallocated */
             }
 
-            /*
-             * Decode VLLDM and VLSTM first: these are nonstandard because:
-             *  * if there is no FPU then these insns must NOP in
-             *    Secure state and UNDEF in Nonsecure state
-             *  * if there is an FPU then these insns do not have
-             *    the usual behaviour that disas_vfp_insn() provides of
-             *    being controlled by CPACR/NSACR enable bits or the
-             *    lazy-stacking logic.
-             */
-            if (arm_dc_feature(s, ARM_FEATURE_V8) &&
-                (insn & 0xffa00f00) == 0xec200a00) {
-                /* 0b1110_1100_0x1x_xxxx_xxxx_1010_xxxx_xxxx
-                 *  - VLLDM, VLSTM
-                 * We choose to UNDEF if the RAZ bits are non-zero.
-                 */
-                if (!s->v8m_secure || (insn & 0x0040f0ff)) {
+            if (disas_vfp_insn(s, insn)) {
+                if (((insn >> 8) & 0xe) == 10 &&
+                    dc_isar_feature(aa32_fpsp_v2, s)) {
+                    /* FP, and the CPU supports it */
                     goto illegal_op;
+                } else {
+                    /* All other insns: NOCP */
+                    gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
+                                       syn_uncategorized(),
+                                       default_exception_el(s));
                 }
-
-                if (arm_dc_feature(s, ARM_FEATURE_VFP)) {
-                    uint32_t rn = (insn >> 16) & 0xf;
-                    TCGv_i32 fptr = load_reg(s, rn);
-
-                    if (extract32(insn, 20, 1)) {
-                        gen_helper_v7m_vlldm(cpu_env, fptr);
-                    } else {
-                        gen_helper_v7m_vlstm(cpu_env, fptr);
-                    }
-                    tcg_temp_free_i32(fptr);
-
-                    /* End the TB, because we have updated FP control bits */
-                    s->base.is_jmp = DISAS_UPDATE;
-                }
-                break;
             }
-            if (arm_dc_feature(s, ARM_FEATURE_VFP) &&
-                ((insn >> 8) & 0xe) == 10) {
-                /* FP, and the CPU supports it */
-                if (disas_vfp_insn(s, insn)) {
-                    goto illegal_op;
-                }
-                break;
-            }
-
-            /* All other insns: NOCP */
-            gen_exception_insn(s, s->pc_curr, EXCP_NOCP, syn_uncategorized(),
-                               default_exception_el(s));
             break;
         }
         if ((insn & 0xfe000a00) == 0xfc000800
-- 
2.20.1


