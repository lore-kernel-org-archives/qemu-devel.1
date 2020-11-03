Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1838BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532BB206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a/SalIDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532BB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2Zl-0001Yx-74
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Vo-0004zQ-FU; Tue, 03 Nov 2020 15:02:36 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Vm-0002nO-37; Tue, 03 Nov 2020 15:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604433754; x=1635969754;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0cnh9t+t9g0YgjdwBXPqSgwt7Z2fQx44mGqfUiJG5h4=;
 b=a/SalIDmWturPm9cYy+yVYa0fQ/nBgAdrQ31bplVrxwyrnVm92+TRLye
 579i3eY6X3ttUem0KPGOqSWwMhoh7mVc1uvQoLfOFIrotIZjWvyWsdxey
 ynbPgE2UHsP+wHETkkxFoZJg9gduj+MZ+TbGmDJUDcck37CjuzPx7rl1K
 NLM6ExSM8C8K9Q8LPUXGXT1yctaQl9If6aq+BWEFHwZoxRYbHHY1TtY7R
 NHdIdQ2+8HcFR/Lv8+8I4QBaSFYRi8pDrrgAt4N0jnswOXml6uk7M35tI
 lmAfDjKUZwC26rphJXUaX9Dd38sDd3PIYJbbXYGxqyU9HP3GYApU0XFRZ g==;
IronPort-SDR: 5tvkVO2EJhGJhP8jaeoeHm2YyGUKHCLHI/cxUEdkjiteR2WuB7dkDOGtD7vz95prOHwPm734Tf
 hUwxlKuYxtUHQX9G2VLPTnfpNDcaRa7MZ/XyxXwVNLyKo63crMzQNuib/rYrArpKudT8DYvso3
 DbjMDtG93g2n8fq4cP9YU1lF3PZnI/0cj6OGMOLe2eRT1yCmHaOHujGXEheiMaDKpmnwGRvD3g
 n1iamKrJVQtWKSIy0fT6d3hOygTizoCTylKjrAqWR2S37FiTIvQnTIyf/5u+u8aJFYnr5mcY22
 hbY=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="261670825"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 04:02:31 +0800
IronPort-SDR: S4HKhBcskZRzzP80NEGvyGvoYJp9otVaaL6vVKBknh4bTxOa9U54atUJqAU/eiBYMjf6AqTU/3
 XgwxZG9rbkZTdUOKvtJmq6opNNFFjdVU3ZXV2vorzJAKiweqGAyRQLuHD5kdcW3mYZzotSLcxI
 O9NY5eZe26nDvGMY4DijX/2RE6XqNUO3JmknvnB4RooMCrWAiZ+SRfR1AlYNoDeCFXty6jsWMj
 tvzAfJT17nQ+Lxx83VuObNWGgAi6xgNva5flw96eolM/Ob7a58qMHU4Ff/EfR/RSY1Z/XtOsfA
 9SBaMzbwA+WO8dAqTX++17+K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 11:48:40 -0800
IronPort-SDR: Nyi9iiHlz4Vtm003REV15Tx6SwiBHDvtuq8XR7LLQ8JkPrU3UFCkLmcsaRyTDc3D4oHCPaJCTw
 NpNP0gIGfe/PYCzVkH/1cfP0Hj4Y7HtHQNOVeE/JuiyHxfQ064bzihNltx6FlzzmeU7PNVhamF
 VvFLcD9Bmm2IaCPBlAjEa37QKymovHnUxhJE97d6Ni1Nq92px4GtQF+jjZCtgPw65/KlMR6OmS
 Z1Gb/4wMqAjroj6wEhUA9UwchVtIFj9Oidevc3z02IfklwuO4Qxcd+Bfsl9iVnLYPcX9EFf/vq
 UCQ=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Nov 2020 12:02:32 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 3/7] target/riscv: Set the virtualised MMU mode when doing
 hyp accesses
Date: Tue,  3 Nov 2020 11:51:01 -0800
Message-Id: <f966e2a73db6b7a7c929225dcee15a5df100c613.1604432950.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604432950.git.alistair.francis@wdc.com>
References: <cover.1604432950.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 15:02:31
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Cc: richard.henderson@linaro.org, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When performing the hypervisor load/store operations set the MMU mode to
indicate that we are virtualised.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/op_helper.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index e20d56dcb8..548c5851ec 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -235,30 +235,31 @@ target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
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
@@ -284,23 +285,25 @@ void helper_hyp_store(CPURISCVState *env, target_ulong address,
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
@@ -326,15 +329,16 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
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


