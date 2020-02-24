Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A6EC3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 09:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2591020838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 09:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bKhUaoie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2591020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6AKX-0004X4-7S
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 04:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j6AHl-0000nv-FC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j6AHk-0007wA-5E
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:44:21 -0500
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com
 ([40.107.236.80]:6069 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>)
 id 1j6AHk-0007vd-07; Mon, 24 Feb 2020 04:44:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYn171X+7Mxw3hbkjtdnhyKNNLWrTT+cyRaENgUnNjRQX8wp1kNViSkB7/JFZtHkJ/6UkeoQ7EBSPOCYr+18xk7XGpk1h8/fR82ORc9PvhXWIaEoHAJ23rju72/9nqrGYbOV8mDG/om5xXuxnpwWtDy4FeuX80nlXvncXG/47cllRY63jPSWMP+55jiBUkdR0pvTfkvFyZBhLx7cf3MKP9gjAWjNuobHXBWpu2udgGTOCovZUDfTUacv3Ee2xymyN1mHy8yPS1yPbqJ6zP8dzJvpsO15wVCyzLvUMjX6rKM5B/9X+/LD8l/hlU1zmynm0PWY4ZtTAJFh8I6qYtaA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlQWv1Ef3DVWgCVdOxB07G7FMmH/s4dCY+atSPkOJog=;
 b=kEsx3MhCHP6JD3EpjhPZ+05PVXtm48WmaHi5N5cdR8CdX56thWMy4xztH9J/LzNF4hvpUFG1niJfhy2zXSgpO3O2xEH9ANOzzZ3UEVlwIl8RtJdVwvOPBNXqWwDHtYVi0fs4ec9pH2ryQGi4PryxUW0BiuYiOo3F6WBl0dEtEa9G7rWesHRYSm7nv2xWJ+PmiQJkQ8a8wucnfUrp93VZNYcM2br3qwrLvfjxBc2z3jJCKN3ksctLuYjErR9KCbpAnF/n7ToXC3GTFMocX7kj0e7Ctpm6Nw/+r8HSopennyDtN9f8Xb9rJPslL5QtPTV9zkzU78SkpAwEZ1UXVi9NWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=suse.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlQWv1Ef3DVWgCVdOxB07G7FMmH/s4dCY+atSPkOJog=;
 b=bKhUaoieuQdkqqlVC6bQUgnpPY0x2rudgNIFiXuMTHYGPt5ZhuJJtE0D3BAIFr8Zj+ImSRGxyxoxjfXuEkJ3rxpbJGKk/oSiTq5zZ+soI7CYz5Iou4F/OneneIX54gSgOI8GojnufQ9RqCClgJNDLcskhOEJ5hYCspcuqFndW1k=
