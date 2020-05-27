Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E75C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1DF2071A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="my7owVEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1DF2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdzTT-0001SF-Be
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 13:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOO-0001Y0-KV; Wed, 27 May 2020 12:59:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:63648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOM-0002D9-Tt; Wed, 27 May 2020 12:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590598739; x=1622134739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DWPU3grvyG4xipf+CgGNdLOUCll6W3GDsG8NV2270Es=;
 b=my7owVEdoTwx4+xtwV5mopXiqjo1KloKleQVkAnl+MZey61lnkyhqdgS
 +aBozN5BuM8UQUD9spVsmdZ2V4L179Xdo2R3OUa/mcd+jBa9JxjQj+R65
 cPvCHR93jZO9bE7IEUqDHNldN5TiK1nigc9R2mu+vVwinv4NOlzd5HE+5
 tlFw3TrMT+hzVgqrHTOqWin2y3rHbYZIhwHHRtmW4x+y3dEmhWh00r6Oi
 lzEzOfv/ei+JgANAvKf6OasYg9Rg1WgkV5kgmsYTjkGPbleuSdVfMoIx4
 Ubr4e05pn3fzwvDdkc300da5H2/67WyQmBYHafKg28kdv6o9vyyA3Usb3 A==;
IronPort-SDR: oOwA8/eY+r9s8DvJXcxn0JcnpvS8oYgcJ1I0vkAim6rrXMck24+w1GQLydTxP6KxE1yTUXb3rh
 MhqvixLbceM4mwaf9QZYFSu0sDxe4UWhyU+STCOHCuaGH8eKm/rGGUcFskIsRecQEc9c23wfiK
 q9jroap1KodSSTrnCaMgP1XoLZxxAzvKapZ1sh31ZTkleN6M6PkqiT2FkB8HbsDB19CNAWRxF1
 tppDVJGV3Ja1dfLkLcT4/OCz5Qes6E5llJNmQUO9MvHYge/9jPp45S76Bx77QcXvBSKp5f0/jT
 pyE=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; d="scan'208";a="140062125"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 00:58:57 +0800
IronPort-SDR: +8TxaKt/t0f59TfRO1LE1KjVjy1qbM2j5i6Wjko4L7yjiXh6JI37Nv4kMIgYH6c7TDfgQFC+tL
 KM0eLxV4vHsQV1Z0+Go/WY0nE3SoTcWLQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 09:48:14 -0700
IronPort-SDR: cHd6qYiy06PKdPt7ho/Cc/dJK+46tNElboPpFx05ToMPMyC/ne1mAo+XpK2H8PlEqKf1bU5nMk
 qctJhmwK2vNw==
WDCIronportException: Internal
Received: from 71vjjc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.96])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 May 2020 09:58:57 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 04/10] target/riscv: Add the lowRISC Ibex CPU
Date: Wed, 27 May 2020 09:50:23 -0700
Message-Id: <7477d159ddc39758d60f5c68b99052dd30441ea4.1590598125.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590598125.git.alistair.francis@wdc.com>
References: <cover.1590598125.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=40961fbaf=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 12:58:55
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ibex is a small and efficient, 32-bit, in-order RISC-V core with
a 2-stage pipeline that implements the RV32IMC instruction set
architecture.

For more details on lowRISC see here:
https://github.com/lowRISC/ibex

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d0e7f5b9c5..8733d7467f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -35,6 +35,7 @@
 #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
+#define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
 #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8deba3d16d..4761ebad42 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -154,6 +154,16 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
+static void rv32imcu_nommu_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    set_misa(env, RV32 | RVI | RVM | RVC | RVU);
+    set_priv_version(env, PRIV_VERSION_1_10_0);
+    set_resetvec(env, 0x8090);
+    set_feature(env, RISCV_FEATURE_PMP);
+    qdev_prop_set_bit(DEVICE(obj), "mmu", false);
+}
+
 static void rv32imacu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -618,6 +628,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
-- 
2.26.2


