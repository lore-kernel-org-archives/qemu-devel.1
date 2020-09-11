Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AA4C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C5920659
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lql+Ra1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C5920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGe7m-0000Qx-01
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kGe75-0008QF-LD
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:08:55 -0400
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com
 ([40.107.243.52]:41077 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kGe73-0006iy-7k
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:08:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdKlHgYtE8dIwjmHL9S2rAMWFyE7OpEK85eOmtoXWRBkjSDfRE+PCZntYl0rld+Ay9xBRpx3UxDaWxbuuDJko2gXAYGVDTk7pzsZ5SIWp/ygyjOiPDBmuxI1M4PvvM9xiTEJHbJcUvr1ZNMr0prWLJX5oVDSBgHgqFI90cfVHkRPvcEJ26TrurVo6oaviyfX3W966GGXim9eCfYoDfJlVWIcki6RyE1xHT+bFEkl2YUsI/Ou5OqU2gXPVbxSUoVTd7KSE7lLiGy/2V8lxegGsRX4sA0mNxZD8GMkVklVgnr3wE8l7BDQlggteCyMS03zSwU0+zaOVpP+a1v7S/J9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+zwcJvqCL9YkLyhtO3LALnYPmaB9Sr8r3UZRL7fikw=;
 b=Gwr+dHb99lzILF10+ARygyOTOYpUbX0yBtSxklUb8APF99AvFlXxR52oxMHUSzLRQsWfuT34VawUGPJvynHrLWjW9VxxMMt0rhQgtnVW43IhGeIrPZeAk+rjlsHYHPopclGATMcBtieo5N/c9Ds2+6oa+67kUHe8m/e4QO+XX+5Fk06L3T/U1cQDLcgSWywAZB1iwXeaJZtVtDG0mP1oDtRXTpOolLfbX8RYlaAvYE/nwuCs64qBs3TaUF1lbvkRoeEqm0UeD/vI0Br+MhPRuN7wiSbfD6qyatu6X5EIZPsSqSodQMGnyiFd0vfwXnBMSZuCzw3Es1y8MG25PVOy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+zwcJvqCL9YkLyhtO3LALnYPmaB9Sr8r3UZRL7fikw=;
 b=lql+Ra1QiwYiOM63ogiiJhUiQbGI5UdjTS4OJcOGbUJhjv3voclC6VCgYDSG4hYgdMZnpxIcRyqUOxM34xNLu4n5R/Jw8jLB/drsRRv0BWWiRLAeJvohD8T8VKll43y+0lLLfwz+FBonmCTR54Vjp0A86aT+8dTZp9pSAWPuLks=
Received: from DM5PR16CA0004.namprd16.prod.outlook.com (2603:10b6:3:c0::14) by
 SN4PR0201MB3502.namprd02.prod.outlook.com (2603:10b6:803:4c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 11 Sep
 2020 08:08:46 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::d4) by DM5PR16CA0004.outlook.office365.com
 (2603:10b6:3:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 08:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 08:08:45
 +0000
Received: from [149.199.38.66] (port=44939 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kGe6v-0008TP-4o; Fri, 11 Sep 2020 01:08:45 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kGe6v-000784-Gn; Fri, 11 Sep 2020 01:08:45 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kGe6m-00076T-Gg; Fri, 11 Sep 2020 01:08:36 -0700
Date: Fri, 11 Sep 2020 10:08:30 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v5 5/7] misc: Add versal-usb2-regs module
Message-ID: <20200911080830.GR14249@toto>
References: <1599719469-24062-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1599719469-24062-6-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599719469-24062-6-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4dad96e-affc-439d-3f6f-08d85629e7ef
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3502:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3502821F799FB6DEF0FF76DEC2240@SN4PR0201MB3502.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhkbB6rSJcxJ3DRK0KqkftKl8zmsFaihjOf2RGmE9WByurEZebA7T6no7+j+x6ZZrCeIC0azNVJ7EoIwauds9YMttiQIx5mcKO6M1GVqgJuIsaLHN54JoKq2YnZ6hyYTN9cqNYw6bVgvb3D6ZbosRsoKzJXd9toxDFBz4K+/lDobTrays8AjrMuv6kbYvIehYlhaSh4mKe07vdHgK9WZyUyebCc30Wg4JkQrjKBXsqdbybOP/bfJod58HobHABO/OljzWvqqhDvqNSCTnwRlHB2adkNyKn1fbpiV6Nqh5lJL71fBFYwjyG0IL37Fg157fMCLXm+iqqTtLK4YKzmLp5BwPElWghvPHsRdpUFsOk/oevXk1nR4R64isFqF4myBMNm/JHH6VGBH9l6CgdJgYA==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(376002)(396003)(136003)(39860400002)(346002)(46966005)(54906003)(83380400001)(478600001)(9686003)(7416002)(9786002)(356005)(26005)(82310400003)(8936002)(186003)(47076004)(2906002)(426003)(70206006)(8676002)(6666004)(82740400003)(81166007)(4326008)(33716001)(336012)(6862004)(316002)(30864003)(1076003)(70586007)(19627235002)(33656002)(6636002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 08:08:45.7654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dad96e-affc-439d-3f6f-08d85629e7ef
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3502
Received-SPF: pass client-ip=40.107.243.52; envelope-from=edgar@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 04:08:47
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?'Marc-Andr=E9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 'Philippe =?iso-8859-1?Q?Mathieu-Daud=E9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 12:01:07PM +0530, Sai Pavan Boddu wrote:
> This module emulates control registers of versal usb2 controller, this is added
> just to make guest happy. In general this module would control the phy-reset
> signal from usb controller, data coherency of the transactions, signals
> the host system errors received from controller.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> ---
>  hw/misc/meson.build                     |   1 +
>  hw/misc/xlnx-versal-usb2-regs.c         | 226 ++++++++++++++++++++++++++++++++
>  include/hw/misc/xlnx-versal-usb2-regs.h |  43 ++++++
>  3 files changed, 270 insertions(+)
>  create mode 100644 hw/misc/xlnx-versal-usb2-regs.c
>  create mode 100644 include/hw/misc/xlnx-versal-usb2-regs.h
> 
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index e1576b8..2d231d4 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -99,3 +99,4 @@ specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cp
>  specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
>  
>  specific_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
> +specific_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-usb2-regs.c'))
> diff --git a/hw/misc/xlnx-versal-usb2-regs.c b/hw/misc/xlnx-versal-usb2-regs.c
> new file mode 100644
> index 0000000..420cadd
> --- /dev/null
> +++ b/hw/misc/xlnx-versal-usb2-regs.c
> @@ -0,0 +1,226 @@
> +/*
> + * QEMU model of the XlnxUsb2Regs Register control block/Status for USB2.0 IP
> + *
> + * This module should control phy_reset, permanent device plugs, frame length
> + * time adjust & setting of coherency paths. None of which are emulated in
> + * present model.
> + *
> + * Copyright (c) 2020 Xilinx Inc. Vikram Garhwal <fnu.vikram@xilinx.com>
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
> +#include "hw/irq.h"
> +#include "hw/register.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qom/object.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/xlnx-versal-usb2-regs.h"
> +
> +#ifndef XILINX_USB2_REGS_ERR_DEBUG
> +#define XILINX_USB2_REGS_ERR_DEBUG 0
> +#endif
> +
> +#define TYPE_XILINX_USB2_REGS "xlnx.usb2_regs"

I think we need to add versal to the name.
Also, USB2 Regs is not a very good name (I know that's what it's internally called but).
Perhaps xlnx.versal-usb2-ctrl-regs?

And XlnxVersalUsb2CtrlRegs

> +
> +#define XILINX_USB2_REGS(obj) \
> +     OBJECT_CHECK(XlnxUsb2Regs, (obj), TYPE_XILINX_USB2_REGS)
> +
> +REG32(BUS_FILTER, 0x30)
> +    FIELD(BUS_FILTER, BYPASS, 0, 4)
> +REG32(PORT, 0x34)
> +    FIELD(PORT, HOST_SMI_BAR_WR, 4, 1)
> +    FIELD(PORT, HOST_SMI_PCI_CMD_REG_WR, 3, 1)
> +    FIELD(PORT, HOST_MSI_ENABLE, 2, 1)
> +    FIELD(PORT, PWR_CTRL_PRSNT, 1, 1)
> +    FIELD(PORT, HUB_PERM_ATTACH, 0, 1)
> +REG32(JITTER_ADJUST, 0x38)
> +    FIELD(JITTER_ADJUST, FLADJ, 0, 6)
> +REG32(BIGENDIAN, 0x40)
> +    FIELD(BIGENDIAN, ENDIAN_GS, 0, 1)
> +REG32(COHERENCY, 0x44)
> +    FIELD(COHERENCY, USB_COHERENCY, 0, 1)
> +REG32(XHC_BME, 0x48)
> +    FIELD(XHC_BME, XHC_BME, 0, 1)
> +REG32(REG_CTRL, 0x60)
> +    FIELD(REG_CTRL, SLVERR_ENABLE, 0, 1)
> +REG32(IR_STATUS, 0x64)
> +    FIELD(IR_STATUS, HOST_SYS_ERR, 1, 1)
> +    FIELD(IR_STATUS, ADDR_DEC_ERR, 0, 1)
> +REG32(IR_MASK, 0x68)
> +    FIELD(IR_MASK, HOST_SYS_ERR, 1, 1)
> +    FIELD(IR_MASK, ADDR_DEC_ERR, 0, 1)
> +REG32(IR_ENABLE, 0x6c)
> +    FIELD(IR_ENABLE, HOST_SYS_ERR, 1, 1)
> +    FIELD(IR_ENABLE, ADDR_DEC_ERR, 0, 1)
> +REG32(IR_DISABLE, 0x70)
> +    FIELD(IR_DISABLE, HOST_SYS_ERR, 1, 1)
> +    FIELD(IR_DISABLE, ADDR_DEC_ERR, 0, 1)
> +REG32(USB3, 0x78)
> +
> +static void ir_update_irq(XlnxUsb2Regs *s)
> +{
> +    bool pending = s->regs[R_IR_STATUS] & ~s->regs[R_IR_MASK];
> +    qemu_set_irq(s->irq_ir, pending);
> +}
> +
> +static void ir_status_postw(RegisterInfo *reg, uint64_t val64)
> +{
> +    XlnxUsb2Regs *s = XILINX_USB2_REGS(reg->opaque);
> +    /*
> +     * TODO: This should also clear USBSTS.HSE field in USB XHCI register.
> +     * May be combine both the modules.
> +     */
> +    ir_update_irq(s);
> +}
> +
> +static uint64_t ir_enable_prew(RegisterInfo *reg, uint64_t val64)
> +{
> +    XlnxUsb2Regs *s = XILINX_USB2_REGS(reg->opaque);
> +    uint32_t val = val64;
> +
> +    s->regs[R_IR_MASK] &= ~val;
> +    ir_update_irq(s);
> +    return 0;
> +}
> +
> +static uint64_t ir_disable_prew(RegisterInfo *reg, uint64_t val64)
> +{
> +    XlnxUsb2Regs *s = XILINX_USB2_REGS(reg->opaque);
> +    uint32_t val = val64;
> +
> +    s->regs[R_IR_MASK] |= val;
> +    ir_update_irq(s);
> +    return 0;
> +}
> +
> +static const RegisterAccessInfo usb2_regs_regs_info[] = {
> +    {   .name = "BUS_FILTER",  .addr = A_BUS_FILTER,
> +        .rsvd = 0xfffffff0,
> +    },{ .name = "PORT",  .addr = A_PORT,
> +        .rsvd = 0xffffffe0,
> +    },{ .name = "JITTER_ADJUST",  .addr = A_JITTER_ADJUST,
> +        .reset = 0x20,
> +        .rsvd = 0xffffffc0,
> +    },{ .name = "BIGENDIAN",  .addr = A_BIGENDIAN,
> +        .rsvd = 0xfffffffe,
> +    },{ .name = "COHERENCY",  .addr = A_COHERENCY,
> +        .rsvd = 0xfffffffe,
> +    },{ .name = "XHC_BME",  .addr = A_XHC_BME,
> +        .reset = 0x1,
> +        .rsvd = 0xfffffffe,
> +    },{ .name = "REG_CTRL",  .addr = A_REG_CTRL,
> +        .rsvd = 0xfffffffe,
> +    },{ .name = "IR_STATUS",  .addr = A_IR_STATUS,
> +        .rsvd = 0xfffffffc,
> +        .w1c = 0x3,
> +        .post_write = ir_status_postw,
> +    },{ .name = "IR_MASK",  .addr = A_IR_MASK,
> +        .reset = 0x3,
> +        .rsvd = 0xfffffffc,
> +        .ro = 0x3,
> +    },{ .name = "IR_ENABLE",  .addr = A_IR_ENABLE,
> +        .rsvd = 0xfffffffc,
> +        .pre_write = ir_enable_prew,
> +    },{ .name = "IR_DISABLE",  .addr = A_IR_DISABLE,
> +        .rsvd = 0xfffffffc,
> +        .pre_write = ir_disable_prew,
> +    },{ .name = "USB3",  .addr = A_USB3,
> +    }
> +};
> +
> +static void usb2_regs_reset(DeviceState *dev)
> +{
> +    XlnxUsb2Regs *s = XILINX_USB2_REGS(dev);
> +    unsigned int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
> +        register_reset(&s->regs_info[i]);
> +    }
> +
> +    ir_update_irq(s);
> +}
> +
> +static const MemoryRegionOps usb2_regs_ops = {
> +    .read = register_read_memory,
> +    .write = register_write_memory,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void usb2_regs_init(Object *obj)
> +{
> +    XlnxUsb2Regs *s = XILINX_USB2_REGS(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
> +
> +    memory_region_init(&s->iomem, obj, TYPE_XILINX_USB2_REGS,
> +                       USB2_REGS_R_MAX * 4);
> +    reg_array =
> +        register_init_block32(DEVICE(obj), usb2_regs_regs_info,
> +                              ARRAY_SIZE(usb2_regs_regs_info),
> +                              s->regs_info, s->regs,
> +                              &usb2_regs_ops,
> +                              XILINX_USB2_REGS_ERR_DEBUG,
> +                              USB2_REGS_R_MAX * 4);
> +    memory_region_add_subregion(&s->iomem,
> +                                0x0,
> +                                &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq_ir);
> +}
> +
> +static const VMStateDescription vmstate_usb2_regs = {
> +    .name = TYPE_XILINX_USB2_REGS,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, XlnxUsb2Regs, USB2_REGS_R_MAX),
> +        VMSTATE_END_OF_LIST(),
> +    }
> +};
> +
> +static void usb2_regs_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = usb2_regs_reset;
> +    dc->vmsd = &vmstate_usb2_regs;
> +}
> +
> +static const TypeInfo usb2_regs_info = {
> +    .name          = TYPE_XILINX_USB2_REGS,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(XlnxUsb2Regs),
> +    .class_init    = usb2_regs_class_init,
> +    .instance_init = usb2_regs_init,
> +};
> +
> +static void usb2_regs_register_types(void)
> +{
> +    type_register_static(&usb2_regs_info);
> +}
> +
> +type_init(usb2_regs_register_types)
> diff --git a/include/hw/misc/xlnx-versal-usb2-regs.h b/include/hw/misc/xlnx-versal-usb2-regs.h
> new file mode 100644
> index 0000000..4c5dc02
> --- /dev/null
> +++ b/include/hw/misc/xlnx-versal-usb2-regs.h
> @@ -0,0 +1,43 @@
> +/*
> + * QEMU model of the XlnxUsb2Regs Register control block/Status for USB2.0 IP
> + *
> + * Copyright (c) 2020 Xilinx Inc.
> + *
> + * Autogenerated by xregqemu.py 2020-04-08.

We should remove this part...


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
> +#ifndef _XLNX_USB2_REGS_H_
> +#define _XLNX_USB2_REGS_H_
> +
> +#define USB2_REGS_R_MAX ((0x78 / 4) + 1)
> +
> +typedef struct XlnxUsb2Regs {
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +    qemu_irq irq_ir;
> +
> +    uint32_t regs[USB2_REGS_R_MAX];
> +    RegisterInfo regs_info[USB2_REGS_R_MAX];
> +} XlnxUsb2Regs;
> +
> +#endif
> +
> +
> -- 
> 2.7.4
> 

