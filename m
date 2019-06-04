Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E47BC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8512075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdTDWCxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8512075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57860 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGRq-0000oa-Bw
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:54:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8W-0001CN-Tg
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8V-0004Il-MI
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:24 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8V-0004IH-HN
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:23 -0400
Received: by mail-oi1-x243.google.com with SMTP id t76so1580574oih.4
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=1kOvtkiHCUjgMw+1Z+kL1S4IV3z9pyM77bVL+IO/D5Y=;
	b=bdTDWCxtSqUpS+kyfe3TeH3lAbfUVkcPRvUG2YsYteUy2L4WkzD7KZKUfAs8ioQnpx
	xDm7KIkLdQR5kdbWJVyorLt10TS+cLgdoNNLJEyuKFOBvCnW2zKQ0prCuTpgT+/6HWla
	VzXp/T6lX686GWn736949LGtdaWd+dZvg4xukX9c/ul7kcY6kFVAGFU0C0NgcXAA0FXp
	9XvzhrfTuk+IRpWhbFV9cN7K7aK55nQv1M/RizzBlHigqmZoYO2Zcu2KtFf1qIWAoh0f
	hlkNUQRbZlRCE4qcJ3+nopUKa7BDhnXJSynS0Rkkmbi3GRPA8VlpeRxziOIiSXd0LHmY
	hZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=1kOvtkiHCUjgMw+1Z+kL1S4IV3z9pyM77bVL+IO/D5Y=;
	b=nNstdii8n/mBv8+k0lHoJZwm4swLbTFNrrsMI0O7NNU7KWnNaxF686O65Wrr+nTild
	sN3S0Au3j75lN2+IaxvRP4VPCRd0plpYEADqhN+24YHhWTSUnCTphAunUilK42o0wtoI
	SeWgdIwZFtPZp5v9r+dRclE1vO8053cQXij8bFbkg7iWKoFE/EqRYVgPEoLD1LOsH8WC
	D5NF8y36XxVW7LFmDp/EVeR59Kbd7mkS3UjbUQbgP8Ic3HES1253r579uwbXha0u5JLL
	9+x7nnnAvqqQLj6gmPXdZ3FB9ojcUL2AYp3w3O+eEkmUNccQyynwy5+0X81UQPX1wssG
	u2Iw==
X-Gm-Message-State: APjAAAVV3mDaI5d9j8G4DoaC5LMSaEWCCbxMDm56ekyJN5Jhw/HDCT+e
	o7NL6uJ2OJVaBFZILoubnB2pDbPsrJJqbw==
X-Google-Smtp-Source: APXvYqxWszT5UGsqqoXCbbf08VS1w6ZWxoaf7kBSPujNrbxeLd8cyPCSafWWLxoy+H5UixvwrJVA/Q==
X-Received: by 2002:aca:f183:: with SMTP id p125mr5626484oih.13.1559680462440; 
	Tue, 04 Jun 2019 13:34:22 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.21
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:29 -0500
Message-Id: <20190604203351.27778-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: [Qemu-devel] [PATCH v4 17/39] target/microblaze: Use env_cpu,
 env_archcpu
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

Cleanup in the boilerplate that each target must define.
Replace mb_env_get_cpu with env_archcpu.  The combination
CPU(mb_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Move cpu_mmu_index below the include of "exec/cpu-all.h",
so that the definition of env_archcpu is available.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h          | 35 ++++++++++++++------------------
 linux-user/microblaze/cpu_loop.c |  2 +-
 target/microblaze/mmu.c          |  5 ++---
 target/microblaze/op_helper.c    |  2 +-
 target/microblaze/translate.c    |  2 +-
 5 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 6e68e00e1f..8402cc81f6 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -310,11 +310,6 @@ struct MicroBlazeCPU {
     CPUMBState env;
 };
 
-static inline MicroBlazeCPU *mb_env_get_cpu(CPUMBState *env)
-{
-    return container_of(env, MicroBlazeCPU, env);
-}
-
 #define ENV_OFFSET offsetof(MicroBlazeCPU, env)
 
 void mb_cpu_do_interrupt(CPUState *cs);
@@ -344,21 +339,6 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 #define MMU_USER_IDX    2
 /* See NB_MMU_MODES further up the file.  */
 
-static inline int cpu_mmu_index (CPUMBState *env, bool ifetch)
-{
-    MicroBlazeCPU *cpu = mb_env_get_cpu(env);
-
-    /* Are we in nommu mode?.  */
-    if (!(env->sregs[SR_MSR] & MSR_VM) || !cpu->cfg.use_mmu) {
-        return MMU_NOMMU_IDX;
-    }
-
-    if (env->sregs[SR_MSR] & MSR_UM) {
-        return MMU_USER_IDX;
-    }
-    return MMU_KERNEL_IDX;
-}
-
 bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
                      bool probe, uintptr_t retaddr);
@@ -384,4 +364,19 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                MemTxResult response, uintptr_t retaddr);
 #endif
 
+static inline int cpu_mmu_index(CPUMBState *env, bool ifetch)
+{
+    MicroBlazeCPU *cpu = env_archcpu(env);
+
+    /* Are we in nommu mode?.  */
+    if (!(env->sregs[SR_MSR] & MSR_VM) || !cpu->cfg.use_mmu) {
+        return MMU_NOMMU_IDX;
+    }
+
+    if (env->sregs[SR_MSR] & MSR_UM) {
+        return MMU_USER_IDX;
+    }
+    return MMU_KERNEL_IDX;
+}
+
 #endif
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 076bdb9a61..a6ea71401d 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -23,7 +23,7 @@
 
 void cpu_loop(CPUMBState *env)
 {
-    CPUState *cs = CPU(mb_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr, ret;
     target_siginfo_t info;
     
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index fcf86b12d5..6763421ba2 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -34,7 +34,7 @@ static unsigned int tlb_decode_size(unsigned int f)
 
 static void mmu_flush_idx(CPUMBState *env, unsigned int idx)
 {
-    CPUState *cs = CPU(mb_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     struct microblaze_mmu *mmu = &env->mmu;
     unsigned int tlb_size;
     uint32_t tlb_tag, end, t;
@@ -228,7 +228,6 @@ uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
 
 void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
 {
-    MicroBlazeCPU *cpu = mb_env_get_cpu(env);
     uint64_t tmp64;
     unsigned int i;
     qemu_log_mask(CPU_LOG_MMU,
@@ -269,7 +268,7 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
             /* Changes to the zone protection reg flush the QEMU TLB.
                Fortunately, these are very uncommon.  */
             if (v != env->mmu.regs[rn]) {
-                tlb_flush(CPU(cpu));
+                tlb_flush(env_cpu(env));
             }
             env->mmu.regs[rn] = v;
             break;
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index b5dbb90d05..18677ddfca 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -65,7 +65,7 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
 
 void helper_raise_exception(CPUMBState *env, uint32_t index)
 {
-    CPUState *cs = CPU(mb_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = index;
     cpu_loop_exit(cs);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 885fc44b51..9ce65f3bcf 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1604,7 +1604,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPUMBState *env = cs->env_ptr;
-    MicroBlazeCPU *cpu = mb_env_get_cpu(env);
+    MicroBlazeCPU *cpu = env_archcpu(env);
     uint32_t pc_start;
     struct DisasContext ctx;
     struct DisasContext *dc = &ctx;
-- 
2.17.1


