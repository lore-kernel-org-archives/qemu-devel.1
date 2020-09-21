Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234CAC43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECDC2145D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 10:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UCf2eZiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECDC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKJEK-00086D-LP
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 06:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKJDj-0007gd-C0
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 06:38:55 -0400
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com
 ([40.107.236.86]:19868 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKJDh-0002lV-6h
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 06:38:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmYduQkN/HaVKwEzwh574dVGugDaVaDWgsv1dRgjSgaEn+pU3WtEGnlkbg30XLSEs4Gk4grKHoV/H/0A/zqzj4fddfec6z0+cVxA8x5/jbNGRpRaNGnYzUYdxSMUaVqoXDwsl9IlLAIwwjdaEZr11l2O4wY4sUDp1eEifU83PvaoDI1ObOxV9nHLx28kDEelOHAttmKu7DLYdyAaC0lo37Zh4+wKSkLl9H5PvWZ7aAsq+RxXx7bhF28F7/Esnk+00hulLuVpUbdmOw9p/FIRwy3PaNsnxAJW4w4RwC6M8t+sRlkxshFHJLpP6j6OoA3oqLY3XCoc8K7nGZ++W3MjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPx2XPdCfrN7Jj0Aj6Gms8fjrDaiU4KTrvaMRUr9UGY=;
 b=b8nJIKe7GpMEtVYgtmLlRem8deU1cyPxfIJeplxA4SVCx0+zpQZ0SD16nzI1Yt2pF35pr1AjCNZkC3i13NnP+GRBKgFU8Z1A83i/9wHtzlXFtv47BTUBRoixA0oIJGfkl+Gd/LzlWoNiRFAY2uX+Y3A6/oWypRf0fZD1w55NFsdLi1DFGq3Z8eo1Ax4Af89sqIRw5iqGV6SyiXU4zKMT1hfa0Cmw92Dw/95C/CCzN3uHUYGf80ZUERSCQ7xtuaSw6wvSP975cMfgXZDCGws8gCfBo2FO+2NamIWiujrjV7YuXn+2vOVDwmHXTKDwhwWHizFjve1sKxnkcSUvAb4aJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPx2XPdCfrN7Jj0Aj6Gms8fjrDaiU4KTrvaMRUr9UGY=;
 b=UCf2eZiue2LS74P0CMPR987YW6ZqLt+8ABjaqCEltXpau6ApOuegzIqgInnYxB/K6L8fchXkoDiS8HJ6m5EGqVTk7ZS3XrGl6sJjqNHAQKEcuJOJ7V51bLh12Ys5D2jOAZfh6YNNHtwrKAc/fq4lT4844QEBiEQLpQlTn1YLOUY=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5781.namprd02.prod.outlook.com (2603:10b6:a03:121::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 10:23:48 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f%6]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 10:23:48 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH v7 3/7] usb/hcd-xhci: Split pci wrapper for xhci base model
Thread-Topic: [PATCH v7 3/7] usb/hcd-xhci: Split pci wrapper for xhci base
 model
