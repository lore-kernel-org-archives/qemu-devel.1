Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B667C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B95F20782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QLAYnWqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B95F20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeB4-0005KP-CY
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9w-0003aF-8O
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9u-0002vn-By
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381943; x=1629917943;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ILcMahWyHzGMNLlu+QFXuOIzQSweh4qTulX7pKYhOqc=;
 b=QLAYnWqW2A5YAw4waRPCgagWBqYZU9ICWt470KKRMQGAv4Wf4wanRCdu
 vs0b6NvWxM0Q5+bKAMBxk/CaEhfqAbnQRIwX4TKrYEqSsblS1jYU+o76N
 /JksS5M4xPRvOOWbS7ElpjXw37IJxl9y8qQhHR/+xgkCXaCl5EzIO+BbE
 lpOsmLlN2JWSyYROA1oAAtHyvKvYcL/jG1sbXw4Vh7Tzp4UEaZ/ol91r0
 uasbJdKWrnlL/qgj+m6BiOhx2RmF/45/9zCJN259xB/aexZt2Jgg2BeMY
 UU4ASBXB+XUMsPgf/BmeOtzHlyxz6qtPSJEQafGit1Z/Or/UbrsTrrMKw w==;
IronPort-SDR: cKQNnxOlo3eu0QKkZftVrWX2i2nrV8/Yln/nC7bzJt7WK7pHoin5uD3ikY6adp6jeNLn1TWGjr
 O6rz52RF2L+V7ncDytcCRPH2pVCG4ltgYzGiL6sl4gkRLPJxnlYMzBqTHXv/bs4XrgFAOeQpMV
 JZ4c5SgfZYO8iP4iLy9hfqwE2PtrWrorlJzeFB5mQDflhjiPYByqPY0HbPhw9d+zOVk721nyft
 VWjfc+SgY5muaLtxus+UEtm5IwO3CvuVjV3nyO9Sz+KQ04hqrWPh+ACuolX3re07dX/ySsAyrG
 zeI=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145288"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:56 +0800
IronPort-SDR: nJkxB+4aLboX54LSlhX5PmMDa3M8qwgQswhkqQGhOEbrm/aLuZ9QtGQx1OEu6v3D/6CcNPl1yJ
 OWcechtWFimw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:31 -0700
IronPort-SDR: 6tdAi03pqrM3pG8ewzdtpfb0qWp1d7hCUgpo6XJqBuC3nHa0kijCcus9Ff9GsfS2fCMRe/2cGq
 Erw8/sLpEorQ==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:54 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/18] target/riscv: Allow setting a two-stage lookup in the
 virt status
Date: Tue, 25 Aug 2020 11:48:24 -0700
Message-Id: <20200825184836.1282371-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 08cdefb171b1bdb0c9e3151c509aaadefc3dcd3e.1597259519.git.alistair.francis@wdc.com
Message-Id: <08cdefb171b1bdb0c9e3151c509aaadefc3dcd3e.1597259519.git.alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a804a5d0ba..383808bf88 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -321,6 +321,8 @@ bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
 void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
+bool riscv_cpu_two_stage_lookup(CPURISCVState *env);
+void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 8117e8b5a7..ba0a5b50ff 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -467,6 +467,7 @@
  * page table fault.
  */
 #define FORCE_HS_EXCEP      2
+#define HS_TWO_STAGE        4
 
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index fd1d373b6f..e5e0d80c32 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -220,6 +220,24 @@ void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
     env->virt = set_field(env->virt, FORCE_HS_EXCEP, enable);
 }
 
+bool riscv_cpu_two_stage_lookup(CPURISCVState *env)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    return get_field(env->virt, HS_TWO_STAGE);
+}
+
+void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt = set_field(env->virt, HS_TWO_STAGE, enable);
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.28.0


