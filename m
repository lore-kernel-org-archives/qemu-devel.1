Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70134C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADB92469C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lwInpYk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADB92469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ha2-0003Fz-Bo
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 04:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j8hYy-00027z-Dx
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j8hYw-0006qB-5p
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:40:36 -0500
Received: from mail-eopbgr750055.outbound.protection.outlook.com
 ([40.107.75.55]:64705 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1j8hYv-0006pU-Um
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:40:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCz7eWRAGJ2tmzRM7P0hWM3KPXiVziavu05oXbD7Y4eNbCQthS2LljH+IWyBvE1NS+3imhYdfqnylpM8gSTyF0pBA31FvnyIFe+p2E6p7r+Zs3JfMOtiKX8X/8Vi+P3EklV4Nkwjpk9oHBjV7sb5cxPfSCktAtkpXTrBlOrbVeEHdyFutcRtiP/T8Gw0Ob78gaYGe37FMdH9rHBol0z6tV15cahqbSTfjdY2fmX/hHZ2zdLUQxe36E/WvQAaUIUfMcMMt9CmCSMZ5nL5Wtr1CUAKnH5FjWluGb3ySdyyv77JbfnhhRBVQSXa6FOrr8w/qLPDdQf3VtwxjKp1Qi/Vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR4rPwfycqJJaKiqSevQQKm01vLxFBgxzYpmHonG9lI=;
 b=bzENUT9xyUfI/FKU5bolKmLRIB4DU+wToN1C1qk+LYHHASXYrvmf7ax9YzGManWWiD4/XqPVetWxdb2Nh6NOIRoq+bTbydINzm7Lhoeu0mtXyU8JIuX/UlPsvGjygcpiZelR/xZ8A5VW3Ta39pc8XKLulMsYxowMUnYE74rZUQAzYQsAJzDl/w2k04YtRLE7ZYwVwylOC2UIZJtuCN6/a0mecHOfM16zdj17U03H917SsChXZvPVQWvlBrZP+gbuou8UXGPm25moPpxFRrlchoTXq23jeURx5/MpCY9uEjuhzvqWRcs3tRRWZJdbaXnZZtKF+11hpUgaHAVan4BTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=weilnetz.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR4rPwfycqJJaKiqSevQQKm01vLxFBgxzYpmHonG9lI=;
 b=lwInpYk0yc9gyQBBQMQACHLaRM3IAKaRNjVJHBdGBkfjoUUmm/4wF08iVMNNzbXWWJ9H+nBCiK3wv+U0KcgSKSww4RdC0owzBpBaLGARLv5lJujtWwe8Qny/P94o/tIaiwSZY/hHaQyzqfgZBumiD2+JPSICW2MOQG0mf7RMGbI=
Received: from MN2PR14CA0029.namprd14.prod.outlook.com (2603:10b6:208:23e::34)
 by CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 09:40:30 +0000
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23e:cafe::6) by MN2PR14CA0029.outlook.office365.com
 (2603:10b6:208:23e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Mon, 2 Mar 2020 09:40:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; weilnetz.de; dkim=none (message not signed)
 header.d=none;weilnetz.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.14
 via Frontend Transport; Mon, 2 Mar 2020 09:40:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j8hYq-0006QX-Rm; Mon, 02 Mar 2020 01:40:28 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j8hYl-0003EP-Ng; Mon, 02 Mar 2020 01:40:23 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0229eJuI021068; 
 Mon, 2 Mar 2020 01:40:19 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j8hYg-00036n-Oa; Mon, 02 Mar 2020 01:40:18 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 06F0A13C036D; Mon,  2 Mar 2020 15:05:27 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Zhong <yang.zhong@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Gonglei <arei.gonglei@huawei.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: [PATCH 0/3] Make hcd-xhci independent of pci hooks
Date: Mon,  2 Mar 2020 15:05:21 +0530
Message-Id: <1583141724-6229-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(189003)(199004)(70206006)(70586007)(5660300002)(6266002)(2906002)(36756003)(110136005)(6636002)(7416002)(186003)(426003)(81166006)(8936002)(26005)(42186006)(2616005)(4326008)(356004)(81156014)(6666004)(4744005)(8676002)(336012)(478600001)(316002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR02MB6197; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7ca7f30-1ceb-4dc7-8ac2-08d7be8dbec1
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6197A5FB79B5459D788CBCC8CAE70@CH2PR02MB6197.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beivktJ/uKiqLAkRw1/OL9TCzRhV6wBXGlmIdoIdkV2ALpSgAds17jvzu0yGnKfLwYTle4DCxamBCFpcgUx3LXHtvxGsaEeT7ejrI288yiiE7Y/RaL9K1TvNhdDQUaMCVEcVTnCaJluf23LYkijcUG4N1786/p4cNy4kslhDo9QATPNlO7wrsTK6lzeB3iXu3vpHUfj2h1x86qj1rIpHDtKoELR0+YQauZcZmQYzYozI5eCj6jXocol/14jB1ZPkue0Heuo8D8B8Ku9N6MDSUOrwIHxUr1XpZydMMSAQfUk3RO78I9GWc8j9JDjOMNVjEhZ6If8FbbMQ5cUAgytklD4F8KYXGzr1Zgo8pM10KeEF/u5eNJhlA9CaEq175LZmVAueRLrOPq5Z6/xpMA37eSerSCAkm77D4LBPcPbQTAxYKdCXYYuamX15DhfRZB1YR212Eak1TBc5DnKFf2DYbiMmzrXfAIm8Y7hHWaHxtijXl2VS3RUryGtBDUbTiJgq
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 09:40:29.4494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ca7f30-1ceb-4dc7-8ac2-08d7be8dbec1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6197
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.55
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This patch series attempts to make 'hcd-xhci' an independent model so
it can be used by both pci and system-bus interface.

Regards,
Sai Pavan

Sai Pavan Boddu (3):
  usb/hcd-xhci: Make dma read/writes hooks pci free
  usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
  usb/hcd-xhci: Split pci wrapper for xhci base model

 hw/usb/Kconfig        |   6 ++
 hw/usb/Makefile.objs  |   1 +
 hw/usb/hcd-xhci-nec.c |   8 +-
 hw/usb/hcd-xhci-pci.c | 246 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci-pci.h |  47 ++++++++++
 hw/usb/hcd-xhci.c     | 230 ++++++++--------------------------------------
 hw/usb/hcd-xhci.h     |  17 ++--
 7 files changed, 351 insertions(+), 204 deletions(-)
 create mode 100644 hw/usb/hcd-xhci-pci.c
 create mode 100644 hw/usb/hcd-xhci-pci.h

-- 
2.7.4


