Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFABC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1058220716
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 00:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OlA+YIg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1058220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5I62-0007xj-99
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 20:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k5I4p-0006gb-BH; Mon, 10 Aug 2020 20:23:39 -0400
Received: from mail-oln040092255024.outbound.protection.outlook.com
 ([40.92.255.24]:37299 helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k5I4n-000200-4j; Mon, 10 Aug 2020 20:23:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asgY9fqENjrWG+6+/fteRegOVHC7R14w8szJ6mk9q+yVH+0HgksUT+NKRzbWQ713wUG5sH67UYnJ+kr16c76whXwrR2pmc83+9EYZtDX/hSuPF20lNehmXkPvSFYI8wK3inf531i7VRl8F+skX8RG3HWhBE0opo7kNnTA+BWacr1jBS9OWk3kLgN5kncPOMlWZRr2jBSA64sn1ZYewlToPCeGMfpT/imFPrBNDr5cgfB+OJaSykQ41PtypAR987AaaizGYyll6rBUvl5G7x/QjjOmGTDLRj3cCLVGEnTeIvUJI9PZnQlhx+30FUU47G+yTjcpOHVUjOGghnGWd1ERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NguLQaFEZBuLOjw5huGrCl6lfp+dmDlrkXb1bqVvNyg=;
 b=d39fLBAFZviNYEpiwnhm4ICAmruKzYWjb+OSYKBXG9v2yzITpym+vnGy9r0jVU6e5dUR9m+rt2zE7Db5gAXoY+JnX3aBFlUPB+uYOn99k1iBGjhhR7QBWD1zdIV/xP83gauHanoego/pJmUjT1I+FdBAfPNqBWSmbj/u8y4qpSOQ+1y994o/yuiuy7rkg7Nomj8ZFsPMOWrFjuYLYZgzG0aXrrq4mTkbUSHpO1Gkb1lg6vaYybCIGhMFGd9zZq0ovJzNjZ3siWYJT0gsg54uP5uX5ZBJyzqRMAmWWyEuESZKxHubPZq9tW1JjAwy6HFKB9L3Q+bmSHrarYhFBO0ylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NguLQaFEZBuLOjw5huGrCl6lfp+dmDlrkXb1bqVvNyg=;
 b=OlA+YIg5VHhk+caMLuwpelMLs4yGVorb5eG+bPLUmSzbw9AfnIo3/Wu6qHZrJX3Ven/0CPJgjaTMrh10EnIRCZ46mBXYON/7+G4jzMutFMI6eN2uuEH/5WPu8FU2fhAmWQ5ibsJ8cqarnzOUhdV+tdlQxrrEgHg2E1kT84TIgMa4BzwpxB3dl9oNRUmrE9qdr1uR9D2CodHghGjGnTVQU47B1qpe2BJpXekCiUSInEl0RMeVRoq5CHFHrYpwWf+DBm02VZeweOMBQD5Vz5qixvTJPuSVGm7oJr79e4sYjdrueTKBluuZgzzNtwq8AAEk3HJ85DuLqBlGlHaGhyBq2Q==
Received: from SG2APC01FT057.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::45) by
 SG2APC01HT141.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::363)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 00:23:30 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebd::4c) by SG2APC01FT057.mail.protection.outlook.com
 (2a01:111:e400:7ebd::389) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Tue, 11 Aug 2020 00:23:30 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A5D1BD764E4DD9772612D0E56AE0F0C1556E1AD6C5ED29BB985860BAA5FCA7C3;
 UpperCasedChecksum:6C6846ABE1A1C26B8888172AB12897970234B22D30E82347BAC99021B0AA097E;
 SizeAsReceived:7504; Count:47
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 00:23:30 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] riscv: Add enhanced PMP support
Date: Tue, 11 Aug 2020 08:23:21 +0800
Message-ID: <SG2PR02MB26340A07DB8609F72486202C93450@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200811002325.46056-1-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.139.46) by
 HK0PR01CA0050.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Tue, 11 Aug 2020 00:23:29 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200811002325.46056-1-weiying_hou@outlook.com>
X-TMN: [KrnAezB6yDSFZgF39g0k4hAcD5Buub5l]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 7331e4d0-9408-43ac-841e-08d83d8cc5ea
X-MS-TrafficTypeDiagnostic: SG2APC01HT141:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLV2X5+bylrJi6oVfsq2TJ1Bj0wcoQUDQcI9PBa2lI7bzWtLWtjqFjj9kFBy0A99fZCwN/tDiLTEfJNFu5cLYtGdlZS9JKavo//uPLHIy80oefJYiMv5pM1qj7Y7dY5wdMKcjQdSFp0gcHB3haG7yG29WDJW6x3wmxJ3VGvR1PO9EIk26pSsIhObLVZMlA7e722mvaLt3GAFGNYUbBdivw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: PIxJaScdtbmS/HqmI/LsK3Bgti7vWLp9C08b9b4O/6EUi00egRvimqtzXFb8dGKHqSGFJiOqB9tcvkG5NfTQrqQip9fTU9R0s9RU4o+ZJggFiN58vEOEZ7CLOWc7lUgiRdpjgJyRbGaC8j4Xo+4kDg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7331e4d0-9408-43ac-841e-08d83d8cc5ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 00:23:30.1610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT057.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT141
Received-SPF: pass client-ip=40.92.255.24;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-HK2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 20:23:32
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
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1 -> v2 :
* regenerate this patch based on the latest upstream

Hou Weiying (4):
  Define ePMP mseccfg
  Implementation of enhanced PMP(ePMP) support
  Add ePMP CSR accesses
  Add a config option for ePMP.

 target/riscv/cpu.c        |   9 ++
 target/riscv/cpu.h        |   3 +
 target/riscv/cpu_bits.h   |   3 +
 target/riscv/csr.c        |  18 ++++
 target/riscv/gdbstub.c    |   2 +
 target/riscv/pmp.c        | 174 +++++++++++++++++++++++++++++++++++---
 target/riscv/pmp.h        |  12 +++
 target/riscv/trace-events |   4 +
 8 files changed, 213 insertions(+), 12 deletions(-)

-- 
2.20.1


