Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235FDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E552073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="liMT9Hdo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="q9FaCbRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E552073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9886-00026k-5Z
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3240045c5=Anup.Patel@wdc.com>)
 id 1j986t-0000yH-An
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3240045c5=Anup.Patel@wdc.com>)
 id 1j986s-0006VK-Au
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:01:23 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3240045c5=Anup.Patel@wdc.com>)
 id 1j986p-0006TC-0G; Tue, 03 Mar 2020 09:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583244079; x=1614780079;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=GCc4iKKy6lLSSEYQbc97PMJrH0hk8z7bF5hcUFEiyY0=;
 b=liMT9HdoIymgiKcqxLT06THqzLiz0V+54U8RtHzRjZssnbaEnOPYkcif
 32dKwl5ATxIYin5RoKqITvF1IhzJ1sQ/SPHrg4WAVwC4wzjDJMUDmyOpu
 FKbITRXdqoYINhNyg4jB8nQuBOLGXgJr+0/SiGKLmbL6BBCP3J6mHY7Pa
 S+PtXqtxBCZKK73a3X3SMqUzSLfzrrKCWGzFiREkRfIyVttUkyUR75xXa
 jcL1b7gc+cuX5fWgIjGrLOP2kcHwLTM9Hku19Vs9thiaKB5o1JZwnM8T+
 7Ixp8g8G6bXCns8HcpbrlV9qaq0Ue3DDAVV1v/iACnu886CjHOHisvb5n A==;
IronPort-SDR: k4c1/z72hkBQ5FU9N9mqR5CTdQzgVHVGyhaNylYuVOkXpSCBYHFb90sdPYJWUTFniIbTiR6z9+
 S93OdZ4BVHQZv4AUAOZgdI+aA2Mt8NQRgbCdA3AGic9C1scZJrLjRD9ji1SLRRbrg8VZt8EZCQ
 nWUiyZSguIOUyiWehKmgzvsZtxbeg+j+6myUCQDICrmqFfWKHoaWFC214UyStaX/IybAEd7UwO
 xjtWGMX+sozGDLANUs4BSswqwTbgdARZuKt61TE6xN8GeXhjjy++0UAcdpMsDJ/S8vO6eXY2L5
 UII=
X-IronPort-AV: E=Sophos;i="5.70,511,1574092800"; d="scan'208";a="239494763"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
 by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2020 22:01:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuKzwinJjjqYA7evbR5k+TQsI+2IK0O4q8WAWgpE7lxXpIf4rTLQYetzSjoHTzfcXeMfVUkfBtcv7M4JVAv3w3EURUPLxoAT0mMtbrCNyi19QjA7KzZV6dmWSvh/8yk+mhTa2VxT4AFxN/thVw7urFKl2723/vJkXxg112/Msam2lSW9YSoO2X661BYZB3FFF9KYHRbxybqq0TEMz1mAIkzn/L3O7b1668nyvBmAbiVjiT45DG0u5V4ye+RDgOU4nWoXZo4HkLeTS8Q+hTCmmkU2fFEOY36jbxQ35C7SB4J060U2XXDeY6cN4b2MnXfLZ+/pSUoYA9ZRAQfX+VRLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Li3wslSnFTZFbsQpl1oExZOCBjgNIMSIhTf6OEhHoo=;
 b=Sr0vr3P036hrbTc+Jr9Ak61YEpYo/YH2MUnAXMjMfQUv4oUGi1So13MD8X5VO03j+QAFx359UUcpUNCFEhcOUjGOMQbCjW4hiyQfYtGz33KiR37kwn5d/HHk9mxkcnzf23qAYtJFZRQuhFI90h/GUyXi0+hdF14WzlNgvbXz36lj+HVeTL9t15KJnaFyGbWcId3kyD544YB4zzBIQKP7t9ijpBNQuVZa5azMzJUmVur1zpQg9ASk3I8llL7ADGnT2lfzhx2S+tHqCM8cYRvAX3GPDa73lja98Wp8m6JfhdsllJ3I76rwXk3m1X65jHERiamaCznihfzXaElvp9m9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Li3wslSnFTZFbsQpl1oExZOCBjgNIMSIhTf6OEhHoo=;
 b=q9FaCbRd02pLZTmn/cJvOL/AbjfXM++SG03SYyzdgOS62yl/GhWM1U5bxGYUWO+H6E6aYEuREBsEFQ8C2BT+nlfRDlzieEArrXNy2c9tcwb9bnPt21YKQFopbNfjHk/yuWVIRP5VIpMNGYP3lctw26Ol+Nx0aEvsGR3lF/P4Ul0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
 by MN2PR04MB7038.namprd04.prod.outlook.com (2603:10b6:208:1e6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 14:01:06 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 14:01:06 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 0/3] RISC-V Spike machine improvements
