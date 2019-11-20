Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DCDC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D11D2251E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kKooz22C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D11D2251E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQBQ-0006Rn-HT
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 08:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXQAl-00062h-IF
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXQAj-0002xZ-Da
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:37:30 -0500
Received: from mail-eopbgr130139.outbound.protection.outlook.com
 ([40.107.13.139]:26290 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXQAi-0002wp-Pb; Wed, 20 Nov 2019 08:37:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmebY7DOMarMQqTZCwpN5wuQp3PGw1IGvUatCT38soDNO7m1GCXolY8+q8UZpHQyxKafhHGucnHICJj3ZSNgT1Y70zgR7em4VunNJFcnc67TCEjJ+1FtG6Qk4MCLWTNDbjDtiav9/y5X8XbbwGwkTo4SY86NiEqI2Uip2wXusGLh2zHYlDz/MfgTzeovR28kMKgqiOKAIzyVWi08Z6vPptpshc+9jDMatEhVmsJktqtq+/Xn6xz9RFvGvSlVNHWKqyw/zTnU7eGWEuJ/lUNyAps8w7jJ/YXASGn6GRBJJ1e2A0Aov0+/Tf0YI32pPE4CSDgPXrBwouCk6HQaClU7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7xdia79sc7JlrxCt8B7fCzuSm4ZA3Y64AOXKvh5wFw=;
 b=GElu/tQSLTtXI8i5XDkVLm6OCnDy3fbwgWZsgDj3tX5cU39ngOndEFj5VW8YxAdoOnJYtj0yo6XAJ7zfbNBucRJsLSRWJYFwUJjiFbhXkurvwMYZs0oU+6oQonV9ur5x3/YoyUzguzuIcZWpFIJVxdMl/N6lrek6N/NoMTo8oDClEFQ4eAMGNCtWzuBWZgR9Xx42oU7gZv8L/BEQFW3ehjxTIVdFZQE4vnFiSLtBf3NRZ4dmntBcaZHA/rE+KBFHwP2DXiIGl8LOPiNwURDovmzqdsx7Z3q2a3ZhOWXmFnVhbHfb+iXmNGTX6gj8U83Q+nK/z+KsTRi0YRL5tznRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7xdia79sc7JlrxCt8B7fCzuSm4ZA3Y64AOXKvh5wFw=;
 b=kKooz22Cj6g6mT3WjJZwg3rCi/0YIcFAnsDv5EtappQ3Le6FTGLWefqD32zmuYohAARpvmRibCYuKoUekYJtY0aJT3j3VwO6k9qf4g2eoZjAW2R4Aj3jtz108Lx2KydEDreuTzcfA+cyYp9nLCN4ob3tNLg0ZZ+ieaLrKzeW6AU=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3990.eurprd08.prod.outlook.com (20.179.0.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 13:37:24 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 13:37:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5KeT3vMAgAAXeACAAAWSAIAAGhEA
Date: Wed, 20 Nov 2019 13:37:23 +0000
Message-ID: <89b56858-c500-7b18-954d-c8d081751dc1@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <7f8574a2-8fd2-9724-a197-d67d3c69d538@virtuozzo.com>
 <20191120114408.GA5779@linux.fritz.box>
 <abb27eb4-1b1d-39b4-3867-b6ade59884d0@virtuozzo.com>
In-Reply-To: <abb27eb4-1b1d-39b4-3867-b6ade59884d0@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120163722003
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33365284-a7a6-40a8-1b73-08d76dbec667
x-ms-traffictypediagnostic: AM6PR08MB3990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3990F36C2E82A6D09D8FBDCAC14F0@AM6PR08MB3990.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(376002)(136003)(39850400004)(396003)(53754006)(199004)(189003)(229853002)(14454004)(486006)(31696002)(2906002)(186003)(26005)(71190400001)(71200400001)(476003)(5660300002)(66476007)(66556008)(66446008)(64756008)(31686004)(107886003)(6246003)(6512007)(6486002)(6436002)(4326008)(76176011)(66066001)(54906003)(66946007)(11346002)(52116002)(316002)(99286004)(478600001)(2616005)(36756003)(102836004)(386003)(6506007)(25786009)(8936002)(8676002)(6116002)(305945005)(7736002)(81166006)(6916009)(81156014)(86362001)(3846002)(446003)(256004)(14444005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3990;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z9b8VeReoUxaxZKVoxos8Ca/RGgLb5DPP22cdvk3I4s9y0ps1+yJ37VwAUID5rIrI2h9qzkpM/MX7a9jancV1Kmuc9aY7/ILDiSsXm4tYpSiOkVppDMTvJLuz9mQUlDtFjgBP7VIWjmH/xF7UeJ/3UL7erkxLzf1DOaLJgnsYHZ1IUtUNOK1so/4mMKR42DNsjnHJqRfQzajDpM8DaKFhXqLg8w3l9NhUj1Y2bZIEYo/Wi/2TFrLL6lGMDoEcLE20u4Oj05mWiJZ4W+N0gqQ5MnklhPIgXcvTpEVhGDbBLoF/R7VNQWY7q7t4U9F3cN0KFnwxNnXHkIo2njRlY3CDQSM2ZODUyD++OskFGCCddOUE5OhHEy5kfDFE9KYLW//FweXCMmZxGSXhmjmbUd+hOn9BZ4MDAJHeNcje3NGLRbdPl7Uh2DUJRlBjU3vfRZA
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9BF1D4DFE31B0344965C1658616F9323@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33365284-a7a6-40a8-1b73-08d76dbec667
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 13:37:23.8452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnq0TOChA3TN70GFe2gmqAgzNFKzNAEHNLsZLeJNOxDbHT0fO2xDQ5nn95EjAuvFcZgIIGc6Ysj1459y9He0jzrUckF/lj1swUMliZ6ilZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3990
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.139
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.11.2019 15:04, Vladimir Sementsov-Ogievskiy wrote:
> 20.11.2019 14:44, Kevin Wolf wrote:
>> Am 20.11.2019 um 11:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> 16.11.2019 19:34, Vladimir Sementsov-Ogievskiy wrote:
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
>>>>
>>>> This leads to the following effect:
>>>>
>>>> ./qemu-img create -f qcow2 base.qcow2 2M
>>>> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
>>>>
>>>> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
>>>> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
>>>>
>>>> Region 1M..2M is shadowed by short middle image, so guest sees zeroes:
>>>> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
>>>> read 1048576/1048576 bytes at offset 1048576
>>>> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
>>>>
>>>> But after commit guest visible state is changed, which seems wrong for=
 me:
>>>> ./qemu-img commit top.qcow2 -b mid.qcow2
>>>>
>>>> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
>>>> Pattern verification failed at offset 1048576, 1048576 bytes
>>>> read 1048576/1048576 bytes at offset 1048576
>>>> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
>>>>
>>>> ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
>>>> read 1048576/1048576 bytes at offset 1048576
>>>> 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
>>>>
>>>>
>>>> I don't know, is it a real bug, as I don't know, do we support backing=
 file larger than
>>>> its parent. Still, I'm not sure that this behavior of bdrv_is_allocate=
d_above don't lead
>>>> to other problems.
>>>>
>>>> =3D=3D=3D=3D=3D
>>>>
>>>> Hmm, bdrv_block_allocated_above behaves strange too:
>>>>
>>>> with want_zero=3Dtrue, it may report unallocated zeroes because of sho=
rt backing files, which
>>>> are actually "allocated" in POV of backing chains. But I see this may =
influence only
>>>> qemu-img compare, and I don't see can it trigger some bug..
>>>>
>>>> with want_zero=3Dfalse, it may do no progress because of short backing=
 file. Moreover it may
>>>> report EOF in the middle!! But want_zero=3Dfalse used only in bdrv_is_=
allocated, which considers
>>>> onlyt top layer, so it seems OK.
>>>>
>>>> =3D=3D=3D=3D=3D
>>>>
>>>> So, I propose these series, still I'm not sure is there a real bug.
>>>>
>>>> Vladimir Sementsov-Ogievskiy (4):
>>>> =A0=A0=A0 block/io: fix bdrv_co_block_status_above
>>>> =A0=A0=A0 block/io: bdrv_common_block_status_above: support include_ba=
se
>>>> =A0=A0=A0 block/io: bdrv_common_block_status_above: support bs =3D=3D =
base
>>>> =A0=A0=A0 block/io: fix bdrv_is_allocated_above
>>>>
>>>> =A0=A0 block/io.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 10=
4 ++++++++++++++++++-------------------
>>>> =A0=A0 tests/qemu-iotests/154.out |=A0=A0 4 +-
>>>> =A0=A0 2 files changed, 53 insertions(+), 55 deletions(-)
>>>>
>>>
>>>
>>> Interesting that the problem illustrated here is not fixed by the serie=
s, it's actually
>>> relates to the fact that mirror does truncation with PREALLOC_MODE_OFF,=
 which leads
>>> to unallocated qcow2 clusters, which I think should be fixed too.
>>
>> Yes, this is what I posted yesterday. (With a suggested quick fix, but
>> it turns out it was not quite correct, see below.)
>>
>>> To illustrate the problem fixed by the series, we should commit to base=
:
>>>
>>> # ./qemu-img commit top.qcow2 -b base.qcow2
>>> Image committed.
>>> # ./qemu-io -c "read -P 0 1M 1M" base.qcow2
>>> Pattern verification failed at offset 1048576, 1048576 bytes
>>> read 1048576/1048576 bytes at offset 1048576
>>> 1 MiB, 1 ops; 00.00 sec (5.366 GiB/sec and 5494.4149 ops/sec)
>>
>> Ok, I'll try that later.
>>
>>> Hmm, but how to fix the problem about truncate? I think truncate must
>>> not make underlying backing available for read.. Discard operation
>>> doesn't do it.
>>>
>>> So, actually on PREALLOC_MODE_OFF we must allocated L2 tables and mark
>>> new clusters as ZERO?
>>
>> Yes, we need to write zeroes to the new area if the backing file covers
>> it. We need to do this not only in mirror/commit/bdrv_commit(), but in
>> fact for all truncate operations: Berto mentioned on IRC yesterday that
>> you can get into the same situation with 'block_resize' monitor
>> commands.
>>
>> So I tried to fix this yesterday, and I thought that I had a fix, when I
>> noticed that bdrv_co_do_zero_pwritev() takes a 32 bit bytes parameter.
>> So I'll still need to fix this. Other than that, I suppose the following
>> fix should work (but is probably a bit too invasive for -rc3).
>>
>> Kevin
>>
>> diff --git a/block/io.c b/block/io.c
>> index f75777f5ea..4118bf0118 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -3382,6 +3382,32 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *chil=
d, int64_t offset, bool exact,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>> =A0=A0=A0=A0=A0 }
>>
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * If the image has a backing file that is large enough tha=
t it would
>> +=A0=A0=A0=A0 * provide data for the new area, we cannot leave it unallo=
cated because
>> +=A0=A0=A0=A0 * then the backing file content would become visible. Inst=
ead, zero-fill
>> +=A0=A0=A0=A0 * the area where backing file and new area overlap.
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 if (new_bytes && bs->backing && prealloc =3D=3D PREALLOC_MODE=
_OFF) {
>> +=A0=A0=A0=A0=A0=A0=A0 int64_t backing_len;
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 backing_len =3D bdrv_getlength(backing_bs(bs));
>> +=A0=A0=A0=A0=A0=A0=A0 if (backing_len < 0) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D backing_len;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 if (backing_len > old_size) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* FIXME bytes parameter is 32 bits *=
/
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D bdrv_co_do_zero_pwritev(child=
, old_size,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MIN(new_bytes, backi=
ng_len - old_size),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BDRV_REQ_ZERO_WRITE =
| BDRV_REQ_MAY_UNMAP, &req);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0=A0 ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_=
BITS);
>> =A0=A0=A0=A0=A0 if (ret < 0) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg_errno(errp, -ret, "Could not refr=
esh total sector count");
>>
>=20
> I'm not sure that it is safe enough: we may not have opened backing at th=
e moment, but
> still it may exist and managed by user.
>=20
> PREALLOC_MODE_OFF is documented as
> # @off: no preallocation
>=20
> - not very descriptive, but I think it's nothing about making backing fil=
e available
> through new clusters.
>=20
> I think PREALLOC_MODE_OFF should always make new clusters "BDRV_BLOCK_ALL=
OCATED". If
> for some scenarios (are they exist at all?) we need to preallocate cluste=
r in manner
> that backing file would be visible through them, we'd better add another =
preallocation
> mode which will directly document this behaviour, like PREALLOC_MODE_BACK=
ING.
>=20
> So, I'd consider PREALLOC_MODE_OFF as something that must not create UNAL=
LOCATED (in POV
> of backing chains) clusters, and should be fixed in all formats.. Or as a=
 quick fix may
> we may write zeros from bdrv_co_truncate, but independently of backing fi=
le existence
> and length.
>=20
> =3D=3D=3D

Or visa-versa, if we can't change current qemu-img-create default, which me=
ans preallocation=3D"off"
  =3D=3D=3D UNALLOCATED transaprent image, we may improve preallocation:"of=
f" specification, mentioning
backing files, and add preallocation:"zero" mode, to be used in truncate.

>=20
> Also I think it's a wrong thing at all that qcow2 new file is transparent=
 by default..
> It should be transparent only when we create snapshots and incremental ba=
ckups. But when
> we create new disk for new vm it should be zeroed (and extending L1 table=
 entry spec by
> "zero bit" may help)
>=20

--=20
Best regards,
Vladimir

