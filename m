Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC4EC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8996A20754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DXtl8dWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8996A20754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNQ19-0005gO-OX
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 20:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kNPzC-00049n-KZ; Tue, 29 Sep 2020 20:28:46 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com
 ([40.107.237.58]:61473 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kNPz9-0007lC-BP; Tue, 29 Sep 2020 20:28:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRDdCnF+tUQ00VfxQWXdaO6yZE0tHTM2AECckOwLxW3Cs4RWD8CjTbNS4qusyHBGCdooAsv8K3UrLWSjKWFA4Dh0eLIS+r7DO1xjNQ5JKC1jZhR1qeIBetso4YL+CCxqRjvl9mL8M71nF5pYoJW1VxWXvSI4+zMgDO3ezTssit7PSav/QRWA86qbm8i0uoa9IxaC27/lrIGzsPQ0T1gFK/EktQI/XYApyeSVw63GbgUtQWORym+6L0foeBgqsEaf57sII32JGh2vc5YOYKAoaZmmc59gvZMXAFsJXZ5+BlSJyw6AUstE3MZ51/UNnwXgM1FzsZ8QlJrEnHWyiLxgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHFWZZ0YIVJaBYLWslkr5H3LB5h1lUK6sUkG7dXJ2vI=;
 b=oFMejxGac6F8yTh8BPnHvnfaUlwLp4BXnvbSTn4mQKK9ubCK+1Zh4+OLQE75wO8QmQbgyqPGogfjAW+N8ZEYlo6liB40oCkRXQiBqP7hgjQk0IhpBVrhXg4CfX6gOVVZUxlAuDFsbePhbQ/wx+YMIRegB4itguC03GHQbgl6AEfdt2RA7zzznCMBKBFPqVjqpWEBj/ZLcL7t/63zuoNbNdIq3BTpjLQSBiuJZxsrYUTprXVYbtYqIjxjco6s8CSqy2+wYBxs07XsEDYydyVpBN9RcyxJ4wYzsBJbuwWpWi5Y+YO3shWk8N7/ZC7emOJb1rWHJ5dvZR1b9m2knhMQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHFWZZ0YIVJaBYLWslkr5H3LB5h1lUK6sUkG7dXJ2vI=;
 b=DXtl8dWCLh6UO/RAxFwNAQ1RTZXZvLMe25jh9H7ZlG62sBIlYVmuc/hmgut4+GYVKdRip3P7hA3foG+rO1I9fYcAEclRPxjVS4+R404PGz3frTuNTUTowhNX/GNcCQwVbIxNbNocQBPxoq2CH+kA44YDShCZSjflUyjOacindp8=
Received: from CY4PR21CA0041.namprd21.prod.outlook.com (2603:10b6:903:12b::27)
 by MN2PR02MB7054.namprd02.prod.outlook.com (2603:10b6:208:201::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 30 Sep
 2020 00:28:40 +0000
Received: from CY1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:12b:cafe::ac) by CY4PR21CA0041.outlook.office365.com
 (2603:10b6:903:12b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.8 via Frontend
 Transport; Wed, 30 Sep 2020 00:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT045.mail.protection.outlook.com (10.152.75.111) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Wed, 30 Sep 2020 00:28:39
 +0000
Received: from [149.199.38.66] (port=59136 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>)
 id 1kNPyg-00073l-Bn; Tue, 29 Sep 2020 17:28:14 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>)
 id 1kNPz5-0007Kh-E1; Tue, 29 Sep 2020 17:28:39 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08U0Sav3012242; 
 Tue, 29 Sep 2020 17:28:36 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1kNPz2-0007Ja-MT; Tue, 29 Sep 2020 17:28:36 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/block/m25p80: Fix Numonyx dummy cycle register behavior
Date: Tue, 29 Sep 2020 17:28:35 -0700
Message-Id: <1601425716-204629-2-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601425716-204629-1-git-send-email-komlodi@xilinx.com>
References: <1601425716-204629-1-git-send-email-komlodi@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d40113a4-8f6d-4748-b088-08d864d7c740
X-MS-TrafficTypeDiagnostic: MN2PR02MB7054:
X-Microsoft-Antispam-PRVS: <MN2PR02MB7054C93EC763ECE6445A4D44D0330@MN2PR02MB7054.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNBRYbTkUxQT4ZqDw6C1g8snL+aUOZVyHXYafwJ+RPnn8GKJGqso2r/a/6vS/IIBIpVCdihHQXBltpDnK9YyGSIbhqZoT7eS1zlB5XUK98FlnmogNAAVjrIPxPT/txwJKJCQ/ymxK0OC2Ec9+hksG2KKF0HidRqVeomuANp7Shnu7F/D1zxy9QCZBR7Y7EUUxm1dIH42vuBBnYVW+1ep2VVYIs4A4eaka3J/8uQOLiv3nBD4e568uMIhnBqpNVB0x8yxbGcfQbfwj2rYCLWNOokHCM06ExUaMirz+Z4puEyzB32YsMIXAfEPumcn3Xxnc80XmHVvPx27oYJaKuaGpfuHSBwrQyo8x4hdN+TnupZRhk6/rVGPoOMC9/F+Xz4mnqHsesUtSd5gd/iNoxR8Kdz6W9Ta4pbcEo0BIsFC1lLT8FzITwxBFgfpmXVe7wt/K9G2dSuDL8lBQ3VzLb0oRNc86OjiHKV59r7ZW02JdFE=
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(346002)(396003)(39850400004)(376002)(136003)(46966005)(81166007)(966005)(86362001)(6916009)(26005)(478600001)(426003)(186003)(7696005)(82310400003)(70586007)(316002)(44832011)(2616005)(70206006)(4326008)(8676002)(83380400001)(356005)(8936002)(36756003)(83080400001)(5660300002)(9786002)(82740400003)(2906002)(336012)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 00:28:39.6506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40113a4-8f6d-4748-b088-08d864d7c740
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7054
Received-SPF: pass client-ip=40.107.237.58; envelope-from=komlodi@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 20:28:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.614,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, francisco.iglesias@xilinx.com, alistair@alistair23.me,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Numonyx chips determine the number of cycles to wait based on bits 7:4 in the
volatile configuration register.

However, if these bits are 0x0 or 0xF, the number of dummy cycles to wait is
10 on a QIOR or QIOR4 command, or 8 on any other currently supported
fast read command. [1]

[1] http://www.micron.com/-/media/client/global/documents/products/
data-sheet/nor-flash/serial-nor/n25q/n25q_512mb_1_8v_65nm.pdf

Page 22 note 2, and page 30 notes 5 and 10.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 hw/block/m25p80.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 483925f..43830c9 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -820,6 +820,26 @@ static void reset_memory(Flash *s)
     trace_m25p80_reset_done(s);
 }
 
