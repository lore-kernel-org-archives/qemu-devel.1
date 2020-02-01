Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C16C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05109206F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VqfW1MZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05109206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhOl-0005uG-31
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHy-0003B1-Cr
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHx-0006W1-28
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHw-00069K-Sg; Fri, 31 Jan 2020 20:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519372; x=1612055372;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XTUMfLshUBsHzLWgQM8ZUz58ZNg2IaxcOfwmzS1hMkM=;
 b=VqfW1MZIPdsq25pD0PV7nE501IQVTWU863n31/2aMyA3ymAks2bwKsVP
 idg6gNJqqypK4VY0EtImH4bLgPuxb4M8RTvBCdvuPwrPRM9//L6lNlC/G
 0GH5d3rV2EECrRlPifXBm6WphmHdQU+G3AuF70HmFAd/aGX6zXTbVHaHq
 qeTnl8acrTi1JcxDFURs+SSeMgOVY6HrUWWM+Eont4ASXhD21JD3C0Z/I
 ozoC2ccmLVqief244QDIYNUjP4SnYU0jCzXXOnH98admCpQI2GOsjlbcv
 vLyVvDB2GD+k4iMf56yUzQzDwWGdVpeNj0J4+caXdPVumryh+FW483OhB Q==;
IronPort-SDR: Bm98mWxqg7kvLkcAffMvTym0s1IiOTBLJSFMApkygg5IENIEYYge+sDekAjqojJyjOIqIWcc5c
 dmGzdh4N8aMv8Te8M+B6K30+whUgK9GMwhdd7KbaWCTPQ8MViiAFMquXrFC5eZmb6D0gHvWr7r
 hWVfWLsrnGwvh+mKFPldf9fGshi+RtEEWPfviNr9kMobeGdn3V38+KH9/AYqP9YCr/o058n7al
 YlrwlmLm2wPuc9E6tpj2hkUCIeQnJ5FxExOxb6jad/6SKvZE/19qqNk1/ttxF9Vcbf5G/ysEMo
 /RU=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872477"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:09:07 +0800
IronPort-SDR: elhqgZMfbxl7zb4vN/6DugwmN7Ptlj58TBNBps5WMXJ32Da7wqvBwPSEQfJruppL439xZ9tmLZ
 CPOwLrl6277Hq1RL44h7kdiTdGFSzbiXlNX++lFHkkTBWnJbN4uFQ9fjYgpJp8CI0eN61hILh7
 nGbjL/u85BW9F8BtCvwNvzYEOgIiEd802RDZl1iG3rTm6krtHCnef7DdSlzOVJiMdoOCz29KbR
 6TU0S8zDY6k29GjAhTKK1u/c6NQO//QTds58z/gl9dQnOCl/A9j9NeoPzMnFfWPU/OFZln6uoy
 k88Y8oRe7cC55WkxYQiqvvFX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:02:16 -0800
IronPort-SDR: 4TD4fNLVQytuxwAnn7bItSiP13szMhyuSG9LjStgLJ/KkVpaYpLCD7KFnTXQnSqpcLiu3Z0vu5
 MTuvNGKZoPIezrvzkAzoFxytIIfuTaKNIEP2GXz+LyYKM0DBcxtB4Kuj9x43FZKse1nPp9FHKC
 EUl3LdBXSgwrKm3ZoeS8UHa52lMJ4NF1Q+3N23zkupRr2Pcf0MGFQiMd1pLSWVB3K66nVs9ERH
 5IjIhP112/mKxcaVKhLCocMjBCFFwVO31raK42lGFTIwHoQdGgHpbsUXI1BIB3L/1Wh1UX+cJH
 3go=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:09:07 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 21/35] target/riscv: Add hypvervisor trap support
