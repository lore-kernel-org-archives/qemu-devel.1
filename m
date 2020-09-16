Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BB3C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF7A20672
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ak+RT0Wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF7A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWqd-0002Vm-MT
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIWfA-00065S-2w
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:35:52 -0400
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com
 ([40.107.243.62]:32992 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIWf6-0006KL-Jb
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:35:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odaaNSQNVCPr5ZIQWdawOcWRZXRVNfh0L20109QU+h6hPZ1LY7aDOFxmSWYcDg1ewB5KqbnpgdpcilJssFwfiyGhNPtw4C6j07vwYPc3QC0a1mvQuNXaV0iiDfb8LVv96SlaD1jqfWplcUZXSvJvSeHymarVN9q3/dyTx+kQVI1q8WMu4xWMNfzXGV47sV+9KVC7ENZFm3cscaTTMBa5oBQ+DIdNPgZlFd6/FuDqPuTCZvcturYYrm4yfFEyEMiKjzQXdOJXUlL+v5EJN4wpFIXYxPKmfJuP5P6fCWR3fvs0vakunmWfUYkvm2WVqcOMzPKl9N+9Yzy+mI9YkmdmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj9aIaiT/9gcv9o5MUrxmRLNTx8DSYu3Qag3Tsf765A=;
 b=ChQ9bMIvKpis8SJY0WVJ2mCiY/Zw48dPtpr8Bn+XkZ7LccXPJTs5VKGPWEeuM0oRCIcow2MjZKE3XGRQg8ZclPBEuu5CfIhQJxmDsyjFuFafTmuNCzpdu+evCNdfBsl0pdpJDpG2pWKVHNgFCVXaVbkOzPIqpKS2xI0JLS6sju+CD2INixI1uHORpTkT6e42R7O5Ks9Xw0+gTdGbWt9fbvBOBjSfLwn8172Dj4wf7cn7WVUR0ZUvj9BD2rzWRYK6CEDuaouBq99ByrCgueltU5nN7227hrg1fduFE1OqLToBZGopDRe8e6psr9l6ENriH8lo1LCDwH/Q87L98/b1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj9aIaiT/9gcv9o5MUrxmRLNTx8DSYu3Qag3Tsf765A=;
 b=Ak+RT0Wf17BNAar9OHnNvX62WasJ8mooqfawz1Mmu+yDeD+v3GUC+h7AJEl4k1CXdywlTVALmN8J3X7/xUTS2cYXSS7+IsuH68O0AYGYSvO58Ekj34hX6lC3WX0zFGtW6YrF6JW532b2IhxCxDyHgLttoNMs3sBBi2mxIwPnfRE=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB4791.namprd02.prod.outlook.com (2603:10b6:a03:4f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 12:35:45 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 12:35:45 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Sai Pavan Boddu <saipava@xilinx.com>, Peter Maydell
 <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?=27Marc-Andr=E9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Edgar
 Iglesias <edgari@xilinx.com>, Francisco Eduardo Iglesias
 <figlesia@xilinx.com>
Subject: RE: [PATCH v6 5/7] misc: Add versal-usb2-regs module
Thread-Topic: [PATCH v6 5/7] misc: Add versal-usb2-regs module
Thread-Index: AQHWjB4E9Z9w91EkOkW4s2tFbhvZualrM3RA
Date: Wed, 16 Sep 2020 12:35:45 +0000
Message-ID: <BY5PR02MB67725B5F9BDF142D03925534CA210@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1600256469-13130-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600256469-13130-7-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1600256469-13130-7-git-send-email-sai.pavan.boddu@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24b878ed-bad6-4199-230e-08d85a3d0852
x-ms-traffictypediagnostic: BYAPR02MB4791:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4791CFFE88C357158CA8871DCA210@BYAPR02MB4791.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:352;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XhiyaS8iwSGhvJfvn3t9amkgUxkXSyczCUxHGOufzrDIfByXN6qsiS+a4u1g4Ef+5HDcF+Pbu9gFBR/vXGNDlweApxRuV92lL0KnppZSZ8wS3GHQZSiRD3wKyyF9DO/a1PL6t1Us9Q/T8NE/3bInREksJch1s6CmUw41mJAcHdm+dVccet2LFj3D3QyQj60oajZTGUcBrO1TkS7tqIhexOFnAo6fJvVkyjTa5CdRKnNE+3GKY0M+tyryr2Kr2PKRHZeoof7+edJ0JPysm7eJ6zqp5jDZf2Y20pCxVFO/N4loeopxQFw2RZUr3XmJn8uhPw7jH3PwqPwbPNkI3oIiCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(39860400002)(136003)(366004)(396003)(6506007)(66446008)(64756008)(26005)(66946007)(110136005)(66476007)(478600001)(71200400001)(4326008)(53546011)(66556008)(33656002)(8936002)(86362001)(186003)(7416002)(8676002)(6636002)(83380400001)(7696005)(54906003)(316002)(5660300002)(55016002)(52536014)(30864003)(9686003)(2906002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TnNrgtJ4YjP36fA102vJ8f/eo4l/n6UL2ASeB2XKD3Sp1JaGe34JKO8pcQpmt5D8JPyN5Amswp2gyYhHJBO5h9I3aXJl7AhuSCzuuOaVgSt0zOeeLYi/fPnNK4mqw1J//7Uu65hB+Pwvz4fmS0Rg1Aj1mOs9obraA2724jTFL5wsPknuOdFdmK+fi3/98GpT7ZAIle/OkMElb3XGIsudaJkfbit1yxlzJs1vfmWYbNdXdmlxcopfD33TqTicoOJYUpnU9hpP7fPoOJ4IeSAyB/81JRA4sSUjEXu1ZbEAlttNgP1hcH5Lwcss67vHExjfF7s2dPWjCX8ypjeH9SzigXsr36BcDroEEyRz37mJNC+WrtOvoftF7/WymkkmnCVag7y/gByK3YlJAUSYOyJt18l1l/eIE1xsnh3ZQTmbXRDa5Bn2iK3pNVHhV75l/La8Xh4WopMSlFFTEZz5T2ndJ22TjKhGcxOVSvhBsl2JhZg8mW+mxXZ9WjsZrcPpPNT7SyNrVUfjc9Et/meQDFXIMorHvenJV5oU32yNamvBOvmf0bOmhFbkk3F3wVKU9HgHsArCAzo/YvdcVydK9dl6aV+7nX9dpoxMJP6siQpY7O7zGXECtpAzsMCkI9r6xpOvf2mnvEIRqtwi+MSu/6woAQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b878ed-bad6-4199-230e-08d85a3d0852
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 12:35:45.0268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMFP04AIKtYKLayuNYEXta6SzruDIxMQ2Yz+WUgeHiP0+KZu0W1InAguKVDkROtg5hRJ8ZHQnb2/qEzSnLSAWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4791
Received-SPF: pass client-ip=40.107.243.62; envelope-from=saipava@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 08:35:46
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>,
 =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

Please ignore this

Regards,
Sai Pavan
> -----Original Message-----
> From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Sent: Wednesday, September 16, 2020 5:11 PM
> To: Peter Maydell <peter.maydell@linaro.org>; Markus Armbruster
> <armbru@redhat.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Gerd Hoffmann <kraxel@redhat.com>; Edgar Iglesias <edgari@xilinx.com>;
> Francisco Eduardo Iglesias <figlesia@xilinx.com>
> Cc: qemu-devel@nongnu.org; Alistair Francis <alistair.francis@wdc.com>;
> Eduardo Habkost <ehabkost@redhat.com>; Ying Fang
> <fangying1@huawei.com>; 'Philippe Mathieu-Daud=E9'
> <philmd@redhat.com>; Vikram Garhwal <fnuv@xilinx.com>; Paul
> Zimmerman <pauldzim@gmail.com>; Sai Pavan Boddu
> <saipava@xilinx.com>
> Subject: [PATCH v6 5/7] misc: Add versal-usb2-regs module
>=20
> This module emulates control registers of versal usb2 controller, this is
> added just to make guest happy. In general this module would control the
> phy-reset signal from usb controller, data coherency of the transactions,
> signals the host system errors received from controller.
>=20
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> ---
>  hw/misc/meson.build                          |   1 +
>  hw/misc/xlnx-versal-usb2-ctrl-regs.c         | 221
> +++++++++++++++++++++++++++
>  include/hw/misc/xlnx-versal-usb2-ctrl-regs.h |  46 ++++++
>  3 files changed, 268 insertions(+)
>  create mode 100644 hw/misc/xlnx-versal-usb2-ctrl-regs.c
>  create mode 100644 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h
>=20
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build index
> 793d45b..b336dd1 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -109,3 +109,4 @@ specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true:
> files('mips_cmgcr.c', 'mips_cp
>  specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
>=20
>  specific_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
> +specific_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true:
> +files('xlnx-versal-usb2-ctrl-regs.c'))
> diff --git a/hw/misc/xlnx-versal-usb2-ctrl-regs.c b/hw/misc/xlnx-versal-u=
sb2-
> ctrl-regs.c
> new file mode 100644
> index 0000000..6ddd38b
> --- /dev/null
> +++ b/hw/misc/xlnx-versal-usb2-ctrl-regs.c
> @@ -0,0 +1,221 @@
> +/*
> + * QEMU model of the XlnxUsb2Regs Register control block/Status for
> +USB2.0 IP
> + *
> + * This module should control phy_reset, permanent device plugs, frame
> +length
> + * time adjust & setting of coherency paths. None of which are emulated
> +in
> + * present model.
> + *
> + * Copyright (c) 2020 Xilinx Inc. Vikram Garhwal
> +<fnu.vikram@xilinx.com>
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a copy
> + * of this software and associated documentation files (the
> +"Software"), to deal
> + * in the Software without restriction, including without limitation
> +the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
> +sell
> + * copies of the Software, and to permit persons to whom the Software
> +is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
> EVENT
> +SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> +OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> +ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> +DEALINGS IN
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
> +#include "hw/misc/xlnx-versal-usb2-ctrl-regs.h"
> +
> +#ifndef XILINX_USB2_REGS_ERR_DEBUG
> +#define XILINX_USB2_REGS_ERR_DEBUG 0
> +#endif
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
> +    FIELD(COHERENCY, USB_COHERENCY, 0, 1) REG32(XHC_BME, 0x48)
> +    FIELD(XHC_BME, XHC_BME, 0, 1)
> +REG32(REG_CTRL, 0x60)
> +    FIELD(REG_CTRL, SLVERR_ENABLE, 0, 1) REG32(IR_STATUS, 0x64)
> +    FIELD(IR_STATUS, HOST_SYS_ERR, 1, 1)
> +    FIELD(IR_STATUS, ADDR_DEC_ERR, 0, 1) REG32(IR_MASK, 0x68)
> +    FIELD(IR_MASK, HOST_SYS_ERR, 1, 1)
> +    FIELD(IR_MASK, ADDR_DEC_ERR, 0, 1)
> +REG32(IR_ENABLE, 0x6c)
> +    FIELD(IR_ENABLE, HOST_SYS_ERR, 1, 1)
> +    FIELD(IR_ENABLE, ADDR_DEC_ERR, 0, 1) REG32(IR_DISABLE, 0x70)
> +    FIELD(IR_DISABLE, HOST_SYS_ERR, 1, 1)
> +    FIELD(IR_DISABLE, ADDR_DEC_ERR, 0, 1) REG32(USB3, 0x78)
> +
> +static void ir_update_irq(XlnxUsb2Regs *s) {
> +    bool pending =3D s->regs[R_IR_STATUS] & ~s->regs[R_IR_MASK];
> +    qemu_set_irq(s->irq_ir, pending);
> +}
> +
> +static void ir_status_postw(RegisterInfo *reg, uint64_t val64) {
> +    XlnxUsb2Regs *s =3D XILINX_USB2_REGS(reg->opaque);
> +    /*
> +     * TODO: This should also clear USBSTS.HSE field in USB XHCI registe=
r.
> +     * May be combine both the modules.
> +     */
> +    ir_update_irq(s);
> +}
> +
> +static uint64_t ir_enable_prew(RegisterInfo *reg, uint64_t val64) {
> +    XlnxUsb2Regs *s =3D XILINX_USB2_REGS(reg->opaque);
> +    uint32_t val =3D val64;
> +
> +    s->regs[R_IR_MASK] &=3D ~val;
> +    ir_update_irq(s);
> +    return 0;
> +}
> +
> +static uint64_t ir_disable_prew(RegisterInfo *reg, uint64_t val64) {
> +    XlnxUsb2Regs *s =3D XILINX_USB2_REGS(reg->opaque);
> +    uint32_t val =3D val64;
> +
> +    s->regs[R_IR_MASK] |=3D val;
> +    ir_update_irq(s);
> +    return 0;
> +}
> +
> +static const RegisterAccessInfo usb2_regs_regs_info[] =3D {
> +    {   .name =3D "BUS_FILTER",  .addr =3D A_BUS_FILTER,
> +        .rsvd =3D 0xfffffff0,
> +    },{ .name =3D "PORT",  .addr =3D A_PORT,
> +        .rsvd =3D 0xffffffe0,
> +    },{ .name =3D "JITTER_ADJUST",  .addr =3D A_JITTER_ADJUST,
> +        .reset =3D 0x20,
> +        .rsvd =3D 0xffffffc0,
> +    },{ .name =3D "BIGENDIAN",  .addr =3D A_BIGENDIAN,
> +        .rsvd =3D 0xfffffffe,
> +    },{ .name =3D "COHERENCY",  .addr =3D A_COHERENCY,
> +        .rsvd =3D 0xfffffffe,
> +    },{ .name =3D "XHC_BME",  .addr =3D A_XHC_BME,
> +        .reset =3D 0x1,
> +        .rsvd =3D 0xfffffffe,
> +    },{ .name =3D "REG_CTRL",  .addr =3D A_REG_CTRL,
> +        .rsvd =3D 0xfffffffe,
> +    },{ .name =3D "IR_STATUS",  .addr =3D A_IR_STATUS,
> +        .rsvd =3D 0xfffffffc,
> +        .w1c =3D 0x3,
> +        .post_write =3D ir_status_postw,
> +    },{ .name =3D "IR_MASK",  .addr =3D A_IR_MASK,
> +        .reset =3D 0x3,
> +        .rsvd =3D 0xfffffffc,
> +        .ro =3D 0x3,
> +    },{ .name =3D "IR_ENABLE",  .addr =3D A_IR_ENABLE,
> +        .rsvd =3D 0xfffffffc,
> +        .pre_write =3D ir_enable_prew,
> +    },{ .name =3D "IR_DISABLE",  .addr =3D A_IR_DISABLE,
> +        .rsvd =3D 0xfffffffc,
> +        .pre_write =3D ir_disable_prew,
> +    },{ .name =3D "USB3",  .addr =3D A_USB3,
> +    }
> +};
> +
> +static void usb2_regs_reset(DeviceState *dev) {
> +    XlnxUsb2Regs *s =3D XILINX_USB2_REGS(dev);
> +    unsigned int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(s->regs_info); ++i) {
> +        register_reset(&s->regs_info[i]);
> +    }
> +
> +    ir_update_irq(s);
> +}
> +
> +static const MemoryRegionOps usb2_regs_ops =3D {
> +    .read =3D register_read_memory,
> +    .write =3D register_write_memory,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static void usb2_regs_init(Object *obj) {
> +    XlnxUsb2Regs *s =3D XILINX_USB2_REGS(obj);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
> +
> +    memory_region_init(&s->iomem, obj, TYPE_XILINX_USB2_REGS,
> +                       USB2_REGS_R_MAX * 4);
> +    reg_array =3D
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
> +static const VMStateDescription vmstate_usb2_regs =3D {
> +    .name =3D TYPE_XILINX_USB2_REGS,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, XlnxUsb2Regs, USB2_REGS_R_MAX),
> +        VMSTATE_END_OF_LIST(),
> +    }
> +};
> +
> +static void usb2_regs_class_init(ObjectClass *klass, void *data) {
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->reset =3D usb2_regs_reset;
> +    dc->vmsd =3D &vmstate_usb2_regs;
> +}
> +
> +static const TypeInfo usb2_regs_info =3D {
> +    .name          =3D TYPE_XILINX_USB2_REGS,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(XlnxUsb2Regs),
> +    .class_init    =3D usb2_regs_class_init,
> +    .instance_init =3D usb2_regs_init,
> +};
> +
> +static void usb2_regs_register_types(void) {
> +    type_register_static(&usb2_regs_info);
> +}
> +
> +type_init(usb2_regs_register_types)
> diff --git a/include/hw/misc/xlnx-versal-usb2-ctrl-regs.h
> b/include/hw/misc/xlnx-versal-usb2-ctrl-regs.h
> new file mode 100644
> index 0000000..1d75f63
> --- /dev/null
> +++ b/include/hw/misc/xlnx-versal-usb2-ctrl-regs.h
> @@ -0,0 +1,46 @@
> +/*
> + * QEMU model of the XlnxUsb2Regs Register control block/Status for
> +USB2.0 IP
> + *
> + * Copyright (c) 2020 Xilinx Inc.
> + *
> + * Autogenerated by xregqemu.py 2020-04-08.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a copy
> + * of this software and associated documentation files (the
> +"Software"), to deal
> + * in the Software without restriction, including without limitation
> +the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
> +sell
> + * copies of the Software, and to permit persons to whom the Software
> +is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
> EVENT
> +SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> +OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> +ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> +DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef _XLNX_USB2_REGS_H_
> +#define _XLNX_USB2_REGS_H_
> +
> +#define TYPE_XILINX_USB2_REGS "xlnx.versal-usb2-ctrl-regs"
> +
> +#define XILINX_USB2_REGS(obj) \
> +     OBJECT_CHECK(XlnxUsb2Regs, (obj), TYPE_XILINX_USB2_REGS)
> +
> +#define USB2_REGS_R_MAX ((0x78 / 4) + 1)
> +
> +typedef struct XlnxUsb2Regs {
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +    qemu_irq irq_ir;
> +
> +    uint32_t regs[USB2_REGS_R_MAX];
> +    RegisterInfo regs_info[USB2_REGS_R_MAX]; } XlnxUsb2Regs;
> +
> +#endif
> --
> 2.7.4


