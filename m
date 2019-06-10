Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296C7C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCD620820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sk4UdPic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCD620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39786 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haA30-0006eV-8h
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53228)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eA-0006oD-RX
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9e9-0001qN-5U
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:54 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:45547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9e8-0001po-SF
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:53 -0400
Received: by mail-pf1-x433.google.com with SMTP id s11so4302657pfm.12
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jHl7gkzT/N8BQj20qWalBWj0TcNnQlOd+W3G9t5Nacs=;
 b=sk4UdPicZz9qqP1RQq3XO7CuSFwftnXVMRai2sKFr0T7ChQNAb4w5qSsUp2dg2yHdB
 Tv+juR00C8M1e6baDg1Yiu9oklCmjo0tK/X/hSzhhhTD7AbGlECT//i4kIlfVGvcv6WZ
 DlST4NTRYpDf1TZF90vJz8jwHVodHLJLieBzhMwd0820hOJXw6ukxD3g03bTElFcZ4nM
 /OXxHvdARu8TlP0l8Xo+/OKKqJYu1m2UWICXNmHVt4gbJpj3NmbrlJ6hicm2Jy5KsUHz
 XaRjf7vSSoHZ0s9Q3Ilb9OhCp1UXGkrR27egl8QjmweD+0DXdgxwzCxywOMiG/hi90gM
 cIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jHl7gkzT/N8BQj20qWalBWj0TcNnQlOd+W3G9t5Nacs=;
 b=E5OFuu2nNGPVtRGF8C8qz379BSNMCDPHtdu1opaA1iEuvVjpOOwRcux5EnwR9p+sVn
 G4VI6b0rUqE/ZSMzzzvRO3S4gFOuSdOXudH95oOOoldoc/TNT0Y95Jlnu55EcK5gAipZ
 O6Ci22/d7pTd3MYilBOEpVF8dcq2l36StM83yxW9+rc0ZrXQdtVt6oWEemb8LLIKsRkx
 M0PCIIBWetLDLHF/CRHBSsDAUyVNfiAjoHC/r2skDbf9zQ/hZRzPg11T7cVC5kSEYvz1
 Ruxf3lv5f8tcoxwQaFTL0IIo0rAqvzuqXbw3L2wKjWMm36jTFc7Kt3UiQrBzHkYD6QkL
 bRtQ==
X-Gm-Message-State: APjAAAVSz2u8nTDsiplu2Y8RFMZn7nbSU2w22YsMVkUWM5vrjhT/Tvt3
 GbWAV6zW3VR5Wc5XPhGEp+ELCO53NI0=
X-Google-Smtp-Source: APXvYqwX1YuY+Sxg5SP39ibNviIHXnrz+4fWfKr7+MaHdyQGyM/wyLghYtA2aDoi06LZ+I78xSoOXw==
X-Received: by 2002:a63:f257:: with SMTP id d23mr13828311pgk.305.1560132171030; 
 Sun, 09 Jun 2019 19:02:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:04 -0700
Message-Id: <20190610020218.9228-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::433
Subject: [Qemu-devel] [PULL 25/39] target/sh4: Use env_cpu, env_archcpu
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup in the boilerplate that each target must define.
Replace sh_env_get_cpu with env_archcpu.  The combination
CPU(sh_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.h          |  5 -----
 linux-user/sh4/cpu_loop.c |  2 +-
 target/sh4/helper.c       | 26 ++++++++++++--------------
 target/sh4/op_helper.c    |  9 +++------
 4 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 8b17e6d63e..089eea261c 100644
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
index fda195e7cb..2afc1770d8 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -216,8 +216,6 @@ static void update_itlb_use(CPUSH4State * env, int itlbnb)
 
 static int itlb_replacement(CPUSH4State * env)
 {
-    SuperHCPU *cpu = sh_env_get_cpu(env);
-
     if ((env->mmucr & 0xe0000000) == 0xe0000000) {
 	return 0;
     }
@@ -230,7 +228,7 @@ static int itlb_replacement(CPUSH4State * env)
     if ((env->mmucr & 0x2c000000) == 0x00000000) {
 	return 3;
     }
-    cpu_abort(CPU(cpu), "Unhandled itlb_replacement");
+    cpu_abort(env_cpu(env), "Unhandled itlb_replacement");
 }
 
 /* Find the corresponding entry in the right TLB
@@ -286,7 +284,7 @@ static int copy_utlb_entry_itlb(CPUSH4State *env, int utlb)
     itlb = itlb_replacement(env);
     ientry = &env->itlb[itlb];
     if (ientry->v) {
-        tlb_flush_page(CPU(sh_env_get_cpu(env)), ientry->vpn << 10);
+        tlb_flush_page(env_cpu(env), ientry->vpn << 10);
     }
     *ientry = env->utlb[utlb];
     update_itlb_use(env, itlb);
@@ -448,14 +446,14 @@ hwaddr superh_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
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
@@ -478,7 +476,7 @@ void cpu_load_tlb(CPUSH4State * env)
         entry->size = 1024 * 1024; /* 1M */
         break;
     default:
-        cpu_abort(CPU(cpu), "Unhandled load_tlb");
+        cpu_abort(cs, "Unhandled load_tlb");
         break;
     }
     entry->sh   = (uint8_t)cpu_ptel_sh(env->ptel);
