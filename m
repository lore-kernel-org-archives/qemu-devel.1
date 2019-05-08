Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA6C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203F9205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnRENbW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203F9205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAOx-0006iR-86
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:25:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7G-0007iG-Ui
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7F-0007MT-2Q
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:22 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA7B-0007AY-El
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:19 -0400
Received: by mail-pg1-x542.google.com with SMTP id j26so9120002pgl.5
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=X6rkU80T9pq7xJ1Q81uwCozlYnDgP/X2oENNiBDM150=;
	b=qnRENbW/wER0NWsG06Oj9VZr3W6Nu5wNRi9t7dfvLN7P3iq2FukD5LUC2lDeAT2d4A
	Nmz1anxAgOKupvPzJHAao2DAUE9IGcCJUKwELgOqpyF1EhJRxLc58ytbQtUCvZNcRlBB
	MTkUTQqo9cm43rTGFXAh7JWVI+AGnCVOM0bmPX+6zNoHQqCeb6bS2Blt1dDYCMToJNZ/
	sCLhIJVINK1pQo4VRfLqc+3t5NVHvcFB/MtnIVUmrOKIzzi88bnKKgG7jj3QqVMLYqij
	iaHptjHK+n+3MAWfDXA55hchNDlf/D/6406h+zUK1tGg5gSxXTEvJlgS9+b3D5Aqo/RE
	OkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=X6rkU80T9pq7xJ1Q81uwCozlYnDgP/X2oENNiBDM150=;
	b=PUIXP5qXVPAlGkhk189v1R//6yicLGrMzSF1GGURjNSquWonWGS7a0lBwl6QU4zEdR
	R+TT8t9j9+ZMpnp6RiPuk6v9dZbzFj546O0wbN23QAfk/HTPkoP0TySatsT3XrPa9s/q
	OreD4zAFIizAHzN49tiqoJYsp9/E9wW54y6+G1MIAdDyNYqiTERcG5JEFYQFtnmH8HBE
	wtZpKxTzk/IonhwpVtJCgwexDsEKHvgoYP+ais+VxDKpHIK7chI3Kgly8HEtQ41VOUNK
	ZgilSDEgx/Wr9C8ouLuET/FuIMlMddTslawgJ6op0G5cJGeMqyYn/RFmQt1cN9+AKO1q
	FifQ==
X-Gm-Message-State: APjAAAXKRcmbUi2ktIeKss73hJwYSe2P98p6nUtG4VXbBFNW49vPUOYA
	zfjT4c6eLTizVX5LALONMIPyFDIcOu4=
X-Google-Smtp-Source: APXvYqxs6JvVtnLQosNcivtWIic8V+jnZB3n7os7rn+cG0Q4VSifjKznM+oMLbdhfu5/4P99fs4tEA==
X-Received: by 2002:a63:555a:: with SMTP id f26mr10078619pgm.197.1557274036105;
	Tue, 07 May 2019 17:07:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:27 -0700
Message-Id: <20190508000641.19090-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v3 25/39] target/sh4: Use env_cpu, env_archcpu
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.h          |  5 -----
 linux-user/sh4/cpu_loop.c |  2 +-
 target/sh4/helper.c       | 26 ++++++++++++--------------
 target/sh4/op_helper.c    |  9 +++------
 4 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index c1a9e4f981..2ed942ca47 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -207,11 +207,6 @@ struct SuperHCPU {
     CPUSH4State env;
 };
 
-static inline SuperHCPU *sh_env_get_cpu(CPUSH4State *env)
-{
-    return container_of(env, SuperHCPU, env);
-}
-
 #define ENV_OFFSET offsetof(SuperHCPU, env)
 
 void superh_cpu_do_interrupt(CPUState *cpu);
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 59cbbeda7e..add8817d86 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -23,7 +23,7 @@
 
 void cpu_loop(CPUSH4State *env)
 {
-    CPUState *cs = CPU(sh_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr, ret;
     target_siginfo_t info;
 
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 2ff0cf4060..5240da715e 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -238,8 +238,6 @@ static void update_itlb_use(CPUSH4State * env, int itlbnb)
 
 static int itlb_replacement(CPUSH4State * env)
 {
-    SuperHCPU *cpu = sh_env_get_cpu(env);
-
     if ((env->mmucr & 0xe0000000) == 0xe0000000) {
 	return 0;
     }
@@ -252,7 +250,7 @@ static int itlb_replacement(CPUSH4State * env)
     if ((env->mmucr & 0x2c000000) == 0x00000000) {
 	return 3;
     }
-    cpu_abort(CPU(cpu), "Unhandled itlb_replacement");
+    cpu_abort(env_cpu(env), "Unhandled itlb_replacement");
 }
 
 /* Find the corresponding entry in the right TLB
@@ -308,7 +306,7 @@ static int copy_utlb_entry_itlb(CPUSH4State *env, int utlb)
     itlb = itlb_replacement(env);
     ientry = &env->itlb[itlb];
     if (ientry->v) {
-        tlb_flush_page(CPU(sh_env_get_cpu(env)), ientry->vpn << 10);
+        tlb_flush_page(env_cpu(env), ientry->vpn << 10);
     }
     *ientry = env->utlb[utlb];
     update_itlb_use(env, itlb);
@@ -533,14 +531,14 @@ hwaddr superh_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
 void cpu_load_tlb(CPUSH4State * env)
 {
-    SuperHCPU *cpu = sh_env_get_cpu(env);
+    CPUState *cs = env_cpu(env);
     int n = cpu_mmucr_urc(env->mmucr);
     tlb_t * entry = &env->utlb[n];
 
     if (entry->v) {
         /* Overwriting valid entry in utlb. */
         target_ulong address = entry->vpn << 10;
-        tlb_flush_page(CPU(cpu), address);
+        tlb_flush_page(cs, address);
     }
 
     /* Take values into cpu status from registers. */
@@ -563,7 +561,7 @@ void cpu_load_tlb(CPUSH4State * env)
         entry->size = 1024 * 1024; /* 1M */
         break;
     default:
-        cpu_abort(CPU(cpu), "Unhandled load_tlb");
+        cpu_abort(cs, "Unhandled load_tlb");
         break;
     }
     entry->sh   = (uint8_t)cpu_ptel_sh(env->ptel);
