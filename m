Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6360EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2985E2067B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YzKV2BHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2985E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1ET-0006oI-8F
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1B4-0001E3-IJ; Thu, 04 Jun 2020 21:29:46 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1B3-00005E-JF; Thu, 04 Jun 2020 21:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320586; x=1622856586;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T0V51AtEox2sY32BbcFrzOQqvlmrKlQBtVR8v/lci/0=;
 b=YzKV2BHWoQpuaF4rgMgRzxRjo8GG27XamYbLoNuTPfI7RtJSXnKGg/Ru
 MSw79dr/k886VVAtQYc//oPYMdCUeIIiQ94Fin1jGhvwU2JcThbc3qhwW
 kJbooHzyIPTq7ndIPh+jpx0OGp3A4eNcxwncZJE7niyZ778mcOvBe9j3y
 IumnPr/UYjDzXYUPc6XaaJHn2ZRUCnRyRJtV7hTHIInYmQLzZvtED5ZIJ
 E52azeCEi4SU7I7o78Hb0AKoUdjM8qp/PqJJmqdMsOvihj3x5s7TvtzAE
 4dgWbLGrsPfoTHITaNQux1W5SsCkS5ttx2r6S54qFb1y1fs82gLqlG9+A Q==;
IronPort-SDR: 3SmhBhdtRGAmPt+c6j5h2+PUwi/F3gpa6bGSMS+hlqwOub+EN1jIePiaAa1BsLOGpKha28VZX7
 ZYWhkip2RzyU0tKz7bmTXkK0BbfwycAIcHb7IAAcqdQJRoRadQ7ZGZW4hYLe4huC59kqCmTDZ9
 DfKVt/uJ9oGCBU95db64T3hmHmo62lk6BFBHsOmCc92FXlOWXpGG4SdIPXotvO/2sSSsBkbi0K
 MGqCVlv5z4vCTrtJo7iYIjNr8AeX/PutQ41ipVktIsqidqX/361EprhLDxNf5Wa1YYs++lpxwv
 /GE=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="143573557"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:29:44 +0800
IronPort-SDR: yhtXdQC9QK+49j3nfJuCUg7MfIJDBCHrDXndllqjMSR5fxkooOvZ/QK0Y9Olv/G99/+t9ZFWut
 9LS5kWJnEfXZ7gGflbW8Sm4M9AgGyGPX0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:18:46 -0700
IronPort-SDR: HfHVrZurbFB23DdVEo9cwBjMyjE1vmi2uXh5lKENnHfRoPLOB+kFOwViQsJu72RnpHRTS0jJn4
 ba8B8/i5qUNQ==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Jun 2020 18:29:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 05/17] target/riscv: Allow setting a two-stage lookup in
 the virt status
Date: Thu,  4 Jun 2020 18:20:56 -0700
Message-Id: <4ae855427beb4d239feb3f7002a9d33128b3b3c9.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:29:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 80569f0d44..93ae472490 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -295,6 +295,8 @@ bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
 void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
+bool riscv_cpu_two_stage_lookup(CPURISCVState *env);
+void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 7f64ee1174..f52711ac32 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -452,6 +452,7 @@
  * page table fault.
  */
 #define FORCE_HS_EXCEP      2
+#define HS_TWO_STAGE        4
 
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 75d2ae3434..68abccc993 100644
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
2.26.2


