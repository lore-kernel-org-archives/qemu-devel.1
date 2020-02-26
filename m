Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7A1C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037692467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="cM+39900"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037692467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6wJx-0002Ny-44
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 08:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <intermediadc@hotmail.com>) id 1j6wIv-0001na-7O
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <intermediadc@hotmail.com>) id 1j6wIt-00031T-V0
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:00:45 -0500
Received: from mail-am6eur05olkn2061.outbound.protection.outlook.com
 ([40.92.91.61]:50560 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <intermediadc@hotmail.com>)
 id 1j6wIl-0002q5-Kh; Wed, 26 Feb 2020 08:00:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0IaqtsQhbDB3mTPQ2Zu4N++uORWj5ymfF26T0VmWa4lQRxXyp8Fw5asJ9EgpPAfnCB0js9yliSmS9zYhgvGZ/fXxzL1dBJGwiRIQVNKYgA6VlTCFnB5G2VI2Peez5o5HBRCophvPgDT5pZdE3C/PhLTItNvDOKx5GwkUWWM/gOQcUQs4Z3bFQpJNM457qgAcaNp8LxynKoKJuFRRtsSN2IVybpLlYMyBRrf8yaLQeOY8pYYM5J7vev7L+8r7skjOVR2BGFChKFBabpIbjnXUejPEQ9FodKyFKlnioUP9xbKHiZDdjfZDZFMMHeJDoUCdkiiSmwQlR/d1gAecawdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR/85vAh5zwB49/eR29veOpqXZ0FCQhXPTqEx16vr+o=;
 b=nRn39oV+9cKANVF4f7Xpkug6NQKXkMjPsOS4XO7oSE11Y2N17q8m0noJPRp7IJEtL7dZgDAVOEfLYhUKuTepVCLj6CP+yMxeeuueflBs6CuzFhMGRXd1WHQZWZoCqVZsyjejgGuwFzo3GtVTI5EUg5UKD8uNzpo0KbDcGyioacwgOkeHDFD1f+aCQvUCRoQjnaHNKV6PBv9bbjDLfPWpYr26ylNu81r/FCVLsAo3mivQQoUb+m+nJSu0305/Q81514crQPRnvNvaU81MxHqbraR0HOvrR8xxWQOiDSnWHvHoh8eDPHd8AJ1/BR3bnS3gq0q+7v1cnpfvXsmhw8zPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR/85vAh5zwB49/eR29veOpqXZ0FCQhXPTqEx16vr+o=;
 b=cM+39900PjyiCQouiP1n8xReHmNdg57TeBLNMV9B31Hw6+TFNlFLm/5wOwtxdgYBClRUKXY0X7Lcvtzoec4LpkoCEkqOQ3LfoJX8R6MuNdPV/GrmY+fx2404BqvUjtlSPwTUsW6oiUY4NxvcrwknIv5YTrmxKx27d/LfGazAkDQuEsrM98CAgQhR1JfhW6Gwa9S7N6mkBuHadFMsn/d7liN8qeE64YWoENT2IiHazyyPiamVT+NPdhxZJzupl+cIEyHzGhiG7JHYNCyG436fSGq22XwhQPfC6M1KFIB7QrT28crM/H71vLXovG13gfBCv5aF+nkYVuxQ/9j2T46QHA==
Received: from AM6EUR05FT037.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::35) by
 AM6EUR05HT257.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::345)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 26 Feb
 2020 13:00:32 +0000