Thread-Index: AQHWjDSLz43wsxuBK0SAtVI1dSocLKlst0gAgAYymIA=
Date: Mon, 21 Sep 2020 10:23:47 +0000
Message-ID: <BY5PR02MB67728C3C8852FA9F1343C9F0CA3A0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1600266140-20763-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600266140-20763-4-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200917114406.sudvur5sjt4nqjd4@sirius.home.kraxel.org>
In-Reply-To: <20200917114406.sudvur5sjt4nqjd4@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c269d5c-c3ee-4281-c69a-08d85e186d80
x-ms-traffictypediagnostic: BYAPR02MB5781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5781C91D88E32A8C35F84B53CA3A0@BYAPR02MB5781.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a8S5hhsKP6yngkNrTYLLItR+Zoek3gExW0sK391s9UK9CQv28tPFU3JLaSCPz1/EKeTWvF9myzNijTKlkcyJNCMO9fdiazLWlqtrFP3c4PB8knYbQTKQ3qWreuGJX05SOhjw3zMT1B6+Ajz6NW3+o0QlzhQo8KvJ/LqnLoN/j3ejljQTOa24oPa27J+bzLgho4v0qrtafiTuoBqtFlbGUDqM+PI7Rj5q2qX+4tokorhAH4Ah4LwjSghfRGB5tD1DVqGw9AfnFV5IK4CG6lKyFdFnWZCkypBqac45a66oM837CJeig+M3ACKLTNnc2PYEpKa7uWwCmXdrUOUoX3wjlA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(376002)(346002)(366004)(39850400004)(2906002)(64756008)(66556008)(66446008)(52536014)(66476007)(33656002)(83380400001)(54906003)(5660300002)(7416002)(4326008)(186003)(8936002)(8676002)(71200400001)(26005)(55016002)(478600001)(66946007)(76116006)(9686003)(316002)(53546011)(86362001)(7696005)(6506007)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JcQAVC7A1P/qbzJg/1lqiqJ3K4TZU77J5V/EQJ224648tIV/Z3Owp3gIE3S0hvlYA7eJ//rL6OoRRqex6ZDLG7U7pDPrxSy3MrYw4onTqIV37+KHBAvZE8FpfSFPjLvV6cjCcYcYw+JM2vFKsmwZgTf5feJeEp3Nw7/As2Hv2wvACRpz3Q16eAWEXZm4sOXpyc4qoYX4gVN8CODjCM1oVMiBeZ7o0uDtQv74f7MQH5+zumXoqKZyr6XFSHIkULLSAfYeqLABXqBRv9aynYD3fi/c0BtjZyTEl2M9GgDVBuP3eXYPjlcX853gwMU1hpc6UmwGdISrZNOWSFKwK9+PN2/fShLL3nFTCQAPqpnIvMDorqF4Sq9XrPMpwifRf50O1BiO3TjcEPiD/qcsajgmesfJkBKljAB2Y1lkn7Ful1q2g/dyLz84ZrzZOO/p7KHXbAu1jCShdxtXML05f47OXY+ojMzjIfFTxU/yuxO6w4votrRhMgsAJ6ZZyhVX2MDafevylN7/l1fTSLjaUXh3dmdCEcD3pGbC8hHE1sg6GHbNKyyTKuY2DqL2kRhbhkAH6LAqsiDbhQryLKWXdFQvf8nYuOXTDi4ic6FES6qxD55tXzq420QWP02p2X7I/TugmdAcu0IDJCQpKJZThzc4zA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c269d5c-c3ee-4281-c69a-08d85e186d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 10:23:47.9927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WssP0rNVLbM56uD9zLr4UR42TUFQXIWnaty8pUPb/AoUbGIYWLx8vXEzf8w4lopXdNOlkUE5rZx1fbM8W5wawQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5781
Received-SPF: pass client-ip=40.107.236.86; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 06:38:51
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

Thanks, I will update this in V8.

Regards,
Sai Pavan
> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Thursday, September 17, 2020 5:14 PM
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
> Subject: Re: [PATCH v7 3/7] usb/hcd-xhci: Split pci wrapper for xhci base
> model
>=20
>   Hi,
>=20
> > +static const VMStateDescription vmstate_xhci_pci =3D {
> > +    .name =3D "xhci-pci",
> > +    .version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_PCI_DEVICE(parent_obj, XHCIPciState),
> > +        VMSTATE_MSIX(parent_obj, XHCIPciState),
> > +        VMSTATE_UINT8_ARRAY(msix_used, XHCIPciState, MAXINTRS),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
>=20
> > @@ -3634,7 +3527,6 @@ static const VMStateDescription
> vmstate_xhci_intr =3D {
> >          VMSTATE_UINT32(erdp_high,     XHCIInterrupter),
> >
> >          /* state */
> > -        VMSTATE_BOOL(msix_used,       XHCIInterrupter),
> >          VMSTATE_BOOL(er_pcs,          XHCIInterrupter),
> >          VMSTATE_UINT64(er_start,      XHCIInterrupter),
> >          VMSTATE_UINT32(er_size,       XHCIInterrupter),
> > @@ -3657,9 +3549,6 @@ static const VMStateDescription vmstate_xhci =3D =
{
> >      .version_id =3D 1,
> >      .post_load =3D usb_xhci_post_load,
> >      .fields =3D (VMStateField[]) {
> > -        VMSTATE_PCI_DEVICE(parent_obj, XHCIState),
> > -        VMSTATE_MSIX(parent_obj, XHCIState),
> > -
> >          VMSTATE_STRUCT_VARRAY_UINT32(ports, XHCIState, numports, 1,
> >                                       vmstate_xhci_port, XHCIPort),
> >          VMSTATE_STRUCT_VARRAY_UINT32(slots, XHCIState, numslots, 1,
>=20
> Uh oh, that'll break cross-version live migration (i.e. save state with 5=
.1, load
> with 5.2).  Sorry for not noticing this earlier.
>=20
> You can't remove the msix_used field.  I guess easiest is to just leave t=
hat in
> XHCIInterrupter even if only xhci-pci actually uses it.
>=20
> The vmstate_xhci + vmstate_xhci_pci reorganization should work with a few
> changes:
>  * First it must be one vmstate which keeps the fields in order.
>    I think you can do that by not registering vmstate_xhci directly, but
>    using an VMSTATE_STRUCT() entry in vmstate_xhci_pci.
>  * Second the name must not change, so vmstate_xhci_pci must continue to
>    use the "xhci" name.
>  * I think for vmstates referenced by VMSTATE_STRUCT the name doesn't
>    matter, so you could rename vmstate_xhci to -- for example --
>    "xhci-core" so vmstate_xhci and vmstate_xhci_pci have different
>    names.
>=20
> take care,
>   Gerd


