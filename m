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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4469DC433E3
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136C32053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="G6jtDmLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136C32053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OVA-000726-9b
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4Kf6-0007Kg-4S; Sat, 08 Aug 2020 04:57:08 -0400
Received: from mail-oln040092254044.outbound.protection.outlook.com
 ([40.92.254.44]:60494 helo=APC01-PU1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weiying_hou@outlook.com>)
 id 1k4Kf4-0007EL-Bs; Sat, 08 Aug 2020 04:57:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuhR1Ou55m/ZflQPBexGK+Ac2qIm0TUhhEMDHdTUXuLWWR86oQZUQjeXHibv9yaWYBFAy4nsN7RLUnHlJUzcL2xc/JOUKg0D4ZHo30LMCUHuePsBkWNKZODmwRq8EaI8e20flKaZOOYmL22F552hONf3XA/kqdZS079ybgNFRGevaKZRJAz/0lwymaP3synaLTjYrk6ZbXRC1qMe86VqfT/8SCebRSKP0sRB41fYs3zcYG8fL4onrPGkWOROBe0wiPGqFZs9FTzUaNhD+8WVeQZEiFX/4hbMYJjQB92sl0ArMhlHc2kVRqetY+KI7+0rd4Qjdl1yA/L9aTkq/zy0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSe+h3YqVKXjPPJg0a5xr4TuLg8up0FeIB7A9Cx7qh0=;
 b=Et+RP5gaWqIQNdMHlHj6mvSSKvlpWdDN5qcMC0FFQzpGoO2GPNQew21CcZWal85fyXOhxwHOUjLW+ZbucZuinNX2qPy6vrxpjaL4zvdLDZOWGT4v+6ldfDxPfbiK6HZbn+uUD2Bq9j7OjqEXcSOHDvmRyJRk+eKio4QGAuO27QK8MZsaNeurHAwzJ2vT3ig+cN5R4YR7JVzzzNb8lrvFsc+5OP+GUCF9o1I/0rrsNON4hKtbJoljUjdAyZjhhdOnTne0fd5v/vyH0inij75ABga5A2GJerLQoMkb3RYRPRa9WF6bSr0B5Fdrsh67ju/bR3a6qRLMUYPJuv/yI1bV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSe+h3YqVKXjPPJg0a5xr4TuLg8up0FeIB7A9Cx7qh0=;
 b=G6jtDmLGEEMzgPs4fakKiu+bZJYYSXxPxjKIUxVsTc4o2GWVMVooZ6uIyrlVpflpQOTcPZblrafFaiows89UsZeqadALprobGUp6uJSdqWUgxl8iaFuAj8P11mcMc+Pqw1Uv0ag9qOfTlZeW792uIbUj0lql7EHGoHa3ot3u6WgfD4WZ1KiUbaa0fb/q1kbgH78w78aF6TKRu/B3rFj0NF//3Fb8nvWrH6R0MqTZz6YFdBbTCedj/rsbHTGylR14vvWU9rsXcsPf+N9qtFWqMiX+zbi7E5WOt9S6TxXn109K6qjqJ1j+DM3yaNrKTGhaZgh2j9xLn86W70OrBKFgnw==
Received: from SG2APC01FT013.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::47) by
 SG2APC01HT031.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::265)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sat, 8 Aug
 2020 08:57:00 +0000
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 (2a01:111:e400:7ebd::50) by SG2APC01FT013.mail.protection.outlook.com
 (2a01:111:e400:7ebd::186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Sat, 8 Aug 2020 08:57:00 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:89D5D278299320B7CA4D497D1E70B9C6A5B353016D27FF996AD08949B14F7BD2;
 UpperCasedChecksum:1780244CFE796278A500725EECDD45C970B9556E625A453D0BBB58892671EEE6;
 SizeAsReceived:7498; Count:47
Received: from SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725]) by SG2PR02MB2634.apcprd02.prod.outlook.com
 ([fe80::8f0:37c7:286c:1725%5]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 08:57:00 +0000
From: Hou Weiying <weiying_hou@outlook.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/4] riscv: Add enhanced PMP support
Date: Sat,  8 Aug 2020 16:56:52 +0800
Message-ID: <SG2PR02MB2634448F0D69E047AD1F576093460@SG2PR02MB2634.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To SG2PR02MB2634.apcprd02.prod.outlook.com
 (2603:1096:4:51::19)
X-Microsoft-Original-Message-ID: <20200808085656.28692-1-weiying_hou@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (223.89.139.46) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15 via Frontend Transport; Sat, 8 Aug 2020 08:56:58 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200808085656.28692-1-weiying_hou@outlook.com>
X-TMN: [OiX5KSBmpbGUxna3ZmDNEElAbtCkQ7Fr]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 21b18311-c60b-478f-568c-08d83b7902db
X-MS-TrafficTypeDiagnostic: SG2APC01HT031:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQsV/tl4T4q9FSHbXJXrF6YmltAf5FtO+r9zD+r2Oc5yv7N9s3ACKTEuJ1rTD60Tyy2Q6nRNw11xacgtU6VQVOyxvzN88AJBsu/Hrzmr+ybOrSC7lfyv3k5V2csYOUyypEuUM9CEQeX77lag9MWS09QSlKaGcmjOpf7N6grRC9LHY9dL+uJ6qPSP0ngeCPAbwNI6fD8x2YpFeIUxztH5sw8G2LkEKoURCNp9WyrXmTY26l+cbRRqpmXqE8AvJd4m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:0; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB2634.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:; SFS:; DIR:OUT; SFP:1901; 
X-MS-Exchange-AntiSpam-MessageData: 5Yr1yR225bis6tgGS3xqJFvOYSn4AoxqUe7dQf7iqUG5lBbQK9XqKtOzskOpCQxtrdfudD/jMqm16Aa64tqUvaT1f/fFh1BgwuhIaqZgn1L8P3zocEsDRUsjKWonM7fT58OcLrvPjdxFYgiR/8LHEg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b18311-c60b-478f-568c-08d83b7902db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 08:56:59.9712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT013.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT031
Received-SPF: pass client-ip=40.92.254.44;
 envelope-from=weiying_hou@outlook.com;
 helo=APC01-PU1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 04:57:02
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


