Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C632FC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8000422310
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cfsLrvUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8000422310
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQP5-0002lM-Km
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 08:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXQOM-0002I7-MK
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXQOK-0005IZ-Dz
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:51:34 -0500
Received: from mail-eopbgr50128.outbound.protection.outlook.com
 ([40.107.5.128]:30018 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXQOJ-0005B0-LG; Wed, 20 Nov 2019 08:51:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAxKNazbgB2gU1rS3Wp1lxX+LeetsApMn4xiId3ox6e0gePUhGAu4sIse175KYfcUajtjs8zKZAS28rVaeVUdsNHlYDfNtm9dxth84lxXZ2779tsppQmtE7OLh3y3S964Ym/hvBHvYQzkfe4abpYQz61TvrkF83VRD4CVkvTi+O6QEGzEfm4rpIIdk3ZXyk/ctawuLVAXVcNA1YrxozvueUQODliaX14SYtiLAmrHRAJ3q2VWspnlQ8UfnTBD8LVwpHmifrN1Hcqx3+T+BRQGj28v2uQaUOpKQmsBNO2xiwnGFoEmycFOy0RWyXxtawGFq+2DEUEsKKqmM1zydxZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKLdUCgwgM/zx+/4gpyqSc1sp8BcgxsTXpqr//ZO1NE=;
 b=ebk+T46pMmYH3jvWDzC9N4y1topk+27p9buOhuXx82WJ8f8NljoR5w9XeAikj2FYhbN8fXtlkialYraDyQLN5TbiLnAaLNJgcXfvb8NtddVMYnBw9uHtJrVXO5PdpSrYTAF0bFZ4yGtZvFt9FtnnWimQtJwCtzDn5wHHpIEB78FPmIL5huiqZcplqQB20jgwC2J5fYl0GrrTsIsSj76vkPXvhNjna7KDxYxDUzkRIKwqOiiYoX6V+/+IcGum5IuK2IaoZQgt+UERCEpDtjQROjjoVq7KbowhZtP6TwQGVyqSyQal4U85jCOlpsZ56LzjeIGfwELD1LDme49+AA1AiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKLdUCgwgM/zx+/4gpyqSc1sp8BcgxsTXpqr//ZO1NE=;
 b=cfsLrvUAwqbrOTeGQkeH40CWQJmlRT0K4c28Vri3lB+11kn7BOiqVXBLmm+LOpogx+t4+w8EiNnFiMHOOA9P76LCxTgPF/sxcUDLQhp6XDDhXzPA8TqcXG5yT+BI6E4XoezsKra53mRjOivuVu6rHxyDXbqzjNvaQLR0wcu70Ck=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3398.eurprd08.prod.outlook.com (20.177.115.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 13:51:29 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 13:51:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5KeT3vMAgAAXeACAAAWSAIAAGDqAgAAFxQA=
Date: Wed, 20 Nov 2019 13:51:29 +0000
Message-ID: <19f08e65-584e-e493-d18e-80f6b84cf239@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <7f8574a2-8fd2-9724-a197-d67d3c69d538@virtuozzo.com>
 <20191120114408.GA5779@linux.fritz.box>
 <abb27eb4-1b1d-39b4-3867-b6ade59884d0@virtuozzo.com>
 <20191120133047.GC5779@linux.fritz.box>
In-Reply-To: <20191120133047.GC5779@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0005.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::15)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120165126201
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e847d00-ceb1-4a61-9a6f-08d76dc0be3d
x-ms-traffictypediagnostic: AM6PR08MB3398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB339859ED2E188D721CD41578C14F0@AM6PR08MB3398.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39850400004)(136003)(376002)(366004)(396003)(53754006)(52314003)(199004)(189003)(43544003)(256004)(14444005)(6512007)(107886003)(7736002)(478600001)(316002)(86362001)(8936002)(52116002)(2906002)(229853002)(6116002)(3846002)(6486002)(386003)(6506007)(102836004)(186003)(476003)(26005)(486006)(71190400001)(71200400001)(76176011)(2616005)(446003)(11346002)(36756003)(66066001)(31686004)(54906003)(81166006)(66946007)(31696002)(4326008)(14454004)(6436002)(6246003)(25786009)(5660300002)(305945005)(64756008)(66446008)(66476007)(6916009)(99286004)(66556008)(8676002)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3398;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: unYX67IecGfRtvIJDtKnTVxCC68TfzflZ17ow6cWFS2qcYbo/CBEu3qBogqaYlWc7iFlc4bH8CxJT/6MMIu2LbSEIdP0eW2yvPYF17njOMQ1Z0iezEp6ZYqJ4cxtKtF4V24+OmLhUSsuOf+KKH8uYS3QFJiqJCsy5Bt6Z6SYdFnbsutlCgKfPK+ESpalw0deHAZydicUWI55XXLmnyk6IEs7Jm6buxvtFn0qW9avpxH0VSdYb/H9iTW5Azckbag2mLiBB/3rEf0ou+i8ltWnwMKZA63SQtY/tNFbFl/QbyMR9/sIRnskKPSF3Ks6AsiHvojI+Frl9fllp7z3mIq1h+An0uvCTqz0nvDRg8somAQ5j0rYjeYuvwAWfSjBggcnv9/iUS52ypOf8c2ZZZTpR0rEq63Lv48egJkbESgcBOTXdB6FGX0p1AStxLnrXwxU
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F115976B9D159B41893E9C2ED6F982CA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e847d00-ceb1-4a61-9a6f-08d76dc0be3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 13:51:29.0590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DNUvzBnNHhnn8TqqGtPNdtggXm/l6E7TcYQyctcy+hTNg92t8y+in0AyxqI1Pqf2bUI3qH7xB5CaUYxCvy/MJhshwQfWdTVDgDQOxdeis8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3398
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.128
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

