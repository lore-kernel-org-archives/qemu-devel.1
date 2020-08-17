Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED57DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B679E2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LQMLGCXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B679E2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7arF-0007DL-Su
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 04:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqN-0005OI-EW
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:15 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqL-0004hm-J2
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:15 -0400
Received: by mail-pf1-x442.google.com with SMTP id r11so7876833pfl.11
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YriqT7TDgb6ftCPxk+DRLCbxDfWBKS8pLCdkw60bWuA=;
 b=LQMLGCXWexSglImFSmxF8YY4ZTBFnKMu/dXVZxiDP0gC6qMFwy1rPzgyNcz+j/2Dbb
 wqsJY2Ve0lt1tzY9stu9+ZS+tqexcor+hDL4xTlGAJ4Ar7WDMzyQsxRCKjF5iwq22+nI
 TY+Ru3yDtIjN8Pk2t6eOzzLzFt9G5m/8QXo7SBfKRRk44iRiD7Ie6nBLWSjnmSMFCrP5
 rRQPcUdma1NwLbzo+UhNjC+xDSNJ3EdgKB6NtQjJbq2hBRkUKrl6J8e9VM4nl7wcT22h
 wIl574aicwS2BnC7NVfB8Gj+xVm9iqL6+38ABkqmDMIYfdCAIVFAytJUFC19iuCUArr1
 3diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YriqT7TDgb6ftCPxk+DRLCbxDfWBKS8pLCdkw60bWuA=;
 b=BLC/MHsIjZDehmKylQGbXxRqWNj7e6IL6PIP+MeY2xIiu4cJg63GkhSW3PC+Vi65Si
 /O/9kE4Sm7XIGYNVSZiZGVVtPa4jboms60OL5OmLLwCWNlF0WZeypB/a4IU+XDQiaCTF
 JQhFJM8kaikvUX+csKlo5DJquo3pkVQr9SW8lIfe8WAD1qxuA4GMLofP7v+oM1AZouaK
 3nKdYxYkD15I2xNXLDly9gRuqLLzV5Zwg0e2GYZm0setHvGib7GBNp8Wb6BsvLCp4jpD
 BiG83tuM0gjUkHO9dnVwciksniUvINlA1GnT6zjJJ9Ju5lPReNM9Ysdv6mMGUpGKya4d
 w9TQ==
X-Gm-Message-State: AOAM530y6YzrjL7q8yCxEO60miS9z1RWcj7irlZ5VqXeVGrcFaUyOFZq
 3fVRWUaOSuQqlGr3eklpp1Y8mQ1dzsT6ng==
X-Google-Smtp-Source: ABdhPJztZZpG03IB/JCcXsNb0NSJ/hOd1aNniK6ubrrg5kwsfOhuslMA6uWK8nHNmUiua3mUfc47oA==
X-Received: by 2002:a63:171e:: with SMTP id x30mr6905619pgl.153.1597654212000; 
 Mon, 17 Aug 2020 01:50:12 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:50:11 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 03/70] target/riscv: rvv-1.0: add mstatus VS field
Date: Mon, 17 Aug 2020 16:48:48 +0800
Message-Id: <20200817084955.28793-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h        |  6 ++++++
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 16 +++++++++++++++-
 target/riscv/csr.c        | 25 ++++++++++++++++++++++++-
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f9ef20fe89a..08d2c10a024 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -317,6 +317,7 @@ int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
+bool riscv_cpu_vector_enabled(CPURISCVState *env);
 bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
@@ -360,6 +361,7 @@ void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
 
 #define TB_FLAGS_MMU_MASK   3
 #define TB_FLAGS_MSTATUS_FS MSTATUS_FS
+#define TB_FLAGS_MSTATUS_VS MSTATUS_VS
 
 typedef CPURISCVState CPUArchState;
 typedef RISCVCPU ArchCPU;
@@ -410,11 +412,15 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 
 #ifdef CONFIG_USER_ONLY
     flags |= TB_FLAGS_MSTATUS_FS;
