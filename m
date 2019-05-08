Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39DFC004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8851820656
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBQ6sf3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8851820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAZ8-0008GF-RQ
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:36:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7O-0007sl-TF
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7K-0007d2-Vq
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:30 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA7J-0007UH-3a
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:26 -0400
Received: by mail-pg1-x543.google.com with SMTP id t22so9100993pgi.10
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=gOCf5dmjvw9Rsxt3RjAriLWO1woSIu9IhAP6/Qu/Lck=;
	b=dBQ6sf3GuEO+y+CoEWty8jGC9Fip0x/kp5X2OriM6UScBFFVG9iWPy0d0M9KxMqAQU
	TrGapVoIn6s94c0PKU6C7yIW7LLNadQzNKxvQ/zIfopkQLT0s7AGyiW11HIMtzbr6ooW
	6qbEBQMegbkdNEG1t2MJ++ASD1Fwf+xmq/cZRIcCM0YiJ6Z5W91CM2gKOL9d44EE00t0
	11nFTElmFMYYusEBuknakK/Ch40N0oGR+LC/AHDpJODNEsioabnwhB0VN61lHLgnY2Br
	6mWmmn9lpDc7yW2HfZlhIgJdpQVqMIp/vThEQSgDAVgAVUt7SjvWTAzIaiZN+lHqv8Kh
	CBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=gOCf5dmjvw9Rsxt3RjAriLWO1woSIu9IhAP6/Qu/Lck=;
	b=Tf1nIB+vRtCiDj08CiXB/H+WlmX9y0Kl2Z3a7Zqpbb+E5tF97ajFA6Kl4ZeMm24y7L
	h2D887MNrzh2ubG/VZlQGk7xX2IC55D5gIKwVKwk047UPa2dK1nhyaj66/GDALcpCJd5
	cFFqpunsnuquf1zFIesO7/ilRX6stwZXHxmuD8du6UZOc8y0vAo1dGOjjEkAkWEUMIbU
	IQK4dt/t7fsFmiScgtn5ekqJQAUFMnqVaK223c72zDbgA8UKjqKesgTEGDnnylfnUSNF
	iorqo/KwLtmr5yOWd9d220D+N6SoX9v2pCh7urVlaPoN19FItssHN7+h4fGbfINOAJx/
	nicA==
X-Gm-Message-State: APjAAAXkNjhZ8JWs/sxvLKNY8HwYJvMU30hIiP59/NFAEyeE6XB8VUmO
	3sHjQVw9MH2/1XkO58iSn1AZ6v0NzpM=
X-Google-Smtp-Source: APXvYqwMoWfUuurDJSKEgtmRG5kSoN4G2lv3GgEfLc70j6SVzwIjw9N3SOaG8hMYX6Ykf3e6rANNNQ==
X-Received: by 2002:a62:e101:: with SMTP id q1mr44914234pfh.160.1557274043075; 
	Tue, 07 May 2019 17:07:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.21 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:33 -0700
Message-Id: <20190508000641.19090-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v3 31/39] cpu: Move ENV_OFFSET to
 exec/gen-icount.h
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we have ArchCPU, we can define this generically,
in the one place that needs it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gen-icount.h | 2 ++
 target/alpha/cpu.h        | 1 -
 target/arm/cpu.h          | 2 --
 target/cris/cpu.h         | 1 -
 target/hppa/cpu.h         | 1 -
 target/i386/cpu.h         | 1 -
 target/lm32/cpu.h         | 1 -
 target/m68k/cpu.h         | 1 -
 target/microblaze/cpu.h   | 1 -
 target/mips/cpu.h         | 1 -
 target/moxie/cpu.h        | 1 -
 target/nios2/cpu.h        | 1 -
 target/openrisc/cpu.h     | 1 -
 target/ppc/cpu.h          | 1 -
 target/riscv/cpu.h        | 2 --
 target/s390x/cpu.h        | 1 -
 target/sh4/cpu.h          | 1 -
 target/sparc/cpu.h        | 1 -
 target/tilegx/cpu.h       | 1 -
 target/tricore/cpu.h      | 1 -
 target/unicore32/cpu.h    | 1 -
 target/xtensa/cpu.h       | 2 --
 22 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 24f7991781..9cfa6ccce5 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -5,6 +5,8 @@
 
 /* Helpers for instruction counting code generation.  */
 
+#define ENV_OFFSET   offsetof(ArchCPU, env)
+
 static TCGOp *icount_start_insn;
 
 static inline void gen_tb_start(TranslationBlock *tb)
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 53c085f691..66782cf5d4 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -273,7 +273,6 @@ struct AlphaCPU {
     QEMUTimer *alarm_timer;
 };
 
-#define ENV_OFFSET offsetof(AlphaCPU, env)
 
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_alpha_cpu;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c54c67fde4..23beb1de9a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -915,8 +915,6 @@ void arm_cpu_post_init(Object *obj);
 
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
 
-#define ENV_OFFSET offsetof(ARMCPU, env)
-
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_arm_cpu;
 #endif
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 7f244ad545..c19fdcec1e 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -183,7 +183,6 @@ struct CRISCPU {
     CPUCRISState env;
 };
 
