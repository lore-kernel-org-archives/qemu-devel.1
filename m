Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5F2C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702332151B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b7mLm4e8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702332151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8wP-0006aB-8s
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8rw-0001TZ-IJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8rt-0005fQ-Ry
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981533; x=1635517533;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WumyfNifo14aIzDni7I+UXZHpnoesgywH8qDEDipM30=;
 b=b7mLm4e8XNAWHdjVd1jVt3NcBBtD4vwtSqrZ8hmZhQQsSBnZ4BUXeg2v
 SSC0kTF/kBkVb9eQ+0bwkG0E1q6/5vO2XlL30u4ZKKk7IupziFDuYZ7zZ
 QIeAbPaleVBJkcFoK3O/Hjipal1lqvTy8EPJyql4wa3+MP6gFvBHRy2r8
 U5cYxYBxAP7B68DXAUV/r0NuHHbbylMTPksemXntvXQb9rl2GIbuIPfQT
 D1BakGLoUzGrAMsXxO5b5EBy1cG27I4288V89ZeAQfj5ayyXIEBWY7eQZ
 0pRtGE2eA3bcPgyWbJFCvtLhvJm5kxAmVTMMiWYNfgwTJr+S9LPlG0fZQ g==;
IronPort-SDR: dM+tg5vRs0YQ+qj1SDHBxjF6BtR0TqoIn7dI7pQty2hEnCPRjpfAXNw0QTn1ZrlZduq9jqqLU5
 /lGN5bIVYWgk8h0tEouHw0KOE8hsMvV4QDxodDX+TnxXFnFQImD2R+auMVRCtaGbwoWLSk2Ksr
 hMpRTMwR3IEBAhnHAXpwDZRnFCLd0Z0s0GwwFLNQ5fhoIvGlLbUe6+QOzaMcgS1eaAipDhKqe7
 zrYh9Ew1RJ7Q3TcVildSdzScTkwNZTeA+pQUP4a2juesoZ0LGayqrEIc856kn0Mi8aeo3ERRYP
 fmk=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317877"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:27 +0800
IronPort-SDR: F6jjAsPV+XgCRyqyX8jZbeQvWaLfqsSBrEvvZgYCLWK7S1i0gwWpPSkku4hwWXe/fpM/PTZsss
 d6rfyETsRIpXQKQZ0UxtLgfGCS7u5aRTDrw2Bq/iXe0AxMSSCZ5A87jLCnZrQuKv81vlwCThDe
 x9NBGHJSvKijCQLkgNq1Hr9QOC7jJjx2ft+Kx/NEsIRFGZv8VKIhCcWOyYgOvxkdrtUQWhys9g
 9L24FySQMm/iqOxtrn6uuneeur3g0KS6ng8xO4S6Csj1s42Za1jul+fB0GA11b4uGXHuWq9paU
 XajxBDuqdHsw4RJqG9GTGiC9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:42 -0700
IronPort-SDR: HHidruOI0hv9YSRm0Ikg0EWCVjJYen50P3OVVRJ9ARHmg4d9vxjeV2ugWq7fwPLFXFuA6ZlKba
 m0T2iSH2g/8owRmbFCZm7ksDL7OvK2wPmLIZ40STb1oltmmBqcTivjYw5Nwv1dTGKfH8RW+1La
 EambCRZKUHfkSg/x4ooobb5PU/FCucKePy5enfF4GI2Xf/m7W5P0N3NuXQqmsp1S2E8jBD5nRi
 kUBEvZB7NV3z7pYABMolS/Y7tHC7rK/dcYILLHiMVEXim/kre3E5H7o6sjUi6jjqDOUDcwGItk
 h/U=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 05/18] target/riscv: Add PMP state description
Date: Thu, 29 Oct 2020 07:13:45 -0700
Message-Id: <20201029141358.3102636-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029141358.3102636-1-alistair.francis@wdc.com>
References: <20201029141358.3102636-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=56447669b=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 10:25:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Yifei Jiang <jiangyifei@huawei.com>, Yipeng Yin <yinyipeng1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yifei Jiang <jiangyifei@huawei.com>

