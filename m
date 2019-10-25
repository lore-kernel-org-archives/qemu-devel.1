Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3561CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B921321929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TGfwzRsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B921321929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxIF-0004ml-FJ
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <casasfernando@outlook.com>) id 1iNwpd-0002Mn-Ta
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <casasfernando@outlook.com>) id 1iNwpb-0004gc-PW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:28:32 -0400
Received: from mail-oln040092070071.outbound.protection.outlook.com
 ([40.92.70.71]:21382 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <casasfernando@outlook.com>)
 id 1iNwpb-0004gL-4B; Fri, 25 Oct 2019 06:28:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTtcAjkhDvIUyKa0uD1QMC4HV46XzV1Y2W/TvdcBjt8HL43cfcOpZ8xDHLHGSQm6umub81ukb4UHS8estsQLdmoN2n8ut1qWHf74mDT47N+PTPEKWie+1gSxX1SLx3ZFhqlXNDfLVm7VN1T0B8P3N1ogRwy9g1r0ELg5nz/235N/A+6e51hNXdf7BnYwF0ONCCBFj59wiY6TvzuEAzR4JJK8GJWo3GwBzUlFS9bfiXANUqKWk/JvbBIZyhAeG5YAYAr6DAp/+PxdUkJ97jsuHXCDIoJXOVejTsyvKlPQRu1pNThnuwpCca2/FrV1HG63oa0a+K/MZmoFkbELL8BG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heE6OZpVrIKsZxShuwsKo6eq6axMkAYo71gGXdcLXp4=;
 b=bDzPphzUXow7IwX73JrACQqmNMUcgk0F3WGINHV4TVjT9w+2XT/+/+oCry76uP4b2O8oTgYVSd8HvHLyhl0LhQ88jC9cA90iY84AJdM+PbQAjgMeSyRarfnOVyPqLHTZ1S2A5pX26G84QmgOoUREZIN6YpP1wsi+ElImXCp5Obujd3AammNhXG2A86OSvbN4KDoqhWOsybv/aMkaMKom0x/Eu8/HJiWkBXe29e9ZSvVlKvyBDop1jo+3f1yjxEU+v34ieWpSDyIGapeIxMf8o6Sxg54gq06CzmNTJmcMq7vwgp4aROHE2+YgrxWbvT4LSC/TEM59v5Wyiay7lL5X+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heE6OZpVrIKsZxShuwsKo6eq6axMkAYo71gGXdcLXp4=;
 b=TGfwzRsDdjayTsCTKrHJPXnTfOJcEX1Tn4qpPG7w7YxFFXiv4Qex6IVe17xrwi6wRtD/p7aHyLS7UXf/iha+xpDF0905HMLNxCjs2Pe9Og3Ncuc63uzf264pt/e2mzZNyjMI57lExnwctOiVjIKp3s8njCOEULaQS5jjn/GyvOD9CjZQmHkUkYlbZRDJFVN6ZMJOrUIWtCH1ldhqBtp1pP2q97nmik5Gah6xq964/gkQUEcrMc8JEhuwl0eRKWXr3f3QD3P9Zvd4qLa3w4tYFiLlaA8ugJDPRTvHIgUd5b8ZoRST8LMcyjWERHxjZfoMV0/uVUtbO/BerLtXChgJQQ==
Received: from VE1EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (10.152.18.59) by VE1EUR03HT036.eop-EUR03.prod.protection.outlook.com
 (10.152.19.157) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15; Fri, 25 Oct
 2019 10:28:29 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com (10.152.18.52) by
 VE1EUR03FT018.mail.protection.outlook.com (10.152.18.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Fri, 25 Oct 2019 10:28:29 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75]) by VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75%6]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 10:28:29 +0000
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Topic: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Index: AQHVhfzB7lc3mC9pr0OyFBE/io6S3qdoYtGAgAAfrICAAqmVgIAABdMA
Date: Fri, 25 Oct 2019 10:28:28 +0000
Message-ID: <VI1PR03MB48140DB2BA084EAEBD980302A4650@VI1PR03MB4814.eurprd03.prod.outlook.com>
References: <VI1PR03MB481484C08A04458ACA64F7A0A46C0@VI1PR03MB4814.eurprd03.prod.outlook.com>
 <dbb363cf-bc3a-6de5-a62a-1467208d0017@redhat.com>
 <VI1PR03MB4814DBEC71814C520D123ADDA46B0@VI1PR03MB4814.eurprd03.prod.outlook.com>
 <20191025100735.GA7275@localhost.localdomain>
