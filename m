Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D1AC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A945A21707
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCMbALbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A945A21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVGx-0002Sx-Kh
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVFw-00012n-U9; Thu, 22 Oct 2020 03:43:29 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:33787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVFn-0007dD-H3; Thu, 22 Oct 2020 03:43:27 -0400
Received: by mail-lj1-x242.google.com with SMTP id c21so906243ljj.0;
 Thu, 22 Oct 2020 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NhA/Yx4IzGlO7kzPXnIit66vJX4zfC+2x0DyLT9E1sw=;
 b=cCMbALbBv3nbjdyPebvSOo/M3Kcy+76+B/culcERpzCOOnrmonm4VxrPHDff+bYJ7l
 iFONFB9AU/2veSE/eA513vfEJmIAsGjUM78JjkmOtVLeGXbm3mdWbndHVWnZr6+PxJQT
 XTSMuBd3Raz2tWdYZMUqGAEHOpAHCuu94PoaVxVSyImYA9hXKgdilT5NYENtRVSP2Xt6
 lvwMOhzCv9xofsY+XcorBsa6MF5WYoRpzx1lT1iUtqGFCFsf2ln/VCI3m60INKg2VHp1
 pCX1rSdkDA/tzh8PCtuAUhMlspY8rGGQ3SZmsdB33gpSsl779ttrooocQn+u7ToBf+Zq
 z6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NhA/Yx4IzGlO7kzPXnIit66vJX4zfC+2x0DyLT9E1sw=;
 b=VBPzZybjp4rmL5bSGZeSmNDmp2JtM7S3Y7N2gXClxyhj1/1HoIH5caaJso2TB6NMOI
 EOWD6iRbC7XaRdoqJNtzMVRNe6Zdx5Gel9KQyJnH0My6sBi4+eZ/GZQ+6BTVCuffjRGx
 swkCqV8zEifUFipe+Z+ofHL1PcXtqmdJ8QIpep37+o779KLulnwuGY1uF5ahUY8IfxdA
 qubxwyEDBEM8MOxccUGoYDqk/k8XKqzt2cIszlxbPl9kkTah829kEGuKV7YReMK/Uc1A
 mQP4ZWeG/ftJdwdFEEah4qZA3icHLqKwlIdWxFBIgQRUUqOlMIVSsss5ENcUU4DPVDm8
 jP+Q==
X-Gm-Message-State: AOAM533PW0jYjr6kUtCpBKWqlcZ6jUYM5UjJ2Zup9d313fht3P+0+dYf
 Y39oVgYf9abgwTB+mBgMyAk=
X-Google-Smtp-Source: ABdhPJwK+nt0hiLyRq9OpJTmPaVkl3e3KzG8+ovKqrV87WTpt40c2f9VAKfpWfSM/MO+a+Jf0nsuTg==
X-Received: by 2002:a2e:2c18:: with SMTP id s24mr540654ljs.264.1603352597303; 
 Thu, 22 Oct 2020 00:43:17 -0700 (PDT)
Received: from neptune.lab ([46.39.229.104])
 by smtp.googlemail.com with ESMTPSA id n19sm138887lfe.142.2020.10.22.00.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 00:43:16 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v5 2/6] [RISCV_PM] Support CSRs required for RISC-V PM
 extension except for ones in hypervisor mode
Date: Thu, 22 Oct 2020 10:43:05 +0300
Message-Id: <20201022074309.3210-3-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201022074309.3210-1-space.monkey.delivers@gmail.com>
References: <20201022074309.3210-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: baturo.alexey@gmail.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, space.monkey.delivers@gmail.com,
 Alistair.Francis@wdc.com, kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
---
 target/riscv/cpu.c      |   3 +
 target/riscv/cpu.h      |  12 ++
 target/riscv/cpu_bits.h |  66 ++++++++++
 target/riscv/csr.c      | 271 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 352 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4e305249b3..db72f5cf59 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -438,6 +438,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         if (cpu->cfg.ext_h) {
             target_misa |= RVH;
         }
