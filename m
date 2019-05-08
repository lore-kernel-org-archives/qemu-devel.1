Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE12C04AAD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5316220675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYyeCTjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5316220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56530 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAHd-0007RT-Fi
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:18:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6x-0007L4-4t
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6r-0006CS-00
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:03 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA6q-000644-HC
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:56 -0400
Received: by mail-pf1-x444.google.com with SMTP id g3so9490149pfi.4
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=yfehAHAtTVANtBULkgQasM4N2AlWMDs9Z3Fkoq4VVfA=;
	b=BYyeCTjIfi0j4YSwvgGIUr3MTtdTwXmZQWoRZkQWUjvrmnZDA+vcNs/WEiFe+kvHgm
	9btrDpzUMtbDI2RnbIJME0lnHxb6G49pAesxfOZcrfuOtFOakde4txpkrW10DSTNq9yD
	xEN+2zE1BacXIALZkqb+U/3V6wqsu0WJzmDJlJ9gQQGZ1l+B3YN7mGaaftDfG6p7ccw8
	ppfP8g7w8zKktg4IGiE8o7I8tX8+3Ta8EJjohvrtYvFbuJAaHcxAGju5Y8H0ZuD8EvRQ
	AaJQE91LCp355Id0hgWskQND1H+b6Dd7CTIk9BLFpHKU33VNP8AdNOHpJ8iNL3Wam1Hj
	y+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=yfehAHAtTVANtBULkgQasM4N2AlWMDs9Z3Fkoq4VVfA=;
	b=KW1oS7TugFuHXPuHWAB4gfu9pCW00xLbzNHorH2oMcEYG9Ax6hIg3ZZUc6XbqHu74c
	7/DTGHxmxJPbtf/asXqa2Cz531nmlzoYY4yIJXoBqNRIW6MgKkZ2ZuRk6Rci1lzsJwc2
	wnZCgLC/H9tgi5O8LWq6ZRg3jXeqaqpVmVKCsIDgNR0FUY2xZj2bbBPncM4YtO9xYsTP
	lQvhtJVTWTy3T1dKGg2zBGWGYDPzaSsx8OGUEuL1ePEZ3lUZ/utXiHjMSn5AyzLZRVHQ
	sM5u7i2GnOk6+G+cwSTRwJG9diarq79NbNASbzAlVrrsuQWk542jMMaJC91WvHqhZxYf
	SlXg==
X-Gm-Message-State: APjAAAVTpZ0IfZInxDAHen8+FuOwjlCJtpfP0vpubPBkDgCvA9PD8Lob
	+V/zPaykoH6/FAhB7LN7zR9gk7/ZdBs=
X-Google-Smtp-Source: APXvYqwZh2wFcnJASmhBwXMY5jVHhAdn1bIR6+NHpWudN+VZ6IVg1f1vwdAYyUSHz6eq8//bb4O2sQ==
X-Received: by 2002:a62:5915:: with SMTP id n21mr43598885pfb.180.1557274011911;
	Tue, 07 May 2019 17:06:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.06.50 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:06:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:08 -0700
Message-Id: <20190508000641.19090-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 06/39] cpu: Replace ENV_GET_CPU with env_cpu
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

Now that we have both ArchCPU and CPUArchState, we can define
this generically instead of via macro in each target's cpu.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h               |  8 +--
 accel/tcg/softmmu_template.h              | 20 ++++----
 include/exec/cpu-all.h                    | 12 +++++
 include/exec/cpu_ldst_template.h          |  6 +--
 include/exec/cpu_ldst_useronly_template.h |  6 +--
 include/exec/softmmu-semi.h               | 16 +++---
 linux-user/cpu_loop-common.h              |  2 +-
 target/alpha/cpu.h                        |  2 -
 target/arm/cpu.h                          |  2 -
 target/cris/cpu.h                         |  2 -
 target/hppa/cpu.h                         |  1 -
 target/i386/cpu.h                         |  2 -
 target/lm32/cpu.h                         |  2 -
 target/m68k/cpu.h                         |  2 -
 target/microblaze/cpu.h                   |  2 -
 target/mips/cpu.h                         |  2 -
 target/moxie/cpu.h                        |  2 -
 target/nios2/cpu.h                        |  2 -
 target/openrisc/cpu.h                     |  2 -
 target/ppc/cpu.h                          |  2 -
 target/riscv/cpu.h                        |  1 -
 target/s390x/cpu.h                        |  2 -
 target/sh4/cpu.h                          |  2 -
 target/sparc/cpu.h                        |  2 -
 target/tilegx/cpu.h                       |  2 -
 target/tricore/cpu.h                      |  2 -
 target/unicore32/cpu.h                    |  2 -
 target/xtensa/cpu.h                       |  2 -
 accel/tcg/cputlb.c                        | 22 ++++-----
 accel/tcg/tcg-runtime.c                   |  4 +-
 accel/tcg/translate-all.c                 |  2 +-
 accel/tcg/user-exec.c                     |  2 +-
 bsd-user/syscall.c                        |  6 +--
 linux-user/arm/cpu_loop.c                 |  2 +-
 linux-user/cris/cpu_loop.c                |  2 +-
 linux-user/elfload.c                      |  6 +--
 linux-user/m68k/cpu_loop.c                |  2 +-
 linux-user/main.c                         |  2 +-
 linux-user/mips/cpu_loop.c                |  2 +-
 linux-user/nios2/cpu_loop.c               |  2 +-
 linux-user/riscv/cpu_loop.c               |  2 +-
 linux-user/signal.c                       |  8 +--
 linux-user/syscall.c                      | 18 +++----
 linux-user/uname.c                        |  2 +-
 target/arm/helper.c                       | 42 ++++++++--------
 target/hppa/op_helper.c                   |  2 +-
 target/i386/hax-all.c                     |  6 +--
 target/i386/hvf/x86_decode.c              | 22 ++++-----
 target/i386/hvf/x86_emu.c                 | 60 +++++++++++++----------
 target/i386/mem_helper.c                  |  4 +-
 target/m68k/op_helper.c                   |  2 +-
 target/nios2/mmu.c                        |  4 +-
 target/nios2/op_helper.c                  |  2 +-
 target/ppc/mmu_helper.c                   |  2 +-
 target/s390x/gdbstub.c                    | 24 ++++-----
 target/s390x/mem_helper.c                 |  2 +-
 target/sh4/op_helper.c                    |  2 +-
 docs/devel/tracing.txt                    |  4 +-
 scripts/tracetool/format/tcg_helper_c.py  |  2 +-
 59 files changed, 176 insertions(+), 198 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 685602b076..5aaf186253 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -62,21 +62,21 @@
 #define ATOMIC_TRACE_RMW do {                                           \
         uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                         \
-        trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info);      \
-        trace_guest_mem_before_exec(ENV_GET_CPU(env), addr,             \
+        trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
+        trace_guest_mem_before_exec(env_cpu(env), addr,             \
                                     info | TRACE_MEM_ST);               \
     } while (0)
 
 #define ATOMIC_TRACE_LD do {                                            \
         uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                         \
-        trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info);      \
+        trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
     } while (0)
 
 # define ATOMIC_TRACE_ST do {                                           \
         uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true); \
                                                                         \
