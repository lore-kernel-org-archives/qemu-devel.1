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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D844CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79642053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NkZ8iI8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79642053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OWg-00020P-Tp
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4KfA-0007MA-Tc; Sat, 08 Aug 2020 04:57:12 -0400
Received: from mail-oln040092253084.outbound.protection.outlook.com
 ([40.92.253.84]:42521 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4Kf9-0007Ex-AN; Sat, 08 Aug 2020 04:57:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBRoc1QoSHVXfBBoaHPt7mD5/MoKnLY17coVbQvifK/lF+dX8zJIhE+mCntjrNN9kIJPDU8WcA0kRbKuZr+kgQ13vYKQAaUdkOvIE9xLKEEkOeKK62zmiDBIeTuSBndSTYTilHcxTcV+YqLiTHnZX2+4XJpRvYkYB/5sZFF+jQQMAxfecKTKVou6+OQ2aZgqvvuUJJNVQAf3Ktcin25KnyREn0JfD68F9x7aRmQI8FHjFV6OaNs98K2DXlep5OhCnpfG8gTDwInkR9JmI4r1QdGS1WbCmQwYmK9mahHDZvVBDA94arVtQ9oWncz9J/10xEveHxfnYzCj6AxctFRyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9e/eHh2eUxi/aXJLtQZjs59sug1p6gsWr7t02S4niM=;
 b=UDbHCoKqOfSfdQjLvZcZV53ZX+uTZaWvBw2kqxXulQmrT++Q7Mu0LWMqjIrlNBNJq3CGb9Yfg0LqwJA6tUgPq/vOUeOJ9VqwCdeQWPvYn/YtvxD+Z5KIEpWFS4tYInrI48uLyyF9ZvsLR/DO34flZ8+NPzPEJFxa2+Pm8HWj2qSmONlhb/N15jfqDnw43j8H09uHjhqq0TRdp/UgJeNF1ZADpkHIYamTFDSQkiqDAz52g8KoFt/XZHIr27RIHVk6RI4jUOVH/62OPfk/nyZynkUSIyCl0d8i22xIIdoi3tzE8MZmSgPgsU/W3zaz1BsF/FqmcvPBWKisMEm33FjeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9e/eHh2eUxi/aXJLtQZjs59sug1p6gsWr7t02S4niM=;
 b=NkZ8iI8FRiESkJqlQd7abR9JJPzeQUybih6mnmxk6kmhtK7cjRC3RC4MH5vV2+25OcnJy+bGYz+oJD+/gjdAnANhjfy6prh6YdYHyetCJBDjacnRdmzNk3/9wwPlS2jocABah029Y3etImFTEzuma4dpzNYRvRZtJOug+bUAU4sHGk4e59QUODhWruhwlox0EvKmvnDli/xVsIVdWga8kHrICUdUv+L0TiVN2Bc1aTjWP95vVc9DcE6KTn1vtyEdyKCRD3kzjXPcKB3anz+X29Z4Qs/725RTwzWr+RcXSKIBQSLpsENfer5iT9OVwY5v/9EZHEOWell+WasXYEi5Ww==
Received: from SG2APC01FT013.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::51) by
 SG2APC01HT147.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::345)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sat, 8 Aug
 2020 08:57:05 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebd::50) by SG2APC01FT013.mail.protection.outlook.com
 (2a01:111:e400:7ebd::186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 08:57:05 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:34BF807D85E90E2F2731DB2CE927190CBCEC110B3223ECE578DA9F2DE8C67FF7;
 UpperCasedChecksum:1E6674525774A83B0B38971123372C13D3FAC50EF641033E0F95491FF57AA09E;
 SizeAsReceived:7681; Count:49
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 08:57:05 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/4] Add ePMP CSR accesses
Date: Sat,  8 Aug 2020 16:56:55 +0800
Message-ID: <SG2PR02MB26344A00814B6AFEFA1BC2E593460@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200808085656.28692-1-weiying_hou@outlook.com>
References: <20200808085656.28692-1-weiying_hou@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200808085656.28692-4-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.139.46) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15 via Frontend Transport; Sat, 8 Aug 2020 08:57:03 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200808085656.28692-4-weiying_hou@outlook.com>
X-TMN: [LV46WbZz4rJ2PGfMOP0YaR3+8UK6O+hq]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: ec5bee50-abae-4741-0a50-08d83b7905f9
X-MS-TrafficTypeDiagnostic: SG2APC01HT147:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KoSsbKrIIPy2fl/t0msT2QlmznefTQjWqFqyxGraMmF+rvrk3kcZ5i7SP1P0smqF17MvanSi1zG4tiKOusP9gbWO9/8NrkSDY4E2wbuTcF6qE47Bty2oaSlTXF6dWO+4To5sokF0tcLWzVxzmZJpna3zlrrFIvwzv8Ogk4+nm8zGZ9cwyvgXSIeCfJpdbu9lyNqkFhrqkmh2cKYdZij/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: NLhYdqwaLDQ8CjHNdhV4R7ue5moSs4JTHrQ+fr09jzMWQl2afgBcacyBWh9+2VkcxghLHY9fB7VMGfm6dlNMBPtRA4ol6cHeKrbvv5JOhsPvYLJ3nBE6feM/hPUyzO7j0u2P6IFOGb1+XLDZ5PRrKA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5bee50-abae-4741-0a50-08d83b7905f9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 08:57:05.2874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT013.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT147
Received-SPF: pass client-ip=40.92.253.84;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 04:57:08
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

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
---
 target/riscv/csr.c | 18 ++++++++++++++++++
 target/riscv/pmp.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 11d184cd16..e2395e3a51 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -112,6 +112,11 @@ static int hmode(CPURISCVState *env, int csrno)
     return -1;
 }
 
