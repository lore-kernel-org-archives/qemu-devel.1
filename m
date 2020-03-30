Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655EEC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE8B206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FPrmqpmW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yqrstLWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE8B206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIpn8-0002FO-AH
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 04:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3512bc3a9=Anup.Patel@wdc.com>)
 id 1jIpm7-0001Jq-CF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3512bc3a9=Anup.Patel@wdc.com>)
 id 1jIpm6-0006Ym-G9
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:28:03 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3423)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3512bc3a9=Anup.Patel@wdc.com>)
 id 1jIpm2-0006Su-NM; Mon, 30 Mar 2020 04:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585556879; x=1617092879;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=TeDob4jTooTQ0SaI+srBUGEft7j0B2PAftK+2fEn1nA=;
 b=FPrmqpmWqNBc4mp5/cc5IN/6oF95EkEBOvcinf8T/1q8OOJRJXcHj65w
 M14The+Uhs+Bv/ra2/uq2OgOy/U7OB9OdY1DCwyBfpP15pMrjzGdgFlai
 +IXeiTaIh3UB5tagDoYg6+IJKVppeaXMa2kTJF5ijAP8Z5kZYQ5/AnQ2y
 7bog8EPhNhcbeXtRBVT0LVMgPVYNnvxCxu7nYx4wFal8TcDqaCSEvXhYg
 HfAvTeyHgg6KfWYAWdieMoFCqBBkiG2M51LKl1bBCeFK63wswL+7+n4ZO
 e176yczhL+QakBHp568j7ig4pAGidLC9EOJ2WcxJdG/4sOm7CxWowu2or A==;
IronPort-SDR: RypFr00kZ3qsWvfLo9VmyEJP2CMcVT8v+ImCp3Vn1QclTt/jIazhzzCX62TCpidJAvZ8ilKxQo
 jecRGm0xKumhUlpikGBwGL8zZ4bqZ04r8O9Tr5/SOokq0U4+BNFb6nXNL6yBM78Hb5cb19Nfvh
 yZQRAwPx6AFwRNDdYtxhlU2BKHK2b5pnlzufy9Pmp8UDVfvFBXIPFBs1+aBJSS2Z0iMDf2+CFp
 PUWhXNg2RumJYXPDNLCX1+QrtFtPaNu9LI6F5SXkJPrdN3yaJOvJmpDo5yGMu/345iQD7zoBF7
 v5k=
X-IronPort-AV: E=Sophos;i="5.72,323,1580745600"; d="scan'208";a="134290859"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
 by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2020 16:27:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lt23xUbKowJyUsdapRXF28LyymvepF1BVDWhC9+bMcnE3zqWqCExS9ePYFWB2hCglTcIhFb61r8Tsx22kksrIkRBwAxiZ8qAxcVkx+eC6x7gzC1eLqm/vA8Q1uZCe2GkYePEmW7pzVXndj6OR5IjhjHt8yTUtmcvn940YH9BmmLRFWEGKlBIFbB3gJZCB/r8Abc91ZemrvNX1yiGYjOGwn7T0nwg9RYJPUgMtuQnghqa1gnxez5BFAGmpya8ZSQKh8d/HJwgmq3YE6YpsYjwCZEvJytFrrqje1RmUE6k1fttwJKsKUa/44CPgcQ86NtHHobQXnKPxDKfLPODkcm2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6i2oKT4RVte8HXAFfgwGoSV73wDWEFj6pZMb4b7Pd4=;
 b=LTXO5E7Mc+fggJxMAKOquEX3hJQ1cHEjmIO+aCMKz2VhU/LAol83OHvaEB/lBNh5F68HSd8L/w0lFJTLpq5UgO9oX/NrpoqeaCuvu81u78OdSBnLdlyQ2gTEgUOVZG6FOK81PaqnqQaBWOOtGRQ3Hj1HCAm6Y/BefuXU3eSsjPp9q0s/pDYB89mARqTZbFa1OKpB9B2PN+mapUwUjDPBgwtIjV4Qu5TigPvtayoFGO5AJ9nt9OCcVMOrIZ9JFbLCWkiArrM0CNwjWYGT3BNJ3TOFmUJUdGJbJqfZ185QwTzrkxkmVa9uAgu3DHZgC1fdnDVcEBbzu+nxZ3p4iUGJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6i2oKT4RVte8HXAFfgwGoSV73wDWEFj6pZMb4b7Pd4=;
 b=yqrstLWq9NAAqeA7oxsCoFvNp0GrqQV64jiETzHsFxY+HkILcEc1f1RoxYKNNyTJoT4ZxRcC7OXArgcU0WHmT9mb+tm2WsbxY8VMmdHr/S0LPWf99Up/cuU9vujb93IB8u4SQNOxYuNdo5dbQIPhZc0yWcUimfmJuj8/z3avd7M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
 by MN2PR04MB6656.namprd04.prod.outlook.com (2603:10b6:208:1ed::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Mon, 30 Mar
 2020 08:27:53 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8%6]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 08:27:53 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH] riscv: Fix Stage2 SV32 page table walk
