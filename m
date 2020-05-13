Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0F1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC5820659
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UwXTF9lU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC5820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvpT-00037B-RY
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYvoT-0001Wc-BG
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:09:01 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com
 ([40.107.237.81]:6586 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYvoQ-00005p-Gw
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:09:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mypy4kkBOu79EIwNmq6qEcVpBX7zvhvUGdy2IxLDKayF+juW+7rX7NKgUm5tXrKd/j4Yetlt06nV3A9gqQa0Nk13Fzm2NP2G2dDwl4szxqonHyex5+PpzEKWlN7Hw0Z+8yL6neCcTXtxpFbqNGhh2O6B9KgzPYYkjGWdWeGEBPK/b4VUZ7AZbolNTxwxOnTH9Ka96WY21kQRCvkHqHNuEoxgnAKWf1tg4zkuBgcrEvmfYnWBfYyejIuZwssHnYhwrtv7bqIA1RHk6v0YKSgindnYNGIEFHMT9AGbMwxmrErbBPxrqHNGR4sfClvtMV3FmGBbGxJTLOlh68UIdCux1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky2frw7xYYuP3OgTRuJ2N2y/8tHtihYuCes7f18Xri4=;
 b=fP34BceaxhWVl8zEgXbm5PrC2fUT2fQN3jIHnnBDAWDp0q0i+3KKGZbZE+KOYLnlZBQhTQ8TVYSvx8du7yvRf4H6/BM0kcJzIozU/CNsY00RLFWnceA41SrZyLOEUPASCVCjeW2lUPAN4T8WiuSezJ/gLJ9iA38KLATOitlAD6t6KdQDPJlVG3TBKafmhSj90keh6G6Hlrx+xc/88xbDkCSGhnpslFwyWTvjsdro75DkVfpPj/RXkWQMGY0KwsozELTu46OUW0voznpCjjud7JZpBrpa2oHBycXWt2OTJVHQYeX4jQHICgHLWN55WQXGNJar9Wr1TW90SMKqKjobkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky2frw7xYYuP3OgTRuJ2N2y/8tHtihYuCes7f18Xri4=;
 b=UwXTF9lUeDMrbjhSg1uNIKFYLdW8s1ZdD6ZD7zToot9e3cpOb8iDU8OMFq8fYowyGyD8kYdwn25GmKCaagO1NVFLUxKwHGA1dCH5opd36bS2iUcI2pXbFzLWumMzUgIDp03rmjpr3cYQa2izFsZkUhg/Et6dIZoJ+ClT/f8Odec=
Received: from SA9PR10CA0012.namprd10.prod.outlook.com (2603:10b6:806:a7::17)
 by SN6PR02MB4622.namprd02.prod.outlook.com (2603:10b6:805:b2::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 13 May
 2020 18:08:56 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:a7:cafe::92) by SA9PR10CA0012.outlook.office365.com
 (2603:10b6:806:a7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend
 Transport; Wed, 13 May 2020 18:08:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Wed, 13 May 2020 18:08:54
 +0000
Received: from [149.199.38.66] (port=59427 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYvo4-0007yA-Lk
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:08:36 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYvoM-0002TI-Gv
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:08:54 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jYvoI-0002SZ-2I; Wed, 13 May 2020 11:08:50 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V2 2/4] target/microblaze: gdb: Extend the number of registers
 presented to GDB
Date: Wed, 13 May 2020 11:08:46 -0700
Message-Id: <1589393329-223076-2-git-send-email-komlodi@xilinx.com>
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
 SFS:(39860400002)(376002)(136003)(346002)(396003)(46966005)(33430700001)(70206006)(2616005)(44832011)(82740400003)(33440700001)(426003)(316002)(2906002)(107886003)(47076004)(8936002)(9786002)(5660300002)(8676002)(336012)(86362001)(82310400002)(36756003)(7696005)(356005)(70586007)(186003)(81166007)(26005)(6666004)(6916009)(478600001)(4326008);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b85c4b2-6dca-4992-9da8-08d7f768b301
X-MS-TrafficTypeDiagnostic: SN6PR02MB4622:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4622ABE90EA298C1023BAE08D0BF0@SN6PR02MB4622.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pz+r8qp62a+O+kZrOChgWDDtVgRkpunXLOuGczVtAngLuK9Dq4cW9Gu/hjEIe7Qynr1IBN9Kb869SpGHtCzkSCD4wZuYYEXECVUzdEpKOsTEeC1vBE5wPFat6ahKM4jsWmoTnYnv7oPZgUKx8haGNrXsRaH2MiVIpPm4NCH8yfOphtygNrK58hNHcwo3bdcloNzOwASKmJZ4D1DVLB0XQiZplVVTy97TPqPuaj9q1iiZOzm0kJrqvo3qZpI6CSnM5hzu0N6ZJXfPp2F5HhBm5CPz2ERG2L8+Qm1W7Oxv8ijtfuQSHSUAfbGbI8xmd31ZI0HK96pglAvsMpZ95UvmEMUKPbi5qPkmHNXWTmbTUR+bIJ+1lSWs5+Ssvl51HBY03ir7eVsEWUaYYAqV4A6kmU6GQlxj3ah4QdaEpA+4r3Z32lXURus0FM+BR5J3E6iXNNNsvdLF7N6H8r5ZENY8e12M7664fJ6Ju1Ao11Is5pjT3SsJBDovmOV+JecuOblml0b0LPioIISN8e38aNiU7ABDd6GNGWI/NheX5Jzhbt8W6zRV9MgJJfRJvZPdqthujjvlbQ2QOzIlBQID7bH8SQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 18:08:54.8071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b85c4b2-6dca-4992-9da8-08d7f768b301
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4622
Received-SPF: pass client-ip=40.107.237.81; envelope-from=komlodi@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 14:08:57
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

Increase the number of Microblaze registers QEMU will report when
talking to GDB.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
---
 target/microblaze/cpu.c     |  2 +-
 target/microblaze/gdbstub.c | 52 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 41cac1b..5b6ad5b 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -331,7 +331,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
 #endif
     dc->vmsd = &vmstate_mb_cpu;
     device_class_set_props(dc, mb_properties);
-    cc->gdb_num_core_regs = 32 + 5;
+    cc->gdb_num_core_regs = 32 + 27;
     cc->gdb_get_dynamic_xml = mb_gdb_get_dynamic_xml;
     cc->gdb_core_xml_file = "microblaze-core.xml";
 
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index cdca434..af29f00 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -26,12 +26,37 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
 
+    /*
+     * GDB expects registers to be reported in this order:
+     * R0-R31
+     * PC-BTR
+     * PVR0-PVR11
+     * EDR-TLBHI
+     * SLR-SHR
+     */
     if (n < 32) {
         return gdb_get_reg32(mem_buf, env->regs[n]);
     } else {
-        return gdb_get_reg32(mem_buf, env->sregs[n - 32]);
+        n -= 32;
+        switch (n) {
+        case 0 ... 5:
+            return gdb_get_reg32(mem_buf, env->sregs[n]);
+        /* PVR12 is intentionally skipped */
+        case 6 ... 17:
+            n -= 6;
+            return gdb_get_reg32(mem_buf, env->pvr.regs[n]);
+        case 18 ... 24:
+            /* Add an offset of 6 to resume where we left off with SRegs */
+            n = n - 18 + 6;
+            return gdb_get_reg32(mem_buf, env->sregs[n]);
+        case 25:
+            return gdb_get_reg32(mem_buf, env->slr);
+        case 26:
+            return gdb_get_reg32(mem_buf, env->shr);
+        default:
+            return 0;
+        }
     }
-    return 0;
 }
 
 int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
@@ -50,7 +75,28 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     if (n < 32) {
         env->regs[n] = tmp;
     } else {
-        env->sregs[n - 32] = tmp;
+        n -= 32;
+        switch (n) {
+        case 0 ... 5:
+            env->sregs[n] = tmp;
+            break;
+        /* PVR12 is intentionally skipped */
+        case 6 ... 17:
+            n -= 6;
+            env->pvr.regs[n] = tmp;
+            break;
+        case 18 ... 24:
+            /* Add an offset of 6 to resume where we left off with SRegs */
+            n = n - 18 + 6;
+            env->sregs[n] = tmp;
+            break;
+        case 25:
+            env->slr = tmp;
+            break;
+        case 26:
+            env->shr = tmp;
+            break;
+        }
     }
     return 4;
 }
-- 
2.7.4


