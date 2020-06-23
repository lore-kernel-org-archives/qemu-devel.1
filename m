Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66316C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24108208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OvzoYRRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24108208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnsIM-0008Jw-DT
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 19:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jnsH8-0006gd-RH
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 19:24:22 -0400
Received: from mail-mw2nam10on2064.outbound.protection.outlook.com
 ([40.107.94.64]:36705 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jnsH6-0004bT-BW
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 19:24:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM9Eso/9zU6RbVvvwgVPNVTXZIhdOwxqO2FONdVV4fxCVoYlYGM10RMj5tv/quoftEwgv0VuNdp9hdoBhrgvEAxYSpKJEPjvTqGdQuLm21TMi5fhHk7qWDvBCPatTNs7RbUyyBiR+hd7Hm5onzwoeY2Mdg8yOoej9zDxLRB2QcHC4txC7Fs0rCCz+TlC6SZH7p1pEjoySwo3bcMwCSaIZH5ceBhopGG32WNtiHHD9MxeQznPh+C68BMwf6HL+hv2ISIHiSyY5DwBQfcQmTetRJuZENF3rvMRdoftWDGzPx2bwT16prGuTVJkGJP0WC/fT1DYvoxUlYxoUe+IffM/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YTd7VQ1lkDciKQEWhPCjmzjd1i7+Sh4PFpUjwuLTIo=;
 b=QyXy4LnN9mHngT1Rb+9wD89z6tGJu3BSDT1bzSMDFblX8nVJQ9fa0qKQJu0WwZzqWgwuqAoasEfk7pjFWjubQZTJrLJRD+hPlJwQwMEinorBRKkh3XnBpeAqplHYIYggjqARKxxrR1AcBow7IYYZwO3tQg0S+phD6Ki0meAjqkVrqBSh3YXx4h5q6hnHLVPiLP95G6Ye1wehq0aAJgTvvsyiOe941C29CKdSxtQLuWJMEkyAnh5cuYpECAvXE48tUZs+VOlZ5kG/kPz1blp6dpB67evqg++jqwp+uudaUw12x7a6l/vWXZ1ttI9XTrGIncnhYyF67VtMANcDwZUC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YTd7VQ1lkDciKQEWhPCjmzjd1i7+Sh4PFpUjwuLTIo=;
 b=OvzoYRRwY6AH54HDr65t7Po859dDJE5Zg/lQAOmYWOm7XFTmvo7KxwOy+2CHhjj1wNz//1BQQtdaGrRxo9NpYVGMROhj5MTq3ob1FuASYPwyUh+oXtqwMbXACt7LoC+sZd5okhGouNrVlbeOl18iM/Xp/OpwGzQaZTfbSrdFU5M=
Received: from SN4PR0201CA0039.namprd02.prod.outlook.com
 (2603:10b6:803:2e::25) by CH2PR02MB7063.namprd02.prod.outlook.com
 (2603:10b6:610:83::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 23:24:17 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2e:cafe::a4) by SN4PR0201CA0039.outlook.office365.com
 (2603:10b6:803:2e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Tue, 23 Jun 2020 23:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 23:24:17
 +0000
Received: from [149.199.38.66] (port=36400 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jnsFr-0000A2-Qs
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:23:03 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jnsH2-0008DN-U0
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:24:16 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05NNOB21019187; 
 Tue, 23 Jun 2020 16:24:11 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jnsGx-00084e-FQ; Tue, 23 Jun 2020 16:24:11 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 4/4] MAINTAINERS: Add maintainer entry for Xilinx ZynqMP
 CAN controller
Date: Tue, 23 Jun 2020 16:23:36 -0700
Message-Id: <1592954616-65393-5-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592954616-65393-1-git-send-email-fnu.vikram@xilinx.com>
References: <1592954616-65393-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(39850400004)(136003)(396003)(46966005)(8936002)(426003)(2616005)(336012)(47076004)(8676002)(7696005)(36756003)(356005)(107886003)(316002)(26005)(4326008)(9786002)(186003)(478600001)(81166007)(4744005)(5660300002)(6666004)(70206006)(82740400003)(70586007)(2906002)(82310400002)(6916009)(42866002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eccdf0e4-4a0e-43dd-c409-08d817cc8c91
X-MS-TrafficTypeDiagnostic: CH2PR02MB7063:
X-Microsoft-Antispam-PRVS: <CH2PR02MB7063AC632A4207DA72E83034BC940@CH2PR02MB7063.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EivG2LqPFeFyXSpo17WgLaH0Alh+d0V81xgqUx6HeKp69OcHaiwi+/swgu5+qBrMUxqzOGvFazzV/fbMoJ9Q0uvy6lxQXhOR8MAVrT+faUMe0gF4/nPJgunUxW1NZEbGcreY285gFGaWU+QR8J1s0k87zeYZhOO2gU0oPxwH/Gs8+BNaHClb0w5ZYq9fMyvLHyye5MK5N4Net4X8SB1HsrlOhUMJ0kA/dCJOv4J0be4RZclJ50R4x0qJSe4L8KBuba0nx+yekH6XHhBUsR850l64DD/sZLreq+wjCHjXCbfRlQQGoWxLJYe7SuYjDoVj6EmWI0q7phS8bj6yxGqWpbgM4UpOxA2mXkrEkbfPlkdxjOnQJ+vdd0WyBxebHAcmFY1rb/sHNSMxOCMFEb3ZmffymQP8jLVoXBw4EE1MjpM=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 23:24:17.2025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eccdf0e4-4a0e-43dd-c409-08d817cc8c91
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7063
Received-SPF: pass client-ip=40.107.94.64; envelope-from=fnuv@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 19:24:18
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


