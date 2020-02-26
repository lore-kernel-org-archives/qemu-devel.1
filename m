Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811B1C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E00424684
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b="H3FTsvk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E00424684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=msn.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6wRb-00056B-EX
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 08:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <skizzato73@msn.com>) id 1j6wQa-0004Yj-5T
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skizzato73@msn.com>) id 1j6wQW-0002Xz-Vs
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:08:40 -0500
Received: from mail-am6eur05olkn2080c.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::80c]:11328
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <skizzato73@msn.com>)
 id 1j6wQP-00028A-E9; Wed, 26 Feb 2020 08:08:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDLV8vsfY4z+QqlU97wBm6ak5KgnKQogxc9670dCXYM5PCu/0ykkrodf7zG6rDcn+nyh7VfmadCsvSochOdmeVJiA2o7QbL03hhMwLmCeugralVA5ejuX//USCmhMo8qCjb2WNlvFkhEQoo826UJUgZXi3g/kjrm1Ww+AyNKbn09KYrBUo6ErZ/I7IyDGppVEflj6HBniIo7j2Unz+HIkxBR3jNCnxYGyj4djc3QpyG4bZPc+HeMCnbjdy4asdPbCIHl5C5KfZV2BJ8RgAguhN0oNejr9kSGgR3dYjrQcSJckI4L7GPLC9hcW483BzPv+SPS3+hDCHsXUXbGYd1FJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V/Z/JBVKgf5SIXiw9jMbPnM571SAy52HqMkntrNG14=;
 b=kirlKZ7tWbLJ32QRUFU+U00BwN+F+FSntSiJ+rJl7essG3yRz9+JUD+9BWlDEx2m+IEPyEkazRZcymH9MF8G4qEtCWPvsBq5wM1/ImWtC0sDeFy/X/YxyfhDaTcFDskEezmRYcVbhC20+B+tJLvKC/QkGYyrOUf9kwSdYLeX1UnH8TPF8jIOj3hfUgZNvj5SFoYs0VtSRbe2uy/mbvoryh8ZfOyaqL5mcHJFconolCB1jufBzdzBHmawbGhDQwJZSRPfiyodcFhMpAudVQxJi288hT49esAweaRJS7uBJRlm9lhBV+ILpikgJpn+0PRXwl/L3f7+Q7E+e61ARtQ75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V/Z/JBVKgf5SIXiw9jMbPnM571SAy52HqMkntrNG14=;
 b=H3FTsvk2uOIHgnqMF7SOaVfTgtV+u7BQj4szjVfIZ+3cIViIiSY70+mFi9WYuGp00pJYaHQtRI2Rm4QaPtEf3br/7cEsKsQyJgh4BQdNuQqKJDhEm56RHAVm0gc+iYpnZMF37M1fdFBJzx76haEN0Q4yZSDi6rw3hat6ceT969r2DM9AVBaoXWP/nmJg66phinYQz3lbVm1xHxdSkqXXdfRByzwri51ZoOPYeHcBNIT/32ypwf29On7albeM37xw9K2nKhyp89lSLJc3Fa+DSs0Tv4T6mxcpwh1eFQuzhPgZG7vEDQLt/I/lePfd8s06ezXutz0lOlG3iTtiLHdABA==
Received: from DB8EUR05FT025.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::3a) by
 DB8EUR05HT124.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::148)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 26 Feb
 2020 13:08:26 +0000
