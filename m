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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5998DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2726F20866
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GLqbaeSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2726F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OTH-0003d4-8t
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4HHq-0007op-6a; Sat, 08 Aug 2020 01:20:54 -0400
Received: from mail-oln040092253026.outbound.protection.outlook.com
 ([40.92.253.26]:6035 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4HHo-0003EI-HF; Sat, 08 Aug 2020 01:20:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kS3T6869WkAZa9m8PAMVxIJNPxWO2bKickl0qavP+dFBJ4CPy4wBX6f1aa5fCk4k9Rt15mWKNJm/cbofkYu9hzvTMkEH6YFwxLkEUqa/076tkjcFWCSulsstPw6Vt54CxYz3JowrRj4XwBLPcJmLPIij7aemBINtkpotjZDv8LiFUZwosOZQqBv4T2ZqxghMtitTypBaQw9ZigPnVvxGZIja5NPWow5DeVx8jEHnWYoJgrj37SyowymJZTX11Lofs4s2KJd1zsdaBJPlizzi5hlxJJjgcLq0VQEEaytPVo6XoDWFM4qEWm7Z55UskLTR/yksnNwrptkKxLs7Y98m/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9e/eHh2eUxi/aXJLtQZjs59sug1p6gsWr7t02S4niM=;
 b=N3WC+sk1vrsh3rFfDH52D4bv83nMxB+qIVupbBppjA5z7D08Mi1godUF5Qx9sLvAGQHI/Mf07IvIDE5pTDvoHT+7rds3wGhhjcu9kGQ2Pna0s0YnyK3YzvjvOQ5jLuGbNYPPDsO5RhEhhuo7Z3pBFpuYv7R938zKoNbsJc/3NL6FdEY3hDHfe/jIvGAvohJEOFiWdt1d6X7SCGsb3lORafQKocGvoQKwr8kwUUwoJRoE1E0cIoMBh0Se0MVZuEST2H69iB3flwyuQq44K8nXZY5G7IBhesY75sEb7dGTcjJuICMS1h4Kbpy6WoxiqeIFEafr+m7jSNKhlQNAXPCAOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9e/eHh2eUxi/aXJLtQZjs59sug1p6gsWr7t02S4niM=;
 b=GLqbaeShnreu271hyG0EDZgt8BrDl00ZQwwcn87sAO+WojyNoHh6aMn4LFPfomT4Qt/STefl9auEUv7zoapYD2SThDPCnquAYZkj77Lx2ESS72ChAgUI30ek+POu1WfcDsCGeJffmRSqUqgNYuS60Yk+ZueOO2FCYt4vfoXZQ97LHA4py27CCEjdDqHRqOi9HFohcExIhXBRelPGZ5yKQlvCHhTDs7cD+uX8PYYEhdTbwH2kFrIIlhlS6S0IAJYVKD2Gd8PpNhL9O6+3bw6tUhnFFS5EBkjn5jk0qzO4meEwE7QSMU0IHPZJH4AvEWSaqQWe7WDrAsQUEjkSI7vNpQ==
Received: from HK2APC01FT029.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::4c) by
 HK2APC01HT185.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::277)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sat, 8 Aug
 2020 05:20:42 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebc::53) by HK2APC01FT029.mail.protection.outlook.com
 (2a01:111:e400:7ebc::195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 05:20:41 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4609F4C2EB12B9FE654E253DE08CD92D385379B642D5DF352591BC0641D4220C;
 UpperCasedChecksum:7D62A51B6E5CFBCF8F5AC4A5C2992272E61731603618BEFC4F328D6C0E3CE1C2;
 SizeAsReceived:7674; Count:49
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 05:20:41 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/4] Add ePMP CSR accesses
Date: Sat,  8 Aug 2020 13:20:30 +0800
Message-ID: <SG2PR02MB2634629878DEAAEC3C8F13D693460@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200808052031.19523-1-weiying_hou@outlook.com>
References: <20200808052031.19523-1-weiying_hou@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:203:c8::17) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200808052031.19523-4-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.141.129) by
 HKAPR03CA0012.apcprd03.prod.outlook.com (2603:1096:203:c8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.7 via Frontend Transport; Sat, 8 Aug 2020 05:20:40 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200808052031.19523-4-weiying_hou@outlook.com>
X-TMN: [eVH/KVaYKtbjqk6dri6NhB+oII+/9cFf]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 4d69a239-c53e-4e03-aa62-08d83b5acb23
X-MS-TrafficTypeDiagnostic: HK2APC01HT185:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FMbIrGxoVK6RzI+QnPaxa1EKeJzmkKLuj/fHd081CA37scH8dDKyVKDDxshHAGKrVIYK55gZe+FHtPy9T01qLLTBHAsboQUdSoWnXpBIoqF9tWHckLROfgLCcpIVbMUoUcWCPAOzHe9swU5VyDv1pLi5FCqHTau6r6gpLp0QCquYrM1T5GpwuKK0ZtDwKO2kZaID4QCOyJTZNUSu3IadOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: swsS1MDqZaJ/JMxmyow1TXVu7wiq249vjhNboYEkTxKEKLHaKtzvcaz1C5nvIN/ABTngCCgSO8/wFeHnWRPnirLtEE0JnP7ByijaZ6OFkv9oMnVO1J+XRDw68P0Ce3wOmpApbHb1a9mO2cZNTb8AGw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d69a239-c53e-4e03-aa62-08d83b5acb23
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 05:20:41.8904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT029.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT185
Received-SPF: pass client-ip=40.92.253.26;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 01:20:42
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