-        trace_guest_mem_before_exec(ENV_GET_CPU(env), addr, info);      \
+        trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
     } while (0)
 
 /* Define host-endian atomic operations.  Note that END is used within
diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index fc6371aed1..efd4d4e743 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -120,14 +120,14 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
     DATA_TYPE res;
 
     if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
+        cpu_unaligned_access(env_cpu(env), addr, READ_ACCESS_TYPE,
                              mmu_idx, retaddr);
     }
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
         if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
+            tlb_fill(env_cpu(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
                      mmu_idx, retaddr);
             index = tlb_index(env, mmu_idx, addr);
             entry = tlb_entry(env, mmu_idx, addr);
@@ -191,14 +191,14 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
     DATA_TYPE res;
 
     if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
+        cpu_unaligned_access(env_cpu(env), addr, READ_ACCESS_TYPE,
                              mmu_idx, retaddr);
     }
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
         if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
+            tlb_fill(env_cpu(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
                      mmu_idx, retaddr);
             index = tlb_index(env, mmu_idx, addr);
             entry = tlb_entry(env, mmu_idx, addr);
@@ -289,14 +289,14 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
     uintptr_t haddr;
 
     if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
+        cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
                              mmu_idx, retaddr);
     }
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
+            tlb_fill(env_cpu(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
             index = tlb_index(env, mmu_idx, addr);
             entry = tlb_entry(env, mmu_idx, addr);
@@ -333,7 +333,7 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         entry2 = tlb_entry(env, mmu_idx, page2);
         if (!tlb_hit_page(tlb_addr_write(entry2), page2)
             && !VICTIM_TLB_HIT(addr_write, page2)) {
-            tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
+            tlb_fill(env_cpu(env), page2, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
 
@@ -369,14 +369,14 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
     uintptr_t haddr;
 
     if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
+        cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
                              mmu_idx, retaddr);
     }
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
+            tlb_fill(env_cpu(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
             index = tlb_index(env, mmu_idx, addr);
             entry = tlb_entry(env, mmu_idx, addr);
@@ -413,7 +413,7 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         entry2 = tlb_entry(env, mmu_idx, page2);
         if (!tlb_hit_page(tlb_addr_write(entry2), page2)
             && !VICTIM_TLB_HIT(addr_write, page2)) {
-            tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
+            tlb_fill(env_cpu(env), page2, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
 
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index da07ce311f..454f6d663f 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -371,4 +371,16 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
 
 int cpu_exec(CPUState *cpu);
 
+/**
+ * env_cpu(env)
+ * @env: The architecture environment
+ *
+ * Return the CPUState associated with the environment.
+ */
+static inline CPUState *env_cpu(CPUArchState *env)
+{
+    ArchCPU *arch_cpu = container_of(env, ArchCPU, env);
+    return &arch_cpu->parent_obj;
+}
+
 #endif /* CPU_ALL_H */
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 0f061d47ef..af7e0b49f2 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -89,7 +89,7 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 
 #if !defined(SOFTMMU_CODE_ACCESS)
     trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
+        env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, false, MO_TE, false));
 #endif
 
@@ -128,7 +128,7 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 
 #if !defined(SOFTMMU_CODE_ACCESS)
     trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
+        env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, true, MO_TE, false));
 #endif
 
@@ -170,7 +170,7 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 
 #if !defined(SOFTMMU_CODE_ACCESS)
     trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
+        env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, false, MO_TE, true));
 #endif
 
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 0fd6019af0..bc45e2b8d4 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -66,7 +66,7 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
 #if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
+        env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, false, MO_TE, false));
 #endif
     return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
@@ -90,7 +90,7 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
 #if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
+        env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, true, MO_TE, false));
 #endif
     return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
@@ -116,7 +116,7 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
 {
 #if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
-        ENV_GET_CPU(env), ptr,
+        env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, false, MO_TE, true));
 #endif
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
diff --git a/include/exec/softmmu-semi.h b/include/exec/softmmu-semi.h
index 7eefad8f39..970837992e 100644
--- a/include/exec/softmmu-semi.h
+++ b/include/exec/softmmu-semi.h
@@ -14,7 +14,7 @@ static inline uint64_t softmmu_tget64(CPUArchState *env, target_ulong addr)
 {
     uint64_t val;
 
-    cpu_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 8, 0);
+    cpu_memory_rw_debug(env_cpu(env), addr, (uint8_t *)&val, 8, 0);
     return tswap64(val);
 }
 
@@ -22,7 +22,7 @@ static inline uint32_t softmmu_tget32(CPUArchState *env, target_ulong addr)
 {
     uint32_t val;
 
-    cpu_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 4, 0);
+    cpu_memory_rw_debug(env_cpu(env), addr, (uint8_t *)&val, 4, 0);
     return tswap32(val);
 }
 
@@ -30,7 +30,7 @@ static inline uint32_t softmmu_tget8(CPUArchState *env, target_ulong addr)
 {
     uint8_t val;
 
-    cpu_memory_rw_debug(ENV_GET_CPU(env), addr, &val, 1, 0);
+    cpu_memory_rw_debug(env_cpu(env), addr, &val, 1, 0);
     return val;
 }
 
@@ -43,14 +43,14 @@ static inline void softmmu_tput64(CPUArchState *env,
                                   target_ulong addr, uint64_t val)
 {
     val = tswap64(val);
-    cpu_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 8, 1);
+    cpu_memory_rw_debug(env_cpu(env), addr, (uint8_t *)&val, 8, 1);
 }
 
 static inline void softmmu_tput32(CPUArchState *env,
                                   target_ulong addr, uint32_t val)
 {
     val = tswap32(val);
-    cpu_memory_rw_debug(ENV_GET_CPU(env), addr, (uint8_t *)&val, 4, 1);
+    cpu_memory_rw_debug(env_cpu(env), addr, (uint8_t *)&val, 4, 1);
 }
 #define put_user_u64(arg, p) ({ softmmu_tput64(env, p, arg) ; 0; })
 #define put_user_u32(arg, p) ({ softmmu_tput32(env, p, arg) ; 0; })
@@ -63,7 +63,7 @@ static void *softmmu_lock_user(CPUArchState *env,
     /* TODO: Make this something that isn't fixed size.  */
     p = malloc(len);
     if (p && copy) {
-        cpu_memory_rw_debug(ENV_GET_CPU(env), addr, p, len, 0);
+        cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0);
     }
     return p;
 }
@@ -79,7 +79,7 @@ static char *softmmu_lock_user_string(CPUArchState *env, target_ulong addr)
         return NULL;
     }
     do {
-        cpu_memory_rw_debug(ENV_GET_CPU(env), addr, &c, 1, 0);
+        cpu_memory_rw_debug(env_cpu(env), addr, &c, 1, 0);
         addr++;
         *(p++) = c;
     } while (c);
@@ -90,7 +90,7 @@ static void softmmu_unlock_user(CPUArchState *env, void *p, target_ulong addr,
                                 target_ulong len)
 {
     if (len) {
-        cpu_memory_rw_debug(ENV_GET_CPU(env), addr, p, len, 1);
+        cpu_memory_rw_debug(env_cpu(env), addr, p, len, 1);
     }
     free(p);
 }
