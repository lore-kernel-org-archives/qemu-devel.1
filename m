Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67505C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38BA820780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rqvYuSVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BA820780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPVmk-0002ha-8f
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 14:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1jPVkq-0001B4-96
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fnuv@xilinx.com>) id 1jPVkp-00025f-3Q
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:30:20 -0400
Received: from mail-eopbgr760083.outbound.protection.outlook.com
 ([40.107.76.83]:9278 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fnuv@xilinx.com>) id 1jPVko-00024K-Ti
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:30:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw3bK0OGfbqQZrTsYlB43CPihqc5uoOWD53HjfaF5NGuGpkldT9x/VpfgM0DCzrKehtbhcH8ByW/9DrF+qEW53PeKWaonV/L+cH7+Rus+ajKtOlQ31VP6XnkaD+OKiqW5R2elqpqBPvDvKX6K4L5BHjDzowYUWQRz/0IJs8aar2lBCpFbBRBPvmdw8TLNSzjtDOj5sjEcckRS8MzifN0e/sfvyUvBJ8iqHxQF2f0XSVwkjuxunO133OWgZTc3b7N64iESrVT9yAldaiacSMpV+oq4gN87hcBN8ZNESXFV+1kZ5Vb2iw+DEhYdJth4t0ecDJ/673DGNXr445r2P+Q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLfKK3vT9MElE8nlum6/ghxTQmdbg1Y4zcJKAHDFOwI=;
 b=RefFQA7X0RAYhljvuV8v2Q+8Ym5xjl1q+Ot90F8O+SYFFNttR/+NagsfAfV9PJtdpgDQrwcy5anOsykgp5bnozFb70dRGIGG2WTcyeTRRRotO5tZhYAOLppOmj9DsmY3Fw/anD914hZpM4Rd2ZmWP6RAmEOFlR3bhFkZZyYWVqcinYB3lsERXm0Q8BY5w8w6HJYMvRLf0KvA0EtmihXSN4yEQQeYH4NeI58TzhI/9QLkGcw3fiw0VTKgukG85LAthlOhTx5C8jAc/3XBFUvaAZP9tgL7/67w/T0xkH3WIaufv+2SlmQ5WAbuFbVXSpHhEqa6BU1PEetzw+ZekiairA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLfKK3vT9MElE8nlum6/ghxTQmdbg1Y4zcJKAHDFOwI=;
 b=rqvYuSVPJBS59CZFH0aGB0siUnNbBtoSKN08W0cjDvc6ZNHCAK9eshkIJLKCSCS+ztA20UYBC1y+IWK33RfbfBmi5b5RwsPrPcH/iYQieFerAsrQZqCr6rZGTdWyzemfeVEn0ue8h3zaGRbzPs6zN/cpR7oRYQLnB2od1EvSmZ4=
Received: from CY4PR06CA0055.namprd06.prod.outlook.com (2603:10b6:903:13d::17)
 by SN6PR02MB4861.namprd02.prod.outlook.com (2603:10b6:805:91::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 18:30:15 +0000
Received: from CY1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13d:cafe::40) by CY4PR06CA0055.outlook.office365.com
 (2603:10b6:903:13d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 18:30:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT061.mail.protection.outlook.com (10.152.75.30) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 18:30:14
 +0000
Received: from [149.199.38.66] (port=34090 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jPVjw-0007K3-Ad; Fri, 17 Apr 2020 11:29:24 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jPVkk-0005wz-2a; Fri, 17 Apr 2020 11:30:14 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jPVkd-00055H-Ku; Fri, 17 Apr 2020 11:30:07 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [[PATCH v2 1/4] MAINTAINERS: Add maintainer entry for Xilinx CAN
Date: Fri, 17 Apr 2020 11:29:26 -0700
Message-Id: <1587148169-173268-2-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587148169-173268-1-git-send-email-fnu.vikram@xilinx.com>
References: <1587148169-173268-1-git-send-email-fnu.vikram@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966005)(356005)(26005)(7696005)(81166007)(478600001)(4744005)(5660300002)(81156014)(186003)(8676002)(82740400003)(47076004)(6666004)(2616005)(70586007)(70206006)(426003)(8936002)(336012)(9786002)(6916009)(2906002)(36756003)(4326008)(107886003)(316002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6831c92b-2271-4be6-2ac2-08d7e2fd5ef2
X-MS-TrafficTypeDiagnostic: SN6PR02MB4861:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4861FDF4908490605A87DFFEBCD90@SN6PR02MB4861.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PwLZkUhfxjot+BkpSOntULrvF4PTGCesXeoQeRxXt32RNzIYaKkPZtc4cv/BtvEeoyn+n7jICjJotRkMGivhjynygFzGGIrvb97Sc8r3Vs/7XmC/Yri4PmbYmI7juHzfb7ic2z7yq3JVswUIiEC44dR0RdR/uJpqHGG1jm7XfwGclHRaS1Zg9Ijs5rWWJcZ/cx+u2PXvQhECepGzSMe3p/KIi0ThI/SaBmuKhreM32KC9AhY1hs32Dyn8st6woZTo2UU9sLJMEOu+ru8l95arIPYVnyOT7prtTtvde140rbGiuvbwua2gl8O2HopyoN6FflHzZVYOILYw4eTQQqSU8JX1NDV3IZR/ihNArTHsjWOE7anOzTCsILoV5dySLKPyo0hDo/CqWUdMGQJ7Qh8/XixYfb2ZHsq3zjynlklacWvjVxoLvsfaM+o2yCP/AYRpEyezJ7ZN8DiRwFodYk6Y8loHVVh7ZD0SJ1Nsn1M7bL0W6PFGzEomJc92dVEtBFWpaCl7zPL+zAGumJGhhQqw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 18:30:14.3706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6831c92b-2271-4be6-2ac2-08d7e2fd5ef2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4861
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.76.83
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
Cc: francisco.iglesias@xilinx.com, jasowang@redhat.com,
 Vikram Garhwal <fnu.vikram@xilinx.com>
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


