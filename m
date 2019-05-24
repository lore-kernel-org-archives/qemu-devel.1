Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFA1C282E5
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1BA2075E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GYqgeWDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1BA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKC7-00047G-HE
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:05:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK3v-0005Im-S7
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJvC-0004ge-2S
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:48:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJvB-0004TN-KH; Fri, 24 May 2019 19:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741701; x=1590277701;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=1niGW1xkrBRvkE6jNbzSdU/IeNxx4fzoQPYH72mo2jw=;
	b=GYqgeWDb+D1YpvItnZ9z/9dl63qQIwcpbzjbUHGsWA98RnfQvTNDlF5c
	TbrNm0ZcvEzU7B0mLUu1s2VpwaMIq3epiAqDwTRIOTvVnt/3gxODGVRkt
	kWn6BjO8OUOOmmQFaW+4IULaevMP5GXcysC9y2d05MGug7GIZkpoRITsa
	/Bs+PN2LERBl8VPO0CnFW9EH0KtX9jsUGOqZ+6p+b1IJSuCPU/NfET3oJ
	6/wVVCCvRa7ZMp+44+8ntadAKvwrhmSn3gCwbL8SZiVuISfSl2hEtSQWv
	l6tg07yuRwqZ4wARgXVkqzmr0vKuS9DVxoTLTIoW0T7qgPWp33cXG12wR A==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="215265029"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:48:20 +0800
IronPort-SDR: PtIixPhO4IIK7/hbdOHunBsQvC9uL15C5OVVh9DevItcIKdpWH1EYtX+MyOVNxensSaWrKnVb8
	NZlnX5MUNoCbd/8CzOf9xk79A11PX/8/aYI2RSUJIBmVdgHnPTawdqlbVkVxZ/wcy47zVKgFjl
	Vwr8HUDlEC/hWA4re45A7IzZaQ6e5a6bYC5sozLaFuanhYpzduaNSrMVnDUH6EGGyZcW8EdZ+Z
	lhx89kdexxOYYRz41hYO6k9pJTpBIcVegnvJIZ3IYYSA4AXTCWC2k7vyEs6OsjwoXSC1zJprTs
	cjESy47auCQLNTB5gzkYrD87
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:25:59 -0700
IronPort-SDR: lVeF+/ne3JCf0KvUWYVPo76Va572axInMxtY+/zLAJoo5llMdR55cVgZas5M48S/45R1iBlmxF
	LWhp7WJZSaSDYfcRdB3mgvYjYRoJKYNQFOB9jsxO8TUwQj/htlcr8pxonK1jD0UB5/iVM149nV
	CsFsAx/sMFJaNM8EpazdPx7QKw+OncwTr9o+n2/zz6iafWRmxv3n3ej8nSdZiUgdGHiGLjCzSA
	m87d7g1bASRdx8oHPzVYhmDA7CwzB7vQRArblkxie/EJKwK6cQV/bn9LqIsNPMRs1/L3ZIW4LP
	5Lc=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2019 16:48:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:46:25 -0700
Message-Id: <fe19aa421f344e938b50ce2bc56827e7aa8d8151.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [RFC v1 19/23] target/riscv: Allow specifying MMU stage
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b7e47b97f5..3c963d26bc 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -261,10 +261,19 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
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
@@ -455,12 +464,20 @@ restart:
 }
 
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
-                                MMUAccessType access_type)
+                                MMUAccessType access_type, bool first_stage)
 {
     CPUState *cs = CPU(riscv_env_get_cpu(env));
-    int page_fault_exceptions =
-        (env->priv_ver >= PRIV_VERSION_1_10_0) &&
-        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE;
+    int page_fault_exceptions;
+    if (first_stage) {
+        page_fault_exceptions =
+            (env->priv_ver >= PRIV_VERSION_1_10_0) &&
+            get_field(env->satp, SATP_MODE) != VM_1_10_MBARE;
+            riscv_cpu_set_force_hs_excep(env, CLEAR_HS_EXCEP);
+    } else {
+        page_fault_exceptions =
+            get_field(env->hgatp, HGATP_MODE) != VM_1_10_MBARE;
+            riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
+    }
     switch (access_type) {
     case MMU_INST_FETCH:
         cs->exception_index = page_fault_exceptions ?
@@ -487,7 +504,8 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
-    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx)) {
+    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
+                             true)) {
         return -1;
     }
     return phys_addr;
@@ -547,7 +565,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
+    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
+                               true);
 
     qemu_log_mask(CPU_LOG_MMU,
                   "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
@@ -564,7 +583,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
-        raise_mmu_exception(env, address, access_type);
+        raise_mmu_exception(env, address, access_type, true);
         riscv_raise_exception(env, cs->exception_index, retaddr);
     }
 #else
-- 
2.21.0


