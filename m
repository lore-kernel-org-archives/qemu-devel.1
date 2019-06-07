Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259F5C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74F1207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EEyQZ8Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74F1207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZN4Y-0006GX-5b
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47629)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrt-00041v-AB
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrr-0001fx-SN
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrr-0001SY-Fu; Fri, 07 Jun 2019 17:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944668; x=1591480668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xw65e62SJqBKkrt6W+qEPmpcUgZUUv62LCp3vTlHgCc=;
 b=EEyQZ8Or0gqnH0C+NTLsRcsPei3K7CYM5pXxE9ZrzRXTGLSIxYXtBqKs
 SHdWh5wb9KE5YdZVG85A4i65cRXRJdOJi6BOcUlMXka8OPJap8bIwREfo
 u7N7s6iZcWuwqqeF5JWVfaoZbFYx3YxODDoKcGj8HfsA8mt59Yd5e7qE2
 8V72FUXxk+jCW05bMqAFuUpvPJYTiBdE/hAaF6Behz+VRhpL45Kr6Qr8E
 mLwuCDdiSwCWz5X4+cD8V9PnG5LwwfV/Ejwg8XrLiErXfPwZO8ejI2kWl
 VO7I4d6S7CAcCyuAON86XVax4zNlhEPmTvb+ildm9QwUdvELZdX8t4BXO A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="115014080"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:57:41 +0800
IronPort-SDR: vbC/Bmr+JfbzIw7eASB7EZZZXPIUwXNo4mlim1vCpCeX0A5OGU1bU0Rqa9MrquMYaKHRsjb3Tw
 4HK2NyDKkLVqjSjbvs+hEeh/3GHg/0SmJjpG0/vdixZvgDoUi/dMB8o7tHyIqjZjuEE3tkq3Db
 32utE1kEj1x/xsVnv49aaRVHAJ5s2z4ZRBni4rdD6A+7tW7fFXvdw1IVVMVLoOnrlsQnx1aqWc
 fuBpe8G0QTvw5okIKA3rH24ZqZrDClMB1bzdcr/3296fGcABxLPxR9u/oOFglF1eWU2/34k12w
 LnaAv01PzQgOdTOiAcj6cfqV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:34:56 -0700
IronPort-SDR: Rt9VUjhzogtRFg22S2MiM/vY0dePbOsWuCnRDEEenWX9gBzBwgxSchXyrOKfQUOaY5wrSy1zDd
 c7bGSQ0RCiyD+RjxET7DZZOq7feZX+mySroLeruwfa00toAUIMyPtdDn/7pNqkv1ivLjvcahrz
 SQ3h7+8ytRuPKa6cZhs28SGwCteZPVN/EPbVQf8vuUK48m+OMG3/+YGO6b9lRAA+nwReIoTNMp
 Qz77xYqf6aTpmu2FKDJNkdJrBRrPStZA+LysVNvRIXcVrtHBvWh0gmBJSHSJK+S001LAhsAkmN
 0EE=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:57:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:55:30 -0700
Message-Id: <c1b55ffb0659f835254e71ec28165d86ed69a91d.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 04/27] target/riscv: Add the force HS
 exception mode
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
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_bits.h   |  6 ++++++
 target/riscv/cpu_helper.c | 23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de4843b879..eeb3756c91 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -282,6 +282,8 @@ int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
+bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
+void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 07c95e8d2c..c898bb1102 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -423,6 +423,12 @@
 #define VIRT_MODE_SHIFT     0
 #define VIRT_MODE_MASK      (1 << VIRT_MODE_SHIFT)
 
+/* HS-level exceptions modes */
+#define CLEAR_HS_EXCEP        0
+#define FORCE_HS_EXCEP        1
+#define FORCE_HS_EXCEP_SHIFT  1
+#define FORCE_HS_EXCEP_MASK   (1 << FORCE_HS_EXCEP_SHIFT)
+
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
 #define SATP32_ASID         0x7fc00000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 5912ae63b7..0fdc81f71f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -94,6 +94,29 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
     env->virt |= enable << VIRT_MODE_SHIFT;
 }
 
+bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env)
+{
+    bool tmp;
+
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    tmp = (env->virt & FORCE_HS_EXCEP_MASK) >> FORCE_HS_EXCEP_SHIFT;
+
+    return tmp == FORCE_HS_EXCEP;
+}
+
+void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt &= ~FORCE_HS_EXCEP_MASK;
+    env->virt |= enable << FORCE_HS_EXCEP_SHIFT;
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.21.0