20.11.2019 16:30, Kevin Wolf wrote:
> Am 20.11.2019 um 13:04 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 20.11.2019 14:44, Kevin Wolf wrote:
>>> Am 20.11.2019 um 11:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> 16.11.2019 19:34, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Hi all!
>>>>>
>>>>> I wanted to understand, what is the real difference between bdrv_bloc=
k_status_above
>>>>> and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should work=
 through
>>>>> bdrv_block_status_above..
>>>>>
>>>>> And I found the problem: bdrv_is_allocated_above considers space afte=
r EOF as
>>>>> UNALLOCATED for intermediate nodes..
>>>>>
>>>>> UNALLOCATED is not about allocation at fs level, but about should we =
go to backing or
>>>>> not.. And it seems incorrect for me, as in case of short backing file=
, we'll read
>>>>> zeroes after EOF, instead of going further by backing chain.
>>>>>
>>>>> This leads to the following effect:
>>>>>
>>>>> ./qemu-img create -f qcow2 base.qcow2 2M
>>>>> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
>>>>>
>>>>> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
>>>>> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
>>>>>
>>>>> Region 1M..2M is shadowed by short middle image, so guest sees zeroes=
:
>>>>> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
>>>>> read 1048576/1048576 bytes at offset 1048576
>>>>> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
>>>>>
>>>>> But after commit guest visible state is changed, which seems wrong fo=
r me:
>>>>> ./qemu-img commit top.qcow2 -b mid.qcow2
>>>>>
>>>>> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
>>>>> Pattern verification failed at offset 1048576, 1048576 bytes
>>>>> read 1048576/1048576 bytes at offset 1048576
>>>>> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
>>>>>
>>>>> ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
>>>>> read 1048576/1048576 bytes at offset 1048576
>>>>> 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
>>>>>
>>>>>
>>>>> I don't know, is it a real bug, as I don't know, do we support backin=
g file larger than
>>>>> its parent. Still, I'm not sure that this behavior of bdrv_is_allocat=
ed_above don't lead
>>>>> to other problems.
>>>>>
>>>>> =3D=3D=3D=3D=3D
>>>>>
>>>>> Hmm, bdrv_block_allocated_above behaves strange too:
>>>>>
>>>>> with want_zero=3Dtrue, it may report unallocated zeroes because of sh=
ort backing files, which
>>>>> are actually "allocated" in POV of backing chains. But I see this may=
 influence only
