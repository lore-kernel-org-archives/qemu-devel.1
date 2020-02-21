Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC926C35640
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 07:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8816B222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 07:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cDT+g8Tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8816B222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5346-0003YW-OP
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 02:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j531S-0000wF-PL
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 02:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j531P-0001Aj-U9
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 02:46:53 -0500
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com
 ([40.107.223.70]:6081 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>)
 id 1j531P-00015a-O7; Fri, 21 Feb 2020 02:46:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDHNcGFRqGWbxPg+oafuvdAJa0uwS5n5rjJFbHZzXu43k6O+a/xMWPVkwupRxZyfABxl9ZBbVyLBxm81TP1g+Y97v915PcKrgAyaBedHQvTJJ8C4OA9S+sr8WChOOpWFGAPRpXokKCIi7J/S8yWGFmUFbrUZsf21tUPShzBTO3id8bbzCWRP9/R2TbyfburP6wdrW/Mdx1EgeZjaKOsQDEEuVJd8LG2CcNPe02Z73BuVqrzK44Peqbs74XqTPTNUoOLXzSoS/zBqI9ZWXS805B1QAOauWy/ovDYN55AcF0qlno4JX4t5Z70mLcIY2olUFOnMWPKMaQNX6ze6TuKYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYlNz8YaPKiBm+UMfGlKLwarvPCaLrRSOCOOTXu7C9w=;
 b=MtXzcTMzK46AE2Q12q8CIM5oMFZ+emsZFLQ6VzpecAEjxVCoPkR+P3L55tPG1pob4v0mUybl9h3GlR0p5h8oaP8f1zwyQz5vPWOAmWG8+ii0D9ZxGf8KmeAcKuvmCW8usPBzrT8E5Yzdbkf1PwlCz8t7rdXqeSchDPtY0A4PobvjXTPDqw3RCMvdqJbNItWKZFjIsPMMm3OvJbr3aBu5cyoNthjeBLYILdf68TlyXsgd93Hvq7ma3c3I+OzaOM49cfqpNlgpoG6z58Pfkst5pp3hgqNGafARA2kHictlwRUG0k3Y+giJZz+JApprIcYanpGAasyaa6J2wii7cYcxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=suse.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYlNz8YaPKiBm+UMfGlKLwarvPCaLrRSOCOOTXu7C9w=;
 b=cDT+g8TzNAeorpg/oR/KR+AMZoxESY/mILk3qc+PRrajRELdKRwRXQJy21ttSK67x/47CYGbKGhqpIawlKfoiCtja1qsbjy8nn1a3hZSEy5ydO3WNk2CO4iEH8dDwVtnM0el8wwbmTe3xStO9w61ndRrGD4pYTG/e6qRl9RFp6s=
