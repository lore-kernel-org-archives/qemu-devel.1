Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21217C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4526A2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFT1oXhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4526A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSkBu-0004N9-Q5
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSkAM-0002nV-BQ; Wed, 14 Oct 2020 13:02:18 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:46256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSkAJ-0000nl-Sk; Wed, 14 Oct 2020 13:02:17 -0400
Received: by mail-ej1-x630.google.com with SMTP id t25so5811369ejd.13;
 Wed, 14 Oct 2020 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rmf2wNciYj15JEGRCEUll9ouExHYp27PN7ORbSBvWk8=;
 b=nFT1oXhS3cJUMzmHd9BYDOkgjxFprrlThYwncRpnRX1a3RFqio7xUdpZ3b2Ri5Qs+b
 Wk0MeRAWJMpGHwdRl75aVZgQdV01RBWqw3Gavoxl20onYomE9V0MB5GOu/KQw3wT/YrK
 AqJXdJgMPLVDGLOSwq9JuqhoPISJJ8s/tJSgutsQxGoPJ+ZmN4yFSRqT7Gb8x0NsTmlQ
 9rXiexl/aQ96Fui/wQtH5YL9t0YUcf1rvhNZ1Ck7RYWx/EMag2uZHeg6MR4Jurtqmr/4
 o2oRVARieOL+QhF1NahESsH0bQjqGq+NRMb6avCgfxe2ZBKsDXeB7vx8QSsSoxVQ787b
 jssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rmf2wNciYj15JEGRCEUll9ouExHYp27PN7ORbSBvWk8=;
 b=TNNgflMqJzU5tcTzlgKKnDhi+heDkYAb5xyAVj7WjFIct+x+MGcZss3tdlYNLelQgc
 1MeIMvHDqJE3u1ztQDs1oH9+Co6kEJzg3YnTjiQSWcO57H+5gxR6QB1anidD4bQh2clv
 W34IZ6zFei4g1REsLE17Jagf+kzrr6C2zkpLWwhp5VkhEqIUjXk/gjV2yHuMpegkazuL
 ZzraOC+QkwEZ6cf3Hit7dC+Ty+sEpDGIirPbLovkvMO+tukd238D7SMT1K82xyEM472G
 zDz6V8TkbQRER5r3wyNv89rJMKjH24fnxdyPv3aNrhjy2/9r8NknYYUX4ONN96uxQJyK
 bIhQ==
X-Gm-Message-State: AOAM533iOkaD+mdaGN/+681OWrwIY9vbd1ki/5+j/CVJp2zM5ufdA/Bu
 B6yoTPR2/0s2x+1wUc5BLU8=
X-Google-Smtp-Source: ABdhPJyQjKqgkD9s3mMR6xlXdHaLdlMEUOIGU4l3cM4iUYinN6nQ5yo15Aug7HXzsNvFRUtmqg8XLw==
X-Received: by 2002:a17:906:dbf7:: with SMTP id
 yd23mr6146066ejb.281.1602694933801; 
 Wed, 14 Oct 2020 10:02:13 -0700 (PDT)
Received: from neptune.lab ([46.39.229.194])
 by smtp.googlemail.com with ESMTPSA id g3sm76012edy.12.2020.10.14.10.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 10:02:13 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH 2/5] [RISCV_PM] Support CSRs required for RISC-V PM extension
 except for ones in hypervisor mode
