Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B7DC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92CE2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92CE2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ocmigroup.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClRV-0008MW-6p
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Ilver.Belletti@ocmigroup.com>) id 1iCkRW-0008Vb-JM
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Ilver.Belletti@ocmigroup.com>) id 1iCkRT-0004cM-Ss
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:01:21 -0400
Received: from mail.ocmigroup.com ([89.96.158.60]:35832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Ilver.Belletti@ocmigroup.com>)
 id 1iCkRT-0004bF-Hl
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:01:19 -0400
Received: from MSG00.local.ocmigroup.com (192.168.1.5) by
 MSG00.local.ocmigroup.com (192.168.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 24 Sep 2019 14:45:59 +0200
Received: from MSG00.local.ocmigroup.com ([fe80::dca9:1345:3c29:d411]) by
 MSG00.local.ocmigroup.com ([fe80::dca9:1345:3c29:d411%11]) with mapi id
 15.00.1497.000; Tue, 24 Sep 2019 14:45:59 +0200
From: Ilver Belletti <Ilver.Belletti@ocmigroup.com>
To: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Subject: pcmcia support in windows xp guest
Thread-Topic: pcmcia support in windows xp guest
Thread-Index: AdVy1Qg7iUS9FbX3SXGOHOfNOA6hrQ==
Importance: high
X-Priority: 1
Date: Tue, 24 Sep 2019 12:45:59 +0000
Message-ID: <ad594e0b002f4a4daeb16dbe4ab1681b@MSG00.local.ocmigroup.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.95]
Content-Type: multipart/alternative;
 boundary="_000_ad594e0b002f4a4daeb16dbe4ab1681bMSG00localocmigroupcom_"
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 89.96.158.60
X-Mailman-Approved-At: Tue, 24 Sep 2019 09:10:42 -0400
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

--_000_ad594e0b002f4a4daeb16dbe4ab1681bMSG00localocmigroupcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We would like to install Windows XP 32 bit as a guest operating system in a=
 Windows 10 64 bit host operating system. With the QEMU emulator will be th=
e pcmcia slot available ?
We would like to use an epp parallel port in the guest operating system by =
means of Quatech pcmcia card installed in the slot.

Best Regards
Ilver Belletti
Ocmi-Otg

--_000_ad594e0b002f4a4daeb16dbe4ab1681bMSG00localocmigroupcom_
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
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.StileMessaggioDiPostaElettronica17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 2.0cm 2.0cm 2.0cm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"IT" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">We would like to install Window=
s XP 32 bit as a guest operating system in a Windows 10 64 bit host operati=
ng system. With the QEMU emulator will be the pcmcia slot available ?<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">We would like to use an epp par=
allel port in the guest operating system by means of Quatech pcmcia card in=
stalled in the slot.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best Regards<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Ilver Belletti<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Ocmi-Otg<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
</div>
</body>
</html>

--_000_ad594e0b002f4a4daeb16dbe4ab1681bMSG00localocmigroupcom_--

