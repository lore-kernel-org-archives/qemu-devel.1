Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23710C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E445920716
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vDgHlV5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E445920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5I66-00086K-5u
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 20:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k5I4r-0006iU-TU; Mon, 10 Aug 2020 20:23:41 -0400
Received: from mail-oln040092253071.outbound.protection.outlook.com
 ([40.92.253.71]:10527 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k5I4q-00020K-0z; Mon, 10 Aug 2020 20:23:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+j3zJDZUIayD59uTMKjvdKEYPqaa4idGPvaMgcn3h6tjaq9Aq+ISKL6jNgByyzvm3idRTb8rFabrEDJKge+ZdMK4o2odNsBq5cwnoR73z9UUXUHtWVFwlPRNP2VmbikWg+l20Xwz8DvAou4C6k7MlhpJkfJpkEyF4iy0S/+Y3O+fTT8/KA31T7S+w82veKqxFVNkt8QtnN8e0UDgUKDsx754zGL8GxNsS3HYyM9p3TgMqU4B9oz/IMFqg59tXGgEAp/ietl2wU13tWsxeIbilWmAq1mqcCeY8xWAHQ+xUVIXE6C/xwhRi5rwtNbMkmMofG7JH1hk/uz4Maprg/AbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LK3y5egxp8Jg+JiQAVrsEas+5InGjExVksuzCXibGJA=;
 b=kQHAaRHQM01gd4DzB+V/MOTxcn3feLzUlvbSuYZiBUhrQjJU+PI1FYYhabIiCRpG4G4JoribXucFTV3LJXzml3RII0VXflIELEsmDdxQG4R6gJHK75pjHeTWWmBLEw4giwlJip/0tmi56eCYJb6jSaUbgTlTHtjYy3gWIGB1fpbSABMwAbhSWqHf8YtCPG0zjYykME4g7Ytjl+WtK9WSsIesnNmM9kIGdobcVGYQgqIHud8o/zUjy7ik3GG/SUl1hpJxdHUVdtNsvoVxc7SZGBP05qtI/cpXqPMnbWPInJBDGRBFhTzoGfCZBxvOWznhCGR8oaQfExUKTIZMSSKU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LK3y5egxp8Jg+JiQAVrsEas+5InGjExVksuzCXibGJA=;
 b=vDgHlV5QM8qbeMRsvtKlezf6UpI35Dx+iUJfp5AxRlTVb3XNdASkrSBQ+eQu2b6oXs5wtvdQ5r+6E5v7YdETQZvogg4yMufi8xw73OgAu/FoiZvuBVUjkRnkhuZvNkEx6VD+q17Af1qIioORflvEE5cBs8OYRdR6EXLGBhFbDKutsWcK7sS73f7sHUfubv2RFLMHl0raGRaK2LfyT24wBW+dCIxSMFE3ODKqQyKM2hUSDxIw+5/ivVF+kWsV2fUt4yOm/oru09gf+R9p6iHrR0/GPgmz9hV4NuOK2gH2obu8GQNWZPoX3ZT+gcOvvSV8LQQV8VszIpd6Q7+UPVX45g==
Received: from SG2APC01FT057.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::47) by
 SG2APC01HT131.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::309)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 00:23:33 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebd::4c) by SG2APC01FT057.mail.protection.outlook.com
 (2a01:111:e400:7ebd::389) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Tue, 11 Aug 2020 00:23:33 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:B1A5A5747E422C6373ABF61165CD8A97B106A507176AC2FA7CF254275C7466AB;
 UpperCasedChecksum:C68702986F8DD68A01C436BEDF068F00A40C70DE0CBA35AC04D43EF9A7C75531;
 SizeAsReceived:7684; Count:49
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 00:23:33 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] Add ePMP CSR accesses
Date: Tue, 11 Aug 2020 08:23:24 +0800
Message-ID: <SG2PR02MB26348FDC30678B3177B5CF3893450@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200811002325.46056-1-weiying_hou@outlook.com>
References: <20200811002325.46056-1-weiying_hou@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200811002325.46056-4-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.139.46) by
 HK0PR01CA0050.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Tue, 11 Aug 2020 00:23:32 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200811002325.46056-4-weiying_hou@outlook.com>
X-TMN: [BjrZUn27IAmQF7Xo5kWef+pM9g86qexT]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 3c1e508b-6e45-4ffd-f9c2-08d83d8cc806
X-MS-TrafficTypeDiagnostic: SG2APC01HT131:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1EmhRXRi+S5uVD3BMGD3Mucu23CruRI70dKJD509dzoGiZ4kWqZJbtSeFEh1G43d81/FV8swCpIpYkUgbXAjg7nzmgYUl6gvXvj1p0TMs5Sld5H7P3Lkv7GI0Shn0FWc6xV5Ac6QFg9EMFLwEGDvqCoak+0c92jGWkId+lB24r/mgR14Mqyy7NNrCU2X5znbxe6hipbCqQqsOoYDmuYJtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: NgoWCIM7mw7ySQIpRf2g+a7pxyuDXj8VHbAacDFZ4PYgIORap9yM2WK0UW+YfS02TbkJHn+LRtjs5jXcmMZWOqrDRGBEBc7I0APWwpnJNzWh85NaJJXpCJ4mjJvC5hE1UkRHDQWjJ3/q/T4UXL9WOQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1e508b-6e45-4ffd-f9c2-08d83d8cc806
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 00:23:33.5462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT057.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT131
Received-SPF: pass client-ip=40.92.253.71;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 20:23:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 6a96a01b1c..0bb33baec3 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -104,6 +104,11 @@ static int hmode(CPURISCVState *env, int csrno)
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
@@ -1142,6 +1147,18 @@ static int write_pmpaddr(CPURISCVState *env, int csrno, target_ulong val)
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
@@ -1353,6 +1370,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MTINST] =              { hmode,   read_mtinst,      write_mtinst     },
 
     /* Physical Memory Protection */
+    [CSR_MSECCFG] =             { epmp,    read_mseccfg,     write_mseccfg    },
     [CSR_PMPCFG0  ... CSR_PMPCFG3]   = { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
 
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index b1fa703aff..97aab0b99e 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -494,3 +494,43 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 
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


