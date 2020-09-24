Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84511C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD25F221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FZr4sTjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD25F221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLS4g-0003qQ-Pm
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kLS2f-0002pi-8V
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:16:14 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com
 ([40.107.92.40]:60423 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kLS2Z-0002FE-5u
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:16:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju0+0Z6cjJzlYRzXR3bENLHO8+FZ9y9BFa+bMa4D4Vi47REgk0kpNTV/tWJpkVrqZudOBUwAl2mxkYUe+6N/N1+W5GUM4qSDrCQ5tPoNyXKYAiz30UAu310+vXAiKzU/aJHgpCeNKko/kUg0igd99tfPMjlrX1wAZhjHiwk6zj2qc0LLX5WU2urztzRQQZRR0Jz3iAqLGatVV9fa24F79LI6eyGMx4+H7rFBm3C0omS0QLm6ikkmBBDQe8CQJSYnROMrCzi0F/LRyRSnM21rSbZTF+hijmIsDGcSDSJjHT6nU+qu5fT+Z/yKEyI7RDSpthF+hvtWd5rR2S9tO1WBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN/yJ7IbDrvTJOnvm1ECho2Sp9euVsnVU6jhFd6m2eQ=;
 b=VXOatyAmOUBqKTGqTEBRaE+BpjWXJH4WNhs4G+nWFwv1aiyW97GAPNtZeMOrXc3/FoV7zA7ruLbL9F/dBRD8CE0GX4lbZ+fTLw3Cnp/Ng4jQf3m3UxFppR+KAR2YjKYULSwgNr2KPYapGchnogzJ+ub7O/nNFKctHcV6XE1izlHb69wlVjGrOb5sA2GjFivwcP6tz50EKhMA+EFBq8KAaw/Eby3/NwxQKvJzLmLZR+esSu+kan00RNrhYJp/0cj5PXtMDyrTbfDyscwZI7m1IZ7wk/YVs9dK+yIkDvMlthrSN0MixCBDlM1FOI1B15P36z3n2CdRF2EyxwgUxN/TJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN/yJ7IbDrvTJOnvm1ECho2Sp9euVsnVU6jhFd6m2eQ=;
 b=FZr4sTjN/w8NNdu27Gy+OErfU5T3ITkDKY1DLGW8CWrFlovPJhgqr8mntjksrAswZvKpKSh7QIXXnlj9oYZ1cwIh7cL4dOOIk3QmRsEnybdGF++KzTZfipDlHHBs5dfo94mx5aMKjzdjJ/x9bZGysbICynV3GWVSXZdeY/iOQEw=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB6438.namprd02.prod.outlook.com (2603:10b6:a03:11d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Thu, 24 Sep
 2020 14:16:05 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 14:16:05 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH v9 3/7] usb/hcd-xhci: Split pci wrapper for xhci base model
Thread-Topic: [PATCH v9 3/7] usb/hcd-xhci: Split pci wrapper for xhci base
 model
Thread-Index: AQHWkdGMjbNag9RYtE21jHcM44MQQKl3UHWAgACEerA=
Date: Thu, 24 Sep 2020 14:16:04 +0000
Message-ID: <BY5PR02MB677220A6C434DC68529AD545CA390@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1600883407-15147-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600883407-15147-4-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200924061507.2ztaxii76f6gvmfm@sirius.home.kraxel.org>
In-Reply-To: <20200924061507.2ztaxii76f6gvmfm@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [49.205.235.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9878cae-3f32-4074-bb45-08d860945fc6
x-ms-traffictypediagnostic: BYAPR02MB6438:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB64388800BA75C2C709E10F85CA390@BYAPR02MB6438.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NQdHNEp2LSexYBkVi3hEw37uuGySXSWkCLdliXViA1Vah736uVOVMyiHwuSRC0h9c5iUQQ+i7d1N7ZlPi+Vomf2pJkHWQucMdHF8jX+IAC5ueK0cWUTxekVZml2Ji6odm259abK7Mc65q4yZdGHC5MCqyyoRdMJfTH3ZyE4KRgQUz93cnX/w11NuapG8nHDRL/CHpKh8SUdu02VYmRMVlWjYvvQ/oNb+xoqpdOf4ILXUsjyZlCBUhkaA05pf5vJJf+Y/44nAg7ajrAyw3MChiqc3JWQPUYTLVbvmmRXDzYBS0y4EV0VPrVqcenYJj1BuU9xkJuvMBE5zkbVQe3qcuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(376002)(346002)(396003)(366004)(39860400002)(66446008)(76116006)(33656002)(64756008)(7416002)(55016002)(83380400001)(26005)(2906002)(186003)(6506007)(7696005)(53546011)(9686003)(4326008)(66556008)(316002)(54906003)(8936002)(66476007)(66946007)(478600001)(6916009)(5660300002)(52536014)(86362001)(71200400001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5OBHcTk3imDyqzCtixYvZXb1PZFmYmu3jkThwPpvo7IqBy3ewlmnDqTuAI6uA5W7XbOAdLP6SRfkCKl9fmqvSOf0tZzMfDYuniCHS6O1/85059fZ3W1AikslAWx58B7RxRg5PQ7AMSvX1H1GQdUZRhOdclWELG+uwWWV/y50C/w4CGv9POdCFYBBBkzSIPIRpnHLfRy5S8yZbVER726eUDBO8OrFAhPfOZwyEyXPVq93k8IfmHhA/ISitVPaYCuAFMAoineHzf8FZZCIXBifvHgem3BhDxgzbo5h4pw6iRXVeDcpJm2BLrcWB1E26Q7AzONLPvtqyl3fLMi8YbQV6hkqurt3muK40iEcLbWo/yTftfjz+pWjUbnDEkRUs5y9hhei+bznD3TH97hHFEUZ/okHwIS4wp/EagfHp4hCIUlbSxctOsCUvz3GH5kSm9EiUhxdr3o8SSD1YYz3QFgWmFeCDLIAaPo+dIxQvZ782Jr5Tna3pJ+di5tT70MfROtOwa7QkfaoJ/vTqxv8i9MRBqsLQlLJPiQ13ZYTJ8JuqMxfNavYwhf7s+1Rc6EfOS/t5S6qSStYQL0tY+awZtYhVoy1ltx4Cg+BsPN8C6uutuKmHvGEosQoXbMUJ41sm3QtNbnrmx+3RAAdlnVeH4snbg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9878cae-3f32-4074-bb45-08d860945fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 14:16:04.9926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XQogO6aRwildIlIw/v0DGBrAM6GnDeEgHs+a2bRcBP3cttULR47OtwkrcG6zpc5o6XjOQOPkuSSVzyMKOB6Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB6438
Received-SPF: pass client-ip=40.107.92.40; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 10:16:06
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
 Alistair Francis <alistair.francis@wdc.com>,
 =?iso-8859-1?Q?=27Marc-Andr=E9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Thursday, September 24, 2020 11:45 AM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Markus Armbruster
> <armbru@redhat.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Edgar Iglesias <edgari@xilinx.com>; Francisco Eduardo Iglesias
> <figlesia@xilinx.com>; qemu-devel@nongnu.org; Alistair Francis
> <alistair.francis@wdc.com>; Eduardo Habkost <ehabkost@redhat.com>;
> Ying Fang <fangying1@huawei.com>; 'Philippe Mathieu-Daud=E9'
> <philmd@redhat.com>; Vikram Garhwal <fnuv@xilinx.com>; Paul
> Zimmerman <pauldzim@gmail.com>; Sai Pavan Boddu
> <saipava@xilinx.com>
> Subject: Re: [PATCH v9 3/7] usb/hcd-xhci: Split pci wrapper for xhci base
> model
>=20
>   Hi,
>=20
> > @@ -203,8 +202,10 @@ struct XHCIState {
> >      uint32_t numslots;
> >      uint32_t flags;
> >      uint32_t max_pstreams_mask;
> > -    OnOffAuto msi;
> > -    OnOffAuto msix;
> > +    void (*intr_update)(XHCIState *s, int n, bool enable);
> > +    void (*intr_raise)(XHCIState *s, int n, bool level);
> > +    void (*vmstate_post_load)(XHCIState *xhci);
>=20
> No need to create your own post_load hook, there is one in
> VMStateDescription ready for use ;)
[Sai Pavan Boddu] Yes thanks, I did not realize this can be used aswell.

Regards,
Sai Pavan
>=20
> take care,
>   Gerd
>=20
> [ I can squash that into 3/7 if you have no objections ]
>=20
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h index
> 294bdc62aeaf..f859a17e73ee 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -205,7 +205,6 @@ typedef struct XHCIState {
>      uint32_t max_pstreams_mask;
>      void (*intr_update)(XHCIState *s, int n, bool enable);
>      void (*intr_raise)(XHCIState *s, int n, bool level);
> -    void (*vmstate_post_load)(XHCIState *xhci);
>      DeviceState *hostOpaque;
>=20
>      /* Operational Registers */
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c index
> f06a2b7f4c57..77608fb78def 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -85,19 +85,21 @@ static void xhci_pci_reset(DeviceState *dev)
>      device_legacy_reset(DEVICE(&s->xhci));
>  }
>=20
> -static void xhci_pci_vmstate_post_load(XHCIState *xhci)
> +static int xhci_pci_post_load(void *opaque, int version_id)
>  {
> -    XHCIPciState *s =3D container_of(xhci, XHCIPciState, xhci);
> +    XHCIPciState *s =3D opaque;
> +    XHCIState *xhci =3D &s->xhci;
>      PCIDevice *pci_dev =3D PCI_DEVICE(s);
>      int intr;
>=20
> -   for (intr =3D 0; intr < xhci->numintrs; intr++) {
> +    for (intr =3D 0; intr < xhci->numintrs; intr++) {
>          if (xhci->intr[intr].msix_used) {
>              msix_vector_use(pci_dev, intr);
>          } else {
>              msix_vector_unuse(pci_dev, intr);
>          }
>      }
> +    return 0;
>  }
>=20
>  static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp) @@=
 -
> 114,7 +116,6 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev,
> Error **errp)
>      object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
>      s->xhci.intr_update =3D xhci_pci_intr_update;
>      s->xhci.intr_raise =3D xhci_pci_intr_raise;
> -    s->xhci.vmstate_post_load =3D xhci_pci_vmstate_post_load;
>      object_property_set_bool(OBJECT(&s->xhci), "realized", true, &err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -176,6 +177,7 @@ static void usb_xhci_pci_exit(PCIDevice *dev)  static
> const VMStateDescription vmstate_xhci_pci =3D {
>      .name =3D "xhci",
>      .version_id =3D 1,
> +    .post_load =3D xhci_pci_post_load,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_PCI_DEVICE(parent_obj, XHCIPciState),
>          VMSTATE_MSIX(parent_obj, XHCIPciState), diff --git a/hw/usb/hcd-
> xhci.c b/hw/usb/hcd-xhci.c index 4a6c0e7edb1a..b1b95abb9b29 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3457,9 +3457,6 @@ static int usb_xhci_post_load(void *opaque, int
> version_id)
>          }
>      }
>=20
> -    if (xhci->vmstate_post_load) {
> -        xhci->vmstate_post_load(xhci);
> -    }
>      return 0;
>  }
>=20


