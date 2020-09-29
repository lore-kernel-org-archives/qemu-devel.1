Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360B7C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 05:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F43A20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 05:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Fsl5N+ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F43A20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN8eU-0006cB-MY
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 01:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kN8dW-0006A2-Lc
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 01:57:14 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com
 ([40.107.92.59]:20832 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kN8dR-0006O2-CP
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 01:57:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJIm6oOxa/9Tly0HB0LZBh9Y19kNt/vTYnj0JorO93iIN9e7BjoyYx0/Vadcfz10cruRQ1XfuQG/gZ+p7/DxAWVMsSCXUH3awz4p2dn7HakWr1hb6DCkhY2PhrGNWpqXw1fvcBy9s6Yu8Vesv8TP650kjYWN0N6lPMrW0LDZcLjHj+aQpqeea6CfW80lnGP6bM//VZzjbIiaVMNTDmaNgYLNdgthPFvCFQ23puPf5t+j3FuZPnO3PCOcC9B1tAZMQUr6TBiGSrPtpoif8XTqzobrbyZv9z/E2noVROdiD+LGT66gP27xQT8cX3D5Y5jwwWbt5XkTtfBFSbglxNetUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3NsuowTkWWUCaJ4qrJ/FnKbfe3TN+DGTYqvvLCtoXA=;
 b=XCh6XWEHsZMznhxLugyhX7JqpY7hEYEf3z00+6uSDSqwVxfSgW3uegFswbetsCk1vyJ3wIL14pl4bczUrAQX8u93VufmJOeYY96eZMkRaYFizI5ivuEPSQGp6Z4nHzw56s5K+Do8XtwtKKp3f2ISt2Kfy1MWkilRmKeI9fgdeLCY4yMVCT2YbsHg0ajRaBluNQzsdGYx6Ou0SDi1ThjC4s4LBYz7/96nAcEDCJHJnMeHICYAK9sImdhljUwDYIOXNgiSVzlqgg+fmeDf2mP+H03Y3FEsSB/TZybSM0KKZCZBvDC1sr/C1EFBPrX8nC2SdJPu34ogH4nj8Sad9yt3+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3NsuowTkWWUCaJ4qrJ/FnKbfe3TN+DGTYqvvLCtoXA=;
 b=Fsl5N+ip/kjX+VDxvFZu8MpvdNjauSscTTJFGWRXncRzQDMn9KPVDE0M2PVw+N/fObIulcCkWXhTvbjdJMs6DzLqsruSiM0hg4QNcMstZZ2LYG8bA38M/v/ffvy6nz9mEXZlpHdUiPLJ1fy4Agxll+jxXocgDQnj9dQhj0tv7WU=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5784.namprd02.prod.outlook.com (2603:10b6:a03:129::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 05:42:03 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 05:42:03 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Edgar Iglesias <edgari@xilinx.com>
Subject: RE: [PATCH v10 7/7] Versal: Connect DWC3 controller with virt-versal
Thread-Topic: [PATCH v10 7/7] Versal: Connect DWC3 controller with virt-versal
Thread-Index: AQHWkn4NObfrliwoYESqClEcN+w/eKl5sX8AgAVvrGA=
Date: Tue, 29 Sep 2020 05:42:03 +0000
Message-ID: <BY5PR02MB67721DF302CFA7EAB0F1FD4BCA320@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1600957256-6494-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600957256-6494-8-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200925183946.GP4142@toto>
In-Reply-To: <20200925183946.GP4142@toto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: efc0b491-48e4-460c-3a18-08d8643a64bb
x-ms-traffictypediagnostic: BYAPR02MB5784:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB57844FF9023C212996A3D602CA320@BYAPR02MB5784.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:357;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X7jXGZgxpYQpz3kir+j8C5OW1ha2LEH5QHrNJEbhmeSBRcQ/lROkyevQ5D9YrgvF4GggzGhkHwEoozJ4CR5ixgB7MBCUoMkGlVXXrm40XhaJRb/sfx/9Wl6Oq3Iv46d5WHHDFAMfD8ZG5hA4IGARAIqKVTqOS6CPHYAk1UKjtMLUPUaU6eabyTnP9ayadBWMXFVWj1kW+7WLCw7uRT9Qygmx5hXmP0cm5TsAmOeOWSI5UTDMvj9TQmjVETM3IesVn7AWWWs4oWUGQVPsCUZtVC6DFjhwfwJnDjDdVmt0fvMox4ae69hWdnjv/juO5qtMe2MeGg5WrHVEbtJnxDKbxqSvlyecqpeeMvX4gWHdP/pKreVMdmNCOjYTlT4tZb36
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(7696005)(83380400001)(54906003)(71200400001)(8676002)(6506007)(53546011)(8936002)(4326008)(6862004)(33656002)(66946007)(66476007)(66556008)(76116006)(9686003)(2906002)(64756008)(66446008)(7416002)(478600001)(19627235002)(86362001)(6636002)(316002)(55016002)(52536014)(186003)(5660300002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: SJpEGziFubcwQPU6+JFDnv849dAntXmQzjKTFffXJNRz632amuPdCqOMvCZmwYZir5Npl06bh87YHkTKjEoMrVkqzNODAshuV8rrREGcke8WkT/XEGDFi1o6QlfbaujhMbliDkSZ0jvZQhda5bXx/DujOJ+BFli+lJ5werNHr7fiwNakNCgcHbcXKIvntLioTFjVHz8DAgaHh+DI+Fti4h4/GCHZt4q455wIIPzlT/aSBE+mRcbtMpX5LHfbbWSkUx7SeDmio5BeHDruNE4ULvjKIXVbvtcxG+WsP1dfg/16XZTLdbK3i+cTyK+0Iy7XkdXCR+bbXMUgY9EdaPNJiskvDGmwxJgAQxNF6MHqZhM35di/17gz4QwGgAVbvhWzEPwjAFwg5vrq9UEZT3xpDKlGcPz6KUKF8uoFJdrjXHiyxDdHneBvv6moKq6K20q4aNnSEDnHPNh19PxJBNx9fFHgjojf0+E03oTSZz0EjgBHIt5XiIvMjmEqMkW1vmCRwa81J/MAlQQLKUk/ZpLsBQUAjVlk0/GOzzghn1oiLQ8BfpOQvFxqvyKYOE+zHlpkYG+XlrjiA96WXSNtG2V9eMYh3P9mdrxHr+9zG3mZpmrQZRlbgXdEONmLqR3Kd9OhGgq2mDFLB2k5lL81T7HVHQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc0b491-48e4-460c-3a18-08d8643a64bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 05:42:03.1358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nj+tkmyab3/FaPbXuVC/JWYneeoG/0dgZ5FbuEbs9hrzLWIbhlz3TZ5DlcyB2bmsdt94V5GKOsq3LmjSzhEDaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5784
Received-SPF: pass client-ip=40.107.92.59; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 01:57:07
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

> -----Original Message-----
> From: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Sent: Saturday, September 26, 2020 12:10 AM
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
> Subject: Re: [PATCH v10 7/7] Versal: Connect DWC3 controller with virt-ve=
rsal
>=20
> On Thu, Sep 24, 2020 at 07:50:56PM +0530, Sai Pavan Boddu wrote:
> > From: Vikram Garhwal <fnu.vikram@xilinx.com>
> >
> > Connect dwc3 controller and usb2-reg module to xlnx-versal SOC, its
> > placed in iou of lpd domain and configure it as dual port host
> > controller. Add the respective guest dts nodes for "xlnx-versal-virt"
> machine.
>=20
> Hi Sai,
>=20
> One minor comment inline.
>=20
> And a question, could you please post an example command-line for this?
[Sai Pavan Boddu] Below is the command to plug a usb storage device on qemu=
 command line

-device usb-storage,bus=3Dusb-bus.0,port=3D1,drive=3Dusb-stick -drive file=
=3D./usb-stick.img,id=3Dusb-stick


>=20
>=20
> >
> > Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> >  hw/arm/xlnx-versal-virt.c    | 58
> ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/arm/xlnx-versal.c         | 34 ++++++++++++++++++++++++++
> >  include/hw/arm/xlnx-versal.h | 14 +++++++++++
> >  3 files changed, 106 insertions(+)
> >
> > diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> > index 03e2320..f0ac5ba 100644
> > --- a/hw/arm/xlnx-versal-virt.c
> > +++ b/hw/arm/xlnx-versal-virt.c
> > @@ -39,6 +39,8 @@ struct VersalVirt {
> >          uint32_t ethernet_phy[2];
> >          uint32_t clk_125Mhz;
> >          uint32_t clk_25Mhz;
> > +        uint32_t usb;
> > +        uint32_t dwc;
> >      } phandle;
> >      struct arm_boot_info binfo;
> >
> > @@ -66,6 +68,8 @@ static void fdt_create(VersalVirt *s)
> >      s->phandle.clk_25Mhz =3D qemu_fdt_alloc_phandle(s->fdt);
> >      s->phandle.clk_125Mhz =3D qemu_fdt_alloc_phandle(s->fdt);
> >
> > +    s->phandle.usb =3D qemu_fdt_alloc_phandle(s->fdt);
> > +    s->phandle.dwc =3D qemu_fdt_alloc_phandle(s->fdt);
> >      /* Create /chosen node for load_dtb.  */
> >      qemu_fdt_add_subnode(s->fdt, "/chosen");
> >
> > @@ -148,6 +152,59 @@ static void fdt_add_timer_nodes(VersalVirt *s)
> >                       compat, sizeof(compat));  }
> >
> > +static void fdt_add_usb_xhci_nodes(VersalVirt *s) {
> > +    const char clocknames[] =3D "bus_clk\0ref_clk";
> > +    char *name =3D g_strdup_printf("/usb@%" PRIx32,
> MM_USB2_CTRL_REGS);
> > +    const char compat[] =3D "xlnx,versal-dwc3";
> > +
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
> > +
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
> > +
> >  static void fdt_add_uart_nodes(VersalVirt *s)  {
> >      uint64_t addrs[] =3D { MM_UART1, MM_UART0 }; @@ -515,6 +572,7 @@
> > static void versal_virt_init(MachineState *machine)
> >      fdt_add_gic_nodes(s);
> >      fdt_add_timer_nodes(s);
> >      fdt_add_zdma_nodes(s);
> > +    fdt_add_usb_xhci_nodes(s);
> >      fdt_add_sd_nodes(s);
> >      fdt_add_rtc_node(s);
> >      fdt_add_cpu_nodes(s, psci_conduit); diff --git
> > a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c index 12ba6c4..64b0d0a
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
> > +    object_initialize_child(OBJECT(s), "dwc3-0", &s->lpd.iou.usb.dwc3,
> > +                            TYPE_USB_DWC3);
> > +    dev =3D DEVICE(&s->lpd.iou.usb.dwc3);
> > +    xhci_dev =3D DEVICE(&s->lpd.iou.usb.dwc3.sysbus_xhci);
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
> > +    object_initialize_child(OBJECT(s), "usb2reg-0", &s-
> >lpd.iou.usb.Usb2Regs,
> > +                           TYPE_XILINX_VERSAL_USB2_CTRL_REGS);
> > +    dev =3D DEVICE(&s->lpd.iou.usb.Usb2Regs);
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
> > b/include/hw/arm/xlnx-versal.h index 8ce8e63..743e4f7 100644
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
> >  OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL) @@ -59,6 +61,10
> @@
> > struct Versal {
> >              PL011State uart[XLNX_VERSAL_NR_UARTS];
> >              CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
> >              XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
> > +            struct {
> > +                USBDWC3 dwc3;
> > +                VersalUsb2CtrlRegs Usb2Regs;
>=20
> I'd prefer this to be any of the following:
>=20
>                    VersalUsb2CtrlRegs ctrl;=09
[Sai Pavan Boddu] Thanks, I would use above.

Regards,
Sai Pavan
>                    VersalUsb2CtrlRegs regs;
>                    VersalUsb2CtrlRegs ctrl_regs;


