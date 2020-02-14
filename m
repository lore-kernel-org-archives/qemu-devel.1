Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C01C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34C4222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bd4WNduk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34C4222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2avN-0002Kw-4C
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 08:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j2auF-0000lB-9g
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j2auE-0004zM-5e
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:21:19 -0500
Received: from mail-co1nam11on2066.outbound.protection.outlook.com
 ([40.107.220.66]:6211 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>)
 id 1j2auD-0004vb-UB; Fri, 14 Feb 2020 08:21:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRu5W4zFYC0LfzTqbD3nOPT7mD5l7pWpXe4MIFw5iPeppKBQqIESiDJmR/nnkN99kTM66yIig2jLhD7eIOKAy9AkRzJCvE3BCGMT4GTMb/pjaepwtvmxjvNa54CocHkmmXAH94pnMb1YhVUuFSHSD8j3gBwD22J+8PbI++9jTmYZyHN92J1AH9YywdY8SCSfnFdPvQIsuUIZZ37Abtyr68La2iOQtkACxnUFIjVSiYZyfPX+TUrSVlVbPSqd6+SSGTp8J6V1+zHEhnu4kyvgKU/WIySEqLGvajz1R8tVaYEXB3enx4ThDO5fLZAJpuErrDDHeHOZXiahyEgwKfoZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwdS5ExHOIylaFbMS9612gcCXi3YjIuVuD5VCE9IRBQ=;
 b=X8b+GLJggOhaGzjD6GerRATf0dVstVf6XJkDmGxwmiccYcSFDGB3b3sHSrGWejz4SQgTM6nUYie/RxtZ6LnJSp2wCVeddM9uXOAzYQkxQa1K5Z+x85yczT3Ym2wTKG0nkkQIu3fWi/IQXXIDnCBuAoDeAAnpkSYzb+pGZpRwMO58P6WDymuyBliQirHOJYDTPR9IYzU/oL7finJKS4Z1DDx8ad72zFEDRZe+Gwhnp4cDTYaemHkCfy7mn35AgHZbRaz3DdFZlBqNusxrGu3jh5MHbHZkCtGgB+Pkt7TOevQRhI2nCeveNZ3Vl7sUwBiFKEQOCdNU4xVTNTBjuNgblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=suse.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwdS5ExHOIylaFbMS9612gcCXi3YjIuVuD5VCE9IRBQ=;
 b=bd4WNdukYPOK6oi4nScevVN4e/DIfJeEOKycjJP6enJ4rR/hWs55ZLlwJ3wOeyxJ2SlPsIMyzsupTkrbLppSQvOP3dRdAPY7thPnDm5tNjVE4VqAEG6DUzqWyLj2N3LEpZgR5nqlP+d/eF5fNOkTRnfEocIg80/iMNtJzpJoYvE=
