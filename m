Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E638CC388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 01:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59602206FB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 01:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EslWrGf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59602206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaqgw-0003iZ-BV
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 20:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kaqcz-0000Yo-Pw; Thu, 05 Nov 2020 20:33:22 -0500
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com
 ([40.107.92.68]:40672 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kaqcp-0001YS-Ek; Thu, 05 Nov 2020 20:33:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUxUSN1sGgMrLNLhlptjtTUZzXzOkQptneeWhmCYIN2mTss5f8h8Xt1TzmXA9hya1LuQgcaUZR+WSrvoJeoBoMxGGTSKMY/hdzG9gJo5hFMnOhf07i6haQXxZ736FB+BkAgiV7aQdE1MifCqld6KXr1GPwUXAa/KTecwDOlvmyvS010NWbVNZ5UpApkQQGoT5zwtjhjkPJnIvmA1qH369xLmzk/EFZAnzvpbZQWgsFa9bshgb1cnLFwBVozu4u1jzEGtjELqlmmqUz7HfR517P/Uv66Jfgbwp6qFoX5ZdGWC4JY98tyknvhv5j/H3G8QtVuQntZZsKtZ+Ejz6KPmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwh3hijBRuOS73J1LNm0G7zEzxHyv2iuKgMzqZooqcI=;
 b=gTGf3nFyg7xu8Ee57wyq1hSPlD9L5sHv7b/XTilma8NhhNOiF64dN+WjNMOrOLNHbDK78Mt67fsZNeLX81We6lpccAQJw4yAwBydmZuCtFHc26h2ZCG82Xm/LXF2zSXqWe1YVaIIxgWaFfjiaEnnCJglzKkieHtTl/T7sRfcXETxwfR3dy+5VnHSNjV/LGkqX7fiG7tSdXq9qCKengfwxVrtqKUho5fL/nD/Pg7dPPiGxoObhv1wlwHd0rhzuVyE+F8vFXvacwwWgKEhNtpllLEHblstq3ylSQzZlUewQ/lWWBmolrcYss/k3EuLrNSHD17C76EHQWswR0swBJK9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwh3hijBRuOS73J1LNm0G7zEzxHyv2iuKgMzqZooqcI=;
 b=EslWrGf/ralTzDxZPeji3aOuxH76176JYTomGkmIzdFA+2hzFa5q9QN+NcdYe4qngC4dtS81f+BCj4Z2XnhFtXRMzrfk9vzFHXtDTsrixiTch8jmEiksp9MBvLIvMAw48d6inord7m9XStKK6NTCuEJ4NwB9kPGx8noNCLVLIyo=
Received: from DM6PR06CA0090.namprd06.prod.outlook.com (2603:10b6:5:336::23)
 by BL0PR02MB4356.namprd02.prod.outlook.com (2603:10b6:208:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 6 Nov
 2020 01:33:06 +0000
Received: from CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::98) by DM6PR06CA0090.outlook.office365.com
 (2603:10b6:5:336::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 01:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT013.mail.protection.outlook.com (10.152.75.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.17 via Frontend Transport; Fri, 6 Nov 2020 01:33:06 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 5 Nov 2020 17:32:58 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 5 Nov 2020 17:32:58 -0800
Received: from [172.19.2.32] (port=50874 helo=xsjkomlodi50.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>)
 id 1kaqcc-0005r0-8Y; Thu, 05 Nov 2020 17:32:58 -0800
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3 3/3] hw/block/m25p80: Fix Numonyx fast read dummy cycle
 count
Date: Thu, 5 Nov 2020 17:32:58 -0800
Message-ID: <1604626378-152352-4-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604626378-152352-1-git-send-email-komlodi@xilinx.com>
References: <1604626378-152352-1-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88ad02c4-acae-4145-28a5-08d881f3e94c
X-MS-TrafficTypeDiagnostic: BL0PR02MB4356:
X-Microsoft-Antispam-PRVS: <BL0PR02MB435604C1A4253537BC02FF16D0ED0@BL0PR02MB4356.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgGR3s0Uq9gXscBJ4H13qF03eoRkI9pagsTRFVtUIA5H17nucj4r/p3ARhWcbE4St3VUmyHqt6dpeDirVw+w9xl+1Pd2miMF2+n7hHb6jsS1GJbt4AZAp8FV+lRgfM5B1ZVEhDzj7cFAHkWSQCg4ZKfDpaRo8yU0upoZ8XhX5w6XTCf8+DUrvcqqzIck8SzNoNwH4zZ6t0eRubr2KgIayFyYoCymsIOKThwsjlU3pVGS3u6Eq5kgW/Xh0I1NhPV+g/cRh6N+6YpmsX/o6mrwTIwu1vbeAgX1oXs71BQ0KncFFo+gw2NybDFBQWR/E3frCqicfE5zg1TNigZ22jfWMGnvAoik3Ot/OB7ORVJR1FgxlPaKRidpqo3tOQWcJrCTL4QUHj6Ag/Bq84ahgnY+l28tAqUqy0hny0eyBDeUczoEzMu1FHYL50EjE1qR7d5GRo7N7P0mTT40l7vUdkUEMRlLSdHhfnM06ulDXhBwMl3YE7m2hZ2Yc7GO0MO8mpQO
X-Forefront-Antispam-Report: CIP:149.199.62.198; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapexch02.xlnx.xilinx.com;
 PTR:unknown-62-198.xilinx.com; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966005)(36906005)(186003)(966005)(8936002)(9786002)(86362001)(70206006)(316002)(336012)(70586007)(5660300002)(44832011)(82310400003)(2616005)(426003)(26005)(7636003)(6916009)(4326008)(82740400003)(8676002)(47076004)(83380400001)(2906002)(478600001)(54906003)(36756003)(356005)(7696005)(102446001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 01:33:06.3409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ad02c4-acae-4145-28a5-08d881f3e94c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.62.198];
 Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4356
Received-SPF: pass client-ip=40.107.92.68; envelope-from=komlodi@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 20:33:08
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
Cc: figlesia@xilinx.com, alistair@alistair23.me,
 philippe.mathieu.daude@gmail.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Numonyx chips determine the number of cycles to wait based on bits 7:4
in the volatile configuration register.

However, if these bits are 0x0 or 0xF, the number of dummy cycles to wait is
10 on a QIOR or QIOR4 command, or 8 on any other currently supported
fast read command. [1]

[1]
https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_02g_cbb_0.pdf?rev=9b167fbf2b3645efba6385949a72e453

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 hw/block/m25p80.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 8a1b684..a2cdfb6 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -841,6 +841,43 @@ static uint8_t numonyx_get_mode(Flash *s)
     return mode;
 }
 
