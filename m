Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86192C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 00:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9BE20771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 00:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UfotkwUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9BE20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k61Ax-0003uH-GR
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 20:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1k619e-0002R1-R0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 20:31:39 -0400
Received: from mail-bn8nam08on2077.outbound.protection.outlook.com
 ([40.107.100.77]:4416 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1k619b-0000bY-0U
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 20:31:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyShPgLLUIEoeiI+dj5RtsaJgfKj0EjGh/xKHHCqV8rzNCDZZaHOnI5VH518Zzzcm68Hczxv484/wiSEEEyv41OP8ZeqRwXBNDt9WbzJHgNw/CAOA1zw5pAuWHTLs0C8fd0RGo1vEvVKbrlMliIBKvHIwtP9C/jahylBXdERXzN4x8EVtO2omyXtzsdrlGWbPT7LbCsxlWRKDw6VgE5JI9OM8HhbVpYILspJ4vEgXC8lVpIxXAiFSRsA9VHXnEE3aR9LZdo33XHNFwGACfNlten9g2Ln7Lv7cUCFXozGtOJNGjhRboFq3OSHOTA4iBY5htZUQMmli7KoUBABW39e7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg+VtIAic2RCbeXl4dagvpFW0us4uFp3G96+zLHZX4E=;
 b=R2fqgfZY9o/mopZUKNhRe5BF/uL2PzRm6gSoD3qR5gLiteqRHDBxuHjh97Gox0Nn11Kq+sLZKwgY8kNYqvL7gwHdTOUNp3pdK9nsEkEB+oPHbCaSrDYiRVyDCXFOgrbEx5bjahXq0ewErCGYEKPFoH9qPMFne5KDHSEvq8JVsfWazBzmea07WjRil/TDS0/nezNyXFFoGJK9Y5MN3fZjWFt+9kLn7Kx5fTcbWLXqZU0i0VDLrnNvF7E67yN70uQC2BTNXEEohNSx+SwV6Xek2j58Cangq3CJvCA+2pLuMZliUPP1urlpmH0SIBuxL3WJlQnTislLuFCaf9qoLr1nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg+VtIAic2RCbeXl4dagvpFW0us4uFp3G96+zLHZX4E=;
 b=UfotkwUjsb0t1B3gEFKXmZA1lvnq3atfUgUso9Fe/12f2Jjniog7eZHgFYeAdyk6S3deXh0XU+CfCIqXMhQqB6EyQz4SL3brgAQ2UMPJtjp/bZfPFR90Je7R3+pmkvblF2TjvRr4m2uGU4wdO3oxubk0V2ihzLDZg3B+y21kokg=
Received: from DM5PR12CA0015.namprd12.prod.outlook.com (2603:10b6:4:1::25) by
 SN1PR02MB3693.namprd02.prod.outlook.com (2603:10b6:802:24::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Thu, 13 Aug 2020 00:31:28 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::2d) by DM5PR12CA0015.outlook.office365.com
 (2603:10b6:4:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Thu, 13 Aug 2020 00:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server id 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 00:31:27
 +0000
Received: from [149.199.38.66] (port=57224 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1k619J-0006yi-Ki
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 17:31:17 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1k619S-00080l-T0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 17:31:26 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07D0VL6Z029552; 
 Wed, 12 Aug 2020 17:31:21 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1k619N-0007xR-5j; Wed, 12 Aug 2020 17:31:21 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 4/4] MAINTAINERS: Add maintainer entry for Xilinx ZynqMP
 CAN controller
Date: Wed, 12 Aug 2020 17:31:08 -0700
Message-Id: <1597278668-339715-5-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597278668-339715-1-git-send-email-fnu.vikram@xilinx.com>
References: <1597278668-339715-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b862c128-c929-4723-b50c-08d83f20373a
X-MS-TrafficTypeDiagnostic: SN1PR02MB3693:
X-Microsoft-Antispam-PRVS: <SN1PR02MB36937A2B82BA3B1C4565B9A9BC430@SN1PR02MB3693.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(136003)(396003)(39860400002)(346002)(376002)(46966005)(7696005)(26005)(316002)(4326008)(70586007)(336012)(107886003)(356005)(8936002)(47076004)(82740400003)(5660300002)(81166007)(186003)(4744005)(70206006)(82310400002)(478600001)(8676002)(2616005)(36756003)(6666004)(2906002)(6916009)(9786002)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 00:31:27.1002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b862c128-c929-4723-b50c-08d83f20373a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3693
Received-SPF: pass client-ip=40.107.100.77; envelope-from=fnuv@xilinx.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 20:31:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 0886eb3..14d9b73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1536,6 +1536,14 @@ F: hw/net/opencores_eth.c
 
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


