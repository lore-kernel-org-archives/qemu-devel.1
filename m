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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E973EC433E1
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0ED720866
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YFupznq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0ED720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OWe-0001wn-Sd
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4HHl-0007el-LD; Sat, 08 Aug 2020 01:20:49 -0400
Received: from mail-oln040092253068.outbound.protection.outlook.com
 ([40.92.253.68]:37206 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4HHg-0003EE-JL; Sat, 08 Aug 2020 01:20:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHNiKOeGMViQSh/EYZ5W8lh0pPoS6R08qyScu+1atbUlsGM7pWejvLTy4xtmH4Z6qbMX7D6A7/kgalwFjtlb0Ef1VuB2V9t3Pbxnm5WRbijdOIGG0qWt8nXblchFlGknyaCzldvlUs1yvvCGPmZ+xEwBm+LzWCBq5svLA7kSd/tWjggjYxpM6EGPUOiEDrDgDmti74hywX+zhF0FcvngDcVQ7oK7ZNlPZFS/xLfbdahsLyfF0YE4d1opAUM4eB3xh78/Vm5Izzj5WAvsDundPjq88diSqAU8qhWUz3bQrdyvmuY7TC918fTVIXeOrKdm4YvzeiKiOP2WZJmeTenEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJQp5LnvRu+Lsc3qDb6WkZP4+QwKlHSumw/vknLoROs=;
 b=iKUgPOEFFggGNqR1/VkdA8eNpyDT8Q7F7cPBBGym4ojtDLb6sHDpkRcHi0IVARrJkX5Va1gSoV5n22chrNvQJgqV/GQKfUYne+/3YJafD8bF5wk8sxNVoFecv7F5AvboWU1VcDeCEDkdA1n9Bka9yERI/vBtAMGOw8IWzHHGOaJHBWs3OW9SuOQ/xSN3YGaAliqm8f8Agz9/Ul9OXSEX7LlzjL3lFc2xLoPO7TarzAVNtAQ8J1wc0AhYnlA9zEmz94No/DBjLZFsk2dj0p9Ns/HLPIlKmQorzpDifss+ZP4opM02DNvC7tBLcPuLLTYiRygp9KK6TsOy4eriDEL+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJQp5LnvRu+Lsc3qDb6WkZP4+QwKlHSumw/vknLoROs=;
 b=YFupznq4d3fMLp1nPnJsDKLUflxxnsW9lmw+rp0tFMRLkF879xDR42lMyjwvVhsFlcsFUe1V7udse6DqdAUbDF/g11hvmHP9ppkVsswgh+i/yv9DudmXFbgys4ZPWk0ClGcbqoO3obtWqv/nYD/AIwNvSfqx7p50fKK30JPKm0eERcNgxKdLM8A58qwJqyHBG4B61mQupHh5xv1uzIaDyHeUsaigUAzacIzkg/v6GkCu3cdQGFYtzWh14aJd2rIDGRhXM9xWKls1JSFy7d+AST2TIlLZuqAvCGF0+2MYvfGXU2zHjBMMk/4d+0lVyYiydx+M17lwLymlgLQ474AMVA==
Received: from HK2APC01FT029.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::4c) by
 HK2APC01HT180.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::467)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sat, 8 Aug
 2020 05:20:38 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebc::53) by HK2APC01FT029.mail.protection.outlook.com
 (2a01:111:e400:7ebc::195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 05:20:37 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:0C6BA96BF13A918393EAC09FC73D94019658B39743266A651F011503153C9382;
 UpperCasedChecksum:37B39E05CD859E3FAA6D47E5BC1E0B3A597BD522D615B78A48D8C89CF85F4690;
 SizeAsReceived:7681; Count:49
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 05:20:37 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/4] Define ePMP mseccfg
Date: Sat,  8 Aug 2020 13:20:28 +0800
Message-ID: <SG2PR02MB263487F8A1ECF35FB6DCD3E893460@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200808052031.19523-1-weiying_hou@outlook.com>
References: <20200808052031.19523-1-weiying_hou@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:203:c8::17) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200808052031.19523-2-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.141.129) by
 HKAPR03CA0012.apcprd03.prod.outlook.com (2603:1096:203:c8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.7 via Frontend Transport; Sat, 8 Aug 2020 05:20:36 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200808052031.19523-2-weiying_hou@outlook.com>
X-TMN: [gkAL8ybWFZylAF44vtHAYeYqA/pgC86+]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c305a621-c15b-4684-65c6-08d83b5ac8db
X-MS-TrafficTypeDiagnostic: HK2APC01HT180:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9C2OGMEVaKbIBwOaP/M/3dmBZDXC7+7odvFuJOJRiEVA0hu4JZt3Cl4H/NQThF3x9D8m5y1Uaf765gRWLqFYL7hZZECMwi5j5TI6voPv3hY41ya1VVv1lon8LJd35Rp9laEJdEbKAeE1krp14KWp+uywsVH8q+B8HItb19vGbJzv8oThktp6o9lwg9MQ3tVDGwakIHRZnB1GKAoYN7JxSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: ym9HSxUc5xVHPgcGtuW+InueKbPM3Vb7bz8Qm6DBV53Cd+dqT3y+pdr+mzHdXpeRGdtStioOuNLy1hRaL4ZmWSNyZRyEilZhZoq+eihTaq/NgOTVEqniWAuF2XY67JffKPmN96fM/cjPfv2s0knkCg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c305a621-c15b-4684-65c6-08d83b5ac8db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 05:20:37.8707 (UTC)
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

Currently using 0x390 and 0x391 for x-epmp (experimental). This may change in the future spec.

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
---
 target/riscv/cpu_bits.h | 3 +++
 target/riscv/gdbstub.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 7f64ee1174..9a8a6be534 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -214,6 +214,9 @@
 #define CSR_MTINST          0x34a
 #define CSR_MTVAL2          0x34b
 
+/* Enhanced PMP */
+#define CSR_MSECCFG         0x390
+#define CSR_MSECCFGH        0x391
 /* Physical Memory Protection */
 #define CSR_PMPCFG0         0x3a0
 #define CSR_PMPCFG1         0x3a1
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index eba12a86f2..de5551604a 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -132,6 +132,8 @@ static int csr_register_map[] = {
     CSR_MIP,
     CSR_MTINST,
     CSR_MTVAL2,
+    CSR_MSECCFG,
+    CSR_MSECCFGH,
     CSR_PMPCFG0,
     CSR_PMPCFG1,
     CSR_PMPCFG2,
-- 
2.20.1


