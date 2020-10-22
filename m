Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9565C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F30D221FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qlPw1cFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F30D221FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVZUR-000073-0U
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 08:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kVZSg-0006v8-QI
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 08:12:55 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com
 ([40.107.93.71]:28897 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kVZRY-000133-Uz
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 08:12:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0BbS6bx8SUVQgx5+19zf7amMaM78W7cbq1UOdbx7IFOgZT8XcYo7Dm31x9QC8yTki/kAmH27JKZuRNMGGrUUYRT97PNxD7ZwToqhCmbyCs5NXlxHfLCwvpBvovsC1/Esk2W1SeN273fdmmr1wAGyZbvUJpMfrjtkv/4NIe9eYtLqKT5JTpx2C8VmjqsXmC/qzXc5qgXnMwctrgG2rVzGmDVcmz5Emp9DqlADJ1EiwXdI6J4tLdfU4WnN8sOA53JyJds/jBCRO7gFtnEOpX4pWwx23k/I/sXizgiitlcuWWxn5gB6LqrypKmp1CIgJ9oBuXiBa//g17SzIE7yp0vLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjgeiTgbDfvzrGxWJTqV4qJL/0x1mLzxj5FRevztxoY=;
 b=migXg9O/1/iou7WQ3FV0l0LREzzx4QPpq9YZplmrQcVsd+LzargaDQvvw3ruIDSVcK+byVW1V6gwdfx6q0cMVyT1sdaE7JCJEGe9ddyN4YogtfyrSXx+D+hedV4d5nOn/TsKCVHcVrhlTyKzZZWLasUQLs8jRiLd9S/8bE8lml/WE6O8XzBqUoPp4XmEVA9n+5rbM7MhiDt5LFq75aB6yY06jhKRIQlycx/7m4v9AMUAcSkMSCkrnafnDi0VRymd/REt9M06YmBFvpe+dcC6ucQ+VZQdyU/hgU+BhSLUEviS/XodpxZA+ikFwTihmwlVpSa7JpZOndBvo/natqghtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjgeiTgbDfvzrGxWJTqV4qJL/0x1mLzxj5FRevztxoY=;
 b=qlPw1cFvwyonSiKofOjBpZnnOh4Fu9tNpJL8Huq1bQtsHwEi7h6ctm3Ae5NJodQGtfT0hwePokQwpthh/Gq6SFCNH3degKBs2/e1amNqLVidwvmWzO+alVWAW5Q6peHEZxlJGN6r3Vom45rIlOWhasjnEVHnvlmeCKMMUsig7fg=
Received: from DM3PR08CA0015.namprd08.prod.outlook.com (2603:10b6:0:52::25) by
 SN1PR02MB3728.namprd02.prod.outlook.com (2603:10b6:802:31::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Thu, 22 Oct 2020 12:11:41 +0000
Received: from CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::5b) by DM3PR08CA0015.outlook.office365.com
 (2603:10b6:0:52::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25 via Frontend
 Transport; Thu, 22 Oct 2020 12:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT062.mail.protection.outlook.com (10.152.75.60) with Microsoft SMTP
 Server id 15.20.3499.20 via Frontend Transport; Thu, 22 Oct 2020 12:11:41
 +0000
Received: from [149.199.38.66] (port=56479 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kVZQY-0001kA-NQ; Thu, 22 Oct 2020 05:10:42 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kVZRU-0005qN-DQ; Thu, 22 Oct 2020 05:11:40 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 09MCBdZB022859; 
 Thu, 22 Oct 2020 05:11:39 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kVZRS-0005pp-Ss; Thu, 22 Oct 2020 05:11:39 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 3302013C0913; Thu, 22 Oct 2020 17:47:51 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v12 0/3] Add Versal usb model
Date: Thu, 22 Oct 2020 17:47:33 +0530
Message-Id: <1603369056-4168-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 471c7c80-b190-4678-f18d-08d87683a278
X-MS-TrafficTypeDiagnostic: SN1PR02MB3728:
X-Microsoft-Antispam-PRVS: <SN1PR02MB37285F08FDA7A04F310D1299CA1D0@SN1PR02MB3728.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJndr3ZpZaq6R1PYjdRFuh/LF4VT2JdUO8IXT1aUvJw9dcQ0BVnSP7EDoAtqFtvWUCGW+Mf/rbkNpiWicXXG7jLRAvQHrqVEjrsIyMl6UG5Wa2PdIwP4OGSflxMop10NfDGadlqT+JT1xohp9qfN1JILEB+oW6fOwiegh0MPj8UrkQz6ffmBN+WV0joSjrobjDlgTu1VDww8YRllTzPL7o14DEAPlmRDRDZchCgBQ3E8BTkZHKxhlpQBPCTEBqm+zGxpzC2Wn6Yqc2UbVdOu1UxbZNPzMBOXAKo23yvqSuZ6TsuBGfLaIMDjyMbG7Ajo4pvcBe2dNYDmB1FZ/d8vdWYoA8ldsOmVSe18Vmuv1OYO4Y4kbvdaoOla+9hOEh083c37DpYjxtw34FgCayifDQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(39860400002)(136003)(376002)(396003)(346002)(46966005)(2616005)(47076004)(426003)(107886003)(7416002)(478600001)(356005)(82740400003)(6266002)(36756003)(2906002)(26005)(186003)(83380400001)(82310400003)(70206006)(54906003)(81166007)(336012)(4326008)(6636002)(8676002)(110136005)(316002)(42186006)(70586007)(6666004)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 12:11:41.1398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471c7c80-b190-4678-f18d-08d87683a278
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3728
Received-SPF: pass client-ip=40.107.93.71; envelope-from=saipava@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:11:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) AC_FROM_MANY_DOTS=2.478, BAYES_00=-1.9,
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

This patch series attempts to make 'hcd-xhci' an independent model so it can be used by both pci and system-bus interface.

Changes for V2:
    Make XHCIState non-qom
    Use container_of functions for retriving pci device instance
    Initialize the AddressSpace pointer in PATCH 1/3 itself Changes for V3:
    Convert XHCIState to TYPE_DEVICE and register as a child of XHCIPciState.
Changes for V4:
    Add DWC3 usb controller
    Add versal, usb2-reg module
    Connect sysbus xhci to versal virt board Changes for V5:
    Add extra info about dwc3 and usb2_regs devices in commit messages
    Use only one irq for versal usb controller
    Mark the unimplemented registers in dwc3 controller
    Rebase the patches over master.
    Move few mispalced contents from patch 2/7 to 3/7.
    Fix the author names in the header.
    Move the inclusion of "sysemu/dma.h" from patch 1/7 to 3/7 Changes for V6:
    Fixed style issue in patch 7/7
    Renamed usb2_reg model to VersalUsb2CtrlReg
    Fixed author in headers
Changes for V7:
    Create a usb structure to keep things clean
    Remove the repeated patch in the series i.e 5/7 Changes for V8:
    Fix vmstate sturcts to support cross version migration.
Changes for V9:
    Added recommended changes to fix vmstate migration.
    Fixed commit message on 3/7.
Changes for V10:
    use vmstate_post_load avaialble in VMStateDescription
    tested vmstate cross migration.
Changes for V11:
    Removed the patches which got accepted
    Changed object name "USB2Reg" -> "ctrl"
    Updated Subject line on cover letter.
Changes for V12:
    Use reset class for usb2-ctrl-regs module
    Move the few register update to realize
    Marked registers which are unimplemented in regapi model


Sai Pavan Boddu (1):
  misc: Add versal-usb2-ctrl-regs module

Vikram Garhwal (2):
  usb: Add DWC3 model
  Versal: Connect DWC3 controller with virt-versal

 hw/arm/xlnx-versal-virt.c                    |  58 +++
 hw/arm/xlnx-versal.c                         |  34 ++
 hw/misc/meson.build                          |   1 +
 hw/misc/xlnx-versal-usb2-ctrl-regs.c         | 229 +++++++++
 hw/usb/Kconfig                               |   6 +
 hw/usb/hcd-dwc3.c                            | 666 +++++++++++++++++++++++++++
 hw/usb/meson.build                           |   1 +
 include/hw/arm/xlnx-versal.h                 |  14 +
 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h |  45 ++
 include/hw/usb/hcd-dwc3.h                    |  55 +++
 10 files changed, 1109 insertions(+)
 create mode 100644 hw/misc/xlnx-versal-usb2-ctrl-regs.c
 create mode 100644 hw/usb/hcd-dwc3.c
 create mode 100644 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h
 create mode 100644 include/hw/usb/hcd-dwc3.h

-- 
2.7.4


