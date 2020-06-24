Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE09C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A966320781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="S+Jio00Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A966320781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6bO-00078z-Ut
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jo6ai-0006Hw-1N
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:41:32 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com
 ([40.107.237.48]:19808 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jo6af-0000se-GQ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:41:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn/0buRPgb3OnNS4luNIzhqGPgMCdUYB+F2tmw/XHxFsSEhw6teW/1eQz2nVX7SNA79X9m6HdZbLtDP0RKT3cZfbvU5CoN4lvWFwtDHpa3moXalePHsQ3iEE78esvtGUhexW8sKt1PqwSz8gCyga1YTEv6Dz12M1BGKcTNejtXHlLfzFY1qlIqITzAFQ+DHs+S2daQzZ0QwqRgsGqxgoU8q9JoEDkBYC4882PCMQOIMr9eZDZizhI+l56o4dAHVW1iH18Sn+7LGujiKCSZNgj4JIsALU6Dnr2nCTtonj9b5SGNgw+e0qyP5ktYSL9Jvn4nI1wEfyJWql91v97yZaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/4zPVtPX7SosYl5zfUSOucHWRsUXeJkTwGCi7QfqhM=;
 b=dTCNjRvMga07ognRsLC1Xv3dNHPaXhTNGk0i40Tmz9vDcpE5cbPV3kMrwBLxoyLa2fUxxIvSAxCts6a3nhSSsSDb63EuhXruaZ/f8tq1Jgnjqb8nHtHR4vqZ/OjdyYb8WUdT5kiyTHgZUS2v814JI1BIDS3EzSQHoPuul/bZJ5Jc6TD255GI1pv/T5nwvQHA/nPIf+dnbbnYGn9O2mxnOeVXWcz0tcdJ2kaYhjZ0a4QupUhq/FtSKPYnLWHlVsyIvAHcWCCvkZFpvLv1c8Kpj9B/Df/GOWaJJ6HWqLUopVzN9/psok5aGale8yPwgVsPvOakvf2eWtDETFHETp0oqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/4zPVtPX7SosYl5zfUSOucHWRsUXeJkTwGCi7QfqhM=;
 b=S+Jio00ZtwGVxbXly4ZWRaMs25+fwpQJWkkYnESap3kb+OVmmJyhvBtZtVDMBCDMXFeuKYavy8PTqmhveiNocsxMz0C3zv87d8srHgj06pZgedpfXVtTgm2cuGnpPTtDhxwLYnyPYltIyyU5/5UT9QlF2s6zpwkJrIp6+QZ98i0=
Received: from MN2PR20CA0044.namprd20.prod.outlook.com (2603:10b6:208:235::13)
 by DM6PR02MB5259.namprd02.prod.outlook.com (2603:10b6:5:43::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.25; Wed, 24 Jun
 2020 14:26:24 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:235:cafe::8a) by MN2PR20CA0044.outlook.office365.com
 (2603:10b6:208:235::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Wed, 24 Jun 2020 14:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 14:26:23
 +0000
Received: from [149.199.38.66] (port=43395 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jo6Kr-0001Yn-LF; Wed, 24 Jun 2020 07:25:09 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jo6M3-0000K8-JA; Wed, 24 Jun 2020 07:26:23 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05OEQMNa017892; 
 Wed, 24 Jun 2020 07:26:22 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jo6M2-0000Ja-5M; Wed, 24 Jun 2020 07:26:22 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id F0BD513C6068; Wed, 24 Jun 2020 19:46:19 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/3] Make hcd-xhci independent of pci hooks
Date: Wed, 24 Jun 2020 19:46:13 +0530
Message-Id: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(396003)(136003)(376002)(346002)(46966005)(5660300002)(4744005)(2906002)(83380400001)(47076004)(82740400003)(70206006)(70586007)(36756003)(2616005)(478600001)(82310400002)(7416002)(110136005)(6266002)(186003)(26005)(8936002)(81166007)(356005)(316002)(42186006)(336012)(54906003)(6666004)(4326008)(426003)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7dfba88a-5698-4a2b-fffa-08d8184a92a6
X-MS-TrafficTypeDiagnostic: DM6PR02MB5259:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5259880FB118E0F62D1DC5BDCA950@DM6PR02MB5259.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JhXvyy5YWYhAgr0K5US1VZ+hqbjEiZbwmHM3FsqMai9PAgoBdUUaetOohhZETsvb4vMqXp/KQWoQxN2oo/4yKz1NsO+JtTjnbKVc5f7dEkn15HMSXRlePKwzlV7uWSEx0pHFNhI8hEZPchtTSX3vGFABv+0oKucRQiVkFXy+WfRhf5jVLCSHPumqA+D0nUlAfp7wZv8hlKAu0jc01mXj4RSDufb1MxBaoetPbOLrd7UfGyEClkH9OGZJtEZS/XeYToQ9qkT0x3+D9NUFgm8VGy5iwQAPU8PD8fLQeKEQTHdltNrixpbFCwyUG35s+FqmwpPfJgAk2MclS0m0eH5CgEpiS/NbFM8CxdYUyw2sGvETRC7p1aKL3Ac+ZIXdvAFjOSq9yMc3+8Ltr3bM8orMA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 14:26:23.9835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfba88a-5698-4a2b-fffa-08d8184a92a6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5259
Received-SPF: pass client-ip=40.107.237.48; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 10:41:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) AC_FROM_MANY_DOTS=1, BAYES_00=-1.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

This patch series attempts to make 'hcd-xhci' an independent model so
it can be used by both pci and system-bus interface.

Sorry for the late followup, below are the changes for V2

V2:
    Make XHCIState non-qom
    Use container_of functions for retriving pci device instance
    Initialize the AddressSpace pointer in PATCH 1/3 itself

Sai Pavan Boddu (3):
  usb/hcd-xhci: Make dma read/writes hooks pci free
  usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
  usb/hcd-xhci: Split pci wrapper for xhci base model

 hw/usb/Kconfig        |   6 ++
 hw/usb/Makefile.objs  |   1 +
 hw/usb/hcd-xhci-nec.c |  14 +--
 hw/usb/hcd-xhci-pci.c | 246 +++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci-pci.h |  47 +++++++++
 hw/usb/hcd-xhci.c     | 287 ++++++++------------------------------------------
 hw/usb/hcd-xhci.h     |  30 +++---
 7 files changed, 369 insertions(+), 262 deletions(-)
 create mode 100644 hw/usb/hcd-xhci-pci.c
 create mode 100644 hw/usb/hcd-xhci-pci.h

-- 
2.7.4


