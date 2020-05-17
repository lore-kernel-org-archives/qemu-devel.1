Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31334C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 07:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37522075F
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 07:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LkFiTUUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37522075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaDgh-0003FG-3P
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 03:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jaDfa-0001wB-Gv
 for qemu-devel@nongnu.org; Sun, 17 May 2020 03:25:10 -0400
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com
 ([40.107.92.72]:6048 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jaDfZ-0007fT-2Y
 for qemu-devel@nongnu.org; Sun, 17 May 2020 03:25:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AP3qzs7rf+k+CDvziAgSKWF9Z4CT5Tm2H5Gbz5VZYM3gG5CUeldsMXO1/qwy/FQ6gb/GbAlhUss66pCKV1Y0IQTGOD4I1HqlE5BfBQhMpg+4MYhP/p7+T69dDVgGXMyhg34fZooW273oxsYhoAlk8RgwRiBiyrFVqmgHnNF7Fe9VB0RPb9gVSSiVopCXXTqZu6VrPGp1znFh8q5Q+Dxh/pzaVa03/HHLsMp1gooSJBduZheURYkiVegLkEUHSzsppuLAARNBUHY+6wvmkX9V2w6exx/CFentlvXrpCso59RLbmFUOcSstmZ3I474hhtn+MMemnL1jxoPCH2LW2YHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOBcMNN0TLOIQO2HkcIAdMvVHFsGXBdVFnvRciSlvHw=;
 b=kaQ3oFbbPATL1LkYUE3/YGhjdQO7yn+FDmWR54RzBFJs3WBYXnWBIfTnMYumdhb3az3Uu9+QGOpMCY+sLn28ugn5oBic17usUBpgfixwIPPy7oFIp74JF8bQLIfqlSpBiYJqmya9iTarjSNZQYc9rKSN4BNJ9b/ZM723xGDnRihowUHkUm11melgRt+vN0kp2r9+uPt3rqrbmBmS1rvMF6yduDjhBle8X2v9tjxsY1pVJB0rs6pHDmyDdwKT+h1vxSvyW/wN0vg010BuSOcxl8iWErxz8uLThRg9PjCOAsJbUFPTTEjd2+kGo26sNGQ0BqOmPzU39AiSatZ/V/fZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOBcMNN0TLOIQO2HkcIAdMvVHFsGXBdVFnvRciSlvHw=;
 b=LkFiTUUSWLLuprtcBzxGVBJWywS8Kq9uboMkPE17n6ornxPdl+CaUEq3VVSG72Z0OSs7FOrYcPAsSQUgEWpLoUos9agHYyiI9ujVvdc4yRAxEUySprit71p2Y5S/FCYCnQbj53n+47HSQseeEt76bIHBmgkJgwql3bb8rerIJdU=
Received: from SN6PR04CA0073.namprd04.prod.outlook.com (2603:10b6:805:f2::14)
 by DM5PR02MB2380.namprd02.prod.outlook.com (2603:10b6:3:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Sun, 17 May
 2020 07:25:07 +0000
Received: from SN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:f2:cafe::d0) by SN6PR04CA0073.outlook.office365.com
 (2603:10b6:805:f2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Sun, 17 May 2020 07:25:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT004.mail.protection.outlook.com (10.152.72.175) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Sun, 17 May 2020 07:25:06
 +0000
Received: from [149.199.38.66] (port=37614 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jaDf9-0002FF-Ju
 for qemu-devel@nongnu.org; Sun, 17 May 2020 00:24:43 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jaDfW-0002kk-78
 for qemu-devel@nongnu.org; Sun, 17 May 2020 00:25:06 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04H7OuNk020514; 
 Sun, 17 May 2020 00:24:56 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jaDfM-0002ct-7I; Sun, 17 May 2020 00:24:56 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/4] MAINTAINERS: Add maintainer entry for Xilinx ZynqMP
 CAN controller
Date: Sun, 17 May 2020 00:24:04 -0700
Message-Id: <1589700245-142782-5-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589700245-142782-1-git-send-email-fnu.vikram@xilinx.com>
References: <1589700245-142782-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(376002)(39850400004)(396003)(46966005)(8936002)(478600001)(82740400003)(426003)(9786002)(36756003)(356005)(7696005)(336012)(186003)(4326008)(5660300002)(81166007)(26005)(8676002)(82310400002)(316002)(70206006)(70586007)(2616005)(4744005)(107886003)(6666004)(6916009)(47076004)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ea6463d4-86e4-4bce-9553-08d7fa336c6a
X-MS-TrafficTypeDiagnostic: DM5PR02MB2380:
X-Microsoft-Antispam-PRVS: <DM5PR02MB23806EE832B2F8BB68DB607CBCBB0@DM5PR02MB2380.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-Forefront-PRVS: 040655413E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHgdleWzo1HIivFVgcTWgP1S+b/MBgqeN//yEFr3JZWzugQni2Rh3zVzRb3BDLbZngM9gZQgsi4jJKwKEPBzjVTWKucfWEr6EvUdttNb8hN196+Xc7gpRKIuKnCJeQ9ohgwKvkHZB2NYPu0ls34YhomGffnEhH7ksRe1p1KHZqwhQXMaj0OVO6loY4Yn1GvWjuBXEbvoA79F+2uQo7vzvPrX2yxnOOmYwYcGfiegOGQGk+krGcmESlEdbOYOdzaKT1YhFqd+lFuGDL8Dhnu6IXX74czbFkAJcodKCFIgec66lkV7Z+FsPsmXBnVfTrrJ7fJ04PDoGkashmzpc6onPJzOrcxoNjrhzOoGasR+J/pFJwdaJMDyhSbqKhsLKzQxdON26+GiSiP4jm2d2xOW+Ow8QRwIZnAkbx727ORZW4kX9bxyupZOpXFM16yEuiucdEXq0qoc1B6nTdDL/yNDVhAkeqOBN2pMPgNEmSzuJsLv4gIek34/s7sZjqF8TdPUr6NXjIgGWAqzJHxFR+q4KA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2020 07:25:06.5210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6463d4-86e4-4bce-9553-08d7fa336c6a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2380
Received-SPF: pass client-ip=40.107.92.72; envelope-from=fnuv@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 03:25:08
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
index 8cbc1fa..b53d75e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1433,6 +1433,14 @@ F: hw/net/opencores_eth.c
 
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


