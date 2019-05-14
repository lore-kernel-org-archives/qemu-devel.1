Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7170C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F44520873
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1shyKB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F44520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54240 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQefx-0007dS-QQ
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:09:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeV6-0007lu-8f
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeIU-0007C3-Lr
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:16 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hQeIT-00077c-Qe
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:14 -0400
Received: by mail-lf1-x141.google.com with SMTP id q17so251535lfo.4
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ycNp4Qh4WZ1+j69cmldUs9hpgiZ5r/F5FvZ4/Ss2hCM=;
	b=o1shyKB/PSjAxK/khrCuiBCvnQ+Q07IfIRGdM2I157kuQc/FIqb/GECI+SqOs5i34+
	z6/IjVSpM7V3JIU+F7sbY0ITvbK9VkLI8KLDcmZ4h9ymb/Z+OSn0vVTK4zja9nrIvVE2
	nyQ7uGyuxPwmNB205O6Xpfs6JQJICV5cZgpf+B7f0IN+02V7xulJeV4FDK9sy7lqVoSA
	PLwtt4hUYXyvBF7Ea6FRPp8rNYlPNwMdZKqh7pyobq/zxg2uIlObR0Azibh5zTT0oVSK
	uPG2v+Z6fTI8mqkwPSht+SDm6pyDjMKQk5dzrRLdgWAPVZnNwKq7oYgXLgnXW/fpR6NF
	8F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ycNp4Qh4WZ1+j69cmldUs9hpgiZ5r/F5FvZ4/Ss2hCM=;
	b=H31CpmbUe+2LHrWR+eZ15B0dQq50j54JJClH3u1OW6T32FCO229n59vPacDCqzNeu7
	Lry7jBpFTQw6tVkdCGuJNWCJAfmgzEkP1kwjem+CtkCfLprDF2RtoPMwQd5K9NJPpS0E
	TyFSY/jiPl2Tg+DHZJK6sa7AN2o6a9p4wdxu5ZGdyDxfrullBHPlgqoYS1xk/315jyhC
	6/9CBSrE32RWN5TPeweI/htxAU6tXYgyKKWFOIBSG9m9pOGJvrZEJHaFpQSeFZ8ePcwM
	uwAPonkMLzOFE69o+aX9EfG5P7smrv6GK++E9vP+tMVvAghhHDAGFfuf1RmKKoKoEdJv
	9EWQ==
X-Gm-Message-State: APjAAAVquDJx+5U92EdN+DU/MMh59yr00Yx125cfXAWuHMINbAh6cUIw
	ZimF1frsQ78wBLIlzb3PkQ8X8m68F0k=
X-Google-Smtp-Source: APXvYqxJmI6GVxhxlvhdtaFr1cLuhsF4iHzYRBsPb/X0iIV+xbqS7qSzYqLDbFyI7kVbHnq3+xKTsQ==
X-Received: by 2002:a19:5015:: with SMTP id e21mr18606306lfb.62.1557866712257; 
	Tue, 14 May 2019 13:45:12 -0700 (PDT)
Received: from octofox.cadence.com
	(jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
	by smtp.gmail.com with ESMTPSA id 78sm4011lje.81.2019.05.14.13.45.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 13:45:11 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 13:44:40 -0700
Message-Id: <20190514204447.17486-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190514204447.17486-1-jcmvbkbc@gmail.com>
References: <20190514204447.17486-1-jcmvbkbc@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: [Qemu-devel] [PATCH 2/9] target/xtensa: make internal MMU functions
 static
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove declarations of the internal mmu_helper functions from the cpu.h,
make these functions static and shuffle them.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h        |  19 ------
 target/xtensa/mmu_helper.c | 163 ++++++++++++++++++++++++---------------------
 2 files changed, 87 insertions(+), 95 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 539033fccb61..502d41688365 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -658,17 +658,6 @@ static inline int xtensa_get_cring(const CPUXtensaState *env)
 }
 
 #ifndef CONFIG_USER_ONLY
