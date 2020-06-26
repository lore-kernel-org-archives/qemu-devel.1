Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41C0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C382089D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CFcvKgym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C382089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowND-0003Do-TP
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI5-0002qa-GI
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI2-0002yn-W5
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208424; x=1624744424;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gfH3RYltiup+leB4/paBXRYbSi3EmWWxrrk+QaFhK7g=;
 b=CFcvKgymGnKThy0/PgnbsxSYIcpRnCriCWHlJbaVmpHwBPP43W4uPTqB
 x3cxmbOylinpK9FVx1CcK4fI3TYsQ/JTFX1r89IMI3pxVNbvBkU6Fg0sp
 MuMVwrLwP7ooWauC079gVx8deD8uYjpjIAQlWWJlsdYbbaGs0PKXYtveD
 enqNIRaYbeq9i+ozMFgd5WDyB3QfEwuXabJv1sCSSiuN+J+8HN1LaKeJ0
 55a+G+d8GxIeywuZs1lUEhHiRiMawQBemOpQ0ypnfHUvnPMIJa/rYKCSy
 p0BjgtlnB8f0Wh0D92jFUforTPg9rPp8bDXVvk36fX5BRyFLWDzMhGiei g==;
IronPort-SDR: 2NLXPqKK1E6uQ1TPU3tLjvPn2jlUapCkey1fvYCCgW/4fcpFEI0x8lUDesR0l4Gd2/yPZdVj7O
 8/XjFm5KJS1pEf81gFp5zcsRjL/LKfUQJVZ9jveru5HDUDXXthcJ3BjWP5fbYDczSRhbtbzPe+
 raYsRGkENdnBOjQ1Wle3+Cbegc9+zPNQJiIL+j5OeuJONQ6Wi8Vhlufz/hrnsBtqgv1j7NNrRa
 9uLZ+cDOa1Bv8IP6R2XzlOs4Mf+UF/cMpGwbELV59SmCi3VNxL0HndlRIeaNK8UjYpn+EH5f19
 xPk=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="145360021"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:36 +0800
IronPort-SDR: 2q+3g4eOvS/kfxAOEmL/Tn2KqC48sT40yrq+r+GCEWfeRYx2dgCryFDc9w+piCDlSxoqqjwxQt
 042BTso0cebuenEqpXDiPrJUVZ4Ty32DM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:33 -0700
IronPort-SDR: v6vrZszJGpqOQRH9Ngq+dzNNQfzdM31YoOawmL81G6/UvMFdJ3hpqLSyyMCuT5L7avjZrHjA9J
 7fnOnh8V7yMA==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:35 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 04/63] target/riscv: implementation-defined constant parameters
Date: Fri, 26 Jun 2020 14:43:11 -0700
Message-Id: <20200626214410.3613258-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:34
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

vlen is the vector register length in bits.
elen is the max element size in bits.
vext_spec is the vector specification version, default value is v0.7.1.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200623215920.2594-3-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 5 +++++
 target/riscv/cpu.c | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0018a79fa3..302e0859a0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -78,6 +78,8 @@ enum {
 #define PRIV_VERSION_1_10_0 0x00011000
 #define PRIV_VERSION_1_11_0 0x00011100
 
+#define VEXT_VERSION_0_07_1 0x00000701
+
 #define TRANSLATE_PMP_FAIL 2
 #define TRANSLATE_FAIL 1
 #define TRANSLATE_SUCCESS 0
@@ -113,6 +115,7 @@ struct CPURISCVState {
     target_ulong guest_phys_fault_addr;
 
     target_ulong priv_ver;
+    target_ulong vext_ver;
     target_ulong misa;
     target_ulong misa_mask;
 
@@ -275,6 +278,8 @@ typedef struct RISCVCPU {
 
         char *priv_spec;
         char *user_spec;
+        uint16_t vlen;
+        uint16_t elen;
         bool mmu;
         bool pmp;
     } cfg;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 391a0b9eec..d525cfb687 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -106,6 +106,11 @@ static void set_priv_version(CPURISCVState *env, int priv_ver)
     env->priv_ver = priv_ver;
 }
 
+static void set_vext_version(CPURISCVState *env, int vext_ver)
+{
+    env->vext_ver = vext_ver;
+}
+
 static void set_feature(CPURISCVState *env, int feature)
 {
     env->features |= (1ULL << feature);
@@ -334,6 +339,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     int priv_version = PRIV_VERSION_1_11_0;
+    int vext_version = VEXT_VERSION_0_07_1;
     target_ulong target_misa = 0;
     Error *local_err = NULL;
 
@@ -357,6 +363,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     set_priv_version(env, priv_version);
+    set_vext_version(env, vext_version);
 
     if (cpu->cfg.mmu) {
         set_feature(env, RISCV_FEATURE_MMU);
-- 
2.27.0


