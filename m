Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EA9C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A15207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sxn+H8Db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A15207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZN1G-0003Pl-IZ
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48299)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsu-00052v-B2
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMss-0002V9-NY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsr-0002G5-O8; Fri, 07 Jun 2019 17:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944730; x=1591480730;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GAd8Pdkdd2gP60Ox3n38qL1ErxsbarXMnIrxQl5gUAo=;
 b=Sxn+H8DbK5b6b9/vOhDlXF1uNKITOcI1Fv6JSQRR3B+NqSgVpa9DEyQR
 DR5PTmlN/5lhs86lc+0km0uuo4CKJc97MaDXCdQXnPeMHKmsQ3yso3M77
 5lY8xC8JxN0Oan2kwVFPhRt04qggUEWmKB+DBXut5BW11RH3BRqH09Q6Q
 fUpzw8+br2phvyP1z3IcT5c+Jw/LSfzFu61RvX9jnjFTVwXU7nUsP1CHz
 Ssy1cuy1+7OrfDJ88HoMtr5YiJYnSn6MGSsEmYS71m2NpRksAk9TcKImD
 oKQ3XU0oN4xkx3l4SHWTk0X1DNOBuLP193Jh5gxjZvzm4yEOSjADHWsV3 w==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="110059661"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:42 +0800
IronPort-SDR: a8+Y8jD9xQnOAYrunHc0MJ9KdwcZLAKquJ0EmgaKgL6o/0yJD58rfZ51W7+zn2smGTIBNnVYIf
 Um8igXwNpq3Pg3WCAzK0BF8zDGK1NEebjC50Y3VjHYqQ+930B5X25QgyihNU5DU7RYFvZR6Ez3
 hyLwwXL+MTsNtyEZxGtZykTHpmH1ECFucaucKxbTzlq14vUjzHGuiR6FsnuEC4wOA5FSR1dKty
 jo93q8rmjHm5BJo+V6F1rMlZ9S87ypiMQLwriwcyRYCun0eMK//NfE8fb/r8uo3+ZHGJvu1Jq2
 An2RAG6qHkg0lqdllSp6QiLR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:35:58 -0700
IronPort-SDR: iM3ptF/s0Jc2AkEpN0lekt7COzbg5/88I79/6yarEaPTYS2IrAZ9edi5SJCQt7KSIQ3wvSCK8V
 s2ezfkz4d54Joz8KBT3aiNlgEXPWA7/jhhS7MDMbrJ4tCLqFZcdKvlBQcqH9WVQ+cQXifus93d
 HER+hxZyOjbmytEQikEy8pZ40iAU7543W4mDncYmNqy2TsuSb2n9CkYpTfXc2DXDW7fXRh4GDh
 uQsT5mS669qQlQlOpa7AyRcUHo7cXjuCZ9lqPEW9NbhHNHLFTykY9iKjyUIKsHHZZ847X12wkP
 Esc=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:58:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:32 -0700
Message-Id: <e81fa46ccf6fc243e86046ba8fa7b6cdaf21bcd6.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v1 23/27] target/riscv: Allow specifying MMU
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b009049cc4..6cef78a2c7 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -274,10 +274,19 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
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
@@ -468,12 +477,20 @@ restart:
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
@@ -500,7 +517,8 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
-    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx)) {
+    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
+                             true)) {
         return -1;
     }
     return phys_addr;
@@ -560,7 +578,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
+    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
+                               true);
 
     qemu_log_mask(CPU_LOG_MMU,
                   "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
@@ -577,7 +596,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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