>>>>> qemu-img compare, and I don't see can it trigger some bug..
>>>>>
>>>>> with want_zero=3Dfalse, it may do no progress because of short backin=
g file. Moreover it may
>>>>> report EOF in the middle!! But want_zero=3Dfalse used only in bdrv_is=
_allocated, which considers
>>>>> onlyt top layer, so it seems OK.
>>>>>
>>>>> =3D=3D=3D=3D=3D
>>>>>
>>>>> So, I propose these series, still I'm not sure is there a real bug.
>>>>>
>>>>> Vladimir Sementsov-Ogievskiy (4):
>>>>>      block/io: fix bdrv_co_block_status_above
>>>>>      block/io: bdrv_common_block_status_above: support include_base
>>>>>      block/io: bdrv_common_block_status_above: support bs =3D=3D base
>>>>>      block/io: fix bdrv_is_allocated_above
>>>>>
>>>>>     block/io.c                 | 104 ++++++++++++++++++--------------=
-----
>>>>>     tests/qemu-iotests/154.out |   4 +-
>>>>>     2 files changed, 53 insertions(+), 55 deletions(-)
>>>>>
>>>>
>>>>
>>>> Interesting that the problem illustrated here is not fixed by the seri=
es, it's actually
>>>> relates to the fact that mirror does truncation with PREALLOC_MODE_OFF=
, which leads
>>>> to unallocated qcow2 clusters, which I think should be fixed too.
>>>
>>> Yes, this is what I posted yesterday. (With a suggested quick fix, but
>>> it turns out it was not quite correct, see below.)
>>>
>>>> To illustrate the problem fixed by the series, we should commit to bas=
e:
>>>>
>>>> # ./qemu-img commit top.qcow2 -b base.qcow2
>>>> Image committed.
>>>> # ./qemu-io -c "read -P 0 1M 1M" base.qcow2
>>>> Pattern verification failed at offset 1048576, 1048576 bytes
>>>> read 1048576/1048576 bytes at offset 1048576
>>>> 1 MiB, 1 ops; 00.00 sec (5.366 GiB/sec and 5494.4149 ops/sec)
>>>
>>> Ok, I'll try that later.
>>>
>>>> Hmm, but how to fix the problem about truncate? I think truncate must
>>>> not make underlying backing available for read.. Discard operation
>>>> doesn't do it.
>>>>
>>>> So, actually on PREALLOC_MODE_OFF we must allocated L2 tables and mark
>>>> new clusters as ZERO?
>>>
>>> Yes, we need to write zeroes to the new area if the backing file covers
>>> it. We need to do this not only in mirror/commit/bdrv_commit(), but in
>>> fact for all truncate operations: Berto mentioned on IRC yesterday that
>>> you can get into the same situation with 'block_resize' monitor
>>> commands.
>>>
>>> So I tried to fix this yesterday, and I thought that I had a fix, when =
I
>>> noticed that bdrv_co_do_zero_pwritev() takes a 32 bit bytes parameter.
>>> So I'll still need to fix this. Other than that, I suppose the followin=
g
>>> fix should work (but is probably a bit too invasive for -rc3).
>>>
>>> Kevin
>>>
>>> diff --git a/block/io.c b/block/io.c
>>> index f75777f5ea..4118bf0118 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -3382,6 +3382,32 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *chi=
ld, int64_t offset, bool exact,
>>>            goto out;
>>>        }
>>>
>>> +    /*
>>> +     * If the image has a backing file that is large enough that it wo=
uld
>>> +     * provide data for the new area, we cannot leave it unallocated b=
ecause
>>> +     * then the backing file content would become visible. Instead, ze=
ro-fill
>>> +     * the area where backing file and new area overlap.
>>> +     */
>>> +    if (new_bytes && bs->backing && prealloc =3D=3D PREALLOC_MODE_OFF)=
 {
>>> +        int64_t backing_len;
>>> +
>>> +        backing_len =3D bdrv_getlength(backing_bs(bs));
>>> +        if (backing_len < 0) {
>>> +            ret =3D backing_len;
>>> +            goto out;
>>> +        }
>>> +
>>> +        if (backing_len > old_size) {
>>> +            /* FIXME bytes parameter is 32 bits */
>>> +            ret =3D bdrv_co_do_zero_pwritev(child, old_size,
>>> +                                          MIN(new_bytes, backing_len -=
 old_size),
>>> +                                          BDRV_REQ_ZERO_WRITE | BDRV_R=
EQ_MAY_UNMAP, &req);
>>> +            if (ret < 0) {
>>> +                goto out;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>>        ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
>>>        if (ret < 0) {
>>>            error_setg_errno(errp, -ret, "Could not refresh total sector=
 count");
>>>
>>
>> I'm not sure that it is safe enough: we may not have opened backing at
>> the moment, but still it may exist and managed by user.
>=20
> But then I think it's the user's responsibility to make sure that the
> backing file still makes sense when they reattach it. You can't tell
> QEMU that there is no backing file and then expect QEMU to take care of
> your secret backing file.
>=20
> Of course, we could unconditionally zero out the new area without
> looking at the backing file, but I'm not sure if that is wanted.
>=20
>> PREALLOC_MODE_OFF is documented as
>> # @off: no preallocation
>>
>> - not very descriptive, but I think it's nothing about making backing fi=
le available
>> through new clusters.
>>
>> I think PREALLOC_MODE_OFF should always make new clusters "BDRV_BLOCK_AL=
LOCATED". If
>> for some scenarios (are they exist at all?) we need to preallocate clust=
er in manner
>> that backing file would be visible through them, we'd better add another=
 preallocation
>> mode which will directly document this behaviour, like PREALLOC_MODE_BAC=
KING.
>>
>> So, I'd consider PREALLOC_MODE_OFF as something that must not create UNA=
LLOCATED (in POV
>> of backing chains) clusters, and should be fixed in all formats.. Or as =
a quick fix may
>> we may write zeros from bdrv_co_truncate, but independently of backing f=
ile existence
>> and length.
>=20
> No, that would mean that all images must be preallocated because
> BDRV_BLOCK_ALLOCATED isn't supposed to be set for sparse blocks.

Hmm. what is sparse blocks and how it relates to backing chain?

>=20
> Essentially, the mode that you're envisioning for it is the same as
> PREALLOC_MODE_METADATA today (except that it would have to be supported
> by every driver).

As I understand, PREALLOC_MODE_METADATA preallocates DATA clusters, not ZER=
O.

Also note, that PREALLOC_MODE_OFF actually allocates some metadata: L1 tabl=
e,
to mark new clusters as UNALLOCATED.

>=20
> Obviously, that's wrong for PREALLOC_MODE_OFF.
>=20
>> =3D=3D=3D
>>
>> Also I think it's a wrong thing at all that qcow2 new file is transparen=
t by default..
>> It should be transparent only when we create snapshots and incremental b=
ackups. But when
>> we create new disk for new vm it should be zeroed (and extending L1 tabl=
e entry spec by
>> "zero bit" may help)
>=20
> Why would a qcow2 file even have a backing file when you don't want to
> ever access the backing file? Create your image without a backing file
> and you get the behaviour you want.
>=20
> Kevin
>=20

Anyway, I think we should at least document that "off" mode make backing fi=
le visible through new
clusters. And with your patch, we should document that "off" mode correctly=
 handles current
backing file (which may be backing file defined by qcow2 image, or may be s=
et by some other
mechanism), and otherwise new clusters will be transparent.

--=20
Best regards,
Vladimir

