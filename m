Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D642AC4742C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 01:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FC920759
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 01:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DDwKA6kk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FC920759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaqeS-0001ku-S6
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 20:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kaqcv-0000XM-Ip; Thu, 05 Nov 2020 20:33:21 -0500
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com
 ([40.107.223.57]:24857 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kaqcp-0001YU-Iy; Thu, 05 Nov 2020 20:33:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmaWjUKTw85wKpCN082S+Ht6xnSnmsn6MG/OYroJFgMTyePgRMHfrPAcjW74o/2Rs+XjJaFEN1toV9Ym9sGz5h00Q24pj3lYu/6z4ZwFiM3e8H6aQo88qWgOV0IonF4vur+8usX7m8m1ZtSMDlTrUq1hQfq68KmfcZnO24feMjKsTsPO/VVd1RJlmqtm8taN86ZxdVXqZT19cEKteqI8c8GpEdK5fzCg8OzL05l+ulBmwz2+VlElZsjp8jLE6J/Qhj/kuiFgFaUJDgaXxnD7iLXms4dD1m7rmxqmPIBwzE4UgteB50Y63a7+Qt4X8ra2V6c5qzHQfgU6jJRTHg+oYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86VOIzYt760d0BWlAUqKRdZOBwPR1di2o8CeSFdDiNQ=;
 b=StB1juQD8tqFFeyS+/eSJ6v02rA8mUpEBzfGRUcI8L3tLTQSDHYNdNHZOk3SgG39TK9gPNYB3x0FVKAjSuxQSrrbSeBV456MVxlxzy1I/JTUdPhQYTk1ZZJPc5m+JqLXiSoFabFdSbKCizGmTrjyWUc37sqOQbh1IxFZDcuAmqTOjYvlVSZRU5TDBJ4CZHcmpno3SMM3+mVYvC5ir+cdo3PGBjBiM4mUacq1CL4QlScQ1atvkkyBr+fg/CtuKz47aWQepPz5AUNjOAGghSWepKVa6FxDZwc0L4srqjp1+LHlf4sJVazp0a/R3Zqm3a+fjqVwpedmHjIrrwN4zAAyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86VOIzYt760d0BWlAUqKRdZOBwPR1di2o8CeSFdDiNQ=;
 b=DDwKA6kkMMgQ9zdbHWYXYQx4V2oMPOnmTvKKb6yr7OzlhM9UGkCvgxIvs6eRt8V4oVagmhR8POIgshWuCZ8v3xduxk9w45ivFn8+DfQudxB1qm8H5sZ0/K0+grnXpyH89XEsogWsjEtrq2UarDFXo7x6Rc31Fq9/YBWPdW84qUI=
Received: from DM6PR06CA0095.namprd06.prod.outlook.com (2603:10b6:5:336::28)
 by DM5PR02MB2379.namprd02.prod.outlook.com (2603:10b6:3:4f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 6 Nov
 2020 01:33:07 +0000
Received: from CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::e3) by DM6PR06CA0095.outlook.office365.com
 (2603:10b6:5:336::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 01:33:07 +0000
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
 15.20.3541.17 via Frontend Transport; Fri, 6 Nov 2020 01:33:07 +0000
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
 id 1kaqcc-0005r0-7v; Thu, 05 Nov 2020 17:32:58 -0800
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3 2/3] hw/block/m25p80: Check SPI mode before running some
 Numonyx commands
Date: Thu, 5 Nov 2020 17:32:57 -0800
Message-ID: <1604626378-152352-3-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604626378-152352-1-git-send-email-komlodi@xilinx.com>
References: <1604626378-152352-1-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80f51326-8df9-4c8f-9b60-08d881f3e9d7
X-MS-TrafficTypeDiagnostic: DM5PR02MB2379:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2379F554F5068756A8435847D0ED0@DM5PR02MB2379.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:242;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWU55vnEs0nF7jgvQ9rNWgpsUzY2O41DMxe+AnowfOG++KTB/+zplnvlXEA9emyrzPMmP69aJ3dTlbgJKoIp6DkTNZfgqobstLrjO1CRgcbAC/ydsl5jofLeP4OFpZodSqjprrrlMGO0ukO64Un3g9w/ajXoYoVUgN+uGuzUIdtTYvMYJTJKdwiLZlXnVNG2LsLl6g9oXH+lIdlSzII0hWoJD1U+iFml73XGDs0jSjOKNJMdQ6PG7Xijo1PYdc1FA0D1wy7ynfBOT3oLRhf8XlgwUKNmfagPbRnikHVDRQlrCs9rPoRIJdV7P67Ebm4Awoj0Z7nPTKwA8p7jQe/JChEX5kXcAs4mW3yMn+Y6Qm8iACm2KkzWWr7cYdp86AIjywVKtqTFYnRKQzEHpm9Js9SpWMfgzuuATIZx65ClT98=
X-Forefront-Antispam-Report: CIP:149.199.62.198; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapexch02.xlnx.xilinx.com;
 PTR:unknown-62-198.xilinx.com; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966005)(44832011)(83380400001)(26005)(86362001)(5660300002)(426003)(8676002)(336012)(316002)(186003)(82740400003)(7696005)(478600001)(9786002)(54906003)(4326008)(36906005)(82310400003)(2906002)(6916009)(356005)(70206006)(47076004)(36756003)(7636003)(70586007)(8936002)(2616005)(102446001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 01:33:07.2553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f51326-8df9-4c8f-9b60-08d881f3e9d7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.62.198];
 Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2379
