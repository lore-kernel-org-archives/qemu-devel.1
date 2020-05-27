Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39823C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046DA20657
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iqtcIKiR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jzNbbmx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046DA20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jduvq-0000lC-6c
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 08:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jduup-0007bT-V6; Wed, 27 May 2020 08:12:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jduun-00048D-I8; Wed, 27 May 2020 08:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590581529; x=1622117529;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=+nZyCNpIfFo8VHii3PbIRZQ8hqdvSvnfO5m36ZgKsEI=;
 b=iqtcIKiRxAsWl0+egU7nQQ5HECDBg/Vee6xlh7HIsaRdXQPN1jTVQRiF
 3dP/HI0tqYdKcX7RVMuabgn5AwBuGTP+Y85M7DKxQkRuail+MW5x5qJqy
 Oq4vHwAOIuIbv3SpjjXk5IbTtu2iL6UMg6BI1qy/tLz1ntijHOGzkbYNA
 2Oy8UpAfgvhLhr63XTOdYDjEsMPkMaOogplPFQzrSDxtiaWyMyt1WDEqj
 yONH79qZKRt0nEdEKG1c2MpVW+71bh0BWadd4sIKCGK1fJ+6peODP7v5M
 S+zwR+RoGcMZLCoGg59X4IjqXMPp9FVgcYsPWpKkeOgcykGJjaNTnK0Eq Q==;
IronPort-SDR: XV4Qs8Pa5TjxXkg4sAquyyY1fPyKBVXke72GZBkg3OZkPikXA30Iixod4VvJFDAOHWFRPatro8
 ly1oyIDm0XJ/4mw5uB/8Jfcb1s8mgGwLcyAtCshP4IFRxaO0fm97/IxyEAntA9W7zK12P/vEwj
 ak6bmZeiTNzUgOv/nEbOMW0a9TQGCN5nj5Kyg+1BX3MpbCJtNOJLaZE01urdNm5jfDwXqRO1pX
 EmEf9/I5EK2dlhWwXiJixcEsX+qOCxaYdWBzcKFnf3BA7w/M1atE44FY+fUIDKKpVU2kj2XV7y
 YYw=
X-IronPort-AV: E=Sophos;i="5.73,441,1583164800"; d="scan'208";a="138613394"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 20:12:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQJs63aOTteHnZzPkORCyhcFHjzCpmDfJeBrjYi33JgUki1Dpq5mOiNh8tCW0eopa96r8DMUqmpKgcfwLQlrsNxVYOd1PB59+dzcPPF6h36pDHfb1jtlylDTfcpP97fMjCkkA5Qu41oZMxPZ07wmsPeNWhiyqTzfTyXEj+NYleEGk7NS3RdQLs2t6Erajqm/4tpivQiggLTk4IU0TxKAnen9rN7FCfmQUFfVsMCjqoFbT1CJCY6gSpLreP3SL4+14u+IeQNpzU4UQVe1sor7Sn9ksNI+/Zl7UnQxwqeIhGFDj7LKDoOJYvBHWwP7KdVFrLQOF4Xx/6E5evw/oa4O3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THhP/8uCYFPj0OhxxqWCpGMAs7Z/GkxK5ryhgkhAGWM=;
 b=ndIRZzBW9X92/TaZJ7KHKSv59S3+Lbkaw/fz82o8bbkxXt1c4DgNnOZD9k+0tanq9iGvdNhrwiIoZsHSv3RUroAAVlh0huml1b2E37LP/UHpiqfkOM3QcQSbVd+fcdKL0S9iy8LRHjXViPXgV+7tkFtJ17rNz5C2K6BjhlDbZr1bi0Pu2KUa1pduIKaAdccLKHqGldtdKK2aCxXCEp9MkN0xo2DAcDdZcxeyfb8tgH48HEDNsK2VL9mcwyiDrG4CVCFcgBt1vlX74YsMoqXcF9u7T3DrMEE9H5uEGR8jFX2PPJPC6qStanDNa3StkTCrwES/aPmUhCCdzxcvZ7gsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THhP/8uCYFPj0OhxxqWCpGMAs7Z/GkxK5ryhgkhAGWM=;
 b=jzNbbmx9avtDzmnRtohqOpzOXUpjg2obnXzf4SOX1xYZ/HIrA1nLlmxDYn+l+pfsk7BWe1gr/1PxtZAlMXQec+r9dOoYVKfTeYSjg7UT1taT3CyPImPfkLWt64AQWwEwarHLG2GS+SRxCeZR5UFjzHyeveyE+VnLB7o55u5tf/w=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4473.namprd04.prod.outlook.com (2603:10b6:5:2e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 27 May
 2020 12:12:02 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.030; Wed, 27 May 2020
 12:12:02 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v3 0/4] RISC-V multi-socket support
