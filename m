Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE94C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC59206B5
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xX+hvrEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC59206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLbP-0003wf-5E
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVw-0003ot-B7
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:12 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:52208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVu-0002Nm-1a
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:12 -0400
Received: by mail-pj1-x1033.google.com with SMTP id a9so3823757pjg.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9hyROkW6SX1plBSlOICmkYSQa2gXJt88PJFbrx2To6c=;
 b=xX+hvrEusEbNpFd2g9v6K4TM2W/O7oIPh4Sl+3eLSWN1emyzGGrupejLIfNk2TFCI4
 j+tjtDAME1TrRfL4ZXd3Al+Bdl1ocgbSx3fJf8lTBvzYasKvA7QsCh1Ao3egaViDmXK9
 fzQeQ7MVgMKio78T/YlMNrmWB18bQuMRtv2+nCTRgksILPwMG//uWUKjCfmZqdSxRvZu
 I0AXigL9wiUJRMi78UuyM/s9xrsdPZNEV2Z3ms/Q1cfMim8BTa+ifYDiUzHG7zWp2Y1K
 x9s48Yc4Ax6yGAdcmfgJpArqY0VWuFkGcvZXFjUjpsQVlWW4p/8HPS6oRUA+j3i4N1F4
 LMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9hyROkW6SX1plBSlOICmkYSQa2gXJt88PJFbrx2To6c=;
 b=SsYK8t5AdHUi/dGTuncFCSXU8/o3br6oKHmP0Wn+ex8VJC/KUKegRy8GFg+VQqMtGK
 Hx7it/eLPV20SJ9bRP3K0CpcLVSmWYeiSoA+JS/KBfnairlNjfdeb+4f5lMmd8O9C324
 DfTtiH2Ho3i/pPT7f3ndfZ21du5NV+5/xI3Y2KkfnwzwvWgjd12q+5Fjr0p0+FmeoFqw
 oZvRxjjt1LBvCjcogBBwdfQk8TLYLbE9/H+N8wsMsLfh4cuVWDlCmTcYSP1vn2y0Fcll
 PTNUmnMefhVdOwT14j6qBo+Ek+hM4FO9zqfCWEfHfxcOxhiTWGwPnemNJcs2IECt8FS+
 lTAA==
X-Gm-Message-State: AOAM532PLF9T9SRc0NE2dJViY9bj5hSD2PjgnFYYwy/WpdP9HP+WcHGa
 eN5oI+jVah7nZljktY/O18LQya61mPGp/Q==
X-Google-Smtp-Source: ABdhPJy0AUPofZuyp3q6eUMS5xYBnE828MdLO7EciQn3CwJWYtcyxDW7ZnA2DSXfnnIeXgDf+755iA==
X-Received: by 2002:a17:90b:368e:: with SMTP id
 mj14mr401066pjb.220.1599501906285; 
 Mon, 07 Sep 2020 11:05:06 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v6sm11367768pfi.38.2020.09.07.11.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 11:05:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/19] target/microblaze: Move pvr regs to MicroBlazeCPUConfig
Date: Mon,  7 Sep 2020 11:04:54 -0700
Message-Id: <20200907180459.29025-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907180459.29025-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
 <20200907180459.29025-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These values are constant, and are derived from the other
configuration knobs.  Move them into MicroBlazeCPUConfig
to emphasize that they are not variable.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h             |  5 +-
 hw/microblaze/petalogix_ml605_mmu.c |  6 +-
 target/microblaze/cpu.c             | 92 ++++++++++++++---------------
 target/microblaze/gdbstub.c         |  4 +-
 target/microblaze/helper.c          |  2 +-
 target/microblaze/op_helper.c       |  2 +-
 target/microblaze/translate.c       |  3 +-
 7 files changed, 54 insertions(+), 60 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 4d53345f23..ef96f2fe02 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -285,10 +285,6 @@ struct CPUMBState {
     struct {} end_reset_fields;
 
     /* These fields are preserved on reset.  */
-
-    struct {
-        uint32_t regs[13];
-    } pvr;
 };
 
 /*
@@ -301,6 +297,7 @@ typedef struct {
 
     uint32_t base_vectors;
     uint32_t pvr_user2;
+    uint32_t pvr_regs[13];
 
     uint8_t addr_size;
     uint8_t use_fpu;
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index e49fc86eb8..159db6cbe2 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -200,9 +200,9 @@ petalogix_ml605_init(MachineState *machine)
     }
 
     /* setup PVR to match kernel settings */
