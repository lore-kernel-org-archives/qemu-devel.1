Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95479C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A8772071A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="delIy1Et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8772071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdzRy-00075c-EK
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 13:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOM-0001S8-A1; Wed, 27 May 2020 12:58:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:63648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOL-0002D9-6M; Wed, 27 May 2020 12:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590598737; x=1622134737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=95oYIs1BVKa8lJpKUNyTJ6K2xLTQpJSfhvRfZcrvMYo=;
 b=delIy1EtSOlZ6gUnMsvovEPhxZaMLXAyA7kSGmr6xdzhV5VM5no0CmIt
 SnPs/X9SCptYdvSX1txBEPag18xZBQys3kLkrwqo5AdE7ONEQsoQYasWE
 5exuYx6UreIzvWun3T98lKTO5GZ0wtgPC6jasxB7CM154lpDgGq0DLW/W
 dxKyvEkcQ10F9njBr0nPLQBy9ovAmtwPLdH+JrMuaAVlxATVw6aa1zVfR
 JNVlGR2IIyDy2BgPmRdFOF3+RfGGsD483xJj+TUGihgNLa1kaKFbN4KAf
 wAyD+oKEArId4otT5DqUywXBQGg97CEnSqu81Z0gq1C2pUqTX47rg7UgX g==;
IronPort-SDR: GK9DAE69ax+S39YK89UvGl1iUsYAUNFcJn9im9b3Dh0z8flsl9xPil7uZj6cHXUAlUwrex21nQ
 sx6+OVLz8oTIkq7EEdiHHc5dwIyY2lNa+6LfYDoQmQ2xYgKwqH3P/4RTHUPCPTKqrhb9C+Wewj
 cYca33ExEfsAhygFERGEKLHGu7kL9906v8ODucWdO0XS3fdPVl0qzajYjVvIIonYCgnH2z4tO6
 rmjmTyF3MIh8yisUxyWD6dGq/EghEmT3ir1nswAYMErHpbiPY3S9AY/ZGBASyGo+AKD1Prtt66
 9e0=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; d="scan'208";a="140062122"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 00:58:55 +0800
IronPort-SDR: 6k6vJv38jsQRvF0QhZhqzwYpXuAKzXEfDjmpXTWXtAN+J+4mpfUFtMUptZnc8A6+s28mi7k4jp
 AEa4VmTwDFwL31iCL22uNRddu6aw/2mGA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 09:48:11 -0700
IronPort-SDR: bs+Nexc6C/cgczZaRzb/7xwjmqT/WsSywsfN1WBEJOTnZjyg/Uwja3h3Oy+PTQuNj2fk6N9lXd
 PYpN3+q6E67A==
WDCIronportException: Internal
Received: from 71vjjc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.96])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 May 2020 09:58:55 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 03/10] target/riscv: Disable the MMU correctly
Date: Wed, 27 May 2020 09:50:20 -0700
Message-Id: <756439d4816fb3bd7ef84b458bdb6ab3442cdeac.1590598125.git.alistair.francis@wdc.com>
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