Received: from BYAPR02CA0048.namprd02.prod.outlook.com (2603:10b6:a03:54::25)
 by CY4PR02MB2454.namprd02.prod.outlook.com (2603:10b6:903:6c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Mon, 24 Feb
 2020 09:44:17 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BYAPR02CA0048.outlook.office365.com
 (2603:10b6:a03:54::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Mon, 24 Feb 2020 09:44:17 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Mon, 24 Feb 2020 09:44:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j6AHf-0003mt-TQ; Mon, 24 Feb 2020 01:44:15 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j6AHa-0008PY-Q4; Mon, 24 Feb 2020 01:44:10 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01O9iAAG029121; 
 Mon, 24 Feb 2020 01:44:10 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j6AHZ-0008PS-OY; Mon, 24 Feb 2020 01:44:09 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 5CCCE13C0374; Mon, 24 Feb 2020 15:09:37 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anthony Liguori <anthony@codemonkey.ws>, afaerber@suse.de
Subject: [PATCH v3 1/3] arm_gic: Mask the un-supported priority bits
Date: Mon, 24 Feb 2020 15:09:22 +0530
Message-Id: <1582537164-764-2-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582537164-764-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1582537164-764-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(81156014)(2616005)(8676002)(5660300002)(336012)(81166006)(478600001)(42186006)(426003)(8936002)(110136005)(4326008)(316002)(356004)(2906002)(26005)(6666004)(186003)(70586007)(70206006)(6266002)(36756003)(42866002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR02MB2454; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9196654-731c-4439-e1e8-08d7b90e1d3a
X-MS-TrafficTypeDiagnostic: CY4PR02MB2454:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2454831E84BB180C87DA9A74CAEC0@CY4PR02MB2454.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPRZY/UVoHSxOllNXxJ3e8de+jy48DfvwzuObViOxB30ITgcoBoWurwmqvx+AiV+ukFAVmy7QIS6YUu3hczkhkoXxHk/ks8nLW4EDHK7FaXP5blBbj5YoYUy5ZZI5u7mi2/n7I4hdYNzQHceSn+FUWxAyln8k61vp64w1VKqDCbuoajcl3GZ/mpOG5NEJ1lx8W1byVcxLhpKX0EBaXJQhFfrib7EjbfN7Lvss6bmOoDGOjgjsBmYp7IDQOHYoqOgrDjQoY3F1yFL9/c6E7YVkQ2VNlYELOK/SRXjOghbxp5+I/JWPY0W2mVuZJsel+wWRjmZ4LSmbebg4rWk9eGIQjYxCLzctrxapcxRSi52w/30eOja+Vqtghv+ucw/dsP8+a8k2d2jGNy7GF9/78mXyQy/FtTzpsItFOXAi89QM0EoqiEN0yydC9e+cRDchq2N9BohCalj2cQfpFOS1Wlyvf4dNmZz9ue+MyuSJU/1YJqEhMmdvW7N5L1rBn8W6Jh/
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 09:44:16.4871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9196654-731c-4439-e1e8-08d7b90e1d3a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2454
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.236.80
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
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c                | 33 +++++++++++++++++++++++++++++++--
 hw/intc/arm_gic_common.c         |  1 +
 include/hw/intc/arm_gic.h        |  2 ++
 include/hw/intc/arm_gic_common.h |  1 +
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 1d7da7b..c60dc6b 100644
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
+    int priBits;
+
+    if (gic_is_vcpu(cpu)) {
+        priBits = GIC_VIRT_MAX_GROUP_PRIO_BITS;
+    } else {
+        priBits = s->n_prio_bits;
+    }
+    return ~0U << (8 - priBits);
+}
+
 void gic_dist_set_priority(GICState *s, int cpu, int irq, uint8_t val,
                       MemTxAttrs attrs)
 {
@@ -651,6 +668,8 @@ void gic_dist_set_priority(GICState *s, int cpu, int irq, uint8_t val,
         val = 0x80 | (val >> 1); /* Non-secure view */
     }
 
+    val &= gic_fullprio_mask(s, cpu);
+
     if (irq < GIC_INTERNAL) {
         s->priority1[irq][cpu] = val;
     } else {
@@ -669,7 +688,7 @@ static uint32_t gic_dist_get_priority(GICState *s, int cpu, int irq,
         }
         prio = (prio << 1) & 0xff; /* Non-secure view */
     }
-    return prio;
+    return prio & gic_fullprio_mask(s, cpu);
 }
 
 static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
@@ -684,7 +703,7 @@ static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
             return;
         }
     }
-    s->priority_mask[cpu] = pmask;
+    s->priority_mask[cpu] = pmask & gic_fullprio_mask(s, cpu);
 }
 
 static uint32_t gic_get_priority_mask(GICState *s, int cpu, MemTxAttrs attrs)
@@ -2055,6 +2074,16 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->n_prio_bits > GIC_MAX_PRIORITY_BITS ||
+       (s->virt_extn ? s->n_prio_bits < GIC_VIRT_MAX_GROUP_PRIO_BITS :
+        s->n_prio_bits < GIC_MIN_PRIORITY_BITS)) {
+        error_setg(errp, "num-priority-bits cannot be greater than %d"
+                   " or less than %d", GIC_MAX_PRIORITY_BITS,
+                   s->virt_extn ? GIC_VIRT_MAX_GROUP_PRIO_BITS :
+                   GIC_MIN_PRIORITY_BITS);
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
 
diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index ed703a1..303b974 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -68,6 +68,8 @@
 
 /* Number of SGI target-list bits */
 #define GIC_TARGETLIST_BITS 8
+#define GIC_MAX_PRIORITY_BITS 8
+#define GIC_MIN_PRIORITY_BITS 4
 
 #define TYPE_ARM_GIC "arm_gic"
 #define ARM_GIC(obj) \
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


