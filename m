Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2C8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649FC2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TASX5l5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649FC2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXhD-0005OF-MO
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1joXdy-0001mD-Nc
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 15:34:44 -0400
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com
 ([40.107.93.83]:27382 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1joXdu-0001ro-F6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 15:34:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7EH3NU4J4XY0DR1ZCZo5w/ns+RyFGgK2+wOG3dO74r0+gvykIrZHpumKbV1SP+1NH0HF1FE00FqPcbHggnIHDBvGQ+QlmySE5tjzUC5wPXJfik+aE16FVIZeUH/mNLggljNakcSau+asxLR+7gfpej0zo5SXKRbdBLYevx9TDm1k1+EWcO0VpZ4qammemikSPWq6XOORXThMQWNxHGydzRAodDNxhDv/bIl1U7aT8Kxm0/rQVWd6L/bMry8ITRlNjD2JlwE4klWN3XQp7nZWA7N+GcbMh/ulCihOilwfwQqLh2+/Ma5zFZfCs3vHxPv0VWxN5TiQjJdOXY3/t6iLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YTd7VQ1lkDciKQEWhPCjmzjd1i7+Sh4PFpUjwuLTIo=;
 b=gTsreSmm6AG7WGhVIDA1GXZJuGuuDAjSixf3RNFPo/WA9cJvhQ+PS7w/KsdNQckhoz9n1KQ0UzC0JWjurZ8pIfuNFoz5qbI7Abe1IG1MstN1lZbjPInjpu+TCAz3b8Veo0dlQsQn4WZc6aqKqV5/vkIaOVjQ39YmOOCuYE2lIvyyF9ycA57szm+jRvJmzbRPfjF02DzBIunBItckZ5ubOfyz9OTyEvkfDo6pZ8l7iB5vL8MTde4hTuRan5MYpO+53iYkbU9s7ugKN2NT0Hqut9YrZiOLyM7pA3XnyrnLLoU5XVOs6R4egSnIe7JLa8kW0UFxyRxNscRqEDI6mbVeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YTd7VQ1lkDciKQEWhPCjmzjd1i7+Sh4PFpUjwuLTIo=;
 b=TASX5l5JFyCmp45YJuBrVMfDU3VsX3gpWWkPr/5MIK2FXm1tqRGcHk759w0KYIi3UkaDU8hiQG/lnXb0Gc6np95SO2FXd0DKa2152wBQ6rlxw+Dhnlt64P0sr5Ap04FVMMCqdrEOFvOrjf3Q7KlPdAL6K10+ho5lHe7JhDdwS/0=
Received: from CY1PR03CA0023.namprd03.prod.outlook.com (2603:10b6:600::33) by
 CH2PR02MB6539.namprd02.prod.outlook.com (2603:10b6:610:6d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Thu, 25 Jun 2020 19:34:35 +0000
Received: from CY1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:600:0:cafe::18) by CY1PR03CA0023.outlook.office365.com
 (2603:10b6:600::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Thu, 25 Jun 2020 19:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT049.mail.protection.outlook.com (10.152.75.83) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 19:34:34
 +0000
Received: from [149.199.38.66] (port=51335 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1joXcc-00081X-Ff
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:33:18 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1joXdq-000359-4A
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:34:34 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05PJYR96012277; 
 Thu, 25 Jun 2020 12:34:27 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1joXdj-0002vc-1C; Thu, 25 Jun 2020 12:34:27 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 4/4] MAINTAINERS: Add maintainer entry for Xilinx ZynqMP
 CAN controller
Date: Thu, 25 Jun 2020 12:33:27 -0700
Message-Id: <1593113607-321118-5-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593113607-321118-1-git-send-email-fnu.vikram@xilinx.com>
References: <1593113607-321118-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(136003)(39860400002)(346002)(46966005)(2616005)(316002)(82740400003)(426003)(47076004)(336012)(70206006)(6916009)(5660300002)(8676002)(8936002)(9786002)(4744005)(4326008)(26005)(82310400002)(107886003)(356005)(478600001)(70586007)(81166007)(36756003)(7696005)(2906002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c6771a00-aaad-420e-578b-08d8193eca2e
X-MS-TrafficTypeDiagnostic: CH2PR02MB6539:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6539328F70FC85EBBCFD1DEFBC920@CH2PR02MB6539.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oq+roBzJogur7+VNlT6m+3YWKULKNYVakEVRFYod3YlgtBLn99YeJJcKEEniu+pSv+1EKs1BWfeNnDMqe1AMUZSMyGffPraZH0T5YYfQow7CWulGda1D4Q/AAN9l0Pa5Cef9Z3nj0Y0HVoKRbxYGpD6X2m3O/XGYz8nEGizFrRLdFB7ZCFj6iQR4l1B06tjm/irjqejrx7hUWYsH2ggBYnMfiMdAeiFZLSLd9O960rH2lPk48l9zulx+F01lcR7oHo05bCGmq8N814CUxvrESSFJdI1UVGADto1jeLpdH6odO6Vi4WR5x2YJgDYZtFi30+NtlZzTUaW4DO4fH5Juw5VsZQKXsTFpq7BFQP34mxmUkOuWWCfqPyY+DaUiCnyuCmAtz7tXmqoxO6SFihdzoQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 19:34:34.3606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6771a00-aaad-420e-578b-08d8193eca2e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6539
Received-SPF: pass client-ip=40.107.93.83; envelope-from=fnuv@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 15:34:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: francisco.iglesias@xilinx.com, Vikram Garhwal <fnu.vikram@xilinx.com>
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
index 63b3bb3..6f73a60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1466,6 +1466,14 @@ F: hw/net/opencores_eth.c
 
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


