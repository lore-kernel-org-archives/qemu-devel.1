Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE67CC433E1
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFC72053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pZVpfJrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFC72053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OV9-00072w-Ve
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4KfL-0007PT-Ed; Sat, 08 Aug 2020 04:57:23 -0400
Received: from mail-oln040092255103.outbound.protection.outlook.com
 ([40.92.255.103]:18925 helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4KfJ-0007GK-Lo; Sat, 08 Aug 2020 04:57:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg4RetzqSBejLRy+WIlKpo2bimZUXBpOv6uDw2d+MV0hQ6mDAUZD+IGyfi7XGHU8cztgPHC7ZAjQAwHxBkCiuP3gXopGiL/hKJqV6UVI+7tqSUoUkauYfc4A+F/9ErEG1CboujVWNjLP0TZVKhzl7OP5Y1HSrwnTXbiQgaFCMDZha9cMLRKFNSarUcrV+a8DmQnJFy2Pfib3Cy/Z8YdkXTNr7FU9/lf6IsXdRpfjF834H6q7+tAKcs5CyU3gi/ptI2Csdz29bIu0KgwgskVNrj5vaCHK3sWGTa1FEO2CzTXB0CtSw83OpaaWGJyF4dzG/knNMH3wxl83K8uJEt4BkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp+JDcJo09cM1iOWfZ5/AwOs6B//J4Enz/bEKWwbgRU=;
 b=nMHLqDprCAJ1Md1GQsN3nULesdKv3lY0qKxvZe/vl1Iyk0K3cNZbWbf5vgM7AaaLzvQWXg41yQmctYiXYTOayySovjZZW6PIJ4aZwMr9++5PqT5cqA/AHDvdJOdO3WPHEHOQnRkZjF/8reeKY3kOWWB6yMCTvOqjJwd0b2d8RRD4WfqdRb4z6YURrJsOdiJAMAZPi08OTOeyQtrE86iQ4twXLb+22nRR/6BYmGBXNCxMCm0q6Abam8WaH/VO9o3xDjyHiRWxP3w4TxGQPCA5JmFE63Tg1kYUCltFV8bPfrOVfX/P9HsjiF3xsEpH2RVgG+k8I0/IKweAwCfYj5rInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp+JDcJo09cM1iOWfZ5/AwOs6B//J4Enz/bEKWwbgRU=;
 b=pZVpfJrb4h/1TAmENdmPCk6iCttxht796enD7dobTS3/kh4wNN1Kkp/K+KjzH7SXF4iob6LrW15cNHl7Z2d8NmsaviSh/K8ZrDMSH6OzjQBjNnjtmkX9NYv+CfoftEuSXb9V6+wJU9aMhl0TsNVEojEc/F+SFXHeOXSab8EcO/CwK2W02tw6arNdjmutCJBQCFQOhtNTLLWzQZfZwBCSxPkzwaGN4PpXLH6rbIiYz4XaauXZb8++WxUTKmUVt/V0pqUS3glWPLidHIuW4MCdZ/eACYjB9nQRpyEMXnu1ODpk3GDKvRFAajv2RGu03ecPseB+++EbDUftPS/RJSLwEQ==
Received: from SG2APC01FT013.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::4b) by
 SG2APC01HT095.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::421)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sat, 8 Aug
 2020 08:57:06 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebd::50) by SG2APC01FT013.mail.protection.outlook.com
 (2a01:111:e400:7ebd::186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 08:57:06 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:23BA5F8E75BA7288E693E58B8221129F0D679FF375636DA7E6D973337A105972;
 UpperCasedChecksum:A1AE190356F77C5AACF780653130892C192D6DDDA7F2F1F4912547538B9C2916;
 SizeAsReceived:7680; Count:49
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 08:57:06 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/4] Add a config option for ePMP.
Date: Sat,  8 Aug 2020 16:56:56 +0800
Message-ID: <SG2PR02MB2634707BFE601B6BCDAC09DC93460@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200808085656.28692-1-weiying_hou@outlook.com>
References: <20200808085656.28692-1-weiying_hou@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200808085656.28692-5-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.139.46) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15 via Frontend Transport; Sat, 8 Aug 2020 08:57:05 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200808085656.28692-5-weiying_hou@outlook.com>
X-TMN: [7QqHpFsqkt/rk8CSMW5rKwxi6ZN2p2to]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: face8cc5-0c48-4927-93d5-08d83b7906ec
X-MS-TrafficTypeDiagnostic: SG2APC01HT095:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lxwGUxCs9t/cSLsj0OSZjuqzcmM8KGXDU7robLE+hOLRZT2zFxTfpFclF4YVUvdhKAT/soK8Xx0oMRLndZqbPTF+XYwrugIzs6DPIlH6gQd64RUhGd3Stt5PL/ubV48D+jWuWYqOiz53Xv4sLycinO7EAr1FJVHv7UbUyhrFverynDlvm8QZTAEvV+wF1gUIrGYJPrWblSYxtCFk0VlaHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: xPGLGG9h8K8K4GI0S2PGDcvVAwfnW9VXruhNvVdTgdlRY5XULYWleQmn/CtilQ54dz6rBt7aTH+q6hvg6G50Rf5+rhUNBHkT7ERz90guwh0bUgNxn31hGcgghLNnEnrlanhVKuTki/MS2Q90teoyqQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: face8cc5-0c48-4927-93d5-08d83b7906ec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 08:57:06.8859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT013.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT095
Received-SPF: pass client-ip=40.92.255.103;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-HK2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 04:57:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2020 08:59:47 -0400
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
Cc: sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 Hongzheng-Li <Ethan.Lee.QNL@gmail.com>, Alistair.Francis@wdc.com,
 Myriad-Dreamin <camiyoru@gmail.com>, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a config option to enable experimental support for ePMP. This
is disabled by default and can be enabled with 'x-epmp=true'.

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
---
 target/riscv/cpu.c | 9 +++++++++
 target/riscv/cpu.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059d71f2c7..79fa9d3c2f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -407,6 +407,14 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
     if (cpu->cfg.pmp) {
         set_feature(env, RISCV_FEATURE_PMP);
+
+        /*
+         * Enhanced PMP should only be available
+         * on harts with PMP support
+         */
+        if (cpu->cfg.epmp) {
+            set_feature(env, RISCV_FEATURE_EPMP);
+        }
     }
 
     /* If misa isn't set (rv32 and rv64 machines) set it here */
@@ -509,6 +517,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
+    DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d0e7f5b9c5..afdc9fa2bf 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -77,6 +77,7 @@
 enum {
     RISCV_FEATURE_MMU,
     RISCV_FEATURE_PMP,
+    RISCV_FEATURE_EPMP,
     RISCV_FEATURE_MISA
 };
 
@@ -202,6 +203,7 @@ struct CPURISCVState {
 
     /* physical memory protection */
     pmp_table_t pmp_state;
+    target_ulong mseccfg;
 
     /* machine specific rdtime callback */
     uint64_t (*rdtime_fn)(void);
@@ -272,6 +274,7 @@ typedef struct RISCVCPU {
         char *user_spec;
         bool mmu;
         bool pmp;
+        bool epmp;
     } cfg;
 } RISCVCPU;
 
-- 
2.20.1


