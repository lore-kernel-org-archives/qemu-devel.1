Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2AAC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34140208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nqbopIUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34140208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGd6-00052z-Vh
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kNGZx-000270-7A
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:26:05 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com
 ([40.107.220.52]:51676 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kNGZs-0008IC-GM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:26:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzjOzCFkeWMJvbxKf2oKuE0ZUZPF5qMG2ulJmPxgwzhpt0jcbJkstgjY72TEkQi5BN5NXtlI9Y6jvRyu2UgczYG3HarWkxeR3hiHO/Ba1bMKQPBcy9oEnzJM7jfJUVziDjNMDK6uWckrceZvbFtZFUJAMz9XhBcmEAky/ka117Wd+yqrftR9P9Z4kIK79VjKb57qUAhA8RCVYdoMwR6ZlM4yLCNNN7wmVuusClk1kiAHMIQ6Vn9sv7nOV+NO5yczca3sz6bN+9exgigZNdFFrYu3yqBiS8jI5H7cH8JmRlxzMGizqv2UMb8yQ8Byvkz+9F+PicL4on8dylHACI5xEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AaZoOZfSpthKFtZooWbfTlnGf/BVP8RL51fFz4viWU=;
 b=f9wmEdeFhMv3CCRnIsCYIqzzFngenSe+OgC2Vl1oFiBT6m3y5siHqLuiU+v6PCKznKu3YBJRwRhhMWjZBf43Dhk0gL87mu5JH/RKGNPAAzcxBpHynuJFZgQOULlALiUoOuIExLTXRTOWG+Uo+FtK+ujl4+Irngxq0Tkj04T0F1f3pV2iFiw6iqPStVupaCSKlV9vyZFM6aAQVK/dTQBJ2DpSJX242I2VA7+h2dl0OpeNB0W4N2UNrC4BJ94RMnI3K+w9CO33OA0nfH5B0I6qNK5qNxvvtBzpAIj4nw5W8NHpmMgHSGhaBg5wAqjr1tXUkHe6YeryJ7i+2Zq2hJXGjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AaZoOZfSpthKFtZooWbfTlnGf/BVP8RL51fFz4viWU=;
 b=nqbopIUphxI0zgx4mCo60fCUjtykqWKpwd4voD995TsrWtnMoi5RIWNRpuoGziumI1engPNc7VuY8GJUCyWZdFUoNvo2z7WnBHcCQhDQhvj1EmH/5pxAlXI8iProuv4G8atHrr9wCWm4yGaO/O9rpH/vEOjnuLGQMg/g5LgCHEw=
Received: from MN2PR22CA0008.namprd22.prod.outlook.com (2603:10b6:208:238::13)
 by DM6PR02MB6557.namprd02.prod.outlook.com (2603:10b6:5:1be::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Tue, 29 Sep
 2020 14:25:56 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:238:cafe::85) by MN2PR22CA0008.outlook.office365.com
 (2603:10b6:208:238::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Tue, 29 Sep 2020 14:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 14:25:56
 +0000
Received: from [149.199.38.66] (port=48762 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kNGZO-000600-Jt; Tue, 29 Sep 2020 07:25:30 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kNGZn-0000P7-2D; Tue, 29 Sep 2020 07:25:55 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08TEPmr3020798; 
 Tue, 29 Sep 2020 07:25:48 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kNGZf-0000Lv-MU; Tue, 29 Sep 2020 07:25:48 -0700
Date: Tue, 29 Sep 2020 16:25:47 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v11 2/3] usb: Add DWC3 model
Message-ID: <20200929142547.GP17122@toto>
References: <1601376942-9648-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1601376942-9648-3-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601376942-9648-3-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55853768-d312-464d-60ae-08d864839457
X-MS-TrafficTypeDiagnostic: DM6PR02MB6557:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6557A3E18237EA74DD10FB64C2320@DM6PR02MB6557.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:293;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GkTUDG0gfO03wI6uVj4KgJR9g0JeMwIMbNaTgK9aovrM7VXd9cPujFaD0OLYah/geaau0PnX2wuS4Vroy16vlr9RHGOxwWyvxxn+3PNJQdNqJkVNJwIyJZPHyGRbmQVE+Ku3HCq59KsZe0MQiHh3ff+iWQ17bNvWxdCy3fvL2/QJkfzzzEVSsO/4UaYGAQqGeAB1acNp31RJiSVXYxLRHfwHgHZc8/kts52rdfFRY8xnPBuLlATVA/3M4ASna5l5CwxFU7PY9RrP+vq9uldmdRFFRjra7KxFwBQGSnholSRErTT2anJFKGmCTuDLZhfBK0T7g1jyEndX0JsbZmQ8dQWENJYhlh0a8NWL76xZ15SvRFNvEdrKq9Z9lygsSa+8WfkwYuEVA3XEKUj/kvwnHdzFDCMUEHR6uRivOhfLh6EFxlMP78do8dI/6goCCLwmbHec3KXqsWWkh5QDVzKnlw==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(46966005)(54906003)(9786002)(8936002)(83380400001)(336012)(5660300002)(426003)(7416002)(47076004)(33716001)(30864003)(9686003)(26005)(6862004)(6636002)(2906002)(1076003)(186003)(70206006)(70586007)(8676002)(107886003)(356005)(33656002)(4326008)(81166007)(498600001)(82310400003)(21314003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 14:25:56.5032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55853768-d312-464d-60ae-08d864839457
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6557
Received-SPF: pass client-ip=40.107.220.52; envelope-from=edgar@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 10:25:58
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?'Marc-Andr=E9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 'Philippe =?iso-8859-1?Q?Mathieu-Daud=E9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 04:25:41PM +0530, Sai Pavan Boddu wrote:
> From: Vikram Garhwal <fnu.vikram@xilinx.com>
> 
> This patch adds skeleton model of dwc3 usb controller attached to
> xhci-sysbus device. It defines global register space of DWC3 controller,
> global registers control the AXI/AHB interfaces properties, external FIFO
> support and event count support. All of which are unimplemented at
> present,we are only supporting core reset and read of ID register.
> 
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/usb/Kconfig            |   6 +
>  hw/usb/hcd-dwc3.c         | 717 ++++++++++++++++++++++++++++++++++++++++++++++
>  hw/usb/meson.build        |   1 +
>  include/hw/usb/hcd-dwc3.h |  55 ++++
>  4 files changed, 779 insertions(+)
>  create mode 100644 hw/usb/hcd-dwc3.c
>  create mode 100644 include/hw/usb/hcd-dwc3.h
> 
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index 4dd2ba9..f5762f0 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -116,3 +116,9 @@ config IMX_USBPHY
>      bool
>      default y
>      depends on USB
> +
> +config USB_DWC3
> +    bool
> +    default y if USB_XHCI_SYSBUS
> +    select USB
> +    select REGISTER
> diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
> new file mode 100644
> index 0000000..de8be7a
> --- /dev/null
> +++ b/hw/usb/hcd-dwc3.c
> @@ -0,0 +1,717 @@
> +/*
> + * QEMU model of the USB DWC3 host controller emulation.
> + *
> + * This model defines global register space of DWC3 controller. Global
> + * registers control the AXI/AHB interfaces properties, external FIFO support
> + * and event count support. All of which are unimplemented at present. We are
> + * only supporting core reset and read of ID register.
> + *
> + * Copyright (c) 2020 Xilinx Inc. Vikram Garhwal<fnu.vikram@xilinx.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "hw/register.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qom/object.h"
> +#include "migration/vmstate.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/usb/hcd-dwc3.h"
> +#include "qapi/error.h"
> +
> +#ifndef USB_DWC3_ERR_DEBUG
> +#define USB_DWC3_ERR_DEBUG 0
> +#endif
> +
> +#define HOST_MODE           1
> +#define FIFO_LEN         0x1000
> +
> +REG32(GSBUSCFG0, 0x00)
> +    FIELD(GSBUSCFG0, DATRDREQINFO, 28, 4)
> +    FIELD(GSBUSCFG0, DESRDREQINFO, 24, 4)
> +    FIELD(GSBUSCFG0, DATWRREQINFO, 20, 4)
> +    FIELD(GSBUSCFG0, DESWRREQINFO, 16, 4)
> +    FIELD(GSBUSCFG0, RESERVED_15_12, 12, 4)
> +    FIELD(GSBUSCFG0, DATBIGEND, 11, 1)
> +    FIELD(GSBUSCFG0, DESBIGEND, 10, 1)
> +    FIELD(GSBUSCFG0, RESERVED_9_8, 8, 2)
> +    FIELD(GSBUSCFG0, INCR256BRSTENA, 7, 1)
> +    FIELD(GSBUSCFG0, INCR128BRSTENA, 6, 1)
> +    FIELD(GSBUSCFG0, INCR64BRSTENA, 5, 1)
> +    FIELD(GSBUSCFG0, INCR32BRSTENA, 4, 1)
> +    FIELD(GSBUSCFG0, INCR16BRSTENA, 3, 1)
> +    FIELD(GSBUSCFG0, INCR8BRSTENA, 2, 1)
> +    FIELD(GSBUSCFG0, INCR4BRSTENA, 1, 1)
> +    FIELD(GSBUSCFG0, INCRBRSTENA, 0, 1)
> +REG32(GSBUSCFG1, 0x04)
> +    FIELD(GSBUSCFG1, RESERVED_31_13, 13, 19)
> +    FIELD(GSBUSCFG1, EN1KPAGE, 12, 1)
> +    FIELD(GSBUSCFG1, PIPETRANSLIMIT, 8, 4)
> +    FIELD(GSBUSCFG1, RESERVED_7_0, 0, 8)
> +REG32(GTXTHRCFG, 0x08)
> +    FIELD(GTXTHRCFG, RESERVED_31, 31, 1)
> +    FIELD(GTXTHRCFG, RESERVED_30, 30, 1)
> +    FIELD(GTXTHRCFG, USBTXPKTCNTSEL, 29, 1)
> +    FIELD(GTXTHRCFG, RESERVED_28, 28, 1)
> +    FIELD(GTXTHRCFG, USBTXPKTCNT, 24, 4)
> +    FIELD(GTXTHRCFG, USBMAXTXBURSTSIZE, 16, 8)
> +    FIELD(GTXTHRCFG, RESERVED_15, 15, 1)
> +    FIELD(GTXTHRCFG, RESERVED_14, 14, 1)
> +    FIELD(GTXTHRCFG, RESERVED_13_11, 11, 3)
> +    FIELD(GTXTHRCFG, RESERVED_10_0, 0, 11)
> +REG32(GRXTHRCFG, 0x0c)
> +    FIELD(GRXTHRCFG, RESERVED_31_30, 30, 2)
> +    FIELD(GRXTHRCFG, USBRXPKTCNTSEL, 29, 1)
> +    FIELD(GRXTHRCFG, RESERVED_28, 28, 1)
> +    FIELD(GRXTHRCFG, USBRXPKTCNT, 24, 4)
> +    FIELD(GRXTHRCFG, USBMAXRXBURSTSIZE, 19, 5)
> +    FIELD(GRXTHRCFG, RESERVED_18_16, 16, 3)
> +    FIELD(GRXTHRCFG, RESERVED_15, 15, 1)
> +    FIELD(GRXTHRCFG, RESERVED_14_13, 13, 2)
> +    FIELD(GRXTHRCFG, RESVISOCOUTSPC, 0, 13)
> +REG32(GCTL, 0x10)
> +    FIELD(GCTL, PWRDNSCALE, 19, 13)
> +    FIELD(GCTL, MASTERFILTBYPASS, 18, 1)
> +    FIELD(GCTL, BYPSSETADDR, 17, 1)
> +    FIELD(GCTL, U2RSTECN, 16, 1)
> +    FIELD(GCTL, FRMSCLDWN, 14, 2)
> +    FIELD(GCTL, PRTCAPDIR, 12, 2)
> +    FIELD(GCTL, CORESOFTRESET, 11, 1)
> +    FIELD(GCTL, U1U2TIMERSCALE, 9, 1)
> +    FIELD(GCTL, DEBUGATTACH, 8, 1)
> +    FIELD(GCTL, RAMCLKSEL, 6, 2)
> +    FIELD(GCTL, SCALEDOWN, 4, 2)
> +    FIELD(GCTL, DISSCRAMBLE, 3, 1)
> +    FIELD(GCTL, U2EXIT_LFPS, 2, 1)
> +    FIELD(GCTL, GBLHIBERNATIONEN, 1, 1)
> +    FIELD(GCTL, DSBLCLKGTNG, 0, 1)
> +REG32(GPMSTS, 0x14)
> +REG32(GSTS, 0x18)
> +    FIELD(GSTS, CBELT, 20, 12)
> +    FIELD(GSTS, RESERVED_19_12, 12, 8)
> +    FIELD(GSTS, SSIC_IP, 11, 1)
> +    FIELD(GSTS, OTG_IP, 10, 1)
> +    FIELD(GSTS, BC_IP, 9, 1)
> +    FIELD(GSTS, ADP_IP, 8, 1)
> +    FIELD(GSTS, HOST_IP, 7, 1)
> +    FIELD(GSTS, DEVICE_IP, 6, 1)
> +    FIELD(GSTS, CSRTIMEOUT, 5, 1)
> +    FIELD(GSTS, BUSERRADDRVLD, 4, 1)
> +    FIELD(GSTS, RESERVED_3_2, 2, 2)
> +    FIELD(GSTS, CURMOD, 0, 2)
> +REG32(GUCTL1, 0x1c)
> +    FIELD(GUCTL1, RESUME_OPMODE_HS_HOST, 10, 1)
> +REG32(GSNPSID, 0x20)
> +REG32(GGPIO, 0x24)
> +    FIELD(GGPIO, GPO, 16, 16)
> +    FIELD(GGPIO, GPI, 0, 16)
> +REG32(GUID, 0x28)
> +REG32(GUCTL, 0x2c)
> +    FIELD(GUCTL, REFCLKPER, 22, 10)
> +    FIELD(GUCTL, NOEXTRDL, 21, 1)
> +    FIELD(GUCTL, RESERVED_20_18, 18, 3)
> +    FIELD(GUCTL, SPRSCTRLTRANSEN, 17, 1)
> +    FIELD(GUCTL, RESBWHSEPS, 16, 1)
> +    FIELD(GUCTL, RESERVED_15, 15, 1)
> +    FIELD(GUCTL, USBHSTINAUTORETRYEN, 14, 1)
> +    FIELD(GUCTL, ENOVERLAPCHK, 13, 1)
> +    FIELD(GUCTL, EXTCAPSUPPTEN, 12, 1)
> +    FIELD(GUCTL, INSRTEXTRFSBODI, 11, 1)
> +    FIELD(GUCTL, DTCT, 9, 2)
> +    FIELD(GUCTL, DTFT, 0, 9)
> +REG32(GBUSERRADDRLO, 0x30)
> +REG32(GBUSERRADDRHI, 0x34)
> +REG32(GHWPARAMS0, 0x40)
> +    FIELD(GHWPARAMS0, GHWPARAMS0_31_24, 24, 8)
> +    FIELD(GHWPARAMS0, GHWPARAMS0_23_16, 16, 8)
> +    FIELD(GHWPARAMS0, GHWPARAMS0_15_8, 8, 8)
> +    FIELD(GHWPARAMS0, GHWPARAMS0_7_6, 6, 2)
> +    FIELD(GHWPARAMS0, GHWPARAMS0_5_3, 3, 3)
> +    FIELD(GHWPARAMS0, GHWPARAMS0_2_0, 0, 3)
> +REG32(GHWPARAMS1, 0x44)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_31, 31, 1)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_30, 30, 1)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_29, 29, 1)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_28, 28, 1)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_27, 27, 1)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_26, 26, 1)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_25_24, 24, 2)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_23, 23, 1)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_22_21, 21, 2)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_20_15, 15, 6)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_14_12, 12, 3)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_11_9, 9, 3)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_8_6, 6, 3)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_5_3, 3, 3)
> +    FIELD(GHWPARAMS1, GHWPARAMS1_2_0, 0, 3)
> +REG32(GHWPARAMS2, 0x48)
> +REG32(GHWPARAMS3, 0x4c)
> +    FIELD(GHWPARAMS3, GHWPARAMS3_31, 31, 1)
> +    FIELD(GHWPARAMS3, GHWPARAMS3_30_23, 23, 8)
> +    FIELD(GHWPARAMS3, GHWPARAMS3_22_18, 18, 5)
> +    FIELD(GHWPARAMS3, GHWPARAMS3_17_12, 12, 6)
> +    FIELD(GHWPARAMS3, GHWPARAMS3_11, 11, 1)
> +    FIELD(GHWPARAMS3, GHWPARAMS3_10, 10, 1)
> +    FIELD(GHWPARAMS3, GHWPARAMS3_9_8, 8, 2)
> +    FIELD(GHWPARAMS3, GHWPARAMS3_7_6, 6, 2)
> +    FIELD(GHWPARAMS3, GHWPARAMS3_5_4, 4, 2)
> +    FIELD(GHWPARAMS3, GHWPARAMS3_3_2, 2, 2)
> +    FIELD(GHWPARAMS3, GHWPARAMS3_1_0, 0, 2)
> +REG32(GHWPARAMS4, 0x50)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_31_28, 28, 4)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_27_24, 24, 4)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_23, 23, 1)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_22, 22, 1)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_21, 21, 1)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_20_17, 17, 4)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_16_13, 13, 4)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_12, 12, 1)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_11, 11, 1)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_10_9, 9, 2)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_8_7, 7, 2)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_6, 6, 1)
> +    FIELD(GHWPARAMS4, GHWPARAMS4_5_0, 0, 6)
> +REG32(GHWPARAMS5, 0x54)
> +    FIELD(GHWPARAMS5, GHWPARAMS5_31_28, 28, 4)
> +    FIELD(GHWPARAMS5, GHWPARAMS5_27_22, 22, 6)
> +    FIELD(GHWPARAMS5, GHWPARAMS5_21_16, 16, 6)
> +    FIELD(GHWPARAMS5, GHWPARAMS5_15_10, 10, 6)
> +    FIELD(GHWPARAMS5, GHWPARAMS5_9_4, 4, 6)
> +    FIELD(GHWPARAMS5, GHWPARAMS5_3_0, 0, 4)
> +REG32(GHWPARAMS6, 0x58)
> +    FIELD(GHWPARAMS6, GHWPARAMS6_31_16, 16, 16)
> +    FIELD(GHWPARAMS6, BUSFLTRSSUPPORT, 15, 1)
> +    FIELD(GHWPARAMS6, BCSUPPORT, 14, 1)
> +    FIELD(GHWPARAMS6, OTG_SS_SUPPORT, 13, 1)
> +    FIELD(GHWPARAMS6, ADPSUPPORT, 12, 1)
> +    FIELD(GHWPARAMS6, HNPSUPPORT, 11, 1)
> +    FIELD(GHWPARAMS6, SRPSUPPORT, 10, 1)
> +    FIELD(GHWPARAMS6, GHWPARAMS6_9_8, 8, 2)
> +    FIELD(GHWPARAMS6, GHWPARAMS6_7, 7, 1)
> +    FIELD(GHWPARAMS6, GHWPARAMS6_6, 6, 1)
> +    FIELD(GHWPARAMS6, GHWPARAMS6_5_0, 0, 6)
> +REG32(GHWPARAMS7, 0x5c)
> +    FIELD(GHWPARAMS7, GHWPARAMS7_31_16, 16, 16)
> +    FIELD(GHWPARAMS7, GHWPARAMS7_15_0, 0, 16)
> +REG32(GDBGFIFOSPACE, 0x60)
> +    FIELD(GDBGFIFOSPACE, SPACE_AVAILABLE, 16, 16)
> +    FIELD(GDBGFIFOSPACE, RESERVED_15_9, 9, 7)
> +    FIELD(GDBGFIFOSPACE, FIFO_QUEUE_SELECT, 0, 9)
> +REG32(GUCTL2, 0x9c)
> +    FIELD(GUCTL2, RESERVED_31_26, 26, 6)
> +    FIELD(GUCTL2, EN_HP_PM_TIMER, 19, 7)
> +    FIELD(GUCTL2, NOLOWPWRDUR, 15, 4)
> +    FIELD(GUCTL2, RST_ACTBITLATER, 14, 1)
> +    FIELD(GUCTL2, RESERVED_13, 13, 1)
> +    FIELD(GUCTL2, DISABLECFC, 11, 1)
> +REG32(GUSB2PHYCFG, 0x100)
> +    FIELD(GUSB2PHYCFG, U2_FREECLK_EXISTS, 30, 1)
> +    FIELD(GUSB2PHYCFG, ULPI_LPM_WITH_OPMODE_CHK, 29, 1)
> +    FIELD(GUSB2PHYCFG, RESERVED_25, 25, 1)
> +    FIELD(GUSB2PHYCFG, LSTRD, 22, 3)
> +    FIELD(GUSB2PHYCFG, LSIPD, 19, 3)
> +    FIELD(GUSB2PHYCFG, ULPIEXTVBUSINDIACTOR, 18, 1)
> +    FIELD(GUSB2PHYCFG, ULPIEXTVBUSDRV, 17, 1)
> +    FIELD(GUSB2PHYCFG, RESERVED_16, 16, 1)
> +    FIELD(GUSB2PHYCFG, ULPIAUTORES, 15, 1)
> +    FIELD(GUSB2PHYCFG, RESERVED_14, 14, 1)
> +    FIELD(GUSB2PHYCFG, USBTRDTIM, 10, 4)
> +    FIELD(GUSB2PHYCFG, XCVRDLY, 9, 1)
> +    FIELD(GUSB2PHYCFG, ENBLSLPM, 8, 1)
> +    FIELD(GUSB2PHYCFG, PHYSEL, 7, 1)
> +    FIELD(GUSB2PHYCFG, SUSPENDUSB20, 6, 1)
> +    FIELD(GUSB2PHYCFG, FSINTF, 5, 1)
> +    FIELD(GUSB2PHYCFG, ULPI_UTMI_SEL, 4, 1)
> +    FIELD(GUSB2PHYCFG, PHYIF, 3, 1)
> +    FIELD(GUSB2PHYCFG, TOUTCAL, 0, 3)
> +REG32(GUSB2I2CCTL, 0x140)
> +REG32(GUSB2PHYACC_ULPI, 0x180)
> +    FIELD(GUSB2PHYACC_ULPI, RESERVED_31_27, 27, 5)
> +    FIELD(GUSB2PHYACC_ULPI, DISUIPIDRVR, 26, 1)
> +    FIELD(GUSB2PHYACC_ULPI, NEWREGREQ, 25, 1)
> +    FIELD(GUSB2PHYACC_ULPI, VSTSDONE, 24, 1)
> +    FIELD(GUSB2PHYACC_ULPI, VSTSBSY, 23, 1)
> +    FIELD(GUSB2PHYACC_ULPI, REGWR, 22, 1)
> +    FIELD(GUSB2PHYACC_ULPI, REGADDR, 16, 6)
> +    FIELD(GUSB2PHYACC_ULPI, EXTREGADDR, 8, 8)
> +    FIELD(GUSB2PHYACC_ULPI, REGDATA, 0, 8)
> +REG32(GTXFIFOSIZ0, 0x200)
> +    FIELD(GTXFIFOSIZ0, TXFSTADDR_N, 16, 16)
> +    FIELD(GTXFIFOSIZ0, TXFDEP_N, 0, 16)
> +REG32(GTXFIFOSIZ1, 0x204)
> +    FIELD(GTXFIFOSIZ1, TXFSTADDR_N, 16, 16)
> +    FIELD(GTXFIFOSIZ1, TXFDEP_N, 0, 16)
> +REG32(GTXFIFOSIZ2, 0x208)
> +    FIELD(GTXFIFOSIZ2, TXFSTADDR_N, 16, 16)
> +    FIELD(GTXFIFOSIZ2, TXFDEP_N, 0, 16)
> +REG32(GTXFIFOSIZ3, 0x20c)
> +    FIELD(GTXFIFOSIZ3, TXFSTADDR_N, 16, 16)
> +    FIELD(GTXFIFOSIZ3, TXFDEP_N, 0, 16)
> +REG32(GTXFIFOSIZ4, 0x210)
> +    FIELD(GTXFIFOSIZ4, TXFSTADDR_N, 16, 16)
> +    FIELD(GTXFIFOSIZ4, TXFDEP_N, 0, 16)
> +REG32(GTXFIFOSIZ5, 0x214)
> +    FIELD(GTXFIFOSIZ5, TXFSTADDR_N, 16, 16)
> +    FIELD(GTXFIFOSIZ5, TXFDEP_N, 0, 16)
> +REG32(GRXFIFOSIZ0, 0x280)
> +    FIELD(GRXFIFOSIZ0, RXFSTADDR_N, 16, 16)
> +    FIELD(GRXFIFOSIZ0, RXFDEP_N, 0, 16)
> +REG32(GRXFIFOSIZ1, 0x284)
> +    FIELD(GRXFIFOSIZ1, RXFSTADDR_N, 16, 16)
> +    FIELD(GRXFIFOSIZ1, RXFDEP_N, 0, 16)
> +REG32(GRXFIFOSIZ2, 0x288)
> +    FIELD(GRXFIFOSIZ2, RXFSTADDR_N, 16, 16)
> +    FIELD(GRXFIFOSIZ2, RXFDEP_N, 0, 16)
> +REG32(GEVNTADRLO_0, 0x300)
> +REG32(GEVNTADRHI_0, 0x304)
> +REG32(GEVNTSIZ_0, 0x308)
> +    FIELD(GEVNTSIZ_0, EVNTINTRPTMASK, 31, 1)
> +    FIELD(GEVNTSIZ_0, RESERVED_30_16, 16, 15)
> +    FIELD(GEVNTSIZ_0, EVENTSIZ, 0, 16)
> +REG32(GEVNTCOUNT_0, 0x30c)
> +    FIELD(GEVNTCOUNT_0, EVNT_HANDLER_BUSY, 31, 1)
> +    FIELD(GEVNTCOUNT_0, RESERVED_30_16, 16, 15)
> +    FIELD(GEVNTCOUNT_0, EVNTCOUNT, 0, 16)
> +REG32(GEVNTADRLO_1, 0x310)
> +REG32(GEVNTADRHI_1, 0x314)
> +REG32(GEVNTSIZ_1, 0x318)
> +    FIELD(GEVNTSIZ_1, EVNTINTRPTMASK, 31, 1)
> +    FIELD(GEVNTSIZ_1, RESERVED_30_16, 16, 15)
> +    FIELD(GEVNTSIZ_1, EVENTSIZ, 0, 16)
> +REG32(GEVNTCOUNT_1, 0x31c)
> +    FIELD(GEVNTCOUNT_1, EVNT_HANDLER_BUSY, 31, 1)
> +    FIELD(GEVNTCOUNT_1, RESERVED_30_16, 16, 15)
> +    FIELD(GEVNTCOUNT_1, EVNTCOUNT, 0, 16)
> +REG32(GEVNTADRLO_2, 0x320)
> +REG32(GEVNTADRHI_2, 0x324)
> +REG32(GEVNTSIZ_2, 0x328)
> +    FIELD(GEVNTSIZ_2, EVNTINTRPTMASK, 31, 1)
> +    FIELD(GEVNTSIZ_2, RESERVED_30_16, 16, 15)
> +    FIELD(GEVNTSIZ_2, EVENTSIZ, 0, 16)
> +REG32(GEVNTCOUNT_2, 0x32c)
> +    FIELD(GEVNTCOUNT_2, EVNT_HANDLER_BUSY, 31, 1)
> +    FIELD(GEVNTCOUNT_2, RESERVED_30_16, 16, 15)
> +    FIELD(GEVNTCOUNT_2, EVNTCOUNT, 0, 16)
> +REG32(GEVNTADRLO_3, 0x330)
> +REG32(GEVNTADRHI_3, 0x334)
> +REG32(GEVNTSIZ_3, 0x338)
> +    FIELD(GEVNTSIZ_3, EVNTINTRPTMASK, 31, 1)
> +    FIELD(GEVNTSIZ_3, RESERVED_30_16, 16, 15)
> +    FIELD(GEVNTSIZ_3, EVENTSIZ, 0, 16)
> +REG32(GEVNTCOUNT_3, 0x33c)
> +    FIELD(GEVNTCOUNT_3, EVNT_HANDLER_BUSY, 31, 1)
> +    FIELD(GEVNTCOUNT_3, RESERVED_30_16, 16, 15)
> +    FIELD(GEVNTCOUNT_3, EVNTCOUNT, 0, 16)
> +REG32(GHWPARAMS8, 0x500)
> +REG32(GTXFIFOPRIDEV, 0x510)
> +    FIELD(GTXFIFOPRIDEV, RESERVED_31_N, 6, 26)
> +    FIELD(GTXFIFOPRIDEV, GTXFIFOPRIDEV, 0, 6)
> +REG32(GTXFIFOPRIHST, 0x518)
> +    FIELD(GTXFIFOPRIHST, RESERVED_31_16, 3, 29)
> +    FIELD(GTXFIFOPRIHST, GTXFIFOPRIHST, 0, 3)
> +REG32(GRXFIFOPRIHST, 0x51c)
> +    FIELD(GRXFIFOPRIHST, RESERVED_31_16, 3, 29)
> +    FIELD(GRXFIFOPRIHST, GRXFIFOPRIHST, 0, 3)
> +REG32(GDMAHLRATIO, 0x524)
> +    FIELD(GDMAHLRATIO, RESERVED_31_13, 13, 19)
> +    FIELD(GDMAHLRATIO, HSTRXFIFO, 8, 5)
> +    FIELD(GDMAHLRATIO, RESERVED_7_5, 5, 3)
> +    FIELD(GDMAHLRATIO, HSTTXFIFO, 0, 5)
> +REG32(GFLADJ, 0x530)
> +    FIELD(GFLADJ, GFLADJ_REFCLK_240MHZDECR_PLS1, 31, 1)
> +    FIELD(GFLADJ, GFLADJ_REFCLK_240MHZ_DECR, 24, 7)
> +    FIELD(GFLADJ, GFLADJ_REFCLK_LPM_SEL, 23, 1)
> +    FIELD(GFLADJ, RESERVED_22, 22, 1)
> +    FIELD(GFLADJ, GFLADJ_REFCLK_FLADJ, 8, 14)
> +    FIELD(GFLADJ, GFLADJ_30MHZ_SDBND_SEL, 7, 1)
> +    FIELD(GFLADJ, GFLADJ_30MHZ, 0, 6)
> +
> +static void reset_csr(USBDWC3 * s)
> +{
> +    int i = 0;
> +    /*
> +     * We reset all CSR regs except GCTL, GUCTL, GSTS, GSNPSID, GGPIO, GUID,
> +     * GUSB2PHYCFGn registers and GUSB3PIPECTLn registers. We will skip PHY
> +     * register as we don't implement them.
> +     */
> +    for (i = 0; i < R_GCTL; i++) {
> +        register_reset(&s->regs_info[i]);
> +    }
> +
> +    for (i = R_GCTL; i < R_GBUSERRADDRLO; i++) {
> +        if (i == R_GUCTL1 || i == R_GPMSTS) {
> +            register_reset(&s->regs_info[i]);
> +        } else {
> +            continue;
> +        }
> +    }
> +
> +    for (i = R_GBUSERRADDRLO; i < USB_DWC3_R_MAX; i++) {
> +        register_reset(&s->regs_info[i]);
> +    }

Can we instead iterate through them all and have a list with the ones
that wont be reset? It'll be easier to understand the code and match
it with the regs that shouldn't reset.
e.g:

for (i = 0; i < USB_DWC3_R_MAX; i++) {
    switch (i) {
    case R_GCTL:
    case XXX:
        /* Should not reset.  */
        break;
    default:
        register_reset(&s->regs_info[i]);
        break;
    }
}

> +
> +    xhci_sysbus_reset(DEVICE(&s->sysbus_xhci));
> +}
> +
> +static void usb_dwc3_gctl_postw(RegisterInfo *reg, uint64_t val64)
> +{
> +    USBDWC3 *s = USB_DWC3(reg->opaque);
> +
> +    if (ARRAY_FIELD_EX32(s->regs, GCTL, CORESOFTRESET)) {
> +        reset_csr(s);
> +    }
> +}
> +
> +static void usb_dwc3_guid_postw(RegisterInfo *reg, uint64_t val64)
> +{
> +    USBDWC3 *s = USB_DWC3(reg->opaque);
> +
> +    s->regs[R_GUID] = s->cfg.dwc_usb3_user;
> +}

This looks strange. Is this register really writeable on real HW?
Looks lite a read-only register that should get it's value from the property...


> +
> +static void usb_dwc3_unimpl_postw(RegisterInfo *reg, uint64_t val64)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s not supported\n", reg->access->name);
> +}
> +
> +static uint64_t usb_dwc3_unimpl_postr(RegisterInfo *reg, uint64_t val64)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s not supported\n", reg->access->name);
> +    return val64;
> +}