+        if (cpu->cfg.ext_j) {
+            env->mmte |= PM_EXT_INITIAL;
+        }
         if (cpu->cfg.ext_v) {
             target_misa |= RVV;
             if (!is_power_of_2(cpu->cfg.vlen)) {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index eca611a367..c236f01fff 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -226,6 +226,18 @@ struct CPURISCVState {
 
     /* True if in debugger mode.  */
     bool debugger;
+
+    /*
+     * CSRs for PM
+     * TODO: move these csr to appropriate groups
+     */
+    target_ulong mmte;
+    target_ulong mpmmask;
+    target_ulong mpmbase;
+    target_ulong spmmask;
+    target_ulong spmbase;
+    target_ulong upmmask;
+    target_ulong upmbase;
 #endif
 
     float_status fp_status;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index bd36062877..84c93c77ae 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -354,6 +354,21 @@
 #define CSR_MHPMCOUNTER30H  0xb9e
 #define CSR_MHPMCOUNTER31H  0xb9f
 
+/* Custom user register */
+#define CSR_UMTE            0x8c0
+#define CSR_UPMMASK         0x8c1
+#define CSR_UPMBASE         0x8c2
+
+/* Custom machine register */
+#define CSR_MMTE            0x7c0
+#define CSR_MPMMASK         0x7c1
+#define CSR_MPMBASE         0x7c2
+
+/* Custom supervisor register */
+#define CSR_SMTE            0x9c0
+#define CSR_SPMMASK         0x9c1
+#define CSR_SPMBASE         0x9c2
+
 /* Legacy Machine Protection and Translation (priv v1.9.1) */
 #define CSR_MBASE           0x380
 #define CSR_MBOUND          0x381
@@ -604,4 +619,55 @@
 #define MIE_UTIE                           (1 << IRQ_U_TIMER)
 #define MIE_SSIE                           (1 << IRQ_S_SOFT)
 #define MIE_USIE                           (1 << IRQ_U_SOFT)
+
+/* general mte CSR bits*/
+#define PM_ENABLE       0x00000001ULL
+#define PM_CURRENT      0x00000002ULL
+#define PM_XS_MASK      0x00000003ULL
+
+/* PM XS bits values */
+#define PM_EXT_DISABLE  0x00000000ULL
+#define PM_EXT_INITIAL  0x00000001ULL
+#define PM_EXT_CLEAN    0x00000002ULL
+#define PM_EXT_DIRTY    0x00000003ULL
+
+/* offsets for every pair of control bits per each priv level */
+#define XS_OFFSET    0ULL
+#define U_OFFSET     2ULL
+#define S_OFFSET     4ULL
+#define M_OFFSET     6ULL
+
+#define PM_XS_BITS   (PM_XS_MASK << XS_OFFSET)
+#define U_PM_ENABLE  (PM_ENABLE  << U_OFFSET)
+#define U_PM_CURRENT (PM_CURRENT << U_OFFSET)
+#define S_PM_ENABLE  (PM_ENABLE  << S_OFFSET)
+#define S_PM_CURRENT (PM_CURRENT << S_OFFSET)
+#define M_PM_ENABLE  (PM_ENABLE  << M_OFFSET)
+
+/* mmte CSR bits */
+#define MMTE_PM_XS_BITS     PM_XS_BITS
+#define MMTE_U_PM_ENABLE    U_PM_ENABLE
+#define MMTE_U_PM_CURRENT   U_PM_CURRENT
+#define MMTE_S_PM_ENABLE    S_PM_ENABLE
+#define MMTE_S_PM_CURRENT   S_PM_CURRENT
+#define MMTE_M_PM_ENABLE    M_PM_ENABLE
+#define MMTE_MASK           (MMTE_U_PM_ENABLE | MMTE_U_PM_CURRENT | \
+                             MMTE_S_PM_ENABLE | MMTE_S_PM_CURRENT | \
+                             MMTE_M_PM_ENABLE | MMTE_PM_XS_BITS)
+
+/* smte CSR bits */
+#define SMTE_PM_XS_BITS     PM_XS_BITS
+#define SMTE_U_PM_ENABLE    U_PM_ENABLE
+#define SMTE_U_PM_CURRENT   U_PM_CURRENT
+#define SMTE_S_PM_ENABLE    S_PM_ENABLE
+#define SMTE_S_PM_CURRENT   S_PM_CURRENT
+#define SMTE_MASK           (SMTE_U_PM_ENABLE | SMTE_U_PM_CURRENT | \
+                             SMTE_S_PM_ENABLE | SMTE_S_PM_CURRENT | \
+                             SMTE_PM_XS_BITS)
+
+/* umte CSR bits */
+#define UMTE_U_PM_ENABLE    U_PM_ENABLE
+#define UMTE_U_PM_CURRENT   U_PM_CURRENT
+#define UMTE_MASK           (UMTE_U_PM_ENABLE | MMTE_U_PM_CURRENT)
+
 #endif
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index aaef6c6f20..e4839c8fc9 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -140,6 +140,11 @@ static int any(CPURISCVState *env, int csrno)
     return 0;
 }
 