-uint32_t xtensa_tlb_get_addr_mask(const CPUXtensaState *env,
-                                  bool dtlb, uint32_t way);
-void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v, bool dtlb,
-        uint32_t *vpn, uint32_t wi, uint32_t *ei);
-int xtensa_tlb_lookup(const CPUXtensaState *env, uint32_t addr, bool dtlb,
-        uint32_t *pwi, uint32_t *pei, uint8_t *pring);
-void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
-        xtensa_tlb_entry *entry, bool dtlb,
-        unsigned wi, unsigned ei, uint32_t vpn, uint32_t pte);
-void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
-        unsigned wi, unsigned ei, uint32_t vpn, uint32_t pte);
 int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
         uint32_t vaddr, int is_write, int mmu_idx,
         uint32_t *paddr, uint32_t *page_size, unsigned *access);
@@ -679,14 +668,6 @@ static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
 {
     return env->system_er;
 }
-
-static inline xtensa_tlb_entry *xtensa_tlb_get_entry(CPUXtensaState *env,
-        bool dtlb, unsigned wi, unsigned ei)
-{
-    return dtlb ?
-        env->dtlb[wi] + ei :
-        env->itlb[wi] + ei;
-}
 #endif
 
 static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 79a10da2310e..465cfbf61359 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -78,8 +78,8 @@ static uint32_t get_page_size(const CPUXtensaState *env,
 /*!
  * Get bit mask for the virtual address bits translated by the TLB way
  */
-uint32_t xtensa_tlb_get_addr_mask(const CPUXtensaState *env,
-                                  bool dtlb, uint32_t way)
+static uint32_t xtensa_tlb_get_addr_mask(const CPUXtensaState *env,
+                                         bool dtlb, uint32_t way)
 {
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         bool varway56 = dtlb ?
@@ -145,8 +145,9 @@ static uint32_t get_vpn_mask(const CPUXtensaState *env, bool dtlb, uint32_t way)
  * Split virtual address into VPN (with index) and entry index
  * for the given TLB way
  */
-void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v, bool dtlb,
-        uint32_t *vpn, uint32_t wi, uint32_t *ei)
+static void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v,
+                                     bool dtlb, uint32_t *vpn,
+                                     uint32_t wi, uint32_t *ei)
 {
     bool varway56 = dtlb ?
         env->config->dtlb.varway56 :
@@ -213,6 +214,14 @@ static void split_tlb_entry_spec(CPUXtensaState *env, uint32_t v, bool dtlb,
     }
 }
 
+static xtensa_tlb_entry *xtensa_tlb_get_entry(CPUXtensaState *env, bool dtlb,
+                                              unsigned wi, unsigned ei)
+{
+    return dtlb ?
+        env->dtlb[wi] + ei :
+        env->itlb[wi] + ei;
+}
+
 static xtensa_tlb_entry *get_tlb_entry(CPUXtensaState *env,
         uint32_t v, bool dtlb, uint32_t *pwi)
 {
@@ -227,65 +236,10 @@ static xtensa_tlb_entry *get_tlb_entry(CPUXtensaState *env,
     return xtensa_tlb_get_entry(env, dtlb, wi, ei);
 }
 
-uint32_t HELPER(rtlb0)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
-{
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
-        uint32_t wi;
-        const xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
-        return (entry->vaddr & get_vpn_mask(env, dtlb, wi)) | entry->asid;
-    } else {
-        return v & REGION_PAGE_MASK;
-    }
-}
-
-uint32_t HELPER(rtlb1)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
-{
-    const xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, NULL);
-    return entry->paddr | entry->attr;
-}
-
-void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
-{
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
-        uint32_t wi;
-        xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
-        if (entry->variable && entry->asid) {
-            tlb_flush_page(CPU(xtensa_env_get_cpu(env)), entry->vaddr);
-            entry->asid = 0;
-        }
-    }
-}
-
-uint32_t HELPER(ptlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
-{
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
-        uint32_t wi;
-        uint32_t ei;
-        uint8_t ring;
-        int res = xtensa_tlb_lookup(env, v, dtlb, &wi, &ei, &ring);
-
-        switch (res) {
-        case 0:
-            if (ring >= xtensa_get_ring(env)) {
-                return (v & 0xfffff000) | wi | (dtlb ? 0x10 : 0x8);
-            }
-            break;
-
-        case INST_TLB_MULTI_HIT_CAUSE:
-        case LOAD_STORE_TLB_MULTI_HIT_CAUSE:
-            HELPER(exception_cause_vaddr)(env, env->pc, res, v);
-            break;
-        }
-        return 0;
-    } else {
-        return (v & REGION_PAGE_MASK) | 0x1;
-    }
-}
-
-void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
-                              xtensa_tlb_entry *entry, bool dtlb,
-                              unsigned wi, unsigned ei, uint32_t vpn,
-                              uint32_t pte)
+static void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
+                                     xtensa_tlb_entry *entry, bool dtlb,
+                                     unsigned wi, unsigned ei, uint32_t vpn,
+                                     uint32_t pte)
 {
     entry->vaddr = vpn;
     entry->paddr = pte & xtensa_tlb_get_addr_mask(env, dtlb, wi);
@@ -293,8 +247,9 @@ void xtensa_tlb_set_entry_mmu(const CPUXtensaState *env,
     entry->attr = pte & 0xf;
 }
 
-void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
-                          unsigned wi, unsigned ei, uint32_t vpn, uint32_t pte)
+static void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
+                                 unsigned wi, unsigned ei,
+                                 uint32_t vpn, uint32_t pte)
 {
     XtensaCPU *cpu = xtensa_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
@@ -322,15 +277,6 @@ void xtensa_tlb_set_entry(CPUXtensaState *env, bool dtlb,
     }
 }
 
