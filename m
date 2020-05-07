Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FED1C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288D8208D6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pOn7tCC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288D8208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWm84-0005cy-AQ
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm5I-0008Ld-Iv; Thu, 07 May 2020 15:21:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm5H-0005Fm-Jh; Thu, 07 May 2020 15:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588879287; x=1620415287;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4db+S1XkotG6283uNgU5sGMLdhtVpqVPC8SsI8fhk0M=;
 b=pOn7tCC712DderlCKG1Kg2I4vwtL9cyX+dTsZQvMdMeAk8Mjl5N07D0J
 EqxO5o5hTikjqNARss/SBj9o4A/Z27jCeb+2P5zYDMo3ij38y95zznn8a
 D0whPgFocSLDPlSzYTy1RIyMsMl706xI0fNCM4qctyp5h2cOEnibQ/XzV
 XD1CD1eACCC2/dRwU/FS1SzVLoNGXFnuGwgY+wlLOhI2rC8XCa4lcyPVa
 gTfmynp/xjtcz87/FOn3r+FdIKRjpqcSbStj5etdXs+sjH3ztmOFDwy+0
 MI/vBs5Bxk5XBavIvNQGhWh7UlSo5YCwFPGitngjOZpw6Ho80gEaujx/f A==;
IronPort-SDR: hGca6WVfoALvJUYp8gf13N/tscn+nnOfa8fRFchpln/pLG5AzWXls+/z66M4VKc/Q969HHjvPq
 65WPV9UQWmdJEzVNN60h2YqO4UAaYaaBkDOYE8XIBJAXYjj9RsH2WzYuaa9f9oDDC8zDKUVFs4
 AXJhMCZn50t+irf5SqG5iEkArMFy6g8NrMUNoNU0u0vPjaleP9oJgh1U1uxRZmxFeg7uh2nYd0
 ApX2N5XV3fSeEqua+YX1Nb0Y/4WzFGFfW4/3gGhaVA3hZIAr9T/+Yb6RWozH3P7VdAt5kL08Qs
 E1c=
X-IronPort-AV: E=Sophos;i="5.73,364,1583164800"; d="scan'208";a="246038033"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 03:21:26 +0800
IronPort-SDR: gTIHFg1h7CFsdTSJRh858F9Mppp4UJPcjPvTDYXCKUTKyCePeUjxltWUiw48x+c9qznnln/nv8
 NVFByVrEcKb7Ni7H5NfcX9da0btuUh+Jo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 12:11:50 -0700
IronPort-SDR: AnDCt2RpFr+0t0367F5O2ayTD7ouXBQ3cwfc34C3CStanE8L1T7luD+2cqLEe+8JmgYtjrnNyG
 wrgIk4kUyEfg==
WDCIronportException: Internal
Received: from uscxm6l72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.6])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 May 2020 12:21:26 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 3/9] target/riscv: Add the lowRISC Ibex CPU
Date: Thu,  7 May 2020 12:13:07 -0700
Message-Id: <698e2a1723bbf04ffa941450f7a351397bcec789.1588878756.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588878756.git.alistair.francis@wdc.com>
References: <cover.1588878756.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=38990af3b=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 15:21:18
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 target/riscv/cpu.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8f837edf8d..235101f685 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -160,6 +160,15 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
+static void rv32imcu_nommu_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    set_misa(env, RV32 | RVI | RVM | RVC | RVU);
+    set_priv_version(env, PRIV_VERSION_1_10_0);
+    set_resetvec(env, 0x8088);
+    set_feature(env, RISCV_FEATURE_PMP);
+}
+
 static void rv32imacu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -620,6 +629,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
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
-- 
2.26.2