diff --git a/linux-user/cpu_loop-common.h b/linux-user/cpu_loop-common.h
index c1d554a249..8828af28a4 100644
--- a/linux-user/cpu_loop-common.h
+++ b/linux-user/cpu_loop-common.h
@@ -24,7 +24,7 @@
 
 #define EXCP_DUMP(env, fmt, ...)                                        \
 do {                                                                    \
-    CPUState *cs = ENV_GET_CPU(env);                                    \
+    CPUState *cs = env_cpu(env);                                        \
     fprintf(stderr, fmt , ## __VA_ARGS__);                              \
     cpu_dump_state(cs, stderr, 0);                                      \
     if (qemu_log_separate()) {                                          \
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index ce470b9089..2c7f75f584 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -278,8 +278,6 @@ static inline AlphaCPU *alpha_env_get_cpu(CPUAlphaState *env)
     return container_of(env, AlphaCPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(alpha_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(AlphaCPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d943bb0fed..a633a233cc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -920,8 +920,6 @@ void arm_cpu_post_init(Object *obj);
 
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
 
-#define ENV_GET_CPU(e) CPU(arm_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(ARMCPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 9f1fbd2f81..883799b463 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -188,8 +188,6 @@ static inline CRISCPU *cris_env_get_cpu(CPUCRISState *env)
     return container_of(env, CRISCPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(cris_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(CRISCPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 9038fa3c13..887e10398a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -227,7 +227,6 @@ static inline HPPACPU *hppa_env_get_cpu(CPUHPPAState *env)
     return container_of(env, HPPACPU, env);
 }
 
-#define ENV_GET_CPU(e)  CPU(hppa_env_get_cpu(e))
 #define ENV_OFFSET      offsetof(HPPACPU, env)
 
 typedef CPUHPPAState CPUArchState;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6bd01ebb83..2546ffa4d4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1484,8 +1484,6 @@ static inline X86CPU *x86_env_get_cpu(CPUX86State *env)
     return container_of(env, X86CPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(x86_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(X86CPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 9132397066..c6b252f90a 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -200,8 +200,6 @@ static inline LM32CPU *lm32_env_get_cpu(CPULM32State *env)
     return container_of(env, LM32CPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(lm32_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(LM32CPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index ce0f93343b..43ef30b7cb 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -168,8 +168,6 @@ static inline M68kCPU *m68k_env_get_cpu(CPUM68KState *env)
     return container_of(env, M68kCPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(m68k_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(M68kCPU, env)
 
 void m68k_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 161d18546d..c5af1c6076 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -315,8 +315,6 @@ static inline MicroBlazeCPU *mb_env_get_cpu(CPUMBState *env)
     return container_of(env, MicroBlazeCPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(mb_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(MicroBlazeCPU, env)
 
 void mb_cpu_do_interrupt(CPUState *cs);
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3fdd075f8e..31e15834ca 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1056,8 +1056,6 @@ static inline MIPSCPU *mips_env_get_cpu(CPUMIPSState *env)
     return container_of(env, MIPSCPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(mips_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(MIPSCPU, env)
 
 void mips_cpu_list(void);
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 8691185162..5b9aae95d2 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -95,8 +95,6 @@ static inline MoxieCPU *moxie_env_get_cpu(CPUMoxieState *env)
     return container_of(env, MoxieCPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(moxie_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(MoxieCPU, env)
 
 void moxie_cpu_do_interrupt(CPUState *cs);
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index fce08e3575..b14095b8dc 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -198,8 +198,6 @@ static inline Nios2CPU *nios2_env_get_cpu(CPUNios2State *env)
     return NIOS2_CPU(container_of(env, Nios2CPU, env));
 }
 
-#define ENV_GET_CPU(e) CPU(nios2_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(Nios2CPU, env)
 
 void nios2_tcg_init(void);
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index a6abcc7d2c..0ba4ae3356 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -322,8 +322,6 @@ static inline OpenRISCCPU *openrisc_env_get_cpu(CPUOpenRISCState *env)
     return container_of(env, OpenRISCCPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(openrisc_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(OpenRISCCPU, env)
 
 void cpu_openrisc_list(void);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a2134fe83a..3449b0b085 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1208,8 +1208,6 @@ static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCState *env)
     return container_of(env, PowerPCCPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(ppc_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(PowerPCCPU, env)
 
 PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4cf4516cc3..cd4f2de798 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -234,7 +234,6 @@ extern const char * const riscv_fpr_regnames[];
 extern const char * const riscv_excp_names[];
 extern const char * const riscv_intr_names[];
 
-#define ENV_GET_CPU(e) CPU(riscv_env_get_cpu(e))
 #define ENV_OFFSET offsetof(RISCVCPU, env)
 
 void riscv_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 6d1b0f273a..9cdd831a77 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -168,8 +168,6 @@ static inline S390CPU *s390_env_get_cpu(CPUS390XState *env)
     return container_of(env, S390CPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(s390_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(S390CPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 8b175c58b4..c1a9e4f981 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -212,8 +212,6 @@ static inline SuperHCPU *sh_env_get_cpu(CPUSH4State *env)
     return container_of(env, SuperHCPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(sh_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(SuperHCPU, env)
 
 void superh_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 5a108b5532..5a10680d8f 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -537,8 +537,6 @@ static inline SPARCCPU *sparc_env_get_cpu(CPUSPARCState *env)
     return container_of(env, SPARCCPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(sparc_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(SPARCCPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 042a7a0c71..135df63523 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -143,8 +143,6 @@ static inline TileGXCPU *tilegx_env_get_cpu(CPUTLGState *env)
     return container_of(env, TileGXCPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(tilegx_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(TileGXCPU, env)
 
 /* TILE-Gx memory attributes */
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 56164e42b5..4c997b6d30 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -213,8 +213,6 @@ static inline TriCoreCPU *tricore_env_get_cpu(CPUTriCoreState *env)
     return TRICORE_CPU(container_of(env, TriCoreCPU, env));
 }
 
-#define ENV_GET_CPU(e) CPU(tricore_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(TriCoreCPU, env)
 
 hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 90aac6a38e..22e22345dc 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -81,8 +81,6 @@ static inline UniCore32CPU *uc32_env_get_cpu(CPUUniCore32State *env)
     return container_of(env, UniCore32CPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(uc32_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(UniCore32CPU, env)
 
 void uc32_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 56fc21c8bb..a20541b5d6 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -534,8 +534,6 @@ static inline XtensaCPU *xtensa_env_get_cpu(const CPUXtensaState *env)
     return container_of(env, XtensaCPU, env);
 }
 
-#define ENV_GET_CPU(e) CPU(xtensa_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(XtensaCPU, env)
 
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2225640fc1..1fed0eebdb 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -415,7 +415,7 @@ static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu_idx,
     CPUTLBDesc *d = &env_tlb(env)->d[mmu_idx];
     int k;
 
-    assert_cpu_is_self(ENV_GET_CPU(env));
+    assert_cpu_is_self(env_cpu(env));
     for (k = 0; k < CPU_VTLB_SIZE; k++) {
         if (tlb_flush_entry_locked(&d->vtable[k], page)) {
             tlb_n_used_entries_dec(env, mmu_idx);
@@ -865,7 +865,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                          target_ulong addr, uintptr_t retaddr,
                          bool recheck, MMUAccessType access_type, int size)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     hwaddr mr_offset;
     MemoryRegionSection *section;
     MemoryRegion *mr;
@@ -934,7 +934,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                       uint64_t val, target_ulong addr,
                       uintptr_t retaddr, bool recheck, int size)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     hwaddr mr_offset;
     MemoryRegionSection *section;
     MemoryRegion *mr;
@@ -1000,7 +1000,7 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
 {
     size_t vidx;
 
-    assert_cpu_is_self(ENV_GET_CPU(env));
+    assert_cpu_is_self(env_cpu(env));
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
         CPUTLBEntry *vtlb = &env_tlb(env)->d[mmu_idx].vtable[vidx];
         target_ulong cmp;
@@ -1050,7 +1050,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 
     if (unlikely(!tlb_hit(entry->addr_code, addr))) {
         if (!VICTIM_TLB_HIT(addr_code, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
+            tlb_fill(env_cpu(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
             index = tlb_index(env, mmu_idx, addr);
             entry = tlb_entry(env, mmu_idx, addr);
         }
@@ -1088,7 +1088,7 @@ void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
     if (!tlb_hit(tlb_addr_write(entry), addr)) {
         /* TLB entry is for a different page */
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
+            tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
                      mmu_idx, retaddr);
         }
     }
@@ -1115,7 +1115,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     /* Enforce guest required alignment.  */
     if (unlikely(a_bits > 0 && (addr & ((1 << a_bits) - 1)))) {
         /* ??? Maybe indicate atomic op to cpu_unaligned_access */
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
+        cpu_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
                              mmu_idx, retaddr);
     }
 
@@ -1131,7 +1131,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     /* Check TLB entry and enforce page permissions.  */
     if (!tlb_hit(tlb_addr, addr)) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, 1 << s_bits, MMU_DATA_STORE,
+            tlb_fill(env_cpu(env), addr, 1 << s_bits, MMU_DATA_STORE,
                      mmu_idx, retaddr);
             index = tlb_index(env, mmu_idx, addr);
             tlbe = tlb_entry(env, mmu_idx, addr);
@@ -1148,7 +1148,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 
     /* Let the guest notice RMW on a write-only page.  */
     if (unlikely(tlbe->addr_read != (tlb_addr & ~TLB_NOTDIRTY))) {
-        tlb_fill(ENV_GET_CPU(env), addr, 1 << s_bits, MMU_DATA_LOAD,
+        tlb_fill(env_cpu(env), addr, 1 << s_bits, MMU_DATA_LOAD,
                  mmu_idx, retaddr);
         /* Since we don't support reads and writes to different addresses,
            and we do have the proper page loaded for write, this shouldn't
@@ -1161,7 +1161,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     ndi->active = false;
     if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
         ndi->active = true;
-        memory_notdirty_write_prepare(ndi, ENV_GET_CPU(env), addr,
+        memory_notdirty_write_prepare(ndi, env_cpu(env), addr,
                                       qemu_ram_addr_from_host_nofail(hostaddr),
                                       1 << s_bits);
     }
@@ -1169,7 +1169,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     return hostaddr;
 
  stop_the_world:
-    cpu_loop_exit_atomic(ENV_GET_CPU(env), retaddr);
+    cpu_loop_exit_atomic(env_cpu(env), retaddr);
 }
 
 #ifdef TARGET_WORDS_BIGENDIAN
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index d0d4484406..8a1e408e31 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -146,7 +146,7 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
 
 void *HELPER(lookup_tb_ptr)(CPUArchState *env)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
@@ -165,5 +165,5 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
 
 void HELPER(exit_atomic)(CPUArchState *env)
 {
-    cpu_loop_exit_atomic(ENV_GET_CPU(env), GETPC());
+    cpu_loop_exit_atomic(env_cpu(env), GETPC());
 }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 20b59f93f4..52d94facf0 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1732,7 +1732,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
     tcg_func_start(tcg_ctx);
 
-    tcg_ctx->cpu = ENV_GET_CPU(env);
+    tcg_ctx->cpu = env_cpu(env);
     gen_intermediate_code(cpu, tb, max_insns);
     tcg_ctx->cpu = NULL;
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 0789984fe6..a6d6b06f30 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -698,7 +698,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 {
     /* Enforce qemu required alignment.  */
     if (unlikely(addr & (size - 1))) {
-        cpu_loop_exit_atomic(ENV_GET_CPU(env), retaddr);
+        cpu_loop_exit_atomic(env_cpu(env), retaddr);
     }
     helper_retaddr = retaddr;
     return g2h(addr);
diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 66492aaf5d..1ee6195d9f 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -315,7 +315,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
                             abi_long arg5, abi_long arg6, abi_long arg7,
                             abi_long arg8)
 {
-    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    CPUState *cpu = env_cpu(cpu_env);
     abi_long ret;
     void *p;
 
@@ -413,7 +413,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
                            abi_long arg2, abi_long arg3, abi_long arg4,
                            abi_long arg5, abi_long arg6)
 {
-    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    CPUState *cpu = env_cpu(cpu_env);
     abi_long ret;
     void *p;
 
@@ -488,7 +488,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
                             abi_long arg2, abi_long arg3, abi_long arg4,
                             abi_long arg5, abi_long arg6)
 {
-    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    CPUState *cpu = env_cpu(cpu_env);
     abi_long ret;
     void *p;
 
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index ee68aa60bf..b7e7a6323c 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -423,7 +423,7 @@ void cpu_loop(CPUARMState *env)
 
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     TaskState *ts = cpu->opaque;
     struct image_info *info = ts->info;
     int i;
diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
index af8c128bf8..7ec36cb0b5 100644
--- a/linux-user/cris/cpu_loop.c
+++ b/linux-user/cris/cpu_loop.c
@@ -83,7 +83,7 @@ void cpu_loop(CPUCRISState *env)
 
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     TaskState *ts = cpu->opaque;
     struct image_info *info = ts->info;
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a26021f8..a8a89997b1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3335,7 +3335,7 @@ static int write_note(struct memelfnote *men, int fd)
 
 static void fill_thread_info(struct elf_note_info *info, const CPUArchState *env)
 {
-    CPUState *cpu = ENV_GET_CPU((CPUArchState *)env);
+    CPUState *cpu = env_cpu((CPUArchState *)env);
     TaskState *ts = (TaskState *)cpu->opaque;
     struct elf_thread_status *ets;
 
@@ -3365,7 +3365,7 @@ static int fill_note_info(struct elf_note_info *info,
                           long signr, const CPUArchState *env)
 {
 #define NUMNOTES 3
-    CPUState *cpu = ENV_GET_CPU((CPUArchState *)env);
+    CPUState *cpu = env_cpu((CPUArchState *)env);
     TaskState *ts = (TaskState *)cpu->opaque;
     int i;
 
@@ -3489,7 +3489,7 @@ static int write_note_info(struct elf_note_info *info, int fd)
  */
 static int elf_core_dump(int signr, const CPUArchState *env)
 {
-    const CPUState *cpu = ENV_GET_CPU((CPUArchState *)env);
+    const CPUState *cpu = env_cpu((CPUArchState *)env);
     const TaskState *ts = (const TaskState *)cpu->opaque;
     struct vm_area_struct *vma = NULL;
     char corefile[PATH_MAX];
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index bfb41bbcc5..42d8d841ea 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -130,7 +130,7 @@ void cpu_loop(CPUM68KState *env)
 
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     TaskState *ts = cpu->opaque;
     struct image_info *info = ts->info;
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 3d2230320b..e66e9d5d34 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -177,7 +177,7 @@ void init_task_state(TaskState *ts)
 
 CPUArchState *cpu_copy(CPUArchState *env)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     CPUState *new_cpu = cpu_create(cpu_type);
     CPUArchState *new_env = new_cpu->env_ptr;
     CPUBreakpoint *bp;
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 61dc90d51c..828137cd84 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -654,7 +654,7 @@ error:
 
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     TaskState *ts = cpu->opaque;
     struct image_info *info = ts->info;
     int i;
diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
index 5aa1eca740..9869083fa1 100644
--- a/linux-user/nios2/cpu_loop.c
+++ b/linux-user/nios2/cpu_loop.c
@@ -23,7 +23,7 @@
 
 void cpu_loop(CPUNios2State *env)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     Nios2CPU *cpu = NIOS2_CPU(cs);
     target_siginfo_t info;
     int trapnr, ret;
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index a9bac4ca79..31700f75d0 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -116,7 +116,7 @@ void cpu_loop(CPURISCVState *env)
 
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     TaskState *ts = cpu->opaque;
     struct image_info *info = ts->info;
 
diff --git a/linux-user/signal.c b/linux-user/signal.c
index e2c0b37173..1b0ae7fce1 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -621,7 +621,7 @@ static void QEMU_NORETURN dump_core_and_abort(int target_sig)
 int queue_signal(CPUArchState *env, int sig, int si_type,
                  target_siginfo_t *info)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     TaskState *ts = cpu->opaque;
 
     trace_user_queue_signal(env, sig);
@@ -646,7 +646,7 @@ static void host_signal_handler(int host_signum, siginfo_t *info,
                                 void *puc)
 {
     CPUArchState *env = thread_cpu->env_ptr;
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     TaskState *ts = cpu->opaque;
 
     int sig;
@@ -837,7 +837,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 static void handle_pending_signal(CPUArchState *cpu_env, int sig,
                                   struct emulated_sigtable *k)
 {
-    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    CPUState *cpu = env_cpu(cpu_env);
     abi_ulong handler;
     sigset_t set;
     target_sigset_t target_old_set;
@@ -922,7 +922,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
 
 void process_pending_signals(CPUArchState *cpu_env)
 {
-    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    CPUState *cpu = env_cpu(cpu_env);
     int sig;
     TaskState *ts = cpu->opaque;
     sigset_t set;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 96cd4bf86d..9f110a7581 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5432,7 +5432,7 @@ static void *clone_func(void *arg)
     rcu_register_thread();
     tcg_register_thread();
     env = info->env;
-    cpu = ENV_GET_CPU(env);
+    cpu = env_cpu(env);
     thread_cpu = cpu;
     ts = (TaskState *)cpu->opaque;
     info->tid = sys_gettid();
@@ -5461,7 +5461,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                    abi_ulong parent_tidptr, target_ulong newtls,
                    abi_ulong child_tidptr)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     int ret;
     TaskState *ts;
     CPUState *new_cpu;
@@ -5494,7 +5494,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         new_env = cpu_copy(env);
         /* Init regs that differ from the parent.  */
         cpu_clone_regs(new_env, newsp);
-        new_cpu = ENV_GET_CPU(new_env);
+        new_cpu = env_cpu(new_env);
         new_cpu->opaque = ts;
         ts->bprm = parent_ts->bprm;
         ts->info = parent_ts->info;
@@ -6590,7 +6590,7 @@ int host_to_target_waitstatus(int status)
 
 static int open_self_cmdline(void *cpu_env, int fd)
 {
-    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
+    CPUState *cpu = env_cpu((CPUArchState *)cpu_env);
     struct linux_binprm *bprm = ((TaskState *)cpu->opaque)->bprm;
     int i;
 
@@ -6607,7 +6607,7 @@ static int open_self_cmdline(void *cpu_env, int fd)
 
 static int open_self_maps(void *cpu_env, int fd)
 {
-    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
+    CPUState *cpu = env_cpu((CPUArchState *)cpu_env);
     TaskState *ts = cpu->opaque;
     FILE *fp;
     char *line = NULL;
@@ -6656,7 +6656,7 @@ static int open_self_maps(void *cpu_env, int fd)
 
 static int open_self_stat(void *cpu_env, int fd)
 {
-    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
+    CPUState *cpu = env_cpu((CPUArchState *)cpu_env);
     TaskState *ts = cpu->opaque;
     abi_ulong start_stack = ts->info->start_stack;
     int i;
@@ -6693,7 +6693,7 @@ static int open_self_stat(void *cpu_env, int fd)
 
 static int open_self_auxv(void *cpu_env, int fd)
 {
-    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
+    CPUState *cpu = env_cpu((CPUArchState *)cpu_env);
     TaskState *ts = cpu->opaque;
     abi_ulong auxv = ts->info->saved_auxv;
     abi_ulong len = ts->info->auxv_len;
@@ -6953,7 +6953,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                             abi_long arg5, abi_long arg6, abi_long arg7,
                             abi_long arg8)
 {
-    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    CPUState *cpu = env_cpu(cpu_env);
     abi_long ret;
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) \
     || defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64) \
@@ -11592,7 +11592,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8)
 {
-    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    CPUState *cpu = env_cpu(cpu_env);
     abi_long ret;
 
 #ifdef DEBUG_ERESTARTSYS
diff --git a/linux-user/uname.c b/linux-user/uname.c
index 313b79dbad..54bb7e9278 100644
--- a/linux-user/uname.c
+++ b/linux-user/uname.c
@@ -54,7 +54,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
     return "armv5te" utsname_suffix;
 #elif defined(TARGET_I386) && !defined(TARGET_X86_64)
     /* see arch/x86/kernel/cpu/bugs.c: check_bugs(), 386, 486, 586, 686 */
-    CPUState *cpu = ENV_GET_CPU((CPUX86State *)cpu_env);
+    CPUState *cpu = env_cpu((CPUX86State *)cpu_env);
     int family = object_property_get_int(OBJECT(cpu), "family", NULL);
     if (family == 4) {
         return "i486";
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 81a92ab491..4c57c0ddd4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -561,7 +561,7 @@ static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
 
     tlb_flush_all_cpus_synced(cs);
 }
@@ -569,7 +569,7 @@ static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbiasid_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
 
     tlb_flush_all_cpus_synced(cs);
 }
@@ -577,7 +577,7 @@ static void tlbiasid_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbimva_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
 
     tlb_flush_page_all_cpus_synced(cs, value & TARGET_PAGE_MASK);
 }
@@ -585,7 +585,7 @@ static void tlbimva_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbimvaa_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
 
     tlb_flush_page_all_cpus_synced(cs, value & TARGET_PAGE_MASK);
 }
@@ -660,7 +660,7 @@ static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx(cs,
                         ARMMMUIdxBit_S12NSE1 |
@@ -671,7 +671,7 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
                                         ARMMMUIdxBit_S12NSE1 |
@@ -688,7 +688,7 @@ static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * translation information.
      * This must NOP if EL2 isn't implemented or SCR_EL3.NS is zero.
      */
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     uint64_t pageaddr;
 
     if (!arm_feature(env, ARM_FEATURE_EL2) || !(env->cp15.scr_el3 & SCR_NS)) {
@@ -703,7 +703,7 @@ static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     uint64_t pageaddr;
 
     if (!arm_feature(env, ARM_FEATURE_EL2) || !(env->cp15.scr_el3 & SCR_NS)) {
@@ -719,7 +719,7 @@ static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
                               uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
 }
@@ -727,7 +727,7 @@ static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E2);
 }
@@ -735,7 +735,7 @@ static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
                               uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
     tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E2);
@@ -744,7 +744,7 @@ static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
@@ -1895,7 +1895,7 @@ static void csselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     uint64_t ret = 0;
 
@@ -3747,7 +3747,7 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
 static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                       uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     bool sec = arm_is_secure_below_el3(env);
 
     if (sec) {
@@ -3764,7 +3764,7 @@ static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
 
     if (tlb_force_broadcast(env)) {
         tlbi_aa64_vmalle1is_write(env, NULL, value);
@@ -3835,7 +3835,7 @@ static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * stage 2 translations, whereas most other scopes only invalidate
      * stage 1 translations.
      */
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     bool sec = arm_is_secure_below_el3(env);
     bool has_el2 = arm_feature(env, ARM_FEATURE_EL2);
 
@@ -3858,7 +3858,7 @@ static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E2);
 }
@@ -3866,7 +3866,7 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E3);
 }
@@ -3949,7 +3949,7 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
@@ -3959,7 +3959,7 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
@@ -3991,7 +3991,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                       uint64_t value)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     uint64_t pageaddr;
 
     if (!arm_feature(env, ARM_FEATURE_EL2) || !(env->cp15.scr_el3 & SCR_NS)) {
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index a55a5dfc02..952e97a7d7 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -77,7 +77,7 @@ static void atomic_store_3(CPUHPPAState *env, target_ulong addr, uint32_t val,
     }
 #else
     /* FIXME -- we can do better.  */
-    cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+    cpu_loop_exit_atomic(env_cpu(env), ra);
 #endif
 }
 
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 44b89c1d74..64fd51ad4a 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -67,7 +67,7 @@ int valid_hax_tunnel_size(uint16_t size)
 
 hax_fd hax_vcpu_get_fd(CPUArchState *env)
 {
-    struct hax_vcpu_state *vcpu = ENV_GET_CPU(env)->hax_vcpu;
+    struct hax_vcpu_state *vcpu = env_cpu(env)->hax_vcpu;
     if (!vcpu) {
         return HAX_INVALID_FD;
     }
@@ -409,7 +409,7 @@ static int hax_handle_io(CPUArchState *env, uint32_t df, uint16_t port,
 
 static int hax_vcpu_interrupt(CPUArchState *env)
 {
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     struct hax_vcpu_state *vcpu = cpu->hax_vcpu;
     struct hax_tunnel *ht = vcpu->tunnel;
 
@@ -461,7 +461,7 @@ void hax_raise_event(CPUState *cpu)
 static int hax_vcpu_hax_exec(CPUArchState *env)
 {
     int ret = 0;
-    CPUState *cpu = ENV_GET_CPU(env);
+    CPUState *cpu = env_cpu(env);
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct hax_vcpu_state *vcpu = cpu->hax_vcpu;
     struct hax_tunnel *ht = vcpu->tunnel;
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 9ef7d7513f..822fa1866e 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -75,8 +75,8 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         VM_PANIC_EX("%s invalid size %d\n", __func__, size);
         break;
     }
-    target_ulong va  = linear_rip(ENV_GET_CPU(env), RIP(env)) + decode->len;
-    vmx_read_mem(ENV_GET_CPU(env), &val, va, size);
+    target_ulong va  = linear_rip(env_cpu(env), RIP(env)) + decode->len;
+    vmx_read_mem(env_cpu(env), &val, va, size);
     decode->len += size;
     
     return val;
@@ -1772,7 +1772,7 @@ void calc_modrm_operand32(CPUX86State *env, struct x86_decode *decode,
     if (4 == decode->modrm.rm) {
         ptr += get_sib_val(env, decode, &seg);
     } else if (!decode->modrm.mod && 5 == decode->modrm.rm) {
-        if (x86_is_long_mode(ENV_GET_CPU(env))) {
+        if (x86_is_long_mode(env_cpu(env))) {
             ptr += RIP(env) + decode->len;
         } else {
             ptr = decode->displacement;
@@ -1877,7 +1877,7 @@ static void decode_prefix(CPUX86State *env, struct x86_decode *decode)
             decode->addr_size_override = byte;
             break;
         case PREFIX_REX ... (PREFIX_REX + 0xf):
-            if (x86_is_long_mode(ENV_GET_CPU(env))) {
+            if (x86_is_long_mode(env_cpu(env))) {
                 decode->rex.rex = byte;
                 break;
             }
@@ -1892,16 +1892,16 @@ static void decode_prefix(CPUX86State *env, struct x86_decode *decode)
 void set_addressing_size(CPUX86State *env, struct x86_decode *decode)
 {
     decode->addressing_size = -1;
-    if (x86_is_real(ENV_GET_CPU(env)) || x86_is_v8086(ENV_GET_CPU(env))) {
+    if (x86_is_real(env_cpu(env)) || x86_is_v8086(env_cpu(env))) {
         if (decode->addr_size_override) {
             decode->addressing_size = 4;
         } else {
             decode->addressing_size = 2;
         }
-    } else if (!x86_is_long_mode(ENV_GET_CPU(env))) {
+    } else if (!x86_is_long_mode(env_cpu(env))) {
         /* protected */
         struct vmx_segment cs;
-        vmx_read_segment_descriptor(ENV_GET_CPU(env), &cs, R_CS);
+        vmx_read_segment_descriptor(env_cpu(env), &cs, R_CS);
         /* check db */
         if ((cs.ar >> 14) & 1) {
             if (decode->addr_size_override) {
@@ -1929,16 +1929,16 @@ void set_addressing_size(CPUX86State *env, struct x86_decode *decode)
 void set_operand_size(CPUX86State *env, struct x86_decode *decode)
 {
     decode->operand_size = -1;
-    if (x86_is_real(ENV_GET_CPU(env)) || x86_is_v8086(ENV_GET_CPU(env))) {
+    if (x86_is_real(env_cpu(env)) || x86_is_v8086(env_cpu(env))) {
         if (decode->op_size_override) {
             decode->operand_size = 4;
         } else {
             decode->operand_size = 2;
         }
-    } else if (!x86_is_long_mode(ENV_GET_CPU(env))) {
+    } else if (!x86_is_long_mode(env_cpu(env))) {
         /* protected */
         struct vmx_segment cs;
-        vmx_read_segment_descriptor(ENV_GET_CPU(env), &cs, R_CS);
+        vmx_read_segment_descriptor(env_cpu(env), &cs, R_CS);
         /* check db */
         if ((cs.ar >> 14) & 1) {
             if (decode->op_size_override) {
@@ -2188,5 +2188,5 @@ target_ulong decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
     default:
         break;
     }
-    return linear_addr_size(ENV_GET_CPU(env), addr, decode->addressing_size, seg);
+    return linear_addr_size(env_cpu(env), addr, decode->addressing_size, seg);
 }
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 3ea18edc68..1b04bd7e94 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -182,12 +182,12 @@ void write_val_ext(struct CPUX86State *env, target_ulong ptr, target_ulong val,
         write_val_to_reg(ptr, val, size);
         return;
     }
-    vmx_write_mem(ENV_GET_CPU(env), ptr, &val, size);
+    vmx_write_mem(env_cpu(env), ptr, &val, size);
 }
 
 uint8_t *read_mmio(struct CPUX86State *env, target_ulong ptr, int bytes)
 {
-    vmx_read_mem(ENV_GET_CPU(env), env->hvf_emul->mmio_buf, ptr, bytes);
+    vmx_read_mem(env_cpu(env), env->hvf_emul->mmio_buf, ptr, bytes);
     return env->hvf_emul->mmio_buf;
 }
 
@@ -399,17 +399,18 @@ static void exec_out(struct CPUX86State *env, struct x86_decode *decode)
 {
     switch (decode->opcode[0]) {
     case 0xe6:
-        hvf_handle_io(ENV_GET_CPU(env), decode->op[0].val, &AL(env), 1, 1, 1);
+        hvf_handle_io(env_cpu(env), decode->op[0].val, &AL(env), 1, 1, 1);
         break;
     case 0xe7:
-        hvf_handle_io(ENV_GET_CPU(env), decode->op[0].val, &RAX(env), 1,
+        hvf_handle_io(env_cpu(env), decode->op[0].val, &RAX(env), 1,
                       decode->operand_size, 1);
         break;
     case 0xee:
-        hvf_handle_io(ENV_GET_CPU(env), DX(env), &AL(env), 1, 1, 1);
+        hvf_handle_io(env_cpu(env), DX(env), &AL(env), 1, 1, 1);
         break;
     case 0xef:
-        hvf_handle_io(ENV_GET_CPU(env), DX(env), &RAX(env), 1, decode->operand_size, 1);
+        hvf_handle_io(env_cpu(env), DX(env), &RAX(env), 1,
+                      decode->operand_size, 1);
         break;
     default:
         VM_PANIC("Bad out opcode\n");
@@ -423,10 +424,11 @@ static void exec_in(struct CPUX86State *env, struct x86_decode *decode)
     target_ulong val = 0;
     switch (decode->opcode[0]) {
     case 0xe4:
-        hvf_handle_io(ENV_GET_CPU(env), decode->op[0].val, &AL(env), 0, 1, 1);
+        hvf_handle_io(env_cpu(env), decode->op[0].val, &AL(env), 0, 1, 1);
         break;
     case 0xe5:
-        hvf_handle_io(ENV_GET_CPU(env), decode->op[0].val, &val, 0, decode->operand_size, 1);
+        hvf_handle_io(env_cpu(env), decode->op[0].val, &val, 0,
+                      decode->operand_size, 1);
         if (decode->operand_size == 2) {
             AX(env) = val;
         } else {
@@ -434,10 +436,10 @@ static void exec_in(struct CPUX86State *env, struct x86_decode *decode)
         }
         break;
     case 0xec:
-        hvf_handle_io(ENV_GET_CPU(env), DX(env), &AL(env), 0, 1, 1);
+        hvf_handle_io(env_cpu(env), DX(env), &AL(env), 0, 1, 1);
         break;
     case 0xed:
-        hvf_handle_io(ENV_GET_CPU(env), DX(env), &val, 0, decode->operand_size, 1);
+        hvf_handle_io(env_cpu(env), DX(env), &val, 0, decode->operand_size, 1);
         if (decode->operand_size == 2) {
             AX(env) = val;
         } else {
@@ -484,12 +486,13 @@ static inline void string_rep(struct CPUX86State *env, struct x86_decode *decode
 
 static void exec_ins_single(struct CPUX86State *env, struct x86_decode *decode)
 {
-    target_ulong addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
-                                   R_ES);
+    target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
+                                         decode->addressing_size, R_ES);
 
-    hvf_handle_io(ENV_GET_CPU(env), DX(env), env->hvf_emul->mmio_buf, 0,
+    hvf_handle_io(env_cpu(env), DX(env), env->hvf_emul->mmio_buf, 0,
                   decode->operand_size, 1);
-    vmx_write_mem(ENV_GET_CPU(env), addr, env->hvf_emul->mmio_buf, decode->operand_size);
+    vmx_write_mem(env_cpu(env), addr, env->hvf_emul->mmio_buf,
+                  decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
 }
@@ -509,8 +512,9 @@ static void exec_outs_single(struct CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
-    vmx_read_mem(ENV_GET_CPU(env), env->hvf_emul->mmio_buf, addr, decode->operand_size);
-    hvf_handle_io(ENV_GET_CPU(env), DX(env), env->hvf_emul->mmio_buf, 1,
+    vmx_read_mem(env_cpu(env), env->hvf_emul->mmio_buf, addr,
+                 decode->operand_size);
+    hvf_handle_io(env_cpu(env), DX(env), env->hvf_emul->mmio_buf, 1,
                   decode->operand_size, 1);
 
     string_increment_reg(env, R_ESI, decode);
@@ -534,8 +538,8 @@ static void exec_movs_single(struct CPUX86State *env, struct x86_decode *decode)
     target_ulong val;
 
     src_addr = decode_linear_addr(env, decode, RSI(env), R_DS);
-    dst_addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
-                                R_ES);
+    dst_addr = linear_addr_size(env_cpu(env), RDI(env),
+                                decode->addressing_size, R_ES);
 
     val = read_val_ext(env, src_addr, decode->operand_size);
     write_val_ext(env, dst_addr, val, decode->operand_size);
@@ -561,8 +565,8 @@ static void exec_cmps_single(struct CPUX86State *env, struct x86_decode *decode)
     target_ulong dst_addr;
 
     src_addr = decode_linear_addr(env, decode, RSI(env), R_DS);
-    dst_addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
-                                R_ES);
+    dst_addr = linear_addr_size(env_cpu(env), RDI(env),
+                                decode->addressing_size, R_ES);
 
     decode->op[0].type = X86_VAR_IMMEDIATE;
     decode->op[0].val = read_val_ext(env, src_addr, decode->operand_size);
@@ -591,9 +595,10 @@ static void exec_stos_single(struct CPUX86State *env, struct x86_decode *decode)
     target_ulong addr;
     target_ulong val;
 
-    addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size, R_ES);
+    addr = linear_addr_size(env_cpu(env), RDI(env),
+                            decode->addressing_size, R_ES);
     val = read_reg(env, R_EAX, decode->operand_size);
-    vmx_write_mem(ENV_GET_CPU(env), addr, &val, decode->operand_size);
+    vmx_write_mem(env_cpu(env), addr, &val, decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
 }
@@ -614,9 +619,10 @@ static void exec_scas_single(struct CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr;
 
-    addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size, R_ES);
+    addr = linear_addr_size(env_cpu(env), RDI(env),
+                            decode->addressing_size, R_ES);
     decode->op[1].type = X86_VAR_IMMEDIATE;
-    vmx_read_mem(ENV_GET_CPU(env), &decode->op[1].val, addr, decode->operand_size);
+    vmx_read_mem(env_cpu(env), &decode->op[1].val, addr, decode->operand_size);
 
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     string_increment_reg(env, R_EDI, decode);
@@ -641,7 +647,7 @@ static void exec_lods_single(struct CPUX86State *env, struct x86_decode *decode)
     target_ulong val = 0;
 
     addr = decode_linear_addr(env, decode, RSI(env), R_DS);
-    vmx_read_mem(ENV_GET_CPU(env), &val, addr,  decode->operand_size);
+    vmx_read_mem(env_cpu(env), &val, addr,  decode->operand_size);
     write_reg(env, R_EAX, val, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
@@ -753,7 +759,7 @@ void simulate_rdmsr(struct CPUState *cpu)
 
 static void exec_rdmsr(struct CPUX86State *env, struct x86_decode *decode)
 {
-    simulate_rdmsr(ENV_GET_CPU(env));
+    simulate_rdmsr(env_cpu(env));
     RIP(env) += decode->len;
 }
 
@@ -851,7 +857,7 @@ void simulate_wrmsr(struct CPUState *cpu)
 
 static void exec_wrmsr(struct CPUX86State *env, struct x86_decode *decode)
 {
-    simulate_wrmsr(ENV_GET_CPU(env));
+    simulate_wrmsr(env_cpu(env));
     RIP(env) += decode->len;
 }
 
diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
index 6cc53bcb40..ae2b2fb4f4 100644
--- a/target/i386/mem_helper.c
+++ b/target/i386/mem_helper.c
@@ -89,7 +89,7 @@ void helper_cmpxchg8b(CPUX86State *env, target_ulong a0)
     }
     CC_SRC = eflags;
 #else
-    cpu_loop_exit_atomic(ENV_GET_CPU(env), GETPC());
+    cpu_loop_exit_atomic(env_cpu(env), GETPC());
 #endif /* CONFIG_ATOMIC64 */
 }
 
@@ -158,7 +158,7 @@ void helper_cmpxchg16b(CPUX86State *env, target_ulong a0)
         }
         CC_SRC = eflags;
     } else {
-        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+        cpu_loop_exit_atomic(env_cpu(env), ra);
     }
 }
 #endif
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 76f439985a..13fcaa74ef 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -800,7 +800,7 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
 #endif
         {
             /* Tell the main loop we need to serialize this insn.  */
-            cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+            cpu_loop_exit_atomic(env_cpu(env), ra);
         }
     } else {
         /* We're executing in a serial context -- no need to be atomic.  */
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
index 5acf442d8b..33382bad1b 100644
--- a/target/nios2/mmu.c
+++ b/target/nios2/mmu.c
@@ -114,7 +114,7 @@ unsigned int mmu_translate(CPUNios2State *env,
 
 static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     Nios2CPU *cpu = nios2_env_get_cpu(env);
     int idx;
     MMU_LOG(qemu_log("TLB Flush PID %d\n", pid));
@@ -138,7 +138,7 @@ static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
 
 void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     Nios2CPU *cpu = nios2_env_get_cpu(env);
 
     MMU_LOG(qemu_log("mmu_write %08X = %08X\n", rn, v));
diff --git a/target/nios2/op_helper.c b/target/nios2/op_helper.c
index 529ec6ac0e..a60730faac 100644
--- a/target/nios2/op_helper.c
+++ b/target/nios2/op_helper.c
@@ -46,7 +46,7 @@ void helper_check_interrupts(CPUNios2State *env)
 
 void helper_raise_exception(CPUNios2State *env, uint32_t index)
 {
-    CPUState *cs = ENV_GET_CPU(env);
+    CPUState *cs = env_cpu(env);
     cs->exception_index = index;
     cpu_loop_exit(cs);
 }
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 1dbc9acb75..b32693f24e 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -522,7 +522,7 @@ static inline int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
             ret = ppc6xx_tlb_check(env, ctx, eaddr, rw, type);
 #if defined(DUMP_PAGE_TABLES)
             if (qemu_loglevel_mask(CPU_LOG_MMU)) {
-                CPUState *cs = ENV_GET_CPU(env);
+                CPUState *cs = env_cpu(env);
                 hwaddr curaddr;
                 uint32_t a0, a1, a2, a3;
 
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index df147596ce..1e6d99287b 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -96,7 +96,7 @@ static int cpu_write_ac_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
     switch (n) {
     case S390_A0_REGNUM ... S390_A15_REGNUM:
         env->aregs[n] = ldl_p(mem_buf);
-        cpu_synchronize_post_init(ENV_GET_CPU(env));
+        cpu_synchronize_post_init(env_cpu(env));
         return 4;
     default:
         return 0;
@@ -201,9 +201,9 @@ static int cpu_write_c_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
     case S390_C0_REGNUM ... S390_C15_REGNUM:
         env->cregs[n] = ldtul_p(mem_buf);
         if (tcg_enabled()) {
-            tlb_flush(ENV_GET_CPU(env));
+            tlb_flush(env_cpu(env));
         }
-        cpu_synchronize_post_init(ENV_GET_CPU(env));
+        cpu_synchronize_post_init(env_cpu(env));
         return 8;
     default:
         return 0;
@@ -251,35 +251,35 @@ static int cpu_write_virt_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
     switch (n) {
     case S390_VIRT_CKC_REGNUM:
         env->ckc = ldtul_p(mem_buf);
-        cpu_synchronize_post_init(ENV_GET_CPU(env));
+        cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_CPUTM_REGNUM:
         env->cputm = ldtul_p(mem_buf);
-        cpu_synchronize_post_init(ENV_GET_CPU(env));
+        cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_BEA_REGNUM:
         env->gbea = ldtul_p(mem_buf);
-        cpu_synchronize_post_init(ENV_GET_CPU(env));
+        cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_PREFIX_REGNUM:
         env->psa = ldtul_p(mem_buf);
-        cpu_synchronize_post_init(ENV_GET_CPU(env));
+        cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_PP_REGNUM:
         env->pp = ldtul_p(mem_buf);
-        cpu_synchronize_post_init(ENV_GET_CPU(env));
+        cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_PFT_REGNUM:
         env->pfault_token = ldtul_p(mem_buf);
-        cpu_synchronize_post_init(ENV_GET_CPU(env));
+        cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_PFS_REGNUM:
         env->pfault_select = ldtul_p(mem_buf);
-        cpu_synchronize_post_init(ENV_GET_CPU(env));
+        cpu_synchronize_post_init(env_cpu(env));
         return 8;
     case S390_VIRT_PFC_REGNUM:
         env->pfault_compare = ldtul_p(mem_buf);
-        cpu_synchronize_post_init(ENV_GET_CPU(env));
+        cpu_synchronize_post_init(env_cpu(env));
         return 8;
     default:
         return 0;
@@ -303,7 +303,7 @@ static int cpu_read_gs_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 static int cpu_write_gs_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 {
     env->gscb[n] = ldtul_p(mem_buf);
-    cpu_synchronize_post_init(ENV_GET_CPU(env));
+    cpu_synchronize_post_init(env_cpu(env));
     return 8;
 }
 
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 3f76a8abfd..e2992deb2f 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1477,7 +1477,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
 #endif
         if ((HAVE_CMPXCHG128 ? 0 : fc + 2 > max) ||
             (HAVE_ATOMIC128  ? 0 : sc > max)) {
-            cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+            cpu_loop_exit_atomic(env_cpu(env), ra);
         }
     }
 
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 4f825bae5a..12fba6fc78 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -119,7 +119,7 @@ void helper_trapa(CPUSH4State *env, uint32_t tra)
 void helper_exclusive(CPUSH4State *env)
 {
     /* We do not want cpu_restore_state to run.  */
-    cpu_loop_exit_atomic(ENV_GET_CPU(env), 0);
+    cpu_loop_exit_atomic(env_cpu(env), 0);
 }
 
 void helper_movcal(CPUSH4State *env, uint32_t address, uint32_t value)
diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 056aa56496..76e492a489 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -434,9 +434,9 @@ Can be used as:
         /* trace emitted at this point */
         trace_foo(0xd1);
         /* trace emitted at this point */
-        trace_bar(ENV_GET_CPU(env), 0xd2);
+        trace_bar(env_cpu(env), 0xd2);
         /* trace emitted at this point (env) and when guest code is executed (cpu_env) */
-        trace_baz_tcg(ENV_GET_CPU(env), cpu_env, 0xd3);
+        trace_baz_tcg(env_cpu(env), cpu_env, 0xd3);
     }
 
 If the translating vCPU has address 0xc1 and code is later executed by vCPU
diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool/format/tcg_helper_c.py
index bbbd6ad0f4..79aa63eada 100644
--- a/scripts/tracetool/format/tcg_helper_c.py
+++ b/scripts/tracetool/format/tcg_helper_c.py
@@ -25,7 +25,7 @@ def vcpu_transform_args(args, mode):
     if mode == "code":
         return Arguments([
             # Does cast from helper requirements to tracing types
-            ("CPUState *", "ENV_GET_CPU(%s)" % args.names()[0]),
+            ("CPUState *", "env_cpu(%s)" % args.names()[0]),
         ])
     else:
         args = Arguments([
-- 
2.17.1


