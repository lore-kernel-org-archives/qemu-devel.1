Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA7AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58893208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EfYlD7aK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58893208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeR1F-0002n7-9t
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvT-0002Fn-Kz; Thu, 28 May 2020 18:22:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvQ-0005o1-Qz; Thu, 28 May 2020 18:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590704576; x=1622240576;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7lsaaaazJWD7znUV85BSVopoiWRkactNOEbF5Q2Y7Zo=;
 b=EfYlD7aKH6DY4lE2e+9lOpa1lhnNPo9tNKPR1D0gLYUDeIvI8fOE7/d/
 ZZ1olgOLEjOGbxioJhi18MfmGmaKI9yZ7TLQT/+SspeiCT9GEZImn728M
 nOu4PdTHA5Q/el1G+Z+BZ0Fzv7v4x4W6zRokvnlIck7x0geyFDCrktUWz
 XzGfVYPMkFeTAU6ah3mXxLlq5fT4TD//LuYAL8fCsOSklAH5AWLJf/muT
 ItqGwXWVo8BJmKppZefovigrrtuDOlyyDedTVIUzJ0jngKOrcrVRMCCja
 iJqqmvtkYfMaB17dP8ma65+E31aBPAGoQ9fH4N6pdRZ2O/tUheJOubvQ9 w==;
IronPort-SDR: HfScqUDsMfjGSHNdN0UZuGEQq0P8+atXo0NAkdTfHaF2mnDyC+5kr0zgG70pdr6fj6UBLHjIiI
 wSAa3+cuA9McwRmN4tsXbWSx6zuKGTF2Rzp/JTy5oJoctVJegc3fjMtJyKaYqs9rDsH2Zyjcz/
 H4mElgfB/TlUcH/V/1NKH+BvB6VPnl/wZ2PPT6lacXyFzvEOTz6cAEoBSwEzZQ8d4QyEg2slaH
 BBDkzhvK3r8Xrbiz/jQg9FTnaM2mfMsIGx7FpqojNTnnELDgFABF/VRjUDfjRldMY89qAo8jwA
 vZw=
X-IronPort-AV: E=Sophos;i="5.73,446,1583164800"; d="scan'208";a="138744572"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 06:22:53 +0800
IronPort-SDR: ntWTFAl8DyLGBOoU6Y9gvLxuDXQYRd6aAEB7R6v5//66Tly0EprHNW/HgBzudy7FkIniclsBA4
 KQWKrFszM+wAwrlh4qv7BdPC+8yA5aEZM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 15:12:42 -0700
IronPort-SDR: JHQh9Tm1DmN/QU7rdSoBQBzDyOfZH5dm5ui38BiRJc8l0HZM3Js/cHRMWMVLcd7OgxSeyzkn9o
 WxK+bcWmIi+g==
WDCIronportException: Internal
Received: from 6xf7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.123])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 May 2020 15:22:54 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v5 04/11] target/riscv: Don't set PMP feature in the cpu init
Date: Thu, 28 May 2020 15:14:17 -0700
Message-Id: <a1bd144a1fe3e80a9b512edfe602c9a32e697429.1590704015.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590704015.git.alistair.francis@wdc.com>
References: <cover.1590704015.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4104b2603=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:22:54
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

The PMP is enabled by default via the "pmp" property so there is no need
for us to set it in the init function. As all CPUs have PMP support just
remove the set_feature() call in the CPU init functions.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8deba3d16d..406e8f37d7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -142,7 +142,6 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_09_1);
     set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_PMP);
 }
 
 static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
@@ -151,7 +150,6 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_PMP);
 }
 
 static void rv32imacu_nommu_cpu_init(Object *obj)
@@ -160,7 +158,6 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
     set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_PMP);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
@@ -170,7 +167,6 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_PMP);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
@@ -190,7 +186,6 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
     set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_09_1);
     set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_PMP);
 }
 
 static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
@@ -199,7 +194,6 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
     set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_PMP);
 }
 
 static void rv64imacu_nommu_cpu_init(Object *obj)
@@ -208,7 +202,6 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
     set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_PMP);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
-- 
2.26.2


