Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD04C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A184206CD
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LoQI0PRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A184206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUwVo-0007OP-Mg
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 14:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwSX-0000na-AT
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jUwS3-0000SE-Mp
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:53 -0400
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com
 ([40.107.237.66]:11321 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwS3-0000Ol-41; Sat, 02 May 2020 14:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkEmVFwsTaMs4NS5zJto/fXl4WrckPBZImYKkYoZ/mwItedCDG0D1B1baokZ7+cdRUsh3YRIDB+6KH5gJNV4Zc2rcC8UsBwXB0WSI47k5XppO0nWYUYvfbhIGmhNxvZ+wOObIb7FMbgyNiTwdQCcnLGXtzSVoNhO0ZXMmmJ6GBJEN452bHsoq0okaZHHJk6KjOK6v45HDQhAooRP04tYA3LxTHE+7V7bOePr94uxtxsAYuiCREIBlfX2xvFII87o+hiXm68I+Vvx2kH2+C586K+MOKoFojzfcqNDgPmlp7CFdiNsrCusn/K2Ghz2LmpPr7vzd7WAn3fq3Zem7ASgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYhKWbdM3mS96mQr9QEiu4aJM0u5/RuFoCcj7G/mxxQ=;
 b=nsytAks1/t+5RW/RKD5//ojqbQNNqorckc9sASRJFsNugY/ZTJl1EBsvd3WKCfKOS/TheQagCbEI38FythXyhIlfwUr5Qstjg8pVxB8J8YKQIyB5zSDfpxsYIqAb9NP+0C9LMkaxumiDaRJFh3l98nZZl32l2gvcujLP0N/8s8bFBQFnm+Z5renZyVtTxrQVt3ZEVqXfOzFueVY3hvBHm8P8WuTb1V0TymjQqxGJIRF7hUuBH/85daLxF49mnOY5dP4LNniwP8Ommf3322RhH6fAvQprf47edKPJoVhfqHnuYx1RnbEBZ+hIC0Vovu2gSibyKrXd0HEAZCsSipQZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYhKWbdM3mS96mQr9QEiu4aJM0u5/RuFoCcj7G/mxxQ=;
 b=LoQI0PRkjcQJ7BtvLpa3vtuYOnNYjcbJuVfmy47D4EI/pOpz1fShfEnhHk57Zte8PqlEk49IKl2BkvAcB0bUqCzuPGpipWdrQRSErMx+1IjAoMRoB5n/6zY2nGdeB2cG5VBIu3wPmx5OAzCf5+go4Dn4bAK8gaX7eHnfXrsBxOE=
Received: from DM6PR13CA0062.namprd13.prod.outlook.com (2603:10b6:5:134::39)
 by CH2PR02MB6664.namprd02.prod.outlook.com (2603:10b6:610:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 18:01:18 +0000
Received: from CY1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::2f) by DM6PR13CA0062.outlook.office365.com
 (2603:10b6:5:134::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.14 via Frontend
 Transport; Sat, 2 May 2020 18:01:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT061.mail.protection.outlook.com (10.152.75.30) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 18:01:17
 +0000
Received: from [149.199.38.66] (port=60242 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRu-0004nT-3U; Sat, 02 May 2020 11:01:14 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRx-0006wB-BD; Sat, 02 May 2020 11:01:17 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 042I1G0A011699; 
 Sat, 2 May 2020 11:01:16 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jUwRv-0006v0-UM; Sat, 02 May 2020 11:01:16 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id B59BD13C1B3C; Sat,  2 May 2020 23:23:39 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 04/10] net: cadence_gem: Define access permission for
 interrupt registers
Date: Sat,  2 May 2020 23:23:08 +0530
Message-Id: <1588441994-21447-5-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588441994-21447-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1588441994-21447-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(346002)(39850400004)(396003)(136003)(376002)(46966005)(2906002)(426003)(2616005)(81166007)(356005)(478600001)(8676002)(8936002)(70206006)(82310400002)(70586007)(6666004)(36756003)(5660300002)(316002)(110136005)(42186006)(186003)(336012)(26005)(82740400003)(4326008)(47076004)(6266002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c209c3d9-5ad7-4bb2-a859-08d7eec2cff9
X-MS-TrafficTypeDiagnostic: CH2PR02MB6664:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6664D552520582F29D810384CAA80@CH2PR02MB6664.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUjDgUZ7E22x0RyI+6z9KrcPpoY6JeGKNCRI1rrLLUscQ8Qvfha9c9l+SUzu4pD7mhLyaV9HxsUpN93xDAUMimJ7735G+qU7d41O98Cju03sXj+jmkyAYUFdMSz3+kjpNf+PDtHYSzdJvQPvBJu+HSY6BWX7JeHDpS1BWyfh8gJk9PfunaALmahH57mulYWOFT3Fnj42CfibkvsChpwykDI2ANbH+Lqa6eTy11rvSkIKFIUrtFHowz/9FEl3L/4qXW5zUoDDdcoH9ZyLyc1zXubwUySwhq3bn37e1Ml+/myYfaLbC6mB4IM8pS1OTowjZEBqGM8FuW88m9PIOgI8fGW11xF5+n/n3rlcf0ZWuZexv1yLCv5sP8doNoOEQByFdUEzq4SagZamneymctT0sNQiW3O2U0a04WSDfXAM7hIjhT2WQfZlqaVKg/ORAP1AIS5E8pTvUK7qPfH3ARzOIuhGigOmHfBfwsn3+dDmiRcPw/t2Ydh+RJioGNeWxw219m7aHcrAkbfv+58/Bg4PBg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 18:01:17.6266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c209c3d9-5ad7-4bb2-a859-08d7eec2cff9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6664
Received-SPF: pass client-ip=40.107.237.66; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 14:01:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.237.66
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

Q1 to Q7 ISR's are clear-on-read, IER/IDR registers
are write-only, mask reg are read-only.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 7782d6d..e745d60 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -458,6 +458,7 @@ static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
  */
 static void gem_init_register_masks(CadenceGEMState *s)
 {
+    unsigned int i;
     /* Mask of register bits which are read only */
     memset(&s->regs_ro[0], 0, sizeof(s->regs_ro));
     s->regs_ro[GEM_NWCTRL]   = 0xFFF80000;
@@ -470,10 +471,19 @@ static void gem_init_register_masks(CadenceGEMState *s)
     s->regs_ro[GEM_ISR]      = 0xFFFFFFFF;
     s->regs_ro[GEM_IMR]      = 0xFFFFFFFF;
     s->regs_ro[GEM_MODID]    = 0xFFFFFFFF;
+    for (i = 0; i < s->num_priority_queues; i++) {
+        s->regs_ro[GEM_INT_Q1_STATUS + i] = 0xFFFFFFFF;
+        s->regs_ro[GEM_INT_Q1_ENABLE + i] = 0xFFFFE319;
+        s->regs_ro[GEM_INT_Q1_DISABLE + i] = 0xFFFFE319;
+        s->regs_ro[GEM_INT_Q1_MASK + i] = 0xFFFFFFFF;
+    }
 
     /* Mask of register bits which are clear on read */
     memset(&s->regs_rtc[0], 0, sizeof(s->regs_rtc));
     s->regs_rtc[GEM_ISR]      = 0xFFFFFFFF;
+    for (i = 0; i < s->num_priority_queues; i++) {
+        s->regs_rtc[GEM_INT_Q1_STATUS + i] = 0x00000CE6;
+    }
 
     /* Mask of register bits which are write 1 to clear */
     memset(&s->regs_w1c[0], 0, sizeof(s->regs_w1c));
@@ -485,6 +495,10 @@ static void gem_init_register_masks(CadenceGEMState *s)
     s->regs_wo[GEM_NWCTRL]   = 0x00073E60;
     s->regs_wo[GEM_IER]      = 0x07FFFFFF;
     s->regs_wo[GEM_IDR]      = 0x07FFFFFF;
+    for (i = 0; i < s->num_priority_queues; i++) {
+        s->regs_wo[GEM_INT_Q1_ENABLE + i] = 0x00000CE6;
+        s->regs_wo[GEM_INT_Q1_DISABLE + i] = 0x00000CE6;
+    }
 }
 
 /*
-- 
2.7.4


