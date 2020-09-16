Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A449C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6819F206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="E+NT/nhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6819F206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIbTe-0003oB-7f
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 13:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIbRs-0002qN-4T; Wed, 16 Sep 2020 13:42:28 -0400
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com
 ([40.107.94.80]:30848 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIbRp-0003Iy-OC; Wed, 16 Sep 2020 13:42:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehXhAAR/UcY8g0jLOHXcZ9hg1aZ3W2CMnNfH/0XXozhttWmUwCWyWl72NVSniL/QgnNcbvR+ogdPjuR/2PTM+PBXAOsOF72YndnPTIBOn1WhnGc+IjWQ4YX9s81Otd76EtV/Q8BAKdC06CqlicL5CVV+O3nq/ABlh6U27ZBt/DRG5mPbTwE2hjGXN35QnfegKjTW83wOzKci1fcFEpqPgrAf9LkDX0o+zMEwzKxgxA5+nDwxpVbXyYWwv+iDWxF0atg8tUJRlfFYFzsZe1Doe5wFHu2Mey8P4GTVCJgfCRBxMIZrIYsgSfBJWCWZUarOj2H4xT6Ivn2LJpvwOOZPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/Kgfv7q8VUkl38O/Zn1Zgk3eBbWRyzw9m3vYjAmzy0=;
 b=lqU6o7DSkxdL6BVwuBW6xba+lJsbxwsCovIvnd5B9nHfOjrdg+W/fhXfyZmeJhEDHBI7MovmtJr9sObsg7AAHrw+lmUEMKLZZ0jLVam224KQMxbGGyHsDfWxDxaHnPWgNVj2MpEniblPYoTNavEEVYModP0N4y36E9YaWfHPNwh1FQ4qeEwocQog4jsxpPJZ3QcN6quZljQQiGjw6mQJC22UAc40rI9EJmlxhVtAgYpuumU387bJ3nJoyzUtX/ssWbbN831FHibWQgVHHoJ5yA9AM8ZoPBCiQAxCdiLgUHuRSW1Gs5CBaW5nNNB517rGvfDOoUZHoVFHoB6eTSibPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/Kgfv7q8VUkl38O/Zn1Zgk3eBbWRyzw9m3vYjAmzy0=;
 b=E+NT/nhvzkpynu4x3VHUMhoJCIkFh2PkcjEVms8Z9+I13AvV8mw9AcKECzEjSSQqQh3r2jqxu1JaLy1mDxJVVeVvXf7n4JknLBYcJ+X/xfkdpNzKC2ZwlHqs9bmj3DJZtgIMKbNPKUZZlYtf3TXPlfxXZ8o3cij2KcX+EKLVVQE=
Received: from CY4PR2201CA0004.namprd22.prod.outlook.com
 (2603:10b6:910:5f::14) by DM6PR02MB7097.namprd02.prod.outlook.com
 (2603:10b6:5:25d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 17:42:19 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:5f:cafe::ab) by CY4PR2201CA0004.outlook.office365.com
 (2603:10b6:910:5f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Wed, 16 Sep 2020 17:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 17:42:18
 +0000
Received: from [149.199.38.66] (port=37905 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kIbRb-0007LK-J1; Wed, 16 Sep 2020 10:42:11 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kIbRi-0005Ul-KU; Wed, 16 Sep 2020 10:42:18 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08GHgHnM014110; 
 Wed, 16 Sep 2020 10:42:17 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kIbRg-0005Ta-KU; Wed, 16 Sep 2020 10:42:17 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id B37A313C029D; Wed, 16 Sep 2020 23:15:58 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] sd: Exibit support for CMD23
Date: Wed, 16 Sep 2020 23:15:56 +0530
Message-Id: <1600278356-28636-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 50377335-14e9-49a6-4f5a-08d85a67dbcc
X-MS-TrafficTypeDiagnostic: DM6PR02MB7097:
X-Microsoft-Antispam-PRVS: <DM6PR02MB7097A99CFD4E0B3022E92435CA210@DM6PR02MB7097.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCqaF2tmXCHRIP0oEXaGpg0ZZ9RS5+nAghymFlAXsg1GE4nA8ctycWJPqMBFukUTzue6h8t6HFKCOHI037/3rgaXvnOY4iVW10DWx4joBfXliA0b6UX0iCz1nt+GsZHvF4zNOK2DB/7vhyGMhFOxg6cyWJiTaV4pIt/c/C/f8HVRO/HywV6W9xBWRRswa9cCq5vm0x9ck4/pKT6EGSFLqI5Q2XThmJUGTvLomsuViYxk5HT7m6mj1vrtXvAMeH7fClUiHdXpcMNgcWjYMbu87/vQzqJcaOMRdXc/9g056+uFqyiDZtxNMlljOj9vtxYTjcQAxIi5ICHigfkmfmJNxiTLYX15vLWbRE3nI9bSmnTkpozjae4RdTEROzRod8sLHbdFrWP8ncqnT3KlYu0FoQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(136003)(376002)(346002)(39850400004)(396003)(46966005)(47076004)(82310400003)(81166007)(356005)(83380400001)(2906002)(5660300002)(4744005)(8676002)(316002)(42186006)(70206006)(82740400003)(26005)(70586007)(36756003)(107886003)(336012)(8936002)(110136005)(478600001)(426003)(2616005)(4326008)(186003)(6266002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 17:42:18.8566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50377335-14e9-49a6-4f5a-08d85a67dbcc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7097
Received-SPF: pass client-ip=40.107.94.80; envelope-from=saipava@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 13:42:21
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
Cc: Rahul Thati <rthati@xilinx.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update SCR.CMD_SUPPORT register with support of CMD23.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reported-by: Rahul Thati <rthati@xilinx.com>
---
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


