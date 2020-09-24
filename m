Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC73FC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C4B22208
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iYV9oPvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C4B22208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSAN-0000Y3-3f
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kLS4g-0004GG-Ey
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:18:18 -0400
Received: from mail-dm6nam11on2058.outbound.protection.outlook.com
 ([40.107.223.58]:56417 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kLS4e-0002Tx-E2
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:18:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcKDrPhO0uPHeodnxqw17+pjcQsvLndkK2ZhQHdoUnXU8rBwz2s971U9bHWHtT+4MRoZ8JXHP3tqHLsewEpmxz4v1QmPpB9mtpKadDt69wCPoKTGZeN6vqWb3VnGRVRier2dZgBpOwYZ7pwyoKAMl2NnBKox5xBEVEX9HUcGl2LK8WOUP5ZmG4I7Mu0sPOirGzERaKO/Y5feV+T/tmzlTmdTVPg60gdkykRe3TXvLB/nPHMW6YVIS/IbXM3Q05yWwDQCs57YjHq43/WgWZRWRzwvOiUvDiDwoukPpR12vKBQ224ZWDz5bk9M5yo0CfnPsW8Aq6cOrcTeik/PW6Z4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaRP7nlFrXj/OIrfa4B2+nVGQNuw+BaggXHU6Zn34T0=;
 b=C4vrV1axDUE2+4OZbHM8+akVlyIlqKPy5kwt8xvClEORyTS/fDPmfQkkqEFx6hsDbXlG1bkdQcgQrN3XJUwvJIN6fFEkoe9yRyVRoDnmAlpVgzjYA52FFDDpno6hVewIFZJMl9zyb3lsAHET6rYUqlyp4i4rTPgw3iJI/fHBzKWUxSvUfKz0Lj14HId71PXjss9j3Srh967wAjsX1yCSOvPx33AtB2mChT0hfxsrKYwuE2jysebNBEgEkV5gtlVfMvD6CW1maIZljFeJGBp79R79d04JKmP4ApB0GQryfzfAvUTmlNsfa1h4oS5Fr7nn9g4Dts3Fwa7qpEGK6rUSXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaRP7nlFrXj/OIrfa4B2+nVGQNuw+BaggXHU6Zn34T0=;
 b=iYV9oPvDyqnVrL/Yo2EPPVLyictNAaohzkJ5/dXDSuVu5L1YraIt1TTjt3WFHpB0wfVAXvc4npJWkYC+MDg0ZL9jwsLbCSYMqy1WjEKCcIlsqnPVqdAuXkgZaBR7jjrL/YQG2yiBtj7sfqMl1OwSV0tplsGxgoKhCyrHck+B9gY=
Received: from SN6PR08CA0014.namprd08.prod.outlook.com (2603:10b6:805:66::27)
 by MN2PR02MB7072.namprd02.prod.outlook.com (2603:10b6:208:202::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 14:17:41 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::4d) by SN6PR08CA0014.outlook.office365.com
 (2603:10b6:805:66::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 24 Sep 2020 14:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 14:17:41
 +0000
Received: from [149.199.38.66] (port=46123 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kLS3n-0005YU-RA; Thu, 24 Sep 2020 07:17:23 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kLS44-0007Sz-P6; Thu, 24 Sep 2020 07:17:40 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08OEHduI011625; 
 Thu, 24 Sep 2020 07:17:39 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kLS43-0007SN-AO; Thu, 24 Sep 2020 07:17:39 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id C7C3E13C0587; Thu, 24 Sep 2020 19:51:00 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v10 0/7] Make hcd-xhci independent of pci hooks
Date: Thu, 24 Sep 2020 19:50:49 +0530
Message-Id: <1600957256-6494-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5fad9547-bba8-4fbc-351a-08d8609498ff
X-MS-TrafficTypeDiagnostic: MN2PR02MB7072:
X-Microsoft-Antispam-PRVS: <MN2PR02MB70725C18E84AD18FE81475E6CA390@MN2PR02MB7072.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACMi2VUocY1P7kPxJ8vktWB9jFn8yctx05Z0qJNTHX3QxDa+/NWQF1EbsKBZlEJH/qEDwvSI+EnvmaZD8r5kb2k3e6vz3qdTgz0a1u/pU/joyoz5Y/rCS3fm5gtaoBvmM02bsLfResYz1umR21xOh99+VuP5PlIk45naqMLX1zfePHcQHyFcINHMwsOWiRSm3b4ygTUsqhUJBctojtWtdXAHEsz+3Mhbr0KXynhFvvcBvaecDsVkQY3dqflTJl3aPSuASDacOF6KVgw1JUMtgOC392GaHSRyQ0hk0FRLkdxHDH8juP4fpo8074PahyF3LTBoxyPbn4X95iqmAyyig1uMAR0iBpT3M1/AnMakaGoBAOLYY/EYu3mm4bgac724vyrDJztwS11VKST/4sfV2kgHQEhPPHrLe+LdUatdAmDzf9Qr84hfeU38kVqGzYx+
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(136003)(376002)(346002)(39860400002)(46966005)(107886003)(4326008)(82740400003)(8676002)(47076004)(478600001)(36756003)(54906003)(82310400003)(6636002)(81166007)(6266002)(2616005)(110136005)(42186006)(316002)(6666004)(356005)(26005)(186003)(83380400001)(5660300002)(7416002)(336012)(70586007)(8936002)(2906002)(70206006)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 14:17:41.1093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fad9547-bba8-4fbc-351a-08d8609498ff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7072
Received-SPF: pass client-ip=40.107.223.58; envelope-from=saipava@xilinx.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 10:18:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) AC_FROM_MANY_DOTS=2.093, BAYES_00=-1.9,
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
 qemu-devel@nongnu.org, Paul Zimmerman <pauldzim@gmail.com>,
 Sai Pavan Boddu <saipava@xilinx.com>,
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
Changes for V5:
    Add extra info about dwc3 and usb2_regs devices in commit messages
    Use only one irq for versal usb controller
    Mark the unimplemented registers in dwc3 controller
    Rebase the patches over master.
    Move few mispalced contents from patch 2/7 to 3/7.
    Fix the author names in the header.
    Move the inclusion of "sysemu/dma.h" from patch 1/7 to 3/7
Changes for V6:
    Fixed style issue in patch 7/7
    Renamed usb2_reg model to VersalUsb2CtrlReg
    Fixed author in headers
Changes for V7:
    Create a usb structure to keep things clean
    Remove the repeated patch in the series i.e 5/7
Changes for V8:
    Fix vmstate sturcts to support cross version migration.
Changes for V9:
    Added recommended changes to fix vmstate migration.
    Fixed commit message on 3/7.
Changes for V10:
    use vmstate_post_load avaialble in VMStateDescription
    tested vmstate cross migration.

Sai Pavan Boddu (5):
  usb/hcd-xhci: Make dma read/writes hooks pci free
  usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
  usb/hcd-xhci: Split pci wrapper for xhci base model
  usb: hcd-xhci-sysbus: Attach xhci to sysbus device
  misc: Add versal-usb2-ctrl-regs module

Vikram Garhwal (2):
  usb: Add DWC3 model
  Versal: Connect DWC3 controller with virt-versal

 hw/arm/xlnx-versal-virt.c                    |  58 +++
 hw/arm/xlnx-versal.c                         |  34 ++
 hw/misc/meson.build                          |   1 +
 hw/misc/xlnx-versal-usb2-ctrl-regs.c         | 222 +++++++++
 hw/usb/Kconfig                               |  17 +
 hw/usb/hcd-dwc3.c                            | 717 +++++++++++++++++++++++++++
 hw/usb/hcd-xhci-nec.c                        |  18 +-
 hw/usb/hcd-xhci-pci.c                        | 261 ++++++++++
 hw/usb/hcd-xhci-pci.h                        |  44 ++
 hw/usb/hcd-xhci-sysbus.c                     | 109 ++++
 hw/usb/hcd-xhci-sysbus.h                     |  32 ++
 hw/usb/hcd-xhci.c                            | 269 ++--------
 hw/usb/hcd-xhci.h                            |  21 +-
 hw/usb/meson.build                           |   3 +
 include/hw/arm/xlnx-versal.h                 |  14 +
 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h |  45 ++
 include/hw/usb/hcd-dwc3.h                    |  55 ++
 17 files changed, 1689 insertions(+), 231 deletions(-)
 create mode 100644 hw/misc/xlnx-versal-usb2-ctrl-regs.c
 create mode 100644 hw/usb/hcd-dwc3.c
 create mode 100644 hw/usb/hcd-xhci-pci.c
 create mode 100644 hw/usb/hcd-xhci-pci.h
 create mode 100644 hw/usb/hcd-xhci-sysbus.c
 create mode 100644 hw/usb/hcd-xhci-sysbus.h
 create mode 100644 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h
 create mode 100644 include/hw/usb/hcd-dwc3.h

-- 
2.7.4


