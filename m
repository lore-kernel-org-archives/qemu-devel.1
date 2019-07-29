Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E69C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC7F2070D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IiZ1yjVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC7F2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7fS-0005Cf-Su
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46544)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hs7aL-00053C-PK
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hs7aK-0004Np-Nm
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:29:13 -0400
Received: from mail-eopbgr40108.outbound.protection.outlook.com
 ([40.107.4.108]:39598 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hs7aH-0004Kw-PV; Mon, 29 Jul 2019 11:29:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8St9kYBw9X6H11fAPznGgwW1EO4DxhkEGs0VJTDbHFB2/ekElCUMsACNfb+F9NM1srAogsTjp1ZsGthm1jPbTQI6Y8G+lbYMqnSkI5ut98/QNHPWstCWyo1qsveA5uiadaL1nsyYbxWeDGzY8A28jMZaUU/ZrQhvKUrDWK0O8GFm60DHxjHWnBB6mM0V4DmwU3vMJGbLTQj7bdX6nrSBGY2k10r/WTFvbD4b7fonQjEgTY+g9Yp1iMSHwmbIVXfNln2d4II7tsJ1HT3DEPltU5l8cDqhcvJwH9xYAYKrFGA1UWsn6cw4W2IikUzUC1zyfEvWdGhFSXTlJUgBdrYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGis6Q+q/Utmmqn3k7a/M6k77bJFCswbvKcsPOrRuy0=;
 b=ffnKeHe1yYCcqHlK/EKsjqAKn3tJxJYQQZxbeDc/u7TCxcWwvDAaG2CLgENKu4ybKwXhjSgp620uKBcIb122sDco0OxFT1ijQ83ugEl9h3h/rK8R56asu8F9aHwMcLIMO01duhW+/CRacmqdxFL4hYzgacXlZcXnchBFgKVFcLTo3y2ikIppH0tstu17fT9bhXfIoAPraetQCNUEqGG2pFN2bHhlEUY/tnTSltqoczK0o5EOSIxsC7LWvHIpu9M/2UMC51SAToZyzQcBG8ELHGDkW0T90IGDew0SLpVZaTKHSf1KJVTHOW5guZgXCWKBEp0ojmtAsZUSNyfWKa0Msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGis6Q+q/Utmmqn3k7a/M6k77bJFCswbvKcsPOrRuy0=;
 b=IiZ1yjVP4zfy6X1aSjSMuN69lBTaN5fLsJ6Jvflq9d4q2h7yvOsIMJozZD86IW8khdjnzE4Zg4vZ0ru2bvvaLsmxMNlEITRE/gcoNOfai9/kXzEu1xeWm0Ldvm1PzZq+6B9FBggAArG5npnVZ5rQycbGEQ8GKEDXg6aXnn30GjU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4105.eurprd08.prod.outlook.com (20.179.12.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Mon, 29 Jul 2019 15:29:07 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 15:29:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Thread-Topic: [Qemu-block] [PATCH v3 for-4.2 0/3] block: BDRV_REQ_PREFETCH
Thread-Index: AQHVQtCOrWd5EA7R1Umv0q7KGrzceqbhtyWAgAAH7wA=
Date: Mon, 29 Jul 2019 15:29:07 +0000
Message-ID: <3d5311b4-62d7-3722-bdba-b4f968f38182@virtuozzo.com>
References: <20190725100550.33801-1-vsementsov@virtuozzo.com>
 <20190729150041.GF6771@stefanha-x1.localdomain>
In-Reply-To: <20190729150041.GF6771@stefanha-x1.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0291.eurprd05.prod.outlook.com
 (2603:10a6:7:93::22) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190729182904497
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28024b62-44d7-4303-f600-08d714397ed4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4105; 
x-ms-traffictypediagnostic: DB8PR08MB4105:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB4105CBAEF44AE0CA978A440EC1DD0@DB8PR08MB4105.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(366004)(396003)(346002)(39840400004)(199004)(189003)(53754006)(186003)(52116002)(6486002)(6436002)(476003)(2616005)(7736002)(11346002)(5660300002)(2906002)(66066001)(31696002)(4326008)(1411001)(68736007)(446003)(53936002)(81156014)(81166006)(14454004)(229853002)(6916009)(107886003)(36756003)(99286004)(486006)(305945005)(26005)(966005)(8676002)(54906003)(25786009)(102836004)(8936002)(478600001)(76176011)(6306002)(71200400001)(6246003)(31686004)(6512007)(71190400001)(66446008)(64756008)(66946007)(256004)(316002)(86362001)(66476007)(6506007)(3846002)(6116002)(66556008)(386003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4105;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dga6bCHoqMZSp/nJ649L//nysZPNlWIr3D6fhXJqsAROL/tSqVbfgiiAH/c1zSTetbBzcLrLRAX/g2ykDQqVCZKAL9MMU5X0i/giGzB+krx1l/OkPLST8XHVRkiadne06T0/1oYeqr+8Tf65Hnep4uLWQWgyCSnCxqqmRtIMo9RzmPFxfYHF0anyMk7OyxX7jMahugyWkESOZP9JBC+iwcdQIQJZQwIjI4ojH7mJcqdZCNrghl4Nm1r0lcHdK4D5UR7HlkzfQ8ElBvZoDGvgK2h31DkI4Py2aqmsqfBk1FlsTx+lY4LW4OwD7Gv+690QF+7HLxTpnKQ19cVseZ98H8WykiXDAxhu0t2AUBohdwhTysE8xmZZKspYp+Ol3LuP0lWje0x87vZyUfOGuRmXEDt3IHhHS7vJdJsQ3Vydyl0=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <13AE531F1EE9454BB0E1A8B64EB7A1BD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28024b62-44d7-4303-f600-08d714397ed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 15:29:07.0912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4105
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.108
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 for-4.2 0/3] block:
 BDRV_REQ_PREFETCH
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.07.2019 18:00, Stefan Hajnoczi wrote:
> On Thu, Jul 25, 2019 at 01:05:47PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi all!
>>
>> Here is small new read flag: BDRV_REQ_PREFETCH, which in combination wit=
h
>> BDRV_REQ_COPY_ON_READ does copy-on-read without
>> extra buffer for read data. This means that only parts that needs COR
>> will be actually read and only corresponding buffers allocated, no more.
>>
>> This allows to improve a bit block-stream and NBD_CMD_CACHE
>>
>> v3: rebase 02 on master, fix commit message of 03.
>>
>> v2: change interface to be just one flag BDRV_REQ_PREFETCH
>>
>> v1 was "[PATCH 0/3] block: blk_co_pcache"
>>     https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01047.html
>>
>> Vladimir Sementsov-Ogievskiy (3):
>>    block: implement BDRV_REQ_PREFETCH
>>    block/stream: use BDRV_REQ_PREFETCH
>>    nbd: improve CMD_CACHE: use BDRV_REQ_PREFETCH
>>
>>   include/block/block.h |  8 +++++++-
>>   block/io.c            | 18 ++++++++++++------
>>   block/stream.c        | 20 +++++++-------------
>>   nbd/server.c          | 43 +++++++++++++++++++++++++++++++++++--------
>>   4 files changed, 61 insertions(+), 28 deletions(-)
>>
>> --=20
>> 2.18.0
>>
>>
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

Thank you for reviewing!

--=20
Best regards,
Vladimir

