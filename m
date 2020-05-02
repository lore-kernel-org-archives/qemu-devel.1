Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1468D206CD
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gJ3NrsSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1468D206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUwWI-0008Fk-5i
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 14:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwSY-0000nk-Nm
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jUwS5-0000Vk-Mu
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:54 -0400
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com
 ([40.107.236.74]:6055 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwS5-0000Su-AA; Sat, 02 May 2020 14:01:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFVJeQXgi5TxtjhUKmW/fcagvgthKZ3GIV1lQHl3H83vyI5YoTOqqR8jlmrW20rvDBejF6R4yREO3ooLnZGVUULkRAeenHWJOtpU9/MQ897ZagTYrTihu2cojFaTdqqejpwKNBDFrJWPSB9Y+LscSjL6aV8Z9vXR4J3hUma6J9zQCsK+dPv/7zTgVrpKBAfHnIJN9ZpSM/aTWIhg6Uzhxa6jKyr/AegYTGsWIjIfpqjkcK1l7B3ALgLbmZp3vRTpMBH98INJ13iK6p9w1MoGM4IX0ypV2ea1fvb1FbIUwF0s5JIiAQ9G3pGTGWEBd/vKH6XIyuftPAHKrV6YfFnlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OzxnUCFZOanLWHbiKGtRBa0bgjjiM7xSsLvRWnbZuE=;
 b=YJzANwT5y1e6Zef+5yFKtTv1/NFdTV0P8ZvaGD75CtBy+gWTT8I/U4kIiV6TMSHBduK30ZRPbgbkX5fzmu/K6Z6r5pZxzpP1CVLx5cB42N5E7arPCnEye0WGq9wfaDuKTwM8fXUg5v9+pmWRGOH8scnGQe11+1/yYUkii0YmuMwTf9JtX6NwNg1irROmM6W7rxAGUtnQdgjzBoFAkplnfgsakBNplXr+pZpTvYbuZAdUmtgeVvFhb6nNKXgklEsdlEbHgLkVvaoVBco4u38VbAd00AZLEskGEUzFsr4stau2duLd1FhCcKfFZS25FV8MECzjqB5uhsXMafXHyvdIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OzxnUCFZOanLWHbiKGtRBa0bgjjiM7xSsLvRWnbZuE=;
 b=gJ3NrsSpzBRro4zxZ0a8kL1aclyOhxZ8yYfyS96W/3L/wQRAfkT1fWTESCTVhFs4fjeMlLb8HmLiW5E8INs99IUDgBaffLlqRv7jEQjBkD6C8etaPrU3w4Or1Qs8HKSDg0lE089h8tLPijLT0RhWuyi/576hqj2lO9i4X99g9Bo=
Received: from DM5PR04CA0062.namprd04.prod.outlook.com (2603:10b6:3:ef::24) by
 BYAPR02MB3909.namprd02.prod.outlook.com (2603:10b6:a02:fa::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Sat, 2 May 2020 18:01:21 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::b0) by DM5PR04CA0062.outlook.office365.com
 (2603:10b6:3:ef::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 18:01:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 18:01:20
 +0000
Received: from [149.199.38.66] (port=60352 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRw-0004nk-Vn; Sat, 02 May 2020 11:01:16 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwS0-0006xL-6t; Sat, 02 May 2020 11:01:20 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 042I1Hek010813; 
 Sat, 2 May 2020 11:01:17 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jUwRw-0006vp-U5; Sat, 02 May 2020 11:01:17 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id D32F113C2544; Sat,  2 May 2020 23:23:39 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 08/10] net: cadence_gem: Update the reset value for interrupt
 mask register
Date: Sat,  2 May 2020 23:23:12 +0530
Message-Id: <1588441994-21447-9-git-send-email-sai.pavan.boddu@xilinx.com>
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
 SFS:(396003)(376002)(136003)(346002)(39860400002)(46966005)(70586007)(81166007)(478600001)(2616005)(6666004)(8936002)(336012)(426003)(356005)(5660300002)(2906002)(8676002)(70206006)(4744005)(26005)(82310400002)(36756003)(110136005)(186003)(47076004)(316002)(6266002)(42186006)(82740400003)(4326008);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca5f8df1-eab0-4504-a0ed-08d7eec2d1d8
X-MS-TrafficTypeDiagnostic: BYAPR02MB3909:
X-Microsoft-Antispam-PRVS: <BYAPR02MB3909BF3238449316EC6FE48ACAA80@BYAPR02MB3909.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xnt8bjGrLDJe1zOJ04EPSun4WQKKCgQbyu8plClDVMoyXWoVqlCjV2rcDxuX2tUL9bBfcNIy10nibbIOCBXB2Azad/wMOXJxq9m+5XUdW7rcz70qJltW7Vi+VTwlN5J2YUrJEfqQ2DcNyFl0TrwBGL4R8t1ipnZg5ADTMKF3oUDoWAcuysPywkEvSyjL8j6Zvwvf3cvnOFh69wowx+m0AnJDQ2yCbg/adGxXeTftZvNze1OWj5lCIxdAg2th6jRosjQbxKT+AF8XqgMOJoOY1Sgc20lqJRc62P0Hx3PLsCKsHhh0rbkuqqOxDnLDFYSwnFoSDl1w/OaFsrZp9vwN3X1AjKnOcGlsKhsrpVZUfVL6CwcbLNNUHZCaSadgRX2koMhMLPL9X6C0Ly98zoEqw4MfVTtOaYeFK8dIRY5sf0LWw5vD9SeRYJgdGzB+ocxLACBxo0RIttP2EUrLpibfAJJME67cudIXAXG68exMhz6ryJ+j0BHCFWM7Oq1gdzwFcDEEU52wvx0xDbeWvfA00A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 18:01:20.7771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5f8df1-eab0-4504-a0ed-08d7eec2d1d8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3909
Received-SPF: pass client-ip=40.107.236.74; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 14:01:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.236.74
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

Mask all interrupt on reset.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index e6a3d6c..68df92d 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1347,6 +1347,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_DESCONF2] = 0x2ab12800;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
+    s->regs[GEM_INT_Q1_MASK] = 0x00000CE6;
 
     if (s->num_priority_queues > 1) {
         queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
-- 
2.7.4