+static int umode(CPURISCVState *env, int csrno)
+{
+    return -!riscv_has_ext(env, RVU);
+}
+
 static int smode(CPURISCVState *env, int csrno)
 {
     return -!riscv_has_ext(env, RVS);
@@ -1250,6 +1255,257 @@ static int write_pmpaddr(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+/*
+ * Functions to access Pointer Masking feature registers
+ * We have to check if current priv lvl could modify
+ * csr in given mode
+ */
+static int check_pm_current_disabled(CPURISCVState *env, int csrno)
+{
+    int csr_priv = get_field(csrno, 0xC00);
+    /*
+     * If priv lvls differ that means we're accessing csr from higher priv lvl,
+     * so allow the access
+     */
+    if (env->priv != csr_priv) {
+        return 0;
+    }
+    int cur_bit_pos;
+    switch (env->priv) {
+    case PRV_M:
+        /* m-mode is always allowed to modify registers, so allow */
+        return 0;
+    case PRV_S:
+        cur_bit_pos = S_PM_CURRENT;
+        break;
+    case PRV_U:
+        cur_bit_pos = U_PM_CURRENT;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    int pm_current = get_field(env->mmte, cur_bit_pos);
+    /* It's same priv lvl, so we allow to modify csr only if pm_current==1 */
+    return !pm_current;
+}
+
+static int read_mmte(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        *val = 0;
+        return 0;
+    }
+    *val = env->mmte & MMTE_MASK;
+    return 0;
+}
+
+static int write_mmte(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    target_ulong wpri_val = val & MMTE_MASK;
+    if (val != wpri_val) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "MMTE: WPRI violation written 0x%lx vs expected 0x%lx\n",
+                      val, wpri_val);
+    }
+    env->mmte = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
+
+static int read_smte(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        *val = 0;
+        return 0;
+    }
+    *val = env->mmte & SMTE_MASK;
+    return 0;
+}
+
+static int write_smte(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    target_ulong wpri_val = val & SMTE_MASK;
+    if (val != wpri_val) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SMTE: WPRI violation written 0x%lx vs expected 0x%lx\n",
+                      val, wpri_val);
+    }
+    if (check_pm_current_disabled(env, csrno)) {
+        return 0;
+    }
+    target_ulong new_val = val | (env->mmte & ~SMTE_MASK);
+    write_mmte(env, csrno, new_val);
+    return 0;
+}
+
+static int read_umte(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        *val = 0;
+        return 0;
+    }
+    *val = env->mmte & UMTE_MASK;
+    return 0;
+}
+
+static int write_umte(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    target_ulong wpri_val = val & UMTE_MASK;
+    assert(val == wpri_val);
+    if (val != wpri_val) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "UMTE: WPRI violation written 0x%lx vs expected 0x%lx\n",
+                      val, wpri_val);
+    }
+    if (check_pm_current_disabled(env, csrno)) {
+        return 0;
+    }
+    target_ulong new_val = val | (env->mmte & ~UMTE_MASK);
+    write_mmte(env, csrno, new_val);
+    return 0;
+}
+
+static int read_mpmmask(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    *val = env->mpmmask;
+    return 0;
+}
+
+static int write_mpmmask(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    env->mpmmask = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
+
+static int read_spmmask(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    *val = env->spmmask;
+    return 0;
+}
+
+static int write_spmmask(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    if (check_pm_current_disabled(env, csrno)) {
+        return 0;
+    }
+    env->spmmask = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
+
+static int read_upmmask(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    *val = env->upmmask;
+    return 0;
+}
+
+static int write_upmmask(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    if (check_pm_current_disabled(env, csrno)) {
+        return 0;
+    }
+    env->upmmask = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
+
+static int read_mpmbase(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    *val = env->mpmbase;
+    return 0;
+}
+
+static int write_mpmbase(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    env->mpmbase = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
+
+static int read_spmbase(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    *val = env->spmbase;
+    return 0;
+}
+
+static int write_spmbase(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    if (check_pm_current_disabled(env, csrno)) {
+        return 0;
+    }
+    env->spmbase = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
+
+static int read_upmbase(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    *val = env->upmbase;
+    return 0;
+}
+
+static int write_upmbase(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+    if (check_pm_current_disabled(env, csrno)) {
+        return 0;
+    }
+    env->upmbase = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
 #endif
 
 /*
@@ -1471,6 +1727,21 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_PMPCFG0  ... CSR_PMPCFG3]   = { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
 
+    /* User Pointer Masking */
+    [CSR_UMTE] =                { umode,  read_umte,        write_umte        },
+    [CSR_UPMMASK] =             { umode,  read_upmmask,     write_upmmask     },
+    [CSR_UPMBASE] =             { umode,  read_upmbase,     write_upmbase     },
+
+    /* Machine Pointer Masking */
+    [CSR_MMTE] =                { any,  read_mmte,        write_mmte        },
+    [CSR_MPMMASK] =             { any,  read_mpmmask,     write_mpmmask     },
+    [CSR_MPMBASE] =             { any,  read_mpmbase,     write_mpmbase     },
+
+    /* Supervisor Pointer Masking */
+    [CSR_SMTE] =                { smode, read_smte,        write_smte        },
+    [CSR_SPMMASK] =             { smode, read_spmmask,     write_spmmask     },
+    [CSR_SPMBASE] =             { smode, read_spmbase,     write_spmbase     },
+
     /* Performance Counters */
     [CSR_HPMCOUNTER3   ... CSR_HPMCOUNTER31] =    { ctr,  read_zero          },
     [CSR_MHPMCOUNTER3  ... CSR_MHPMCOUNTER31] =   { any,  read_zero          },
-- 
2.20.1


