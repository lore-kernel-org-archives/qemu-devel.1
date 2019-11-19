Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B0EC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DCF222A4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Fc/tz3Zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DCF222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2iA-0000U3-1R
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX2eq-0007UU-2Z
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX2eo-0007d4-JK
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:30:59 -0500
Received: from mail-eopbgr150118.outbound.protection.outlook.com
 ([40.107.15.118]:38786 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iX2eo-0007cQ-Cq; Tue, 19 Nov 2019 07:30:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4PGDLgLWpEuL+ejPYoak94H3GHCv52ZPw8FAVrUi/1ufs52haNrkVPwJcGnWc3w1LST4+HVPL4dd449wavxifnaMcHnqvShgwdYVDdZsb6onW5x8e5qxede9Rf1YEmqBMeIDWvE+zX0uZZ7UdBG19MZ4bRIb018p/eb27tjE1u+2w4hAlzk5sihT822tOxKfJpiIDOcON9NHz+qu/G31olBNWCqoHnLwJAh0nS84doNW5Kobi7JJbke9KKPzwjS/FWKRtNCf9D6Xqav2VAvDjE5xZUGWLmjBHF4sZpRzfJazZIepl4XN7wxAxm9Eca4gAxsyIqO7AGLEHrKGCAmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqXlYMdVIeY73YZncWf8StOnkwbNEk39syI/jb1F2I0=;
 b=W9KPJTeRKRUc+NqUSlsyGP1XZ5aTPkUDFKkKsRITU6gxbFUv7UvJBCOg9YrE3xt3UjPZOWg5lJFN9IZNXH8TEEgHCFCorSoJJyYHlC5jjHGqonmeu/jkYlMEo9uP/rnu0aw9KgI+mXP38XXR1CvGIPrRS0O3M9C1VgxHETHAjnTPq1Il60Al3lR915/S4FabmSgDH8RMPjGg8jC27gWdcBljgJKrpnFhyW5oaoLz+B9bOHiHrVolhlcSeYtuBwnXjlMK1AWVKNrGf0P8FZ02d+Yj1Y/VpbTyT5GzmPSMSw1Gte4uktJOBm1xb3Hz9HzM1bD2jwNlDaqnUX6x0U8OBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqXlYMdVIeY73YZncWf8StOnkwbNEk39syI/jb1F2I0=;
 b=Fc/tz3ZwHC6YBmOij1izEVQtBQkR2QLM1OWAX/mKhlx+gUB662f9L4bNG/dwBcdl2mDZPLeCsqqi/rKcsYBDHUTaSbhqV9S46Jtr6uzsSYtJ1GlS+Jr1l0B3WPgoULls+GQ/A99qGZSkqR8heD0EvE8qR9j3BRygA9cnIJVzwFM=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5192.eurprd08.prod.outlook.com (10.255.34.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Tue, 19 Nov 2019 12:30:55 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 12:30:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5KeSTT2AgAAb/oCAAAURgIAAAtkA
Date: Tue, 19 Nov 2019 12:30:55 +0000
Message-ID: <6cb1ffd6-3fa2-7828-fdf1-42d31974c85c@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <09d0bab1-ed7d-4fd7-555d-93075f10d497@redhat.com>
 <6b0811ec-822e-1c4a-1512-d6f3945645d2@openvz.org>
 <5c894f55-71ec-6ef2-856d-d2f0b859144b@redhat.com>
In-Reply-To: <5c894f55-71ec-6ef2-856d-d2f0b859144b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0039.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::49) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191119153052914
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49f45641-31f3-492d-c7f1-08d76cec5287
x-ms-traffictypediagnostic: AM6PR08MB5192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB519239E21269C8FB9E4A2369C14C0@AM6PR08MB5192.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(39840400004)(366004)(376002)(53754006)(199004)(189003)(8676002)(5660300002)(256004)(446003)(11346002)(4326008)(6512007)(110136005)(6116002)(25786009)(486006)(6486002)(26005)(31686004)(86362001)(102836004)(305945005)(66946007)(7736002)(66446008)(31696002)(64756008)(66556008)(66476007)(6436002)(66066001)(81156014)(2616005)(186003)(81166006)(476003)(2906002)(6246003)(386003)(6506007)(53546011)(36756003)(99286004)(54906003)(478600001)(316002)(14454004)(52116002)(8936002)(76176011)(3846002)(71200400001)(14444005)(229853002)(2501003)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5192;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TOQmqzjpyhSOPWnXVOxA+SdpNuNfTHJhc3xs/uYQaFb5b08aGT5CZzWZz9IE3tDb97wTJmigt1sidxOjHwIKwBgmzcMHUQOrnV2AcRJAb5aX5Df2jZEQN3bBODgJmSBlxu/5pzpm6qdmkbgsWvUf6a/iraRVTV+uMHKFaJ2cojqFfONhHBCABvTQowYerHvuvPNSe2kq/dN5tjiVHqw4PH4w5EgtAMtPZje4cns2lHarB1nqry4AdMWs64dYj43jzqQ0Nu9pagaIiay1P77PauFTFHZVumMksvq/dlOnn1aDy+ah6CS9QTumcSlLHUROr+So5fTppvH0qFDdwnb4Abn3W96UmwIxWe5Xl11/WWshXTCbTy0SgTUCymBhpWJlkKc/g0SwCwaWDXF9zTNIDdJObt0c+nFA5Peb/+PQe92u8bhcmHqqowphPxkhz1nb
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <C239E509728BE142A5135B2D115B5A5F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f45641-31f3-492d-c7f1-08d76cec5287
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 12:30:55.0395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2svsEp+hu09yd9CbUjygyW4SXFRbk8e95f231TbiWnwtICPaQEaRWEmvJxvjwnX8FyW32DcyXU39xCTjGp9VDfAk3N5kuYZAZSXpfw2D23I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5192
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.118
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.11.2019 15:20, Max Reitz wrote:
> On 19.11.19 13:02, Denis V. Lunev wrote:
>> On 11/19/19 1:22 PM, Max Reitz wrote:
>>> On 16.11.19 17:34, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi all!
>>>>
>>>> I wanted to understand, what is the real difference between bdrv_block=
_status_above
>>>> and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should work =
through
>>>> bdrv_block_status_above..
>>>>
>>>> And I found the problem: bdrv_is_allocated_above considers space after=
 EOF as
>>>> UNALLOCATED for intermediate nodes..
>>>>
>>>> UNALLOCATED is not about allocation at fs level, but about should we g=
o to backing or
>>>> not.. And it seems incorrect for me, as in case of short backing file,=
 we'll read
>>>> zeroes after EOF, instead of going further by backing chain.
>>> Should we, though?  It absolutely makes sense to me to consider post-EO=
F
>>> space as unallocated because, well, it is as unallocated as it gets.
>>>
>>> So from my POV it would make more sense to fall back to the backing fil=
e
>>> for post-EOF reads.
>>>
>>> OTOH, I don=92t know whether changing that behavior would qualify as a
>>> possible security issue now, because maybe someone has sensitive
>>> information in the tail of some disk and then truncated the overlay so
>>> as to hide it?  But honestly, that seems ridiculous and I can=92t imagi=
ne
>>> people to do that.  (It would work only for the tail, and why not just
>>> write zeroes there, which works everywhere?)  So in practice I don=92t
>>> believe that to be a problem.
>>>
>>> Max
>>
>> That seems to be wrong from my POW. Once we get block device truncated,
>> it exposed that tail to the guest with all zeroes.
>>
>> Let us assume that we have virtual disk of length L. We create new top
>> delta of
>> length X (less then L) and new top delta after with length Y (more than =
L),
>> like the following:
>>
>> [.........................] Y
>> [........] X
>> [...................] L
>>
>> Once the guest creates FS=A0 on state Y it relies on the fact that data =
from X
>> to Y is all zeroes.
>>
>> Any operations with backing chain must keep guest content to be tha same=
,
>> i.e. if we commit from Y to L, virtual disk content should be preserved,
>> i.e.
>> read as all zero even if there is some data in L from X to L.
>>
>> If we commit from X to Y, the range from X to L should remain all zeroes=
.
>>
>> This is especially valid for backups, which can not be changed and are
>> validated by the software from time to time.
>>
>> Does this makes sense?
>=20
> All right then.  But then there=92s the case of commit not shrinking the
> backing file, so the guest content won=92t be the same if you commit a
> short overlay into a longer backing file.
>=20

Hmm. Isn't commit target truncated to source before operation?


--=20
Best regards,
Vladimir

