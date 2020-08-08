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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04ACC433E1
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1A22053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="edfkvRer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1A22053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OTH-0003co-QZ
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4HHo-0007kU-6D; Sat, 08 Aug 2020 01:20:52 -0400
Received: from mail-oln040092253068.outbound.protection.outlook.com
 ([40.92.253.68]:37206 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4HHm-0003EE-J3; Sat, 08 Aug 2020 01:20:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nresNTCzaNFEst2oaxNQUoUC6/QaE0/zx5PaQFJfMEuMY/6Vi+JyNPdK8wyp5RVkA1HGwI5vr98VJlmP2QypM5Fas197iq/G0pH4bO5AWwiF6x3vQfZzarb3lnq9iCYEUr9R4bBdaxveOcuckWvFy45AUDlFMlvDmsFDSbxnkTiRVbn4epaAcE5m0zNmtbJcuAyrRBEtO+SBv+MfCGiVMF7GKNRL1qMytJZpE1Q9wMIAPcbCOo8HBCIPKYFWT44vZDHYSIV/dk7bPJGFafulqaKMyEcMQDJrU3T7wzVF2AOcv5Ms+iMecm/LFl1clgeNN6fxncKjXps5hwPuP0/2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp+JDcJo09cM1iOWfZ5/AwOs6B//J4Enz/bEKWwbgRU=;
 b=gpEcrXSiJGHHsEoIoE6e/VEw52KzbTzv920B4jznKYkSPMYwsdErS16lJre217DyZOVNe9dH9ZHPORHd4VQ78kLMXJRC9u92du4Jz7l2BFyMq04FI48tCOA+ulTw7Fv26ieba82duL9B6BB/VWJ5IuEbi5hxvb3kxVsdQCc2YaNxVk85ym3AmnailxBPt5xnnnVMtd78S4bLYlS4sxdk25CF5oJ//u/X6mMuiQ7uGWMqgenu1N4OZr0TpbZmmzIOdjnYZ5eDY96iHwwhrWP4Ki3eBTogWXyHD73gnKwEiuxv+/O3VdQvevZpppZFhm892XK9fY/RU4k8SFx956VTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp+JDcJo09cM1iOWfZ5/AwOs6B//J4Enz/bEKWwbgRU=;
 b=edfkvRerfVlEhr4ZiiNqU4AhUJbdNr2zhszNDPNrf23+3chjoeWI+7cqrf1XZdIjlr/9DGcWE0gboQoRtAlmKQihbGGLhQJjF/SAdStKtMtwOLh0ssMaJ/LkzftCUbO1jcQGAsc3O5Y2eVHWvEBXTX19CXmKx2I4W3Gs9oQ2GwsRty0m9YMZO6LEOq8R06maARwLWoKwOmXZKIEl+L5vyC80A550HYMWeJ2tlx99pHNFFmuhWcV1gx5nZlKZAPALLFZhNhgJdWPG85I2jzJVJNJelJDnLaG40QBvi81q/JfkPbqtN+6QpnJN8MMgcDSHMl+58F+mgOX6PgoIOZtovA==
Received: from HK2APC01FT029.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::4c) by
 HK2APC01HT180.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::467)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sat, 8 Aug
 2020 05:20:43 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebc::53) by HK2APC01FT029.mail.protection.outlook.com
 (2a01:111:e400:7ebc::195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 05:20:43 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:9B1E7670D5D45FA23577A738998D61C2EE4AFE400FD01872058E038E4968D7F6;
 UpperCasedChecksum:75B244A1D450F6704CEB2FBC90021AAF2919E785D71D61B7F1550C9EE9B5093E;
 SizeAsReceived:7683; Count:49
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 05:20:43 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/4] Add a config option for ePMP.
Date: Sat,  8 Aug 2020 13:20:31 +0800
Message-ID: <SG2PR02MB26343AB84DD6B092C3D6EEC993460@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200808052031.19523-1-weiying_hou@outlook.com>
References: <20200808052031.19523-1-weiying_hou@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:203:c8::17) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200808052031.19523-5-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.141.129) by
 HKAPR03CA0012.apcprd03.prod.outlook.com (2603:1096:203:c8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.7 via Frontend Transport; Sat, 8 Aug 2020 05:20:42 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200808052031.19523-5-weiying_hou@outlook.com>
X-TMN: [v44OcWefmgfg6gVU3G20sELJtvw6VccB]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 51ca37f6-7b68-4b26-8839-08d83b5acc34
X-MS-TrafficTypeDiagnostic: HK2APC01HT180:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNzjVGcNc1VC/oOCjpEydtWRdSieYHXiKyKTLGJhZeLuHPiXM7QKnI8igQ+hOvRHHCtylpLyeyIU3IRFtWeu/G0YRFzp53doO8MPZtQzuupHz6jmvzcSQ4eoKlOy4s02Gcb+gxXSvsj+XM2a2IkgH6QWqXUozaDGJ6nuTFvMJqpQPB+PEx2ncaN3+w4vHWZ369lvO5JCtDswZeAEMp9EvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: ZlPQJBh76XSm6FyQ5JRGnN289dPVvsIzC9n0FK+8rnNcMfpZ9tiRvA8XfSVKGZ2aqiNZ/KDIbSppdHFiM5//aI2RwkVlYE2J+6bLpF+5SDkU+P6lTmnWpEUdyzwK8gcW4AgIcHZ5NZfLGFuNSIJ+5A==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ca37f6-7b68-4b26-8839-08d83b5acc34
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 05:20:43.3906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT029.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT180
Received-SPF: pass client-ip=40.92.253.68;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 01:20:41
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


