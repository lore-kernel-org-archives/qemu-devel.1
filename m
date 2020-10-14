Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFABDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 06:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AC42177B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 06:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ip5/0sBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AC42177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSZsu-0004JO-89
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 02:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZrC-00037A-W1
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 02:01:51 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com
 ([40.107.93.43]:61696 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZr9-0007eo-Bg
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 02:01:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHlZnRiz2mxZbo4uwTdoleL1bwQdUBlJ0HEDqdwxsIUukhneYEc4b9lkX0+dE4LhSTVYZhdNSBkWlGG0H0o3xvC0HZEYJflQPvfFGeU2/epaHWjEgK7oeywMtNUzdwIvSdwfOc3d3CoYBqTdabVvDhVcMaIUFHcTrEhOzap53ADq6vovOp4IILEbbXdJEJ0Jjx1IecnFFg+HfHpGiFVRm8t1FvjYVe9skosRtW6GXHpgaqG33mcIuQG2pUvFQY5SwpEcgLqe/yEJyYZSgRZNIEMuC6Y6t2haUOd6aj/eKkulVoadEC5ow89vZ5cuzowCQWxhnB8oTQd7TrVFk4rp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFebQn3EFBQdTQJm7xLpLU46YHuDLmCHz4+KPg1F/iA=;
 b=bcOS4iWF8HQJ7XEoB8RIx0g+OnarsjFrnwwl4Fbw2HkpBFrq1veHiu2+FkqMBcJo/IdIng9GKXlfBcXwWvhaSmqYzCpD4iAa/pNnV/EX6m9sNPAWabsqEkm/p6YIlbojy3Yo6nZGG1b1PtYJCcF1mQkt8ifMNpeMIGZ20NbJGbNEhXyAO+y+nFvzchZ//gUgER5IwEhCTCDyvgtmWsXiYFeVK0+MdiI8RKo33cvXGCfcREq0SK96Da/RMecRgH1RxE8vPjLjXOS4vGD9LkgafG6zLGUkf9rgsHCsrim3ig8MsY1roUeqlcNQ5nhl164sFx6z2ySthKWnsdl8UxALSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFebQn3EFBQdTQJm7xLpLU46YHuDLmCHz4+KPg1F/iA=;
 b=ip5/0sBalpLFHvO/MpTP2ZjNJZD6Df2/mllrh79f90KMO3qushbPIQHlBld4dUNmdfdz9h9T9yA4Ob6slYvgE3a94/sEyhM2FVj4cEE5K+thuqzUo5aPsmQmVffhXSoBQRJJwvNXiuu9yx8qEBBbts6315Edvq3V6xbznPqqVhE=
Received: from BL1PR13CA0107.namprd13.prod.outlook.com (2603:10b6:208:2b9::22)
 by DM6PR02MB5003.namprd02.prod.outlook.com (2603:10b6:5:4d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 14 Oct
 2020 05:46:41 +0000
Received: from BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2b9:cafe::8a) by BL1PR13CA0107.outlook.office365.com
 (2603:10b6:208:2b9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Wed, 14 Oct 2020 05:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT049.mail.protection.outlook.com (10.152.77.118) with Microsoft SMTP
 Server id 15.20.3455.25 via Frontend Transport; Wed, 14 Oct 2020 05:46:41
 +0000
Received: from [149.199.38.66] (port=54691 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZbn-0001aX-2T
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:45:55 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZcX-0001oH-34
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:46:41 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 09E5kbhl003877; 
 Tue, 13 Oct 2020 22:46:37 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kSZcT-0001nf-9W; Tue, 13 Oct 2020 22:46:37 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 4/4] MAINTAINERS: Add maintainer entry for Xilinx ZynqMP
 CAN controller
Date: Tue, 13 Oct 2020 22:46:37 -0700
Message-Id: <1602654397-35162-5-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602654397-35162-1-git-send-email-fnu.vikram@xilinx.com>
References: <1602654397-35162-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dd0f63ad-b7d7-4482-3303-08d8700486ab
X-MS-TrafficTypeDiagnostic: DM6PR02MB5003:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5003AAC183CA8EE46A044578BC050@DM6PR02MB5003.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ebj4vJXoRMSzPVthet0LJOvSFkbm1rAbiV5iMi6vw1gW23qBgJHd0z4NKh6rGeQvSZyOpB7FSd/oHlcEqn0ugbkthgC3L6yy4xVwgFx0CcIA1HBSVKlsU27QpU1Mq0NLUE89fx5Jtafa9lNYxhBYxr+xSylqwPUcyTFVi70EhYURlrNQg/FFQkdBgBo4ZlNYoegANTNuPKE2mPLCsOdEeJ9jK4mxEDL69XiHjqC7SKkrkrj21HMDvhUF0pOu+kUpxbjFNpU7XsPt3GHd3iLr+MC/TCMOdtfvuHXYoDe4FrlHDbk2L5d1LcfJILrvrD5XyukhSjaddumHvVoR5zRspT3ucwXZLSsz8RcN0hW7CbMi9wpgI32nsd2a+xgrolLS0GUpe63VOEHU6JTAYoJtAA==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(136003)(346002)(376002)(39860400002)(46966005)(356005)(316002)(47076004)(6916009)(8936002)(82740400003)(5660300002)(336012)(9786002)(426003)(107886003)(478600001)(81166007)(2906002)(4744005)(7696005)(186003)(2616005)(36756003)(70206006)(70586007)(82310400003)(26005)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 05:46:41.4451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0f63ad-b7d7-4482-3303-08d8700486ab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5003
Received-SPF: pass client-ip=40.107.93.43; envelope-from=fnuv@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 02:01:46
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
Cc: figlesia@xilinx.com
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


