Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DF3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 09:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5EF20838
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 09:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5EF20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k69lB-0002SQ-Ab
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 05:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <likaige@loongson.cn>)
 id 1k69kI-0000wc-OU
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 05:42:02 -0400
Received: from mail.loongson.cn ([114.242.206.163]:52716 helo=loongson.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <likaige@loongson.cn>) id 1k69kG-0000q4-2q
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 05:42:02 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_9_bCjVfyGQIAA--.154S2;
 Thu, 13 Aug 2020 17:41:47 +0800 (CST)
From: Kaige Li <likaige@loongson.cn>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH 1/2] target/mips: Coding style update to fix checkpatch errors
Date: Thu, 13 Aug 2020 17:41:46 +0800
Message-Id: <1597311707-27565-1-git-send-email-likaige@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx_9_bCjVfyGQIAA--.154S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1DCF1UCw4fuF43Wr4Durg_yoWrtFy5pr
 y7Jw45GF4DJFZIg3y7XrnFvFy5ZFn2gFZ8C3srXF13ta1Uu347ZrsFva4UAFZFqFWkKF15
 Aan29w1YgFyxWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8uwCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
 AIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bwjjkUUUUU=
X-CM-SenderInfo: 5olntxtjh6z05rqj20fqof0/
Received-SPF: pass client-ip=114.242.206.163; envelope-from=likaige@loongson.cn;
 helo=loongson.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 05:41:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will help ensure that style guidelines are being maintained during
subsequent changes.

Signed-off-by: Kaige Li <likaige@loongson.cn>
---
 target/mips/translate_init.inc.c | 61 ++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index 637cacc..0740819 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -53,8 +53,7 @@
 
 /*****************************************************************************/
 /* MIPS CPU definitions */
