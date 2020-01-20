Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE03C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569B42087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OpX8noas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569B42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZnq-0004Yc-GJ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itZmb-0003Tn-VA
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:20:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itZmX-00029t-RR
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:20:09 -0500
Received: from mail-eopbgr00091.outbound.protection.outlook.com
 ([40.107.0.91]:18794 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itZmX-000297-2g; Mon, 20 Jan 2020 11:20:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvA9twT6wyEYxuRq8dWIak8HKbCKyPlkX9VaWe9pBJLXbCbcu4nt60eOcUzp6SrCo74ESyCGumPyWLtLXs2Kuxwk4r76Uc80C00pt52JC6cue6DQ9lWFOdMZP4bkROaQzv2/WCxBZEab2u2eQCgd+/JN9bL+qUh0qlJH7v5sdziVEyoq5HVB6p9v4Di8pZoLIeWpsMDrv/ZcwQMOgnKjBcdA8TvgEp4ND737iig5NYCI2ataMuZV46MUz+/llUHA6N4mon56pUd7vuqQjSey+e4E4RCLKgF/7fexLXTUNGkin6x7PCsGlENJg6kuDrpvgYyDRh5ZJDW3dPodC3KQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbv0V2OEFF7Km4JqJCrhTCl6WeAkjPhTdgatBUr127E=;
 b=iz22dvKcZ/S/rBN6Ox1gNklR+kwXMGiDOt/VxUj+f33eUcE4ffLfMXmnj8XjvX0NwtW0RCNFFIwPKckNlLq1AsvWG8N5OWzl8ADkYOFGd68v+enTfZjCMa0hIMjBQtp1k5RQ7d0qHEQU2v2fmCDYI09VE6p/YG9DzXgDWt85zMSKDkFLM+bS/wOUiorbqFLc6mrU8CmkvCOFigGkVcadpRapFftbnFpeW9X5fHtTtWkE3n8hKEH87i3gJ30s3VZj8AClWLW0yTZSw0xgx9KPguD3v1DUdp9x0q+e+jukmD8BD/kETcvPhTxZY3owMugPKOi4E9Of1Ctiy7J87TCAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbv0V2OEFF7Km4JqJCrhTCl6WeAkjPhTdgatBUr127E=;
 b=OpX8noaswgChm6e9qLGsMA1sQ78PL/AKtN0uqTbPJ8Gwmxfg1XiiQgvPWOqkmGQrSIrXlpz5mp9uRkx3pNouuQXmEefu4MQWx0gqR2e1qY+E6+GJGvBta3Lw2MYDwFz87LkpA0BQ1/vfG3YMfGwhQPlkzCnw5OSaSnBE/nUhN6k=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3272.eurprd08.prod.outlook.com (52.135.167.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 16:20:03 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 16:20:03 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 16:20:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 04/10] hbitmap: drop meta bitmaps as they are unused
Thread-Topic: [PATCH v3 04/10] hbitmap: drop meta bitmaps as they are unused
Thread-Index: AQHVtlOfjJFz1HLGS0Gzm2LfZzDgPKfzmLyAgABVioA=
Date: Mon, 20 Jan 2020 16:20:03 +0000
Message-ID: <e6d654fb-7c04-c709-6b2a-3801ae1008d6@virtuozzo.com>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-5-vsementsov@virtuozzo.com>
 <a42037d5-0d62-d916-a814-ba755b6ad9a4@redhat.com>
In-Reply-To: <a42037d5-0d62-d916-a814-ba755b6ad9a4@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120192001364
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 717e3a6b-30fa-47fc-8029-08d79dc49ab3
x-ms-traffictypediagnostic: AM6PR08MB3272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3272E3D4556ED45335D44C3CC1320@AM6PR08MB3272.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(376002)(136003)(346002)(396003)(366004)(189003)(199004)(26005)(5660300002)(16526019)(186003)(956004)(31686004)(8936002)(107886003)(2616005)(71200400001)(36756003)(16576012)(316002)(53546011)(6486002)(54906003)(66446008)(64756008)(66556008)(66476007)(2906002)(4326008)(478600001)(66946007)(110136005)(81166006)(52116002)(81156014)(8676002)(31696002)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3272;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n/1LjhBNxFRtP7Lu/mKAQY6+uoQ6A9xC6eVYGTVoBq2KSS/L1hM2UPAKja0jLX1eLR2OES1PAjkyO/WGqoLlWPvrZvU2qrn/lmNawD9VsGVfp/9QmYwwp6I5Cvhzedtwz2Q0xAeZGUmE2t+ycar0b1EGKeMxfi+ed/4JUCFazDvbSt8g8beQt65ohvRIk5R67WpXmKr+2E/YWEJYTpytcR4JYotNSWpNU6rX8zUP55YXM9aabpE75x42f4wXyI0gQy8159tL99MoNaa7ogJKSMxxXbPL3CLGD0qRXDswyzbYWyTHL9NHhJrIQIhhPfnoPNjIjMqoJTzWENRAn/P0Ye0ilLVNGjMTa5y6c85IZ6nKp7zSOo/F+9KX5HnZ6frXkjXxNkhUenvcfZ911QwX7ygINlTa8y5XGJGsvIA2DMv8vmZAhW2k3Ffk4JsostW/
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0FB0C920EA822B4D9BB78901AF6EEEE9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717e3a6b-30fa-47fc-8029-08d79dc49ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 16:20:03.2119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnSphUr9S1yVU6oc5aVnovEYM8DRzZ5eBcbl/NoKnwUopXqkE9eaXv0gqKDd7Jg4BaoV91Cx39LKiJIgKhiH7h0LQBekMYYfw3nbIlm4exs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3272
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.91
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.01.2020 14:13, Max Reitz wrote:
> On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/qemu/hbitmap.h |  21 --------
>>   tests/test-hbitmap.c   | 115 -----------------------------------------
>>   util/hbitmap.c         |  16 ------
>>   3 files changed, 152 deletions(-)
>=20
> Er, hrm, well.
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> git log me the only commits that touched anything to the regard of
> '*create_meta*' were the ones that introduced it and your commit that
> dropped it.
>=20
> Soo, er, well, okay.  Why did we introduce these again?  (I suppose I
> should know since they have my S-o-b on them.  But I actually don=92t.)
>=20
> Max
>=20

I'm a bit not follow what you mean. I can just note, that dirty-bitmap.c
part of meta bitmaps was recently removed, and hbitmap.c part I forgot to
remove...

Meta bitmaps were intended to control live migration of bitmaps and to
implement something like partial sync of bitmaps (write to qcow2 only
changed part of bitmap), but migration implemented in other way
(postcopy) and the second thing was not implemented.

--=20
Best regards,
Vladimir