Date: Wed, 27 May 2020 17:41:27 +0530
Message-Id: <20200527121131.251007-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::27) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.30.5) by
 MA1PR0101CA0065.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend
 Transport; Wed, 27 May 2020 12:11:59 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ae991df-c6c6-438c-0943-08d8023729de
X-MS-TrafficTypeDiagnostic: DM6PR04MB4473:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4473A353D1BE9960048685B18DB10@DM6PR04MB4473.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QU6/Sa8rn8426w38jLGYoQlXK8zBCgwmgb1jztg3pTKrJ/cVFbg3qGn6zGjyWn75cuvKiP2cxZdLjVlM5eEkGmIcIbP7iRwuVhzoG/nyrTovPjUc+0xRsfspcoJpqvi2fX5sFZAag93bMG5xzpyOC/hXot+F2lRcYDQbjyWfu469/4dFP7pMkKDWb+nLw3avK5YVKbJXuiN3cH2nWY5z7HYuSThgylTkkb4GZPBArwxwdEIFn8uRg/skzgmAtGW4wFUWWCnOr0/YxPTF0Z2Bn9767JrW/QL2/2PyUijmN9fIaFMaAKa2Xy+ecfy6MtEaJqmGtDADmnd7lg5Vyyn33fMtyCRq0r9S6JHv6OJImaQ5Lg7z3wJ3F9nJyslpDfTBdn4ywMhS0v8x+VU/BJ5+bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(83380400001)(36756003)(5660300002)(55236004)(44832011)(1006002)(16526019)(6666004)(186003)(966005)(66946007)(8886007)(316002)(2616005)(110136005)(54906003)(52116002)(7696005)(66476007)(66556008)(86362001)(956004)(2906002)(1076003)(55016002)(8676002)(8936002)(478600001)(26005)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mIlbkGGoXhc0HPqNqffSWD8MDYt1G0Rwk2Ndn8MmcgOuY7lPE/v3VAnuyTtaeXpMvA34EYVmwpo8rZPTcsxpZEfldnEYyOdOYUJGWclAOf7AZDAgOyRlTJwfd2fRj6s4I7l6AX0j1W2bL/JWATG0XwGJ517+hyd/JBp5DepKmtpsGai9Rig3phO+TpL4M/kzZ7aUYDBcMu0BdL7e0VvjD/n05hsygb44zNfn9cXT0UFo5A1FAFTtaQYZRC3LCg7WO0FrQYItp41DPKO/dZaJS8Tyn1yCplmFtNPr/CwdDcaD57XohzU4aEGUTGm4mQYJSPJy65i5nzGZVuDElDL5suUaKmH4euttgShy3+45KwifVHhMMjbMO8rmrn0WDj0MvULf6rRMp8u50rTqe5IxpWprEwukZy4rtwwKwtfixbvRQm0EK8D2acBuq4YTx6zA121ikJHs/TnEcGjv7/Vo9ytMxL+0ROwIAgJgDERTfec=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae991df-c6c6-438c-0943-08d8023729de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 12:12:02.3568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbuli3P6PedaaOo9DRcWfBxGNhhUv6QoNjKSO6BMMGq7yOX4unbVxndP7KriC221RuUt1arJ/OMJbj+LwDpUdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4473
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=409226bd6=Anup.Patel@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 08:12:06
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

These patch can be found in riscv_multi_socket_v3 branch at:
https://github.com/avpatel/qemu.git

To try this patches, we will need: Linux multi-PLIC improvements
support which can be found in plic_imp_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v2:
 - Dropped PATCH1 as it is not required any more
 - Added "multi-socket" sub-option for Spike and Virt machine
   which can be used to enable/disable mult-socket support

Changes since v1:
 - Fixed checkpatch errors and warnings
 - Added PATCH1 for knowning whether "sockets" sub-option was specified
 - Remove SPIKE_CPUS_PER_SOCKET_MIN and SPIKE_CPUS_PER_SOCKET_MAX in PATCH3
 - Remove VIRT_CPUS_PER_SOCKET_MIN and VIRT_CPUS_PER_SOCKET_MAX in PATCH5

Anup Patel (4):
  hw/riscv: Allow creating multiple instances of CLINT
  hw/riscv: spike: Allow creating multiple sockets
  hw/riscv: Allow creating multiple instances of PLIC
  hw/riscv: virt: Allow creating multiple sockets

 hw/riscv/sifive_clint.c         |  20 +-
 hw/riscv/sifive_e.c             |   4 +-
 hw/riscv/sifive_plic.c          |  24 +-
 hw/riscv/sifive_u.c             |   4 +-
 hw/riscv/spike.c                | 273 +++++++++++------
 hw/riscv/virt.c                 | 523 ++++++++++++++++++--------------
 include/hw/riscv/sifive_clint.h |   7 +-
 include/hw/riscv/sifive_plic.h  |  12 +-
 include/hw/riscv/spike.h        |  13 +-
 include/hw/riscv/virt.h         |  11 +-
 10 files changed, 548 insertions(+), 343 deletions(-)

-- 
2.25.1


