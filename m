Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129B4C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4532063A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k18NtNQc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JdHjtJD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4532063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSyqS-0006dn-TF
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=379c65f89=Anup.Patel@wdc.com>)
 id 1jSyo1-0003Gs-75
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=379c65f89=Anup.Patel@wdc.com>)
 id 1jSynp-0001or-8W
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:07:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=379c65f89=Anup.Patel@wdc.com>)
 id 1jSynl-0001db-S8; Mon, 27 Apr 2020 04:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587974861; x=1619510861;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=CkPbWQt5m8Kp0IXCkN2oowW79G2q3mQ0lgq4R2jFUTg=;
 b=k18NtNQcb5fiGPAZfjONUvRL5R7p5R26eNd3C8/6BatloFod/S1PEJSu
 s5yncsjfCgfQLWW7qPFCZ0yJaDWNiAyCfoDYOe6nDKuJtBfp0bTXG9fRO
 CF/I3TavwJgkf29MTym6noKeeyw3plRuzxD2nV/cR6Nh/TcljHLBZBQlT
 5IKLp/QGK8+kkHVARO1/NXeJ62h38qjY/JyQbaIBf43ur2rj+M5eTL5M5
 83ejshLbVE8PpAQUB2rSg/qbo/Dp024T3xHAyv8fWOGp/UdJEpisiNGCJ
 T1XTJUaVvDqCwq285zwPZNQLRKaeCJVTcva6ZWF9we7Ao3TOQ0HXEwDTK w==;
IronPort-SDR: 534lwcazxS9mN5v13DILJeVF1ocuFmir5IFvApl61ysQ9iIkGRB8xXnoMFZKjdYTBGq0irkv4c
 kdMw7g1UWATXpYBEuhazH6H3I3yVKjbY21ZnyZxbm3vSRFx0jL8w8HTDtZfA6q7so46Yec7lRV
 EW8bN6SOPdR7LmLMLD6D+A/EeDM9oZI+9mhCFKNsgghcu6aX+KihVcUPEBkggONsCW5ufk1XbH
 WlpZzIu0pTkI+akggRr4c59zHkVkQpY+LhhlbMgNb+Rq/G7yF66S54ARVAiA1XRi+IDkobgGNi
 yjc=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; d="scan'208";a="245003193"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 16:07:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YutnkAJeJltzFCsUl5jfLqAWwJDjGX2RELoC7noHWmlF3k273lceVMq5JI/vvXb2UKhI77M+b06/gq/QHsIFhQ3C+VV0A4Aizjr52JmLUCQQUZO6K2J3LCd0DyQ3eBXVinFjLPf5aDQnC/0Ojj6PNkFpxFUkrV3rqVpLpzsy+ChLL8QoyW1nFlnaDCCXo1A4NK/jrPpafu6/NB3U3mOZyso+OP42m7Bz3dJD+C70FOlC2G21NvHETtJGwGcFHoB8kej2Q0Vr34aWr7HSo9abZtbOLK9IDqoS7R82+DkKOSDUvXuxo4tTUydFwM3gm2igimzZzvjmLFvCLqHKSsVT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUAk/xq7dVqtv2rmjbGHykFpmVSVedXFCrMjaY+su+g=;
 b=cuAA6OVurW9vbf8DTkHV312lpLpD2f/OmSLTgt9PNyTZm9gZKYg4kvYzYEJfpsH9npSIarB/QAsPK4iVYmyeytqWAAxYwIxMHhcH53QgY1js1IJKnCu4D7MczMfXv3B5himIcE0q82lmSgRRrkQxm2mFYFftRNbu+JiO5alo1ErnsnIdF5zVuqMSGSZTiE5z3CGMzH0JbIlbBpLiPOrvv0AHop90UCXcyVGw7m+daBqABIQBqgd0YQ4hA22DLiPtsfdrGYUqUapYySN/nqF9G3sPV401m2cQnfmiCWmIlXlHc6k+EYwJN1BA4WkbNLU54/P2jPdx5m1E8HThT0+9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUAk/xq7dVqtv2rmjbGHykFpmVSVedXFCrMjaY+su+g=;
 b=JdHjtJD/hO4Z/tZRH113B3MGYClv+GN0MeTXPRm2zjgDN3I5qXihth8nk5pYgNal1shDVryVL+bMPPKn1AqCmoMuTPHIfi5ez9ZnBErQHu00dK8F+FdJvarftZJ3d2V4L1qj3AT8f29XlIL+wcQcV7yI+DJyoGmdc3eLePjNSCQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (20.178.225.224) by
 DM6PR04MB5241.namprd04.prod.outlook.com (20.178.27.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Mon, 27 Apr 2020 08:07:36 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 08:07:36 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v3 3/3] hw/riscv/spike: Allow more than one CPUs