-void HELPER(wtlb)(CPUXtensaState *env, uint32_t p, uint32_t v, uint32_t dtlb)
-{
-    uint32_t vpn;
-    uint32_t wi;
-    uint32_t ei;
-    split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei);
-    xtensa_tlb_set_entry(env, dtlb, wi, ei, vpn, p);
-}
-
 hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
@@ -462,8 +408,9 @@ static unsigned get_ring(const CPUXtensaState *env, uint8_t asid)
  * \param pring: [out] access ring
  * \return 0 if ok, exception cause code otherwise
  */
-int xtensa_tlb_lookup(const CPUXtensaState *env, uint32_t addr, bool dtlb,
-                      uint32_t *pwi, uint32_t *pei, uint8_t *pring)
+static int xtensa_tlb_lookup(const CPUXtensaState *env,
+                             uint32_t addr, bool dtlb,
+                             uint32_t *pwi, uint32_t *pei, uint8_t *pring)
 {
     const xtensa_tlb *tlb = dtlb ?
         &env->config->dtlb : &env->config->itlb;
@@ -495,6 +442,70 @@ int xtensa_tlb_lookup(const CPUXtensaState *env, uint32_t addr, bool dtlb,
         (dtlb ? LOAD_STORE_TLB_MISS_CAUSE : INST_TLB_MISS_CAUSE);
 }
 
+uint32_t HELPER(rtlb0)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
+{
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
+        uint32_t wi;
+        const xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
+        return (entry->vaddr & get_vpn_mask(env, dtlb, wi)) | entry->asid;
+    } else {
+        return v & REGION_PAGE_MASK;
+    }
+}
+
+uint32_t HELPER(rtlb1)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
+{
+    const xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, NULL);
+    return entry->paddr | entry->attr;
+}
+
+void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
+{
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
+        uint32_t wi;
+        xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
+        if (entry->variable && entry->asid) {
+            tlb_flush_page(CPU(xtensa_env_get_cpu(env)), entry->vaddr);
+            entry->asid = 0;
+        }
+    }
+}
+
+uint32_t HELPER(ptlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
+{
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
+        uint32_t wi;
+        uint32_t ei;
+        uint8_t ring;
+        int res = xtensa_tlb_lookup(env, v, dtlb, &wi, &ei, &ring);
+
+        switch (res) {
+        case 0:
+            if (ring >= xtensa_get_ring(env)) {
+                return (v & 0xfffff000) | wi | (dtlb ? 0x10 : 0x8);
+            }
+            break;
+
+        case INST_TLB_MULTI_HIT_CAUSE:
+        case LOAD_STORE_TLB_MULTI_HIT_CAUSE:
+            HELPER(exception_cause_vaddr)(env, env->pc, res, v);
+            break;
+        }
+        return 0;
+    } else {
+        return (v & REGION_PAGE_MASK) | 0x1;
+    }
+}
+
+void HELPER(wtlb)(CPUXtensaState *env, uint32_t p, uint32_t v, uint32_t dtlb)
+{
+    uint32_t vpn;
+    uint32_t wi;
+    uint32_t ei;
+    split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei);
+    xtensa_tlb_set_entry(env, dtlb, wi, ei, vpn, p);
+}
+
 /*!
  * Convert MMU ATTR to PAGE_{READ,WRITE,EXEC} mask.
  * See ISA, 4.6.5.10
-- 
2.11.0


