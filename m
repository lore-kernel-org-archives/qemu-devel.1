Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21A5C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E822206BA
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NcO9BieR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E822206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JWK-0004ms-8X
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCP-0001BP-VJ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCO-0000KR-O3
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCO-0000Il-DH; Fri, 23 Aug 2019 19:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603749; x=1598139749;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2K2heKwYI3ZlRTWb1vXPZVntWORWGCN1A7mMqHQXzJ8=;
 b=NcO9BieRwZcYOfNcuxPdbMfDDdLsZ7qCKLOOj1MimjYo/2yhxJ3zGbPf
 S6dqHDOOdPQjbqha64dKQ9nTj4QvDx/XODKCEz694M8pWYgOZ8zmdBhKm
 JeHgh4Tn6Y2rclJ+rIGkImqJJL92gYHkj6iVyo3iWsuf65glEcXpvfgTw
 r1V5lMP7p8Tb12GW+wXAZR0FN+R1FlcRnCfi6FiV3LXUk/2futsAg0f4m
 nbOgakcQLv+0DQLrH0HcuQuSdHyhDh/cSG+VeKartbQQ9+DDSTPNtX6GV
 24KOmsURprUVf+P0YdaL4OptBtEvHIgkCLy9TZwrUmSPMZJ35ivL0aZUG g==;
IronPort-SDR: GJq8Tcu0MFA2en6CJsBOlGv6c9mbWhewOoAh3cVUVqKwtO17+FFYKSm13vCZIwIZXCP0jQHnPJ
 tM3rGITwScYmiOotQ9FONXg46GMdS+LQpjNMQ4ywuXAeWkckjx41OieQoaYN92/kHr3zynljxl
 wMXAa1436Gnu5biorABUmK2UpQQluNzIn52DqaWhi9TIXHUTK8Dxm+IqwTz0j/gOTnjgCrzpu5
 eHNmjffZwSVbl0afHD+cfwzdeoj6eu5SfgBkkl60eY2asYPS9it5jOQDxff8WNAKc5zVzl96yb
 nPc=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117486911"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:29 +0800
IronPort-SDR: 3UPduKeBdVtNLkqRMurCni0PZnHOyAL2UHY4Tn+zBbEQLw4dg/G5LhPtDrtcLrvT9w6YQ0/I1K
 pbP7DmvHhaAexQtRiHxRF/ib4G9OZnygym+4+LnQK7KTHngYATb+Oa7yVRSbpNo0x//FmrzoB7
 u/ZoekblXL6oNDQgxa2D5+C5NpqYP0CqqErAF3Uy53s6UlORJ95OuhUugSbCMRlN56RYuwQR10
 C0fZvPZZXLKf7APEZuxIkUrse0JbCYGX8NuvBkks9lPtamw6tqdGubFUawUWNMPsGfCAgR7vgH
 fbzdhZECIAlB8/x+3HdXWyQm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:45 -0700
IronPort-SDR: GLUIVrpebuDeLf9BzATPTNFU10RmE4mzgmE0bTFP2F345YOrNbKs3XZmhhB02hq0MnPUPZtxyY
 CsqI2AIUk6NnUOMiJx72AgWrBOox1ghMLpkd+cqmWTX9n7jX+yYynGonlnUe/lV5MXlotbQ27d
 3q6lAi+TOboke54+nMT3iQUuOsGH9TcZDB+5rmmPY2d+0Mcq8yDDtaP36nD9ykqQiscFnoERo3
 rBD7ZJidSm4R7RM5doaQw77vwKyQm8Bcw77JKmndn70wxM03KNoq1CCxqQWPgZfSkcFNT7GAMt
 yj4=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:42:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:47 -0700
Message-Id: <4d84c887def558fc178c31e3adc52f1c4b2fb075.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 22/28] target/riscv: Allow specifying MMU
 stage
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 098873c83e..9aa6906acd 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -318,10 +318,19 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
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
@@ -518,13 +527,23 @@ restart:
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
+            riscv_cpu_set_force_hs_excep(env, CLEAR_HS_EXCEP);
+    } else {
+        page_fault_exceptions =
+            get_field(env->hgatp, HGATP_MODE) != VM_1_10_MBARE &&
+            !pmp_violation;
+            riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
+    }
     switch (access_type) {
     case MMU_INST_FETCH:
         cs->exception_index = page_fault_exceptions ?
@@ -551,7 +570,8 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
-    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx)) {
+    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
+                             true)) {
         return -1;
     }
     return phys_addr;
@@ -613,7 +633,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
+    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
+                               true);
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(*env->mstatus, MSTATUS_MPRV)) {
@@ -640,7 +661,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
-        raise_mmu_exception(env, address, access_type, pmp_violation);
+        raise_mmu_exception(env, address, access_type, pmp_violation, true);
         riscv_raise_exception(env, cs->exception_index, retaddr);
     }
 #else
-- 
2.22.0