+static uint8_t numonyx_extract_cfg_num_dummies(Flash *s)
+{
+    uint8_t cycle_count;
+    uint8_t num_dummies;
+    uint8_t mode;
+    uint8_t cycle_table[0x100][3] = {
+        [FAST_READ] = {8, 8, 10},
+        [FAST_READ4] = {8, 8, 10},
+        [DOR] = {8, 8, 0xff},
+        [DOR4] = {8, 8, 0xff},
+        [QOR] = {8, 0xff, 10},
+        [QOR4] = {8, 0xff, 10},
+        [DIOR] = {8, 8, 0xff},
+        [DIOR4] = {8, 8, 0xff},
+        [QIOR] = {10, 0xff, 10},
+        [QIOR4] = {10, 0xff, 10},
+    };
+    assert(get_man(s) == MAN_NUMONYX);
+
+    mode = numonyx_get_mode(s);
+
+    cycle_count = extract32(s->volatile_cfg, 4, 4);
+    if (cycle_count == 0x0 || cycle_count == 0xf) {
+        num_dummies = cycle_table[s->cmd_in_progress][mode];
+    } else {
+        num_dummies = cycle_count;
+    }
+
+    /*
+     * Validation if the command can be executed should be done outside of
+     * this function. e.g. trying to execute DIOR in QIO mode.
+     */
+    assert(num_dummies != 0xff);
+
+    return num_dummies;
+}
+
 static bool numonyx_check_cmd_mode(Flash *s)
 {
     uint8_t mode;
@@ -901,7 +938,7 @@ static void decode_fast_read_cmd(Flash *s)
         break;
     case MAN_NUMONYX:
         if (numonyx_check_cmd_mode(s)) {
-            s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+            s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
             s->state = STATE_COLLECTING_DATA;
         }
         break;
@@ -947,7 +984,7 @@ static void decode_dio_read_cmd(Flash *s)
         break;
     case MAN_NUMONYX:
         if (numonyx_check_cmd_mode(s)) {
-            s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+            s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
             s->state = STATE_COLLECTING_DATA;
         }
         break;
@@ -993,7 +1030,7 @@ static void decode_qio_read_cmd(Flash *s)
         break;
     case MAN_NUMONYX:
         if (numonyx_check_cmd_mode(s)) {
-            s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+            s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
             s->state = STATE_COLLECTING_DATA;
         }
         break;
-- 
2.7.4