Date: Fri, 31 Jan 2020 17:02:30 -0800
Message-Id: <7ee4badbb4dfc33ab2e75151b69559f09d733575.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 69 +++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 98017df33b..e7728cb0ca 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -639,6 +639,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    bool force_hs_execp = riscv_cpu_force_hs_excep_enabled(env);
+    target_ulong s;
 
     /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
      * so we mask off the MSB and separate into trap type and cause.
@@ -648,19 +650,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong deleg = async ? env->mideleg : env->medeleg;
     target_ulong tval = 0;
 
-    static const int ecall_cause_map[] = {
-        [PRV_U] = RISCV_EXCP_U_ECALL,
-        [PRV_S] = RISCV_EXCP_S_ECALL,
-        [PRV_H] = RISCV_EXCP_VS_ECALL,
-        [PRV_M] = RISCV_EXCP_M_ECALL
-    };
-
     if (!async) {
         /* set tval to badaddr for traps with address information */
         switch (cause) {
         case RISCV_EXCP_INST_GUEST_PAGE_FAULT:
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
         case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
+            force_hs_execp = true;
+            /* fallthrough */
         case RISCV_EXCP_INST_ADDR_MIS:
         case RISCV_EXCP_INST_ACCESS_FAULT:
         case RISCV_EXCP_LOAD_ADDR_MIS:
@@ -678,7 +675,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         /* ecall is dispatched as one cause so translate based on mode */
         if (cause == RISCV_EXCP_U_ECALL) {
             assert(env->priv <= 3);
-            cause = ecall_cause_map[env->priv];
+
+            if (env->priv == PRV_M) {
+                cause = RISCV_EXCP_M_ECALL;
+            } else if (env->priv == PRV_S && riscv_cpu_virt_enabled(env)) {
+                cause = RISCV_EXCP_VS_ECALL;
+            } else if (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) {
+                cause = RISCV_EXCP_S_ECALL;
+            } else if (env->priv == PRV_U) {
+                cause = RISCV_EXCP_U_ECALL;
+            }
         }
     }
 
@@ -688,7 +694,36 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (env->priv <= PRV_S &&
             cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
         /* handle the trap in S-mode */
-        target_ulong s = env->mstatus;
+        if (riscv_has_ext(env, RVH)) {
+            target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
+
+            if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
+                !force_hs_execp) {
+                /* Trap to VS mode */
+            } else if (riscv_cpu_virt_enabled(env)) {
+                /* Trap into HS mode, from virt */
+                riscv_cpu_swap_hypervisor_regs(env);
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
+                                         get_field(env->hstatus, HSTATUS_SPV));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                                         get_field(env->mstatus, SSTATUS_SPP));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
+                                         riscv_cpu_virt_enabled(env));
+
+                riscv_cpu_set_virt_enabled(env, 0);
+                riscv_cpu_set_force_hs_excep(env, 0);
+            } else {
+                /* Trap into HS mode */
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
+                                         get_field(env->hstatus, HSTATUS_SPV));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                                         get_field(env->mstatus, SSTATUS_SPP));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
+                                         riscv_cpu_virt_enabled(env));
+            }
+        }
+
+        s = env->mstatus;
         s = set_field(s, MSTATUS_SPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_SPP, env->priv);
@@ -702,7 +737,21 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_S);
     } else {
         /* handle the trap in M-mode */
-        target_ulong s = env->mstatus;
+        if (riscv_has_ext(env, RVH)) {
+            if (riscv_cpu_virt_enabled(env)) {
+                riscv_cpu_swap_hypervisor_regs(env);
+            }
+            env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
+                                      riscv_cpu_virt_enabled(env));
+            env->mstatus = set_field(env->mstatus, MSTATUS_MTL,
+                                      riscv_cpu_force_hs_excep_enabled(env));
+
+            /* Trapping to M mode, virt is disabled */
+            riscv_cpu_set_virt_enabled(env, 0);
+            riscv_cpu_set_force_hs_excep(env, 0);
+        }
+
+        s = env->mstatus;
         s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_MPP, env->priv);
-- 
2.25.0


