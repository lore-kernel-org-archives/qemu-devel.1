Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4505BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0869220781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DCbK/uYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0869220781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWYN-0007WW-AV
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1joWXJ-0006Ua-H2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:23:45 -0400
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com
 ([40.107.236.46]:19681 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1joWXH-0000gc-10
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:23:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWVtJOrVd3P0FawNDe4bow2RvStFzqwn8EVeGjZAqvoyfsXI9SVNM89I3P84QKQCNMkL2HLxlQppMwOx1dhVGDh7r47xyg9ogYoany2fn610lUcp5xXnBoxfdL0S9Dsvf0H15DqGeRkUzXCunXNZdsEIEPeD5lVLgQq341SmY0Fp3PlpXYd33BdArmFxTsA4yabpu8sMG4A4yoNNMjcEN667KoSp9Y71ArdHBpWR8VPjpvC8bcNr3u9gKekr38STRFQj8jzID8qU3AMBHNKZ6oEGQHzwzG78d3cQjlvaSpoPfycGs+wfRG/b+z/4AyXBy6vJ+tHleZsYfLRIvQu8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKLcnjQH1jgOt/7RTkD9RdNK6ERgQUPoVW3DRt13KTM=;
 b=AvEBMt7sef7blLUUj2smNSZdVJixz4xTtFO1c6ffFg4EWmRrrb0M2SY9r+af6GDIb3Qval+Hv0w+z2FkQl/yJhSMqCcKQYJOg+wfuqioFDMNAGZeLHK9gozBrq95BVq0ngBg+kAmGAFyXntNonczgSPzjOLRe8NZFva/07fnHr6mOAG1MumaToXpifBD6jtNFB9Ppla8un0n1wsCBFa4hq+R+1K/9FTaQSkVUz6hi/UqkrWb+QHrz03he/eEK2My54Cme+JesOaBWgxzY+cdEwNdzuGKGv+k14UlkjzVANctAyII06MOqBArmsMGlUpPt2NtmonDvt+5GmY+9FlI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKLcnjQH1jgOt/7RTkD9RdNK6ERgQUPoVW3DRt13KTM=;
 b=DCbK/uYWhoU59K7BY0UWJnPrXNlg+URw5zN8PZkDg2iQG9x/zO2OO1+2x5bPpti6mdnCvhxn2D9IhdgT3IfKkqA3mytSt/TKxxMtkNgwP0x9s0LKZGAjTyihSB08n5rw4F9ONHvQRSgblpG0U4JqegF6juu3GWqxbVRS9cr237Q=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB4136.namprd02.prod.outlook.com (2603:10b6:a02:fb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 18:08:38 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828%3]) with mapi id 15.20.3131.024; Thu, 25 Jun 2020
 18:08:38 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: RE: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci base model
Thread-Topic: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci base
 model
Thread-Index: AQHWSshDrYoefVt0mk6gEfaCZTEJaajpoDjA
Date: Thu, 25 Jun 2020 18:08:38 +0000
Message-ID: <BY5PR02MB67723A0D247E4D2BC60A0710CA920@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1593008176-9629-4-git-send-email-sai.pavan.boddu@xilinx.com>
 <87y2obzhsc.fsf@dusky.pond.sub.org>