Received: from AM6PR03MB5525.eurprd03.prod.outlook.com (10.233.240.52) by
 AM6EUR05FT037.mail.protection.outlook.com (10.233.241.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 13:00:32 +0000
Received: from AM6PR03MB5525.eurprd03.prod.outlook.com
 ([fe80::7c37:6ec9:2d0e:94f7]) by AM6PR03MB5525.eurprd03.prod.outlook.com
 ([fe80::7c37:6ec9:2d0e:94f7%5]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 13:00:32 +0000
From: luigi burdo <intermediadc@hotmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, Programmingkid
 <programmingkidx@gmail.com>
Subject: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
Thread-Topic: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
Thread-Index: AQHV5n9h3lClWy/kM0istMYCtQzSH6ghy0MAgADcEYCACJz9gIAAl6SAgAF7IoCAAAudgIAAGR2a
Date: Wed, 26 Feb 2020 13:00:32 +0000
Message-ID: <AM6PR03MB5525DE221E3E7E595893DF4DC8EA0@AM6PR03MB5525.eurprd03.prod.outlook.com>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
 <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
 <3539F747-145F-49CC-B494-C9794A8ABABA@gmail.com>,
 <alpine.BSF.2.22.395.2002261220230.39786@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2002261220230.39786@zero.eik.bme.hu>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:FC0FD15EF9FC616BFC5A9FC7DA76251260B40C7713B3C316E0D895EE6CCF7685;
 UpperCasedChecksum:78733F6F9F55F0134D116727C54061A21E70694222AA471D8CBD6F1E476235B2;
 SizeAsReceived:7492; Count:46
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [0QR4Y+5s9K56FxeRaveZj7jOphSTAdeS]
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: bf698da4-fadf-4b6b-af4e-08d7babbdd01
x-ms-traffictypediagnostic: AM6EUR05HT257:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TqNxWOUAU0vg9OGdbbOKOS5K9wPs2EXYVg5aIU8hXtxDjwLmoelAFqjU1adKnkPQYRqk3sSx529UFtS9fXCssc9z/dGZ+ezhIhjAOmrDNDnXhSsnxDDIsr+qqZ8OG+2mETlufKTK726PmZ8nDMyn3ME8YvR5NmfTIa/T0W/+Lm1QbnGHgU16kgvhVXprvkcg
x-ms-exchange-antispam-messagedata: d4hRp8XesqzRR5QxiSPhCSeo7dQjvBAcLim8n43bmWAKvb2Njz1UBNU1bo6z+M3aH1xDdewob3zEGUYkn/h4cygjYWZfLI1nykCsIXJ7fF7hAnrubWRUaR0oAPXGBWloAf6rkZkjmnv7En1bKdPYbQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM6PR03MB5525DE221E3E7E595893DF4DC8EA0AM6PR03MB5525eurp_"
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bf698da4-fadf-4b6b-af4e-08d7babbdd01
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 13:00:32.5550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT257
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.92.91.61
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM6PR03MB5525DE221E3E7E595893DF4DC8EA0AM6PR03MB5525eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Zoltan,
i can say MacOs Leopard use multiple cores on PowerMac G5 Quad the most of =
the apps did for  Panter/Tiger/leopard use for sure 2 Core in smtp only app=
s did for Tiger/leopard use more than 2 Cores.
Ciao and thenks
 Luigi


________________________________
Da: Qemu-ppc <qemu-ppc-bounces+intermediadc=3Dhotmail.com@nongnu.org> per c=
onto di BALATON Zoltan <balaton@eik.bme.hu>
Inviato: mercoled=EC 26 febbraio 2020 12:28
A: Programmingkid <programmingkidx@gmail.com>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>; qemu-ppc@nongnu.org <qemu-ppc@no=
ngnu.org>; qemu-devel qemu-devel <qemu-devel@nongnu.org>; David Gibson <dav=
id@gibson.dropbear.id.au>
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


--_000_AM6PR03MB5525DE221E3E7E595893DF4DC8EA0AM6PR03MB5525eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Hi Zoltan,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
i can say MacOs Leopard use multiple cores on PowerMac G5 Quad the most of =
the apps did for&nbsp; Panter/Tiger/leopard use for sure 2 Core in smtp onl=
y apps did for Tiger/leopard use more than 2 Cores.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Ciao and thenks</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&nbsp;Luigi&nbsp;</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:12pt; col=
or:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>Da:</b> Qemu-ppc &lt;qemu-ppc-b=
ounces&#43;intermediadc=3Dhotmail.com@nongnu.org&gt; per conto di BALATON Z=
oltan &lt;balaton@eik.bme.hu&gt;<br>
<b>Inviato:</b> mercoled=EC 26 febbraio 2020 12:28<br>
<b>A:</b> Programmingkid &lt;programmingkidx@gmail.com&gt;<br>
<b>Cc:</b> Howard Spoelstra &lt;hsp.cat7@gmail.com&gt;; qemu-ppc@nongnu.org=
 &lt;qemu-ppc@nongnu.org&gt;; qemu-devel qemu-devel &lt;qemu-devel@nongnu.o=
rg&gt;; David Gibson &lt;david@gibson.dropbear.id.au&gt;<br>
<b>Oggetto:</b> Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On Wed, 26 Feb 2020, Programmingkid wrote:<br>
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
BALATON Zoltan<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_AM6PR03MB5525DE221E3E7E595893DF4DC8EA0AM6PR03MB5525eurp_--

