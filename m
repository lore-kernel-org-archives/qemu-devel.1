Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD102C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8609920787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="efHG1l9+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ttiGXMUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8609920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdovW-0003EN-Nw
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdoqG-00033x-B8; Wed, 27 May 2020 01:43:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdoqE-0003Rx-6N; Wed, 27 May 2020 01:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590558182; x=1622094182;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=68UCwcFgVKHLDKqEtHeML5pe7M1/N5eFz+GJ8ogLHnw=;
 b=efHG1l9+eRX6lKPAQfak4cDuJuv8TmI2qokMcj/hTcBtxmuW4h9O+wjs
 HP8/I2Nqp/FpOi7FRJnBWQp+E92dhV0l/T8AantHO4JPdmiFhSnpGxrDe
 m9q6h9ITXc2JUNZhB9DK28FtQ08gkWkD10sicFfiGMpUQ3eY+LiDtm2JK
 YoRhS6YP5/RD9YrrT+R34r/AFi1j3EjRO6ZPT8l2kN17mtKtLjByYEcL3
 wAQXNfGN8V2SgfmC4HjTZQGUZ4b/2xF2pcwpAbbbjlpcFYLAZW1vkx2jH
 CoWCuDf3tRSPHscomd6x8d2uHf6qdloqYJbfyCJr8pZYj+Slxwo5BHTR1 w==;
IronPort-SDR: 9zn55FQvaOYSZKQolTDJpbjFVnJB3d6Q9+Br7D03vQKIiRihVF0niOe6Hc4Ro/bIgIgfMY60Jv
 N7drbfRDoVWBqhQYDWcmsZ/rfFTWPFLdE3/B3vLjpSiwhVgi6DVzPp3wm/+f1cyj8p9zDca6of
 +yh9do/RPJ71ZxICM5VEgycs68FMgC4o1bi30/oor2dsDmu2hAzQiHH053eR5zxxkdteKcwaw8
 yq3msMhyGTiaygkUro2d4uUfz2tXcIyBuRvwvrnlYsFJTdnPco/+VveztnxuPAOWqEH+V8/CcL
 zJA=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; d="scan'208";a="247638062"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 13:42:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+KGVcAvmIbtez80UIYCZH6acJ0cuUheBiaAWojxB8c6oewvj9TRkWJzp6g4NsuFW5RSaksbnskwTLFroDzQ63UQetuQMU0RYc+bxZuBVJJ5+rDq3zXKvRZb5h1bg5l6jSBJ+Bb/yMJAoX4bAnEZfGraw5REPt6yK+qj+IjMa/w6dIqPH2aEXRPll/M2kwXo8hS85jmUjRd27KR1cotjo0CloaNfeD14/u7d4XJ9lrm817c61WLkR17cAY1AJjYISg93n3mySV4QfUUwcG2dcrgjmPcIZQKtNIESYdo19b1D0wQwmyPWG3FPAEDabQgdte4aTRNzza2MqNf4vzeaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnpwvTRg7KsW5uIPsviRBKslOjv/mk7yXBJ8umfZn40=;
 b=Dg3r0tjBLl6W0kbGVZHHDYdUriihnDD/wI8T95wPI8B2mhfURVekAh1wQwBphd5dZ8Kgt3vHwVAqAzPa6L3XNQuCEynJBdZQEHiZ+JNxX4KcdWQL8zg3l19OjLbGmJXu/wB7dhSVMBSd0OQsn8K+P63YQLh76aue7bhXoMH7Cw5NNU0fAYvVFvLF8l6DDTYeAgHpFCkC73tVqjCXTKB63+qW7KrJnSZ+EjoWVXL1AQ3Ha+rb1q/KBmjw9wy0ItVJKLKqb5UeBdWObsvpz9huBGo1ZznIKbCwvRC4VhR71cpLNVg4Abhogo/Zm66DrAyvKgXGKsbZ+YloB5hanwG9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnpwvTRg7KsW5uIPsviRBKslOjv/mk7yXBJ8umfZn40=;
 b=ttiGXMUCbbIbsAEGLOhI1XuxVAxiH2S2ck/EHVMLTc3XHpC3Qj979k34oo0zznqq40WkiqvLRbP1ly2eDNTzqmif0+nTBf5gR+/ax1891CVhu9Qrww3Qo3HIqmLswrU3z7suoWyocz+eQlcFVI3rRuvEItONXaUp9aq78v56Dtk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6923.namprd04.prod.outlook.com (2603:10b6:5:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 05:42:57 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 05:42:56 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 0/5] RISC-V multi-socket support
Date: Wed, 27 May 2020 11:12:21 +0530
Message-Id: <20200527054226.232103-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::20) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.30.5) by
 MAXPR0101CA0058.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Wed, 27 May 2020 05:42:52 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 571f98df-84eb-417d-2ae6-08d80200cec6
