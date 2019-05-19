Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D67C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 15:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5EE21872
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 15:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Ifg0omH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5EE21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49945 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSNYs-00080u-K3
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 11:17:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hSNXx-0007kH-VV
	for qemu-devel@nongnu.org; Sun, 19 May 2019 11:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hSNXw-000094-SK
	for qemu-devel@nongnu.org; Sun, 19 May 2019 11:16:21 -0400
Received: from mail-eopbgr810111.outbound.protection.outlook.com
	([40.107.81.111]:42528
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hSNXw-0008WV-D4
	for qemu-devel@nongnu.org; Sun, 19 May 2019 11:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=PRxYWrCOQTeUEa4EiAQyM2C9MbH8Lh3Ay8dzgiU0VdU=;
	b=Ifg0omH8f2UoEeB+M20LVDQ1BJYMf8pZvkR5hlGdaaE3HrzwoUV6N5K4O0OHiHNeoW8JPQYN1kPpiCW6TiQc/WYuPun+lReZEqvZxFntOwDhzyQqHQWrLFcG8NFsd9siKA2o1CqITs4NyyTajrVrI8Bvcs09BWNrqnN9AREc1dY=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1634.namprd22.prod.outlook.com (10.174.86.38) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.18; Sun, 19 May 2019 15:16:15 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8%8]) with mapi id 15.20.1900.020;
	Sun, 19 May 2019 15:16:15 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Jakub Jermar <jakub.jermar@kernkonzept.com>, Aleksandar Markovic
	<aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PULL 00/10] MIPS queue for May 19th, 2019
Thread-Index: AQHVDjD42uPeb3UWpEan+oXB5O/BoaZyUQ+AgAAGylCAAC8AAIAABDr3
Date: Sun, 19 May 2019 15:16:15 +0000
Message-ID: <BN6PR2201MB1251AE5715F377C587459080C6050@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1558263144-8776-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<bb25cbee-9265-260a-681d-d7d390c007ee@kernkonzept.com>
	<BN6PR2201MB125130243EB8B0ED9AE36848C6050@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<034a6cb7-7fb6-e59c-007b-4f8610db37a8@kernkonzept.com>
In-Reply-To: <034a6cb7-7fb6-e59c-007b-4f8610db37a8@kernkonzept.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5aa0601-e7ae-4af1-fca8-08d6dc6cefd8
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1634; 
x-ms-traffictypediagnostic: BN6PR2201MB1634:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR2201MB16348DD37F07A79C13D3D408C6050@BN6PR2201MB1634.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00429279BA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39830400003)(396003)(346002)(376002)(136003)(66544003)(54534003)(189003)(199004)(7736002)(99286004)(73956011)(8936002)(3846002)(86362001)(74316002)(305945005)(81166006)(81156014)(6116002)(7696005)(66946007)(76176011)(66556008)(66446008)(64756008)(8676002)(55016002)(68736007)(76116006)(66476007)(6436002)(102836004)(2501003)(25786009)(71200400001)(71190400001)(446003)(26005)(110136005)(6246003)(53546011)(66066001)(4326008)(6506007)(11346002)(33656002)(55236004)(186003)(5660300002)(316002)(14454004)(478600001)(6306002)(256004)(229853002)(486006)(53936002)(476003)(14444005)(52536014)(9686003)(966005)(2906002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1634;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: djDPXCR4zu+K3AlXk0VdxF5Z3e0HkVYmWC0pUoUF+XrFxUL0wyZTD84CqgDhUkCdHgtzDBHk0oy49kL0M8QIhok6yB6JzqemgI60RA22I1hANhlmpWbmJh8jQqDteE1DMmpCJGOvvAgSOL7znkuowcwtGu9RC52eb4tpvSQMqmmNJnYGFUuX8eu0FHI2GDGt5sgWOnoN9/2QjfXSc6+LGkWFaL56ykKPtDAIbNps7TLpibZv+ZG/8iH8rnuL6PMz/RshEUzxPFm0+U9VUg+qYR3sr62bO+cC4+7RZut2E8VVsoIqEl6ZaOOmdQUk3fHa5S6yuGgOafinoePaEnKEY405F9hQHs1O4TpaIFzCWqnMjy0VOJsOMSktLxxu2z/KsaXbkY4intohNlSi12btN6/sH2JD7pst+qo+SZblFL8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5aa0601-e7ae-4af1-fca8-08d6dc6cefd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2019 15:16:15.6366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1634
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.111
Subject: Re: [Qemu-devel] [PULL 00/10] MIPS queue for May 19th, 2019
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Jakub Jermar <jakub.jermar@kernkonzept.com>
>=20
> On 5/19/19 2:00 PM, Aleksandar Markovic wrote:
> >>>
> >>>   * A fix for HelenOS boot hang (related to the flag PAGE_EXEC)
> >>
> >> This was rather a problem with failing non-executable page tests in
> >> L4Re, not HelenOS. Even though I tested HelenOS for regressions.
> >
> > OK, Jakub, what would be your suggestion for a high-level description
> > of this message for end users (it is definitely a change that affects e=
nd
> > user)? Something like" Improved PAGE_EXEC flag handling"?
>=20
> It makes sure that referenced pages are not automatically marked
> executable by QEMU (despite the XI bit).
>=20
> As a user-visible change, this might unbreak some tests that attempt to
> execute data. Note that this fix does not affect pages that are not
> referenced prior to being executed - those have worked fine.
>=20
> Otherwise for normal code that does not attempt to execute data, things
> should not change at all.
>=20

I changed the first item in MIPS section of 4.1 release notes (change log)
to be:

* Marking referenced memory pages as executable is improved (it is restrict=
ed to necessary cases only).

We have time to change it by end of July, if you have a better suggestion.

Link:

https://wiki.qemu.org/ChangeLog/4.1#MIPS

Thanks for your engaging in this issue!

Hope to see you soon with more contributions!

Aleksandar


> Cheers,
> Jakub
>=20
> > Thanks,
> > Aleksandar
> >
>=20
> --
> Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael
> Hohmuth

