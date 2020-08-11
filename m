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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B111C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226FD20716
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nBbMl0az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226FD20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5I7P-0001bS-Ev
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 20:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k5I50-0006zy-0d; Mon, 10 Aug 2020 20:23:50 -0400
Received: from mail-hk2apc01olkn0827.outbound.protection.outlook.com
 ([2a01:111:f400:febc::827]:18848
 helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k5I4y-000211-5p; Mon, 10 Aug 2020 20:23:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go72V2WjOFSDiiyg3Czu76BqKCwBwENKJoaWkJSW6gaH9qK3/QtdXse2rEOXpVa2Bv2RiTTp/M+vzK3BTmXvwRVOyLYgWuPc8yZJs17Lp4v0F2+gESpWD5Dfi0ID/NJy8IKc1JBczM/Mzon8gQqGaE0xPaoYrhc3wcQjj+flp7Xdhg5qPl2xpW4yG9yVvRaw6hCT9Igmb1l/wjxLWEsty5rTYKWgs/PSm7T3T3Qd8oe4eAt2961zRVp++sOh5qNogiY/6J4DwZEqItTvc7ubGkzT+4yUNSw4u/jDAC7yKxy5Vj5Mxea1tZtogbucfoD5bO9prHrSmhwemnY10jJNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CerzXq5Ps3KaIL30Ekb17zswEDoM9iiTlvy0qqmJV8o=;
 b=dysXswreLaIx9UR/h1gxh6j6Eo0jy44gwlAdIpD9hmCDFQLaFwbP8UUsoQsKVtmyduMuML2V3+tKen3acGyi8imdzVnjNZ+hdxs0f6OGQma8FaBDrPhc0NdPMv6w97gztoXp8rutB5+D9nDukHFeOEJlu9uvnysMF7tj8sUwPuuX7pc38JI464B9pSaxkdj/lKr3Bb90AdwblIxrodYQPb36dejnS2HT4zJUnnb7nqAWc0TPpqZtV6xIgysSKmxZyOXEpzu1DA1zXthMmTJxyeChu1khqFdcw92oFy4Ky4iUYoBnEwJvvW4lDU2ozUga58WIPJnj/lyQiTQlF4xihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CerzXq5Ps3KaIL30Ekb17zswEDoM9iiTlvy0qqmJV8o=;
 b=nBbMl0azJPz4h7Z0CbvfwUDsHZhHAJ0TPACux7qkuSWGZdBPcvEjIpS+d1q3mGb9+pa2Ktux6Y/4t2YSgyEembbYrMJM6Xph9qh+3dL+tnFii1EKZn7hqCMVltN2958pFF3BRiKLn8cFjJkC9FhxZu9MoLJHBJTzGvHfAGm6f79cNsZl0rpTCQJMmszHtjsao2wOHAJlloIBUlRo9wqN5Wm/bpBVJ7IgjoHU63mspxoaBlPaMtzBQfDcEgZ6q9C6Moh5ncZOtZGRb0lJ3a3laAml1/qIjFRgIBXoKrlg38/Hivra8Rwoj19a7lpa167MIZqlBofZS5ZRnq2q9xFlBQ==
Received: from SG2APC01FT057.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::40) by
 SG2APC01HT214.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::267)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 00:23:31 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebd::4c) by SG2APC01FT057.mail.protection.outlook.com
 (2a01:111:e400:7ebd::389) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Tue, 11 Aug 2020 00:23:31 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4F717F9EA4F324911856F87F97D2817017D306212E503FB7F17E666B1288E014;
 UpperCasedChecksum:3CD44E51BA36FFFC40E267540DEB79A908D2FF8CB41BECBD3C2265AD22F62BE2;
 SizeAsReceived:7691; Count:49
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 00:23:31 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] Define ePMP mseccfg
Date: Tue, 11 Aug 2020 08:23:22 +0800
Message-ID: <SG2PR02MB2634D85E5DF0C2BB540AE1BB93450@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200811002325.46056-1-weiying_hou@outlook.com>
References: <20200811002325.46056-1-weiying_hou@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200811002325.46056-2-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.139.46) by
 HK0PR01CA0050.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Tue, 11 Aug 2020 00:23:30 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200811002325.46056-2-weiying_hou@outlook.com>
X-TMN: [BPtoTc6YTrn8byDN6+mS+QFNYjcUKbXN]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: cb081333-2b4d-4684-5f47-08d83d8cc6af
X-MS-TrafficTypeDiagnostic: SG2APC01HT214:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RnFgJ9b38ky3RKQBwFum+4jiMK9F9K0qJ6ubAeUrrLVAj0VrzghrZtOqFQcTzDR/aSEwTBbp6jevTfYgnkJXhIu4gX3QwGIsXi5qJ+1c1lgzBhx88ZkmfVH3PgoFJL+7ReZmfkSlrmxnOQzU+tB4HKDKiVaAJJWu1I3+meQ4EhhODCHw/dLsDcEth1EbGlV8KeLCxV/Yz+eA/x4BFhE7Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: zHv1Ml/60Mdm8dGhFVbKru/E+/79gBV26ileJpy3oYTQNkXsOg8X3OFARdgxCmNg5AqBX7aXvh5xhtSjs0qlEBSZoQlrPoV1kEKGjPkSli3EZui89uv9EaIIaGI1/S74L4chU5FFppnoX+0DaieQAA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb081333-2b4d-4684-5f47-08d83d8cc6af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 00:23:31.3084 (UTC)
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

Currently using 0x390 and 0x391 for x-epmp (experimental). This may change in the future spec.

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
---
 target/riscv/cpu_bits.h | 3 +++
 target/riscv/gdbstub.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 8117e8b5a7..9c35179983 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -229,6 +229,9 @@
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


