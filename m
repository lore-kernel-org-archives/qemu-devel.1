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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E07C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A25620716
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KLhxqTzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A25620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5I8O-0002TN-DZ
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 20:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k5I52-00076g-MS; Mon, 10 Aug 2020 20:23:54 -0400
Received: from mail-hk2apc01olkn0827.outbound.protection.outlook.com
 ([2a01:111:f400:febc::827]:18848
 helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k5I50-000211-RT; Mon, 10 Aug 2020 20:23:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aksbvnrs05CL7nlvM1rV3K58xnqYqF6A2dbQ91lsoII8dRvMT19RX3scpuBQNGtZfVSX7iO+udRxkp5WXD4LsYbArZNBcuWXyb34F3a8AIueSfdaU4JMsoKcWBJnQdf0Az8TjBkj+Wc3d1ofDdfa42n1JWWQ89bvNGgBaK7fPUtum3LjF2kWgeTVVVZqcGW5cOrfk2ES78DWx1GzgMI+6yZr7jxYTxpDe8OXPsm0wSjetnbK0zDnvEEP4Z9z3IPki6N+Dg1ewKBD25Ig2ilNKojoCKwPQnvf5YjNqrwjM06EqJIN6CHPRvlpCcgGgzuD6i7R52l0o7zoHF9eFQekLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdGkXH8F4w3dyBYAEE3eSCxz42ACBtC8kQixFIYGVCI=;
 b=FF7pJXFndLeKaYSr++ohl8fkgFqELZpF2d1agCjhz+0l63h42T1UBDWlLJOzczJPwzioPmcF4e0biS4LdQUpJGFjM+LpMemfWsLRBOb1a+lbMAIq7Nj+Wr7SNG+xa92vze0KIO4UUNwZA6IbvfmcvcZvu3qWLszS4gfOmsQ4TsMfH5RpX73eynXxTCbxhIjoXruZmRDJe8B37vnBVsLSnvTE5AVKn6HWoQ7T+HXrhwE11IhEZYHiZIDJ5n6C6G89V50zwBZgXo44zGRqKuXiUgqKAVFWoiT1+28PLbOo/hHP9SohWzh23GhSzDTQ7LuC2Ao2CgcXV37aln0+gVFNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdGkXH8F4w3dyBYAEE3eSCxz42ACBtC8kQixFIYGVCI=;
 b=KLhxqTzMwp97bNCgyR+5t+W8eoLQbTozlu/Cuni99Wr3dZdpw2PsmoyM5S/V2TqB/dCF22E35Zsl7qY3By8y2mD6Aihb9PR5afsaSA4bMM6w5zmIAAnB6PRBm7NeROPWaoq4zvcOKiZZ9twECWvY61ZCbwPO1sl7GzDdu4+F+8QmNoRVJT+uYOPVFjwUo9koslBAEFyWwyTMABRFGg2w4fDdPlkonJSMp1ihOQ+eqyG4zF916pKY17qMdDZkQbPrr3loC7h5Aw1xOB1xiyheieNLkheYO2qBUGeThvv8WY4FsSrvpT5dBDN7Ht+qMqtap3kEgCDSMsnjX7X9K5IzAw==
Received: from SG2APC01FT057.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::40) by
 SG2APC01HT214.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::267)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 00:23:34 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebd::4c) by SG2APC01FT057.mail.protection.outlook.com
 (2a01:111:e400:7ebd::389) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Tue, 11 Aug 2020 00:23:34 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:30FEBE8ED4FE323B2093882BF5BB95D7281322F16460E495CC7E42B1C498C521;
 UpperCasedChecksum:CA6FC02BA149E3F7663F15882B23E6578B87B63157FEE4A4D7A76A4A186ECDD4;
 SizeAsReceived:7692; Count:49
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 00:23:34 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] Add a config option for ePMP.
Date: Tue, 11 Aug 2020 08:23:25 +0800
Message-ID: <SG2PR02MB263458D195A60A57C05EBE9993450@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200811002325.46056-1-weiying_hou@outlook.com>
References: <20200811002325.46056-1-weiying_hou@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200811002325.46056-5-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.139.46) by
 HK0PR01CA0050.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Tue, 11 Aug 2020 00:23:33 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200811002325.46056-5-weiying_hou@outlook.com>
X-TMN: [Ds+cNC+tOFcDZv48zO7ufvMxjR7Ggn+l]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 1ecaa089-4ff5-4317-3cf9-08d83d8cc8ab
X-MS-TrafficTypeDiagnostic: SG2APC01HT214:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AX6ML41wzrroa7syfRdgX7dvJrfSiGeMxUcSRkp5ZG3i9URwJQdaRRuZstnN6U4JBfrauuuvHjw9pY9cOB0zYhnLSaSIW38HCXd9JxO+WyPOrRgMNQ6zPmi9udrc8KgVLU4cERK48sZBvN6GEsagg74vC4n21BSkicdIdYkD/AT6HFUwrZm1sQmobq8aK0jYasW7dXVV81pEBruBHDHtDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: n9e/bFJtwpFES49ObC0n4iVc1DiXmbj4WaelH6tAeFs7E1wWhXKS/5OEONBqNWIWxxu6lNT4TpLx8pjinYG/CThCFETXbI7ZxZq1jvnY6TUD44SW7VRn4ZynBiSodfWyTvdg9bkP3VwLD3KYLWP+Vg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecaa089-4ff5-4317-3cf9-08d83d8cc8ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 00:23:34.6103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT057.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT214
Received-SPF: pass client-ip=2a01:111:f400:febc::827;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-HK2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 228b9bdb5d..d691d6ffd6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -371,6 +371,14 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
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
@@ -518,6 +526,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
+    DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a804a5d0ba..9a813f3f1c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -73,6 +73,7 @@
 enum {
     RISCV_FEATURE_MMU,
     RISCV_FEATURE_PMP,
+    RISCV_FEATURE_EPMP,
     RISCV_FEATURE_MISA
 };
 
@@ -217,6 +218,7 @@ struct CPURISCVState {
 
     /* physical memory protection */
     pmp_table_t pmp_state;
+    target_ulong mseccfg;
 
     /* machine specific rdtime callback */
     uint64_t (*rdtime_fn)(void);
@@ -291,6 +293,7 @@ typedef struct RISCVCPU {
         uint16_t elen;
         bool mmu;
         bool pmp;
+        bool epmp;
     } cfg;
 } RISCVCPU;
 
-- 
2.20.1