Received: from AM4PR07MB3506.eurprd07.prod.outlook.com (10.233.238.58) by
 DB8EUR05FT025.mail.protection.outlook.com (10.233.239.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 13:08:26 +0000
Received: from AM4PR07MB3506.eurprd07.prod.outlook.com
 ([fe80::1d5b:5d66:1368:39c4]) by AM4PR07MB3506.eurprd07.prod.outlook.com
 ([fe80::1d5b:5d66:1368:39c4%3]) with mapi id 15.20.2772.012; Wed, 26 Feb 2020
 13:08:26 +0000
From: Dino Papararo <skizzato73@msn.com>
To: luigi burdo <intermediadc@hotmail.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, Programmingkid <programmingkidx@gmail.com>
Subject: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
Thread-Topic: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
Thread-Index: AQHV5n9iGhp7OH0uf0GD6Z/qd6KtDaghy0MAgADcEYCACJz9gIAAl6SAgAF7IoCAAAudgIAAGcEAgAAA5vA=
Date: Wed, 26 Feb 2020 13:08:25 +0000
Message-ID: <AM4PR07MB350651FBB263FEEDB857CBFFCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
 <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
 <3539F747-145F-49CC-B494-C9794A8ABABA@gmail.com>,
 <alpine.BSF.2.22.395.2002261220230.39786@zero.eik.bme.hu>
 <AM6PR03MB5525DE221E3E7E595893DF4DC8EA0@AM6PR03MB5525.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5525DE221E3E7E595893DF4DC8EA0@AM6PR03MB5525.eurprd03.prod.outlook.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:AB1EEBAD96B72C8333FBEB124E19BA2AAFC7FA7FB5025829F514EC57580FE525;
 UpperCasedChecksum:A9B907ABD61C83CA3B2EED2C6796F99CEFEA4C7CF497DA794BA0FE427B275A19;
 SizeAsReceived:7599; Count:45
x-tmn: [n3WTp7wMioBc5l/YYvQ13TkmzYfMOG2o]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 4c4a7dc9-3e2c-4b2c-bfac-08d7babcf733
x-ms-exchange-slblob-mailprops: vKxeIzzER/Nr5q+2n96WmC64Fzqj5xUjhRDvUGHM12BJ4Kci+vu9uA2nCOB6VBgaPhgYIBnnY4ilPYHrgsGOUAcwzbNUSF1V7H3BJXphiksesibctUNAW8abQ8bvK+zA5q0RDoOc7NeWRBtzwQLzeGgfYihsH3d2Gyi3bNp0VyHdn8CAgc8SdA7MaHQS8T+TRqkF3PuJmk85JNd+qlRC/IL/G3cDKkQM4ij9LZinoauon4NN2PeiUe7dQGc0PMIQXgaPMc3ERDhEj9EatBAdSvC4kdHOZugHTx+DTeP2BzF76MqjEuC3AP9oWDi+Kj8Sg9S9AN2wz1/a6nkBB1uH7/aZ2pm89/BK26w0HqgIFz8BbjWb72NrjMmFo/YEuP3tqNDyfsSZErNRoRxk3baqOfKeG99D893uueV1wkbdWDJnd9ioQA9ahKONHoK5QQTK37LYLO0qhBnIRDJs57M6AdiAyucfgIbH+7hBdeFQk4u+mkhco1adCIyUs4eRLZHReC+VKpsQUKOyIlI0xPvKrpBI0dYPUBkCuo4pVYvNQehedF1I73VyFucwxNHvYbndVR/RcqalZv62puVy3KQgDlodc+/QBl4wdreUMEtClPLFvEG7P+C29iwxktZvsR6B3Ho6mxO6p4nWlcAUfz1shXph7Q5XqA+cURP4npy8IIbc/ohdh/jaq2ylbLRutPM+Y3d05tCfZJUNkLArbScbZvsnKkNnyYjCLuro6gun/T7iRSRqeezHOOFfhVyr9FwS
x-ms-traffictypediagnostic: DB8EUR05HT124:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: maClls36C7x+OnbSZ7rT8mlVe/eifAwAVDQ1sgimwxsQrKCMfyk/ZYmg8MsytIKndBTlkGfq/YDKgQOSeDq+WCM1i1R1OesPljnZTtsLk/K5cCevOoTX9zq9Mvel2DIiQvkGY4rmUBdADifOsMC2X39jj1e1ZGhIbaz10W2J9w/BRzmBrG8E87fOkLx02+7b
x-ms-exchange-antispam-messagedata: AyRjECATEDzyOMCj95gmzyB14eOSGzreBL62RysZ2Sg+ARMnuEYuuTfL0xx59o5NAWVUzQ5KV6n4kKUmYXGGeFwKLeTonR7MCEtSHj7uT1HVbx3Y1vgeWryPuzYmFIUQwpV073ghmPihQ3nC+qqMIw==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM4PR07MB350651FBB263FEEDB857CBFFCAEA0AM4PR07MB3506eurp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4a7dc9-3e2c-4b2c-bfac-08d7babcf733
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 13:08:25.9696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT124
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7e1b::80c
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM4PR07MB350651FBB263FEEDB857CBFFCAEA0AM4PR07MB3506eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Please let's go with hardfloat pps support, it's really a good feature to i=
mplement.
Even if in a first step it could lead to inaccuracy results, later it could=
 solved with other patches.

I think it's important for qemu to as global as possible and don't target o=
nly recent hardware.

Regards,
Dino Papararo

Da: Qemu-ppc <qemu-ppc-bounces+skizzato73=3Dmsn.com@nongnu.org> Per conto d=
i luigi burdo
Inviato: mercoled=EC 26 febbraio 2020 14:01
A: BALATON Zoltan <balaton@eik.bme.hu>; Programmingkid <programmingkidx@gma=
il.com>
Cc: David Gibson <david@gibson.dropbear.id.au>; qemu-ppc@nongnu.org; qemu-d=
evel qemu-devel <qemu-devel@nongnu.org>; Howard Spoelstra <hsp.cat7@gmail.c=
om>
Oggetto: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC

Hi Zoltan,
i can say MacOs Leopard use multiple cores on PowerMac G5 Quad the most of =
the apps did for  Panter/Tiger/leopard use for sure 2 Core in smtp only app=
s did for Tiger/leopard use more than 2 Cores.
Ciao and thenks
 Luigi


________________________________
Da: Qemu-ppc <qemu-ppc-bounces+intermediadc=3Dhotmail.com@nongnu.org<mailto=
:qemu-ppc-bounces+intermediadc=3Dhotmail.com@nongnu.org>> per conto di BALA=
TON Zoltan <balaton@eik.bme.hu<mailto:balaton@eik.bme.hu>>
Inviato: mercoled=EC 26 febbraio 2020 12:28
A: Programmingkid <programmingkidx@gmail.com<mailto:programmingkidx@gmail.c=
om>>
Cc: Howard Spoelstra <hsp.cat7@gmail.com<mailto:hsp.cat7@gmail.com>>; qemu-=
ppc@nongnu.org<mailto:qemu-ppc@nongnu.org> <qemu-ppc@nongnu.org<mailto:qemu=
-ppc@nongnu.org>>; qemu-devel qemu-devel <qemu-devel@nongnu.org<mailto:qemu=
-devel@nongnu.org>>; David Gibson <david@gibson.dropbear.id.au<mailto:david=
@gibson.dropbear.id.au>>
Oggetto: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC

On Wed, 26 Feb 2020, Programmingkid wrote:
> I think a timeout takes place and that is why audio stops playing. It is
> probably an USB OHCI issue. The other USB controller seems to work
> better.

Which other USB controller? Maybe you could try enabling some usb_ohci*
traces and see if they reveal anything.

>> The Amiga like OSes I'm interested in don't use multiple cores so I'm
>> mainly interested in improving single core performance. Also I'm not
>> sure if (part of) your problem is slow FPU preventing fast enough audio
>> decoding then having multiple CPUs with slow FPU would help as this may
>> use a single thread anyway.
>
> Good point. MTTCG might be the option that really helps with speed improv=
ements.

Only if you have multithreaded workload in the guest because AFAIK MTTCG
only runs different vcpus in parallel, it won't make single emulated CPU
faster in any way. OSX probably can benefit from having multiple cores
emulated but I don't think MacOS would use it apart from some apps maybe.

Regards,
BALATON Zoltan

--_000_AM4PR07MB350651FBB263FEEDB857CBFFCAEA0AM4PR07MB3506eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.StileMessaggioDiPostaElettronica20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<body lang=3D"IT" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Please let&#8217;s go with hardfloat pps support, it&#8217;s really a=
 good feature to implement.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Even if in a first step it could lead to inaccuracy results, later it=
 could solved with other patches.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">I think it&#8217;s important for qemu to as global as possible and do=
n&#8217;t target only recent hardware.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Dino Papararo<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>Da:</b> Qemu-ppc &lt;qemu-ppc-bounces&#43;skizzat=
o73=3Dmsn.com@nongnu.org&gt;
<b>Per conto di </b>luigi burdo<br>
<b>Inviato:</b> mercoled=EC 26 febbraio 2020 14:01<br>
<b>A:</b> BALATON Zoltan &lt;balaton@eik.bme.hu&gt;; Programmingkid &lt;pro=
grammingkidx@gmail.com&gt;<br>
<b>Cc:</b> David Gibson &lt;david@gibson.dropbear.id.au&gt;; qemu-ppc@nongn=
u.org; qemu-devel qemu-devel &lt;qemu-devel@nongnu.org&gt;; Howard Spoelstr=
a &lt;hsp.cat7@gmail.com&gt;<br>
<b>Oggetto:</b> R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC<o:p>=
</o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi Zolt=
an,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">i can s=
ay MacOs Leopard use multiple cores on PowerMac G5 Quad the most of the app=
s did for&nbsp; Panter/Tiger/leopard use for sure 2 Core in smtp only apps =
did for Tiger/leopard use more than 2 Cores.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Ciao an=
d thenks<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;L=
uigi&nbsp;<o:p></o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">Da:</span></b><span s=
tyle=3D"color:black"> Qemu-ppc &lt;<a href=3D"mailto:qemu-ppc-bounces&#43;i=
ntermediadc=3Dhotmail.com@nongnu.org">qemu-ppc-bounces&#43;intermediadc=3Dh=
otmail.com@nongnu.org</a>&gt; per conto di BALATON Zoltan
 &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt;<br>
<b>Inviato:</b> mercoled=EC 26 febbraio 2020 12:28<br>
<b>A:</b> Programmingkid &lt;<a href=3D"mailto:programmingkidx@gmail.com">p=
rogrammingkidx@gmail.com</a>&gt;<br>
<b>Cc:</b> Howard Spoelstra &lt;<a href=3D"mailto:hsp.cat7@gmail.com">hsp.c=
at7@gmail.com</a>&gt;;
<a href=3D"mailto:qemu-ppc@nongnu.org">qemu-ppc@nongnu.org</a> &lt;<a href=
=3D"mailto:qemu-ppc@nongnu.org">qemu-ppc@nongnu.org</a>&gt;; qemu-devel qem=
u-devel &lt;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org<=
/a>&gt;; David Gibson &lt;<a href=3D"mailto:david@gibson.dropbear.id.au">da=
vid@gibson.dropbear.id.au</a>&gt;<br>
<b>Oggetto:</b> Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC</sp=
an> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">On Wed, 26 Feb 2020, =
Programmingkid wrote:<br>
&gt; I think a timeout takes place and that is why audio stops playing. It =
is <br>
&gt; probably an USB OHCI issue. The other USB controller seems to work <br=
>
&gt; better.<br>
<br>
Which other USB controller? Maybe you could try enabling some usb_ohci* <br=
>
traces and see if they reveal anything.<br>
<br>
&gt;&gt; The Amiga like OSes I'm interested in don't use multiple cores so =
I'm <br>
&gt;&gt; mainly interested in improving single core performance. Also I'm n=
ot <br>
&gt;&gt; sure if (part of) your problem is slow FPU preventing fast enough =
audio <br>
&gt;&gt; decoding then having multiple CPUs with slow FPU would help as thi=
s may <br>
&gt;&gt; use a single thread anyway.<br>
&gt;<br>
&gt; Good point. MTTCG might be the option that really helps with speed imp=
rovements.<br>
<br>
Only if you have multithreaded workload in the guest because AFAIK MTTCG <b=
r>
only runs different vcpus in parallel, it won't make single emulated CPU <b=
r>
faster in any way. OSX probably can benefit from having multiple cores <br>
emulated but I don't think MacOS would use it apart from some apps maybe.<b=
r>
<br>
Regards,<br>
BALATON Zoltan<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_AM4PR07MB350651FBB263FEEDB857CBFFCAEA0AM4PR07MB3506eurp_--

