Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6D7C47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0632075A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dsc3GgIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0632075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNQ1A-0005iD-9W
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 20:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kNPzE-0004Bb-GT; Tue, 29 Sep 2020 20:28:48 -0400
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com
 ([40.107.243.52]:18688 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kNPzA-0007lK-9G; Tue, 29 Sep 2020 20:28:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfgsuPbTUSIT0EjtDkj0OgGvO2xbs51RxRXo0epGAeUNvDEOLcq60zIHgLjr66oZJ7MxB3WkoU6xJdyHZjnvNAYL9k3axVh0f09aXq1fvBQIibmoAxMq8XSHG8GOYZB0DgfPLhyJePOIKIUDxsBcIX1/uT2TDCu/HzWWlHbzzRCbpGWTVng2Rrvsi3yo90ekvGwfnY4aWBmqiTqwDKhL6chQE0VTClY/Gm+9oTJWikx+E4Ro/p9nx+E2l7i8kxDUMWwRyWEdu5cdidnuCMZBYdYi5u4tfrjAQhKxfCF0QA9OLiMf8pbbehCMClfRoufiy5NESqwqv4VX7rHNL/B+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EggeW64ZqcqxO+iy+qGs5QCHbxH7LrlKjU1FXNKeIuE=;
 b=kUruuDCV1A9Frf1kjZtzndA14Pgj7CQRxbGs9eIUT3oyOI/7ycznmsX/M5cFR8xcm69jDSvATafaDrK0ebLjPCJPXKpn0Kwp48yT2Kd8vnNYot4C1VamiZqmsPANfvpGz+goH1HoD1ZTD6ow94nn5kTMaH0x8Ou6gLydMtxl98E14sdS2qtmpXSva11jVtt6gb3dO33h5HgVNM1f+Jybs94LV14iBG7U15mxrmP6FrCzpdzaASWkbBLvQ49R4O0USafjXdOfrGcSGQLevijM8iG3GBhipWknrBBrd26mwsk+i5YQe0Id7Z7iPYtjaC8AEnFSTyuskOvG1xFv6pJ6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EggeW64ZqcqxO+iy+qGs5QCHbxH7LrlKjU1FXNKeIuE=;
 b=dsc3GgIXdDxzyNV3yfb4hDk3jePRm/RcUhH3drE9zGczR9beiYpQZBE3WQEotTpE6tBnNUIo+qTV5D5mo+b/jcc9n4+ZECeS4m0oBvNkc2AKI6WZ7cThO3W9yztPg3XxjplX3aLJENOhAQjjL24M3gMGmniCw5av1xf/Ul0pvlM=
Received: from SN4PR0601CA0024.namprd06.prod.outlook.com
 (2603:10b6:803:2f::34) by MN2PR02MB6368.namprd02.prod.outlook.com
 (2603:10b6:208:1bd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Wed, 30 Sep
 2020 00:28:40 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::6a) by SN4PR0601CA0024.outlook.office365.com
 (2603:10b6:803:2f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend
 Transport; Wed, 30 Sep 2020 00:28:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Wed, 30 Sep 2020 00:28:39
 +0000
Received: from [149.199.38.66] (port=59159 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>)
 id 1kNPyg-00073r-Kp; Tue, 29 Sep 2020 17:28:14 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>)
 id 1kNPz5-0007Kh-N2; Tue, 29 Sep 2020 17:28:39 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08U0SawV005666; 
 Tue, 29 Sep 2020 17:28:36 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1kNPz2-0007Ja-Ko; Tue, 29 Sep 2020 17:28:36 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/block/m25p80: Fix Numonyx flash dummy cycle register
 behavior
Date: Tue, 29 Sep 2020 17:28:34 -0700
Message-Id: <1601425716-204629-1-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c477d447-6108-4a4b-1324-08d864d7c775
X-MS-TrafficTypeDiagnostic: MN2PR02MB6368:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6368435BF1B3982869092A8ED0330@MN2PR02MB6368.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91LGwYuzxs2T0CK0q4ns5NLnAPDNqO0aHsour0yRvnvrBoZfK/FtJU1DB3qojTDs0pOSL5z0BpducIzhmb4b4tAvNU771pdjpu+ZKS2MaOpfTOMv/EH8J8/Ptwihy/dq9ohLybngyBSW+PjvdwJ9quAsXtLMPculVjMcXZZepfZjArkYX0dj2Yt2IjTs+VM9YsIJXtlcWavavpmCABfzkcaEOHlWKPCdLgMk/hj6VL3l70Eb2SL74d7oGYNuvyWkHYrlRuOdMjwaA5EqgFxWaC1genJSxJ7arKTt3fJU8h8CXxhVyM9pKMDUBlRAOvJcAJ4x+l5qRroQMG1GTdueLcQqhhE5IW6Jykak5llHBAwVJQ5OOy0QgXT+LyFrIul/p/XvCeTsh5jXST1uhlwSS9TlT+Z7t54HJm1vA5Yki5rhvBkXcOsjCMaUzF0Y3UIV
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(376002)(346002)(396003)(136003)(39850400004)(46966005)(44832011)(2906002)(336012)(86362001)(426003)(4326008)(4744005)(2616005)(47076004)(186003)(36756003)(8936002)(83380400001)(70206006)(70586007)(316002)(356005)(81166007)(26005)(82740400003)(7696005)(8676002)(6916009)(82310400003)(9786002)(478600001)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 00:28:39.9940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c477d447-6108-4a4b-1324-08d864d7c775
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6368
Received-SPF: pass client-ip=40.107.243.52; envelope-from=komlodi@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 20:28:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.614,
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
Cc: kwolf@redhat.com, francisco.iglesias@xilinx.com, alistair@alistair23.me,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

This series addresses a couple issues with dummy cycle counts with Numonyx
flashes.

The first patch fixes the behavior of the dummy cycle register so it's closer to
how hardware behaves.
As a consequence, it also corrects the amount of dummy cycles QIOR and QIOR4
commands need by default.

The second patch changes the default value of the nvcfg register so it
matches what would be in hardware from the factory.

Thanks!
Joe

Joe Komlodi (2):
  hw/block/m25p80: Fix Numonyx dummy cycle register behavior
  hw/block/m25p80: Fix nonvolatile-cfg property default value

 hw/block/m25p80.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

-- 
2.7.4