Received: from SN4PR0201CA0045.namprd02.prod.outlook.com
 (2603:10b6:803:2e::31) by DM6PR02MB6044.namprd02.prod.outlook.com
 (2603:10b6:5:1f5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Fri, 14 Feb
 2020 13:21:15 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by SN4PR0201CA0045.outlook.office365.com
 (2603:10b6:803:2e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Fri, 14 Feb 2020 13:21:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Fri, 14 Feb 2020 13:21:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j2auA-0001Ua-7B; Fri, 14 Feb 2020 05:21:14 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j2au5-0006fn-3U; Fri, 14 Feb 2020 05:21:09 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01EDL8iT013753; 
 Fri, 14 Feb 2020 05:21:08 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j2au4-0006fc-3G; Fri, 14 Feb 2020 05:21:08 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 9ADB513C0374; Fri, 14 Feb 2020 18:47:01 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anthony Liguori <anthony@codemonkey.ws>, afaerber@suse.de
Subject: [PATCH 1/3] arm_gic: Mask the un-supported priority bits
Date: Fri, 14 Feb 2020 18:46:50 +0530
Message-Id: <1581686212-9625-2-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581686212-9625-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1581686212-9625-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(70586007)(4326008)(110136005)(70206006)(316002)(2906002)(42186006)(336012)(356004)(6666004)(426003)(5660300002)(26005)(186003)(6266002)(2616005)(81166006)(478600001)(8676002)(81156014)(8936002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB6044; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 476c6e60-7bdb-4891-5607-08d7b150c47e
X-MS-TrafficTypeDiagnostic: DM6PR02MB6044:
X-Microsoft-Antispam-PRVS: <DM6PR02MB60447FE492609174043736B6CA150@DM6PR02MB6044.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-Forefront-PRVS: 03137AC81E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YlejLYiRkUVK3ZBOItsWqMXZCEwNVQiGD0LR8kz7ipa4wWWDTFZ3+quUcAw+IbBQ7A84my1Q7hNqlVLp8tTCjEsEC9x1Z+aBRYmJlDvY/bd2Xdex7u/MoY1MHyweiZ61MIT2KpMh1BPGSir6UJ7T2M3QtqeXbMfoW+hl6su4bVut0V4RNdbGINdkRp/QXZg/52Z2J9VZzSYP4gS5PjR0zlaLBGzRM3U+/fIc66GHa9bwYUB2cQiyHTTWZDMjHvfxxjx4Nquawq3614nCFzhH78FgvaiIylZzzV2xG64aXMqJO6DzMHFYzd+iGndMLghE1dEQLLg46No0ZuFkHp9tdNJIqQabQTvVTvd+2WK15ARdqYejJUHafv17btkzYimH8FY7/s94DtyFEpxeT4EnWq/ZUXriRu/SJ8BsHehdlRwqcRI4l3vKfk5/6ol6f97S
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 13:21:14.6597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476c6e60-7bdb-4891-5607-08d7b150c47e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6044
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.220.66
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

Priority bits implemented in arm-gic can 8 to 4, un-implemented bits
are read as zeros(RAZ).

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/intc/arm_gic.c                | 9 ++++++---
 hw/intc/arm_gic_common.c         | 1 +
 include/hw/intc/arm_gic_common.h | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 1d7da7b..8875330 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -43,6 +43,9 @@
         }                                                               \
     } while (0)
 
+#define UMASK(n) \
+    ((((1 << n) - 1) << (8 - n)) & 0xFF)
+
 static const uint8_t gic_id_11mpcore[] = {
     0x00, 0x00, 0x00, 0x00, 0x90, 0x13, 0x04, 0x00, 0x0d, 0xf0, 0x05, 0xb1
 };
@@ -652,9 +655,9 @@ void gic_dist_set_priority(GICState *s, int cpu, int irq, uint8_t val,
     }
 
     if (irq < GIC_INTERNAL) {
-        s->priority1[irq][cpu] = val;
+        s->priority1[irq][cpu] = val & UMASK(s->n_prio_bits) ;
     } else {
-        s->priority2[(irq) - GIC_INTERNAL] = val;
+        s->priority2[(irq) - GIC_INTERNAL] = val & UMASK(s->n_prio_bits);
     }
 }
 
@@ -684,7 +687,7 @@ static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
             return;
         }
     }
-    s->priority_mask[cpu] = pmask;
+    s->priority_mask[cpu] = pmask & UMASK(s->n_prio_bits);
 }
 
 static uint32_t gic_get_priority_mask(GICState *s, int cpu, MemTxAttrs attrs)
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index e6c4fe7..e4668c7 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -357,6 +357,7 @@ static Property arm_gic_common_properties[] = {
     DEFINE_PROP_BOOL("has-security-extensions", GICState, security_extn, 0),
     /* True if the GIC should implement the virtualization extensions */
     DEFINE_PROP_BOOL("has-virtualization-extensions", GICState, virt_extn, 0),
+    DEFINE_PROP_UINT32("num-prio-bits", GICState, n_prio_bits, 8),
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


