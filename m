Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98329C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6A520829
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Z6aYomV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6A520829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRtZ-0002kN-In
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 08:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kDRrS-0000ou-34
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:27:34 -0400
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com
 ([40.107.236.67]:60129 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kDRrP-0003EM-VD
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:27:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAQRZwpLJISoMgeVIg61hTOEVc1AfPbUVmscccEQE8bHIiI1+uSG1xH4K9paA6qjH3RQmPl1S3HJ2Un2QXZDU5vdVo6seumII5DoQp0oz3hEUYc9kTOquLPa7qaUj+cfe9BXpDWAowHOv5DMW/oaJGbkB1Kft3zdTF3kOU+eBeOCX87rcE1awl0FzssKaGNF3HDTgwfVjAogZYB6wfpq/M0VswK4cG1em6rV25D9JaHLazzZxyH/bOX717ySP15pMlN9Hc3V6vrEPb0TEuudbZwEQ0wwThFwWftsBCAqFkGcPjJ0JYhVoFHuI2b8QnMUEVevAfHqxXHqwFuNR05xbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikV7o2TwSnZ3f0HMW2HGVquDgLbjrCFDhPcw45dp7to=;
 b=M/eB4bh5+J68iYgXKtbr+B4v1v/qPJWUCB3b6L+vGsDwv+xb/7DDnzeEnLFlvKnnDh9LzCgzxTu7qXNL1KK+MqD3O14XdrhjDiInCaKik69snehK/kOZ2CxdqLwyJnBN3DZHgdoznHzluKvnbMDWQIv58pT1HAMszP1K2+Be2FFzxTNFWq9kIaZi7THsgmS1f05tqFL6TJz9am0nzQWoG3AjVIWI8mHKbQwXc5vos1eHFBLJlTS5RJzx+949IJ+2+bs2u/xq/q9KQSvcEiHm7AvubdJfjpL2gmVmR5Ps2sNquKx/Y5CqOjVjL60WoLxJ1P2UShU9E17seEZhKIrIEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikV7o2TwSnZ3f0HMW2HGVquDgLbjrCFDhPcw45dp7to=;
 b=Z6aYomV9s1sNX4o93YTvYgh3SqRBrbxBAcco61MjqbuH3zZDHA1ZZFoG7HT95p+bGW6mqrSniU1RGf5S/OunpL+3E0euwOtAygDKN2niA5CYhWgeF5N2cO8d6/VBRFYBJojDuqSCypj8ct54rOV0MQJJDy2ykGSbl183Jct/iEQ=
Received: from BL1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:208:256::24)
 by BYAPR02MB5480.namprd02.prod.outlook.com (2603:10b6:a03:9a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 12:12:27 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:256:cafe::47) by BL1PR13CA0019.outlook.office365.com
 (2603:10b6:208:256::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.7 via Frontend
 Transport; Wed, 2 Sep 2020 12:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 12:12:26
 +0000
Received: from [149.199.38.66] (port=52595 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kDRck-0008A9-9J; Wed, 02 Sep 2020 05:12:22 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kDRco-0004lp-Di; Wed, 02 Sep 2020 05:12:26 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 082CCPtt032162; 
 Wed, 2 Sep 2020 05:12:25 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kDRcm-0004lM-Q3; Wed, 02 Sep 2020 05:12:25 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 742BF13C050F; Wed,  2 Sep 2020 17:46:46 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Francisco Iglesias <francisco.iglesias@xilinx.com>
Subject: [PATCH] usb/host-libusb: Check for USBDEVFS_GET_SPEED ioctl support
Date: Wed,  2 Sep 2020 17:46:43 +0530
Message-Id: <1599049003-2937-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11771f7d-f65a-413d-703a-08d84f397524
X-MS-TrafficTypeDiagnostic: BYAPR02MB5480:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5480FB9D75967900B8E4A4FDCA2F0@BYAPR02MB5480.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:216;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tcjhbwDOvdy/LYdtp3qZI80S8gs7NuA8rcvryiz5wKEAwQeup7WU6aR2XaXnRc4XoZfcY+XFTguOhCAUywZt19nIqGIXMn+kQ3syI+6NtNRQrp6jW5UV8zbN4H8nO7NbayFI4Mvq47ue+gtihF0Sg1jvOt8TPmGg4CxofSAAr7TechejpQwMWoPVMPAVvn3w+YBxctLAZw7jwenT3n1Q0x4+1L+JWsX6ZBXz+zi7aFJQeWHgp2KSVS74A3HQVJw3owlY7ipcQvKqfJZ29aENtp/9MGJIESz+zUCVhRRF8cST76GzlGu10apyQ51n48Jk8U/mFj0sWykZNz11m58WqG+kIwSZkt1y3DlTOnVWXfTQi0egAn40M2yI9YUE/g1W96WhVIjg2ckxStP6amaP7w==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(136003)(39860400002)(346002)(376002)(396003)(46966005)(316002)(2616005)(6266002)(336012)(5660300002)(4326008)(70206006)(426003)(7416002)(70586007)(82310400003)(4744005)(26005)(83380400001)(36756003)(8676002)(42186006)(81166007)(6636002)(47076004)(6666004)(8936002)(2906002)(478600001)(356005)(186003)(82740400003)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 12:12:26.9837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11771f7d-f65a-413d-703a-08d84f397524
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5480
Received-SPF: pass client-ip=40.107.236.67; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 08:27:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) AC_FROM_MANY_DOTS=2.595, BAYES_00=-1.9,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 sai.pavan.boddu@xilinx.com, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes compilation issue with older kernels, below is the error which is
fixed.

hw/usb/host-libusb.c:954:32: error: =E2=80=98USBDEVFS_GET_SPEED=E2=80=99 =
undeclared
(first use in this function)
         int rc =3D ioctl(hostfd, USBDEVFS_GET_SPEED, NULL);

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/usb/host-libusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 08604f7..c30d450 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -942,7 +942,7 @@ static int usb_host_open(USBHostDevice *s, libusb_dev=
ice *dev, int hostfd)
     usb_host_ep_update(s);
=20
     libusb_speed =3D libusb_get_device_speed(dev);
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_LINUX) && defined(USBDEVFS_GET_SPEED)
     if (hostfd && libusb_speed =3D=3D 0) {
         /*
          * Workaround libusb bug: libusb_get_device_speed() does not
--=20
2.7.4


