Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87714C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51099207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kIUISUj3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eJLPk1nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51099207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jedVY-0003nB-97
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=411e18819=Anup.Patel@wdc.com>)
 id 1jedTu-00023W-M6; Fri, 29 May 2020 07:47:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=411e18819=Anup.Patel@wdc.com>)
 id 1jedTr-00069L-U9; Fri, 29 May 2020 07:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590752839; x=1622288839;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=4g2eOyOJcvfy2+2jFhBWq45rTb4CGEntjnzVH2x9H8g=;
 b=kIUISUj3xj9k+7XWPu/59u4ohACes8N8jkv3IDzf/otWSf4eAoQLcjtk
 44woGdpIw8WrkY+06M1hUkMV4h+9ntcJiy8BXzYmHr7GV0etg5BvLx+5E
 vd503WlFUuDfAlPN/KYSKJtN1MiTSv7dHEfRtonJm+y8TcNCu9fZy64S1
 p9y4B1URc95A/xY1VHFd9hHym9ldOHlWzSBmwdhlrp2by/BASlxJqYsM7
 vypjSM/PHCim7oqoqhURtxlmOwxt/iuNorOXYYrLXeclSJ2+l0J8ob3Zs
 yvIJSY5/7pUGkBcxphJRtGs9ncSJAc181E3Yrj8oBWqWKxF2MLcYGrAdv Q==;
IronPort-SDR: l9uXlfLIjW+vML84ny90y1CC1nGdHr0Q5NDSeWlUGEX+qZssu4uiNOyDiWgKuiPOaOzK0oFhwN
 JWxJM1pdFIQn6S2AIo/r9fclvM7AeJhJETUB/oVmLzOF3V6sBkWcgnyPMF2QeQvfeW5e9FXFe3
 uCwSjHeHcRnf9EC8txLbdPIC+YKjH55exqABt0ufCbwt5w0o3J3ehsJ1q0rDpYu2Hr8JR3Jkzw
 cFFyF8y/5U5GCYVHws6RxNERiLQUe/8eSYCIjIs57ENCf79jqKjV6NpUaPezLzuXwIuWjU4eQe
 JjE=
X-IronPort-AV: E=Sophos;i="5.73,448,1583164800"; d="scan'208";a="247863254"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 19:47:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1jSLCz/Q7It4yhdIQEoh4a652mVOorIHXWziN046SXz4KTkpCuykUIaVwqRVikQwhpYLlLxhB3FEwd1blT80eXx51WI8IclE9/Xa1HT6vcAYvBKnJABBnulm4LoJH+cZHaKS62bXdWr7i01AGOGOqlXBnCbWtLHKFY8pHWMQnkttt4a9US30npx6JTPu4sBOCDZhcpGsCUrli94RGBiHe0H3FfSty0lHutBiVxTVei8gE8K/H2ohPgYwerXxybP8t5N3GMDWkpUz2WEbeyQbiV07V9g/g8Mg2myL82Sxr+mS9wW6BXP4+x5RbzotPBFxp2Vtkpv7C3M0W2FFUCDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6w7sWWJUcCc7oSixc3xCX9Q0pm5d5LhMmoqPh8WN5A=;
 b=U/hLF5xI3rPH/Podty+PnflB+Sz8Sj35VjBJETBKI21GpnfrsqxgZ9wUVYQ5a1L6aCz26t34a1s3uGVh0zGGRBoqXKYRahc+SnLt5u5l3/nZWrOz72Sq3SskXtCvDNAKieeyLBU8kwYMcUuVmvoCjlh9PjpLHEHmtMl/a/4wXHpWDgW8bqq9IhtSEloWxIeEhctgjajSGFZSpN8m2kpjEkFgHjPIxGm27pcHtCfMz5i4+poP8rFP0TwJhnn33n1J9AXIwCujWmsP5wO6vowkGAzDG9ya7ZWB5Xl2a0i5T6Y7EhyjXExdpxNss7IhOOPcbvDfa9UiY7M/V7ABklM/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6w7sWWJUcCc7oSixc3xCX9Q0pm5d5LhMmoqPh8WN5A=;
 b=eJLPk1nktoVnb8fiM4Ky6wi0YIwpNYeycxmXKPiKMwjPfdhWoNEXXdCZW8T3dIisnA9j8IfVssU8GtNE1FB8BclM+m2HlRedKvC9wWvbFiRnkEsclD3b16YCyLxjGHbcuBcIhLGcYQXW/7NYps6ubJgB0yAUzL84XkQlIl0o9o4=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB7019.namprd04.prod.outlook.com (2603:10b6:5:246::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 11:47:12 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 11:47:12 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v5 0/5] RISC-V multi-socket support
Date: Fri, 29 May 2020 17:16:36 +0530
Message-Id: <20200529114641.121332-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::19) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.109.153) by
 MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 11:47:08 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.109.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66ac5a06-59df-430d-e29a-08d803c6069b