In-Reply-To: <20191025100735.GA7275@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0016.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::28)
 To VI1PR03MB4814.eurprd03.prod.outlook.com
 (2603:10a6:803:b7::21)
x-incomingtopheadermarker: OriginalChecksum:7FA57E465A949B161975AA041C72447DD1C7FBB6A63D280107D7C6B2BA9E1302;
 UpperCasedChecksum:645B500B81EC8302514AB4E78F70BD6E5D5C0A42EDB108B5B5A01BC8AD6C92E0;
 SizeAsReceived:7625; Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: pantheon-mail/1.0.8
x-tmn: [6O6KB2tC1uZvwN7VBAGsuo6H/mIEB8RKwJHcYYvDpeo=]
x-microsoft-original-message-id: <1571999306.6067.0@smtp-mail.outlook.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: VE1EUR03HT036:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vqehmmm2QJArOzfIjv2pUAZ2vjggFiTTU7mjUtHIAuHAdAV42hO3QyolgphSpVzmtG/9B1gp03j+EsYLp+qmjnlnpwAFjkjJUSIelJm2MKYWTf3dfcFp8CgyTk1HoP+reRfLPQYLjNvqxG4l05CrzafV2el5nWGSpz/90jwnOGxgD6DrvAysDbBUTKAi4Zpc
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_VI1PR03MB48140DB2BA084EAEBD980302A4650VI1PR03MB4814eurp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 655413bb-af32-4306-cad3-08d759361361
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 10:28:29.0093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT036
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.70.71
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_VI1PR03MB48140DB2BA084EAEBD980302A4650VI1PR03MB4814eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for the reply Kevin.

I will do my best to upgrade to 4.1, test again and report back if this is =
fixed or not in that version.
Hopefully it is.

Fernando

On vie, oct 25, 2019 at 12:07 PM, Kevin Wolf <kwolf@redhat.com> wrote:
Am 23.10.2019 um 19:28 hat Fernando Casas Sch=F6ssow geschrieben:
Hi John, Thanks for looking into this. I can quickly repro the problem with=
 qemu 4.0 binary with debugging symbols enabled as I have it available alre=
ady. Doing the same with qemu 4.1 or development head may be too much hassl=
e but if it's really the only way I can give it try.
We had a lot of iothread related fixes in 4.1, so this would really be the =
only way to tell if it's a bug that still exists. I suspect that it's alrea=
dy fixed (and to be more precise, I assume that commit d0ee0204f fixed it).=
 Kevin



--_000_VI1PR03MB48140DB2BA084EAEBD980302A4650VI1PR03MB4814eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <70FF353749A6ED4CA9C79C802B6639CC@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
Thanks for the reply Kevin.
<div><br>
</div>
<div>I will do my best to upgrade to 4.1, test again and report back if thi=
s is fixed or not in that version.</div>
<div>Hopefully it is.</div>
<div><br>
</div>
<div>Fernando</div>
<div><br>
</div>
<div>
<div>On vie, oct 25, 2019 at 12:07 PM, Kevin Wolf &lt;kwolf@redhat.com&gt; =
wrote:<br>
<blockquote type=3D"cite">
<div class=3D"plaintext" style=3D"white-space: pre-wrap;">Am 23.10.2019 um =
19:28 hat Fernando Casas Sch=F6ssow geschrieben:
<blockquote>Hi John, Thanks for looking into this. I can quickly repro the =
problem with qemu 4.0 binary with debugging symbols enabled as I have it av=
ailable already. Doing the same with qemu 4.1 or development head may be to=
o much hassle but if it's really
 the only way I can give it try. </blockquote>
We had a lot of iothread related fixes in 4.1, so this would really be the =
only way to tell if it's a bug that still exists. I suspect that it's alrea=
dy fixed (and to be more precise, I assume that commit d0ee0204f fixed it).=
 Kevin
</div>
</blockquote>
<br>
<br>
</div>
</div>
</body>
</html>

--_000_VI1PR03MB48140DB2BA084EAEBD980302A4650VI1PR03MB4814eurp_--

