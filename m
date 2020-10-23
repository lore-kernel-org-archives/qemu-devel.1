Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD6CC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211A82192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GmXd243U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211A82192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzlU-0004r5-3z
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVz8E-0000DB-QA; Fri, 23 Oct 2020 11:37:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVz8B-0002qB-91; Fri, 23 Oct 2020 11:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467447; x=1635003447;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fVH3yJDP92d88/TMEtwm9Tro9Lrx+BKom1+AbX5QU0M=;
 b=GmXd243UmzX0hqNbE7AZ5Ck7GW9c5fRoUXZToNuMW+9TSgYcO9JODPJ9
 L/il8n9JS8jTBfNzpzj4J36gLepLnLjt/xtvKqkIZvPHVvAEHz3atGjwF
 ilIH21pZWoA99YIrv3iysZ68dZ8NmWthVksn3NC7vPsdznxzjBvWQQZ57
 3mr76bUFUm2NCQWhcIgzPv6vSMKr/GGEZAzr81OjVsl172U7QqPgQnkcg
 wzcJmF0r19Oikbexsq2qE8IZqK0/BsPdH2Ipz2+uJkwMh6+RBxP48gvFg
 GNEMPZEseKv1FO9eCo2L9+0vE/laT4eCjgJl3VqJe2Npzs9F5TZkpzMNl A==;
IronPort-SDR: TsuN3FRp4U5yUqhODmYsdpOPJjEyrBOFF60GFeC/M6hx9F/Tdj3pi58UReFrbRkkAi+1NPzpjr
 duVwVKQntBVj1b7Xaxe12uGleyuFOjt+8cGyz83hUVJx9UIYOaF1ad5yH0bkkhxTotBY7Tsyyp
 P+0Q+dlEaytKSSD6aEtLuqLFwgxlQzSnse96XD33zeFqoBhIU9VJC+mRG3uCzl5FiZwIg0BYYI
 6KFvuQ+C9ni3EnUZWyFXOLTMXQ+1c7s5Q19nTV1mpeCNrf4uoX4Aszkz45HdKwx8FVV1saQyXh
 S7E=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="260636267"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:37:25 +0800
IronPort-SDR: O2TJtcsEFgMqe2MiGM483JCJAJdmbJiuXwYvEuDQLMJBfsQ/KOwDEaOK41ciAvcW78eem3ofwD
 nLvfda7++X4haHYKnuDuP9ZPdtMO6tezoU3aVakQ0grhfAnmgepWVZ7CNt+x00H8Negd0evJsr
 pa0rkgrX0FLT4as5+jBWo18uHmkiPOC20ktpU+MosSNIP6d9nc4GkrMkV55N9yq953kU0FBEIE
 b2Y2+htCDZbZp9W3DByclV3o7Q6QN2Pi7XShF4nIlMO6KDcE5imbr4Al6yb7dLumSdwEOv6YoU
 345u4NkSd8qxDP3TQgFdYZMp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:23:47 -0700
IronPort-SDR: cpqGxKW/3+r2CxmWPPe3kYRJA3cr/k29NtTTmNApX1pRwOxHaz55Ooo++LRGO3eFozc1qHUr1Q
 ziP+AWSq7PA8/JKFs38+5Jz+fYxbNSkW3lkUkCedkPWsJUg7uHP3MTM+C25a2Dk4bwXYQwgT/G
 DsE5BZyL5DTfOvPVZS99qy7qI7IqDqiMxwNqYko1VJUWHE9Fim3AzFU1eIPjivgoKzdlNvgbaH
 L3Wd2Qm6GouAT9rHexAtjB6AVBKGiVxIC+Cpj9SHOBYEqdAIkB+oVWL0ObPI0ck31rdiXjF3it
 Ro0=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:37:25 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 2/5] target/riscv: Set the virtualised MMU mode when doing
 hyp accesses
