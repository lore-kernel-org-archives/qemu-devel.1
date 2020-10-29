Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21856C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0D72076D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NeuroBlade.onmicrosoft.com header.i=@NeuroBlade.onmicrosoft.com header.b="lWxjKHXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0D72076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuroblade.ai
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYEcY-0005uB-Nw
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 16:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shaked.m@neuroblade.ai>)
 id 1kYEbI-0005Dn-8z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:32:48 -0400
Received: from mail-eopbgr70123.outbound.protection.outlook.com
 ([40.107.7.123]:55402 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shaked.m@neuroblade.ai>)
 id 1kYEbE-0003sy-MC
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:32:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVdL/6mPGFVExncfacMAjuoN03bmJs//YQ8OK8NuD8tVDm7DVWT5Gc0zpfJFLqAeSIql5ZjLJfHcabtDxfCPqBUrXj4Ap1huqcumRGb9UXVq6C1sT4pumWakX7uZGccUDaomSA4zHf6+3AyaqsORigrUibTuQRDWGpCRpRJ5J1J6EpAmH0nO+iUSDXWzZMp/t+mDe+3H9bagtQLpNB7OYSU7L1ROgEfBpAkbrZYFlyYHOHN5XPpW11mWogAjDgMndOETHypVYtDNhPhyyno/FbZyXZcsplKBR98UhuZTdzb+CIHvrfNKTFGlhdXv/is0Yaz6fXdnB/PShny0Er83bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoZNJUSZO2VvygTh4qykD1DGiybQC5E1WZdZncdLWi4=;
 b=GOnRyMaLYDvu07ooBgO1r+GK5apHWhn9pvs4A0rfcUbTS78th8LYZDwNE3A7N5EKJFaXBT2V5nuFbCosZi2AgRBHadr3kZZuqKBv2eysocwc2yd3xiPMLu7XC1p1dsc3d0aXzjQBHcE1VFk44/ZsRdYDi+mOF9vlHwcPCB4r/1cAHgtZen/+Ivq8z4m5zrfY0TC7N2IaEgrTuFoUwVZspzUzVcW0UG33lFdBVRbfoF6g4QU9qm1zXfdyNPP1YHrom12TbG6yFMdy1mPiLuNbkwCWO2YXIVCe6vSymIWP2qhI3vtYg8siRlsgo3gtEnlu4ApIucX0SzsPJwajI4tShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=neuroblade.ai; dmarc=pass action=none
 header.from=neuroblade.ai; dkim=pass header.d=neuroblade.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NeuroBlade.onmicrosoft.com; s=selector2-NeuroBlade-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoZNJUSZO2VvygTh4qykD1DGiybQC5E1WZdZncdLWi4=;
 b=lWxjKHXZ8E0P71OOtIl2nUWDTCYPyluJZ49JzUM/JyyqeT4Xi/Xp53wR3pKU+Bo33ub9eAW17AboXUJD6dTeVmZ+W44MVuL73Zh9PK4Ea3XSrdRFKEGJXSBscnX9GMpidMEDMg3Z557m/Jq9hSNaT+q0uNZhWoHAEV1QEZKkuKE=
