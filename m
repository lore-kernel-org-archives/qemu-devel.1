Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61084C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16E024724
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RLMvOGp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16E024724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmtY-0006RD-VU
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=563b96974=alistair.francis@wdc.com>)
 id 1kXmpk-0001ng-8B; Wed, 28 Oct 2020 10:53:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=563b96974=alistair.francis@wdc.com>)
 id 1kXmpi-00036U-Bv; Wed, 28 Oct 2020 10:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603896830; x=1635432830;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1d/Pc82dQ4fgFa8gXxhoCsb7iNK2pBewRrK+00Mlt+o=;
 b=RLMvOGp+QbaxJqy+/5jyp4XU5iC/cTtS4kXNP4R+5YlUN+LmYHYoAZOy
 sXe66Vh2AKZhBZXEeOW0+nFeqwey5ujtQKPfphRv5niFEqHOZZGTURZDS
 Dt4Q4OavxZ+QYU/f282oNpQ3Efr7x73r5e+tgTPBaKjj9X7OYBTK++Z9W
 qOYUbcOBGONqd1GDpR8AXv2P/vxH2uWdrxbxaAtpfX9N+Y7d9mNWcytYP
 FAOcEeUpbj0SltaxtK8muI6kkoDGnAe/8IQeBcBLf91qbHGrvYEoAdsbc
 qlqC6saybPSUmixC0OA3NiZJDjqgENXJxaUAP4PCpNeYhRCV0mujiqkaW Q==;
IronPort-SDR: Y7Abz3bGNl4wgbLgtaodAF0oJNSzakfY7nBPHDiZBWvZRotCmXKiXPr7yA814QXhcVcNyMBBn8
 jWUbwBh1omUaDzEXUzMswZtETOi4NAGZ0JhHz0KG7jCVIBHiB8jvZJqF8Y0NnXAmQaA+oWY1TF
 scrv0LMxdlbJbc6oBR6gUrS8qBzAgCnLN7ubGfd0RsBE0/QaBjmR3QdR4DJMbLReCebCGgXXcY
 MkY9lBG1J0/zbncV2DJaNBwzH8faenfucLloDQhDFi/P9TGR9kKQmQ63UVk8cGuLQnkWHEuTgX
 fFM=
X-IronPort-AV: E=Sophos;i="5.77,426,1596470400"; d="scan'208";a="151200379"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2020 22:53:48 +0800
IronPort-SDR: YjVpCiR/xMkcwzDB45HPiOd316SuKqF22VwXfuXxI1Ly48SXpqXWk5Jm+9do/fgeo91BEWun0s
 Cb0aUsO5gpd4Tu/fYOC3gfBtfLmqghiHGeMif8DJnJ0z7HyFWdsl+fM2RKOu5p35/q31atPP2o
 qbLtNbqKmarEp369dmrQOksXYtBbQulZJLv9N7QmVZB2ZiH2mT+oQbOOkTGODaZ2dthc+NdB6C
 5+SQRNg2YzEXrQbIRSCynSapiMZrP/oTqiy4cm+RHTjzfGTcRTBRAEoQTi/BVYz0Bc5rP1nHYX
 L1F8GnCXxn8WPcTy9vWkrT7v
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2020 07:38:58 -0700
IronPort-SDR: zzoOC2sZNKh9S/ZA3v3cgCTF6zN0aIqRqydjTLlcGjXnGQRYuxp0pPQkn/a4f4x3nSZHfhDrrw
 Dh4Sr3sZGkhDhi5iomAq+h1RsMAU3e/6OLKbcMrIPOkVqLHqHzX/wiw+YrO8wIHTtY6OqnuUMY
 a0BaQVDwS4tqs1Ah1YZNjFYpzIuMOnXBFjpHT9qp1VuATcmkO0U6fs+t+92ZHBKvgYMT3B2wjf
 5iEbUO+gLQFPym/he3xm1XflWCrLO2DTostM03jjtq+kTM9F0J2IRQqX0wDa3Eo9XECFWBkYgj
 q1w=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 Oct 2020 07:53:48 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 2/5] target/riscv: Set the virtualised MMU mode when doing
 hyp accesses
Date: Wed, 28 Oct 2020 07:42:23 -0700
Message-Id: <3f5666c9eb72758011c14a660de99ba86a0b6561.1603896075.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603896075.git.alistair.francis@wdc.com>
References: <cover.1603896075.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=563b96974=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 10:53:43
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