Date: Mon, 27 Apr 2020 13:36:44 +0530
Message-Id: <20200427080644.168461-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200427080644.168461-1-anup.patel@wdc.com>
References: <20200427080644.168461-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::24) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.31.156) by
 MAXPR0101CA0062.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Mon, 27 Apr 2020 08:07:32 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.31.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a23e00c-8562-4140-a706-08d7ea820ba7
X-MS-TrafficTypeDiagnostic: DM6PR04MB5241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB5241E5C238DABA6D92BAF7C58DAF0@DM6PR04MB5241.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(55236004)(16526019)(6666004)(8676002)(1006002)(54906003)(1076003)(8936002)(81156014)(186003)(478600001)(316002)(110136005)(44832011)(86362001)(5660300002)(8886007)(4326008)(26005)(2906002)(55016002)(7696005)(52116002)(66476007)(66556008)(2616005)(4744005)(36756003)(956004)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QopnMi8HTeRHRTK3plCGYCaiphIfIDLPaneAyZqsEV5f0o5T/ccApGagLI+9/MnxsSh1Volcm/aoITr/FkyAiro48o3EkNyMmSLhrf97ZabRrjAGNkhJArHvupHkiqR9wEnsHhDk8Q5l7eZjFTwFd6TFI5+tmfHUVBgayFBmVMWIoB3mpzWECJuk1/B9xbduF0GnNYxgtDBMmyIHwVTeKhG51qJ8HvmREJyJH4y/6YPqz3cPdSMq0emhLRHtd2WW+EAYxUF1UbgtbmusuGU+uCZGgSthOso97yO7IfeTPUHEVyzsaAJjVqtpL2on5C09sfbWpSw7KLGOscDBTI18Hy074Uf+U7V2oyEBtQps2SACGtUtym6rxclAQEofa9N0KHA8oCvU6+2kJd05b3KNC96Wmqq5OjACrc00RzBtzFlwFC9yrvwbK4nosEN0xnS
X-MS-Exchange-AntiSpam-MessageData: N8+Y7GIg4RnwxxgwrY+zZnzv2l26Hlg9TWQdb+GEE5b6QuNTI3aSDsrCCH28z8VAIUbjQhyYlcQMHqLiwxJSbyVBKKZ+HbYz+2DPeSJlfO/lgrL+CdoRoSMt3+JCFEIsiWpoJsZAkD1Gr/m0RBzrwsBYamoHEi56ZgjTQjIEpcvvCuJtg0umeiDBiEx21KpVT1o4P8CNkY5fFuW/MPft73NnYoZ0Q63eeShesgKek5HZtzkZ37lgYZLd4T/r3vOu72xZ+PjzWg6t7ZOyGTFv1+JuE24ZNrmLgr+3n0q59iKcLnGx9Ag4xVCBLVPG2VgIMtB6vHJRVgM4cC5PMtLK25ji1IOlZHK2a7vDp5ZLM7XG5FjuHsqmce+6ZkHmr/DLb+w8jAgMZYBrfYtOtS4BTATw+CIErFAG/8m5vVMnP3CTCXgppFyY+iFBrblThVF5rHAExNdmU22OCktOcoyRq3C8MDvkF3qa1Y4V9qfoO8LZ0tg4yt8Fp31o6Z38dVG0vPekFV9ng6u0RzO9AfTvIM5qX3PfCNhfQMtPTx4L4C2a9n86PXyhf7QsEObreF+BkRNj5hCroDOVkAY+s4ZD5uj8JD+6P0WTU5SkJkPyyC5IvfdYEzWfSp3VKnn6O15H/Z8/r+qU5iZbVfnz2biPXZ46mD08cXOvY0fmwZKKZuRw3c6Sz9sQYc4ExDF2reyI37Pa5u8EuvmB2/Ao3Gmki92Nj/QHjozxotrq4UA+zDr+RW0w0c/btR1MIYp5G1f4U08GsGffC3i2Bc7HuK74cku5+FnKpURAeUUXVwfgCZE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a23e00c-8562-4140-a706-08d7ea820ba7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:07:36.3445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtsSSUlT8ah+G27a0AnKVC0+IZzTGVj0O8MWLfpQTGUloLZQQtRmCfgcKOa+N2sIA6/35YgVXh8AW8Kp/COYuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5241
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=379c65f89=Anup.Patel@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:07:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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

Currently, the upstream Spike ISA simulator allows more than
one CPUs so we update QEMU Spike machine on similar lines to
allow more than one CPUs.

The maximum number of CPUs for QEMU Spike machine is kept
same as QEMU Virt machine.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/spike.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index b0395e227c..1799b9291c 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -472,7 +472,7 @@ static void spike_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Spike Board";
     mc->init = spike_board_init;
-    mc->max_cpus = 1;
+    mc->max_cpus = 8;
     mc->is_default = true;
     mc->default_cpu_type = SPIKE_V1_10_0_CPU;
 }
-- 
2.25.1


