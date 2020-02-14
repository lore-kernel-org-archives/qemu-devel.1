Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFB8C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F682187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cyA2BAqb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Gzm0cYm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F682187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2VJW-0003HZ-3v
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 02:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3066d6cb9=Anup.Patel@wdc.com>)
 id 1j2VIb-00021S-SB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3066d6cb9=Anup.Patel@wdc.com>)
 id 1j2VIa-0003yg-OO
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:22:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3066d6cb9=Anup.Patel@wdc.com>)
 id 1j2VIX-0003pP-BF; Fri, 14 Feb 2020 02:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581664921; x=1613200921;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=fJDOSKKX3t+3XtWsGJJUkmVQgtHbTvwg37noiy+q8+8=;
 b=cyA2BAqbkmC1AJfT9MoHk1t5Byq0n2oU79VlQ0HrxoJPPEYSLGc0Oct4
 ga+QZzdrQ96TMPcsdUZKRwBgtEfC9ZhjJVJVXugUacvkxiSuaVE8vaUNM
 VEaalFjYmz6Q4Kt2BV5KIim9ElmZeP6VvduT41q/wdvxRLaMrkkY8sBJd
 6euJAJgJY+Pnbq50XUO2EzOcCHZTEppMRwEnxj6EWzo+wz3amSplWdL4X
 +pH0lTCTNvFxR5kcdihaGr9jePMceiM9fC7xkcL+PRgK2b5O/sBJ17yeN
 kKVCxxvn6A1StTeDPzfco8VoEYfxL37aG5Sgh/VFdJt6k1vMbr3O2WGL8 Q==;
IronPort-SDR: +rkOjX2zmJOVJxQrDPT4vs0LciRJ6r5q/JZzYxsEzMXS7Um2YAl6eebWmYuQrafylvQ6eek8VP
 2jMUPeaWOxar008jTSCw9GjKSUEXFGHNuit5Lbojrt+eW/JyNaaM807VAt5Rq6LiYxveKti3gY
 ZQe/mR07cx7N/rbvA5rhJglbteMVtN7kMtY4Z55BoGFeF8mg7ujHCEbE2xAoeKu1lUzn6ZfPEx
 dgbe6610trCI7IqUU2rgWMlbxq4Ac3lxvV/hHhL3z3dwb5pN2QfKYGHXCV/Gc1iK7nj31K/TgQ
 abI=
X-IronPort-AV: E=Sophos;i="5.70,439,1574092800"; d="scan'208";a="129846930"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2020 15:21:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLL13c3fQOPraPmhdC2imoGkY6uiZoauN7cwdIAyHga+1rSoftM3bBSGXeVwg/QSre4OgFATwBurPO1kUw2Z70Rtsv4IBihuICtiAuwZnALNOQ2AYqOp8jfYYaFNNybD1oI+p4MONzdxyOhvHvURWcIFDYRGMB+3WLdn7C4SZRTxN9UgFv/DOx45gQz1cofw/JGZSkWm6C0kkTRbJznmtEsqiK72FIzfQTZkZOPPkQ2XlmdHzUVfsoK02CvDR2trhnhK5Vk8q/FDEeWyqndWxB8/GPxrcFSjhXB3E5A8IUgiNXFOQj6Wps/KK1G8+juz6WiVMYskGsqKhpdFDDmOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mg8nKM+FzPcTpPz2dLwgs++LiklWblLTrFawyaV84f4=;
 b=O+C9njb1RwI1NKnnvFMCeZ2sK0zmj6qNVwtl9AWdadEkqMtlMX7k1PvAYITRumImpzc2W7dpKWzI4pWQ5cCOFYNqjtMAGi5B1eb42fLh2LrgvhW0ri7IvGIcpqAkiUy1UcgDtjXy8XZS4QbHcewdclwzarZTS25fUpb9YQRKtCMGfywyTrzAP23WJsZY6s9E9Tdj1iAv6R9X8KevSmRbJXVLFHl68yzW3AevZ1pxW9YMggj1/YH4MdqPhqsq+Xb/9ewcmZ7LzWaUGJtS7kc77jJ6coKF+pUQL42AE9NTA/jTJTmSh0iTrw0EhFZZphfczY6PsEBWsDGxV15NuHXbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mg8nKM+FzPcTpPz2dLwgs++LiklWblLTrFawyaV84f4=;
 b=Gzm0cYm48Cuzzk9U6tsuU4ME1gir9KBJe2mnngCnMBBKXCETehXK1lxokFnJc7N9WBNk4DujN4JB99TredAeMacl22QIe0nkQbetqIrY3LMi7D5yPHxxvtgpGXxXm8xrksOXPVYxtrHI24X+1vBdjY2ezXTtqVmqOT1D5IpUga4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6288.namprd04.prod.outlook.com (52.132.169.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 14 Feb 2020 07:21:55 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 07:21:54 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 0/3] RISC-V Spike machine improvements