We should probably use the regapi .unimp instead of these functions.

> +
> +static const RegisterAccessInfo usb_dwc3_regs_info[] = {
> +    {   .name = "GSBUSCFG0",  .addr = A_GSBUSCFG0,
> +        .ro = 0xf300,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GSBUSCFG1",  .addr = A_GSBUSCFG1,
> +        .reset = 0x300,
> +        .ro = 0xffffe0ff,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GTXTHRCFG",  .addr = A_GTXTHRCFG,
> +        .ro = 0xd000ffff,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GRXTHRCFG",  .addr = A_GRXTHRCFG,
> +        .ro = 0xd007e000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GCTL",  .addr = A_GCTL,
> +        .reset = 0x30c13004, .post_write = usb_dwc3_gctl_postw,
> +    },{ .name = "GPMSTS",  .addr = A_GPMSTS,
> +        .ro = 0xfffffff,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GSTS",  .addr = A_GSTS,
> +        .reset = 0x7e800000,
> +        .ro = 0xffffffcf,
> +        .w1c = 0x30,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GUCTL1",  .addr = A_GUCTL1,
> +        .reset = 0x198a,
> +        .ro = 0x7800,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GSNPSID",  .addr = A_GSNPSID,
> +        .reset = 0x5533330a,
> +        .ro = 0xffffffff,
> +    },{ .name = "GGPIO",  .addr = A_GGPIO,
> +        .ro = 0xffff,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GUID",  .addr = A_GUID,
> +        .reset = 0x12345678, .post_write = usb_dwc3_guid_postw,
> +    },{ .name = "GUCTL",  .addr = A_GUCTL,
> +        .reset = 0x0c808010,
> +        .ro = 0x1c8000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GBUSERRADDRLO",  .addr = A_GBUSERRADDRLO,
> +        .ro = 0xffffffff,
> +        .post_read = usb_dwc3_unimpl_postr,
> +    },{ .name = "GBUSERRADDRHI",  .addr = A_GBUSERRADDRHI,
> +        .ro = 0xffffffff,
> +        .post_read = usb_dwc3_unimpl_postr,
> +    },{ .name = "GHWPARAMS0",  .addr = A_GHWPARAMS0,
> +        .ro = 0xffffffff,
> +    },{ .name = "GHWPARAMS1",  .addr = A_GHWPARAMS1,
> +        .ro = 0xffffffff,
> +    },{ .name = "GHWPARAMS2",  .addr = A_GHWPARAMS2,
> +        .ro = 0xffffffff,
> +    },{ .name = "GHWPARAMS3",  .addr = A_GHWPARAMS3,
> +        .ro = 0xffffffff,
> +    },{ .name = "GHWPARAMS4",  .addr = A_GHWPARAMS4,
> +        .ro = 0xffffffff,
> +    },{ .name = "GHWPARAMS5",  .addr = A_GHWPARAMS5,
> +        .ro = 0xffffffff,
> +    },{ .name = "GHWPARAMS6",  .addr = A_GHWPARAMS6,
> +        .ro = 0xffffffff,
> +    },{ .name = "GHWPARAMS7",  .addr = A_GHWPARAMS7,
> +        .ro = 0xffffffff,
> +    },{ .name = "GDBGFIFOSPACE",  .addr = A_GDBGFIFOSPACE,
> +        .reset = 0xa0000,
> +        .ro = 0xfffffe00,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GUCTL2",  .addr = A_GUCTL2,
> +        .reset = 0x40d,
> +        .ro = 0x2000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GUSB2PHYCFG",  .addr = A_GUSB2PHYCFG,
> +        .reset = 0x40102410,
> +        .ro = 0x1e014030,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GUSB2I2CCTL",  .addr = A_GUSB2I2CCTL,
> +        .ro = 0xffffffff,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GUSB2PHYACC_ULPI",  .addr = A_GUSB2PHYACC_ULPI,
> +        .ro = 0xfd000000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GTXFIFOSIZ0",  .addr = A_GTXFIFOSIZ0,
> +        .reset = 0x2c7000a,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GTXFIFOSIZ1",  .addr = A_GTXFIFOSIZ1,
> +        .reset = 0x2d10103,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GTXFIFOSIZ2",  .addr = A_GTXFIFOSIZ2,
> +        .reset = 0x3d40103,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GTXFIFOSIZ3",  .addr = A_GTXFIFOSIZ3,
> +        .reset = 0x4d70083,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GTXFIFOSIZ4",  .addr = A_GTXFIFOSIZ4,
> +        .reset = 0x55a0083,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GTXFIFOSIZ5",  .addr = A_GTXFIFOSIZ5,
> +        .reset = 0x5dd0083,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GRXFIFOSIZ0",  .addr = A_GRXFIFOSIZ0,
> +        .reset = 0x1c20105,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GRXFIFOSIZ1",  .addr = A_GRXFIFOSIZ1,
> +        .reset = 0x2c70000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GRXFIFOSIZ2",  .addr = A_GRXFIFOSIZ2,
> +        .reset = 0x2c70000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTADRLO_0",  .addr = A_GEVNTADRLO_0,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTADRHI_0",  .addr = A_GEVNTADRHI_0,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTSIZ_0",  .addr = A_GEVNTSIZ_0,
> +        .ro = 0x7fff0000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTCOUNT_0",  .addr = A_GEVNTCOUNT_0,
> +        .ro = 0x7fff0000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTADRLO_1",  .addr = A_GEVNTADRLO_1,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTADRHI_1",  .addr = A_GEVNTADRHI_1,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTSIZ_1",  .addr = A_GEVNTSIZ_1,
> +        .ro = 0x7fff0000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTCOUNT_1",  .addr = A_GEVNTCOUNT_1,
> +        .ro = 0x7fff0000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTADRLO_2",  .addr = A_GEVNTADRLO_2,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTADRHI_2",  .addr = A_GEVNTADRHI_2,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTSIZ_2",  .addr = A_GEVNTSIZ_2,
> +        .ro = 0x7fff0000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTCOUNT_2",  .addr = A_GEVNTCOUNT_2,
> +        .ro = 0x7fff0000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTADRLO_3",  .addr = A_GEVNTADRLO_3,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTADRHI_3",  .addr = A_GEVNTADRHI_3,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTSIZ_3",  .addr = A_GEVNTSIZ_3,
> +        .ro = 0x7fff0000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GEVNTCOUNT_3",  .addr = A_GEVNTCOUNT_3,
> +        .ro = 0x7fff0000,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GHWPARAMS8",  .addr = A_GHWPARAMS8,
> +        .ro = 0xffffffff,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GTXFIFOPRIDEV",  .addr = A_GTXFIFOPRIDEV,
> +        .ro = 0xffffffc0,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GTXFIFOPRIHST",  .addr = A_GTXFIFOPRIHST,
> +        .ro = 0xfffffff8,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GRXFIFOPRIHST",  .addr = A_GRXFIFOPRIHST,
> +        .ro = 0xfffffff8,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GDMAHLRATIO",  .addr = A_GDMAHLRATIO,
> +        .ro = 0xffffe0e0,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    },{ .name = "GFLADJ",  .addr = A_GFLADJ,
> +        .reset = 0xc83f020,
> +        .rsvd = 0x40,
> +        .ro = 0x400040,
> +        .post_read = usb_dwc3_unimpl_postr,
> +        .post_write = usb_dwc3_unimpl_postw,
> +    }
> +};
> +
> +static void usb_dwc3_reset(DeviceState *dev)
> +{
> +    USBDWC3 *s = USB_DWC3(dev);
> +    unsigned int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
> +        register_reset(&s->regs_info[i]);
> +    }
> +
> +    /*
> +     * Device Configuration
> +     */
> +    s->regs[R_GHWPARAMS0] = 0x40204048 | s->cfg.mode;
> +    s->regs[R_GHWPARAMS1] = 0x222493b;
> +    s->regs[R_GHWPARAMS2] = 0x12345678;
> +    s->regs[R_GHWPARAMS3] = 0x618c088;
> +    s->regs[R_GHWPARAMS4] = 0x47822004;
> +    s->regs[R_GHWPARAMS5] = 0x4202088;
> +    s->regs[R_GHWPARAMS6] = 0x7850c20;
> +    s->regs[R_GHWPARAMS7] = 0x0;
> +    s->regs[R_GHWPARAMS8] = 0x478;