X-MS-TrafficTypeDiagnostic: DM6PR04MB6923:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6923C2E6EEF0B6F92928F4758DB10@DM6PR04MB6923.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZqO38I4tmg1sehVR/pKoxgLV6U2DMOpJGl4WHCFHf98txmjqu0DPRre+pM6pCcA+ANayMIDGzlbSOkr/I9Q+MjYf4Wug+pbPlWp8+OZCb7TB/gfydE9unhsgYhsydTwCbQDkaLE3+N2AdUOb2+z4E098IPivPzUgwrbmHHeBFswyqKmvyKfsObE+r/A6CJzEB2CInL7NWH87kVAoNHowGlLqZz7GJ9omSf/a3iGkDPeiTaGXp8KeS0GhuAc2d36r1jURVHeWGIfOKdsrl/B/2DhE6nFFH9kusY0GxygtST/7/A3DRTtuWwOu5V9VfTaadZNMDZDvO29XVjS/p0gOzUcSG5ukpg5F6pNjTTY2FxYY7pAwLmqrigNV1t4hWp2zpmay1fzpOCaZxaWlC/BuxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(1006002)(110136005)(6666004)(316002)(1076003)(8676002)(2616005)(5660300002)(956004)(8886007)(8936002)(966005)(36756003)(44832011)(4326008)(54906003)(186003)(16526019)(478600001)(26005)(66556008)(2906002)(55236004)(66476007)(7696005)(55016002)(86362001)(52116002)(66946007)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: taJWTLzFKgWxvLMatPcwA4mnGiX0MhIwLg/0p0aBJ6JoI67js8A0XFZXxjhqeti7RmV8BK8xjv987yeYgX2Sbju3BS62CgSYwBC++O3LXM1g1WGDmgQC/v69FH6b6YniDSJjSewd01qiEaNlV+Kma/1/ZCvW/UB04pTdsqwOkqIBrcpQ4UIEUnljyMOETcu0Q57lSAVKzGNsIg/bISYNFnn6aYGQnxATXCyHF2rdPce0O/lk5xXlitM7LX4BvLpRJF/fig4TqPtX1VGHx765tg9wYRlEfZNbPKHk5aegG3aIM3qL7tt4CwRUdsH6U8/pGEZzBQclf+QPokRmm9qSsnuQjxC5L30tS5R3snsdVcHIVz1D4+ahBxKV93bVLuddkrKHskUrsG91TCa9G77SerzJTFA0Iozu3BZaq2qeFTHtaDLPNQ1g+M3yxYczkqVJAP8Z4xxZMl6mkNJNAgwK2CEvf+LxN8Exkh3n1lyL4Ac=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571f98df-84eb-417d-2ae6-08d80200cec6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 05:42:56.7422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GhIGWqVU+chFkR6v0TSNbiHxkE96SYS2RwUUL5S+CuZTYKZXZ+1e9Mt1yyBk143gyUu7odvggXKJc0/086EKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6923
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=409226bd6=Anup.Patel@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:42:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds multi-socket support for RISC-V virt machine and
RISC-V spike machine. The multi-socket support will help us improve
various RISC-V operating systems, firmwares, and bootloader to
support RISC-V NUMA systems.

These patch can be found in riscv_multi_socket_v2 branch at:
https://github.com/avpatel/qemu.git

To try this patches, we will need: Linux multi-PLIC improvements
support which can be found in plic_imp_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v1:
 - Fixed checkpatch errors and warnings
 - Added PATCH1 for knowning whether "sockets" sub-option was specified
 - Remove SPIKE_CPUS_PER_SOCKET_MIN and SPIKE_CPUS_PER_SOCKET_MAX in PATCH3
 - Remove VIRT_CPUS_PER_SOCKET_MIN and VIRT_CPUS_PER_SOCKET_MAX in PATCH5

Anup Patel (5):
  hw: Add sockets_specified field in CpuTopology
  hw/riscv: Allow creating multiple instances of CLINT
  hw/riscv: spike: Allow creating multiple sockets
  hw/riscv: Allow creating multiple instances of PLIC
  hw/riscv: virt: Allow creating multiple sockets

 hw/core/machine.c               |   2 +
 hw/riscv/sifive_clint.c         |  20 +-
 hw/riscv/sifive_e.c             |   4 +-
 hw/riscv/sifive_plic.c          |  24 +-
 hw/riscv/sifive_u.c             |   4 +-
 hw/riscv/spike.c                | 214 ++++++++------
 hw/riscv/virt.c                 | 498 ++++++++++++++++++--------------
 include/hw/boards.h             |   2 +
 include/hw/riscv/sifive_clint.h |   7 +-
 include/hw/riscv/sifive_plic.h  |  12 +-
 include/hw/riscv/spike.h        |   6 +-
 include/hw/riscv/virt.h         |  10 +-
 12 files changed, 466 insertions(+), 337 deletions(-)

-- 
2.25.1