@@ -590,7 +588,7 @@ void cpu_load_tlb(CPUSH4State * env)
         entry->v = 0;
     }
 
-    tlb_flush(CPU(sh_env_get_cpu(s)));
+    tlb_flush(env_cpu(s));
 }
 
 uint32_t cpu_sh4_read_mmaped_itlb_addr(CPUSH4State *s,
@@ -616,7 +614,7 @@ void cpu_sh4_write_mmaped_itlb_addr(CPUSH4State *s, hwaddr addr,
     if (entry->v) {
         /* Overwriting valid entry in itlb. */
         target_ulong address = entry->vpn << 10;
-        tlb_flush_page(CPU(sh_env_get_cpu(s)), address);
+        tlb_flush_page(env_cpu(s), address);
     }
     entry->asid = asid;
     entry->vpn = vpn;
@@ -658,7 +656,7 @@ void cpu_sh4_write_mmaped_itlb_data(CPUSH4State *s, hwaddr addr,
         if (entry->v) {
             /* Overwriting valid entry in utlb. */
             target_ulong address = entry->vpn << 10;
-            tlb_flush_page(CPU(sh_env_get_cpu(s)), address);
+            tlb_flush_page(env_cpu(s), address);
         }
         entry->ppn = (mem_value & 0x1ffffc00) >> 10;
         entry->v   = (mem_value & 0x00000100) >> 8;
@@ -711,7 +709,7 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
             if (entry->vpn == vpn
                 && (!use_asid || entry->asid == asid || entry->sh)) {
 	        if (utlb_match_entry) {
-                    CPUState *cs = CPU(sh_env_get_cpu(s));
+                    CPUState *cs = env_cpu(s);
 
 		    /* Multiple TLB Exception */
                     cs->exception_index = 0x140;
@@ -743,14 +741,14 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
 	}
 
         if (needs_tlb_flush) {
-            tlb_flush_page(CPU(sh_env_get_cpu(s)), vpn << 10);
+            tlb_flush_page(env_cpu(s), vpn << 10);
         }
         
     } else {
         int index = (addr & 0x00003f00) >> 8;
         tlb_t * entry = &s->utlb[index];
 	if (entry->v) {
-            CPUState *cs = CPU(sh_env_get_cpu(s));
+            CPUState *cs = env_cpu(s);
 
 	    /* Overwriting valid entry in utlb. */
             target_ulong address = entry->vpn << 10;
@@ -805,7 +803,7 @@ void cpu_sh4_write_mmaped_utlb_data(CPUSH4State *s, hwaddr addr,
         if (entry->v) {
             /* Overwriting valid entry in utlb. */
             target_ulong address = entry->vpn << 10;
-            tlb_flush_page(CPU(sh_env_get_cpu(s)), address);
+            tlb_flush_page(env_cpu(s), address);
         }
         entry->ppn = (mem_value & 0x1ffffc00) >> 10;
         entry->v   = (mem_value & 0x00000100) >> 8;
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 12fba6fc78..11cb68cc1c 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -58,10 +58,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
 void helper_ldtlb(CPUSH4State *env)
 {
 #ifdef CONFIG_USER_ONLY
-    SuperHCPU *cpu = sh_env_get_cpu(env);
-
-    /* XXXXX */
-    cpu_abort(CPU(cpu), "Unhandled ldtlb");
+    cpu_abort(env_cpu(env), "Unhandled ldtlb");
 #else
     cpu_load_tlb(env);
 #endif
@@ -70,7 +67,7 @@ void helper_ldtlb(CPUSH4State *env)
 static inline void QEMU_NORETURN raise_exception(CPUSH4State *env, int index,
                                                  uintptr_t retaddr)
 {
-    CPUState *cs = CPU(sh_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = index;
     cpu_loop_exit_restore(cs, retaddr);
@@ -103,7 +100,7 @@ void helper_debug(CPUSH4State *env)
 
 void helper_sleep(CPUSH4State *env)
 {
-    CPUState *cs = CPU(sh_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->halted = 1;
     env->in_sleep = 1;
-- 
2.17.1


