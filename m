Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D27C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7232217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UW+n0bv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7232217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZiC-0007xR-1H
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itZhO-0007LJ-LO
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itZhN-0007l3-DF
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:14:46 -0500
Received: from mail-am5eur02on070a.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::70a]:35651
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itZhM-0007jv-P5; Mon, 20 Jan 2020 11:14:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fj3NRMD9pZBUvfK+AyiAbye2iACFC5ihhc1lbJLY3FahQwagHu1Ma5eK3oHz6RcjTTVcjt5qEDXqbLnSJSlGc9tpublvnktNEDdnomwbV8UGjutgGwmFZFUtuf6kqQ7Lx4j3WPotFpq0qt9vBRlNlGRLnh5Lh9cHQSuAMKIpVMhf7/ITlnPX7AVssv6ytvoJC306dxcBh4fnPM/vsr+A20mwCi1Anb/ScnP4seSHf7F4nneGKyGZdDj02PDEYQE8ErJCf++US8mPmT367KdNP1SJzXGzj4rmkX/DTEee/p0y8q5QxhjBumbgcTnVjllFTRDn9P/Ojw3m6TyMy9uw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HJKKrVgNQL3Kr+DJbw3Zj9imMrRocnyYsWydUgRpg8=;
 b=DrBBi1YOkXYGeUmWmVuMsF+Rnl17MLB6/cTM9BPYssEhrlCT3AsDPXqHAw370X/TPN+6AQ2QJ+Z0l78ERFh1vOLhAzItjPv4nWePPtFWdcNXcSmxWXjvFpkNPfPxtxeGwKCRdDSyVqW644fkQ1ckGN4U4zOwNMwrCHhvX1DAAKvGssUjOCehG7RkewdRdof3/71cORK5rQMHrbLij+niuACoS3u6c+YeUZ6AZew/PZP20t7LLWdAPV/0wwkHrNvcFFIDu8q5yPcj0UNdWjeYvcMoJBxiPTAOPwWzMDacBjWbJ3K+vZ/qlGYnT1tctC+eD9FF36qog6iSd4qxekjiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HJKKrVgNQL3Kr+DJbw3Zj9imMrRocnyYsWydUgRpg8=;
 b=UW+n0bv3INbitoe9aTUSaByyqTg/z6PcAs0XRS3ptw4dhhKXNw3R6GfjDCh1U94aUA0x3k65h4T921/xljeAEVHqKCMlVmd+3oXB4M5hBhnXh580MzP44yB7jnk7LLPop58gF8iQ33mXNXCGZ8BiHTT0UlwyyaQqwrMQ43nt7RU=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3272.eurprd08.prod.outlook.com (52.135.167.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 16:14:41 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 16:14:41 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM0PR10CA0058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Mon, 20 Jan 2020 16:14:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 02/10] hbitmap: move hbitmap_iter_next_word to hbitmap.c
Thread-Topic: [PATCH v3 02/10] hbitmap: move hbitmap_iter_next_word to
 hbitmap.c
Thread-Index: AQHVtlOgfdptnmLCCUWOJLO9xdm00Kfzk4CAgABZRQA=
Date: Mon, 20 Jan 2020 16:14:41 +0000
Message-ID: <126d11e5-6be5-ae12-56ca-ca520ca28b3e@virtuozzo.com>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-3-vsementsov@virtuozzo.com>
 <027f0bec-8373-9d61-c713-ad5b7e04eef8@redhat.com>
In-Reply-To: <027f0bec-8373-9d61-c713-ad5b7e04eef8@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0058.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::38) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120191438635
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9102c96-a8e8-4ffc-15c7-08d79dc3dade
x-ms-traffictypediagnostic: AM6PR08MB3272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB32722C428FBA3FC04D815CADC1320@AM6PR08MB3272.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(366004)(39840400004)(136003)(376002)(199004)(189003)(66556008)(66476007)(2906002)(4326008)(478600001)(110136005)(66946007)(64756008)(6486002)(316002)(36756003)(16576012)(54906003)(66446008)(53546011)(81156014)(8676002)(81166006)(52116002)(31696002)(86362001)(31686004)(8936002)(107886003)(186003)(956004)(2616005)(16526019)(26005)(5660300002)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3272;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yBFONuW2kjKciYoju+s9BKl2RQIfMrgUDQEYlHHJF/83EEn0qe5MikOLxHCz1RiFtVL3DJAW8jQ9v2fM5PUkpZjN0dbBDDOqD8gQ1m2MJKkt0ke7J1f76gWrGbv+acp6HmJQGJE5lBrGMfZWD6FOTJyKKtpkxlM6JmWn2/nAPRCL9BXG59+hDVDLvztNut7TZJAzktBZkR2itFUCEFrsiK7GJ05o+pTHLkJWyCDDonjxcGcWpw5rVUF58zHdKqAb2OUAoeChdwUfrt/RrefXRhsWujB6sy4i8Rreg32GVSwn7Zmcx/tac/dL65T21q7IPXdzXlW4SHhWRnKChB+pZQ8Ah+yZDJSodq3kqf0oJnFsVq3uLWUT5D+8Axqv3Q5cVHny0f7h4RsTL05f+AdLcP/Bo9D2GWjHxIBjGXtaY3wX99km4JOaR2DipoPNdy+H
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2315FB162E3345418FD75A5F61BA0BA8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9102c96-a8e8-4ffc-15c7-08d79dc3dade
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 16:14:41.3185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUGawRTbyxJj+shs6dJ2nGTnYKGWpYuOwGQQTWdUa95UTLyLEv65LHSdKU0Hfo+HQl/brYYSz/kjDQzE0upsuMQOaOPuwORm8zMye0GYSaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3272
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::70a
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

20.01.2020 13:55, Max Reitz wrote:
> On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
>> The function is definitely internal (it's not used by third party and
>> it has complicated interface). Move it to .c file.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/qemu/hbitmap.h | 30 ------------------------------
>>   util/hbitmap.c         | 29 +++++++++++++++++++++++++++++
>>   2 files changed, 29 insertions(+), 30 deletions(-)
>=20
> I wonder why you removed the =93inline=94, but then again we should proba=
bly
> trust the compiler more than our intuition anyway.

Hmm, somehow, I was sure, that defining "static inline" functions in .c fil=
e is
equal to defining them just "static", as compiler will decide inline it or =
not
it on its own anyway.. May be I'm wrong. At least it's claimed that compile=
r may
ignore "inline", so it's a hing, and on the other hand it may inline not "i=
nline"
function.

And even if I'm wrong, I agree that in non-critical cases we should trust t=
he
compiler optimization strategy.

>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20


--=20
Best regards,
Vladimir

