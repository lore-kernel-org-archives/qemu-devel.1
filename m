Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59930C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:24:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F000720656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f68fl0XX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F000720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48899 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcUD-0000kj-4h
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:24:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc9Q-0006Ol-7E
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc9O-0007Kd-15
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:28 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc9M-0007IY-20
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:25 -0400
Received: by mail-pl1-x644.google.com with SMTP id y3so599650plp.0
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=gq+75Jwe6UgdK6wwUmwmOXLqxX22YU2TrXaZcI7Iv/Q=;
	b=f68fl0XX+e76VVChlVMestDJcA3wlhsI1hU5vgrmTEf6UuWB6MgqOTceeoYls828u9
	OEe1QRx8lBTKG2NnyA0maWCA4c6407ZWZHWQJiuahFbCjrzxrvMKBhcO5jlT2OBwlP4P
	3BNyq6R+NqLbD5EJVGnlm5kuTuRWg0iFZsnQgmmYVy4AIRmg642/GRUVpNKj8xfr5q3y
	d69wRkg7et7fwsKokxVT2PbEpz4ZOc7zSTjt+62Jm62yTHHKojA0hb/cq5TSshhr4Tm1
	fYndflQHQordOSGoQvgffAFnYqHni5tw72Ff0MCd49IqlF+YfBkNwJyxLOc2ObEEGpdo
	c61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=gq+75Jwe6UgdK6wwUmwmOXLqxX22YU2TrXaZcI7Iv/Q=;
	b=YKZXIalRQy25CteA076huEPOFon4nrNobwp/kwNJ+i1H2pwFhaxlpOIq7ervE8sVjQ
	pUQgIt6B9v/Yu9Wpn07dO3M1XDGCekN9WqYKcuf1/1qbeFXOoyiunfHxISjnuwKCGww1
	r4jTHTTZShd8l+bitDs2Cp9/ICCeXgpZ+ePBZ5NKqc772v0CHoQ/ezmhnQi3p9PBvUNt
	h+3AI2b6IlVwRC4VDrA08hKyWdu607erlwtHSI8XIOhBKuOvyexCsZSvANZdkixZTV5Q
	s0dyBq+cjL6GxCdFzb3mr/RPCj+VeK1fmMbtMNcw7uYS1GoPjty+8klxCGAK3iFR5HrL
	EoAA==
X-Gm-Message-State: APjAAAWKgZpjJct1ZbECheER6Yk7CQKIdR0pT1zmp49popVYJ80FqsV6
	vSocx+xevtU2TYKSDXzWDleir4LElvM=
X-Google-Smtp-Source: APXvYqyDpND9N6xROkxcMHpWhlkVQcAzAivA+AEl0sRKQo2XAHp8lGLSWIRIXr2nztqLUC+cctW1pQ==
X-Received: by 2002:a17:902:2b89:: with SMTP id
	l9mr2718957plb.331.1557381801369; 
	Wed, 08 May 2019 23:03:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.03.20
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:03:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:44 -0700
Message-Id: <20190509060246.4031-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v2 25/27] tcg: Use CPUClass::tlb_fill in
 cputlb.c
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

We can now use the CPUClass hook instead of a named function.

Create a static tlb_fill function to avoid other changes within
cputlb.c.  This also isolates the asserts within.  Remove the
named tlb_fill function from all of the targets.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h    |  9 ---------
 accel/tcg/cputlb.c         | 19 +++++++++++++++++++
 target/alpha/helper.c      |  6 ------
 target/arm/helper.c        |  8 --------
 target/cris/helper.c       |  6 ------
 target/hppa/mem_helper.c   |  6 ------
 target/i386/excp_helper.c  |  8 --------
 target/lm32/helper.c       |  6 ------
 target/m68k/helper.c       |  8 --------
 target/microblaze/helper.c |  6 ------
 target/mips/helper.c       |  6 ------
 target/moxie/helper.c      |  6 ------
 target/nios2/helper.c      |  6 ------
 target/openrisc/mmu.c      |  6 ------
 target/ppc/mmu_helper.c    |  6 ------
 target/riscv/cpu_helper.c  |  6 ------
 target/s390x/excp_helper.c |  6 ------
 target/sh4/helper.c        |  8 --------
 target/sparc/ldst_helper.c |  6 ------
 target/tricore/helper.c    |  6 ------
 target/unicore32/softmmu.c |  6 ------
 target/xtensa/helper.c     |  6 ------
 22 files changed, 19 insertions(+), 137 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 58e988b3b1..31f0ecc461 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -474,15 +474,6 @@ static inline void assert_no_pages_locked(void)
  */
 struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
                                              hwaddr index, MemTxAttrs attrs);
-
-/*
- * Note: tlb_fill() can trigger a resize of the TLB. This means that all of the
- * caller's prior references to the TLB table (e.g. CPUTLBEntry pointers) must
- * be discarded and looked up again (e.g. via tlb_entry()).
- */
-void tlb_fill(CPUState *cpu, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
-
 #endif
 
 #if defined(CONFIG_USER_ONLY)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f2f618217d..dfcd9ae168 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -855,6 +855,25 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
     return ram_addr;
 }
 
