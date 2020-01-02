Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35C7C2D0DD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 07:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A695820672
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 07:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rSvy+SpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A695820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imugY-00045f-RD
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 02:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1imufj-0003cG-BH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 02:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1imufh-0007Ix-Eg
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 02:13:30 -0500
Received: from mail-co1nam11on2079.outbound.protection.outlook.com
 ([40.107.220.79]:9025 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1imufh-0007IJ-1u
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 02:13:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwztRdC6FbZnSO2T709iJ66mV8LwGbZ0jVt6mAyhyDjNOttwSzXQfYBwReTJ6tUvSyIcrdin0GoVb/2ZHgfZ504H+0LxPP5DRQQr4+g2lR/9gL+Y12FRhUg4kf8eKqSJ11/vzN5xDEFlotzwAsV8/qiKUpxWXGNzb3uKp9C1fMQeMUW7KtmN7xIVdTTw7g6w5EGBpXx7X8/OjyAj7qJnJS5/KoPRYmMMrGo0Jix7sg4XeQJGZeYm2ae/gkU3uaIv+NF50VhTRbB7A4HhxcJ7By4T/BfgSSR2l6Vhqwc1andD/s+ughLzKgi5VmtkNbhSzxR4ndGTzFUVeIcR1yKmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=telF/3pKcjiL2BgohfnfxYe5yMw0Yc+Y1w9krof85K8=;
 b=aBITI1iJhhbEh8hGjfWbIrnd+VbwCVlNalgeRl4ccCw71ZvNShpJF9yplVmyf7XPa40MpTSZgeT0s6R3fk6C14X3UFqsiO7mHukQA3W6UDG35DCehsaiw+JbGq/TXnY9fMLj8f2f3o7Y5/jObpc0IcACucqJklBbk6rKMq+5cBzRUvb+3hK6ui0MXpT2ooEWXEMuE+W78Hbf9wkWIoXxJiEbWKbGEvebzx5UdG2MjEsyiWVE+bUb8bKaDw3q3HewE8CGq46jyFCaeUk4Znzg9VI7agCUp9msyZZz/ZbZiMLB9KGT2Zp20yasKz2rFKHC9ddipsRinOFoEreHlcPgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=telF/3pKcjiL2BgohfnfxYe5yMw0Yc+Y1w9krof85K8=;
 b=rSvy+SpK5CO3a2DGXeq8yXj5blFQFHKdjXoGsb11y2AUvmQ0E4of+pBFKRJ9jFOLRD7FzUzzbVoLn2eaoPs/bxFq8SzoWMxMDib1tpYlo0IRpIN1t5IDZeOfY/DhUncHgywfFX0LfPSZF4JAT2n5K+J7lLV9a4IcN+Sh1Vg7J8M=
Received: from MN2PR02MB5935.namprd02.prod.outlook.com (20.179.86.87) by
 MN2PR02MB6877.namprd02.prod.outlook.com (20.180.25.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 2 Jan 2020 07:13:25 +0000
Received: from MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::ccdf:be82:7597:e916]) by MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::ccdf:be82:7597:e916%4]) with mapi id 15.20.2581.007; Thu, 2 Jan 2020
 07:13:25 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: sysbus usb xhci 
Thread-Topic: sysbus usb xhci 
Thread-Index: AdXBOtUqrwwzin1wTyqynlaACcsu6g==
Date: Thu, 2 Jan 2020 07:13:25 +0000
Message-ID: <MN2PR02MB5935CFE95528B85E06DA9583CA200@MN2PR02MB5935.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saipava@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51828e83-ff2c-48d6-855f-08d78f5342a0
x-ms-traffictypediagnostic: MN2PR02MB6877:
x-microsoft-antispam-prvs: <MN2PR02MB6877E7C761C8321B3EADAB17CA200@MN2PR02MB6877.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(366004)(39850400004)(189003)(199004)(66446008)(66476007)(81166006)(81156014)(4326008)(26005)(86362001)(66946007)(76116006)(52536014)(64756008)(66556008)(55016002)(110136005)(8676002)(316002)(33656002)(7116003)(9686003)(2906002)(3480700007)(186003)(5660300002)(8936002)(7696005)(71200400001)(4743002)(478600001)(4744005)(6506007)(9326002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB6877;
 H:MN2PR02MB5935.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cAui/CKlj3QrvK0MZ1Jns5XAcBkx9Lyl7XQf2mly0ceNgrjqUMq5K5BZW6Rxim6gM2RlfgSIWsLgCxg3kplS/1fUrM9oyJ2XALbtz4m/TBicLd6UnNxbaDdk5MZM2W1zu434Cd/3eTWGwYKr3mzmeK/guA2oObKkuKd0Xa0nlQYl7qKVdsm7xR1ZkTSZ+XVamqDFP7UU6K3+wMoIrVVb4I5W3WkqfbpqGuTe1TmpQUXeq4byBaFjrnO6Io7jqC7Fvw2fz021l0EJ41jQlv69N+iLN1EsZcWR7AfOW/NM/Dra8X2ud/u5aJWSkTEpvaT2wI4QfI2vMhNiySiYkCzK2a5JNk9AFaeDnI+PJp0I93+K1TEPjLj85k0PJnNxz3jJivCj1WH0dVT/mykkavpdcbkJSgiLvJ4czEDonf1ec1hesGuuZxpzsUmwOaai63Uq
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_MN2PR02MB5935CFE95528B85E06DA9583CA200MN2PR02MB5935namp_"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51828e83-ff2c-48d6-855f-08d78f5342a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 07:13:25.8208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDynttN7Ww06YrzN95829aZ/qmVYPb7O7uAYrAdlU+q70sVFTJTJWE6Z4ipSIqwteM6yEfl44dOM2Zy9RS1c4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6877
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.220.79
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

--_000_MN2PR02MB5935CFE95528B85E06DA9583CA200MN2PR02MB5935namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Gred,

We are seeing of options to reuse the hcd-xhci model and use it over system=
 bus interface rather than pci. (for Xilinx ZynqMP SOC, usb emulation)
Are there any plans of implementing a sysbus device ? if none it would be g=
ood if provided few pointers to start.

Im looking at hcd-ehci/ochi as a reference, let me know if there are any kn=
ow limitations for this usecase.

Thanks & Regards,
Sai Pavan


--_000_MN2PR02MB5935CFE95528B85E06DA9583CA200MN2PR02MB5935namp_
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
<style><!--
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
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"MsoNormal">Hi Gred,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are seeing of options to reuse the hcd-xhci model=
 and use it over system bus interface rather than pci. (for Xilinx ZynqMP S=
OC, usb emulation)<o:p></o:p></p>
<p class=3D"MsoNormal">Are there any plans of implementing a sysbus device =
? if none it would be good if provided few pointers to start.<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Im looking at hcd-ehci/ochi as a reference, let me k=
now if there are any know limitations for this usecase.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Pavan<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR02MB5935CFE95528B85E06DA9583CA200MN2PR02MB5935namp_--

