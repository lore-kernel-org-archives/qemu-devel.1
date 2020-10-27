Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7514AC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 23:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6880207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 23:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IZ0aGI0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6880207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXYe6-0007qr-T3
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 19:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kXYd5-0006KK-92; Tue, 27 Oct 2020 19:43:51 -0400
Received: from mail-eopbgr770042.outbound.protection.outlook.com
 ([40.107.77.42]:60741 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kXYd2-0006Ui-Gl; Tue, 27 Oct 2020 19:43:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Msv8Qse2tqwcWQF2tHntG6/zxUayH9yC2DNb2z4tyHFDypBkltIiVEYRZVToZCgLVpW/TLX7yvOilEmRGYMar6l+/avxEVpC92ZnD1+K8q4RvmUQszifyvqxKR4rJNrRoSKXsnTFgsyRbWPp9H8UiRo5yw3JUfDl2Rkfm93xUrUT3Iocvzzzkrq0XVomyWch46zGv9fwvqN+Wc8Ztbsj1jf5YepdI0YVv2DbJ7wd46DS0zk54IWZa56cnmNQQbBg5teboPKFeTeLUsDS/REzx6EIEvMo6HaC2AteSw+JMh3JF6uVN4hkdKg2jq7IZL9QMTpIEOTcvvKVKr6mfHLNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vObvFccYPxMQra7bX3ea1hTDSrqjM3/+XiKhdZ+lkIg=;
 b=TJXWYQVRsG07G1ulqX/LxuGQnNRp8nvdk9iK7xsSGVlm/324R09ahAPp2MCJMH7uYmrPrxq+m+I65DNjEtnqw5Wo4wFKo5nDqqIzybv4pgdpvGp+7U8K8OctdS4YcNtGRK4P17Zr9th+8HlEi5RFUPuCJOzDqqCrL/ClWbu9hv0afnT/eGXuoaVW/U5ANif2bI0iIDIM5dfNN7kZB7fS2lXwjflYUtpONtL9tn6YieA3TVGKi0TUN/wskxQpl7vh6U0e6PmfMDLONQYtYk7b1XESUBBBRlGqzWIIplR17rLvODA8+U92W3jPi2SbNXiZHybo5Uqt/WX4e8l3t+sF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vObvFccYPxMQra7bX3ea1hTDSrqjM3/+XiKhdZ+lkIg=;
 b=IZ0aGI0x72zMerRJ8AJIuK5frSB/pJCVuW1aET5YeowZn/9LIgZmXuAmb/rSaLrOuiizn2NIGeKs0e3Wgcn3nKchPWcCrgjegOp42tl0eFrCpVBhXuDhEgKOl65vl4dahR/QMiJ1uNCE3Ua6A0tapgi9yZcPfxBTY5E9ihdZHi4=
Received: from DM6PR14CA0070.namprd14.prod.outlook.com (2603:10b6:5:18f::47)
 by DM6PR02MB6890.namprd02.prod.outlook.com (2603:10b6:5:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 27 Oct
 2020 23:43:42 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::ea) by DM6PR14CA0070.outlook.office365.com
 (2603:10b6:5:18f::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 23:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.20 via Frontend Transport; Tue, 27 Oct 2020 23:43:41 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 27 Oct 2020 16:43:40 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 27 Oct 2020 16:43:40 -0700
Received: from [172.19.2.32] (port=45998 helo=xsjkomlodi50.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>)
 id 1kXYcu-00015W-BM; Tue, 27 Oct 2020 16:43:40 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 1/1] hw/block/m25p80: Fix Numonyx fast read dummy cycle
 count
Date: Tue, 27 Oct 2020 16:43:40 -0700
Message-ID: <1603842220-215321-2-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603842220-215321-1-git-send-email-komlodi@xilinx.com>
References: <1603842220-215321-1-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13f7da13-4228-4e3a-1fc3-08d87ad222d6
X-MS-TrafficTypeDiagnostic: DM6PR02MB6890:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6890286CBAC0D6A47EC44030D0160@DM6PR02MB6890.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:334;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbuX6DoovpMHlccpGNK2T+5BhY7pSQWiMbwOJgVjEAsDz15Z2dgGvsE/5SKUJtKzXd/iL1nqF/F4ddhnUXe22ha+FjPTkJj6lrwpiN2MVWqQ06XZ+aeRavCpIpt2m+h7QrnBXt7qSk6SjYn8WZKE1NWnX1GqodGAZMBhknYJ9+93I9ZCCxjO0TwkOVFn+z8HvE1pX3p0jog6ikd02k+KQMu0mmtJtCR7N57Otaua4zUgYHcEl7GI65fycAMqMr8ju9VfvDROJu3A4ImmrLzdkqxIAM5hGoEyXlznYOHJfGzZGx3dSp+S0BqsLPRVl2/YDwYYI1WKbGG8HS4CRQ5Py8Kq3SrYZYCZRhPmscQrdWFkLV4E20nLXiAz2WROyxIbJRquKCf3l/VFnTt3xXDtgNccQoxYjpOWqWgxzmYmFmqhxnQSmjoRV6tPt5NIyE3H67WMWblipHcLUzZ9GuCBJiOuTBXG2+HgUHiIq52ZOwtdj0oR3kxsfO8Ftk44nhSt
X-Forefront-Antispam-Report: CIP:149.199.62.198; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapexch01.xlnx.xilinx.com;
 PTR:unknown-62-198.xilinx.com; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(376002)(346002)(136003)(46966005)(36756003)(7696005)(44832011)(5660300002)(70206006)(83380400001)(7636003)(54906003)(82740400003)(356005)(47076004)(70586007)(82310400003)(86362001)(4326008)(9786002)(336012)(6916009)(316002)(36906005)(8936002)(8676002)(478600001)(26005)(186003)(2906002)(966005)(2616005)(426003)(102446001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 23:43:41.8470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f7da13-4228-4e3a-1fc3-08d87ad222d6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.62.198];
 Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6890
Received-SPF: pass client-ip=40.107.77.42; envelope-from=komlodi@xilinx.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 19:43:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: figlesia@xilinx.com, kwolf@redhat.com, alistair@alistair23.me,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Numonyx chips determine the number of cycles to wait based on bits 7:4 in the
volatile configuration register.

However, if these bits are 0x0 or 0xF, the number of dummy cycles to wait is
10 on a QIOR or QIOR4 command, or 8 on any other currently supported
fast read command. [1]

[1] https://www.micron.com/-/media/client/global/documents/products/data-sheet/
nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_02g_cbb_0.pdf
?rev=9b167fbf2b3645efba6385949a72e453
Page 34, page 39 note 5

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 hw/block/m25p80.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 483925f..302ed9d 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -820,6 +820,26 @@ static void reset_memory(Flash *s)
     trace_m25p80_reset_done(s);
 }
 
+static uint8_t numonyx_extract_cfg_num_dummies(Flash *s)
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
+        s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
         break;
     case MAN_MACRONIX:
         if (extract32(s->volatile_cfg, 6, 2) == 1) {
@@ -868,7 +888,7 @@ static void decode_dio_read_cmd(Flash *s)
                                     );
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+        s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
         break;
     case MAN_MACRONIX:
         switch (extract32(s->volatile_cfg, 6, 2)) {
@@ -908,7 +928,7 @@ static void decode_qio_read_cmd(Flash *s)
                                     );
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+        s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
         break;
     case MAN_MACRONIX:
         switch (extract32(s->volatile_cfg, 6, 2)) {
-- 
2.7.4


