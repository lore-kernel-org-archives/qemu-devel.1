Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D4FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D9F21582
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DpKpMaK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D9F21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSZkU-0005MG-Od
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 01:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZjG-0004E7-64
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 01:53:38 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com
 ([40.107.223.75]:21792 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZjE-00050E-DD
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 01:53:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGaLkAQJku0NyqdzoSm+qnH3BgPTyk6pFIl59AKYAI+/BdDtvrAAyKW+Lc788e53LqqcL21uWYPqTOOIXGMv8RlRj4ror/KSPmzgoNwPb07JpCXLJrnbXSO5vNsGRBVaj7vJ+EQ1HNK2xZnFZcQLMpUUQ4XY17T69HIDPcNtM2TKdajNGgU15UAUBBFtT8sZW+Gir5TedQUcU2ESjSeoCAZyCDDdn4HBvr+rO588Gfi5rdNXVHaMGGz59G37jhusSCt3Cr02oX8NJeKfHjPMFIgNjCACm1yYR/dC6ayMR+3fj+7TbdtcACD1PPFKsYkGr8UV82cBo1YyoHDpLT6hHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFebQn3EFBQdTQJm7xLpLU46YHuDLmCHz4+KPg1F/iA=;
 b=D7r5ffqNpNnSvCAHGgf8PkxLj77bzK2JZipIStbXGaSD+ms0f6xtIP/g8+INe36/lvOuzq397fG2XUYEOaQOltYPMM9omrFkao2JBRvFnNxI9X2IwxKuvF9cMRJvm5Q6g82dYynq4oQESmhOHXvpcgLBby7a0oHUkVssVgQx2NE9ghHmDHuz10Hk2Xgve+zIbvk8mJoiJ9TGuRp00DConZDyJ//EpbCWwEsQx0+BD62V09n3SkURQm7YUhKjXcddKOPAGO3fceydPSm57tx2b+xO9o3cLVuoVi0cL/CNVAVAhQlJ79eFd96JXFCI1SxIXZwx481uscLQ4uCHKV9sqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFebQn3EFBQdTQJm7xLpLU46YHuDLmCHz4+KPg1F/iA=;
 b=DpKpMaK1YZxiwKtDPGRE3soK+tGCDYkjs7nklvunTh4DX328ViX/rdpdtZ2ah0zTnZ7B0pAO18xlL2Nwgv/iPe3tuaNiosVs9r2aJxkAW106Oq3hcCspOoKeALrVpNerHgsvk1AzDy5YaEDiecdOfggENmqZTIV/y5MUjwIoH0U=
Received: from MN2PR14CA0030.namprd14.prod.outlook.com (2603:10b6:208:23e::35)
 by CH2PR02MB6492.namprd02.prod.outlook.com (2603:10b6:610:67::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 14 Oct
 2020 05:53:34 +0000
Received: from BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23e:cafe::8a) by MN2PR14CA0030.outlook.office365.com
 (2603:10b6:208:23e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Wed, 14 Oct 2020 05:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT044.mail.protection.outlook.com (10.152.77.35) with Microsoft SMTP
 Server id 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 05:53:34
 +0000
Received: from [149.199.38.66] (port=35597 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZiR-0001h9-PI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:52:47 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZjB-0003fd-QE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:53:33 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kSZj9-0003e5-EK; Tue, 13 Oct 2020 22:53:31 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH resend v11 4/4] MAINTAINERS: Add maintainer entry for Xilinx
 ZynqMP CAN controller
Date: Tue, 13 Oct 2020 22:53:06 -0700
Message-Id: <1602654786-35589-5-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602654786-35589-1-git-send-email-fnu.vikram@xilinx.com>
References: <1602654786-35589-1-git-send-email-fnu.vikram@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d2529313-dc1b-4832-db1c-08d870057ca2
X-MS-TrafficTypeDiagnostic: CH2PR02MB6492:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6492595F84E7EC3F87A11BB3BC050@CH2PR02MB6492.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rjw3ZOaB8aufLPhlfoO133De7gxxNPp/+TsXeJVRzMVp+pHIafLh7aKHfh+nU6ERGbhuT4ltTtbWAnAOu6JTlFUJe96RKYhTOFNugvQOTzHXlsJYIqTwmzSPm0YHJ6o+Q+v2q90rL+IiPqP3HBjbRhn5PB6FUwxSNxwJLlokYj2Sw74Y9y/41eebnWy0ugiNA1JOcWG5w4jVNyNzyiRe0DmQPTb29vDuU2meAhpz/G0rTxCh+BFkIvEXk9D7WBanJh4fWnTsySpAf9In9sNWG2fNbU/lpAKCUTJwYl2FLlKusIvvGBU6QC5K7gKz5D9CiX0ZpModO4tCN/V8KfOUbPkgculw4iJAXPmyieaRNZzfxqS+zuSxr0TPkLmqMjLV8j4WSi+Cw9bO1c1ieoffFA==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(39850400004)(346002)(376002)(396003)(136003)(46966005)(70206006)(426003)(186003)(9786002)(316002)(2616005)(8936002)(6916009)(82740400003)(6666004)(8676002)(36756003)(336012)(7696005)(47076004)(5660300002)(4326008)(26005)(107886003)(70586007)(356005)(81166007)(478600001)(2906002)(4744005)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 05:53:34.1100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2529313-dc1b-4832-db1c-08d870057ca2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6492
Received-SPF: pass client-ip=40.107.223.75; envelope-from=fnuv@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:53:35
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
Cc: figlesia@xilinx.com, Vikram Garhwal <fnu.vikram@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47dd38a..a8c672c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1559,6 +1559,14 @@ F: hw/net/opencores_eth.c
 
 Devices
 -------
+Xilinx CAN
+M: Vikram Garhwal <fnu.vikram@xilinx.com>
+M: Francisco Iglesias <francisco.iglesias@xilinx.com>
+S: Maintained
+F: hw/net/can/xlnx-*
+F: include/hw/net/xlnx-*
+F: tests/qtest/xlnx-can-test*
+
 EDU
 M: Jiri Slaby <jslaby@suse.cz>
 S: Maintained
-- 
2.7.4


