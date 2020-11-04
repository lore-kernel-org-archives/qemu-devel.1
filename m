Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63497C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC5F20691
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NeuroBlade.onmicrosoft.com header.i=@NeuroBlade.onmicrosoft.com header.b="cIBee3Ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC5F20691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuroblade.ai
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMTe-0007iC-NV
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shaked.m@neuroblade.ai>)
 id 1kaMSp-0006R7-Fn
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:20:51 -0500
Received: from mail-eopbgr70102.outbound.protection.outlook.com
 ([40.107.7.102]:2183 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shaked.m@neuroblade.ai>)
 id 1kaMSl-0007Lx-1x
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:20:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy63jJHAXiHqU57bxoozX3YGZdQdskvH+C4LsggQPPx9FBvE1wYTkCbBd8V5p8HfY2rH+qFqzk8iSLattRNQM1jcFnUFP0pu9F+pMZ0Om67LStomMtiwkqQFQxdghmZFSreQQvhkCX/alL8AmYQQcj5JZEWTJyd4TjfpcpOtAoH2l4OFYUPN1lN5KDDUFWrOYYqBo9BY6wGjLBGSGxXsnBazkrOGtn9hDIBh/4HUQ14rSqtzzKnf3xOe6t6iwI2nRLf2kat8U8sekJJnrnpJ/LvFVIgGHHD4vcLBbTs5ghD74hQs5T3uGeKe5uxS/eAymo64iXzPs4Y1Za+1bI3pSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BesOSfgS0XuOr2qvkKLrxcQbGYY5KBZIcp3LMrsei3g=;
 b=Bmi8Iw+7E1uYHcDluKNLr5hvOGkKXq1dsK2CLmRHZAN0bfryY9ih8q0ujuQdZ5JZ8o0JyON3euDvHY9FyRiwGI7UsV7WAwZgtjy/trqKYTIdO6Cw0n10cqVU1TJqW9g6V86dTAfpR0bmUveNVmWntmfRb7UXXgsv+vIOhzXhBguAAFN2pNUMmACjycboerkBliBOtNTl25j7uw7jSZ59ztxl7hcnbVxH09/sEoRIw3epT1huwfpEb3stSrkX4VoIhV1nLb++nILafsFYkOZfYwTpLtZAoQFwA5xXexOx49qUaOh30Lbt6INz4iViX6y/rAByqp3TPhiBzb1hDa89Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=neuroblade.ai; dmarc=pass action=none
 header.from=neuroblade.ai; dkim=pass header.d=neuroblade.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NeuroBlade.onmicrosoft.com; s=selector2-NeuroBlade-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BesOSfgS0XuOr2qvkKLrxcQbGYY5KBZIcp3LMrsei3g=;
 b=cIBee3FfxpS14D/FQw8cENxaAvzwTrTIptPeoUv6End8zCZ0PrLdSHXaCAB3y5T2VN2T47dmbSPZxCH+TNFCZ5bfTWRr+LXU1A7eZxoP36O6/1zNV9l3Pe9cBmHcw4AMZvSeD+8zpIa4k1i+3Tr+6gKr/O1VQuFlqMlc8+b8EaI=
