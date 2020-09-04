Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F393C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9235820684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aw/A0G7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9235820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEH85-0006Un-Ie
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH4w-0001KD-49
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:08:54 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:38860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH4t-0000mZ-Vp
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:08:53 -0400
Received: by mail-pf1-x42e.google.com with SMTP id d22so5118485pfn.5
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pQLFSNBwse1S0ZFhx1luL29ASl3tpDoWjIQpSs5jL3c=;
 b=Aw/A0G7pdf4YniAcrRI8iobI8PHXFw9OHRQCO4YBKmLjCiGYC/Sl5RuYf+J9E63hiK
 02+es9Winyuo87hUVoEHVWUxYCNv83pENaqPCkgLz9GcDV7hJlHK8o82UNndiVTIzxHQ
 ODCV/XTh+6qMS5zKLWJeGN5xaeh3zpwTFfPLTAp7tRZZZ0HC3Gpg18HmeZh2sfOFWutM
 bymep+eb4LHSywm122nvvFrYNjDyEgBvPXrgbOXnu4+2hMQCCydt7v1YJQM5PZTz9YqM
 VynLm6UW4CWyeAQtG8BARFCoFQboCkfuzjEHa2Szugq6grnqYfWMN10kn3PE76FYyvWo
 OeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pQLFSNBwse1S0ZFhx1luL29ASl3tpDoWjIQpSs5jL3c=;
 b=Js0eglVUZxbRyR6N3DBfM7n1X/qptSWw7khYY4/iMKHiU6R5GeOr8jihkFO9XX/ItC
 Ab5pEfZhPWSpR64CsmOODIUY2Hfrc646SLvOaB2hWgOngdIIBwoOlGIPwGlL32nNwA+d
 Jae4lUoX1jFmffyjLUO2tg2GDhwHhEUG1MGE9Gz9UjnKTin3mYJeRl8z97P1aru/Nz0G
 xXtn5Z71vF+9m2YEUVcb3OUmClvB4EUTpIpKNRAoOBJiAqcWt8dG2FPplcn231CxRPXZ
 MTo1xegNUUpeC1hArt7b20DfDvSZOqK1w/tcOCyU0LLqLWeGsDvJUTa1+c6ubrrvAfe8
 +MYA==
X-Gm-Message-State: AOAM5332iRaamWpwrCqwmyf+LFbusMarz+CCxLQhWOufXAiwZfjXMzfV
 SWEfygfRH5Ib+I1q4jOTOi7AJxsbs67GsQ==
X-Google-Smtp-Source: ABdhPJwp5VYRzzoSRsdyntGi40+zGFl6Q9DPEYxCbsGe6Zs7670WSk9kejyKD6xZPpd0k5mkuAYNMQ==
X-Received: by 2002:a63:4e41:: with SMTP id o1mr8304212pgl.205.1599246530199; 
 Fri, 04 Sep 2020 12:08:50 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:08:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/19] target/microblaze: Rename mmu structs