-#define ENV_OFFSET offsetof(CRISCPU, env)
 
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_cris_cpu;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index a5ddc53bf1..58b2bf2933 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -222,7 +222,6 @@ struct HPPACPU {
     QEMUTimer *alarm_timer;
 };
 
-#define ENV_OFFSET      offsetof(HPPACPU, env)
 
 typedef CPUHPPAState CPUArchState;
 typedef HPPACPU ArchCPU;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e7f94437b1..a9cfb42b22 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1479,7 +1479,6 @@ struct X86CPU {
     int32_t hv_max_vps;
 };
 
-#define ENV_OFFSET offsetof(X86CPU, env)
 
 #ifndef CONFIG_USER_ONLY
 extern struct VMStateDescription vmstate_x86_cpu;
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 8e7b70a275..4234a439a3 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -195,7 +195,6 @@ struct LM32CPU {
     uint32_t features;
 };
 
-#define ENV_OFFSET offsetof(LM32CPU, env)
 
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_lm32_cpu;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index f8d5a0819b..02fbff3625 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -163,7 +163,6 @@ struct M68kCPU {
     CPUM68KState env;
 };
 
-#define ENV_OFFSET offsetof(M68kCPU, env)
 
 void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 7b85beb556..1becb9270b 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -310,7 +310,6 @@ struct MicroBlazeCPU {
     CPUMBState env;
 };
 
-#define ENV_OFFSET offsetof(MicroBlazeCPU, env)
 
 void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index e0645eb1d1..52286fcb0e 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1051,7 +1051,6 @@ struct MIPSCPU {
     CPUMIPSState env;
 };
 
-#define ENV_OFFSET offsetof(MIPSCPU, env)
 
 void mips_cpu_list(void);
 
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index a481a92833..ebe1c66f52 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -90,7 +90,6 @@ typedef struct MoxieCPU {
     CPUMoxieState env;
 } MoxieCPU;
 
-#define ENV_OFFSET offsetof(MoxieCPU, env)
 
 void moxie_cpu_do_interrupt(CPUState *cs);
 void moxie_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index f2ffc1469f..96c8193179 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -193,7 +193,6 @@ typedef struct Nios2CPU {
     uint32_t fast_tlb_miss_addr;
 } Nios2CPU;
 
-#define ENV_OFFSET offsetof(Nios2CPU, env)
 
 void nios2_tcg_init(void);
 void nios2_cpu_do_interrupt(CPUState *cs);
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 91ba667139..150227d450 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -317,7 +317,6 @@ typedef struct OpenRISCCPU {
 
 } OpenRISCCPU;
 
-#define ENV_OFFSET offsetof(OpenRISCCPU, env)
 
 void cpu_openrisc_list(void);
 void openrisc_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ef00a3415d..f970853556 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1203,7 +1203,6 @@ struct PowerPCCPU {
     int32_t mig_slb_nr;
 };
 
-#define ENV_OFFSET offsetof(PowerPCCPU, env)
 
 PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c32428a4ef..818692dde5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -229,8 +229,6 @@ extern const char * const riscv_fpr_regnames[];
 extern const char * const riscv_excp_names[];
 extern const char * const riscv_intr_names[];
 
-#define ENV_OFFSET offsetof(RISCVCPU, env)
-
 void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index eefed6f509..971dc0ccbd 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -163,7 +163,6 @@ struct S390CPU {
     uint32_t irqstate_saved_size;
 };
 
-#define ENV_OFFSET offsetof(S390CPU, env)
 
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_s390_cpu;
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 2ed942ca47..3f2f4043e0 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -207,7 +207,6 @@ struct SuperHCPU {
     CPUSH4State env;
 };
 
-#define ENV_OFFSET offsetof(SuperHCPU, env)
 
 void superh_cpu_do_interrupt(CPUState *cpu);
 bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 1442232cef..b170dd592e 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -532,7 +532,6 @@ struct SPARCCPU {
     CPUSPARCState env;
 };
 
-#define ENV_OFFSET offsetof(SPARCCPU, env)
 
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_sparc_cpu;
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 7f8fe7c513..643b7dbd17 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -138,7 +138,6 @@ typedef struct TileGXCPU {
     CPUTLGState env;
 } TileGXCPU;
 
-#define ENV_OFFSET offsetof(TileGXCPU, env)
 
 /* TILE-Gx memory attributes */
 #define MMU_USER_IDX    0  /* Current memory operation is in user mode */
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index fc3328fdf5..581e68e37c 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -208,7 +208,6 @@ struct TriCoreCPU {
     CPUTriCoreState env;
 };
 
-#define ENV_OFFSET offsetof(TriCoreCPU, env)
 
 hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void tricore_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 2dd1b34765..abb36b5d48 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -76,7 +76,6 @@ struct UniCore32CPU {
     CPUUniCore32State env;
 };
 
-#define ENV_OFFSET offsetof(UniCore32CPU, env)
 
 void uc32_cpu_do_interrupt(CPUState *cpu);
 bool uc32_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 86c88eae40..748b6fca25 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -529,8 +529,6 @@ struct XtensaCPU {
     CPUXtensaState env;
 };
 
-#define ENV_OFFSET offsetof(XtensaCPU, env)
-
 
 int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int size,
                                 int mmu_idx);
-- 
2.17.1


