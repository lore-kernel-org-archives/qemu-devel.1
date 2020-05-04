Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A11C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651E920721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="F0efQ6oW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651E920721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbxN-000897-De
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrR-0007BL-Oe; Mon, 04 May 2020 10:14:21 -0400
Received: from mail-eopbgr680052.outbound.protection.outlook.com
 ([40.107.68.52]:22918 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrQ-0005dX-IL; Mon, 04 May 2020 10:14:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBY8iwk/3xhpsNwpHLs2a4pv2ubm59YNFzYwLWnNcagzFTj0nbcj8gpq00UTNwghHXMPEBwsTpP41c16dKy5WUkAHVSuuDB5+MlnYkC6GH355h8JFO1J1mFQ6Ir8jpHSC4k87K2DJe6zf/BuZRa9V+9RWNfkSTdKP1AKaVBCFovkpXFRv7gz5za1eq75ya82N7qiZHWUEdOoF7ZMRkodhnAWBYXnbceLomx0qrChqAqjkUY8FjuJ8xdLYDgOVG2ZwMEqfSYZd8aeRoF0DfcD+6l14XnzzHtPeZl6e4MpnaEWs90h0+cyF7SF1gt3JntEgClM4YEe383gp+IFa+qEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLw9nesv8ObZmzDZcurZrBf/ki2S2Gf/YPbDnpCiXfM=;
 b=J0L2kI5DtdNpaas9HzyfnuPNtiYOUGa4loxyEQoW4HAsyGRbh+ZXvyU+MDCb3XAQm6FmSFbI5+sqJTqZ7+iHdmXrTV+ux4Tl8pZIsj2J+iS/JI61ENDmAV/iv9Z2B4WRnn7S8FYdZkG+w5ydKpuH0n0TL236h0ulJ4cN3KQPUH6rNAmLmjkACGdZ0c3b4bAolfQHQkw2AhFT8+mhF+UhMuNkes5DiqMA3rNyRkeFMd9lD/AOngEaVzgZP4QJVqUptYz4Pobm6HfOdCHutos86PEUzhpCcCbN9M6y6xo61pSwpgRKSGV45Lp/N1UemKthC3oemOvdfji1IoDWfeueCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLw9nesv8ObZmzDZcurZrBf/ki2S2Gf/YPbDnpCiXfM=;
 b=F0efQ6oWinMESTsH96j+FU2hdhUpscne6XzZ7NGdGDRzOMyDV5ej5a+V1Ze16Omhtl6JxdD3pnqAIkN8ArDC+41AgZLAeGDZH3qSa2rKX0z8lDynXSgdgnKNGhOYPXh2pAaxskUKJH/jj5YreV6/xOVXJvEVF2yowVaM9EQWaqg=
Received: from SN6PR01CA0002.prod.exchangelabs.com (2603:10b6:805:b6::15) by
 SN6PR02MB4110.namprd02.prod.outlook.com (2603:10b6:805:31::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Mon, 4 May 2020 14:14:17 +0000
Received: from SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::4a) by SN6PR01CA0002.outlook.office365.com
 (2603:10b6:805:b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Mon, 4 May 2020 14:14:17 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT047.mail.protection.outlook.com (10.152.72.201) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 14:14:16
 +0000
Received: from [149.199.38.66] (port=43045 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrG-0000Gr-P3; Mon, 04 May 2020 07:14:10 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrM-0000wc-Dl; Mon, 04 May 2020 07:14:16 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jVbrL-0000wA-IA; Mon, 04 May 2020 07:14:15 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id AA53C13C2E73; Mon,  4 May 2020 19:36:34 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 07/10] net: cadnece_gem: Update irq_read_clear field of
 designcfg_debug1 reg
Date: Mon,  4 May 2020 19:36:05 +0530
Message-Id: <1588601168-27576-8-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(46966005)(8676002)(8936002)(6266002)(4326008)(82310400002)(2906002)(81166007)(70206006)(70586007)(356005)(2616005)(42186006)(110136005)(426003)(47076004)(498600001)(336012)(36756003)(186003)(5660300002)(6666004)(26005)(4744005);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f35b1d38-9608-4678-15b7-08d7f0356e22
X-MS-TrafficTypeDiagnostic: SN6PR02MB4110:
X-Microsoft-Antispam-PRVS: <SN6PR02MB411053475DC95A1335E6034ACAA60@SN6PR02MB4110.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4WBDEi8lY7LpjdZVNGKajwfM4SCks6DJWE6s8i4Na5hP2cLbhqI+9SkU6/4JIuvkaAlafkmIroaL0YFEeKnN40AwrsZJL2a4ugeVrqVjsYyrlhP7iwUYsjVVjAD+RyUlNAy4gK+ftgpxuhoNHVdwEWpyMjF4DZcuuvisiOgVunWrFPaDFazBEsjGgp4m2QC+dKo8DtCqQ+H++g6uE/zWzvMgc4KsmHUy475Gr2JpLv8THKgjT0VwkPbVxZAUpmNSBPnodpK0dLQuON+BiNHmE4FkEX6061XbT0QbMOpKo3twbcx9NcwTVdPec9dNLQmHWtR+eyxl9syrlGKUHbYnQc3d2hW1I62OuecZUfwSdj5rShKrZfT5q/phxxrrpZXYA4+izGhs8WEqhXH4xD8l3IJDjnb+Bgj4wljEcl6cpxarYkKMvc4hvUvHBCt4S7R/6FWSwrQnZAeweO9biOUrnJNXIc5lbVWBpGZKSpBzlkWFoxgo0aWtOx+RubCa4EVxU35nbViPQZDklNL1yhJkg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 14:14:16.7745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f35b1d38-9608-4678-15b7-08d7f0356e22
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4110
Received-SPF: pass client-ip=40.107.68.52; envelope-from=saipava@xilinx.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:14:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Advertise support of clear-on-read for ISR registers.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 848be3f..9eb72a2 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1344,7 +1344,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_TXPARTIALSF] = 0x000003ff;
     s->regs[GEM_RXPARTIALSF] = 0x000003ff;
     s->regs[GEM_MODID] = s->revision;
-    s->regs[GEM_DESCONF] = 0x02500111;
+    s->regs[GEM_DESCONF] = 0x02D00111;
     s->regs[GEM_DESCONF2] = 0x2ab12800;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
-- 
2.7.4