Date: Fri,  4 Sep 2020 12:08:27 -0700
Message-Id: <20200904190842.2282109-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
Cc: edgar.iglesias@xilinx.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce typedefs and follow CODING_STYLE for naming.
Rename struct microblaze_mmu to MicroBlazeMMU.
Rename struct microblaze_mmu_lookup to MicroBlazeMMULookup.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h    |  2 +-
 target/microblaze/mmu.h    | 15 ++++++---------
 target/microblaze/helper.c |  4 ++--
 target/microblaze/mmu.c    | 11 +++++------
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 32811f773d..20c2979396 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -278,7 +278,7 @@ struct CPUMBState {
 
 #if !defined(CONFIG_USER_ONLY)
     /* Unified MMU.  */
-    struct microblaze_mmu mmu;
+    MicroBlazeMMU mmu;
 #endif
 
     /* Fields up to this point are cleared by a CPU reset */
diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 75e5301c79..c1feb811b9 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -63,8 +63,7 @@
 
 #define TLB_ENTRIES    64
 
-struct microblaze_mmu
-{
+typedef struct {
     /* Data and tag brams.  */
     uint64_t rams[2][TLB_ENTRIES];
     /* We keep a separate ram for the tids to avoid the 48 bit tag width.  */
@@ -76,10 +75,9 @@ struct microblaze_mmu
     int c_mmu_tlb_access;
     int c_mmu_zones;
     uint64_t c_addr_mask; /* Mask to apply to physical addresses.  */
-};
+} MicroBlazeMMU;
 
-struct microblaze_mmu_lookup
-{
+typedef struct {
     uint32_t paddr;
     uint32_t vaddr;
     unsigned int size;
@@ -88,13 +86,12 @@ struct microblaze_mmu_lookup
     enum {
         ERR_PROT, ERR_MISS, ERR_HIT
     } err;
-};
+} MicroBlazeMMULookup;
 
-unsigned int mmu_translate(struct microblaze_mmu *mmu,
-                           struct microblaze_mmu_lookup *lu,
+unsigned int mmu_translate(MicroBlazeMMU *mmu, MicroBlazeMMULookup *lu,
                            target_ulong vaddr, int rw, int mmu_idx);
 uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
 void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
-void mmu_init(struct microblaze_mmu *mmu);
+void mmu_init(MicroBlazeMMU *mmu);
 
 #endif
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 27a24bb99a..3c2fd388fb 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -52,7 +52,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
-    struct microblaze_mmu_lookup lu;
+    MicroBlazeMMULookup lu;
     unsigned int hit;
     int prot;
 
@@ -235,7 +235,7 @@ hwaddr mb_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
     target_ulong vaddr, paddr = 0;
-    struct microblaze_mmu_lookup lu;
+    MicroBlazeMMULookup lu;
     int mmu_idx = cpu_mmu_index(env, false);
     unsigned int hit;
 
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 6e583d78d9..0546cfd0bc 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -35,7 +35,7 @@ static unsigned int tlb_decode_size(unsigned int f)
 static void mmu_flush_idx(CPUMBState *env, unsigned int idx)
 {
     CPUState *cs = env_cpu(env);
-    struct microblaze_mmu *mmu = &env->mmu;
+    MicroBlazeMMU *mmu = &env->mmu;
     unsigned int tlb_size;
     uint32_t tlb_tag, end, t;
 
@@ -55,7 +55,7 @@ static void mmu_flush_idx(CPUMBState *env, unsigned int idx)
 
 static void mmu_change_pid(CPUMBState *env, unsigned int newpid) 
 {
-    struct microblaze_mmu *mmu = &env->mmu;
+    MicroBlazeMMU *mmu = &env->mmu;
     unsigned int i;
     uint32_t t;
 
@@ -73,8 +73,7 @@ static void mmu_change_pid(CPUMBState *env, unsigned int newpid)
 }
 
 /* rw - 0 = read, 1 = write, 2 = fetch.  */
-unsigned int mmu_translate(struct microblaze_mmu *mmu,
-                           struct microblaze_mmu_lookup *lu,
+unsigned int mmu_translate(MicroBlazeMMU *mmu, MicroBlazeMMULookup *lu,
                            target_ulong vaddr, int rw, int mmu_idx)
 {
     unsigned int i, hit = 0;
@@ -290,7 +289,7 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
             break;
         case MMU_R_TLBSX:
         {
-            struct microblaze_mmu_lookup lu;
+            MicroBlazeMMULookup lu;
             int hit;
 
             if (env->mmu.c_mmu_tlb_access <= 1) {
@@ -314,7 +313,7 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
    }
 }
 
-void mmu_init(struct microblaze_mmu *mmu)
+void mmu_init(MicroBlazeMMU *mmu)
 {
     int i;
     for (i = 0; i < ARRAY_SIZE(mmu->regs); i++) {
-- 
2.25.1


