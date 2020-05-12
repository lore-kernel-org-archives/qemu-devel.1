Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB17C54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96E520674
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hJhyfOJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96E520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWZZ-00046P-Pi
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSV-0001Q3-Rr; Tue, 12 May 2020 11:04:39 -0400
Received: from mail-eopbgr700078.outbound.protection.outlook.com
 ([40.107.70.78]:1889 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWST-0002dp-H6; Tue, 12 May 2020 11:04:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddH//pkDOvhXLRMtHMLs+/5uVIAFcG9XLDFjnzU0DeGpcNq/5ZvBntibxGTUWVHa7LOe8PMbejRISgNW7NNBxpv2JZqa6k5GDT/JqpiRHQSzMdq/n9XMUduqqQBMzwq8RvwAvBkVkeC4nLXn04nedVGADRzN2KRv3wiCkUCMDBHdf+iVpGqmISDqp8LawEEJ6oOECAVXI97OcVGlHbn6zRKMVMcLIDoqgJMg24LtUXqcH3TvUAYq+mE+i+zZ9VcNQlFcJ4zedfWDgCHAM21x1z71zNNgKjDDX6eoKwk+me238W//yUCAnkcd87rzE7lYWYUD+WhNwR8J5fDCRrKPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU0O8Ak969WK02hryUKYGxuUpZqp0gUowhHwVt4h8w0=;
 b=VN2SIZrX28lJwejWvtGSXh33cggt+JeI7RJH1xF9z2T0b+OY9IqfQwb54rufzFkkIkZv05XXdbKHD6Lg0VR2Hx6anfN7/RlDIytBjOMewMDpu8cXxLGQ+N9r0zmm4iPApGDwzViTqp94MnE9gHUEkxrDEo4k/CIEl1YyVLUSSnhxXR05izotp/3YjduLYwOt7wvWn20dqp8O6RcakZQiEEO+DpZXkYB2B8Il6ER13fjC7M3NSUbYw2JKLyktxEHCqm8lX4A2YoC4W3kqddXvLGAWqwGt67wJ3FypEA1B8ULXDscdsvWcVUQ/FgwO9CySF8TkzlnqxYJfNc/Hr+LWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU0O8Ak969WK02hryUKYGxuUpZqp0gUowhHwVt4h8w0=;
 b=hJhyfOJfGEXojpS+oqCi/cY7pZDtNw3dt3l8mtnXZrnnwjO0Cj81kYc5cMQzSY+8G7PQR9lv3uYP9gH/LwJlQ4WZK6pWIOwp4dsvoXxmgUKnZ2mUQw2DkiwY/ZtngVM4/6BKalfo88XLlrqd70FgIrbY3XDZXGRJHYwe9y5A4xs=
Received: from CY4PR06CA0060.namprd06.prod.outlook.com (2603:10b6:903:13d::22)
 by DM6PR02MB5868.namprd02.prod.outlook.com (2603:10b6:5:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Tue, 12 May
 2020 15:04:34 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13d:cafe::a8) by CY4PR06CA0060.outlook.office365.com
 (2603:10b6:903:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Tue, 12 May 2020 15:04:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 15:04:33
 +0000
Received: from [149.199.38.66] (port=48774 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWS9-00045T-4N; Tue, 12 May 2020 08:04:17 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSP-0003o2-Er; Tue, 12 May 2020 08:04:33 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYWSO-0003nn-Q8; Tue, 12 May 2020 08:04:33 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 3BBA113C0178; Tue, 12 May 2020 20:26:29 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 04/12] net: cadence_gem: Define access permission for
 interrupt registers
Date: Tue, 12 May 2020 20:24:46 +0530
Message-Id: <1589295294-26466-5-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(136003)(39860400002)(376002)(346002)(46966005)(33430700001)(4326008)(8936002)(426003)(6266002)(2616005)(336012)(70586007)(70206006)(2906002)(8676002)(81166007)(36756003)(47076004)(82740400003)(26005)(82310400002)(316002)(186003)(6666004)(356005)(5660300002)(478600001)(110136005)(33440700001)(42186006);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a9248bc-75d2-4ad3-66ef-08d7f685c7b4
X-MS-TrafficTypeDiagnostic: DM6PR02MB5868:
X-Microsoft-Antispam-PRVS: <DM6PR02MB58683153EEEB514A55EA8226CABE0@DM6PR02MB5868.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FmfuSs1hp+eHXIHKu2asTMbbMO+zyma6oj5Nc4rZl5AH+Mkbm2bz+PbrWX5IFvTkE+o8uGCH7/tdZKoeGZ7tL+6CLvplOlCh1yjR4APGRV8mVKieGnB9gz9eI350CiQB4qWypljF5yfDWBXmqXXtbDoIoBnGrJpRz8DHYaMCbBnTkYFUdkCh8L1QGFRdUroEE0k9RfjdXnf0mhgcpNMMCpyXHXnlq1CskK7JRs9C9LpzTpB3hWRyX+ZNs5hzm5zvCsEzIkAWHy8Q2HuaF+YWn+yhHRfJVEWgnhXYAYdJbLzReF/r8UYz5pzuMXiYrMkbJk6K9xt+ngef+gciLnCVNIDqkzqFjnCKdNoqmD/KZ7i+GOSS3stLFhoGA6Wh/t5xrL4HgQReWI7EnImiOfz/d245PyG+rBFveeSt7l/zVNBJ6efRO17AfWzMmXTubusHoPqjYUTxPjPxZMEZSgaMeetRFZL3Fs0rFf5y7ZumeAHii+92vNpmIjj4O4d70/JllLKF3VAklACvX1yS581lpywTe2zlcAaPq0ZLgfFA6D+MIaf5QGhk8xPkX/sVN9G2S5CZoo5lPaa/oyiUVVfsng==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:04:33.7656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9248bc-75d2-4ad3-66ef-08d7f685c7b4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5868
Received-SPF: pass client-ip=40.107.70.78; envelope-from=saipava@xilinx.com;
 helo=NAM04-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:04:35
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

Q1 to Q7 ISR's are clear-on-read, IER/IDR registers
are write-only, mask reg are read-only.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 76c11a1..40bfa5b 100644
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
+        s->regs_ro[GEM_INT_Q1_ENABLE + i] = 0xFFFFF319;
+        s->regs_ro[GEM_INT_Q1_DISABLE + i] = 0xFFFFF319;
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