+/*
+ * Note: tlb_fill() can trigger a resize of the TLB. This means that all of the
+ * caller's prior references to the TLB table (e.g. CPUTLBEntry pointers) must
+ * be discarded and looked up again (e.g. via tlb_entry()).
+ */
+static void tlb_fill(CPUState *cpu, target_ulong addr, int size,
+                     MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    bool ok;
+
+    /*
+     * This is not a probe, so only valid return is success; failure
+     * should result in exception + longjmp to the cpu loop.
+     */
+    ok = cc->tlb_fill(cpu, addr, size, access_type, mmu_idx, false, retaddr);
+    assert(ok);
+}
+
 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                          int mmu_idx,
                          target_ulong addr, uintptr_t retaddr,
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 929a217455..5fe9c87912 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -275,12 +275,6 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
                  prot, mmu_idx, TARGET_PAGE_SIZE);
     return true;
 }
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    alpha_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
 #endif /* USER_ONLY */
 
 void alpha_cpu_do_interrupt(CPUState *cs)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f1a2b94ddb..e2d5c8e34f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13127,14 +13127,6 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    arm_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-#endif
-
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
     /* Implement DC ZVA, which zeroes a fixed-length block of memory.
diff --git a/target/cris/helper.c b/target/cris/helper.c
index 69464837c8..b5159b8357 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -123,12 +123,6 @@ bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit(cs);
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    cris_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 void crisv10_cpu_do_interrupt(CPUState *cs)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 5cee0c19b1..0fd3ac6645 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -260,12 +260,6 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     return true;
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType type, int mmu_idx, uintptr_t retaddr)
-{
-    hppa_cpu_tlb_fill(cs, addr, size, type, mmu_idx, false, retaddr);
-}
-
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
 void HELPER(itlba)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
 {
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index 68bf8e3f7c..fa1ead6404 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -700,11 +700,3 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     return true;
 #endif
 }
-
-#if !defined(CONFIG_USER_ONLY)
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    x86_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-#endif
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 1db9a5562e..20ea17ba23 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -44,12 +44,6 @@ bool lm32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     return true;
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    lm32_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 hwaddr lm32_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     LM32CPU *cpu = LM32_CPU(cs);
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 862f955f7b..9fc9e646ff 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -884,14 +884,6 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-#ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    m68k_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-#endif
-
 uint32_t HELPER(bitrev)(uint32_t x)
 {
     x = ((x >> 1) & 0x55555555u) | ((x << 1) & 0xaaaaaaaau);
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index a523c77959..ab2ceeb055 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -108,12 +108,6 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    mb_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 void mb_cpu_do_interrupt(CPUState *cs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 3a4917ce7b..9799f2ede1 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -944,12 +944,6 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 }
 
 #ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    mips_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address, int rw)
 {
     hwaddr physical;
diff --git a/target/moxie/helper.c b/target/moxie/helper.c
index 216cef057e..f5c1d4181c 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -26,12 +26,6 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    moxie_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 void helper_raise_exception(CPUMoxieState *env, int ex)
 {
     CPUState *cs = CPU(moxie_env_get_cpu(env));
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index 72884e4260..5bf715e6dd 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -315,10 +315,4 @@ bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     env->regs[CR_BADADDR] = address;
     cpu_loop_exit_restore(cs, retaddr);
 }
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    nios2_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 991f3fafe8..4e190514ca 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -178,10 +178,4 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         return phys_addr;
     }
 }
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    openrisc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, 0, retaddr);
-}
 #endif
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index afcca50530..e605efa883 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -3080,9 +3080,3 @@ bool ppc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     }
     return true;
 }
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    ppc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2535435260..41d6db41c3 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -378,12 +378,6 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     env->badaddr = addr;
     riscv_raise_exception(env, cs->exception_index, retaddr);
 }
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-        MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    riscv_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
 #endif
 
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index a4e134bcab..3a467b72c5 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -178,12 +178,6 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit(cs);
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    s390_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 static void do_program_interrupt(CPUS390XState *env)
 {
     uint64_t mask, addr;
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 1df1e02a14..074c74f337 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -872,11 +872,3 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
     cpu_loop_exit_restore(cs, retaddr);
 }
-
-#ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    superh_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-#endif
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2558c08a64..b4bf6faf41 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1924,10 +1924,4 @@ void QEMU_NORETURN sparc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 #endif
     cpu_raise_exception_ra(env, TT_UNALIGNED, retaddr);
 }
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    sparc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
 #endif
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index ed184fee3a..a680336850 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -85,12 +85,6 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    tricore_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 static void tricore_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index 13678df4d7..27f218abf0 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -275,12 +275,6 @@ bool uc32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    uc32_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
-}
-
 hwaddr uc32_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     error_report("function uc32_cpu_get_phys_page_debug not "
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 5c94f934dd..efb966b3bf 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -305,12 +305,6 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 }
 
-void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    xtensa_cpu_tlb_fill(cs, vaddr, size, access_type, mmu_idx, false, retaddr);
-}
-
 void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       unsigned size, MMUAccessType access_type,
                                       int mmu_idx, MemTxAttrs attrs,
-- 
2.17.1