Date: Wed, 14 Oct 2020 20:01:56 +0300
Message-Id: <20201014170159.26932-3-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
References: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x630.google.com
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
Cc: baturo.alexey@gmail.com,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 space.monkey.delivers@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
---
 target/riscv/cpu.c      |   1 +
 target/riscv/cpu.h      |  11 ++
 target/riscv/cpu_bits.h |  66 +++++++++
 target/riscv/csr.c      | 302 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 380 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fe6bab4a52..d63031eb08 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -440,6 +440,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         }
         if (cpu->cfg.ext_j) {
             target_misa |= RVJ;
+            env->mmte |= PM_EXT_INITIAL;
         }
         if (cpu->cfg.ext_v) {
             target_misa |= RVV;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index eca611a367..21e47b8283 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -226,6 +226,17 @@ struct CPURISCVState {
 
     /* True if in debugger mode.  */
     bool debugger;
+
+    /* CSRs for PM
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
index aaef6c6f20..bbfbe71656 100644
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
@@ -1250,6 +1255,288 @@ static int write_pmpaddr(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+/* Functions to access Pointer Masking feature registers 
+ * We have to check if current priv lvl could modify
+ * csr in given mode
+ */
+static int check_pm_current_disabled(CPURISCVState *env, int csrno)
+{
+    /* m-mode is always allowed to modify registers, so allow */
+    if (env->priv == PRV_M) {
+        return 0;
+    }
+    int csr_priv = get_field(csrno, 0xC00);
+    /* If priv lvls differ that means we're accessing csr from higher priv lvl, so allow */
+    if (env->priv != csr_priv) {
+        return 0;
+    }
+    int cur_bit_pos = (env->priv == PRV_U) ? U_PM_CURRENT :
+                      (env->priv == PRV_S) ? S_PM_CURRENT : -1;
+    assert(cur_bit_pos != -1);
+    int pm_current = get_field(env->mmte, cur_bit_pos);
+    /* We're in same priv lvl, so we allow to modify csr only if pm_current==1 */
+    return !pm_current;
+}
+
+static int read_mmte(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        *val = 0;
+        return 0;
+    }
+#endif
+    *val = env->mmte & MMTE_MASK;
+    return 0;
+}
+
+static int write_mmte(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    target_ulong wpri_val = val & MMTE_MASK;
+    assert(val == wpri_val);
+    /* flush translation cache */
+    if (val != env->mmte) {
+        tb_flush(env_cpu(env));
+    }
+    env->mmte = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
+
+static int read_smte(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        *val = 0;
+        return 0;
+    }
+#endif
+    *val = env->mmte & SMTE_MASK;
+    return 0;
+}
+
+static int write_smte(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    target_ulong wpri_val = val & SMTE_MASK;
+    assert(val == wpri_val);
+    if (check_pm_current_disabled(env, csrno))
+        return 0;
+    target_ulong new_val = val | (env->mmte & ~SMTE_MASK);
+    write_mmte(env, csrno, new_val);
+    return 0;
+}
+
+static int read_umte(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        *val = 0;
+        return 0;
+    }
+#endif
+    *val = env->mmte & UMTE_MASK;
+    return 0;
+}
+
+static int write_umte(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    target_ulong wpri_val = val & UMTE_MASK;
+    assert(val == wpri_val);
+    if (check_pm_current_disabled(env, csrno))
+        return 0;
+    target_ulong new_val = val | (env->mmte & ~UMTE_MASK);
+    write_mmte(env, csrno, new_val);
+    return 0;
+}
+
+static int read_mpmmask(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    *val = env->mpmmask;
+    return 0;
+}
+
+static int write_mpmmask(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    if (val != env->mpmmask) {
+        tb_flush(env_cpu(env));
+    }
+    env->mpmmask = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
+
+static int read_spmmask(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    *val = env->spmmask;
+    return 0;
+}
+
+static int write_spmmask(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    if (check_pm_current_disabled(env, csrno))
+        return 0;
+    if (val != env->spmmask) {
+        tb_flush(env_cpu(env));
+    }
+    env->spmmask = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
+
+static int read_upmmask(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    *val = env->upmmask;
+    return 0;
+}
+
+static int write_upmmask(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    if (check_pm_current_disabled(env, csrno))
+        return 0;
+    if (val != env->upmmask) {
+        tb_flush(env_cpu(env));
+    }
+    env->upmmask = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
+
+static int read_mpmbase(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    *val = env->mpmbase;
+    return 0;
+}
+
+static int write_mpmbase(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    /* flush translation cache */
+    if (val != env->mpmbase) {
+        tb_flush(env_cpu(env));
+    }
+    env->mpmbase = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
+
+static int read_spmbase(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    *val = env->spmbase;
+    return 0;
+}
+
+static int write_spmbase(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    if (check_pm_current_disabled(env, csrno))
+        return 0;
+    /* flush translation cache */
+    if (val != env->spmbase) {
+        tb_flush(env_cpu(env));
+    }
+    env->spmbase = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
+
+static int read_upmbase(CPURISCVState *env, int csrno, target_ulong *val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    *val = env->upmbase;
+    return 0;
+}
+
+static int write_upmbase(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!riscv_has_ext(env, RVJ)) {
+        return -RISCV_EXCP_ILLEGAL_INST;
+    }
+#endif
+    if (check_pm_current_disabled(env, csrno))
+        return 0;
+    /* flush translation cache */
+    if (val != env->upmbase) {
+        tb_flush(env_cpu(env));
+    }
+    env->upmbase = val;
+    env->mstatus |= MSTATUS_XS | MSTATUS_SD;
+    env->mmte |= PM_EXT_DIRTY;
+    return 0;
+}
 #endif
 
 /*
@@ -1471,6 +1758,21 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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