In the case of supporting PMP feature, add PMP state description
to vmstate_riscv_cpu.

'vmstate_pmp_addr' and 'num_rules' could be regenerated by
pmp_update_rule(). But there exists the problem of updating
num_rules repeatedly in pmp_update_rule(). So here extracts
pmp_update_rule_addr() and pmp_update_rule_nums() to update
'vmstate_pmp_addr' and 'num_rules' respectively.

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201026115530.304-4-jiangyifei@huawei.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.h     |  2 ++
 target/riscv/machine.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 target/riscv/pmp.c     | 29 ++++++++++++++----------
 3 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 6a8f072871..6c6b4c9bef 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -62,5 +62,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
     target_ulong size, pmp_priv_t priv, target_ulong mode);
 bool pmp_is_range_in_tlb(CPURISCVState *env, hwaddr tlb_sa,
                          target_ulong *tlb_size);
+void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
+void pmp_update_rule_nums(CPURISCVState *env);
 
 #endif
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 32edbcba7c..fc1461d88e 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -22,6 +22,52 @@
 #include "sysemu/kvm.h"
 #include "migration/cpu.h"
 
+static bool pmp_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    return riscv_feature(env, RISCV_FEATURE_PMP);
+}
+
+static int pmp_post_load(void *opaque, int version_id)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+    int i;
+
+    for (i = 0; i < MAX_RISCV_PMPS; i++) {
+        pmp_update_rule_addr(env, i);
+    }
+    pmp_update_rule_nums(env);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_pmp_entry = {
+    .name = "cpu/pmp/entry",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL(addr_reg, pmp_entry_t),
+        VMSTATE_UINT8(cfg_reg, pmp_entry_t),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_pmp = {
+    .name = "cpu/pmp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pmp_needed,
+    .post_load = pmp_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(env.pmp_state.pmp, RISCVCPU, MAX_RISCV_PMPS,
+                             0, vmstate_pmp_entry, pmp_entry_t),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 1,
@@ -70,5 +116,9 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.timecmp, RISCVCPU),
 
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_pmp,
+        NULL
     }
 };
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index c394e867f8..2eda8e1e2f 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -136,18 +136,8 @@ static void pmp_decode_napot(target_ulong a, target_ulong *sa, target_ulong *ea)
     }
 }
 
-
-/* Convert cfg/addr reg values here into simple 'sa' --> start address and 'ea'
- *   end address values.
- *   This function is called relatively infrequently whereas the check that
- *   an address is within a pmp rule is called often, so optimise that one
- */
-static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index)
+void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
 {
-    int i;
-
-    env->pmp_state.num_rules = 0;
-
     uint8_t this_cfg = env->pmp_state.pmp[pmp_index].cfg_reg;
     target_ulong this_addr = env->pmp_state.pmp[pmp_index].addr_reg;
     target_ulong prev_addr = 0u;
@@ -186,7 +176,13 @@ static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index)
 
     env->pmp_state.addr[pmp_index].sa = sa;
     env->pmp_state.addr[pmp_index].ea = ea;
+}
 
+void pmp_update_rule_nums(CPURISCVState *env)
+{
+    int i;
+
+    env->pmp_state.num_rules = 0;
     for (i = 0; i < MAX_RISCV_PMPS; i++) {
         const uint8_t a_field =
             pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
@@ -196,6 +192,17 @@ static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index)
     }
 }
 
+/* Convert cfg/addr reg values here into simple 'sa' --> start address and 'ea'
+ *   end address values.
+ *   This function is called relatively infrequently whereas the check that
+ *   an address is within a pmp rule is called often, so optimise that one
+ */
+static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index)
+{
+    pmp_update_rule_addr(env, pmp_index);
+    pmp_update_rule_nums(env);
+}
+
 static int pmp_is_in_range(CPURISCVState *env, int pmp_index, target_ulong addr)
 {
     int result = 0;
-- 
2.28.0