-const mips_def_t mips_defs[] =
-{
+const mips_def_t mips_defs[] = {
     {
         .name = "4Kc",
         .CP0_PRid = 0x00018000,
@@ -766,8 +765,8 @@ const mips_def_t mips_defs[] =
         .name = "Loongson-2E",
         .CP0_PRid = 0x6302,
         /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
-        .CP0_Config0 = (0x1<<17) | (0x1<<16) | (0x1<<11) | (0x1<<8) |
-                       (0x1<<5) | (0x1<<4) | (0x1<<1),
+        .CP0_Config0 = (0x1 << 17) | (0x1 << 16) | (0x1 << 11) | (0x1 << 8) |
+                       (0x1 << 5) | (0x1 << 4) | (0x1 << 1),
         /* Note: Config1 is only used internally,
            Loongson-2E has only Config0.  */
         .CP0_Config1 = (1 << CP0C1_FP) | (47 << CP0C1_MMU),
@@ -786,8 +785,8 @@ const mips_def_t mips_defs[] =
         .name = "Loongson-2F",
         .CP0_PRid = 0x6303,
         /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
-        .CP0_Config0 = (0x1<<17) | (0x1<<16) | (0x1<<11) | (0x1<<8) |
-                       (0x1<<5) | (0x1<<4) | (0x1<<1),
+        .CP0_Config0 = (0x1 << 17) | (0x1 << 16) | (0x1 << 11) | (0x1 << 8) |
+                       (0x1 << 5) | (0x1 << 4) | (0x1 << 1),
         /* Note: Config1 is only used internally,
            Loongson-2F has only Config0.  */
         .CP0_Config1 = (1 << CP0C1_FP) | (47 << CP0C1_MMU),
@@ -932,19 +931,19 @@ void mips_cpu_list(void)
 }
 
 #ifndef CONFIG_USER_ONLY
-static void no_mmu_init (CPUMIPSState *env, const mips_def_t *def)
+static void no_mmu_init(CPUMIPSState *env, const mips_def_t *def)
 {
     env->tlb->nb_tlb = 1;
     env->tlb->map_address = &no_mmu_map_address;
 }
 
-static void fixed_mmu_init (CPUMIPSState *env, const mips_def_t *def)
+static void fixed_mmu_init(CPUMIPSState *env, const mips_def_t *def)
 {
     env->tlb->nb_tlb = 1;
     env->tlb->map_address = &fixed_mmu_map_address;
 }
 
-static void r4k_mmu_init (CPUMIPSState *env, const mips_def_t *def)
+static void r4k_mmu_init(CPUMIPSState *env, const mips_def_t *def)
 {
     env->tlb->nb_tlb = 1 + ((def->CP0_Config1 >> CP0C1_MMU) & 63);
     env->tlb->map_address = &r4k_map_address;
@@ -956,40 +955,41 @@ static void r4k_mmu_init (CPUMIPSState *env, const mips_def_t *def)
     env->tlb->helper_tlbinvf = r4k_helper_tlbinvf;
 }
 
-static void mmu_init (CPUMIPSState *env, const mips_def_t *def)
+static void mmu_init(CPUMIPSState *env, const mips_def_t *def)
 {
     env->tlb = g_malloc0(sizeof(CPUMIPSTLBContext));
 
     switch (def->mmu_type) {
-        case MMU_TYPE_NONE:
-            no_mmu_init(env, def);
-            break;
-        case MMU_TYPE_R4000:
-            r4k_mmu_init(env, def);
-            break;
-        case MMU_TYPE_FMT:
-            fixed_mmu_init(env, def);
-            break;
-        case MMU_TYPE_R3000:
-        case MMU_TYPE_R6000:
-        case MMU_TYPE_R8000:
-        default:
-            cpu_abort(env_cpu(env), "MMU type not supported\n");
+    case MMU_TYPE_NONE:
+        no_mmu_init(env, def);
+        break;
+    case MMU_TYPE_R4000:
+        r4k_mmu_init(env, def);
+        break;
+    case MMU_TYPE_FMT:
+        fixed_mmu_init(env, def);
+        break;
+    case MMU_TYPE_R3000:
+    case MMU_TYPE_R6000:
+    case MMU_TYPE_R8000:
+    default:
+        cpu_abort(env_cpu(env), "MMU type not supported\n");
     }
 }
 #endif /* CONFIG_USER_ONLY */
 
-static void fpu_init (CPUMIPSState *env, const mips_def_t *def)
+static void fpu_init(CPUMIPSState *env, const mips_def_t *def)
 {
     int i;
 
-    for (i = 0; i < MIPS_FPU_MAX; i++)
+    for (i = 0; i < MIPS_FPU_MAX; i++) {
         env->fpus[i].fcr0 = def->CP1_fcr0;
+    }
 
     memcpy(&env->active_fpu, &env->fpus[0], sizeof(env->active_fpu));
 }
 
-static void mvp_init (CPUMIPSState *env, const mips_def_t *def)
+static void mvp_init(CPUMIPSState *env, const mips_def_t *def)
 {
     env->mvp = g_malloc0(sizeof(CPUMIPSMVPContext));
 
@@ -999,9 +999,10 @@ static void mvp_init (CPUMIPSState *env, const mips_def_t *def)
        implemented, 5 TCs implemented. */
     env->mvp->CP0_MVPConf0 = (1U << CP0MVPC0_M) | (1 << CP0MVPC0_TLBS) |
                              (0 << CP0MVPC0_GS) | (1 << CP0MVPC0_PCP) |
-// TODO: actually do 2 VPEs.
-//                             (1 << CP0MVPC0_TCA) | (0x1 << CP0MVPC0_PVPE) |
-//                             (0x04 << CP0MVPC0_PTC);
+/* TODO: actually do 2 VPEs.
+ *                            (1 << CP0MVPC0_TCA) | (0x1 << CP0MVPC0_PVPE) |
+ *                            (0x04 << CP0MVPC0_PTC);
+ */
                              (1 << CP0MVPC0_TCA) | (0x0 << CP0MVPC0_PVPE) |
                              (0x00 << CP0MVPC0_PTC);
 #if !defined(CONFIG_USER_ONLY)
-- 
2.1.0


