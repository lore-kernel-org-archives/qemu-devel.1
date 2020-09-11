Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B73C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B602B2226B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Eta/by78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B602B2226B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGk9G-0001bu-BA
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kGk7i-0000ik-8H
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:33:58 -0400
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com
 ([40.107.92.77]:14657 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kGk7f-0004rx-C4
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:33:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3UVkT+jAcYG6y+GxQbGsaUCXIdSNX4QFhkJ9iNvsjumJwV8gywV9WqHrC/H1BXw3hG+qmnKkKtKh52m2Zvpx3siYmJICwu42RY6Ifsb+3bOrGTMGUyrtZCPoq9btNCMYkA70QFY+AODGcxchPT+JcU7m88w9lPvXCNtHp0zX3bbdvoZrqa1aQqD70P8ERFfnAnpSUalEGd/ekxlndK0gt6iLJyLpNhwdUftRllIS/FwcE6F27E3zL7848R/kjLfCPpibT6WhxwVP9dsCf8f2iadvdnBvilUFlJ7MLNTaYaEfJJEfVDDdrnMoPTY5x8SXik/7b34N6/dY9SD52ki8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI8KGeaimhrLGEXTSIahFoeZtTY0rypc2DCg3FV23tk=;
 b=nniGyb268NFs75J2z57mKTLTo4ZzkZcfsQomygVNoyTkMxSkVbKv+Ok/gy8GUNtHbMpynhWeCh0kPMjyVscP8HLBIa11A9Rix0KeRHCkwb3/KmdEjcxTXsu/esW6hlnbJr6/qE2gfq1QvsqhPwEpvCf/MRgP4YH7F2JhF58mQpUdjvmcJ58LIwexCnsOtFKAHkA+0EQTXG5RyxjW1pMtn4ooukvH6/bRUh2/fglVpl87HL0fK9jEMKR83IKWaY42TxdDzoiXSq2Vc5v4Rsvnf8U/dm5xEYA+kKrGxYtTjhu1SWR9SF/hdhJjIq1YmUVbID0RyRVIlonb0gOd807qAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI8KGeaimhrLGEXTSIahFoeZtTY0rypc2DCg3FV23tk=;
 b=Eta/by78WfGcF+BPqXDwruvTq6LuPBnYOEvXAlOl989zAd34Ywmn2B4ghoT6DP/Ui7OXQbmWbMhH2Kg3JFVw9gMelX3aKAkkiM7TrAv7gfkIGE2Hvw4orXRYpsurjZZwSIahAgXCFqzDnmE8+S8px92jrt3ZV3XsLRsabJ0qHfs=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5269.namprd02.prod.outlook.com (2603:10b6:a03:6e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 11 Sep
 2020 14:18:47 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 14:18:47 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Edgar Iglesias <edgari@xilinx.com>
Subject: RE: [PATCH v5 7/7] Versal: Connect DWC3 controller with virt-versal
Thread-Topic: [PATCH v5 7/7] Versal: Connect DWC3 controller with virt-versal
Thread-Index: AQHWhzt9DAVVsuVrD0ei0ON/DTbDuqljFY0AgABosdA=
Date: Fri, 11 Sep 2020 14:18:47 +0000
Message-ID: <BY5PR02MB67724310EC96F914701F116CCA240@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1599719469-24062-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1599719469-24062-8-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200911080318.GQ14249@toto>
In-Reply-To: <20200911080318.GQ14249@toto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b172771d-f32e-4e8e-07fe-08d8565d9924
x-ms-traffictypediagnostic: BYAPR02MB5269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB52698CBE3CA750D91CB3AF9CCA240@BYAPR02MB5269.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:364;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MChfPbNv2RUoLzIapxsKT/LX+0YbLq4ZWvUqxkhfMetjk0nWQwztUwv3RXcq0YOGn8ABuZ8PrAXggIyaK5lr+Ir/Y7vBdcNv+SaJ926+begQ9SzRGz2fTyBJGxTblKhFTF3ByVXq8ovTHruhUsaVK8hOH63Zjl3YG1Bq740h3m28uzvlQdhGlY7mRl73pkI3lC+1jNUL/otYpNSt/i+5mZG3UEWOmhXeUzZDlbtsgqkcQ47z/SyeK0JsZl6CV4XHuRMXwPbOJDU47UNtcGlzIicdZfW7a8kL6KjTmflBdBt6kexv3CzPGGpmb33NjY5qEIp+EUg1Qq38TKUQlTiAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(136003)(396003)(366004)(346002)(39860400002)(2906002)(5660300002)(53546011)(7696005)(52536014)(7416002)(33656002)(6636002)(71200400001)(76116006)(478600001)(83380400001)(66946007)(86362001)(6506007)(4326008)(66446008)(8936002)(6862004)(55016002)(9686003)(54906003)(64756008)(26005)(186003)(316002)(66476007)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: EqvuK8t+G4hGqKZ+SE6CSFcqSzzyb3ZBuufkEtd9L/Nr0XI3PQp6qcE5bK7NFhhc4WCgRnoZbIl8ClXoTZqhO5WUKIHLvgiFK7Ke6grfo82dMJeNqTj6HKiDCHnRwNCDOIAXqygrHsgKB59G9S4bNg7AeZr5x3udrno0Sf+6qy1tJFwk8t4yx2OtMLkLXPOExuuqFCHIH3cEurwN95y355aLGZ3OdUaSEgk0fiEwJ5fijERgx+DSxbYVv0ZGipFthQcAenpSp2b9TQl8N09imLYHi6xevTIjmenrr//gXlprXbELtJOqhc8dQqdJbvU0RWJTahSr4Mm6VL/OMisboV6c0hlCii7yJwx9KSs3Y8xTxl4i9GGZMA9yYsO3r4y+ipdq04fqXiIVOJjhZGVBF5rUe5AaqGdoBj0tZZGkGHHha8lQCwGGpsHWRwTkPJFOlGav/JhUZ0XnuCOZN9jNCfBayQBESPdBO0lkb/nsGo8GXQTNivcEXLh0wWjlBZifxWzojvkhkhgPYteLu4v2OCIb/7TctBkpdS9MVGq+Homu4dMby5oMB2z2uUA8k0O+gggIyQnJCyr2jiEofdjlay7gnIsH7dn1Z4fIJd7fvW2XNbzYV/5N7fIwMZ2XMUJYysyieq8jAP+IyZnt3vMGLg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b172771d-f32e-4e8e-07fe-08d8565d9924
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 14:18:47.3012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7syw1Qfz3dCYnO2OzjuINon+IOTjYGHD/a2zr3nuyFdSDjfHPdnHEGmBapAYVRECYbFNBgbOEHxiH5/+negHMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5269
Received-SPF: pass client-ip=40.107.92.77; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 10:33:53
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

Thanks, I would try to clean this up as per your comments.

Regards,
Sai Pavan

> -----Original Message-----
> From: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Sent: Friday, September 11, 2020 1:33 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Markus Armbruster
> <armbru@redhat.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Gerd Hoffmann <kraxel@redhat.com>; Edgar Iglesias <edgari@xilinx.com>;
> Francisco Eduardo Iglesias <figlesia@xilinx.com>; qemu-devel@nongnu.org;
> Alistair Francis <alistair.francis@wdc.com>; Eduardo Habkost
> <ehabkost@redhat.com>; Ying Fang <fangying1@huawei.com>; 'Philippe
> Mathieu-Daud=E9' <philmd@redhat.com>; Vikram Garhwal
> <fnuv@xilinx.com>; Paul Zimmerman <pauldzim@gmail.com>
> Subject: Re: [PATCH v5 7/7] Versal: Connect DWC3 controller with virt-ver=
sal
>=20
> On Thu, Sep 10, 2020 at 12:01:09PM +0530, Sai Pavan Boddu wrote:
> > From: Vikram Garhwal <fnu.vikram@xilinx.com>
> >
> > Connect dwc3 controller and usb2-reg module to virt-versal.
> > Configure it as dual port host controller.
> >
> > Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> >  hw/arm/xlnx-versal-virt.c    | 59
> ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/arm/xlnx-versal.c         | 38 ++++++++++++++++++++++++++++
> >  include/hw/arm/xlnx-versal.h | 14 +++++++++++
> >  3 files changed, 111 insertions(+)
> >
> > diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> > index 4b3152e..398693d 100644
> > --- a/hw/arm/xlnx-versal-virt.c
> > +++ b/hw/arm/xlnx-versal-virt.c
> > @@ -39,6 +39,8 @@ typedef struct VersalVirt {
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
> > @@ -148,6 +152,60 @@ static void fdt_add_timer_nodes(VersalVirt *s)
> >                       compat, sizeof(compat));  }
> >
> > +static void fdt_add_usb_xhci_nodes(VersalVirt *s) {
> > +    const char clocknames[] =3D "bus_clk\0ref_clk";
> > +    char *usb2name =3D g_strdup_printf("/usb@ff9d0000");
>=20
> This string should be generated using the MM_USB2_REGS macro.
>=20
> > +    const char dwcCompat[] =3D "xlnx,versal-dwc3";
>=20
> You can use compat[] as we do in other places here.
>=20
>=20
> > +    qemu_fdt_add_subnode(s->fdt, usb2name);
> > +    qemu_fdt_setprop(s->fdt, usb2name, "compatible",
> > +                         dwcCompat, sizeof(dwcCompat));
> > +    qemu_fdt_setprop_sized_cells(s->fdt, usb2name, "reg",
> > +                                     2, MM_USB2_REGS, 2, 0x100);
>=20
> 0x100 as size looks small, you've added a macro for it, why not use it?
>=20
>=20
> > +    qemu_fdt_setprop(s->fdt, usb2name, "clock-names",
> > +                         clocknames, sizeof(clocknames));
> > +    qemu_fdt_setprop_cells(s->fdt, usb2name, "clocks",
> > +                               s->phandle.clk_25Mhz, s->phandle.clk_12=
5Mhz);
> > +    qemu_fdt_setprop(s->fdt, usb2name, "ranges", NULL, 0);
> > +    qemu_fdt_setprop_cell(s->fdt, usb2name, "#address-cells", 2);
> > +    qemu_fdt_setprop_cell(s->fdt, usb2name, "#size-cells", 2);
> > +    qemu_fdt_setprop_cell(s->fdt, usb2name, "phandle", s->phandle.usb)=
;
> > +    g_free(usb2name);
> > +
> > +    {
> > +        uint64_t addr =3D MM_USB_XHCI_0;
> > +        unsigned int irq =3D VERSAL_USB0_IRQ_0;
>=20
> You're only using irq once? why not just use VERSAL_USB0_IRQ_0 directly?
>=20
> > +        const char compat[] =3D "snps,dwc3";
> > +        const char intName[] =3D "dwc_usb3";
>=20
> I'd prefer interrupt_names[] or irq_names[].
>=20
>=20
> > +        uint32_t frameLen =3D 0x20;
>=20
> Can't you just directly use 0x20 when setting the prop?
>=20
> > +
> > +        char *name =3D g_strdup_printf("/usb@ff9d0000/dwc3@%" PRIx64,
> > + addr);
>=20
> We shouldn't hard-code ff9d0000 here.
> It also looks weird/wrong to have dwc3 as a subnode of usb like that.
>=20
>=20
> > +        qemu_fdt_add_subnode(s->fdt, name);
> > +        qemu_fdt_setprop(s->fdt, name, "compatible",
> > +                         compat, sizeof(compat));
> > +        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> > +                                     2, addr, 2, MM_USB_XHCI_SIZE_0);
> > +        qemu_fdt_setprop(s->fdt, name, "interrupt-names",
> > +                         intName, sizeof(intName));
> > +        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> > +                                   GIC_FDT_IRQ_TYPE_SPI, irq,
> > +                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> > +        qemu_fdt_setprop_cell(s->fdt, name,
> > +                              "snps,quirk-frame-length-adjustment",
> > +                               frameLen);
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
> > +        qemu_fdt_setprop(s->fdt, name, "snps,usb3_lpm_capable", NULL, =
0);
> > +        qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc)=
;
> > +        qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-
> speed");
> > +        g_free(name);
> > +    }
> > +}
> >  static void fdt_add_uart_nodes(VersalVirt *s)  {
> >      uint64_t addrs[] =3D { MM_UART1, MM_UART0 }; @@ -515,6 +573,7 @@
> > static void versal_virt_init(MachineState *machine)
> >      fdt_add_gic_nodes(s);
> >      fdt_add_timer_nodes(s);
> >      fdt_add_zdma_nodes(s);
> > +    fdt_add_usb_xhci_nodes(s);
> >      fdt_add_sd_nodes(s);
> >      fdt_add_rtc_node(s);
> >      fdt_add_cpu_nodes(s, psci_conduit); diff --git
> > a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c index e3aa4bd..9b241de
> > 100644
> > --- a/hw/arm/xlnx-versal.c
> > +++ b/hw/arm/xlnx-versal.c
> > @@ -145,6 +145,43 @@ static void versal_create_uarts(Versal *s,
> qemu_irq *pic)
> >      }
> >  }
> >
> > +static void versal_create_usbs(Versal *s, qemu_irq *pic) {
> > +    char *name =3D g_strdup_printf("dwc3-0");
>=20
> There's no need to allocate and format a constant string...
>=20
>=20
> > +    DeviceState *dev, *xhci_dev;
> > +    MemoryRegion *mr;
> > +
> > +    object_initialize_child(OBJECT(s), name, &s->fpd.iou.dwc3,
> > +                            TYPE_USB_DWC3);
> > +    dev =3D DEVICE(&s->fpd.iou.dwc3);
> > +    xhci_dev =3D DEVICE(&s->fpd.iou.dwc3.sysbus_xhci);
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
> > +    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0 +
> 0xC100 , mr);
> > +    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(xhci_dev), 0);
> > +    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0, mr);
> > +
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(xhci_dev), 0,
> pic[VERSAL_USB0_IRQ_0]);
> > +    g_free(name);
> > +
> > +    name =3D g_strdup_printf("usb2reg-0");
>=20
> This one too.
>=20
> > +    object_initialize_child(OBJECT(s), name, &s->fpd.iou.Usb2Regs,
> > +                           "xlnx.usb2_regs");
> > +    dev =3D DEVICE(&s->fpd.iou.Usb2Regs);
> > +    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> > +
> > +    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> > +    memory_region_add_subregion(&s->mr_ps, MM_USB2_REGS, mr);
> > +    g_free(name);
> > +}
> > +
> >  static void versal_create_gems(Versal *s, qemu_irq *pic)  {
> >      int i;
> > @@ -332,6 +369,7 @@ static void versal_realize(DeviceState *dev, Error
> **errp)
> >      versal_create_apu_cpus(s);
> >      versal_create_apu_gic(s, pic);
> >      versal_create_uarts(s, pic);
> > +    versal_create_usbs(s, pic);
> >      versal_create_gems(s, pic);
> >      versal_create_admas(s, pic);
> >      versal_create_sds(s, pic);
> > diff --git a/include/hw/arm/xlnx-versal.h
> > b/include/hw/arm/xlnx-versal.h index 9c9f47b..e19cfd5 100644
> > --- a/include/hw/arm/xlnx-versal.h
> > +++ b/include/hw/arm/xlnx-versal.h
> > @@ -20,6 +20,8 @@
> >  #include "hw/dma/xlnx-zdma.h"
> >  #include "hw/net/cadence_gem.h"
> >  #include "hw/rtc/xlnx-zynqmp-rtc.h"
> > +#include "hw/usb/hcd-dwc3.h"
> > +#include "hw/misc/xlnx-versal-usb2-regs.h"
> >
> >  #define TYPE_XLNX_VERSAL "xlnx-versal"
> >  #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj),
> > TYPE_XLNX_VERSAL) @@ -42,6 +44,11 @@ typedef struct Versal {
> >              ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
> >              GICv3State gic;
> >          } apu;
> > +
> > +        struct {
> > +            USBDWC3 dwc3;
> > +            XlnxUsb2Regs Usb2Regs;
> > +        } iou;
> >      } fpd;
> >
> >      MemoryRegion mr_ps;
> > @@ -87,6 +94,7 @@ typedef struct Versal {
> >
> >  #define VERSAL_UART0_IRQ_0         18
> >  #define VERSAL_UART1_IRQ_0         19
> > +#define VERSAL_USB0_IRQ_0          22
> >  #define VERSAL_GEM0_IRQ_0          56
> >  #define VERSAL_GEM0_WAKE_IRQ_0     57
> >  #define VERSAL_GEM1_IRQ_0          58
> > @@ -124,6 +132,12 @@ typedef struct Versal {
> >  #define MM_OCM                      0xfffc0000U
> >  #define MM_OCM_SIZE                 0x40000
> >
> > +#define MM_USB2_REGS                0xFF9D0000
> > +#define MM_USB2_SIZE                0x10000
> > +
> > +#define MM_USB_XHCI_0               0xFE200000
> > +#define MM_USB_XHCI_SIZE_0          0x10000
> > +
> >  #define MM_TOP_DDR                  0x0
> >  #define MM_TOP_DDR_SIZE             0x80000000U
> >  #define MM_TOP_DDR_2                0x800000000ULL
> > --
> > 2.7.4
> >