-    cpu->env.pvr.regs[4] = 0xc56b8000;
-    cpu->env.pvr.regs[5] = 0xc56be000;
-    cpu->env.pvr.regs[10] = 0x0e000000; /* virtex 6 */
+    cpu->cfg.pvr_regs[4] = 0xc56b8000;
+    cpu->cfg.pvr_regs[5] = 0xc56be000;
+    cpu->cfg.pvr_regs[10] = 0x0e000000; /* virtex 6 */
 
     microblaze_load_kernel(cpu, MEMORY_BASEADDR, ram_size,
                            machine->initrd_filename,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 6392524135..b9bb7f0cc7 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -153,7 +153,6 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUState *cs = CPU(dev);
     MicroBlazeCPUClass *mcc = MICROBLAZE_CPU_GET_CLASS(dev);
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    CPUMBState *env = &cpu->env;
     uint8_t version_code = 0;
     const char *version;
     int i = 0;
@@ -173,16 +172,6 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
 
-    env->pvr.regs[0] = PVR0_USE_EXC_MASK
-                       | PVR0_USE_ICACHE_MASK
-                       | PVR0_USE_DCACHE_MASK;
-    env->pvr.regs[2] = PVR2_D_OPB_MASK
-                        | PVR2_D_LMB_MASK
-                        | PVR2_I_OPB_MASK
-                        | PVR2_I_LMB_MASK
-                        | PVR2_FPU_EXC_MASK
-                        | 0;
-
     version = cpu->cfg.version ? cpu->cfg.version : DEFAULT_CPU_VERSION;
     for (i = 0; mb_cpu_lookup[i].name && version; i++) {
         if (strcmp(mb_cpu_lookup[i].name, version) == 0) {
@@ -195,46 +184,53 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
         qemu_log("Invalid MicroBlaze version number: %s\n", cpu->cfg.version);
     }
 
-    env->pvr.regs[0] |= (cpu->cfg.stackprot ? PVR0_SPROT_MASK : 0) |
-                        (cpu->cfg.use_fpu ? PVR0_USE_FPU_MASK : 0) |
-                        (cpu->cfg.use_hw_mul ? PVR0_USE_HW_MUL_MASK : 0) |
-                        (cpu->cfg.use_barrel ? PVR0_USE_BARREL_MASK : 0) |
-                        (cpu->cfg.use_div ? PVR0_USE_DIV_MASK : 0) |
-                        (cpu->cfg.use_mmu ? PVR0_USE_MMU_MASK : 0) |
-                        (cpu->cfg.endi ? PVR0_ENDI_MASK : 0) |
-                        (version_code << PVR0_VERSION_SHIFT) |
-                        (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0) |
-                        cpu->cfg.pvr_user1;
+    cpu->cfg.pvr_regs[0] =
+        (PVR0_USE_EXC_MASK |
+         PVR0_USE_ICACHE_MASK |
+         PVR0_USE_DCACHE_MASK |
+         (cpu->cfg.stackprot ? PVR0_SPROT_MASK : 0) |
+         (cpu->cfg.use_fpu ? PVR0_USE_FPU_MASK : 0) |
+         (cpu->cfg.use_hw_mul ? PVR0_USE_HW_MUL_MASK : 0) |
+         (cpu->cfg.use_barrel ? PVR0_USE_BARREL_MASK : 0) |
+         (cpu->cfg.use_div ? PVR0_USE_DIV_MASK : 0) |
+         (cpu->cfg.use_mmu ? PVR0_USE_MMU_MASK : 0) |
+         (cpu->cfg.endi ? PVR0_ENDI_MASK : 0) |
+         (version_code << PVR0_VERSION_SHIFT) |
+         (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0) |
+         cpu->cfg.pvr_user1);
 
-    env->pvr.regs[1] = cpu->cfg.pvr_user2;
-    env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
-                        (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0) |
-                        (cpu->cfg.use_hw_mul ? PVR2_USE_HW_MUL_MASK : 0) |
-                        (cpu->cfg.use_hw_mul > 1 ? PVR2_USE_MUL64_MASK : 0) |
-                        (cpu->cfg.use_barrel ? PVR2_USE_BARREL_MASK : 0) |
-                        (cpu->cfg.use_div ? PVR2_USE_DIV_MASK : 0) |
-                        (cpu->cfg.use_msr_instr ? PVR2_USE_MSR_INSTR : 0) |
-                        (cpu->cfg.use_pcmp_instr ? PVR2_USE_PCMP_INSTR : 0) |
-                        (cpu->cfg.dopb_bus_exception ?
-                                                 PVR2_DOPB_BUS_EXC_MASK : 0) |
-                        (cpu->cfg.iopb_bus_exception ?
-                                                 PVR2_IOPB_BUS_EXC_MASK : 0) |
-                        (cpu->cfg.div_zero_exception ?
-                                                 PVR2_DIV_ZERO_EXC_MASK : 0) |
-                        (cpu->cfg.illegal_opcode_exception ?
-                                                PVR2_ILL_OPCODE_EXC_MASK : 0) |
-                        (cpu->cfg.unaligned_exceptions ?
-                                                PVR2_UNALIGNED_EXC_MASK : 0) |
-                        (cpu->cfg.opcode_0_illegal ?
-                                                 PVR2_OPCODE_0x0_ILL_MASK : 0);
+    cpu->cfg.pvr_regs[1] = cpu->cfg.pvr_user2;
 
-    env->pvr.regs[5] |= cpu->cfg.dcache_writeback ?
-                                        PVR5_DCACHE_WRITEBACK_MASK : 0;
+    cpu->cfg.pvr_regs[2] =
+        (PVR2_D_OPB_MASK |
+         PVR2_D_LMB_MASK |
+         PVR2_I_OPB_MASK |
+         PVR2_I_LMB_MASK |
+         PVR2_FPU_EXC_MASK |
+         (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
+         (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0) |
+         (cpu->cfg.use_hw_mul ? PVR2_USE_HW_MUL_MASK : 0) |
+         (cpu->cfg.use_hw_mul > 1 ? PVR2_USE_MUL64_MASK : 0) |
+         (cpu->cfg.use_barrel ? PVR2_USE_BARREL_MASK : 0) |
+         (cpu->cfg.use_div ? PVR2_USE_DIV_MASK : 0) |
+         (cpu->cfg.use_msr_instr ? PVR2_USE_MSR_INSTR : 0) |
+         (cpu->cfg.use_pcmp_instr ? PVR2_USE_PCMP_INSTR : 0) |
+         (cpu->cfg.dopb_bus_exception ? PVR2_DOPB_BUS_EXC_MASK : 0) |
+         (cpu->cfg.iopb_bus_exception ? PVR2_IOPB_BUS_EXC_MASK : 0) |
+         (cpu->cfg.div_zero_exception ? PVR2_DIV_ZERO_EXC_MASK : 0) |
+         (cpu->cfg.illegal_opcode_exception ? PVR2_ILL_OPCODE_EXC_MASK : 0) |
+         (cpu->cfg.unaligned_exceptions ? PVR2_UNALIGNED_EXC_MASK : 0) |
+         (cpu->cfg.opcode_0_illegal ? PVR2_OPCODE_0x0_ILL_MASK : 0));
 
-    env->pvr.regs[10] = 0x0c000000 | /* Default to spartan 3a dsp family.  */
-                        (cpu->cfg.addr_size - 32) << PVR10_ASIZE_SHIFT;
-    env->pvr.regs[11] = (cpu->cfg.use_mmu ? PVR11_USE_MMU : 0) |
-                        16 << 17;
+    cpu->cfg.pvr_regs[5] |=
+        cpu->cfg.dcache_writeback ? PVR5_DCACHE_WRITEBACK_MASK : 0;
+
+    cpu->cfg.pvr_regs[10] =
+        (0x0c000000 | /* Default to spartan 3a dsp family.  */
+         (cpu->cfg.addr_size - 32) << PVR10_ASIZE_SHIFT);
+
+    cpu->cfg.pvr_regs[11] = ((cpu->cfg.use_mmu ? PVR11_USE_MMU : 0) |
+                             16 << 17);
 
     mcc->parent_realize(dev, errp);
 }
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 08d6a0e807..9e3b9ac824 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -78,7 +78,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         break;
     case GDB_PVR0 ... GDB_PVR11:
         /* PVR12 is intentionally skipped */
-        val = env->pvr.regs[n - GDB_PVR0];
+        val = cpu->cfg.pvr_regs[n - GDB_PVR0];
         break;
     case GDB_EDR:
         val = env->edr;
@@ -134,7 +134,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         break;
     case GDB_PVR0 ... GDB_PVR11:
         /* PVR12 is intentionally skipped */
-        env->pvr.regs[n - GDB_PVR0] = tmp;
+        cpu->cfg.pvr_regs[n - GDB_PVR0] = tmp;
         break;
     case GDB_EDR:
         env->edr = tmp;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 3c2fd388fb..c9f236c897 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -122,7 +122,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
 
     switch (cs->exception_index) {
     case EXCP_HW_EXCP:
-        if (!(env->pvr.regs[0] & PVR0_USE_EXC_MASK)) {
+        if (!(cpu->cfg.pvr_regs[0] & PVR0_USE_EXC_MASK)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "Exception raised on system without exceptions!\n");
             return;
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 4614e99db3..757f3ff04b 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -134,7 +134,7 @@ static void update_fpu_flags(CPUMBState *env, int flags, uintptr_t ra)
         raise = 1;
     }
     if (raise
-        && (env->pvr.regs[2] & PVR2_FPU_EXC_MASK)
+        && (env_archcpu(env)->cfg.pvr_regs[2] & PVR2_FPU_EXC_MASK)
         && (env->msr & MSR_EE)) {
         raise_fpu_exception(env, ra);
     }
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index ff0cb7dbb6..9e4551d99b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1539,7 +1539,8 @@ static bool trans_mfs(DisasContext *dc, arg_mfs *arg)
 
     case 0x2000 ... 0x200c:
         tcg_gen_ld_i32(dest, cpu_env,
-                       offsetof(CPUMBState, pvr.regs[arg->rs - 0x2000]));
+                       offsetof(MicroBlazeCPU, cfg.pvr_regs[arg->rs - 0x2000])
+                       - offsetof(MicroBlazeCPU, env));
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid mfs reg 0x%x\n", arg->rs);
-- 
2.25.1