Received-SPF: pass client-ip=40.107.223.57; envelope-from=komlodi@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

Some Numonyx flash commands cannot be executed in DIO and QIO mode, such as
trying to do DPP or DOR when in QIO mode.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 hw/block/m25p80.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 119 insertions(+), 13 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 4255a6a..8a1b684 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -413,6 +413,12 @@ typedef enum {
     MAN_GENERIC,
 } Manufacturer;
 
+typedef enum {
+    MODE_STD = 0,
+    MODE_DIO = 1,
+    MODE_QIO = 2
+} SPIMode;
+
 #define M25P80_INTERNAL_DATA_BUFFER_SZ 16
 
 struct Flash {
@@ -820,6 +826,70 @@ static void reset_memory(Flash *s)
     trace_m25p80_reset_done(s);
 }
 
+static uint8_t numonyx_get_mode(Flash *s)
+{
+    uint8_t mode;
+
+    if (s->enh_volatile_cfg & EVCFG_QUAD_IO_ENABLED) {
+        mode = MODE_QIO;
+    } else if (s->enh_volatile_cfg & EVCFG_DUAL_IO_ENABLED) {
+        mode = MODE_DIO;
+    } else {
+        mode = MODE_STD;
+    }
+
+    return mode;
+}
+
+static bool numonyx_check_cmd_mode(Flash *s)
+{
+    uint8_t mode;
+    assert(get_man(s) == MAN_NUMONYX);
+
+    mode = numonyx_get_mode(s);
+
+    switch (mode) {
+    case MODE_STD:
+        return true;
+    case MODE_DIO:
+        switch (s->cmd_in_progress) {
+        case QOR:
+        case QOR4:
+        case QIOR:
+        case QIOR4:
+        case QPP:
+        case QPP_4:
+        case PP4_4:
+        case JEDEC_READ:
+        case READ:
+        case READ4:
+            qemu_log_mask(LOG_GUEST_ERROR, "M25P80: Cannot execute cmd %x in "
+                          "DIO mode\n", s->cmd_in_progress);
+            return false;
+        default:
+            return true;
+        }
+    case MODE_QIO:
+        switch (s->cmd_in_progress) {
+        case DOR:
+        case DOR4:
+        case DIOR:
+        case DIOR4:
+        case DPP:
+        case JEDEC_READ:
+        case READ:
+        case READ4:
+            qemu_log_mask(LOG_GUEST_ERROR, "M25P80: Cannot execute cmd %x in "
+                          "QIO mode\n", s->cmd_in_progress);
+            return false;
+        default:
+            return true;
+        }
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void decode_fast_read_cmd(Flash *s)
 {
     s->needed_bytes = get_addr_length(s);
@@ -827,9 +897,13 @@ static void decode_fast_read_cmd(Flash *s)
     /* Dummy cycles - modeled with bytes writes instead of bits */
     case MAN_WINBOND:
         s->needed_bytes += 8;
+        s->state = STATE_COLLECTING_DATA;
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+        if (numonyx_check_cmd_mode(s)) {
+            s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+            s->state = STATE_COLLECTING_DATA;
+        }
         break;
     case MAN_MACRONIX:
         if (extract32(s->volatile_cfg, 6, 2) == 1) {
@@ -837,19 +911,21 @@ static void decode_fast_read_cmd(Flash *s)
         } else {
             s->needed_bytes += 8;
         }
+        s->state = STATE_COLLECTING_DATA;
         break;
     case MAN_SPANSION:
         s->needed_bytes += extract32(s->spansion_cr2v,
                                     SPANSION_DUMMY_CLK_POS,
                                     SPANSION_DUMMY_CLK_LEN
                                     );
+        s->state = STATE_COLLECTING_DATA;
         break;
     default:
+        s->state = STATE_COLLECTING_DATA;
         break;
     }
     s->pos = 0;
     s->len = 0;
-    s->state = STATE_COLLECTING_DATA;
 }
 
 static void decode_dio_read_cmd(Flash *s)
@@ -859,6 +935,7 @@ static void decode_dio_read_cmd(Flash *s)
     switch (get_man(s)) {
     case MAN_WINBOND:
         s->needed_bytes += WINBOND_CONTINUOUS_READ_MODE_CMD_LEN;
+        s->state = STATE_COLLECTING_DATA;
         break;
     case MAN_SPANSION:
         s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
@@ -866,9 +943,13 @@ static void decode_dio_read_cmd(Flash *s)
                                     SPANSION_DUMMY_CLK_POS,
                                     SPANSION_DUMMY_CLK_LEN
                                     );
+        s->state = STATE_COLLECTING_DATA;
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+        if (numonyx_check_cmd_mode(s)) {
+            s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+            s->state = STATE_COLLECTING_DATA;
+        }
         break;
     case MAN_MACRONIX:
         switch (extract32(s->volatile_cfg, 6, 2)) {
@@ -882,13 +963,14 @@ static void decode_dio_read_cmd(Flash *s)
             s->needed_bytes += 4;
             break;
         }
+        s->state = STATE_COLLECTING_DATA;
         break;
     default:
+        s->state = STATE_COLLECTING_DATA;
         break;
     }
     s->pos = 0;
     s->len = 0;
