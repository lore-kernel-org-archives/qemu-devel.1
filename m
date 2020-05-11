Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68262C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3336D20746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="L5Yd9Stx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3336D20746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYC82-00074B-8o
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 13:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYC70-0005Bn-IF
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:21:06 -0400
Received: from mail-dm6nam10on2075.outbound.protection.outlook.com
 ([40.107.93.75]:49536 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYC6v-0003uR-W0
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:21:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAXYwUkepeb3IxW/H69fEtCoPd0O9Gxtjb6ll+E2XnlI9G3piZQWXv8qTIO84HdquYDMPNxEmxwQSd+WSuryFypngx6yhrG1Q+HXup9HRHCB4HsEb4VB9tj2AAqVe/6yUcquMhPPdVwsNTECD0xyI+6IWO00aoIpb6jD+efew9oNPCgQ4IaGEahqlVYwvEQl4yYQid9tNpn3/zQPpEHK0M61j8OQenSOOHpLIVzsD6SIxsVOSqDxaAzEAQosfZ0SjrY89fnHbJyom9hggjkadg9sgeCjW8f7wJWv4lPP9n9M2Sexq/HWaivQXvM8RrnlflphKQpP1ZTi80x1xV43Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUBtE68pDVFOLxmda2X/+UzxTjyagMw2y9Wh/zkqtPk=;
 b=YE+klWCCThk2B8o1T42n5jTBGqWFZkR6tosgeZUDfYhueTpLRaD4g9MzdsE5yZWvoFYXlpoHpk/zIIbqrw3q14CCmel5YFS/JgqqdPjrqpWClaiR6kXmVt+x6A9zZohJX/axkf/Qh6VOTY6L624X1KZHylZ/I6ONdcDEiyYaGOcDsA1weW+HH8dAqT5tGkZvCBs1BNVtF1IXn6peTwiMgdOtQXOGXTMliBkNgN2Ml8fG0n6dM1TSd2/XK/kEJSKeqVVgtuC3QLpE89VM6uDonYmxXGTuNC9QzQvU62zN8Po1sqaOAc4yoKsdFShmD0MKa9B7kY/cNOemcIB/2GBA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUBtE68pDVFOLxmda2X/+UzxTjyagMw2y9Wh/zkqtPk=;
 b=L5Yd9StxQAv+mVcaW+gtp9TGRbfK/HoykM/KFs1WgRTJAMOoJNIKKsUHpIN1Cp2L+0Xse4M2cvGtw3cVdooEz0OqWLu4b4piMfuw1oyvyEkny5WtFnvgE161Q6XmnPLIOIpv9WPLk18wRUihr8Eu42ufd8ANdnXPR4DQYQMLvC8=
Received: from CY4PR01CA0016.prod.exchangelabs.com (2603:10b6:903:1f::26) by
 BYAPR02MB5926.namprd02.prod.outlook.com (2603:10b6:a03:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 17:05:57 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:1f:cafe::7d) by CY4PR01CA0016.outlook.office365.com
 (2603:10b6:903:1f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Mon, 11 May 2020 17:05:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Mon, 11 May 2020 17:05:56
 +0000
Received: from [149.199.38.66] (port=35090 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYBs5-0007nK-3I
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:05:41 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYBsK-0004Py-7l
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:05:56 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04BH5pQL000797; 
 Mon, 11 May 2020 10:05:52 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jYBsF-0004PW-SP; Mon, 11 May 2020 10:05:51 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/4] target/microblaze: gdb: Fix incorrect SReg reporting
Date: Mon, 11 May 2020 10:05:50 -0700
Message-Id: <1589216751-106038-4-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589216751-106038-1-git-send-email-komlodi@xilinx.com>
References: <1589216751-106038-1-git-send-email-komlodi@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(39860400002)(136003)(396003)(46966005)(33430700001)(107886003)(4326008)(6916009)(70206006)(478600001)(316002)(36756003)(7696005)(47076004)(2906002)(426003)(5660300002)(2616005)(336012)(86362001)(26005)(70586007)(186003)(9786002)(8676002)(82310400002)(44832011)(356005)(82740400003)(81166007)(33440700001)(8936002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be2a6a3d-06af-4b43-b03d-08d7f5cd922e
X-MS-TrafficTypeDiagnostic: BYAPR02MB5926:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5926C9E270BC9A5436897020D0A10@BYAPR02MB5926.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZajc8Ygv9xfrhvXQYTFGG6RmyZmx4HbeQCjHoeyOgiVI9hZo1uDw5F1+qUGjcQt8kBjv/nT29zTYSfxvs6/YvTD9jFlI3Ni6fcrBRxRxiC7Y1dhctJl2HzezusP70FP6Wj+YyYcgK0pV9CibZbnPDyoTK+k4xLuPw/bxzruWvqSOjarLLjtutBv8/rOOSNseYnfi6E/GG6/nKi+Wf4CX9rfoh58ibAtN+mel3AVz1rwltSsjU5jjMf+yTRqglECbD2wP2i8vJqtqn+Iq6ri3VmqzLhNg/9KgAwBo+IO5kyLahBZi8Rmrvbp+PfIxHEGcx7gSmQqZz8DQlrvn0xQox3itLWt4AbTuVOlJrksdG9LpntdgWn3KCOLro7nqpfJN3DUNqfvszewx20Cfa7Tbolxzb06GerMqmFrGu58D5hroJqCXE/S3DGBzBkTg+bDLql2ZHP9+jCBS10ckkGzMrSDYw1NwW+gktcwc5636mkp0LaBq3iEE92eg1p+ETAJZ3Njxxn65qPDKVE5ukzuGKxOTLXJMwW8JDkJscAn4JNVXDGTUVXlzQi+sRLn5u+BoW3g4WDjRw5udiK1FKDyJA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 17:05:56.5823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2a6a3d-06af-4b43-b03d-08d7f5cd922e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5926
Received-SPF: pass client-ip=40.107.93.75; envelope-from=komlodi@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 13:20:58
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SRegs used to be reported to GDB by iterating over the SRegs array,
however we do not store them in an order that allows them to be
reported to GDB in that way.

To fix this, a simple map is used to map the register GDB wants to its
location in the SRegs array.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 target/microblaze/gdbstub.c | 59 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index af29f00..485b717 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -25,6 +25,21 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
+    /*
+     * GDB expects SREGs in the following order:
+     * PC, MSR, EAR, ESR, FSR, BTR, EDR, PID, ZPR, TLBX, TLBSX, TLBLO, TLBHI.
+     * They aren't stored in this order, so make a map.
+     * PID, ZPR, TLBx, TLBsx, TLBLO, and TLBHI aren't modeled, so we don't
+     * map them to anything and return a value of 0 instead.
+     */
+    static const uint8_t sreg_map[6] = {
+        SR_PC,
+        SR_MSR,
+        SR_EAR,
+        SR_ESR,
+        SR_FSR,
+        SR_BTR
+    };
 
     /*
      * GDB expects registers to be reported in this order:
@@ -40,15 +55,16 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         n -= 32;
         switch (n) {
         case 0 ... 5:
-            return gdb_get_reg32(mem_buf, env->sregs[n]);
+            return gdb_get_reg32(mem_buf, env->sregs[sreg_map[n]]);
         /* PVR12 is intentionally skipped */
         case 6 ... 17:
             n -= 6;
             return gdb_get_reg32(mem_buf, env->pvr.regs[n]);
-        case 18 ... 24:
-            /* Add an offset of 6 to resume where we left off with SRegs */
-            n = n - 18 + 6;
-            return gdb_get_reg32(mem_buf, env->sregs[n]);
+        case 18:
+            return gdb_get_reg32(mem_buf, env->sregs[SR_EDR]);
+        /* Other SRegs aren't modeled, so report a value of 0 */
+        case 19 ... 24:
+            return gdb_get_reg32(mem_buf, 0);
         case 25:
             return gdb_get_reg32(mem_buf, env->slr);
         case 26:
@@ -66,29 +82,52 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUMBState *env = &cpu->env;
     uint32_t tmp;
 
+    /*
+     * GDB expects SREGs in the following order:
+     * PC, MSR, EAR, ESR, FSR, BTR, EDR, PID, ZPR, TLBX, TLBSX, TLBLO, TLBHI.
+     * They aren't stored in this order, so make a map.
+     * PID, ZPR, TLBx, TLBsx, TLBLO, and TLBHI aren't modeled, so we don't
+     * map them to anything.
+     */
+    static const uint8_t sreg_map[6] = {
+        SR_PC,
+        SR_MSR,
+        SR_EAR,
+        SR_ESR,
+        SR_FSR,
+        SR_BTR
+    };
+
     if (n > cc->gdb_num_core_regs) {
         return 0;
     }
 
     tmp = ldl_p(mem_buf);
 
+    /*
+     * GDB expects registers to be reported in this order:
+     * R0-R31
+     * PC-BTR
+     * PVR0-PVR11
+     * EDR-TLBHI
+     * SLR-SHR
+     */
     if (n < 32) {
         env->regs[n] = tmp;
     } else {
         n -= 32;
         switch (n) {
         case 0 ... 5:
-            env->sregs[n] = tmp;
+            env->sregs[sreg_map[n]] = tmp;
             break;
         /* PVR12 is intentionally skipped */
         case 6 ... 17:
             n -= 6;
             env->pvr.regs[n] = tmp;
             break;
-        case 18 ... 24:
-            /* Add an offset of 6 to resume where we left off with SRegs */
-            n = n - 18 + 6;
-            env->sregs[n] = tmp;
+        /* Only EDR is modeled in these indeces, so ignore the rest */
+        case 18:
+            env->sregs[SR_EDR] = tmp;
             break;
         case 25:
             env->slr = tmp;
-- 
2.7.4


