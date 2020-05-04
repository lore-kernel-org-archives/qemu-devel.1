Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D54CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E344420721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kB9/XfEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E344420721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbtz-0002oG-3C
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrS-0007Cl-E0; Mon, 04 May 2020 10:14:22 -0400
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com
 ([40.107.236.67]:20641 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrR-0005e4-HF; Mon, 04 May 2020 10:14:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irR4B1MyJE+7bAuZ8qVRvtzD3XpLsdokuKMzQsDWV+S3AmlgxE+CRiPos9GAXVzlPyQY1JklTd8IB/irBZtgie4s51ryHgrS/GIaVVWUefTVxhpjtfsDYeJqk0UIdryQJjUL8udRkdxUFpOdM62JB++G+J9OItZ3Gv0/lljVPGFUoT+G9VQYn0ikIm6YVzqliv+m/FugFGrCLQotinfuG4yshYPufeChBUx9Zy7zJP2Ay+Bdeo7oiOXMI7yx43OeUdPOzT1SCudzy1TocNECLcQ11i5MHjLPzA+YeUvPpcyCiPv1koQhMhMfbmxHlebTTSAMNlNres/xLlfz4JwM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNuahRkyku4wOSuP0kH987muvBcuhMG7AY7NoF+zC+g=;
 b=JMLNk3Lzwm+GJADHF9wQN5TlPT8zqDSGIBwJt5SaLKQTWi6t0X2FwglseFdpZi67xAqwybFgETqcSf/IYg3k65cDUlhnX8HUXv6Hcjm7f8shJevo5T16s5FW2SHLTYwtk7by0dcxFGHHThdViy84boTVwuBtPYS4VNGL6lvrqrv+TyiCYaRmnvAQr8INxFC/KLg+HYjb6wFcz87YsDIVk9iSwLzotgeRygdrBS/oYbEPGEfJ4X+9oTK6r50tpFR94FRv1vORU39bX/mkmHMvycjGuu7W7swPfyuSIctgC6iSqjEAFVsDr4H63tSfk/8+Y5Ba59VM89P8PXWN4EHmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNuahRkyku4wOSuP0kH987muvBcuhMG7AY7NoF+zC+g=;
 b=kB9/XfEyl/5g72G5Gr7OA9p5AL5DbJdbrG8AqHd9VTXm6LvX/y7qXfesNWs7tUIoRhgPM8O/cb1LmtfcJ70zfrzzHd4A/oJQZNbMN9fjIb62Nxo7e+97hkqHNnGie0huxiHYzf5P9STBlSKEyPlreeNnEDdBGnS8NBbo8cb981M=
Received: from SN6PR04CA0077.namprd04.prod.outlook.com (2603:10b6:805:f2::18)
 by BYAPR02MB5591.namprd02.prod.outlook.com (2603:10b6:a03:a6::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Mon, 4 May
 2020 14:14:18 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:f2:cafe::31) by SN6PR04CA0077.outlook.office365.com
 (2603:10b6:805:f2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Mon, 4 May 2020 14:14:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 14:14:18
 +0000
Received: from [149.199.38.66] (port=43073 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrI-0000Gz-6r; Mon, 04 May 2020 07:14:12 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrN-0000wt-Rr; Mon, 04 May 2020 07:14:17 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jVbrN-0000wk-0A; Mon, 04 May 2020 07:14:17 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id B15E913C2E73; Mon,  4 May 2020 19:36:35 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 08/10] net: cadence_gem: Update the reset value for
 interrupt mask register
Date: Mon,  4 May 2020 19:36:06 +0530
Message-Id: <1588601168-27576-9-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(46966005)(42186006)(70206006)(4326008)(47076004)(6266002)(8936002)(336012)(2616005)(426003)(8676002)(110136005)(26005)(82310400002)(356005)(498600001)(186003)(2906002)(36756003)(4744005)(5660300002)(81166007)(6666004)(70586007);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 519e84e6-8e2a-4fad-fcd7-08d7f0356efc
X-MS-TrafficTypeDiagnostic: BYAPR02MB5591:
X-Microsoft-Antispam-PRVS: <BYAPR02MB559194834AB2C0AB673F0FD3CAA60@BYAPR02MB5591.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQV2Uj9Jdsb5RPXKHvZZcZNh4mT2TZQMJwGU/k0hNImqnCoKzwzQY+Iz0Sq6eYBVhDArWn3SRFegXiBsrO/v2ZvTGKvNIU11cMdw5Dyr+QLFEjg8UY7CvTGng7wSanQzXYwy61q8lcCEjt5O8iuKLF6U6GxgeXrQMSKBgFftIRBsaz5Ro72EoR4mbiUIrLO2UgA2SXmZHsZxqXvu8OvKpnSnMxcUlObGqIbsLOFewTI5NQXt92/y2Q2xH65AYYX1q9hkpUVclavgyBZqpkcY2WH0EsX2gxqte5wHZ9A0YZUf0vreHQahsJp3yD4PatLNmcMdRs2n37sa6Nt0kJKx41kAmzbkQ5DEobxvWVkatAJBlxM+4riPZfZ2e9lB3UITPyyna0V+EFN0O0U9gUQd4FNa6q3WKpilAYXi+qksecwGWBAtJE0yBhJ5aTDZmiPlUWxleAdoVqwV2usVhDYQLeC76W71CHPjOE7/tDv6UwsTMLS3cB0B+TGdE95cvw4FY/9HiBqD47g71fTnOAtwBw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 14:14:18.2091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519e84e6-8e2a-4fad-fcd7-08d7f0356efc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5591
Received-SPF: pass client-ip=40.107.236.67; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:14:20
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mask all interrupt on reset.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 9eb72a2..ac3a553 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1348,6 +1348,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_DESCONF2] = 0x2ab12800;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
+    s->regs[GEM_INT_Q1_MASK] = 0x00000CE6;
 
     if (s->num_priority_queues > 1) {
         queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
-- 
2.7.4