Date: Fri, 14 Feb 2020 12:51:24 +0530
Message-Id: <20200214072127.64330-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::25) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
Received: from wdc.com (106.51.31.230) by
 MA1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Fri, 14 Feb 2020 07:21:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [106.51.31.230]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57e352bd-6ac3-4a6a-b9a9-08d7b11e9163
X-MS-TrafficTypeDiagnostic: MN2PR04MB6288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB628879A04382E7452A2E35028D150@MN2PR04MB6288.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(110136005)(478600001)(54906003)(316002)(52116002)(1076003)(7696005)(66946007)(36756003)(16526019)(8676002)(4326008)(4744005)(81156014)(1006002)(44832011)(55236004)(8886007)(2906002)(956004)(26005)(66556008)(66476007)(8936002)(2616005)(5660300002)(86362001)(186003)(55016002)(81166006)(6666004)(32040200004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6288;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzJTP8m+wYS1MFutYEWpOxXZiadf+3nsbkh88H0oSFCppu3p2Wu5qUWYU4kSCegLYPIi0TpeXIfO2Hmo/oWm5DEo0bxLC5zN79HASuJE7YQo89gUpp8WrlgITgV5l8M6XD6+2jZoQZa6DFXelK8OesCHTbZ5MFjGyFNPaSdGX1IDBoxPMEpkvIiK08F3EPlv11RJi4XJGosTcbPKuski3R9naIFFKVGCfzZY0FPfqJnX+1D9kcMio3w5UFu1EerVoZJQlLcUeB3vGpA0P8sLbhHJNuR3DmSGEOUhBvR9i8CtkRSbv8VPeXhOwexc6f4X5gVhPiYEHSLC3W7/AsTYcSMCTs1UnH1KYuV1x8OW72XM+H2Y79+tq0FinynAJpxV4CKke2PUzmbrP6Rk16p8ahVuw5FGxPZ77/cHgqW5otKHSgc9/PCBlhUpqxk5ixX+k9AI0t43YoB+FEbVu9OxQhscTotNO3/AlnTZqunagjsSPNQFDVeM05ZfSSaaWkWF
X-MS-Exchange-AntiSpam-MessageData: dBpZTWqYdPyW5y98p0AJ3dUvjG0qZEKNa7JTHLs8boog30hvXy3UN/IgkN3gK77zomLK4gQoaZjdBtzZBqLKZx0aoDIDusyq7EvqUbnXXoYUk7Biwou3GSDjGOqMykqNNYKE4UuQK5TTy9kmHnRRdQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e352bd-6ac3-4a6a-b9a9-08d7b11e9163
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 07:21:54.6909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2oP1h3EOB7EKhcIkxojviMBAEF5QBDB3r2F9T/vKo2fq2uKOLAE9d3VSTchWZ9h8/F5k0zM0vfs4FxDgIBoYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6288
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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


