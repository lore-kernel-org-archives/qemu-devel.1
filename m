Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9EAC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765652082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cB/pcKUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765652082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd36r-0003lB-Mt
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 21:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40876)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd307-0006cF-Ja
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd306-0008Ro-9p
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd305-0008L1-Gs; Mon, 17 Jun 2019 21:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560821609; x=1592357609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yjAxmHO+IlbgcE9s5eMCiJERcKojM3+lW9tXUnlXSrU=;
 b=cB/pcKUPRcGQKzDHIUan4UjlvWrAdL6lfYLEQZbqG12NK4m1IG8N0TGc
 kEqDeeRMBamty+vN93n2h0U7eSEbBf+q2q9poYGP44JlH+Ukv58wm6C7w
 kfto8cBZZxuSDBkIFQPymcYYBI8Jp45zRYCLR/RYIFdU2X3p0cPkXb/Ws
 zGl0s0x9VhmWhWvv+kbPVXcsq74d4kLnqMM+fxyQAzsuFDEp8LzopcQOI
 Klj2PntFlCsKiJQrtkm4Fv0IazeCcDIJmqiJBwiW1KePKi8LKhohyjrX8
 S82YWKblCyr0jx1W5/lo1wkYcd49mwR2rmRVqPWcwu2lhrcAZ/I8Cr8cz g==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; d="scan'208";a="115717009"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 09:33:23 +0800
IronPort-SDR: VG9tu8UusbKDclV52Qd+JWCPBXe80xj/UjdpEMallRNVW23hAcbkFcSpsYPRB7IGB+DP+QuAwD
 CLLVDblnEZ0DdUtBlJX06FWDm9iTN4b9Bgoz4mjwxcQ8XwEV50QA8GIxeqHnEPi6xD2XgzDdB1
 eQfomJy+P/qiWXVeRVDiYEyVpJHcabBNbmHlRfJdTPObpbB0t+peFZH1AhViputiF4y4O7/Fmk
 2L9/+YGsTwQGv2wE+YHBdV/wYcd2j6a1h5ekRKKm1nqKBF4d2TwUiagVoyCBOxfx2zIrZydVD0
 ZpCajrvFv9WKskeEkUwa28HI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 17 Jun 2019 18:32:55 -0700
IronPort-SDR: fYEWfEtGYkogHAAdOUQhiEpK0YpltRAVwxyjJ1ba6TtZ6/LYMtoK5UZXsF2+TBzCCrAm9UeKfM
 p5X8FFSipXFcnI74gK78VrATK4acqM1jQ0Khzr52kH/+6pfcRKsVf6uBJt8Mkr0yySIM/TTJkN
 ICGEkLqL8jcwiikC3JkblcrO7n6/6V6Nm6CGOCzJBVgCe3drfRBwwsaFsLg5S0WYdlMiJUvFyb
 xmZ/NZDZvLAbdeVcsUBgh2fxEYzRfBDQXQU6aXLZOaqLVkEe3b7uxPMINmE2/f5SWwCAdKkn6M
 uns=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 Jun 2019 18:33:23 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 17 Jun 2019 18:31:02 -0700
Message-Id: <1483cda620f3bff57b7c47ad74c44f586cfde4a5.1560821342.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560821342.git.alistair.francis@wdc.com>
References: <cover.1560821342.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 1/9] target/riscv: Restructure deprecatd CPUs
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restructure the deprecated CPUs to make it clear in the code that these
are depreated. They are already marked as deprecated in
qemu-deprecated.texi. There are no functional changes.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 18 ++++++++++--------
 target/riscv/cpu.h | 13 +++++++------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0632ac08cf..a4dd7ae6fc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -558,18 +558,20 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init)
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
+    /* Depreacted */
+    DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init)
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base64_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init)
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init),
+    /* Deprecated */
+    DEFINE_CPU(TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cpu_init)
 #endif
 };
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b47cde5017..1668d12018 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -35,16 +35,17 @@
 #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
-#define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
-#define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.10.0")
-#define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu-nommu")
-#define TYPE_RISCV_CPU_RV64GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.9.1")
-#define TYPE_RISCV_CPU_RV64GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.10.0")
-#define TYPE_RISCV_CPU_RV64IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv64imacu-nommu")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
+/* Deprecated */
+#define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu-nommu")
+#define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
+#define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.10.0")
+#define TYPE_RISCV_CPU_RV64IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv64imacu-nommu")
+#define TYPE_RISCV_CPU_RV64GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.9.1")
+#define TYPE_RISCV_CPU_RV64GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.10.0")
 
 #define RV32 ((target_ulong)1 << (TARGET_LONG_BITS - 2))
 #define RV64 ((target_ulong)2 << (TARGET_LONG_BITS - 2))
-- 
2.22.0


