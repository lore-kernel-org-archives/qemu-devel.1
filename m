Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CD8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569562177B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="h1FuCYzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569562177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSZjO-0004B7-DL
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 01:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZgX-00018n-El
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 01:50:49 -0400
Received: from mail-co1nam11on2072.outbound.protection.outlook.com
 ([40.107.220.72]:20352 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZgU-0004B9-0t
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 01:50:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PD+S6qIrT2yKU0yFxQ/82RvPCJQCfEy8WH+8h69ZfKL0nF5XgDSC8W3t/CUbyZpcipIy8EJdWWywSGFjhXjIYWYS/jJeUIhZMn/s7Vi+lUzY4FQu2o9b0ScC7x2UchrY9AFEMndY5ZioU7U05Gi+4hFfiG4nzPrytN59MaUZdDXUFm7KMpFS61kLWdSFZ3On0RXQZn62QUx56uyetpLQVwL78dAcaCbPQk7i0sDzYzvnxzsRPj5WboENcbx3LMsnEv9/iuUhL7txdULwLS4tfiMvEAuXbwb8nq1SmqJFfKa290H6Y7C5mxT09OFE9ZUDtKyGia+ZiFZr3QoFXyguRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFebQn3EFBQdTQJm7xLpLU46YHuDLmCHz4+KPg1F/iA=;
 b=YLd6omdyvM2neaitcixsaRWOH0BLsuTrg+7TCBGdFjbFOhJYAESFXprcdC/TA3li3Dry6faV30x1Hy/UePKg3qhEWlJRgQR7NOAxonK+5J7iNy/2e9Rr8QP1AkCgHx6e454j80rSiecQUEcZiU36VKO2VJXjzlAfygx25pLDtZhQQf1qSO2o+e9wN0mQsxarwqCr7jfh/7PvmJjHkdD3UAVorI7rVAS2audAO2UI+glJc2jjkekxUg/I7RiI5AJ8Lr/2Ma+ole5REGeZnlSWAjEfse8szxYdvRhb+lzvTvx3AlkALMfkXAs9c8OfE75slkqvupL5UXj0prDhupOCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFebQn3EFBQdTQJm7xLpLU46YHuDLmCHz4+KPg1F/iA=;
 b=h1FuCYzv23GhMGQ6vxhVRjbNVuPeum1fziLJPOy1wYaqTy9bdA2dhIAKTH05TikobKw9epaLC9PAUtaFkY2UYoBN+jwLh6Wg6512Tn35gSMr5Macbtx/v43P5swwlJKTNWhjxekik5IL0wK2gq8euy0JTPNV0SWp3g553qWRqik=
Received: from BL1PR13CA0272.namprd13.prod.outlook.com (2603:10b6:208:2bc::7)
 by BN6PR02MB2241.namprd02.prod.outlook.com (2603:10b6:404:2f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 05:50:42 +0000
Received: from BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2bc:cafe::c9) by BL1PR13CA0272.outlook.office365.com
 (2603:10b6:208:2bc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend
 Transport; Wed, 14 Oct 2020 05:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT039.mail.protection.outlook.com (10.152.77.152) with Microsoft SMTP
 Server id 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 05:50:42
 +0000
Received: from [149.199.38.66] (port=33443 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZfg-0001eB-Ao
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:49:56 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZgQ-0003D3-Bb
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:50:42 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 09E5oZnW006476; 
 Tue, 13 Oct 2020 22:50:35 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kSZgJ-0003AT-4I; Tue, 13 Oct 2020 22:50:35 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH resend v11 4/4] MAINTAINERS: Add maintainer entry for Xilinx
 ZynqMP CAN controller
Date: Tue, 13 Oct 2020 22:50:34 -0700
Message-Id: <1602654634-35418-5-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602654634-35418-1-git-send-email-fnu.vikram@xilinx.com>
References: <1602654634-35418-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 81aade3d-75af-48b0-4232-08d870051677
X-MS-TrafficTypeDiagnostic: BN6PR02MB2241:
X-Microsoft-Antispam-PRVS: <BN6PR02MB224139CF56F820744BCAAF3EBC050@BN6PR02MB2241.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c79dcPtkuQMuuRFWyZyGReZES4BySBUk/bpL3SL6fILmMhqWngT9L6+WQktZIjjStSvAKhh2P9mZQOJy3iAvnfAEJtwJqFXg0/jSDpmKISawEJXz1ROiLbA2Os7vSikeEscEiwaSCpwg/t1UfYbQ6h3Wei4HW4MFGIk42qywJXXwOMExSwsAQfeh/8W0n+5rJzVI/Nfr8EwrDV0lc5/WhMgJUT4mNg/lqgrnyGMoY0PCDMEdyr1utc1G+W/yBSqCxIoCVd3TppKU31Gsp+xwDWbq2zp4rmNhHHAUKEGnWpsfCENO5J1FQ3Ukydu30mt/iStZW+onYhl4OlwslKf1Zd53RLqJYjiCDKzcp4Ma0EcnVFHfgQHpjvWC/V52xWS4XydehfKZeEjfQ7/GLYZHPw==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(346002)(376002)(39860400002)(136003)(46966005)(36756003)(70586007)(186003)(70206006)(26005)(4744005)(9786002)(5660300002)(4326008)(426003)(336012)(107886003)(2616005)(316002)(82740400003)(47076004)(478600001)(81166007)(8676002)(82310400003)(356005)(8936002)(2906002)(7696005)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 05:50:42.6967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81aade3d-75af-48b0-4232-08d870051677
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2241
Received-SPF: pass client-ip=40.107.220.72; envelope-from=fnuv@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:50:44
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