+    flags |= TB_FLAGS_MSTATUS_VS;
 #else
     flags |= cpu_mmu_index(env, 0);
     if (riscv_cpu_fp_enabled(env)) {
         flags |= env->mstatus & MSTATUS_FS;
     }
+    if (riscv_cpu_vector_enabled(env)) {
+        flags |= env->mstatus & MSTATUS_VS;
+    }
 #endif
     *pflags = flags;
 }
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 8117e8b5a7e..a8b31208833 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -367,6 +367,7 @@
 #define MSTATUS_SPIE        0x00000020
 #define MSTATUS_MPIE        0x00000080
 #define MSTATUS_SPP         0x00000100
+#define MSTATUS_VS          0x00000600
 #define MSTATUS_MPP         0x00001800
 #define MSTATUS_FS          0x00006000
 #define MSTATUS_XS          0x00018000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 75d2ae34349..3fae736529a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -108,10 +108,24 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
     return false;
 }
 
+/* Return true is vector support is currently enabled */
+bool riscv_cpu_vector_enabled(CPURISCVState *env)
+{
+    if (env->mstatus & MSTATUS_VS) {
+        if (riscv_cpu_virt_enabled(env) && !(env->mstatus_hs & MSTATUS_VS)) {
+            return false;
+        }
+        return true;
+    }
+
+    return false;
+}
+
 void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
 {
     target_ulong mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
-                                MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE;
+                                MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE |
+                                MSTATUS_VS;
     bool current_virt = riscv_cpu_virt_enabled(env);
 
     g_assert(riscv_has_ext(env, RVH));
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6a96a01b1cf..b0413f52d77 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -180,6 +180,7 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
+    env->mstatus |= MSTATUS_VS;
 #endif
     env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
     if (vs(env, csrno) >= 0) {
@@ -210,6 +211,13 @@ static int read_vxrm(CPURISCVState *env, int csrno, target_ulong *val)
 
 static int write_vxrm(CPURISCVState *env, int csrno, target_ulong val)
 {
+#if !defined(CONFIG_USER_ONLY)
+    if (!env->debugger && !riscv_cpu_vector_enabled(env)) {
+        return -1;
+    }
+    env->mstatus |= MSTATUS_VS;
+#endif
+
     env->vxrm = val;
     return 0;
 }
@@ -222,6 +230,13 @@ static int read_vxsat(CPURISCVState *env, int csrno, target_ulong *val)
 
 static int write_vxsat(CPURISCVState *env, int csrno, target_ulong val)
 {
+#if !defined(CONFIG_USER_ONLY)
+    if (!env->debugger && !riscv_cpu_vector_enabled(env)) {
+        return -1;
+    }
+    env->mstatus |= MSTATUS_VS;
+#endif
+
     env->vxsat = val;
     return 0;
 }
@@ -234,6 +249,13 @@ static int read_vstart(CPURISCVState *env, int csrno, target_ulong *val)
 
 static int write_vstart(CPURISCVState *env, int csrno, target_ulong val)
 {
+#if !defined(CONFIG_USER_ONLY)
+    if (!env->debugger && !riscv_cpu_vector_enabled(env)) {
+        return -1;
+    }
+    env->mstatus |= MSTATUS_VS;
+#endif
+
     env->vstart = val;
     return 0;
 }
@@ -400,7 +422,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
     mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
         MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
         MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
-        MSTATUS_TW;
+        MSTATUS_TW | MSTATUS_VS;
 #if defined(TARGET_RISCV64)
     /*
      * RV32: MPV and MTL are not in mstatus. The current plan is to
@@ -412,6 +434,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
     mstatus = (mstatus & ~mask) | (val & mask);
 
     dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
+            ((mstatus & MSTATUS_VS) == MSTATUS_VS) |
             ((mstatus & MSTATUS_XS) == MSTATUS_XS);
     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
     env->mstatus = mstatus;
-- 
2.17.1


