Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90BEC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B5920663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="PbRB5c2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B5920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igwBc-0002MU-Pt
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1igwAn-0001nV-3V
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1igwAl-0007a9-KW
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:36:52 -0500
Received: from mail-dm6nam12on2101.outbound.protection.outlook.com
 ([40.107.243.101]:18113 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1igwAl-0007W9-7X
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:36:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDIP9ZXVl7XpoKRwZeQBW1DzRRpMY4jsZim49OJW/EmtkK7dth8kBB/Tqs6GX+sT9m+AIaM8cdlESeimSjhnL8OlZ9T0Q4aHBAl9DHVeDw4wkKMYSQ5b2GJVLrQJXbV1txp4SPQ76huJLCd6SpcTp4mJfVjKhPwrCMCEPmBjraPRBiD/B4cCDIjRKUliRzABK0EGks12Ui+5Prhu88gFM9ZzYbKnXQO7wlEWy7YU02ooLi15RApKWZFgN1HLJw6XBZUdrYEe6uQAgHhrfuIVcPc05CMF3sPCoi27erHi7itvhMYTuFbE0lUSN9SmzY1kUAsTy8Mzg5xbY3SEDrulpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erRyLwUA5XGIfuCvDceKB8PjydD7XKhv00ZU7cK18Os=;
 b=Z5coN4azzg9L8Ftqto7wQKsPd5I0dYGONsA3TadnScOOEIjgPvS1IMwSKzfiIbR9GZBuuW0FGOl/cvQxAYRY+QywI4zuGlnwUZuDtZt1mDsZ7jOPZmyB65FuTjbm5tmuZhO7xV+ZSWmYWVTy4CaBQ0awTNIxrVw/YLnWsVHVnAig41kZPqoGr9da5bYdn6oO7LdZa+iPqAcnMnQqiWk07vN9BgbPwPHNXUnvbBGmupl+JRCMn8/9xOKg8oslfIHhU5rr4tbbA6B1WZ1rZGTsGETauiALNYcjwGGeAsr8e/L5Y3t69lQnXvIFPyFbe1yDwCY0yI6AFZFDxA7j8qxDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erRyLwUA5XGIfuCvDceKB8PjydD7XKhv00ZU7cK18Os=;
 b=PbRB5c2U247+7RM9eslMAeY9rr1P/8vIiOKRnu+SN6V3qlI+Z6YdAcX9YcQCbrqdJMxSXXjAMJZG1gTspOO98GBKFpibFsMPaTyuC8sh+nmNLIHCaH+W4YXY458NWmFYe/OlXY4NmeBh5qQvcWam/++MQHMHSx/x3FAR5uIJUzo=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1332.namprd22.prod.outlook.com (10.174.80.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 19:36:47 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::8d7a:f373:d18d:db1c]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::8d7a:f373:d18d:db1c%10]) with mapi id 15.20.2538.019; Mon, 16 Dec
 2019 19:36:47 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [EXTERNAL]Re: [PATCH v4 29/37] RFC: mips/cps: fix setting saar
 property
Thread-Topic: [EXTERNAL]Re: [PATCH v4 29/37] RFC: mips/cps: fix setting saar
 property
Thread-Index: AQHVswx4FaxGJpqKDkWNslik8UH0GKe9JJLJ
Date: Mon, 16 Dec 2019 19:36:47 +0000
Message-ID: <BN6PR2201MB1251016B3D5948ABEFAAC117C6510@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-30-marcandre.lureau@redhat.com>,
 <41a2531e-b887-6f72-fd51-a7e1d5688670@redhat.com>