Date: Tue,  3 Mar 2020 19:30:34 +0530
Message-Id: <20200303140037.85311-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::13) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (49.207.61.196) by
 BMXPR01CA0027.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 14:01:01 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [49.207.61.196]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e0fdd04-5288-43f1-b033-08d7bf7b50cb
X-MS-TrafficTypeDiagnostic: MN2PR04MB7038:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB7038B11092BADFF7395392F88DE40@MN2PR04MB7038.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(186003)(16526019)(26005)(66556008)(66476007)(55016002)(36756003)(1006002)(6666004)(86362001)(55236004)(4326008)(8886007)(478600001)(81166006)(54906003)(66946007)(1076003)(81156014)(316002)(5660300002)(110136005)(2616005)(8936002)(7696005)(52116002)(956004)(44832011)(8676002)(4744005)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB7038;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVuJMcf7KGAIaCpZ4EdhubT5w80qR9sflNVjOtLEuHpCVcPXy0/A99982sdIp/BU3B4rawHrJP0pRvdSyU14WsE6g8ptMmxzr0mFqdZhxv8uQp+QjL2OsPJiaBgrYy6o5IhSj0N2UHj+8+c8AnOLPRBRnZrPYi7s0gYgN5+CUhZknjbIbQRK6jz7skSRAdsivcxSHT5xTMGWg9gvIzB7n72zLQGMyPSBlIsbg0/rtTlLqRsb3TsnrwL8rc1ObBINGjvtWcdPGn45B+hs7ELg60REPX/NaitHb+hSUTXO6gpVHAxrXavPOd5jIPttIAG3CI+lgZ0NTxwgFU24LXgW494XGbD2z+xQ5zVd15CYDab4DRRnOKfLPX3nPhwXUqZRGmPs+k1uj4mPiT34O3LnrhVAt754cfeXcDEhx+mGNh4daM6d8A6hO+sqPwYfXpdO
X-MS-Exchange-AntiSpam-MessageData: 0rLOiBhUMK9B7QB4zxPaqkp5GpMFs7t8G1uPyydT/Fr0rW6wbJnCfu5x7qMAGwPUsmiAfwlmzh23Souf2ofxivoq3izqh0K2k5OQHH5vkUEETUjSAVtx6SV2aVBHxll4HKgJ7Pj/0FbsfT6RSIwZzw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0fdd04-5288-43f1-b033-08d7bf7b50cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 14:01:05.9260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hi1RTtYszJX997w79zp67JcmF/IPYSG05lCMBjFI7Xaf4ZaZnN6cGyyfBkgrKnxElD/ARLAjhcDskd+iEzzaEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7038
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
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

This series improves QEMU Spike machine to:
1. Allow loading OpenBI firmware using -bios option
2. Allow more than one CPUs

Changes since v1:
 - Rebased on QEMU master (commit 2ac031d171ccd18c973014d9978b4a63f0ad5fb0)

Anup Patel (3):
  hw/riscv: Add optional symbol callback ptr to riscv_load_firmware()
  hw/riscv/spike: Allow loading firmware separately using -bios option
  hw/riscv/spike: Allow more than one CPUs

 hw/riscv/boot.c         | 13 ++++++++-----
 hw/riscv/sifive_u.c     |  2 +-
 hw/riscv/spike.c        | 26 ++++++++++++++++++++++++--
 hw/riscv/virt.c         |  2 +-
 include/hw/riscv/boot.h |  6 ++++--
 5 files changed, 38 insertions(+), 11 deletions(-)

-- 
2.17.1