+static int epmp(CPURISCVState *env, int csrno)
+{
+    return -!(env->priv == PRV_M && riscv_feature(env, RISCV_FEATURE_EPMP));
+}
+
 static int pmp(CPURISCVState *env, int csrno)
 {
     return -!riscv_feature(env, RISCV_FEATURE_PMP);
@@ -1160,6 +1165,18 @@ static int write_pmpaddr(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int read_mseccfg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = mseccfg_csr_read(env);
+    return 0;
+}
+
+static int write_mseccfg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    mseccfg_csr_write(env, val);
+    return 0;
+}
+
 #endif
 
 /*
@@ -1368,6 +1385,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MTINST] =              { hmode,   read_mtinst,      write_mtinst     },
 
     /* Physical Memory Protection */
+    [CSR_MSECCFG] =             { epmp,    read_mseccfg,     write_mseccfg    },
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
 
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 8df389cecd..0eabaf690c 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -490,3 +490,43 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 
     return val;
 }
+
+
+/*
+ * Handle a write to a mseccfg CSR
+ */
+void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
+{
+    int i;
+
+    if (!MSECCFG_RLB_ISSET(env)) {
+        for (i = 0; i < MAX_RISCV_PMPS; i++) {
+            if (pmp_is_locked(env, i)) {
+                /*
+                 * Now that mseccfg.rlb is zero
+                 * the value of mseccfg.rlb should be locked.
+                 */
+                val &= ~MSECCFG_RLB;
+                break;
+            }
+        }
+    }
+
+    /*
+     * sticky bit
+     */
+    val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
+
+    env->mseccfg = val;
+    trace_mseccfg_csr_write(env->mhartid, val);
+}
+
+
+/*
+ * Handle a read from a mseccfg CSR
+ */
+target_ulong mseccfg_csr_read(CPURISCVState *env)
+{
+    trace_mseccfg_csr_read(env->mhartid, env->mseccfg);
+    return env->mseccfg;
+}
-- 
2.20.1