Date: Fri, 23 Oct 2020 08:26:04 -0700
Message-Id: <0231a2792b6653c9399d91a6605874b001641a02.1603466725.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603466725.git.alistair.francis@wdc.com>
References: <cover.1603466725.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:37:20
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
Cc: alistair.francis@wdc.com, richard.henderson@linaro.org, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When performing the hypervisor load/store operations set the MMU mode to
indicate that we are virtualised.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 4ce73575a7..bc6df6c8c9 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -238,30 +238,31 @@ target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
         (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
             get_field(env->hstatus, HSTATUS_HU))) {
         target_ulong pte;
+        int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
         riscv_cpu_set_two_stage_lookup(env, true);
 
         switch (memop) {
         case MO_SB:
-            pte = cpu_ldsb_data_ra(env, address, GETPC());
+            pte = cpu_ldsb_mmuidx_ra(env, address, mmu_idx, GETPC());
             break;
         case MO_UB:
-            pte = cpu_ldub_data_ra(env, address, GETPC());
+            pte = cpu_ldub_mmuidx_ra(env, address, mmu_idx, GETPC());
             break;
         case MO_TESW:
-            pte = cpu_ldsw_data_ra(env, address, GETPC());
+            pte = cpu_ldsw_mmuidx_ra(env, address, mmu_idx, GETPC());
             break;
         case MO_TEUW:
-            pte = cpu_lduw_data_ra(env, address, GETPC());
+            pte = cpu_lduw_mmuidx_ra(env, address, mmu_idx, GETPC());
             break;
         case MO_TESL:
-            pte = cpu_ldl_data_ra(env, address, GETPC());
+            pte = cpu_ldl_mmuidx_ra(env, address, mmu_idx, GETPC());
             break;
         case MO_TEUL:
-            pte = cpu_ldl_data_ra(env, address, GETPC());
+            pte = cpu_ldl_mmuidx_ra(env, address, mmu_idx, GETPC());
             break;
         case MO_TEQ:
-            pte = cpu_ldq_data_ra(env, address, GETPC());
+            pte = cpu_ldq_mmuidx_ra(env, address, mmu_idx, GETPC());
             break;
         default:
             g_assert_not_reached();
@@ -287,23 +288,25 @@ void helper_hyp_store(CPURISCVState *env, target_ulong address,
         (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
         (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
             get_field(env->hstatus, HSTATUS_HU))) {
+        int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
+
         riscv_cpu_set_two_stage_lookup(env, true);
 
         switch (memop) {
         case MO_SB:
         case MO_UB:
-            cpu_stb_data_ra(env, address, val, GETPC());
+            cpu_stb_mmuidx_ra(env, address, val, mmu_idx, GETPC());
             break;
         case MO_TESW:
         case MO_TEUW:
-            cpu_stw_data_ra(env, address, val, GETPC());
+            cpu_stw_mmuidx_ra(env, address, val, mmu_idx, GETPC());
             break;
         case MO_TESL:
         case MO_TEUL:
-            cpu_stl_data_ra(env, address, val, GETPC());
+            cpu_stl_mmuidx_ra(env, address, val, mmu_idx, GETPC());
             break;
         case MO_TEQ:
-            cpu_stq_data_ra(env, address, val, GETPC());
+            cpu_stq_mmuidx_ra(env, address, val, mmu_idx, GETPC());
             break;
         default:
             g_assert_not_reached();
@@ -329,15 +332,16 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
         (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
             get_field(env->hstatus, HSTATUS_HU))) {
         target_ulong pte;
+        int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
         riscv_cpu_set_two_stage_lookup(env, true);
 
         switch (memop) {
         case MO_TEUW:
-            pte = cpu_lduw_data_ra(env, address, GETPC());
+            pte = cpu_lduw_mmuidx_ra(env, address, mmu_idx, GETPC());
             break;
         case MO_TEUL:
-            pte = cpu_ldl_data_ra(env, address, GETPC());
+            pte = cpu_ldl_mmuidx_ra(env, address, mmu_idx, GETPC());
             break;
         default:
             g_assert_not_reached();
-- 
2.28.0