Date: Mon, 30 Mar 2020 13:57:24 +0530
Message-Id: <20200330082724.120444-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: PN1PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::14) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.27.68) by
 PN1PR01CA0074.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19 via Frontend Transport; Mon, 30 Mar 2020 08:27:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [106.51.27.68]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87de9aa5-73d7-48f4-8f0f-08d7d4843d24
X-MS-TrafficTypeDiagnostic: MN2PR04MB6656:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB6656B4449CC60F9FE777E2568DCB0@MN2PR04MB6656.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6061.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(186003)(8676002)(36756003)(316002)(26005)(2616005)(16526019)(110136005)(5660300002)(44832011)(54906003)(81166006)(4326008)(66476007)(8936002)(478600001)(956004)(81156014)(52116002)(55236004)(8886007)(66946007)(2906002)(55016002)(1006002)(6666004)(1076003)(7696005)(66556008)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RkNFZyQ9ccwKTxxWlpOvyDeOfGgAg5k+zc5aVczDBe3w3zGON+xe83DWrmDzHkbI9ola83zZ9YsxM+7FvUaOb9kmi+B32hDE5wF6AliCH3Mm+UN0diBgIlSGhpXg2xSmZW2BZWLgIHslwZecs+hg1tn2swxJ7nziXNIOoeo2dxlKh4S1XSBtw6Wni6CXr0flVcc7OFxWS5+McTWsqhwTAlM1V+JniKe0VJNQWlQ3/4sItRn1KvReU+ULSP5NjodX0fdjk8QmYlntY5uM3OiwCN2V2Dr9Y0XvWLXn/0Tyuq1nplF+4YvfOS++ctgC/6jfImh28KcyoC2iXyWow5dQnImHQ4Bc8Dxx8fBKGwyPnG+Xr6rxj+Aemrdhrx2jUmDXT1WFwGYCBJDn6ZnFpklAZT0uhoEY5RJchkA/s409/1mSHgZXR/jyMbdyEvdHjVRK
X-MS-Exchange-AntiSpam-MessageData: rlTY0iIiobIJl23qVzgkijOaE/ZoXN3kDqi8NOaLTklM89OoOxHbGzZktqJfRXulkjGPGRWJcbYBxMGUd3ZqiEWxu1lesbiYFe9kDBdb6gRbU8I+iqbVY6x8EMNVTiETpKiLsRuD67eEJUHoe8AIDg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87de9aa5-73d7-48f4-8f0f-08d7d4843d24
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 08:27:53.3316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aq8M7IU43JdXX81W39OheLphZfqMNk30+YsJc3IJ69V7FrS76H546mXMreNhR4RwZ8I8h3oWqJtVKggGKfUAMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6656
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.144
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As-per RISC-V H-Extension v0.5 draft, the Stage2 SV32 page table has
12bits of VPN[1] and 10bits of VPN[0]. The additional 2bits in VPN[1]
is required to handle the 34bit intermediate physical address coming
from Stage1 SV32 page table. The 12bits of VPN[1] implies that Stage2
SV32 level-0 page table will be 16KB in size with total 4096 enteries
where each entry maps 4MB of memory (same as Stage1 SV32 page table).

The get_physical_address() function is broken for Stage2 SV32 level-0
page table because it incorrectly computes output physical address for
Stage2 SV32 level-0 page table entry.

The root cause of the issue is that get_physical_address() uses the
"widened" variable to compute level-0 physical address mapping which
changes level-0 mapping size (instead of 4MB). We should use the
"widened" variable only for computing index of Stage2 SV32 level-0
page table.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 target/riscv/cpu_helper.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 50e13a064f..bc80aa87cf 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -559,12 +559,7 @@ restart:
             /* for superpage mappings, make a fake leaf PTE for the TLB's
                benefit. */
             target_ulong vpn = addr >> PGSHIFT;
-            if (i == 0) {
-                *physical = (ppn | (vpn & ((1L << (ptshift + widened)) - 1))) <<
-                             PGSHIFT;
-            } else {
-                *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
-            }
+            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
 
             /* set permissions on the TLB entry */
             if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
-- 
2.17.1