X-MS-TrafficTypeDiagnostic: DM6PR04MB7019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB70199333AB5602E0425C46578D8F0@DM6PR04MB7019.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MK6Ea/t1jbWlL2QJ8cGsxuljrhWKLv1yH/TeKwlD5deDiAMTLH/oNScxt5JOmC+DrsbX0f8SiUlSYRyyUgpXHrm3B/wfX0cnpJrRPjfpwQZMm6SadDsBy81YNBfSFPyhc8RVkmm4icHcR4mCpcDxHHq3PCKV4ZtHesOllaJsEvB3Oe1lUlQp1wAhDdndnvxyetXORkA+jlDRAmm39AbAB4BBTzH/9oDIgW/chO63Fk1ZQabc7KKCnn4DJLAkLInAbr5kjkz+mPDfEsbuQgzKWYDl8LjnHAPL28VkyvpP+IrWMGqCLQZeK1MQQeOwqTm+kpZ+Pa6qTu7yKDKdiB1vXju/hxe8BPIlD8BGZKzQObXLmVvYkfmIAdKniDbJKjBrZVeGLaz1A1Bglc/vaycPBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(8936002)(83380400001)(8886007)(2906002)(186003)(478600001)(6666004)(316002)(1006002)(966005)(36756003)(54906003)(55016002)(1076003)(110136005)(66946007)(26005)(16526019)(956004)(86362001)(2616005)(66476007)(66556008)(5660300002)(7696005)(52116002)(4326008)(55236004)(44832011)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nIpP2xHn3Z5KTXbLdT+S9wlngxpbxCVxFwbwbTHSFXx4bY5tZU5X4OLimOFk90i9wqqalqoPFWRbEse54567wHnZa3juGQJGsp2Lggd9P8KCbg2tBgB0AlMCQXIhHRAl9bPfiV/RWwJQNSmHD+0KHjQTFN4Np/rwuuhRcR/rEjuZzbjgtVgJYy3eBY2OFB4TknWfMQUKQojabSkmJigut3DA1vao1fS9VQTPL9jdd2Yxscxrf0YH3RpxvIc4mmjjdvFbA6jh+wLT1Fb4Yy+HiqbxZ61rMUk4NZQxbRvBIgb7FgfxixSYR7wmaAEbIDafrxLgiU1p5w9eNNb1+pamnXJFfufGGBo0EtOl7LakrX89WPQDJVbw6FXqkIkFHe8xC6q5bXPS+lDos3c6hDqhgj8TYWHSeSBDD/63UofYgjr2dP2DpRTK1tWwLHoyIZwvBLZXFIVZFdmymgfe2u+/mPU2HSYw7hB9ODZWdzyVnP6MGRvGu18AHy14DRBA7MgS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ac5a06-59df-430d-e29a-08d803c6069b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 11:47:12.6429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/FonYuZY/DAZjt1xVAXdEvsKQwa095XFJjZ3hQdy4RrcvLMWPDBEDWWX3ZF5LjqraIVkThYHaSxK4vAj6YVxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7019
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=411e18819=Anup.Patel@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 07:47:15
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

These patch can be found in riscv_multi_socket_v5 branch at:
https://github.com/avpatel/qemu.git

To try this patches, we will need: Linux multi-PLIC improvements
support which can be found in plic_imp_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v4:
 - Re-arrange patches and move CLINT and PLIC patches before other
   patches because these are already reviewed
 - Added PATCH3 for common RISC-V multi-socket helpers
 - Added support for "-numa cpu,node-id" option in PATCH4 and PATCH5

Changes since v3:
 - Use "-numa" QEMU options to populate sockets instead of custom
   "multi-socket" sub-option in machine name

Changes since v2:
 - Dropped PATCH1 as it is not required any more
 - Added "multi-socket" sub-option for Spike and Virt machine
   which can be used to enable/disable mult-socket support

Changes since v1:
 - Fixed checkpatch errors and warnings
 - Added PATCH1 for knowning whether "sockets" sub-option was specified
 - Remove SPIKE_CPUS_PER_SOCKET_MIN and SPIKE_CPUS_PER_SOCKET_MAX in PATCH3
 - Remove VIRT_CPUS_PER_SOCKET_MIN and VIRT_CPUS_PER_SOCKET_MAX in PATCH5

Anup Patel (5):
  hw/riscv: Allow creating multiple instances of CLINT
  hw/riscv: Allow creating multiple instances of PLIC
  hw/riscv: Add helpers for RISC-V multi-socket NUMA machines
  hw/riscv: spike: Allow creating multiple NUMA sockets
  hw/riscv: virt: Allow creating multiple NUMA sockets

 hw/riscv/Makefile.objs          |   1 +
 hw/riscv/numa.c                 | 242 +++++++++++++++
 hw/riscv/sifive_clint.c         |  20 +-
 hw/riscv/sifive_e.c             |   4 +-
 hw/riscv/sifive_plic.c          |  24 +-
 hw/riscv/sifive_u.c             |   4 +-
 hw/riscv/spike.c                | 272 ++++++++++------
 hw/riscv/virt.c                 | 530 ++++++++++++++++++--------------
 include/hw/riscv/numa.h         |  51 +++
 include/hw/riscv/sifive_clint.h |   7 +-
 include/hw/riscv/sifive_plic.h  |  12 +-
 include/hw/riscv/spike.h        |  11 +-
 include/hw/riscv/virt.h         |   9 +-
 13 files changed, 831 insertions(+), 356 deletions(-)
 create mode 100644 hw/riscv/numa.c
 create mode 100644 include/hw/riscv/numa.h

-- 
2.25.1


