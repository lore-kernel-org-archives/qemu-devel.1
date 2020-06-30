Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFDDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 18:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CCB20722
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 18:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AjUfvb7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CCB20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqKio-0005Z4-Pp
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 14:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jqKi0-000547-TW
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 14:10:17 -0400
Received: from mail-co1nam11on2041.outbound.protection.outlook.com
 ([40.107.220.41]:53505 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jqKhx-0004Ei-M1
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 14:10:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwK2snhdCRJbuptks0lICZmUy72g+DpIBI1HoQpFHoZG6KFyGtLFwR/q7VJ1rjLv2ZtGmsIt0HZuSCqI6l6Ar9yLI90SHRh8x3iXbczcdqROXkYydfcEWVZLjM+sOVqsJzeQ4SfumhlexbMAL1FSoNUREIBukNcBQykDHcbMS139R+FMJt+W1uyLijZ8z/50MJov1Qd0LcP4ml+yx4Fwu1f+fm7JpK4tEeJuH3VCZd2+PwnALSHYgrYrPyPKusuktCC+MKMsYiCWxc3qvbOUGhwqC5Q5aDjL/XQeeFFPRCB2Li/8faIG8Y4dpYICTaUBieAZBe4Zeu5wzZduyMrcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx/LezBkXY7Zg6llLKewtwV2RG671dpwawQl/H35oL0=;
 b=DY1pPVtqFB24G5LEKsg0S/5acnDgHF4dCrPTr7HlwX79RSRfLtOFh0WPm4OZXr7kqQcjWXwgyIu9jO2c/sKMzWF+M4a0DMJ4ZMJVpSmHtbre9rIEefVPsazzSbViKEa+1eeF/+LQlACKCtVFKhziIUghx9tzAE0QVLwj3gmdBTwPuYH/pvqyu/kARsB6C5c3KwDdbciZAWIsa+6pfLqGcfhoUpby42wF4MxYpbqgEFW9dkcV4qm5fOCY7W1bDGnYf2ma2lzsJzRBds1dgJaAc2FrrtBmyX3/QktS83BiscMCM9uM05cB9cErydHx7a6gvK59TgsrXeyhB0X4JgwmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx/LezBkXY7Zg6llLKewtwV2RG671dpwawQl/H35oL0=;
 b=AjUfvb7jASIKjfCp/xOc1xrTmyStYcF11VhV799Y+eYkDlbNlry8xFYamMB1YfEa573oNXDbxPx0gpkhIi6jj4x2RunFVlX4KdLRNUP0+JxmihS8d1yANdzpMmzh9dB0yi4WcBnzrK88dp7st29tk81qpJwQmolkg7COfLSNBkw=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5542.namprd02.prod.outlook.com (2603:10b6:a03:96::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 17:55:07 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828%3]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 17:55:07 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci base model
Thread-Topic: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci base
 model
Thread-Index: AQHWSshDrYoefVt0mk6gEfaCZTEJaajpoDjAgADLyH+AAAVdsIAFkt2AgAF0QGA=
Date: Tue, 30 Jun 2020 17:55:07 +0000
Message-ID: <BY5PR02MB677235DB4A77059EC3F3D8D7CA6F0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1593008176-9629-4-git-send-email-sai.pavan.boddu@xilinx.com>
 <87y2obzhsc.fsf@dusky.pond.sub.org>
 <BY5PR02MB67723A0D247E4D2BC60A0710CA920@BY5PR02MB6772.namprd02.prod.outlook.com>
 <871rm2tkxn.fsf@dusky.pond.sub.org>
 <BY5PR02MB6772B9C9031FD35A9FA8A969CA930@BY5PR02MB6772.namprd02.prod.outlook.com>
 <20200629193843.fufoicpgkpkes6sv@sirius.home.kraxel.org>
In-Reply-To: <20200629193843.fufoicpgkpkes6sv@sirius.home.kraxel.org>
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
x-ms-office365-filtering-correlation-id: d874a959-25c5-4229-0ec4-08d81d1eb9bb
x-ms-traffictypediagnostic: BYAPR02MB5542:
x-microsoft-antispam-prvs: <BYAPR02MB55427ED27CBD82EE2A4F5A53CA6F0@BYAPR02MB5542.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AJSB9oanbkwYRglz2iCa9ADfZzK+OrY/46NI/yiRWkRbTuBDP5VscQdjeuuDYBjj7JsBdzxFglc7YYOC20umWpoARlznbVY+OYMVnbsZG/wpiPtBkvhLtFf9dlB9Fmudea8mdreSxGE3RJjjY5MxCzVkKlALR2RoyusGI9TIS4D/FQGQvWH5E2/sioKdy1E0xbyFhILRbVoVbI9uCBXTE8u4jtJ1/00shYjOLRcNZOICE5v6jae3A3UK6rZrKAqYRv5JaH5NCRIHyxaun4p4njXAr4Z0DV02RmtE4On3wPzTEVcZAA0ZvsrKSGmMjuc2CXRyeAk4yUuWOlMgsOVITQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(39860400002)(376002)(366004)(136003)(346002)(86362001)(2906002)(83380400001)(71200400001)(33656002)(7696005)(9686003)(53546011)(55016002)(7416002)(6506007)(4326008)(52536014)(478600001)(54906003)(66476007)(6916009)(8936002)(66946007)(66446008)(186003)(64756008)(8676002)(66556008)(5660300002)(26005)(76116006)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1XxfbrxQpmkeQ4Uco7ryYEubbScmvJrNcSxNXafsvscnEKTysC4UNw9xWZf+0BHomm12OAuhZ+x8wb5zpRGJaV8P4SbLnB1gi+Yc8CRcS/XOnMQTbTZVkwJU7qsTiH6OibVOrVgmk/bNr7yCLCLzw7elpyQr+Y+dzbdxZoCE/VO4bbHf1On5JDl/JPuIH8OVH1jTjiWHbDrQw/mMT73HXMwRWD1DLtQKklxOhPdyZ+y5UetOm0HLfuxuSiF1/9MolLXU40zYayrA76kjzMYN3FOmfMuTStWAhlVd3pWKsC940uBAE0asKzQIz6pCbonmZP2Zb22UeYbMGSCJcUUh1DgbmBquqLaa5w4Nn+FIbAs0RUwN/iKkdpcz4hRkW/Dn/rZ7SY5wZslR4ZVDyjIwOLGMJ/djzpdjQxYrPY89SEHysVbeGBjBeNdMYaGmZbP0jT3kaNYo+nMncgaluGdacib1N+hfAqTXSQ4cnggsrHgVLK1179lOvaZ36HDXarMJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d874a959-25c5-4229-0ec4-08d81d1eb9bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 17:55:07.3660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPUgWDGVVGc6xRP1Yx1K6DljT9ZayEZ3ZzIo6X2HeAnyo+iWBuI2UJZvQ7qV4iv58GIlBu6DU4v2fdgUZK3c/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5542
Received-SPF: pass client-ip=40.107.220.41; envelope-from=saipava@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 14:10:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?iso-8859-1?Q?=27Marc-Andr=E9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gred,

> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Tuesday, June 30, 2020 1:09 AM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Markus Armbruster <armbru@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Thomas Huth <thuth@redhat.com>; Eduardo
> Habkost <ehabkost@redhat.com>; qemu-devel@nongnu.org; Alistair Francis
> <alistair.francis@wdc.com>; Paolo Bonzini <pbonzini@redhat.com>; Ying
> Fang <fangying1@huawei.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; 'Philippe Mathieu-Daud=E9'
> <philmd@redhat.com>
> Subject: Re: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci base
> model
>=20
>   Hi,
>=20
> > > >> Do you intend to add a "sysbus model" in a future patch?
> > > > [Sai Pavan Boddu]  Yes. I would be sending it along with that a
> > > > device which would be using it. (i.e for zynqmp soc ) Let me know,
> > > > if its good to
> > > include hcd-xhci-sysbus.c here ?
>=20
> I think this would be useful, to see how the code separation plays out on=
 the
> sysbus side.
>=20
> > > Here's a clean way to provide different bus connectors (say PCI and
> > > sysbus) for the same core device:
> > >
> > > Make the core device a TYPE_DEVICE.
> > >
> > > For each desired bus, have a bus-specific device that contains a core
> device.
> > > Use object_initialize_child() for the component.
>=20
> > This was my V1 implementation.
> > Changed it to non-qom structure after some feedback from @Gred. Felt
> like XHCIState will not be used standalone.
>=20
> > > Example: core device TYPE_SERIAL, PCI device TYPE_PCI_SERIAL, ISA
> > > device TYPE_ISA_SERIAL, sysbus devices TYPE_SERIAL_IO.
> TYPE_SERIAL_MM.
>=20
> /me goes check out the serial code ...
>=20
> For reference: commit which transforms serial into the structure above is
> this:
>=20
>     commit 7781b88ee458ff933459503ade0b0a6ddaad08de
>     Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>     Date:   Mon Oct 21 23:32:12 2019 +0200
>=20
>         serial: initial qom-ification
>=20
> Note that this patch doesn't change structs, so ISASerialState still look=
s this
> way:
>=20
> struct ISASerialState {
>     ISADevice parent_obj;
>     [ ... ]
>     SerialState state;
> };
>=20
> So you can likewise keep your current "struct XHCIPciState" struct layout=
 and
> still turn XHCIState into a device object.  Which is nice to have as it b=
etter
> models the hardware (xhci core behind pci connector).
[Sai Pavan Boddu] Ok, as marcus pointed. We might be able to use it just as=
, child of a pci/sysbus based controller. Rather than using it standalone. =
I agree it looks nice that way.

Thanks,
Sai Pavan
>=20
> take care,
>   Gerd