Received: from AM9PR09MB4643.eurprd09.prod.outlook.com (2603:10a6:20b:286::17)
 by AM4PR0902MB1812.eurprd09.prod.outlook.com (2603:10a6:200:92::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Thu, 29 Oct
 2020 20:32:40 +0000
Received: from AM9PR09MB4643.eurprd09.prod.outlook.com
 ([fe80::3c65:130c:3906:6542]) by AM9PR09MB4643.eurprd09.prod.outlook.com
 ([fe80::3c65:130c:3906:6542%7]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 20:32:40 +0000
From: Shaked Matzner <shaked.m@neuroblade.ai>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: simple example of pci driver with dma
Thread-Topic: simple example of pci driver with dma
Thread-Index: AdatzlSpgJldPz/zQsi+/NRP8xO5pwAPEvcAAAm5xbA=
Date: Thu, 29 Oct 2020 20:32:39 +0000
Message-ID: <AM9PR09MB4643DE281C54F5A4FA09958382140@AM9PR09MB4643.eurprd09.prod.outlook.com>
References: <AM9PR09MB4643ECD51E00A54B871DED7682140@AM9PR09MB4643.eurprd09.prod.outlook.com>
 <CAFEAcA8mcRhyYvfJyTZhdCmwkzP77Nhb=ehUBmYSiwZxMnSBdA@mail.gmail.com>
In-Reply-To: <CAFEAcA8mcRhyYvfJyTZhdCmwkzP77Nhb=ehUBmYSiwZxMnSBdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=neuroblade.ai;
x-originating-ip: [79.181.92.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da7dab94-922d-43ff-81cf-08d87c49c7d9
x-ms-traffictypediagnostic: AM4PR0902MB1812:
x-microsoft-antispam-prvs: <AM4PR0902MB181256E54010492D9858C3FF82140@AM4PR0902MB1812.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BL+SjxuAN7LVbzeIaLEi4+Qc7YRDMbSZXw+QEfmr3SLS8wu6Tbr5vzwCMCF2EXws62Rd4t/rd8caGntTyJI27N164nzD9MIizT8hu8JvCOWg0cGlKodlgZNVZCGVf2Z6KqApipDCx80WTsH0ejJknrfm5copbKaSEEEgoyXnKFBC+GwTXnv31btuonhlIPiRFiJDddh4ahtdt3IBUwpgkzYNJ1fInWVnGKq372t79QPDpijL0uutxViXTHOmOEiHalBzk0lJV00d2Ur55oP0d5hunEyoIDNdFWLjKIFwXnw2Hw4QSHZVpuS5q179CUNRIT8bbhQkQ6gSupHVu3ZqrA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4643.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(376002)(346002)(39830400003)(396003)(136003)(2906002)(9686003)(26005)(6916009)(5660300002)(66556008)(52536014)(8936002)(86362001)(8676002)(55016002)(478600001)(4326008)(316002)(83380400001)(6506007)(186003)(53546011)(66476007)(7696005)(33656002)(64756008)(66946007)(76116006)(71200400001)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: KFKNuJ9XYwuxLZw6GTEUacNC7pfzKS42Cb3G+Cp4yLH6X98HAJRWMKhsHrhUdncCBgo/jjWN7PG7c2si7EyPNi+eRBMqoBMQy0cUg24uRog6pGcoEBCGHpl3jLip9TC3S7YpMMEeRbg/Qbq7wlhgeYaJpr1/0gOIeCke+TroqJ2axKJ+Ddj3NTq2tqlhDgA9z9mKFwM65RHyGavn9OyeF5Qtk4fRzN4LE4vGlS/BVUYv+ooOG2vTmH7GD5NymsxloevkLl9vEgDJe742INSK7tiPEv7WL6qNW/1edcQsZDROdXFCIgtYaqOafCBRdlgqoj77O6TN0d5TW36QkaK4lt/huy2o6nEG0n6dLTQ0UGKOK5dKcQ6Qj8VyTeKJlDqfOJVJv6RM0ytpuNBU1PRCA8L832nj4wggJCA3mTLO8DXXap1DCxB7XrCYvWpvQnoritcOimBCnSxSLUKRDzoSwQHQ/tVXuJLILzoTB8qCVOaFGIgNVa6yZBYwF89VbszDbBC0hcVeSPwwQlnxk1Gb0hQlq57S01xUnNqzit+k825tP8d9KAh90iO/rMVT0VdL6LZAlAypb/GexG8DJIGTFIApGHbrx24mBEKJSNrfque/zqDgzynR7eNsS2BmJJDQiOAAaiec+0ToNiBs6YVhRg==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM9PR09MB4643DE281C54F5A4FA09958382140AM9PR09MB4643eurp_"
MIME-Version: 1.0
X-OriginatorOrg: neuroblade.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4643.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7dab94-922d-43ff-81cf-08d87c49c7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 20:32:39.9824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63c61203-65af-4cf8-98e5-d12f35edaefa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVqOgfChaeEGUx/FoDQt4pPHQd3UQ97k08O4697yTI5mnoqek3DPEQwDuRm5V/P0f7wrRTNUPiJycjoqWFWzQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0902MB1812
Received-SPF: pass client-ip=40.107.7.123; envelope-from=shaked.m@neuroblade.ai;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 16:32:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM9PR09MB4643DE281C54F5A4FA09958382140AM9PR09MB4643eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey Peter,
Currently I have this test in the driver which allocates data, assign it to=
 default value config source as the BASE address of dma, dest as the physic=
al address which I got from dma_alloc_coherent, set the count and assign th=
e command to raise interrupt and read,the piece of code used is something l=
ike this(this a test performed from the probe function of the driver)
                                                vaddr_to =3D dma_alloc_cohe=
rent(&(dev->dev), 4, &dma_handle_to, GFP_ATOMIC |GFP_KERNEL);
            *((volatile int*)vaddr_to) =3D 0xff;
                                                test->vaddr_to =3D vaddr_to=
;
                                                dev_info(&(dev->dev), "vadd=
r_to =3D %px\n", vaddr_to);
                                                dev_info(&(dev->dev), "dma_=
handle_to =3D %llx\n", (unsigned long long)dma_handle_to);
                                                iowrite32(DMA_BASE, mmio + =
IO_DMA_SRC);
                                                iowrite32((u32)dma_handle_t=
o, mmio + IO_DMA_DST);
                                                iowrite32(SIZE, mmio + IO_D=
MA_CNT);
                                               iowrite32(DMA_CMD | DMA_FROM=
_DEV | DMA_IRQ, mmio + IO_DMA_CMD);
Where and when should the pci_set_master hould be called?
Thanks,
             Shaked Matzner

From: Peter Maydell <peter.maydell@linaro.org>
Sent: Thursday, October 29, 2020 5:46 PM
To: Shaked Matzner <shaked.m@neuroblade.ai>
Cc: qemu-devel@nongnu.org
Subject: Re: simple example of pci driver with dma

[https://s3.amazonaws.com/staticmediafiles/media/sights/iron-icon-color.png=
]
IRONSCALES couldn't recognize this email as this is the first time you rece=
ived an email from this sender peter.maydell@linaro.org<mailto:peter.maydel=
l@linaro.org>

[EXTERNAL]

On Thu, 29 Oct 2020 at 14:59, Shaked Matzner wrote:
> however the value I get is still 255(0xff) and not 18(0x12) probably I've=
 missed something but when the interrupt is called the transfer to the RAM =
address should be completed, however it seems like the dma_write_buffer fun=
ction from the device does not perform any transfer. What Am I missing?

The usual mistake is forgetting in the guest code to program the
PCI device to enable bus mastering by setting the Bus Master bit
in the Command register in the PCI config space registers for
the device. Unless you do that then all DMA attempts will fail
(same as on real h/w). In the Linux kernel the function for this
is pci_set_master(), I think.

thanks
-- PMM


The contents of this email message and any attachments are intended solely =
for the addressee(s) and may contain confidential and/or privileged informa=
tion and may be legally protected from disclosure. If you are not the inten=
ded recipient of this message or their agent, or if this message has been a=
ddressed to you in error, please immediately alert the sender by reply emai=
l and then delete this message and any attachments. If you are not the inte=
nded recipient, you are hereby notified that any use, dissemination, copyin=
g, or storage of this message or its attachments is strictly prohibited.

--_000_AM9PR09MB4643DE281C54F5A4FA09958382140AM9PR09MB4643eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hey Peter,<o:p></o:p></p>
<p class=3D"MsoNormal">Currently I have this test in the driver which alloc=
ates data, assign it to default value config source as the BASE address of =
dma, dest as the physical address which I got from dma_alloc_coherent, set =
the count and assign the command to
 raise interrupt and read,the piece of code used is something like this(thi=
s a test performed from the probe function of the driver)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vaddr_to =3D dma_=
alloc_coherent(&amp;(dev-&gt;dev), 4, &amp;dma_handle_to, GFP_ATOMIC |GFP_K=
ERNEL);<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:1.0in">&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *((volatile int*)vaddr_to) =3D 0=
xff;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; test-&gt;vaddr_to =3D vaddr_to;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; dev_info(&amp;(dev-&gt;dev), &quot;vaddr_to =3D %px\n&quot;, vaddr_to=
);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; dev_info(&amp;(dev-&gt;dev), &quot;dma_handle_to =3D %llx\n&quot;, (u=
nsigned long long)dma_handle_to);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; iowrite32(DMA_BASE, mmio + IO_DMA_SRC);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; iowrite32((u32)dma_handle_to, mmio + IO_DMA_DST);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; iowrite32(SIZE, mmio + IO_DMA_CNT);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iowri=
te32(DMA_CMD | DMA_FROM_DEV | DMA_IRQ, mmio + IO_DMA_CMD);<o:p></o:p></p>
<p class=3D"MsoNormal">Where and when should the pci_set_master hould be ca=
lled?<br>
Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &nbsp;Shaked Matzner<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Peter Maydell &lt;peter.maydell@linaro.=
org&gt; <br>
<b>Sent:</b> Thursday, October 29, 2020 5:46 PM<br>
<b>To:</b> Shaked Matzner &lt;shaked.m@neuroblade.ai&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org<br>
<b>Subject:</b> Re: simple example of pci driver with dma<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"eyJ0eXBlIjoic2lnaHRzLWJhbm5lciIsIm5vcm10ZXh0IjoiaXJvbnNjYWxlc2Nv=
dWxkbnRyZWNvZ25pemV0aGlzZW1haWxhc3RoaXNpc3RoZWZpcnN0dGltZXlvdXJlY2VpdmVkYW5=
lbWFpbGZyb210aGlzc2VuZGVycGV0ZXJtYXlkZWxsbGluYXJvb3JnIn0:1kYA8I:pct7yR_kbZs=
lB2j1AtUcJ8iors4">
<div>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"100%" style=3D"width:100.0%;background:gainsboro">
<tbody>
<tr>
<td valign=3D"top" style=3D"padding:3.75pt 3.75pt 3.75pt 3.75pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif"><span style=3D"color:black"><img id=3D"_x0000_i1025" src=3D"https://s3=
.amazonaws.com/staticmediafiles/media/sights/iron-icon-color.png"></span><o=
:p></o:p></span></p>
</td>
<td style=3D"padding:3.75pt 3.75pt 3.75pt 3.75pt">
<p class=3D"MsoNormal"><b><span style=3D"font-size:9.0pt;font-family:&quot;=
Arial&quot;,sans-serif;color:black">IRONSCALES couldn't recognize this emai=
l as this is the first time you received an email from this sender
<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a><o:=
p></o:p></span></b></p>
</td>
</tr>
</tbody>
</table>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">[EXTERNAL]<br>
<br>
On Thu, 29 Oct 2020 at 14:59, Shaked Matzner wrote:<br>
&gt; however the value I get is still 255(0xff) and not 18(0x12) probably I=
've missed something but when the interrupt is called the transfer to the R=
AM address should be completed, however it seems like the dma_write_buffer =
function from the device does not perform
 any transfer. What Am I missing?<br>
<br>
The usual mistake is forgetting in the guest code to program the<br>
PCI device to enable bus mastering by setting the Bus Master bit<br>
in the Command register in the PCI config space registers for<br>
the device. Unless you do that then all DMA attempts will fail<br>
(same as on real h/w). In the Linux kernel the function for this<br>
is pci_set_master(), I think.<br>
<br>
thanks<br>
-- PMM <o:p></o:p></p>
</div>
</div>
<br>
<p style=3D"font-size:8pt; line-height:10pt; font-family: 'Cambria','times =
roman',serif;">
The contents of this email message and any attachments are intended solely =
for the addressee(s) and may contain confidential and/or privileged informa=
tion and may be legally protected from disclosure. If you are not the inten=
ded recipient of this message or
 their agent, or if this message has been addressed to you in error, please=
 immediately alert the sender by reply email and then delete this message a=
nd any attachments. If you are not the intended recipient, you are hereby n=
otified that any use, dissemination,
 copying, or storage of this message or its attachments is strictly prohibi=
ted. </p>
</body>
</html>

--_000_AM9PR09MB4643DE281C54F5A4FA09958382140AM9PR09MB4643eurp_--

