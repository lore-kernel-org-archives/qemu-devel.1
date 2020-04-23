Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ACAC55185
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 00:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F0B2074F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 00:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="adxCKTz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F0B2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRQDa-00016V-BL
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 20:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1jRQAg-0006eD-JL
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 20:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1jRQAe-0000pW-87
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 20:56:54 -0400
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com
 ([40.107.94.57]:6181 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jRQAd-0000ci-QC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 20:56:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jM0OChTY1yByfeC3QI89IyrYURWaBLv1Qry4I+hDtUEr/PnvdHFm4jfFeCH0vlTuJn+31Ur9GG3+r5xdnCRnmC8rMyPChJQIiRJQbd1+4x/9LqI8jS39TBH18s4LEUC1PVDHTAUOYaHvKdVO4cwPsJY2Z0sIN26SfcmjMHWNTS0B2Z1XlutfADobKhV4nkrHd4C7xbhy3Zs44daau9HelGmfGLmIpRj2P7sqsmZlfPghFHngSExZWcNO1vixb+ox1lPnS1lBAJZL/y0gf5OeltaW/+XhWEdk8pX7MrGkp0JTginJDFJHLuFGfLew2e3U1Bepcl6gutzM2uZDAthvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLfKK3vT9MElE8nlum6/ghxTQmdbg1Y4zcJKAHDFOwI=;
 b=atRuZnIx8AIev40Z14m6qc2TZco+axo/EYtBjoFIXf4MGE7k2HATorlk4DFOD5LlJxelEvSb/1XyI4PfgYnHsi2p21N3wCRWfrmFaFiy2exas4YVFU/Zigbw6TQ/pQtgXwKfarnUNYPkM6uQDnDEQG9cR7MyFp3CQ9jOK2Njdqx4GPgfcyMQvm7Dqi7htF6VWjq2SL/B8wjo4VrlXMNT+2EYYg/3mc1o17q8ZBSA3cD6Lc5lGHkuELzXNKVnFEO5n+di6RKtR/Bp9LIkS50lOBkvUWaqNlwPOYYA6BO3Xdoi98jAoPK19YjdQPFRREssHIAr+qYk6iLcQbjZ4HLeRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLfKK3vT9MElE8nlum6/ghxTQmdbg1Y4zcJKAHDFOwI=;
 b=adxCKTz8mrAOC+CBpB8qyPJER6omoAmvKLFueR8pj9cKK/81WpuVaRbwjkuMo4UXd4t8av30mBOX+8Rkn9rVqPdYwpVYy6wJgKu9HA04Zq+axP8i4M+DHaLT6OQDP5uB7D+OGUhBTgAiCLITY23LNHMWJD8vJYWPu5yt/JAkvXg=
Received: from DM6PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:40::42) by
 BYAPR02MB4821.namprd02.prod.outlook.com (2603:10b6:a03:4c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Thu, 23 Apr 2020 00:56:48 +0000
Received: from SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::33) by DM6PR03CA0029.outlook.office365.com
 (2603:10b6:5:40::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 00:56:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT052.mail.protection.outlook.com (10.152.72.146) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Thu, 23 Apr 2020 00:56:47
 +0000
Received: from [149.199.38.66] (port=51916 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jRQ9V-0004Jc-Ll
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:55:41 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jRQAZ-0007tD-4o
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:56:47 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03N0uhFv013711; 
 Wed, 22 Apr 2020 17:56:43 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jRQAV-0007oW-6E; Wed, 22 Apr 2020 17:56:43 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] MAINTAINERS: Add maintainer entry for Xilinx ZynqMP CAN
Date: Wed, 22 Apr 2020 17:56:09 -0700
Message-Id: <1587603369-14644-5-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587603369-14644-1-git-send-email-fnu.vikram@xilinx.com>
References: <1587603369-14644-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(186003)(9786002)(336012)(426003)(5660300002)(8936002)(81156014)(26005)(478600001)(7696005)(36756003)(316002)(2906002)(81166007)(82310400002)(356005)(47076004)(82740400003)(6916009)(2616005)(70586007)(4326008)(6666004)(107886003)(70206006)(4744005)(8676002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5127a4af-d89e-48e7-cdb5-08d7e7213325
X-MS-TrafficTypeDiagnostic: BYAPR02MB4821:
X-Microsoft-Antispam-PRVS: <BYAPR02MB482139E574DF428FC49ED3A8BCD30@BYAPR02MB4821.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M61aEfYBLvzD3/dZOK+SLfsbeBthEc/kvgngEQf4QUUAbUxsuNsAmf88r2ZjY/Y4ImHur/sk4fHO4cg2nc0yGz1PTyuMnSm/ADhSdFl7E8RSJM+rXvOEHRUJ9lhM16BiEoH4k/7J4PivvJd1ZgdYFjdzA2pP4pcPBcFAZaBiUw0DIKpE6s+bmW2QpNy4SMi6x2AkWRd1Y1uiKziI4cmmJU9qRWGZYJxZ0e2/nFXcM1xFkh4SVUef8/aKQrfSJNAQmVFMvk2KLKV6QsSQOUt6l+vpOGlLt41QxULeUqLousOMGgrs817Lj83iS8D8fQTszRwzdFKQ7PDM5WUy77yr5BTPCQsVA166TJZlmF9DJqyz9wNIuNfKKCw4gO3KPiNfl60cOEkxmUlBw12KgrHAQuvbSbFufmyTUe507RFEL7aLhBHaVe2qfs10pQ4az4kVqc3vWYD9h/KMikkWIZ7So6YntfX5qc6FF0Hx3Kjt4vkhXnNAMvEKVoUwq2q1/unBs50BFPHsIDGRT2B/T/xxeA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 00:56:47.4237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5127a4af-d89e-48e7-cdb5-08d7e7213325
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4821
Received-SPF: pass client-ip=40.107.94.57; envelope-from=fnuv@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 20:56:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.94.57
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
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add myself as Xilinx CAN maintainer.

Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fa..6223573 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1433,6 +1433,13 @@ F: hw/net/opencores_eth.c
 
 Devices
 -------
+Xilinx CAN
+M: Vikram Garhwal <fnu.vikram@xilinx.com>
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