In-Reply-To: <87y2obzhsc.fsf@dusky.pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e76996e2-ae67-4ae8-8113-08d81932c90b
x-ms-traffictypediagnostic: BYAPR02MB4136:
x-microsoft-antispam-prvs: <BYAPR02MB41361A2711C58231577F7A18CA920@BYAPR02MB4136.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLcLKgRNzq0IMQk3kYSfV3/lKy+lcS6d/9E0MbWUcAkec3rh8kIFLGlkxBXz1rYV2EkBYq7NFt17ifs7bscByB2QM0iFgwW+/N39bJ5S5srMvPK9AcOqcH5HIITo9j62II9sCBlKF52AWzzJDPJ3sDfsH9wUOXM3KMedQKmCD8o9S5QleVFgbBAwEnICWYw3b17P79AAOt/XQmVebOf/WYC2nIv5Tvd4u1Ug5Uy6b/XSE/puf/KSwrAyA6WQveUDr910jPDrq/7mo0tFmL5rX8jyYreb+C1T+KaYmuydaTcWNQ/GBYJeqkHAIBmYGXsA/OXFVGum97rtr6TtDgCtew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(39860400002)(396003)(366004)(376002)(4326008)(316002)(478600001)(55016002)(9686003)(5660300002)(7416002)(83380400001)(86362001)(2906002)(26005)(52536014)(186003)(7696005)(71200400001)(6506007)(54906003)(53546011)(66446008)(66946007)(76116006)(6916009)(66556008)(33656002)(64756008)(8676002)(8936002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: XEeffeyCvxUcwXnuVW9BcllSTcWVR23ajHlI4pByVEqT93TtRtas2vqzCiQtpXjs7BEwRAmV47G9sbQrGiZTr5JrUn1VjOwzK5WmHdfvR84xTRwuBCBKhgIT/K7mNOqBzwUPpecGFQZwTveUa9StbNBCrtjyjOPQRXtcu8uiQwVGj/ndfpUESCl8gsDBMpVcOOr2ullzxof3QnTtGytUBn/fX6CgJ31QS/S8HxbWVd5b6odaYpLe+7/R/RDN1TvGiY9ZkP9eabGo7KTWlyjM9ma2LjN7nXD9ulCeybMpYr7r7qw67Qu4t4BPJprdZ/+NX0pyHVR1NYib9btDzaVAVro06J7IIGoeXLEgU6FOOTQwB5J2Iku+Hfg0PaywnEi0qVP3RATI427I2zi8UQscQ32l1BtlusGvfsudmQJO3G3928CK01Q/tIiMaK2Xcm4FHM2Q9gG180lTxggeW9JsJ7zrRBhJRrk9E9gxJGzzO33Hg8UJ/m03Shab25/YNZO2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76996e2-ae67-4ae8-8113-08d81932c90b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 18:08:38.3724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tyi1k6glgs3wE8s0q9Wxm0drNsIhw02zvhXjILubyVWVrO7DXwuu+of2MRqpzPjvBoKv9OUrrlBSe7OAueqChg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4136
Received-SPF: pass client-ip=40.107.236.46; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 14:23:41
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
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?iso-8859-1?Q?=27Marc-Andr=E9_Lureau=27?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

> -----Original Message-----
> From: Markus Armbruster <armbru@redhat.com>
> Sent: Thursday, June 25, 2020 1:42 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Thomas Huth <thuth@redhat.com>; Eduardo
> Habkost <ehabkost@redhat.com>; qemu-devel@nongnu.org; Alistair Francis
> <alistair.francis@wdc.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Ying Fang <fangying1@huawei.com>;
> Paolo Bonzini <pbonzini@redhat.com>; 'Philippe Mathieu-Daud=E9'
> <philmd@redhat.com>
> Subject: Re: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci base
> model
>=20
> Sai Pavan Boddu <sai.pavan.boddu@xilinx.com> writes:
>=20
> > This patch sets the base to use xhci as sysbus model, for which pci
> > specific hooks are moved to hcd-xhci-pci.c. As a part of this
> > requirment msi/msix interrupts handling is moved under XHCIPCIState,
> > and XHCIState is  non qom object, make use of 'container_of' calls to
> > retrive XHCIPciState. Made required changes for qemu-xhci-nec.
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>=20
> I can't see a "sysbus model".  What I can see is
>=20
>          TYPE_DEVICE
>               |
>        TYPE_PCI_DEVICE
>               |
>         TYPE_XHCI_PCI (renamed from TYPE_XHCI)
>           /       \
> TYPE_QEMU_XHCI TYPE_NEC_XHCI
>=20
> All but the two leaves are abstract.
>=20
> Do you intend to add a "sysbus model" in a future patch?
[Sai Pavan Boddu]  Yes. I would be sending it along with that a device whic=
h would be using it. (i.e for zynqmp soc )
Let me know, if its good to include hcd-xhci-sysbus.c here ?

Regards,
Sai Pavan


