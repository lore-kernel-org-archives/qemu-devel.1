Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25C1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911B0214DB
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nObRDFfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911B0214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKeg-0000D3-Q2
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUF-0000jB-PC
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUD-0004PR-NW
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586449; x=1624122449;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K/19YyQZ1dMfa5QzOEJU2PErNtrrLO7t97Cdg6fUhnU=;
 b=nObRDFfD+pP7hVdY53JSKcQk/T+YuZjzCNk/KwM853pRP2pm20DsExsr
 jcdEJdKZlssWLK/b6FwGaFfcN9IZ6kbSdmchA8SZGahiQ5awGHNsnuMyo
 G0jOttFDj5MPkFGn4lGSwsanXW8isAkh3X7RDjo7/Q6aBsElXvF4TFiXW
 nhUfNvEVg0IVP5xl8f1JBKpDvGGNSWXdNerP/B+qURWcCN/gOcbChimTG
 9cOeEm1P65PF5gxAgA7naPkDSE/x6MJij+dWB3CAQ1EkKUoEsCQEv3PHn
 TbSxNNNNzQZWn63nPsdXzI91DT6lkYU2V5+ttZ0xQ5ziHj2puGB9+dXup w==;
IronPort-SDR: 7fkIcEMZZ6tmGHd9NISf74+2yi5MlzOBkz16gwPBhj3KsXsd7tkc8fRdRzz/Amg8lKmJEhXJjg
 O7ePHNLmivVTPn5CODOJvySa7cgqpTnDirKXDpD6TQZeIeRsKTd1mi2CZ8tc7Ca7jgMbSwSomd
 fap92/URmjsLbG/zuewoAIdE9b77GLL82TU5fRs66ES9IWR0mPlWjZ5IqiDTEiGG2RMcY4Y3Jc
 qVPjAwcU/dP3fiybK7PIpg+hM8ir3tPlYPkp/XCnB5XUfLkRq4KHqNIeju7WrM2/Pi+y8gqXXR
 U7c=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="144763314"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:22 +0800
IronPort-SDR: 6kj3ov8XR0mpmbBX3cl7x6TYiBqHewpFy05dNUtoHLbScE1LcE+wRB0L8k86G/TuV4jsDKfKTJ
 IbnXwcZkvpvi2q41kzh/zdTF1PhPReNwY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:55:59 -0700
IronPort-SDR: Cdex+AH3dOeWDHm27jfdMxlGyCIYJp5C3m8IPAKJnRh4Kx5Giw76BCs0nTbe2TE3sndJje936O
 2sw8McjdPwZQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:23 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 06/32] riscv: Keep the CPU init routine names consistent
Date: Fri, 19 Jun 2020 09:57:51 -0700
Message-Id: <20200619165817.4144200-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Adding a _ to keep some consistency among the CPU init routines.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1591837729-27486-4-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 35a8c7853b..e867766cf0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -153,7 +153,7 @@ static void rvxx_imacu_nommu_cpu_init(Object *obj)
 
 #if defined(TARGET_RISCV32)
 
-static void rv32imcu_nommu_cpu_init(Object *obj)
+static void rv32_imcu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVC | RVU);
@@ -162,7 +162,7 @@ static void rv32imcu_nommu_cpu_init(Object *obj)
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
-static void rv32imafcu_nommu_cpu_init(Object *obj)
+static void rv32_imafcu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC | RVU);
@@ -577,9 +577,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_imcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvxx_imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_gcsu_priv1_10_0_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
-- 
2.27.0


