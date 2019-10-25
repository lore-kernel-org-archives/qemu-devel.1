Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71A7CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9035421D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IHnP1hBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9035421D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO9CN-0003fi-6r
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91J-0005R9-RP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91I-0004fM-CH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:25 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91I-0004Yx-2H; Fri, 25 Oct 2019 19:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046164; x=1603582164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i8VVKNCleTNXc1sJm+bTXzJRq92Hz7ibezM65PfGzFQ=;
 b=IHnP1hBlLbJ1pKoEc+P+iY34CwA93x5pc07S1qwIFtZwOoTsRDGrKGdK
 VUhNEjAZGMynSzahU5gJve/S3kaRdtI3gmLJcz2t+pAIzQaw9NOBzKwhw
 BHAINcyLJ9FNR1UYhytAOkm+x4WVq2LrBKyMUFlTpkNIVG78kypGalz9J
 zXOZL7ELcmLWZ8oJTkHRlBQWMIoLFZIMzMN0UX7xOM7j5IaJvtemkj9QL
 J5QMT9XsZLvT5zSGLut/tuBr+ziskbiJ1BbTn4BDf/jxHWaeVZFxhNrpQ
 KBrG3uaXCM8QpKovz17r6FwK/BJ3/e0s6hzTFK28HeTUWhtVhahXm+Ood A==;
IronPort-SDR: 5qXar3GzXyBZ3QBMTecNz1enKM4XiQDNA2GhDZlr109yNot1bTgnNiG14hu41u0liuYkYauZfl
 r0xm1TCPRLKBa2qdgEAGhPU15SYSWsQFTeuJa+LVzowDAgqKKZWnIzNca17RASiwzkGDMclBb9
 8tL9JUOVqw7nR5IYi6HuUBa0c4u9EtGzebhad/bVo1/FuueP5Vvz6PGdoPvOP7l56taP4SV+TG
 DzZM9FXztHjMAR4uqvwtYgAN4X1Gbai83VVD7JBT0unl+o9cXf6IsK/++NbEEMxydbsOnyL1N8
 SPU=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="122956699"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:29:23 +0800
IronPort-SDR: W1nXGwwOpjWflXq5s4w06nxfSRRu36dYwthe0OKOUzc+XkzkdTTqOiRTT93aLJFYn452cYqpJX
 /4cQ7I8I5Srra5IFZZQWy1FLa/3lykqzVeEQw+OThJqmiQjxOqExXUS7NnGw6rbimaQ+B8SGnJ
 cBVt9ok4VmYgwKIgNsDW9nFRTUbFcrmSHVOI6giS89oMnzeApdsGqg62Zv1P7O+FnvW5lFgdhP
 X1S67lUaGHQknQWHSmdWdCX/NKRWwNLJqHFI04SrtYYDLt033MT69vpQDRk3BzqFJikWZthPHw
 WopEXM4heIC133/B//MwOhYx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:49 -0700
IronPort-SDR: FlTUyhGSx3cZUpthD0F/iI1FQMa4Zf/4Qlie90JrKlTQnmH62BpsiGoRU3Bky/MyJkwK6wp5C8
 +v0S6Ol/eGJ+PEKtT7NoS0sdNQjUpIXqckQhBjrV0h4iqdcCFNJGjX3Inmnjp9xuNUAiWOG2EV
 8SDzY/TnsMh0RPUqFq7dpeMAa6beTvF2UEGNoSoj1FoAPYTTFcT2dYBawpVtnveGxxR7wcGZBW
 Xe/87xPraQ5pklyHyd3rEr1DTmlsWYqzDfz2RZXD7Gga+YqJxUVheHsrgze+lYik1oJdbmV2qt
 1m8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:29:24 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 23/27] target/riscv: Allow specifying MMU stage
Date: Fri, 25 Oct 2019 16:24:28 -0700
Message-Id: <472e51aff01eddec5ebc7e5550738caf2800b631.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 79966ac6e6..275b6c2a67 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -296,10 +296,19 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
  *
  * Adapted from Spike's mmu_t::translate and mmu_t::walk
  *
+ * @env: CPURISCVState
+ * @physical: This will be set to the calculated physical address
+ * @prot: The returned protection attributes
+ * @addr: The virtual address to be translated
+ * @access_type: The type of MMU access
+ * @mmu_idx: Indicates current privilege level
+ * @first_stage: Are we in first stage translation?
+ *               Second stage is used for hypervisor guest translation
  */
 static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 int *prot, target_ulong addr,
-                                int access_type, int mmu_idx)
+                                int access_type, int mmu_idx,
+                                bool first_stage)
 {
     /* NOTE: the env->pc value visible here will not be
      * correct, but the value visible to the exception handler
@@ -502,13 +511,23 @@ restart:
 }
 
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
-                                MMUAccessType access_type, bool pmp_violation)
+                                MMUAccessType access_type, bool pmp_violation,
+                                bool first_stage)
 {
     CPUState *cs = env_cpu(env);
-    int page_fault_exceptions =
-        (env->priv_ver >= PRIV_VERSION_1_10_0) &&
-        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
-        !pmp_violation;
+    int page_fault_exceptions;
+    if (first_stage) {
+        page_fault_exceptions =
+            (env->priv_ver >= PRIV_VERSION_1_10_0) &&
+            get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
+            !pmp_violation;
+        riscv_cpu_set_force_hs_excep(env, 0);
+    } else {
+        page_fault_exceptions =
+            get_field(env->hgatp, HGATP_MODE) != VM_1_10_MBARE &&
+            !pmp_violation;
+        riscv_cpu_set_force_hs_excep(env, 1);
+    }
     switch (access_type) {
     case MMU_INST_FETCH:
         cs->exception_index = page_fault_exceptions ?
@@ -535,7 +554,8 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
-    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx)) {
+    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
+                             true)) {
         return -1;
     }
     return phys_addr;
@@ -601,7 +621,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
+    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
+                               true);
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(*env->mstatus, MSTATUS_MPRV)) {
@@ -638,7 +659,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
-        raise_mmu_exception(env, address, access_type, pmp_violation);
+        raise_mmu_exception(env, address, access_type, pmp_violation, true);
         riscv_raise_exception(env, cs->exception_index, retaddr);
     }
 #else
-- 
2.23.0