-    s->state = STATE_COLLECTING_DATA;
 }
 
 static void decode_qio_read_cmd(Flash *s)
@@ -899,6 +981,7 @@ static void decode_qio_read_cmd(Flash *s)
     case MAN_WINBOND:
         s->needed_bytes += WINBOND_CONTINUOUS_READ_MODE_CMD_LEN;
         s->needed_bytes += 4;
+        s->state = STATE_COLLECTING_DATA;
         break;
     case MAN_SPANSION:
         s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
@@ -906,9 +989,13 @@ static void decode_qio_read_cmd(Flash *s)
                                     SPANSION_DUMMY_CLK_POS,
                                     SPANSION_DUMMY_CLK_LEN
                                     );
+        s->state = STATE_COLLECTING_DATA;
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+        if (numonyx_check_cmd_mode(s)) {
+            s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
+            s->state = STATE_COLLECTING_DATA;
+        }
         break;
     case MAN_MACRONIX:
         switch (extract32(s->volatile_cfg, 6, 2)) {
@@ -922,13 +1009,14 @@ static void decode_qio_read_cmd(Flash *s)
             s->needed_bytes += 6;
             break;
         }
+        s->state = STATE_COLLECTING_DATA;
         break;
     default:
+        s->state = STATE_COLLECTING_DATA;
         break;
     }
     s->pos = 0;
     s->len = 0;
-    s->state = STATE_COLLECTING_DATA;
 }
 
 static void decode_new_cmd(Flash *s, uint32_t value)
@@ -950,6 +1038,15 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     case ERASE4_32K:
     case ERASE_SECTOR:
     case ERASE4_SECTOR:
+    case DIE_ERASE:
+    case RDID_90:
+    case RDID_AB:
+        s->needed_bytes = get_addr_length(s);
+        s->pos = 0;
+        s->len = 0;
+        s->state = STATE_COLLECTING_DATA;
+        break;
+
     case READ:
     case READ4:
     case DPP:
@@ -958,13 +1055,19 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     case PP:
     case PP4:
     case PP4_4:
-    case DIE_ERASE:
-    case RDID_90:
-    case RDID_AB:
-        s->needed_bytes = get_addr_length(s);
-        s->pos = 0;
-        s->len = 0;
-        s->state = STATE_COLLECTING_DATA;
+        if (get_man(s) == MAN_NUMONYX) {
+            if (numonyx_check_cmd_mode(s)) {
+                s->needed_bytes = get_addr_length(s);
+                s->pos = 0;
+                s->len = 0;
+                s->state = STATE_COLLECTING_DATA;
+            }
+        } else {
+            s->needed_bytes = get_addr_length(s);
+            s->pos = 0;
+            s->len = 0;
+            s->state = STATE_COLLECTING_DATA;
+        }
         break;
 
     case FAST_READ:
@@ -1035,6 +1138,9 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         break;
 
     case JEDEC_READ:
+        if (get_man(s) == MAN_NUMONYX && !numonyx_check_cmd_mode(s)) {
+            break;
+        }
         trace_m25p80_populated_jedec(s);
         for (i = 0; i < s->pi->id_len; i++) {
             s->data[i] = s->pi->id[i];
-- 
2.7.4