@@ -505,7 +503,7 @@ void cpu_load_tlb(CPUSH4State * env)
         entry->v = 0;
     }
 
-    tlb_flush(CPU(sh_env_get_cpu(s)));
+    tlb_flush(env_cpu(s));
 }
 
 uint32_t cpu_sh4_read_mmaped_itlb_addr(CPUSH4State *s,
@@ -531,7 +529,7 @@ void cpu_sh4_write_mmaped_itlb_addr(CPUSH4State *s, hwaddr addr,
     if (entry->v) {
         /* Overwriting valid entry in itlb. */
         target_ulong address = entry->vpn << 10;
-        tlb_flush_page(CPU(sh_env_get_cpu(s)), address);
+        tlb_flush_page(env_cpu(s), address);
     }
     entry->asid = asid;
     entry->vpn = vpn;
@@ -573,7 +571,7 @@ void cpu_sh4_write_mmaped_itlb_data(CPUSH4State *s, hwaddr addr,
         if (entry->v) {
             /* Overwriting valid entry in utlb. */
             target_ulong address = entry->vpn << 10;
-            tlb_flush_page(CPU(sh_env_get_cpu(s)), address);
+            tlb_flush_page(env_cpu(s), address);
         }
         entry->ppn = (mem_value & 0x1ffffc00) >> 10;
         entry->v   = (mem_value & 0x00000100) >> 8;
@@ -626,7 +624,7 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
             if (entry->vpn == vpn
                 && (!use_asid || entry->asid == asid || entry->sh)) {
 	        if (utlb_match_entry) {
-                    CPUState *cs = CPU(sh_env_get_cpu(s));
+                    CPUState *cs = env_cpu(s);
 
 		    /* Multiple TLB Exception */
                     cs->exception_index = 0x140;
@@ -658,13 +656,13 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
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
@@ -719,7 +717,7 @@ void cpu_sh4_write_mmaped_utlb_data(CPUSH4State *s, hwaddr addr,
         if (entry->v) {
             /* Overwriting valid entry in utlb. */
             target_ulong address = entry->vpn << 10;
-            tlb_flush_page(CPU(sh_env_get_cpu(s)), address);
+            tlb_flush_page(env_cpu(s), address);
         }
         entry->ppn = (mem_value & 0x1ffffc00) >> 10;
         entry->v   = (mem_value & 0x00000100) >> 8;
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 932aa7a7c7..14c3db0f48 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -46,10 +46,7 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
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
@@ -58,7 +55,7 @@ void helper_ldtlb(CPUSH4State *env)
 static inline void QEMU_NORETURN raise_exception(CPUSH4State *env, int index,
                                                  uintptr_t retaddr)
 {
-    CPUState *cs = CPU(sh_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = index;
     cpu_loop_exit_restore(cs, retaddr);
@@ -91,7 +88,7 @@ void helper_debug(CPUSH4State *env)
 
 void helper_sleep(CPUSH4State *env)
 {
-    CPUState *cs = CPU(sh_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->halted = 1;
     env->in_sleep = 1;
-- 
2.17.1


