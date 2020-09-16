Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E136C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC1622242
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hRxHDBTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC1622242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYF0-0007lC-RV
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIYED-0007KL-Gk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:16:09 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com
 ([40.107.92.75]:56804 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIYE6-0003LS-60
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:16:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXq0z2RblvR/+pxnWoOwB7k6SPvT/o6FROl/YcBMEUFQKvHCyxpWZz0y8cQFSZ/5lVoQX+QbWXZyKtrfa7YYWDzLVx+UKW7mqeMfVtT5Y1LLcgKFLiJjJOsXUuMrUfr39/Va6n8a04Pdas/JrmfXXExoums2+b/0bVwpEDD0WgcCzkVXaYzckEkLmQTC66VaH99sUt0P50kv3DyhfOSNxeQAPmuXJwCBMn5FgZWKSo6CBuSas3JKikLFCHy0wxkWITyxm39snMKTkAbrrdbHBCB177EFv2d18SLR6JHFRmqwa/Kg5NolQ2JFdYLmj5H42ZotQgFUBkAy/h3ufmOYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbcU3sMLJaYbeDEZucL8kZGP9ncaYHonzjPrl5/r0VQ=;
 b=bsna24seVJURRBpk46LSoNgDBtwUXpksCo1rqKwYjoYJeWNBPJOHlVqwhHLW+aQ20ZQLm3+Z4U4HHQuB8Mg/zscAOcv37+X+beGqpjpb8f0J6z3KiV9bhFbP3y7h0JjwegRCb2nLJ+CAsxGs+BDjBWmOwLFgvSzRfIUb4hclU9UFGLLkrJgRBK9fFzNJm+wbjUob1oleJMteiXmNBRtzTTMsPDFVqhQ8VWGGHjGCl4RJYxNLs4u7f4YRGPfpFpy/y6BTgHJWIlTiCZX3o0Pgv5CIRMpO5Py7M3oFt0pfLYf2oVTFhnWhiBQumykiGl2GHrhG5/Hgyhl1MOXvLoLuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbcU3sMLJaYbeDEZucL8kZGP9ncaYHonzjPrl5/r0VQ=;
 b=hRxHDBTa0WzrjAVTE9TksL3Vrw+Ffn+ffnIt8W5LiBBDgnv0Ge7lwR2W4ADUrRUW6ihgEGWMvyob2JvyQmLOLvWdh3xYkN8V7v7FC0LezcYMeTzRR+uYFdLG++JPUvsngCXxVZK91Qf1hdiMLl9/4I72uM2oz8Lm7PcIIjudkPA=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6502.namprd02.prod.outlook.com (2603:10b6:a03:1da::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Wed, 16 Sep
 2020 14:15:56 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 14:15:55 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Edgar Iglesias <edgari@xilinx.com>
Subject: RE: [PATCH v6 7/7] Versal: Connect DWC3 controller with virt-versal
Thread-Topic: [PATCH v6 7/7] Versal: Connect DWC3 controller with virt-versal
Thread-Index: AQHWjB4GcR6UFQphFUayhnt5CxUcZqlrMi0AgAAdOUA=
Date: Wed, 16 Sep 2020 14:15:55 +0000
Message-ID: <BY5PR02MB677262DF80E7122060D9D448CA210@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1600256469-13130-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600256469-13130-9-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200916123048.GE4142@toto>
In-Reply-To: <20200916123048.GE4142@toto>
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
x-ms-office365-filtering-correlation-id: e8ea786d-291f-4c81-1fd7-08d85a4b06f1
x-ms-traffictypediagnostic: BY5PR02MB6502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6502BE410F6B24396FACCE1DCA210@BY5PR02MB6502.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +9GP6zfr4yhHN6ejBkGiPU/k8XFFGV1Ych01JIU/BjFkiIg7nvNhWC5Pt8AeCXVeaZe8yaxWSXnRRQVeAGwZrkuYXRU9+D5/TU+hWdr8kuYagggXbBm/l722CwjzzGc9J/rntuHvyzPPkRYO6kmTu0Mj7t1/oUX8nTZaaeY+QsTJsZ/cvbWzpyXs1Qxj2kS5+C35aLF2NOf6K6tEmspiYUUNXgrUP5m2g4RrJNTckBh023mfE/67rtTwPoc9901QQkU4qAsF6jErr9DGxQ4AoTIJU/dn2FQFxCjSl1FaMBp0I+Ei3495tIEyrbkVcRI6ghXKSQkC3ip59BqahVBZ1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(39850400004)(376002)(346002)(366004)(8676002)(2906002)(4326008)(83380400001)(6636002)(76116006)(71200400001)(8936002)(7416002)(9686003)(86362001)(55016002)(66946007)(66446008)(64756008)(66556008)(6862004)(66476007)(19627235002)(5660300002)(26005)(186003)(478600001)(6506007)(54906003)(7696005)(52536014)(316002)(53546011)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ZB3SdZukER86eOD8p1At1ksgps3HGl7ZZFjoBbYPa+2SKUyfiCxtS1LzylXHrlIu+pw2eejay2t4x66z777lTxPXZcYhGCTI/U/X0pDndDO7MYlpA3N+FuuZKv3JK4523eWjOZ2RWXz7JkxCxyN8ujA/GI9vG5TKnWmGG8eX/9YCA3/FEnsAvO2cKJ9YiB4YzxLhN9uP3SRPK4L1/4Pw70YwRaL/hQSeEmYq6NwcrNPrL6m+zRYgkXQ730+cDIMqmUlFmCobHP/RxFo3/0osYTHbw4OOjpkkno04P6k4JcZWyRJexu27KtfP/tUpnT0b+n5b6fWndMsC0kwlL8LrEk4mz5Jgocuu5x+BBqlMsFiHEetRZ55Lf3USyao8Blg7xRSy18wYSliEMMDKRH0BXU9tcx5zhi2MgW1B7XcFNin06R5uXVd3uTYbGOS4ncS9zHEx+mOY2WovCsiv/G1Ex4N43PJByu0uSN61XvKTVSYpE4tr/PJO4uPvWFOp2/A9jljZUHkao5UbU5Zk2zUwoxG5zXuWjY266MrV73qiZsX9YTJMwzitzQW13INDEnMs6AfafavLBVMEBitgD6GPGtjlFPHghbr78F0WhNcm7+TT2JWOpjiXaogbhX1+9+R0pP23ZQQx1l8yW//XegpDvg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ea786d-291f-4c81-1fd7-08d85a4b06f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 14:15:55.6232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XaIwVnLDuBRKlVvTRkDKikfUGiY7X+I/Faz1KnNYVhHbGnOhtv5wO05dE8JNtdzC24tvcBb0sYjmK+MqBgOhZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6502
Received-SPF: pass client-ip=40.107.92.75; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 10:15:59
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
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?=27Marc-Andr=E9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Edgar,

Thanks for suggestions, I will send V7 with those changes.

Regards,
Sai Pavan

> -----Original Message-----
> From: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Sent: Wednesday, September 16, 2020 6:01 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Markus Armbruster
> <armbru@redhat.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Gerd Hoffmann <kraxel@redhat.com>; Edgar Iglesias <edgari@xilinx.com>;
> Francisco Eduardo Iglesias <figlesia@xilinx.com>; qemu-devel@nongnu.org;
> Alistair Francis <alistair.francis@wdc.com>; Eduardo Habkost
> <ehabkost@redhat.com>; Ying Fang <fangying1@huawei.com>; 'Philippe
> Mathieu-Daud=E9' <philmd@redhat.com>; Vikram Garhwal
> <fnuv@xilinx.com>; Paul Zimmerman <pauldzim@gmail.com>; Sai Pavan
> Boddu <saipava@xilinx.com>
> Subject: Re: [PATCH v6 7/7] Versal: Connect DWC3 controller with virt-ver=
sal
>=20
> On Wed, Sep 16, 2020 at 05:11:09PM +0530, Sai Pavan Boddu wrote:
> > From: Vikram Garhwal <fnu.vikram@xilinx.com>
> >
> > Connect dwc3 controller and usb2-reg module to xlnx-versal SOC, its
> > placed in iou of lpd domain and configure it as dual port host
> > controller. Add the respective guest dts nodes for "xlnx-versal-virt"
> machine.
> >
> > Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> >  hw/arm/xlnx-versal-virt.c    | 55
> ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/arm/xlnx-versal.c         | 34 +++++++++++++++++++++++++++
> >  include/hw/arm/xlnx-versal.h | 12 ++++++++++
> >  3 files changed, 101 insertions(+)
> >
> > diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> > index 1f9409e..2b4564b 100644
> > --- a/hw/arm/xlnx-versal-virt.c
> > +++ b/hw/arm/xlnx-versal-virt.c
> > @@ -41,6 +41,8 @@ struct VersalVirt {
> >          uint32_t ethernet_phy[2];
> >          uint32_t clk_125Mhz;
> >          uint32_t clk_25Mhz;
> > +        uint32_t usb;
> > +        uint32_t dwc;
> >      } phandle;
> >      struct arm_boot_info binfo;
> >
> > @@ -68,6 +70,8 @@ static void fdt_create(VersalVirt *s)
> >      s->phandle.clk_25Mhz =3D qemu_fdt_alloc_phandle(s->fdt);
> >      s->phandle.clk_125Mhz =3D qemu_fdt_alloc_phandle(s->fdt);
> >
> > +    s->phandle.usb =3D qemu_fdt_alloc_phandle(s->fdt);
> > +    s->phandle.dwc =3D qemu_fdt_alloc_phandle(s->fdt);
> >      /* Create /chosen node for load_dtb.  */
> >      qemu_fdt_add_subnode(s->fdt, "/chosen");
> >
> > @@ -150,6 +154,56 @@ static void fdt_add_timer_nodes(VersalVirt *s)
> >                       compat, sizeof(compat));  }
> >
> > +static void fdt_add_usb_xhci_nodes(VersalVirt *s) {
> > +    const char clocknames[] =3D "bus_clk\0ref_clk";
> > +    char *name =3D g_strdup_printf("/usb@%" PRIx32,
> MM_USB2_CTRL_REGS);
> > +    const char compat[] =3D "xlnx,versal-dwc3";
>=20
> Need a blank line here.
>=20
> > +    qemu_fdt_add_subnode(s->fdt, name);
> > +    qemu_fdt_setprop(s->fdt, name, "compatible",
> > +                         compat, sizeof(compat));
> > +    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> > +                                 2, MM_USB2_CTRL_REGS,
> > +                                 2, MM_USB2_CTRL_REGS_SIZE);
> > +    qemu_fdt_setprop(s->fdt, name, "clock-names",
> > +                         clocknames, sizeof(clocknames));
> > +    qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> > +                               s->phandle.clk_25Mhz, s->phandle.clk_12=
5Mhz);
> > +    qemu_fdt_setprop(s->fdt, name, "ranges", NULL, 0);
> > +    qemu_fdt_setprop_cell(s->fdt, name, "#address-cells", 2);
> > +    qemu_fdt_setprop_cell(s->fdt, name, "#size-cells", 2);
> > +    qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.usb);
> > +    g_free(name);
> > +
> > +    {
> > +        const char irq_name[] =3D "dwc_usb3";
> > +        const char compat[] =3D "snps,dwc3";
>=20
> Here too.
>=20
>=20
> > +        name =3D g_strdup_printf("/usb@%" PRIx32 "/dwc3@%" PRIx32,
> > +                               MM_USB2_CTRL_REGS, MM_USB_XHCI_0);
> > +        qemu_fdt_add_subnode(s->fdt, name);
> > +        qemu_fdt_setprop(s->fdt, name, "compatible",
> > +                         compat, sizeof(compat));
> > +        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> > +                                     2, MM_USB_XHCI_0, 2, MM_USB_XHCI_=
0_SIZE);
> > +        qemu_fdt_setprop(s->fdt, name, "interrupt-names",
> > +                         irq_name, sizeof(irq_name));
> > +        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> > +                                   GIC_FDT_IRQ_TYPE_SPI, VERSAL_USB0_I=
RQ_0,
> > +                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> > +        qemu_fdt_setprop_cell(s->fdt, name,
> > +                              "snps,quirk-frame-length-adjustment", 0x=
20);
> > +        qemu_fdt_setprop_cells(s->fdt, name, "#stream-id-cells", 1);
> > +        qemu_fdt_setprop_string(s->fdt, name, "dr_mode", "host");
> > +        qemu_fdt_setprop_string(s->fdt, name, "phy-names", "usb3-phy")=
;
> > +        qemu_fdt_setprop(s->fdt, name, "snps,dis_u2_susphy_quirk", NUL=
L,
> 0);
> > +        qemu_fdt_setprop(s->fdt, name, "snps,dis_u3_susphy_quirk", NUL=
L,
> 0);
> > +        qemu_fdt_setprop(s->fdt, name, "snps,refclk_fladj", NULL, 0);
> > +        qemu_fdt_setprop(s->fdt, name, "snps,mask_phy_reset", NULL, 0)=
;
> > +        qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc)=
;
> > +        qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-
> speed");
> > +        g_free(name);
> > +    }
> > +}
> >  static void fdt_add_uart_nodes(VersalVirt *s)  {
> >      uint64_t addrs[] =3D { MM_UART1, MM_UART0 }; @@ -517,6 +571,7 @@
> > static void versal_virt_init(MachineState *machine)
> >      fdt_add_gic_nodes(s);
> >      fdt_add_timer_nodes(s);
> >      fdt_add_zdma_nodes(s);
> > +    fdt_add_usb_xhci_nodes(s);
> >      fdt_add_sd_nodes(s);
> >      fdt_add_rtc_node(s);
> >      fdt_add_cpu_nodes(s, psci_conduit); diff --git
> > a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c index 12ba6c4..88f7dc8
> > 100644
> > --- a/hw/arm/xlnx-versal.c
> > +++ b/hw/arm/xlnx-versal.c
> > @@ -145,6 +145,39 @@ static void versal_create_uarts(Versal *s,
> qemu_irq *pic)
> >      }
> >  }
> >
> > +static void versal_create_usbs(Versal *s, qemu_irq *pic) {
> > +    DeviceState *dev, *xhci_dev;
> > +    MemoryRegion *mr;
> > +
> > +    object_initialize_child(OBJECT(s), "dwc3-0", &s->lpd.iou.dwc3,
> > +                            TYPE_USB_DWC3);
> > +    dev =3D DEVICE(&s->lpd.iou.dwc3);
> > +    xhci_dev =3D DEVICE(&s->lpd.iou.dwc3.sysbus_xhci);
> > +
> > +    object_property_set_link(OBJECT(xhci_dev), "dma", OBJECT(&s-
> >mr_ps),
> > +                             &error_abort);
> > +    qdev_prop_set_uint32(xhci_dev, "intrs", 1);
> > +    qdev_prop_set_uint32(xhci_dev, "slots", 2);
> > +
> > +    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> > +
> > +    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> > +    memory_region_add_subregion(&s->mr_ps,
> MM_USB_XHCI_0_DWC3_GLOBAL, mr);
> > +    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(xhci_dev), 0);
> > +    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0, mr);
> > +
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(xhci_dev), 0,
> > + pic[VERSAL_USB0_IRQ_0]);
> > +
> > +    object_initialize_child(OBJECT(s), "usb2reg-0", &s->lpd.iou.Usb2Re=
gs,
> > +                           TYPE_XILINX_VERSAL_USB2_CTRL_REGS);
> > +    dev =3D DEVICE(&s->lpd.iou.Usb2Regs);
> > +    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> > +
> > +    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> > +    memory_region_add_subregion(&s->mr_ps, MM_USB2_CTRL_REGS,
> mr); }
> > +
> >  static void versal_create_gems(Versal *s, qemu_irq *pic)  {
> >      int i;
> > @@ -333,6 +366,7 @@ static void versal_realize(DeviceState *dev, Error
> **errp)
> >      versal_create_apu_cpus(s);
> >      versal_create_apu_gic(s, pic);
> >      versal_create_uarts(s, pic);
> > +    versal_create_usbs(s, pic);
> >      versal_create_gems(s, pic);
> >      versal_create_admas(s, pic);
> >      versal_create_sds(s, pic);
> > diff --git a/include/hw/arm/xlnx-versal.h
> > b/include/hw/arm/xlnx-versal.h index eaa9023..a428933 100644
> > --- a/include/hw/arm/xlnx-versal.h
> > +++ b/include/hw/arm/xlnx-versal.h
> > @@ -21,6 +21,8 @@
> >  #include "hw/net/cadence_gem.h"
> >  #include "hw/rtc/xlnx-zynqmp-rtc.h"
> >  #include "qom/object.h"
> > +#include "hw/usb/hcd-dwc3.h"
> > +#include "hw/misc/xlnx-versal-usb2-ctrl-regs.h"
> >
> >  #define TYPE_XLNX_VERSAL "xlnx-versal"
> >  typedef struct Versal Versal;
> > @@ -61,6 +63,8 @@ struct Versal {
> >              PL011State uart[XLNX_VERSAL_NR_UARTS];
> >              CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
> >              XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
> > +            USBDWC3 dwc3;
> > +            VersalUsb2CtrlRegs Usb2Regs;
>=20
> Can you please add a sub-struct for the usb stuff?
> e.g:
> struct {
>     USBDWC3 dwc3;
>     VersalUsb2CtrlRegs regs;
> } usb;
>=20
> >          } iou;
> >      } lpd;
> >
> > @@ -90,6 +94,7 @@ struct Versal {
> >
> >  #define VERSAL_UART0_IRQ_0         18
> >  #define VERSAL_UART1_IRQ_0         19
> > +#define VERSAL_USB0_IRQ_0          22
> >  #define VERSAL_GEM0_IRQ_0          56
> >  #define VERSAL_GEM0_WAKE_IRQ_0     57
> >  #define VERSAL_GEM1_IRQ_0          58
> > @@ -127,6 +132,13 @@ struct Versal {
> >  #define MM_OCM                      0xfffc0000U
> >  #define MM_OCM_SIZE                 0x40000
> >
> > +#define MM_USB2_CTRL_REGS           0xFF9D0000
> > +#define MM_USB2_CTRL_REGS_SIZE      0x10000
> > +
> > +#define MM_USB_XHCI_0               0xFE200000
> > +#define MM_USB_XHCI_0_SIZE          0x10000
> > +#define MM_USB_XHCI_0_DWC3_GLOBAL   (MM_USB_XHCI_0 + 0xC100)
> > +
> >  #define MM_TOP_DDR                  0x0
> >  #define MM_TOP_DDR_SIZE             0x80000000U
> >  #define MM_TOP_DDR_2                0x800000000ULL
> > --
> > 2.7.4
> >

