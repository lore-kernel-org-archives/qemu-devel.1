Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB07AC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B715B2072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mz31XhIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B715B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrbq-0002hd-TU
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraU-0000Zc-SX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraS-0003uN-Qe
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraQ-0003Ps-M7; Wed, 29 Apr 2020 14:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588185455; x=1619721455;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tbkmc57R+L0aN9VLZbhIXSvamug7nnx7kvOn3zmvZfk=;
 b=mz31XhIY5E/vWsgAFLOomn2VzqjWolHd362+qrIAmoGibhJUQjuN07SQ
 c+wkQzcF1IbPJKL/kqYuKedH1xPkpHArgIDWecADwuU3uAa+ydmA7jzl+
 +xL/5zXjXDCz39Guia2jPwPZ9UeWC16hwsA6sKpgjoL2O8iRh+HvIwkYZ
 xWZqGK2eMFW+2o7Eucel9Gyh55T/iY/lMefW4DRrdF/VprnsnrD1QN/U4
 BJK2FUFZF0In0IxBAwIWnLD3rGqigwIQ8LSJFh7irhkKJNx4gmxJZcPl+
 yDqBNe+zMriy8f7QronHvSiRDEj1aQIlYAICjq+qaZFsBvAf/RSHITvxt Q==;
IronPort-SDR: tAFnAgZBtRfSAbsQHi7cpkZ5W1Xfoto/qyqkl75xVRx/lrfCoFil2Vv7twW4vb/qhF7bruV4qk
 3a+CuSCAz0e3urcruwrOyzcAjnKZ0trye7gs8gBzPfYbsv/aFDpehpnMki5ZPl+JGl4Evs9uYa
 r1g7lJHFm4NcyX2ozzdyEhMrUU1SUrTCN+P1ZTnhbBlWk+URUIbH3eVr9ryseoa4lQ8v4VdB+N
 aGCy32SZGopSGbzdA/xioPEg6Ak1ZF0YO1IAPxWsAQSea8j91DA6/8kVMRvBz9oXFUrna7aWxz
 erk=
X-IronPort-AV: E=Sophos;i="5.73,332,1583164800"; d="scan'208";a="137935149"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 02:37:07 +0800
IronPort-SDR: imqoSWRzhUVgNpwXzrNF/djgQwWMqMKJ6YFMbbQLRSSfd226rRzpzMJe+Uc8mmp8T4wEOaps3j
 toD5e0A6fGLC6LREiSru3mKce0QZjUkUg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 11:27:11 -0700
IronPort-SDR: 7wl+mEfBXH9Bh9GC/LqFxh6jl3RugCiQg0KxEwWpjGnY62k6F0CShiq9cbp31kpsME+nkrNdMa
 2q0T6OOpH/Lw==
WDCIronportException: Internal
Received: from cnf007834.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.55.253])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 11:37:04 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL 09/14] target/riscv: Add a sifive-e34 cpu type
Date: Wed, 29 Apr 2020 11:28:51 -0700
Message-Id: <20200429182856.2588202-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429182856.2588202-1-alistair.francis@wdc.com>
References: <20200429182856.2588202-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 14:37:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: qemu-riscv@nongnu.org, Corey Wharton <coreyw7@fb.com>,
 palmerdabbelt@google.com, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Wharton <coreyw7@fb.com>

The sifive-e34 cpu type is the same as the sifive-e31 with the
single precision floating-point extension enabled.

Signed-off-by: Corey Wharton <coreyw7@fb.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Message-id: 20200313193429.8035-3-coreyw7@fb.com
Message-Id: <20200313193429.8035-3-coreyw7@fb.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 target/riscv/cpu.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4e578239d3..059d71f2c7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -164,6 +164,15 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
+static void rv32imafcu_nommu_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC | RVU);
+    set_priv_version(env, PRIV_VERSION_1_10_0);
+    set_resetvec(env, DEFAULT_RSTVEC);
+    set_feature(env, RISCV_FEATURE_PMP);
+}
+
 #elif defined(TARGET_RISCV64)
 
 static void riscv_base64_cpu_init(Object *obj)
@@ -610,6 +619,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
     /* Depreacted */
     DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7d21addbab..d0e7f5b9c5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -36,6 +36,7 @@
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
+#define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
-- 
2.26.2