+static uint8_t numonyx_fast_read_num_dummies(Flash *s)
+{
+    uint8_t cycle_count;
+    uint8_t num_dummies;
+    assert(get_man(s) == MAN_NUMONYX);
+
+    cycle_count = extract32(s->volatile_cfg, 4, 4);
+    if (cycle_count == 0x0 || cycle_count == 0x0F) {
+        if (s->cmd_in_progress == QIOR || s->cmd_in_progress == QIOR4) {
+            num_dummies = 10;
+        } else {
+            num_dummies = 8;
+        }
+    } else {
+        num_dummies = cycle_count;
+    }
+
+    return num_dummies;
+}
+
 static void decode_fast_read_cmd(Flash *s)
 {
     s->needed_bytes = get_addr_length(s);
@@ -829,7 +849,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += 8;
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+        s->needed_bytes += numonyx_fast_read_num_dummies(s);
         break;
     case MAN_MACRONIX:
         if (extract32(s->volatile_cfg, 6, 2) == 1) {
@@ -868,7 +888,7 @@ static void decode_dio_read_cmd(Flash *s)
                                     );
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+        s->needed_bytes += numonyx_fast_read_num_dummies(s);
         break;
     case MAN_MACRONIX:
         switch (extract32(s->volatile_cfg, 6, 2)) {
@@ -908,7 +928,7 @@ static void decode_qio_read_cmd(Flash *s)
                                     );
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+        s->needed_bytes += numonyx_fast_read_num_dummies(s);
         break;
     case MAN_MACRONIX:
         switch (extract32(s->volatile_cfg, 6, 2)) {
-- 
2.7.4


