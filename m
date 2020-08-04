Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD6FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 21:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4119C2075A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 21:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="b5p5lx9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4119C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k34FZ-0007a7-7w
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 17:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1k34EM-00067G-79
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 17:12:18 -0400
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com
 ([40.107.237.87]:9312 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1k34EH-0002Og-QQ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 17:12:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4cxmBgKu3E5WZ4soW8IO9CVhHd61t3g2JdEswr2IwSIeQ/p7ZmH9hwK3i8wLuJjV6Bo6bzHIF7jPqS6cnOmOM61EYBpcJFEpDjhKtDX18MWdemA2P8yaTsiL+ePKUd+RkLNsAhaRRc54MewNE7mM0wS1ocyTU2Q9dtCZmf5FoBeNd+364XnPGZxMFbmBCvaFL1t2cXSGBTNMb4mJJDWdag31gSoGNfNwhqYTIaTo+JJh4cIaplCp+22UQKVDOLZzrGOKw7PYSE7i7ZXNQqzKrA8bN2eYu8PPzLHsxK7+413Sd8Q5hWH7qmuGfBHf0kOwG8At3nGyDeyq6aZCLGArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg+VtIAic2RCbeXl4dagvpFW0us4uFp3G96+zLHZX4E=;
 b=CipvfU0FZjVOIhqV8oEXcqch6Xs4wHaXCMEQRAB7RNmxfJhUHLNPrPnazempXO6IiQzlY1+7IzO8nHosn7EBE1b4F3IUx+usD2YwoJJeOiOPx6EGHauXJnsSZ1K1oPESpaNqpzasdeKmyocIy5WUuOFiqOU9yluB0UCSeizuolUpTKcwpM8tCxPE2maGzTV3hyzCEKFIv5kFvFFy1nist5Lx0UiVG3G57ga+xU8qAlDwcSQwllo7GsorkTjeto691fsfETlDZInTKXrhUGRMi94tmi/DLpVllr4ufyMB8GkjjHO3qC+GAc40gsvKJq8Ttzp/dZWoMr8l7bfIkAiIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg+VtIAic2RCbeXl4dagvpFW0us4uFp3G96+zLHZX4E=;
 b=b5p5lx9d39v3qijEzstzStji8KBg5rsvkFMJx3wx85HahB3GkMJb1CgSC+gFZeC/j5M4lUK+gF+bcjxKCPwTXGglQFSAbz/XDmAeQi/5HsdsKxIku6wC/+IhAUMAYf4J3ncN5SonpEr7RAI/qmPNDFVuAhvq+eBCLVqCrNsifzg=
Received: from MN2PR01CA0009.prod.exchangelabs.com (2603:10b6:208:10c::22) by
 CH2PR02MB7095.namprd02.prod.outlook.com (2603:10b6:610:8b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.18; Tue, 4 Aug 2020 21:12:11 +0000
Received: from BL2NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:10c:cafe::4f) by MN2PR01CA0009.outlook.office365.com
 (2603:10b6:208:10c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Tue, 4 Aug 2020 21:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT037.mail.protection.outlook.com (10.152.77.11) with Microsoft SMTP
 Server id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 21:12:11
 +0000
Received: from [149.199.38.66] (port=46997 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1k34EA-0007xr-Rw
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:12:06 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1k34EF-0008Qe-2d
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:12:11 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1k34EC-0008KU-MA; Tue, 04 Aug 2020 14:12:08 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 4/4] MAINTAINERS: Add maintainer entry for Xilinx ZynqMP
 CAN controller
Date: Tue,  4 Aug 2020 14:11:45 -0700
Message-Id: <1596575505-163040-5-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596575505-163040-1-git-send-email-fnu.vikram@xilinx.com>
References: <1596575505-163040-1-git-send-email-fnu.vikram@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 32d51872-b4f7-4363-e879-08d838bb0dc7
X-MS-TrafficTypeDiagnostic: CH2PR02MB7095:
X-Microsoft-Antispam-PRVS: <CH2PR02MB70955FF2E00D60F89FC29F5ABC4A0@CH2PR02MB7095.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXkVE3IQhsjH2NX3irdHXbf50+PLKYleXZNuiP4lEcDOSTRlBCbjMZoWztrpnidTtoEWh6UCPvwBS5jdWCYGYjYS1tFKMNVSqxaWYRV6XsI8DXMdDae7ZScoDXXOFNkbdDH2NVQV6CMMJTRsipR+VhWZ6GwoBdOPz8p5siMiKJc5ucIZTvSELf6cxJU+XFXa4h9qGqT4MlAYDn8NEHEoiX2C7kr3zpxBQ+qe/LvNVh7ApL5Mt/K5gbS0XJMNINqvHVHijjFPG7faXFFY/JeVZHRqdoP0OdFYmJvSytjLRbzSMZyIdDGFJBKR8zQBzxAxUKrvIouRYNJEobhFhgbusgbAj1UoPSKx/rt/IDISsvWjvrszUJjVZVjT9mm7re/c5uqjJ+wxvOix8Bw3kBvofQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(376002)(346002)(39830400003)(46966005)(186003)(7696005)(426003)(478600001)(5660300002)(4744005)(2906002)(336012)(26005)(2616005)(9786002)(107886003)(6916009)(70206006)(316002)(81166007)(36756003)(4326008)(82310400002)(8936002)(70586007)(8676002)(356005)(6666004)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 21:12:11.4149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d51872-b4f7-4363-e879-08d838bb0dc7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7095
Received-SPF: pass client-ip=40.107.237.87; envelope-from=fnuv@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 17:12:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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


