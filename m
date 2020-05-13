Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C7AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92CC2065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="M5mPljSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92CC2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvpd-0003FN-4r
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYvoU-0001YJ-Oa
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:09:02 -0400
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com
 ([40.107.92.45]:6227 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYvoQ-00005S-5S
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:09:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1q7RS9DsySj2fGHHE06x24n4SPZdgwpMx7sTLJnJPJMZplAq5umeW2Qb/GjDfMIltG8sIjuvaxIB4CRs67St56bkYyHNVVhsFOvVGJ/b8xgrIQJTzx5Yls/Zow8gbSouSv+CihkTz4PGlkj4d+1GVp4meIA+0XNNe10vBJZBVKvzsGrAV0ejwbUSFWyOBw2lU++C7ki8FwqyS5amFeeEJQ5jgIEw9vD76Rj72uO5sR6m/LHMSUXbQHC1sVth/bmG039Pr8xl9QCSzfiiww41gLFEZjOUpiTjyxGs0+6alE+4XDE/Elp2/tTFSt/0xTXnBwQw7bm9O0EqNPpvZgErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUBtE68pDVFOLxmda2X/+UzxTjyagMw2y9Wh/zkqtPk=;
 b=nttwsErfwVdMRv8fVLPzNJZhRTxCij1dkQ2uL1W/pDVtho9cnoJbB+8o2qRpDPp1XA+NR/r6XGVshUaR4kpIJhBovF9xIgcSKwDstAEnpxSqpYSdKCU5EMB2tT51IHXDz79EamxpbaTCYDz/evA5braal+Dw3uMDrAnVzkQv/D765PVSLpX/8ncskiQTI+utcfGzpQXyBMoknKnMcn/i0taDhIh80sceP1Z+UwwC5e+knrtzWy1vPzKsyOzWvZdev0gjmMcKL8ECrEvouht79WFmsIdSV9hWOIKsGccSyClmhquKnCUJaZLbU+PI0w1xLRfX2N7Tt5XQT3fBpeSVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUBtE68pDVFOLxmda2X/+UzxTjyagMw2y9Wh/zkqtPk=;
 b=M5mPljSyQuUTqvLjk04Ws+xf9/yGAKWFU0oUBnGphUaBaX5lXcCIxWewBXV8Nz1zcJM0MG8AY1irPoGG47BfXsMWCQmP0fnHglvB+H3vbhH2AStpBb0oz/6c7jdNWWHybMMVh8mU5Sq5DFMHSkJCyfKOz2PhbT/2p+n+nUtr/LE=
Received: from SN6PR16CA0052.namprd16.prod.outlook.com (2603:10b6:805:ca::29)
 by MN2PR02MB7103.namprd02.prod.outlook.com (2603:10b6:208:20e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 13 May
 2020 18:08:55 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::6a) by SN6PR16CA0052.outlook.office365.com
 (2603:10b6:805:ca::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend
 Transport; Wed, 13 May 2020 18:08:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Wed, 13 May 2020 18:08:54
 +0000
Received: from [149.199.38.66] (port=59423 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYvo4-0007y7-KF
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:08:36 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYvoM-0002TI-FO
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:08:54 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jYvoI-0002SZ-2i; Wed, 13 May 2020 11:08:50 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V2 3/4] target/microblaze: gdb: Fix incorrect SReg reporting
Date: Wed, 13 May 2020 11:08:47 -0700
Message-Id: <1589393329-223076-3-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
References: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(346002)(136003)(39860400002)(46966005)(33430700001)(36756003)(426003)(2616005)(7696005)(107886003)(336012)(70206006)(44832011)(70586007)(2906002)(86362001)(186003)(26005)(8676002)(4326008)(47076004)(8936002)(356005)(5660300002)(82740400003)(9786002)(33440700001)(6916009)(81166007)(6666004)(82310400002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c42d6f02-fe6f-4ac1-73cd-08d7f768b2f9
X-MS-TrafficTypeDiagnostic: MN2PR02MB7103:
X-Microsoft-Antispam-PRVS: <MN2PR02MB71036B878AB0AE4109D2D069D0BF0@MN2PR02MB7103.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+id/tbyT7w+WzUAxkABtBg/NGMLJW03n6e8NIIXtuidQDRlSdgghBwNb1a3P4OLJCCOh9SGEu6VGrq6TNIf2zKQPoLKQoPVwsQbsOG6/rSwvfINMqPAatMpX/WYvfzdenMHKGDqrkjRDm1woNwsoAca6j5eJu4ZeZR13W8Xmh+s/1CRcq/SB2a1TiCEUB4E0CWXCaPVMcBax0KOr2kR7w6NdmqKYi6RHNq/JUh9tFoVlHGk3eGOWiyb9zBDTitnXib9XxLAchw3RFUHpiYhQ8qWVrV1nhRWl/XyuIiylWCqBWo7XJD5cEBBTdIxCpefAxLZeBz5pAwUMfCM68lXhIvPBYRf1XUQUrdObU60r5MCJ+q18AvoIeddg+VQmBTiXEOow/mxDAC6ORv/MrJKGhRyYThqAhPltZSMQFbre/weTlHR10BJX32iPzM0zuGIlvsUGjhdhDrI1TLt0tvkTqMGGTuG3FOtCeP8U0/yMXnyveypqnbwlyG9SkiT98n6O1UKo/nloxK0fMeRpGcaQUg+BblPl3U4np6sKMhSvTJEKugnsmwiy5CFh7IyaH/8RJPjoXuyhyidWX0ba8MIJA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 18:08:54.7536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c42d6f02-fe6f-4ac1-73cd-08d7f768b2f9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7103
Received-SPF: pass client-ip=40.107.92.45; envelope-from=komlodi@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 14:08:56
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