Received: from BN6PR02CA0040.namprd02.prod.outlook.com (2603:10b6:404:5f::26)
 by CY4PR02MB2278.namprd02.prod.outlook.com (2603:10b6:903:15::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Fri, 21 Feb
 2020 07:46:47 +0000
Received: from SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BN6PR02CA0040.outlook.office365.com
 (2603:10b6:404:5f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 07:46:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT044.mail.protection.outlook.com (10.152.72.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Fri, 21 Feb 2020 07:46:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j531J-0002CJ-VC; Thu, 20 Feb 2020 23:46:45 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j531E-0006CZ-SI; Thu, 20 Feb 2020 23:46:40 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01L7keGm018620; 
 Thu, 20 Feb 2020 23:46:40 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j531D-0006CP-TG; Thu, 20 Feb 2020 23:46:40 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 9A58F13C0374; Fri, 21 Feb 2020 13:12:15 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anthony Liguori <anthony@codemonkey.ws>, afaerber@suse.de
Subject: [PATCH v2 1/3] arm_gic: Mask the un-supported priority bits
Date: Fri, 21 Feb 2020 13:12:05 +0530
Message-Id: <1582270927-2568-2-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582270927-2568-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1582270927-2568-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39850400004)(396003)(136003)(346002)(199004)(189003)(8936002)(426003)(70206006)(336012)(70586007)(42186006)(316002)(6266002)(2616005)(110136005)(2906002)(5660300002)(356004)(6666004)(186003)(4326008)(478600001)(26005)(81156014)(8676002)(81166006)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR02MB2278; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ebfaa9b-1b2d-4b3f-4c37-08d7b6a233bf
X-MS-TrafficTypeDiagnostic: CY4PR02MB2278:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2278B1867DB9BDEB5A507D25CA120@CY4PR02MB2278.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-Forefront-PRVS: 0320B28BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XRKzyXILk4oN+5NbGc4zRp8AzepNC9swEz6X+3tnuzmBZRUkfvsKerOf7ZJ/8vCaY5pvOFW8rqY9broeOEbSziEe+Z9NdjdGVdZSzDQctytuSDyqCDOg6Gw+3e19DMo/Q8CKLhJKPSiuZX8dRdFOOqFeEC5LXKIF3Zv6VPKj64xst/+0ziidWrMRQncXgNZ4PU3R+NqooaGflvijHhch0ZursioOz3NpM6it2/L/344cS5bOK+SI/7JNjunMOEI8wUcC4aUp843MOWoPurKRLOyliAKhMcpqAQzNk4uM39mx4Y6LnOgqHZM7Y/WMPIuomCZlHDdQmSbB60KWk10mi3w2SEikkmOyI7v/RFVlOpUyt4dy4pZpk7zYW2Sd/swqKXadg5gd5owKFT+9ESm54foc+3uIvFiyrncIwlWc820GL/coCljnJWunNMYXsFT
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 07:46:46.3875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebfaa9b-1b2d-4b3f-4c37-08d7b6a233bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2278
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.223.70
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

Priority bits implemented in arm-gic can be 8 to 4, un-implemented bits
are read as zeros(RAZ).

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/intc/arm_gic.c                | 26 ++++++++++++++++++++++++--
 hw/intc/arm_gic_common.c         |  1 +
 include/hw/intc/arm_gic_common.h |  1 +
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 1d7da7b..dec8767 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -641,6 +641,23 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
     return ret;
 }
 
+static uint32_t gic_fullprio_mask(GICState *s, int cpu)
+{
+    /*
+     * Return a mask word which clears the unimplemented priority
+     * bits from a priority value for an interrupt. (Not to be
+     * confused with the group priority, whose mask depends on BPR.)
+     */
+    int unimpBits;
+
+    if (gic_is_vcpu(cpu)) {
+        unimpBits = GIC_VIRT_MAX_GROUP_PRIO_BITS;
+    } else {
+        unimpBits = 8 - s->n_prio_bits;
+    }
+    return ~0U << unimpBits;
+}
+
 void gic_dist_set_priority(GICState *s, int cpu, int irq, uint8_t val,
                       MemTxAttrs attrs)
 {
@@ -669,7 +686,7 @@ static uint32_t gic_dist_get_priority(GICState *s, int cpu, int irq,
         }
         prio = (prio << 1) & 0xff; /* Non-secure view */
     }
-    return prio;
+    return prio & gic_fullprio_mask(s, cpu);
 }
 
 static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
@@ -684,7 +701,7 @@ static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
             return;
         }
     }
-    s->priority_mask[cpu] = pmask;
+    s->priority_mask[cpu] = pmask & gic_fullprio_mask(s, cpu);
 }
 
 static uint32_t gic_get_priority_mask(GICState *s, int cpu, MemTxAttrs attrs)
@@ -2055,6 +2072,11 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->n_prio_bits > 8) {
+        error_setg(errp, "num-priority-bits cannot be greater than 8");
+        return;
+    }
+
     /* This creates distributor, main CPU interface (s->cpuiomem[0]) and if
      * enabled, virtualization extensions related interfaces (main virtual
      * interface (s->vifaceiomem[0]) and virtual CPU interface).
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index e6c4fe7..7b44d56 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -357,6 +357,7 @@ static Property arm_gic_common_properties[] = {
     DEFINE_PROP_BOOL("has-security-extensions", GICState, security_extn, 0),
     /* True if the GIC should implement the virtualization extensions */
     DEFINE_PROP_BOOL("has-virtualization-extensions", GICState, virt_extn, 0),
+    DEFINE_PROP_UINT32("num-priority-bits", GICState, n_prio_bits, 8),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index b5585fe..6e0d6b8 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -96,6 +96,7 @@ typedef struct GICState {
     uint16_t priority_mask[GIC_NCPU_VCPU];
     uint16_t running_priority[GIC_NCPU_VCPU];
     uint16_t current_pending[GIC_NCPU_VCPU];
+    uint32_t n_prio_bits;
 
     /* If we present the GICv2 without security extensions to a guest,
      * the guest can configure the GICC_CTLR to configure group 1 binary point
-- 
2.7.4


