Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94A9C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A702053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iCvR5G93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A702053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OTF-0003ZY-3j
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4HHg-0007dv-EP; Sat, 08 Aug 2020 01:20:44 -0400
Received: from mail-oln040092255094.outbound.protection.outlook.com
 ([40.92.255.94]:18627 helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4HHe-0003E6-JQ; Sat, 08 Aug 2020 01:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzJPYb5y8hkZC6pcCEtpz0AoWJvBFRqXtLqTPvwYEQp+1p6l5Z11x4iFAEdJYWUitl8351pRLuVlrCyLBR0gl7BL/YV4KBYJnAgc9zO4drupZMmhDjfavqelKYJPV4tdh0bt/PtsOH0KRZ4Uzgi3Pcyp2+8uGyRum8QjMtLNv5nZUuFIlFRnLbaWt/9sxaSXqShOls8jDnhFzOE6jz5SBvTqabcP7pgRIvVEk+LTGCLZGAmS4/N0PMGd8XL+M+bO+w8tI7uvYc2Mssfhpcn8oumiMWLkaADEURjUH8FWNVCuW4LRVuAvg1NXdcAcyuxOKDkuv8GL5u7HIGYfxDyQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSe+h3YqVKXjPPJg0a5xr4TuLg8up0FeIB7A9Cx7qh0=;
 b=Um3sRBHvFrtjq4IUD2CR0dz8baZd0GYmKmkCgHHilDvF//XP/GsXC8G4njFT66+jmfC54+fCYhJv25cKdKfRntigG7000GozRmAdn7PxHM3mLqJ//uVELkZv5H8VnfT/BKPilWu95qh5LdR91ogY2sm1a2m9UGWas5tcEuV0w6ufaVMDlCLU5yp/5KdAIkhim5tj0zuMkIpFqaYkwJBAefXY2RJko8Ao0nlSISaaZN0Mvesa+qrW8h7kMtiTgC3KxZJRQ5cvAJ28uipfgeAdcV2NeG7Rj7cApKKW1B0MujjQPcX8j2aCuDOmkLaBZcVJG8Rgdf023v/shf3AwEVlrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSe+h3YqVKXjPPJg0a5xr4TuLg8up0FeIB7A9Cx7qh0=;
 b=iCvR5G936cdBrpdPkOuX9AFIR0h2NY62Oh/D+AWPTit751h0UZF9+o8IOaKSudsuqOfHW7Iet3TDQArgmmH9VFUBuN8ViF/ZlUKXZfJ7lMy1i+9IUkEQThG3Bk4Kh4j+sLkHr9YZIcW5oOVer0SomdnvbN88GNl+1STXR3AFlVzXhvpSz2kWFJWthTdCi1XG7VQOBFgeB6DROHR5vMx/hU9WFYsP2H3k73FwyI5sceQT+aFilL5Zic+6FChABCZMVAE2t/l0gCF6crdtksARqPCiDbaodtUZ5IzjB9TbTjbMBQ+9GOSVo7YP9zwjDF0iWrCNQmnfNPifrs4pImSuJw==
Received: from HK2APC01FT029.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::4c) by
 HK2APC01HT211.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::239)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sat, 8 Aug
 2020 05:20:35 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebc::53) by HK2APC01FT029.mail.protection.outlook.com
 (2a01:111:e400:7ebc::195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 05:20:35 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:B5C71CC384E790BD49414B45C3264B12E30A099D9989B73216F2F4AD5E526830;
 UpperCasedChecksum:A7ADC201C95D80397791566E924D326699EE5CB47AD999C2402A1668A38B94F8;
 SizeAsReceived:7500; Count:47
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 05:20:35 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/4] riscv: Add enhanced PMP support
Date: Sat,  8 Aug 2020 13:20:27 +0800
Message-ID: <SG2PR02MB2634B738EB3C0B1103D077A093460@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:203:c8::17) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200808052031.19523-1-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.141.129) by
 HKAPR03CA0012.apcprd03.prod.outlook.com (2603:1096:203:c8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.7 via Frontend Transport; Sat, 8 Aug 2020 05:20:34 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200808052031.19523-1-weiying_hou@outlook.com>
X-TMN: [/36+pmSwHDZOj1AOi30LIaV2mntlLkr6]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 0f798ea1-a7b1-4d8a-a1a0-08d83b5ac755
X-MS-TrafficTypeDiagnostic: HK2APC01HT211:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlJf9x9lC3PGPH5ZVjKVFEsJI7PQA16VMUjydM2MZJfMndj7wEVH/7gODeYf0cZLGbaRtwqftwxZvTP8lZQCnhV0DJCICr9Mr1qLs6iW6kNcQLXOXUTSwfiPULLZS9FnpzLIJGD/m+zZdXzYU8oMvuZYhj6CDXABEjzJp7CEbWDk8yfuHOQnQ3c6/XKxy/UUuQLv7mzDYH/7q8u6GQW3AyBq2Es47a9Hzqb6gdN+sk4L34k3qgIlf9PkURGT3kZ0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: 9Rg4YuZvvH2VQ5HV/mwj60r39BEeAW8v8ge98ZMYnK3RdNUYnyS+laTtn5bf5vBLk7aJQ0Da2XxXQdc29mtqltV64JaY/g5Daqqcy0ryqCB/wd3hoIafQbfiX+DHsBqvD3vHrHGjQk3za7/naDS4Ig==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f798ea1-a7b1-4d8a-a1a0-08d83b5ac755
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 05:20:35.4975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT029.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT211
Received-SPF: pass client-ip=40.92.255.94;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-HK2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 01:20:38
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
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ePMP can be found in:
https://docs.google.com/document/d/1Mh_aiHYxemL0umN3GTTw8vsbmzHZ_nxZXgjgOUzbvc8/edit#heading=h.9wsr1lnxtwe2

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