In-Reply-To: <41a2531e-b887-6f72-fd51-a7e1d5688670@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95b0e4ba-28a1-462c-d23d-08d7825f4a6a
x-ms-traffictypediagnostic: BN6PR2201MB1332:
x-microsoft-antispam-prvs: <BN6PR2201MB1332C52CC4CF1ADA291A8E01C6510@BN6PR2201MB1332.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(199004)(189003)(55236004)(6506007)(66556008)(110136005)(186003)(54906003)(2906002)(64756008)(33656002)(66476007)(966005)(91956017)(55016002)(5660300002)(66446008)(52536014)(8676002)(81166006)(71200400001)(7696005)(86362001)(81156014)(508600001)(9686003)(4326008)(8936002)(53546011)(66946007)(76116006)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1332;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g6UD6prWZ3l2wpqBdJUcH2gEjlXZdF4U9lUh6xdISTmjAnX03F/ReC4OpO4nO5vZSH1QCT0gKKUd/o6wt55dUWUyNXSq8krlRYnLSzC3fM/1iGZfOHNQW45pp/pd6BR/08/ei4B7zUEQmNQX+Lehtby+WALzYcETE5JxDl3W/WDDa1u1VRxSOREEUOIkc1obs7c7DOP4Pu1Dl2b04oyVABWoeB83/GX1jWayeut2prLdheoB5COtdfSfv+CqQG2Mwhglgpdd6kiOZcgPNM07ewXCdBqZY20gPAqAQpSdYQOTGuz3dXNWSv+m8ZM+brqj2XTRed3rPp7n1VKm5tMPYEcksq965I/R0Xo5eaUUDc12uP+ogAQlRYxPGtpryZFmX92oOIEYMPgX1zgQQt4BYxApaHRFFWTIEwjR6DvGYRySZnQ5COmOu4xGIJn6mV4ZTtK+QZrUh/fg4qwhcpK7WarNFFTZB46xeXWZCMKI6VI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b0e4ba-28a1-462c-d23d-08d7825f4a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 19:36:47.6893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZpkFF9D7qmjlahpAO0HyAiN0e9ic0G+hw5PjN4ikRZRatwtNU/buu28cf72ezeI2xkPDCq6mmkw8gkWOZvLWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1332
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.243.101
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>=0A=
> Sent: Sunday, December 15, 2019 6:56 AM=0A=
> > On 11/20/19 4:24 PM, Marc-Andr=E9 Lureau wrote:=0A=
> > There is no "saar" property. Note: I haven't been able to test this=0A=
> > code. Help welcome.=0A=
> >=0A=
> > May fix commit 043715d1e0fbb3e3411be3f898c5b77b7f90327a ("target/mips:=
=0A=
> > Update ITU to utilize SAARI and SAAR CP0 registers")=0A=
> >=0A=
> > Cc: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
> > ---=0A=
> >   hw/mips/cps.c | 2 +-=0A=
> >   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> >=0A=
> > diff --git a/hw/mips/cps.c b/hw/mips/cps.c=0A=
> > index 1660f86908..c49868d5da 100644=0A=
> > --- a/hw/mips/cps.c=0A=
> > +++ b/hw/mips/cps.c=0A=
> > @@ -106,7 +106,7 @@ static void mips_cps_realize(DeviceState *dev, Erro=
r **errp)=0A=
> >           object_property_set_bool(OBJECT(&s->itu), saar_present, "saar=
-present",=0A=
> >                                    &err);=0A=
> >           if (saar_present) {=0A=
> > -            qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void *)&env->C=
P0_SAAR);=0A=
> > +            s->itu.saar =3D &env->CP0_SAAR;=0A=
>=0A=
> Hmmm this could be what the author of 043715d1e wanted to do indeed.=0A=
> =0A=
> Since this feature is incomplete (see comments in previous versions of=0A=
> this series:=0A=
>    $ git grep saarp=0A=
>    hw/mips/cps.c:98:    saar_present =3D (bool)env->saarp;=0A=
>    target/mips/cpu.h:1103:    int saarp;=0A=
> and I don't know how to test this, I'll defer to Aleksandar regarding=0A=
> this patch.=0A=
=0A=
Hello, Philippe,=0A=
=0A=
Good that you brought this to my attention - but Marc-Andr=E9 and=0A=
I already had a discussion about this in this series' cover letter=0A=
responses (unfortunately not followed up by me as a response to=0A=
this patch, sorry about that):=0A=
=0A=
https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg00056.html=0A=
=0A=
In essence, our conclusion was that the real fix would be certainly=0A=
outside of the scope of this series, since it requires some really=0A=
(non-straightforward) mips-specific code changes, so we agreed=0A=
that Marc-Andr=E9 submit this patch as-is, and later on (certainly=0A=
within timeframe of 5.0) I will submit the fix addressing the root=0A=
cause (absence of "saar" property, and incomplete handling of=0A=
SAAR and SAARI config registers).=0A=
=0A=
In other words, this patch is fine at this moment, and formally:=0A=
=0A=
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
=0A=
(Marc-Andr=E9, just please remove "RFC" from the title, and remove=0A=
the sentence "Note: I haven't been able to test this code. Help=0A=
welcome." from the commit message, since we have the deal on=0A=
how and who will fix the underlining problem.)=0A=
=0A=
Thanks to both of you!=0A=
=0A=
Aleksandar=

