Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6EDC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3E7206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WC677Iae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3E7206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIbY6-00066O-6u
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 13:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIbX9-0005ak-8O; Wed, 16 Sep 2020 13:47:55 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com
 ([40.107.223.50]:23585 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIbX7-000429-OY; Wed, 16 Sep 2020 13:47:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awZnyl4Uk1y+9YSo+xERhKinw4tKTox2WWZJ5YESv4aETMWOuaU2RVlS5kQ6o4nGF1bGtZgK4X4HylYnkGbxq4ifyYsXThe/mjVL3qPt/3kF3MSoHGq/e0HiWMjMfYIiNeG1CHHtqWB2vtDxBNub6xFnbLNLIqyp9hdiiSlAfSG1ev4U+3kcgEGIqsWbZKMYgKs6Qb+HsZ3oC85hWnxJiYbkmd94KwoyThjElVErpmdGbTpJ7wKBaptcqvfdXyAk6X7SQqjXwJ/n7I87drZ+GAU3nz0GZFJogklGr4XfXY/7o3fSuk1MBb45g4xgEHEbnnvEqb3Z+UlZ5DV2YwAMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdde6W662NsqFmsyeC9T8SOBE7Fc2a6PxPPf2BVOPNI=;
 b=oE187QBTyiBuS+atnO087pDfGJ94o7Q/Di4ByoxnPlIBLgKBXu3eONLGxeGGv0QZEcG4vQJuvclHK+objGd4JD7/0DPi/EA/D026ZA49bPrAlLef0zL7llrflcbe6Qp534V8ZgaA7vFklW99R4Fr8OPORTxJz13JaHqf8vWXNLqDl0Brue4N18kiwY3FB8mzieAJ3rZYsS5ngtNWo1QKVB8d86cd3sa32cUR32zoOSul7+ZrlNZfvCC0Wthsn52Bc6H5RIawb///IwxFFroMGk9+XCLSYus+sezsUx6ccCKnrhP9yFSvH055wLc/CVHuFWd2ND+GdfwDQgt09FLD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdde6W662NsqFmsyeC9T8SOBE7Fc2a6PxPPf2BVOPNI=;
 b=WC677Iae234c2OSmbzCnXmHM0e4MUW7dK7gh0gw/ApaziWI00q0PfybN/I1wjOWZOdSCuELAKl7MYeDjliTL9vwYm3Tx2Fh6JVHxk18bmjjtChs3A1JceiW3oU4N63KG7vkcW0/8FDUjc3U6Myxw29VGKyLkg8S3Jp/17Wpem8M=
Received: from DM5PR06CA0052.namprd06.prod.outlook.com (2603:10b6:3:37::14) by
 CY4PR02MB2261.namprd02.prod.outlook.com (2603:10b6:903:14::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 17:47:50 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::2f) by DM5PR06CA0052.outlook.office365.com
 (2603:10b6:3:37::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Wed, 16 Sep 2020 17:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 17:47:49
 +0000
Received: from [149.199.38.66] (port=45280 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kIbWw-0007Qa-EB; Wed, 16 Sep 2020 10:47:42 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kIbX3-00078F-Fz; Wed, 16 Sep 2020 10:47:49 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08GHlm9r004038; 
 Wed, 16 Sep 2020 10:47:48 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kIbX2-000788-6M; Wed, 16 Sep 2020 10:47:48 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id E0BDF13C029D; Wed, 16 Sep 2020 23:21:30 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2] sd: Exhibit support for CMD23
Date: Wed, 16 Sep 2020 23:21:29 +0530
Message-Id: <1600278689-32187-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 55972a62-9985-497e-ab6f-08d85a68a109
X-MS-TrafficTypeDiagnostic: CY4PR02MB2261:
X-Microsoft-Antispam-PRVS: <CY4PR02MB226140AAC16ABCD22CE416CCCA210@CY4PR02MB2261.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JO2oOVma5zaL8W47G3Qb2XL1QbKnWMJS6KyeLFV4OzNtdMpNXbR8LMguM8V/K/h6Pflvp9JTe66eVvQOG5NZFEQ+8a1dCHLMwJR8EPNPsWvUOEgSWyb2rMmJqSbbQQoaY/mVPFRZ24sqpstiXTqaZ/3Dl1TZNYCu7gaCvernm5i/kXu/H45/lsImxWaCuYBIV3JauzwomJxKMN8AuYd/XArAoHfL9MUDVc7ghlvY079sXT8iCphw6AzJm4BICU2B9g7UYLeIYNcmAaw57U9qJh/UR7czm489OSt71plAB5e/QQe1khyx4IAwvkbjY+PRIYSO3mSOSgbSEcq40/iCbb2OyqbY+ESKWgj+NOcGZC4k99OR6KGFWhE6gnXp6pdgVHjkEBkofSeqpG3dHL3zF+QqSG8Gtreq8SGfoQfesC6P9gruNbjaSSuHfaqHC7+e
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(39850400004)(396003)(136003)(346002)(376002)(46966005)(81166007)(316002)(82740400003)(356005)(83380400001)(42186006)(8676002)(186003)(8936002)(2906002)(4744005)(36756003)(5660300002)(47076004)(70586007)(70206006)(6266002)(110136005)(26005)(426003)(4326008)(107886003)(336012)(478600001)(2616005)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 17:47:49.7689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55972a62-9985-497e-ab6f-08d85a68a109
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2261
Received-SPF: pass client-ip=40.107.223.50; envelope-from=saipava@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 13:47:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) AC_FROM_MANY_DOTS=1.303, BAYES_00=-1.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: sai.pavan.boddu@xilinx.com, Rahul Thati <rthati@xilinx.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update 'SCR.CMD_SUPPORT' register with support of CMD23.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reported-by: Rahul Thati <rthati@xilinx.com>
---
Changes for V2:
	Fix commit message

 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0012882..16d1b61 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -335,7 +335,7 @@ static void sd_set_scr(SDState *sd)
     if (sd->spec_version >= SD_PHY_SPECv3_01_VERS) {
         sd->scr[2] |= 1 << 7;   /* Spec Version 3.0X */
     }
-    sd->scr[3] = 0x00;
+    sd->scr[3] = 0x2;           /* CMD23 supported */
     /* reserved for manufacturer usage */
     sd->scr[4] = 0x00;
     sd->scr[5] = 0x00;
-- 
2.7.4


