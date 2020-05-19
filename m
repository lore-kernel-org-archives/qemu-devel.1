Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F640C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CC720C09
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="krIQPmgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CC720C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbA1E-0001Dt-Dy
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=401675184=alistair.francis@wdc.com>)
 id 1jb9yI-0004bC-6y; Tue, 19 May 2020 17:40:22 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:10366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=401675184=alistair.francis@wdc.com>)
 id 1jb9yG-0008RL-FL; Tue, 19 May 2020 17:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589924443; x=1621460443;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8F8a9zRpcDfMqrY5c2yGF+yjuL1qF8edKe6nQ2idqxM=;
 b=krIQPmgSmC2iGe/SC6J3jOx8nBuNh+vhK9S7Sc+bdUYLnaNEKzmbYgFz
 V1pDKHivIktm2ufxdbgyNQCMec6AHe0yEvpdusuV9S3Wo33Z/IagDl4K3
 0iGyeQ1HM6lLB3xixYaU/VF+dSQbf1ykp71GYBcP2s4hJoNO9EM3ZsDNJ
 J+uk4I4WEPJuxstgRdiRNfJsu4xVlyamQlVTwtXFIX+lWs/TXCInV7tYh
 LYkMfBMzq12vjL2PC+KegvOOKwRYcPd2unUEXDwys5JY+BecGE9T6yNGM
 IZLT0hjjaO90P0trlpH6cRKKQrzgegq9qB5xUTgSI0XiFL0RT/7sNi43Q w==;
IronPort-SDR: rh+B+RMxZEev9kzr3o69WMTbl8DHJIc0b/VvpSa/8faBbzlS4Xxk+oG89tGcYiRoj2q3EKdjKG
 0T+Z0hSG0uTLMqgL4V4KCaS13WzHO9J6DJi9RrLr1pd7tN+QKFUguW1t2dVQypT6N3jPAY6tu8
 GsaFnwet7hqdCp7bfkOcuzvVPBPw5iGrdnRVtMFsN7BT9PG1PGMb2Gyzg8oX4GRLtTJphRZRPL
 BNrm0f/zpgCMwLIuqEC1uU9gffbi1122tozd+weeBzKllEjl6tGt0BU4OD40yRJG2+LftKG2PQ
 Bh4=
X-IronPort-AV: E=Sophos;i="5.73,411,1583164800"; d="scan'208";a="240814189"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 May 2020 05:40:12 +0800
IronPort-SDR: kf/Ne/uK2TY+9WTvJ4DhrRB8HABbQ2LV34mzaab8wzH1+YFsbNCyu/jjdR5y2fO9sKBdoL2zwn
 w0ea31uhHmemuaGLs2F29o1hYlZa5LmCU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 14:29:30 -0700
IronPort-SDR: MZFOkxiZxDm7+wT1p73JtEoBdLTO7hEzXVyLV7BcD+XOQQ0ugiG6b+tX1rT68sspNGONm3tlZl
 lNDCqvEx1N2w==
WDCIronportException: Internal
Received: from usa005149.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2020 14:39:59 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 3/9] target/riscv: Add the lowRISC Ibex CPU
Date: Tue, 19 May 2020 14:31:32 -0700
Message-Id: <24ba2634ff761e7a1e6b28b15929b03db3f59008.1589923785.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589923785.git.alistair.francis@wdc.com>
References: <cover.1589923785.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=401675184=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 17:39:51
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
Cc: alistair.francis@wdc.com, philmd@redhat.com, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
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
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

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
index 5eb3c02735..eb2bbc87ae 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -156,6 +156,15 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
+static void rv32imcu_nommu_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    set_misa(env, RV32 | RVI | RVM | RVC | RVU);
+    set_priv_version(env, PRIV_VERSION_1_10_0);
+    set_resetvec(env, 0x8090);
+    set_feature(env, RISCV_FEATURE_PMP);
+}
+
 static void rv32imacu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -619,6 +628,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
-- 
2.26.2