Received: from AM9PR09MB4643.eurprd09.prod.outlook.com (2603:10a6:20b:286::17)
 by AM9PR09MB4786.eurprd09.prod.outlook.com (2603:10a6:20b:2d8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 17:05:37 +0000
Received: from AM9PR09MB4643.eurprd09.prod.outlook.com
 ([fe80::3c65:130c:3906:6542]) by AM9PR09MB4643.eurprd09.prod.outlook.com
 ([fe80::3c65:130c:3906:6542%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 17:05:37 +0000
From: Shaked Matzner <shaked.m@neuroblade.ai>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: executing user code to test qemu driver
Thread-Topic: executing user code to test qemu driver
Thread-Index: AdayyxAw30YcY7CFQgCfeGuQiNXcYQ==
Date: Wed, 4 Nov 2020 17:05:37 +0000
Message-ID: <AM9PR09MB46436ACF9B2DCE0CDDB4440382EF0@AM9PR09MB4643.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=neuroblade.ai;
x-originating-ip: [79.176.89.142]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d20fbd4e-5026-4e69-df74-08d880e3d9e3
x-ms-traffictypediagnostic: AM9PR09MB4786:
x-microsoft-antispam-prvs: <AM9PR09MB4786E6448AD3B20BB13944CA82EF0@AM9PR09MB4786.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iOmBd9/DYPuTi2HChZkPeGbFgd1cT1gARDPCA0CLQshR/8P/wIbBOc7K5W0LCXe11aoPnyNSG5+ySWICnxAZE2bF87lQVuxL1NnnCK07XY02ewJmMjhMqyicYfaqHaexNfPRCY6f4pvI+NWE+2dbBNXxnh/GQ7zxcK7gZAY19m58hvkAweKyV0XsOLW/ebGcPnU/hKAbQ6jt917NMO58ObViZ6iGBZhVp39m5uiyj/7aZeCSbeaxd9phd6Ug5D9N9dk2CSJ6nc3kQXKPkp0Ggy/Ce7yDyv16yXK2FFq5+ATbbP8u1wLQKBVdziytyckp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4643.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(39830400003)(346002)(376002)(366004)(55016002)(6916009)(2906002)(186003)(316002)(26005)(8676002)(83380400001)(6506007)(7696005)(71200400001)(52536014)(33656002)(478600001)(9686003)(8936002)(66556008)(86362001)(66476007)(66946007)(66446008)(76116006)(5660300002)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: EApPaLncwi3qG3P57nlIeR1io/wdEjv32XK4bT7VoO3zvsk+O+wfKHMTa96w/GY0ie8xdTuB0uv/BOCnSGgrAoHMHopdlGtE4+G8oTpipJLmFuVVOgtpz8Gb5iXRQKMLATccqp8mWU0zD8//KKrWVIy3rkMeR5SI7ywNAXD6az6qdxjPW5AN6H8OfxIOQNzbh6m+TcmGuut2zxJjMvdOU4rZvlot1qhGt2vUhLQRBDS88uRgNbymBCDVEz8xoh5ac2kOqMa/blmeYITqrihiBSJulg6+/G74lW1g/I2YVvN8QOTFgJhasTZCYIZiB1gmJ5K9legCIST84Fcv/T/fl/8lQqyHUT0fNrYRuTpzm5a1KlqWAxJq2HzRktUlEXx8qyOsX/6jai1l5/6MpuWXWiynBw8ZbHWrNKwbVbjoBC5ZofpAlSb7jUdGV05PHx7zVRDDPWDeA9aYOc7cAVSHcCDE8nRSjY/44M7HMECA+n2aPrMXcyklssUb7XGGAo+cT0hzS2eCxE7nH3NGp4d4QGmLMeXl7/gPwnSe2G2eZHO8W0KNGroJ+zydZFsflimx2b7Aryg+4VjUDQpCUWkdzrXnjFW7ernGK2xXQYa85mV5Wq2fKt3f7804Cbc++Nx0u8MVOFS20iKzg5Pc3HSzBQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM9PR09MB46436ACF9B2DCE0CDDB4440382EF0AM9PR09MB4643eurp_"
MIME-Version: 1.0
X-OriginatorOrg: neuroblade.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4643.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20fbd4e-5026-4e69-df74-08d880e3d9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 17:05:37.3819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63c61203-65af-4cf8-98e5-d12f35edaefa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZR7VuANRtirpdM3uYl+fw1NUvbeWqJ/Inv6rGlwGqNhAd5ZOqCpj5s/R4/+p0vDDq29ByYz0OC/KdsA/VdBZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4786
Received-SPF: pass client-ip=40.107.7.102; envelope-from=shaked.m@neuroblade.ai;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 12:20:45
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM9PR09MB46436ACF9B2DCE0CDDB4440382EF0AM9PR09MB4643eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey all,
So I've created a small test to check ioctl calls of my pci with dma driver=
, under a shared directory (which is mounted to the qemu-x86-64 instance).
I've just tried to compile it with gcc (gcc test_dma.c -o test_dma_exec)
I've tried to execute it from the qemu but it said it could not found the f=
ile, also I wonder how does it recognize my kernel and devices),
How should I compile it and run the code?
BR,
     Shaked Matzner


The contents of this email message and any attachments are intended solely =
for the addressee(s) and may contain confidential and/or privileged informa=
tion and may be legally protected from disclosure. If you are not the inten=
ded recipient of this message or their agent, or if this message has been a=
ddressed to you in error, please immediately alert the sender by reply emai=
l and then delete this message and any attachments. If you are not the inte=
nded recipient, you are hereby notified that any use, dissemination, copyin=
g, or storage of this message or its attachments is strictly prohibited.

--_000_AM9PR09MB46436ACF9B2DCE0CDDB4440382EF0AM9PR09MB4643eurp_
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
<p class=3D"MsoNormal">Hey all,<o:p></o:p></p>
<p class=3D"MsoNormal">So I&#8217;ve created a small test to check ioctl ca=
lls of my pci with dma driver, under a shared directory (which is mounted t=
o the qemu-x86-64 instance).<o:p></o:p></p>
<p class=3D"MsoNormal">I&#8217;ve just tried to compile it with gcc (gcc te=
st_dma.c -o test_dma_exec)<o:p></o:p></p>
<p class=3D"MsoNormal">I&#8217;ve tried to execute it from the qemu but it =
said it could not found the file, also I wonder how does it recognize my ke=
rnel and devices),<o:p></o:p></p>
<p class=3D"MsoNormal">How should I compile it and run the code?<o:p></o:p>=
</p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; Shaked Matzner<o:p></o:p></=
p>
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

--_000_AM9PR09MB46436ACF9B2DCE0CDDB4440382EF0AM9PR09MB4643eurp_--

