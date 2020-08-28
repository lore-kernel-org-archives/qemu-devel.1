Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811A2C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DB52075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OrUiEOZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DB52075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBk6Y-0002ut-Ln
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 15:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kBk4s-0000ij-B8
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 15:30:22 -0400
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com
 ([40.107.237.71]:37878 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kBk4p-0004qR-RD
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 15:30:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSb3ZNldBxthT71o6ZVXyxnd0/HZZFzMPKDfgs3p20NDk0ChMCrMWSlDj7E1p4Sr2ShKvlt7rQDxXfXgpM8lRciykDhTGjjliU7Jta/aX2mqjdcVneeolgIbSdtABfMxQjT2y+WYluhYl9JCWMCF84hkmLAlktzaanNen/5URORbNBJAScBi8EtX0KxfWo+h+PzFEndX+03z8Ls2Tjksjl6lE+Ip5VA73xA+ZONoSfNTfV+WA4yLkBWGTEcyl+WUoky0qUupD4bHq7gfpH+LocL0RnEah/p3QBkzUYLGH7pQGB9NZe+dGw61npO7xDH8UXGdePK/LO7ONpj7A7zRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTUANMvtwLezbi1twDlBeS9VtnaiW1sUuSUfGWxltK8=;
 b=apuxzv1aXPz0cGN+jNiGUN39pakLS8YmrmIHrazTVr4xewB6d5ZxNe3Qwyjxd8RSnKSu51NM//AZrY3WKUDZS7bwE4XT022G9sUt+gNhnOavc8FWBd8dPDD3lR2PTWaeu6RBhsWt/UyQzCNsO+ijwXpHlLQgbGcPMYsInHBxWSjqkbE98PBx8ALjQvf6Pv1H/6iLBcVvlzVqJGjByIjXe6/6ArsATO+F+up6PDVIjI4YLQt5h6ESSevnWZPLz7bzedOq7UeAWYAyUM6wj+dtXppfEvQRlaEDUNxRAcSXig/HDDFUYsskVpE7+Bovgrs8Ue2GbbG1FiSHX9XEegVrlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTUANMvtwLezbi1twDlBeS9VtnaiW1sUuSUfGWxltK8=;
 b=OrUiEOZlJPJoMYqi5hhXiPFYfgOmrkzc/sBTS2tAHr7rNae9mPEWEshiW5DiHs05nKHO6aYBMwrNk1r6oZ3v+6ecePG53iiXgCOs8G/g6W50ga1KmZmyNsmoS0fsRxwiroedghzW0/T+kfMlmmpBSG7WInDZBg56Lr+QLeDFun4=
Received: from BL0PR0102CA0059.prod.exchangelabs.com (2603:10b6:208:25::36) by
 CH2PR02MB6167.namprd02.prod.outlook.com (2603:10b6:610:4::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Fri, 28 Aug 2020 19:15:15 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:25:cafe::c8) by BL0PR0102CA0059.outlook.office365.com
 (2603:10b6:208:25::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 19:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 19:15:15
 +0000
Received: from [149.199.38.66] (port=48147 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kBjpg-0007JO-9f; Fri, 28 Aug 2020 12:14:40 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kBjqE-0002CJ-OB; Fri, 28 Aug 2020 12:15:14 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07SJFDx8012946; 
 Fri, 28 Aug 2020 12:15:13 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kBjqD-0002BT-5Z; Fri, 28 Aug 2020 12:15:13 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 774C613C0585; Sat, 29 Aug 2020 00:49:47 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Francisco Iglesias <francisco.iglesias@xilinx.com>
Subject: [PATCH v4 0/7] Make hcd-xhci independent of pci hooks
Date: Sat, 29 Aug 2020 00:49:33 +0530
Message-Id: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4b79d9c5-ad47-4e7f-2b47-08d84b86b1ab
X-MS-TrafficTypeDiagnostic: CH2PR02MB6167:
X-Microsoft-Antispam-PRVS: <CH2PR02MB61676FEBED0DA821071D0F14CA520@CH2PR02MB6167.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuH/RdyFRYtpet8kyniAIGPbxsww2x+h7GLnU9gnAgDpcq9CZAEA7NfGQOa0U75aOJnT/pacTtYYhOcbgNBK44n4HV9xk/bULep2NciNiSRPEKL71vUw/wtLui7OpnmU20t3oVCykom6aRseOl4RV5rYrH7YqndIY3d82asad7H+ZqXtsEMzsCZB/qRGX4tgtKXBep4C7noRDFODRrgFRuEGMkZILoCOxuBwmrVJcZh4iykGAC60z6BhtkbBBphWYJ/wzgkHXUFdq2DZ00TapzmBVOaYq7L6ZxBfvO419dtcl6fsLcbkDip+4VOI6SdLf3fn9tkBkasaPohKxay3rGJtDsCLrsPMrEAydzJXNjTgu0zNCm3v5a9GTEcWbmb6FIUcvlrvJ2j8Z9kbcMTr+Q==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(376002)(39860400002)(136003)(346002)(46966005)(82310400002)(356005)(83380400001)(82740400003)(47076004)(81166007)(6636002)(5660300002)(426003)(4326008)(70206006)(110136005)(6266002)(70586007)(7416002)(42186006)(316002)(8936002)(8676002)(6666004)(54906003)(2616005)(2906002)(186003)(26005)(336012)(478600001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 19:15:15.1271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b79d9c5-ad47-4e7f-2b47-08d84b86b1ab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6167
Received-SPF: pass client-ip=40.107.237.71; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 15:30:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) AC_FROM_MANY_DOTS=2.999, BAYES_00=-1.9,
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

This patch series attempts to make 'hcd-xhci' an independent model so
it can be used by both pci and system-bus interface.

Changes for V2:
    Make XHCIState non-qom
    Use container_of functions for retriving pci device instance
    Initialize the AddressSpace pointer in PATCH 1/3 itself
Changes for V3:
    Convert XHCIState to TYPE_DEVICE and register as a child of XHCIPciState.
Changes for V4:
    Add DWC3 usb controller
    Add versal, usb2-reg module
    Connect sysbus xhci to versal virt board

Sai Pavan Boddu (5):
  usb/hcd-xhci: Make dma read/writes hooks pci free
  usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
  usb/hcd-xhci: Split pci wrapper for xhci base model
  usb: hcd-xhci-sysbus: Attach xhci to sysbus device
  misc: Add versal-usb2-regs module

Vikram Garhwal (2):
  usb: Add DWC3 model
  Versal: Connect DWC3 controller with virt-versal

 hw/arm/xlnx-versal-virt.c               |  59 ++++
 hw/arm/xlnx-versal.c                    |  38 ++
 hw/misc/Makefile.objs                   |   1 +
 hw/misc/xlnx-versal-usb2-regs.c         | 224 ++++++++++++
 hw/usb/Kconfig                          |  11 +
 hw/usb/Makefile.objs                    |   3 +
 hw/usb/hcd-dwc3.c                       | 606 ++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci-nec.c                   |  18 +-
 hw/usb/hcd-xhci-pci.c                   | 244 +++++++++++++
 hw/usb/hcd-xhci-pci.h                   |  45 +++
 hw/usb/hcd-xhci-sysbus.c                |  99 ++++++
 hw/usb/hcd-xhci-sysbus.h                |  32 ++
 hw/usb/hcd-xhci.c                       | 260 +++-----------
 hw/usb/hcd-xhci.h                       |  22 +-
 include/hw/arm/xlnx-versal.h            |  14 +
 include/hw/misc/xlnx-versal-usb2-regs.h |  43 +++
 include/hw/usb/hcd-dwc3.h               |  58 +++
 17 files changed, 1552 insertions(+), 225 deletions(-)
 create mode 100644 hw/misc/xlnx-versal-usb2-regs.c
 create mode 100644 hw/usb/hcd-dwc3.c
 create mode 100644 hw/usb/hcd-xhci-pci.c
 create mode 100644 hw/usb/hcd-xhci-pci.h
 create mode 100644 hw/usb/hcd-xhci-sysbus.c
 create mode 100644 hw/usb/hcd-xhci-sysbus.h
 create mode 100644 include/hw/misc/xlnx-versal-usb2-regs.h
 create mode 100644 include/hw/usb/hcd-dwc3.h

-- 
2.7.4


