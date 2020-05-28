Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2EDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F75208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BdidjeVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F75208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeR1D-0002l9-O5
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvQ-0002AH-Ek; Thu, 28 May 2020 18:22:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvN-0005c9-OF; Thu, 28 May 2020 18:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590704574; x=1622240574;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=95oYIs1BVKa8lJpKUNyTJ6K2xLTQpJSfhvRfZcrvMYo=;
 b=BdidjeVBt51LDUinZKLXJKWSsK0vJVcfmTohDx3GXjTdtghG+E9ivcm3
 VaWh7roJnfjUTFZo5Q1Kw9xbCAo3PVCUX41yTh3V1z8FLWDZ0RvPXLFcD
 2cRCNH4vyckvQnbvM/BMkp3XqsbmHWDD8mJ4BGcbhOb/uZAHfFbU6AJnO
 oh484ZoWT4rzksLGwf87m9FNM7uXWS1PC2Laso5anmE4cER8sY0nJlBDl
 DZvjTMPchExpXStMuGHGx6u6RoCIrlnSYzSAMXxh2CGnU3N+wPtr3mFdb
 QE2hRGVuyaN7UaMk64t+K03KRu/iL+rw5S+JiI3qzL97BGBj2WVbnlT4x w==;
IronPort-SDR: 2u73v+OPiHZ1XTpAjbwTX0JEzORaPFB2iIV/BWI+U+4DO1AK4MrZftxqHF9SCudPpiSDSGd0FQ
 YNkDxHJpHYuDQ/LGLWzRd11qOHiwQ3N/Rk/FiCQTTHcaIJeroV6txgMOU89PdnGvRYoWh3ojVn
 wfexdTEOdvArVF/C9zKcMhhA9wkf0wlnvHswNL6aYSaj99Tt4r5IhsYvDyDFuqhAHIP7VsvSA1
 ks1XAGHeaSzDVMYsqwvj59L73sFg+V9kBmL3MuXBoi+YuhIhct1ZSQKzTwnNfRExW/SYSCpJPb
 N5Y=
X-IronPort-AV: E=Sophos;i="5.73,446,1583164800"; d="scan'208";a="139073332"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 06:22:52 +0800
IronPort-SDR: lSShjQcbl5ulWyE8SXG2cWJP8PaOF9Qbk3ZBfnFIW9JOzdfTgTKbbQz/JsoJRqigiLS0N+oaQU
 6dNoveD/n5e1Sitp7YkotJdsZorSql5OI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 15:12:06 -0700
IronPort-SDR: f80anS23G5A8BJ9SCr8oFhK3Ht4jPat+tFbF82se8wvJ/JGX3sPuF0YjyzbIaelFCChimsU29s
 Un6xl1W5KrxA==
WDCIronportException: Internal
Received: from 6xf7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.123])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 May 2020 15:22:51 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v5 03/11] target/riscv: Disable the MMU correctly
Date: Thu, 28 May 2020 15:14:15 -0700
Message-Id: <3e5b7d781f56c7a625c7c8ca5e38a9544e2995c2.1590704015.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590704015.git.alistair.francis@wdc.com>
References: <cover.1590704015.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4104b2603=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:22:43
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

Previously if we didn't enable the MMU it would be enabled in the
realize() function anyway. Let's ensure that if we don't want the MMU we
disable it. We also don't need to enable the MMU as it will be enalbed
in realize() by default.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5eb3c02735..8deba3d16d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -142,7 +142,6 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_09_1);
     set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
@@ -152,7 +151,6 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
@@ -163,6 +161,7 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
     set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_PMP);
+    qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
 static void rv32imafcu_nommu_cpu_init(Object *obj)
@@ -172,6 +171,7 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
     set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_PMP);
+    qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
 #elif defined(TARGET_RISCV64)
@@ -190,7 +190,6 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
     set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_09_1);
     set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
@@ -200,7 +199,6 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
     set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
@@ -211,6 +209,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
     set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_PMP);
+    qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
 #endif
-- 
2.26.2