Shouldn't these be setup in realize()?

> +
> +    xhci_sysbus_reset(DEVICE(&s->sysbus_xhci));
> +}
> +
> +static const MemoryRegionOps usb_dwc3_ops = {
> +    .read = register_read_memory,
> +    .write = register_write_memory,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void usb_dwc3_realize(DeviceState *dev, Error **errp)
> +{
> +    USBDWC3 *s = USB_DWC3(dev);
> +    Error *err = NULL;
> +
> +    sysbus_realize(SYS_BUS_DEVICE(&s->sysbus_xhci), &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +}
> +
> +static void usb_dwc3_init(Object *obj)
> +{
> +    USBDWC3 *s = USB_DWC3(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
> +
> +    memory_region_init(&s->iomem, obj, TYPE_USB_DWC3, USB_DWC3_R_MAX * 4);
> +    reg_array =
> +        register_init_block32(DEVICE(obj), usb_dwc3_regs_info,
> +                              ARRAY_SIZE(usb_dwc3_regs_info),
> +                              s->regs_info, s->regs,
> +                              &usb_dwc3_ops,
> +                              USB_DWC3_ERR_DEBUG,
> +                              USB_DWC3_R_MAX * 4);
> +    memory_region_add_subregion(&s->iomem,
> +                                0x0,
> +                                &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    object_initialize_child(obj, "dwc3-xhci", &s->sysbus_xhci,
> +                            TYPE_XHCI_SYSBUS);
> +    qdev_alias_all_properties(DEVICE(&s->sysbus_xhci), obj);
> +
> +    s->cfg.mode = HOST_MODE;
> +}
> +
> +static Property usb_dwc3_properties[] = {
> +    DEFINE_PROP_UINT32("DWC_USB3_USERID", USBDWC3, cfg.dwc_usb3_user,
> +                       0x12345678),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void usb_dwc3_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = usb_dwc3_reset;
> +    dc->realize = usb_dwc3_realize;
> +    device_class_set_props(dc, usb_dwc3_properties);
> +}
> +
> +static const TypeInfo usb_dwc3_info = {
> +    .name          = TYPE_USB_DWC3,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(USBDWC3),
> +    .class_init    = usb_dwc3_class_init,
> +    .instance_init = usb_dwc3_init,
> +};
> +
> +static void usb_dwc3_register_types(void)
> +{
> +    type_register_static(&usb_dwc3_info);
> +}
> +
> +type_init(usb_dwc3_register_types)
> diff --git a/hw/usb/meson.build b/hw/usb/meson.build
> index 934e4fa..962fbc0 100644
> --- a/hw/usb/meson.build
> +++ b/hw/usb/meson.build
> @@ -26,6 +26,7 @@ softmmu_ss.add(when: 'CONFIG_USB_XHCI_SYSBUS', if_true: files('hcd-xhci-sysbus.c
>  softmmu_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
>  softmmu_ss.add(when: 'CONFIG_USB_MUSB', if_true: files('hcd-musb.c'))
>  softmmu_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
> +softmmu_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))
>  
>  softmmu_ss.add(when: 'CONFIG_TUSB6010', if_true: files('tusb6010.c'))
>  softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('chipidea.c'))
> diff --git a/include/hw/usb/hcd-dwc3.h b/include/hw/usb/hcd-dwc3.h
> new file mode 100644
> index 0000000..586968d
> --- /dev/null
> +++ b/include/hw/usb/hcd-dwc3.h
> @@ -0,0 +1,55 @@
> +/*
> + * QEMU model of the USB DWC3 host controller emulation.
> + *
> + * Copyright (c) 2020 Xilinx Inc.
> + *
> + * Written by Vikram Garhwal<fnu.vikram@xilinx.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +#ifndef HCD_DWC3_H
> +#define HCD_DWC3_H
> +
> +#include "hw/usb/hcd-xhci.h"
> +#include "hw/usb/hcd-xhci-sysbus.h"
> +
> +#define TYPE_USB_DWC3 "usb_dwc3"
> +
> +#define USB_DWC3(obj) \
> +     OBJECT_CHECK(USBDWC3, (obj), TYPE_USB_DWC3)
> +
> +#define USB_DWC3_R_MAX ((0x530 / 4) + 1)
> +
> +typedef struct USBDWC3 {
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +    MemoryRegion fifos;
> +    XHCISysbusState sysbus_xhci;
> +
> +    uint32_t regs[USB_DWC3_R_MAX];
> +    RegisterInfo regs_info[USB_DWC3_R_MAX];
> +
> +    struct {
> +        uint8_t     mode;
> +        uint32_t    dwc_usb3_user;
> +    } cfg;
> +
> +} USBDWC3;
> +
> +#endif
> -- 
> 2.7.4
> 

