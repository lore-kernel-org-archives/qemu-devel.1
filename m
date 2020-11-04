Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758F0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7EA20BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LBgzK4NM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7EA20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaB7f-0005Ym-Py
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=57073d1dd=alistair.francis@wdc.com>)
 id 1kaAp5-00048B-1s; Tue, 03 Nov 2020 23:55:03 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=57073d1dd=alistair.francis@wdc.com>)
 id 1kaAp2-0005k1-Lc; Tue, 03 Nov 2020 23:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604465700; x=1636001700;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0cnh9t+t9g0YgjdwBXPqSgwt7Z2fQx44mGqfUiJG5h4=;
 b=LBgzK4NMj61/Mrrlc54etyPUyZ9T5YH0Be5H+sDoRStVhwqeGec1rxGy
 hTWXfY08BrbQtxQIXJusUwNcVUGEEp/XJaL3FZbvvlwE5pz4wr00U5aJ2
 YoG7zaRvOeSNxditNeugkpiAg3ChlGbh29p6S3hMjqhTprIepZ4SyAlxG
 3WljHPXPhxBK2aL5aKj9smkgbcXAl1RdVXONM3Zc07T4rR3zK3PoireZN
 796yyK+diiH6rjOZoeA4pQM9hyl8MAJ3MMuRo8ULjAQ+FyzeK+v46QAI3
 pG7HqxDE1h0lKXylS3vrfkXvM4d4ijBKAlbx/gsqvI7RWoFA2RqoZirMS g==;
IronPort-SDR: eiaPOCjCAivFnCOlz483Sbn4q4yHIMhg2Xiv7mDWCfLewDuaNJA+r5DnCuVcUpEzKJpwtsh00S
 YeDMuPV4MXD7WcJPimlIuo1pwjD3HdmUPGOoyV4I0rCzTvResWWcafDljOR+4DwhfQszdLLd3f
 F9qN6nHyyFUa2eEf1dO9YYecJO45YnR8ITJjZ2rpftpcbJnF+cP5Eisz6gMMumEv4R/E9DCM0q
 s+FJTzuSzYmn66DLc+yBOsDWc6HccQgiLDSwN9e5Ez4njOMdkZDQQ+wjr7ler9VhZLYE+hfbMt
 ZZw=
X-IronPort-AV: E=Sophos;i="5.77,449,1596470400"; d="scan'208";a="151656930"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 12:54:57 +0800
IronPort-SDR: zxU5t4CJ2It1i320/2VAHK97/k9/+a07ol9lJIbJfv9dFDKhayE1AHGUYA6gww65GrwnWw7V7a
 BMQtzmTToeOq3rG6/pRnDJb8hbXDcEFm6LRaiPmLepDKGrsOUb/cAPoTT1LFH34W0N/SyUkDjf
 h11mX+M1sLBQ0jubCMVppU15ru+jj2Ap89uFBxBU5vRSMioAhy1syZzk0Xf0QDdZUKhm+rJAZD
 M1uNmiFIPG6BfrqNWY0mlCsrACLgMF9Rk6qmRS+GiU4yTsFMzXhY0PAz+SyDf6hFMBUMJO/IRS
 x+Q7eyo2XndUQ8AJ/DxoggGv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 20:39:55 -0800
IronPort-SDR: NkRqUrVR00i4zen0TVFblCluK3P433CpMjAj+Q45c8EFfvZoILllI2JOXT76+iz6BAHdbOhR4p
 Fy9ynpOT2SGeyUfHQ62HyxPeu2RGcrRfEf7yRBcqAXUO58NzEvHz/1rQJixBdlM9VN7mihlClU
 3+ucu4RM/wR7XxpVw2SIGguUoGTborT6/22agaxrztLA9zN4B8+fx1TkWxO5Z30XBslffX1WQg
 HVWqZTVBjHvIoAFrfYfQRy0j1mDHnlNjmcgIWmSqdPl1MmdQqfjGudNaL4IECZG5Evjs48o0yu
 eu4=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Nov 2020 20:54:57 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 2/5] target/riscv: Set the virtualised MMU mode when doing
 hyp accesses
Date: Tue,  3 Nov 2020 20:43:26 -0800
Message-Id: <e411c61a1452cad16853f13cac2fb86dc91ebee8.1604464950.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604464950.git.alistair.francis@wdc.com>
References: <cover.1604464950.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=57073d1dd=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 23:54:51
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


