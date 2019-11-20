Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98236C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553CF223D1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ImV75u8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553CF223D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOkh-0002Su-CR
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXOiS-0000vq-0F
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXOiP-0006Xi-VY
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:04:11 -0500
Received: from mail-am5eur03on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::714]:19761
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXOiP-0006U6-4K; Wed, 20 Nov 2019 07:04:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eX7VceOM7c+L8TP+p+bHR4Ubp2FOHwsdyF+Jfgl3kddzm63n93tAV2ZqwBuG+De+BxNIOD2LffmkC2htrQoCI6xhKLYvOkiCjFiWR3o4OMBgu4x9uGgGapgdl3/8uIzuP90NoR+iDFD2mYkTLuWB3I05MsrosMAhch897QotT3oLh5KSc1t2yeedetUSK7VmYAKxQJH4Len5iJSl4Lutgs2McjJiCvY3MycPUv1KxOKWUUPTErkDdbnP85gsdLsMOi0ZvixziA/A2NqaNC82yIxzaqNSOE+tecb3l2q/+sytW3q9TW4OYy5xYigVaGTIL/sMSMiCCnzG3sJ87t3vSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDjGUEx8zdqShbzJBIfpjuOqMHve2Nkdd5+RrXwTGc8=;
 b=VVRSS9yYfZpIXJzytcUc2yf1pNjgFdWz3QdJbxlYesWQONNNT/azPSpeZNk8zrw0MK9/y1+mV6PG1ePnkN0/6Q5tegSdm4uwO5M233JQMyiIvJTEg8UFNiNAeiU/GfxWhzVv8tXUhv0g74eiJ3/o968+zjuRTUseyXnIW0iqzbAEylM1DnA8NGntGXH5z0KuKNrMenkufzAO13kNLY58sU1Y4B/RAN5OBXXgKw5ls0AEeqUTcrm8yP/8eQ6W/ogwJtQ5zpEFJLGCLVF5KqgbqfhaHRKlS4ce4Zpfo9VbNroixkKBWQjU3Edag6PasD/sAOvQCDtkGmwojKPELShJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDjGUEx8zdqShbzJBIfpjuOqMHve2Nkdd5+RrXwTGc8=;
 b=ImV75u8mxWsvF3shehq5BYagTJYD2BLCIhCNUKVHhmG5kbp+/Y/r3ADvhJvfXie7++CAE2STgH0lZbfXNNxXLql729OsV0Hg0xlUGsOzLNAVD04wSatr9/WhTPDYda0ykTEmascX64U6RxWfKRTOlEoVYQf0Xr370Tl4CDtrsWQ=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4534.eurprd08.prod.outlook.com (20.179.6.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 12:04:06 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 12:04:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5KeT3vMAgAAXeACAAAWSAA==
Date: Wed, 20 Nov 2019 12:04:06 +0000
Message-ID: <abb27eb4-1b1d-39b4-3867-b6ade59884d0@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <7f8574a2-8fd2-9724-a197-d67d3c69d538@virtuozzo.com>
 <20191120114408.GA5779@linux.fritz.box>
In-Reply-To: <20191120114408.GA5779@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0018.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::31)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120150404117
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8132a4a6-e218-4193-085d-08d76db1bde5
x-ms-traffictypediagnostic: AM6PR08MB4534:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4534B718B74652CB91EFC940C14F0@AM6PR08MB4534.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(366004)(346002)(39840400004)(396003)(189003)(199004)(53754006)(81156014)(52116002)(6436002)(6512007)(229853002)(14444005)(256004)(86362001)(8936002)(71200400001)(6246003)(71190400001)(478600001)(476003)(8676002)(4326008)(14454004)(31686004)(25786009)(6916009)(66066001)(107886003)(99286004)(486006)(2616005)(81166006)(386003)(6506007)(11346002)(446003)(305945005)(6486002)(186003)(3846002)(102836004)(26005)(54906003)(66946007)(316002)(64756008)(66476007)(66556008)(66446008)(31696002)(36756003)(7736002)(6116002)(76176011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4534;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aq27Ra27/j8CsnPOh8kZkpzBeLhhcMbQwixTLH45uCrN+GmuUhZwMNAdHpVAulqSkGbSaRkhTnK3JEcuxkiLaU2P8N/Br4pGBVyi4sgkywi7ilyTki5x3VVq56hKAy2vxaru2x45YOEl0CU/6r5mzlGu3kFmKmEeaAuLZgGGJxzvHqN0ZCzDicXkVC1t+gQMk2KvxIBkeyb+X9zVBfSbSr+bn3yqM7WYru7Dslf9+aMhp1+GXZilv1SvnboA2Nk8ymFeKPnfM591WgHY9hNOucidS1qTf0X67PziDc8Qq39V8Btjvf9sYXwaqRPUgyFawQK89fBXiT9/O8yl2seV2vcOx0TetJCdH0MGgyLllTK2Wrxj1RI+dJxVlCUb86Bo0bnrdoMovV0za3hr2tRNaPGjeDTQOY8Gf8xNJ+YBamQM2xjXyzySzfKF35FZw9uk
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <84A38BB1FE864948B455E3F6F19B4A20@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8132a4a6-e218-4193-085d-08d76db1bde5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 12:04:06.0626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HFGvblFAs8h7l4P1ugQmGXVjWDCyWvIeVVwI37q8J3tpLxLKgjnL3i1F/vCCv2BlNrG3kZzQAAsfqGY6v81co2FNcDY51jEnnge+0KAPfYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4534
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::714
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

20.11.2019 14:44, Kevin Wolf wrote:
> Am 20.11.2019 um 11:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 16.11.2019 19:34, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> I wanted to understand, what is the real difference between bdrv_block_=
status_above
>>> and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should work t=
hrough
>>> bdrv_block_status_above..
>>>
>>> And I found the problem: bdrv_is_allocated_above considers space after =
EOF as
>>> UNALLOCATED for intermediate nodes..
>>>
>>> UNALLOCATED is not about allocation at fs level, but about should we go=
 to backing or
>>> not.. And it seems incorrect for me, as in case of short backing file, =
we'll read
>>> zeroes after EOF, instead of going further by backing chain.
>>>
>>> This leads to the following effect:
>>>
>>> ./qemu-img create -f qcow2 base.qcow2 2M
>>> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
>>>
>>> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
>>> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
>>>
>>> Region 1M..2M is shadowed by short middle image, so guest sees zeroes:
>>> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
>>> read 1048576/1048576 bytes at offset 1048576
>>> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
>>>
>>> But after commit guest visible state is changed, which seems wrong for =
me:
>>> ./qemu-img commit top.qcow2 -b mid.qcow2
>>>
>>> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
>>> Pattern verification failed at offset 1048576, 1048576 bytes
>>> read 1048576/1048576 bytes at offset 1048576
>>> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
>>>
>>> ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
>>> read 1048576/1048576 bytes at offset 1048576
>>> 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
>>>
>>>
>>> I don't know, is it a real bug, as I don't know, do we support backing =
file larger than
>>> its parent. Still, I'm not sure that this behavior of bdrv_is_allocated=
_above don't lead
>>> to other problems.
>>>
>>> =3D=3D=3D=3D=3D
>>>
>>> Hmm, bdrv_block_allocated_above behaves strange too:
>>>
>>> with want_zero=3Dtrue, it may report unallocated zeroes because of shor=
t backing files, which
>>> are actually "allocated" in POV of backing chains. But I see this may i=
nfluence only
>>> qemu-img compare, and I don't see can it trigger some bug..
>>>
>>> with want_zero=3Dfalse, it may do no progress because of short backing =
file. Moreover it may
>>> report EOF in the middle!! But want_zero=3Dfalse used only in bdrv_is_a=
llocated, which considers
>>> onlyt top layer, so it seems OK.
>>>
>>> =3D=3D=3D=3D=3D
>>>
>>> So, I propose these series, still I'm not sure is there a real bug.
>>>
>>> Vladimir Sementsov-Ogievskiy (4):
>>>     block/io: fix bdrv_co_block_status_above
>>>     block/io: bdrv_common_block_status_above: support include_base
>>>     block/io: bdrv_common_block_status_above: support bs =3D=3D base
>>>     block/io: fix bdrv_is_allocated_above
>>>
>>>    block/io.c                 | 104 ++++++++++++++++++-----------------=
--
>>>    tests/qemu-iotests/154.out |   4 +-
>>>    2 files changed, 53 insertions(+), 55 deletions(-)
>>>
>>
>>
>> Interesting that the problem illustrated here is not fixed by the series=
, it's actually
>> relates to the fact that mirror does truncation with PREALLOC_MODE_OFF, =
which leads
>> to unallocated qcow2 clusters, which I think should be fixed too.
>=20
> Yes, this is what I posted yesterday. (With a suggested quick fix, but
> it turns out it was not quite correct, see below.)
>=20
>> To illustrate the problem fixed by the series, we should commit to base:
>>
>> # ./qemu-img commit top.qcow2 -b base.qcow2
>> Image committed.
>> # ./qemu-io -c "read -P 0 1M 1M" base.qcow2
>> Pattern verification failed at offset 1048576, 1048576 bytes
>> read 1048576/1048576 bytes at offset 1048576
>> 1 MiB, 1 ops; 00.00 sec (5.366 GiB/sec and 5494.4149 ops/sec)
>=20
> Ok, I'll try that later.
>=20
>> Hmm, but how to fix the problem about truncate? I think truncate must
>> not make underlying backing available for read.. Discard operation
>> doesn't do it.
>>
>> So, actually on PREALLOC_MODE_OFF we must allocated L2 tables and mark
>> new clusters as ZERO?
>=20
> Yes, we need to write zeroes to the new area if the backing file covers
> it. We need to do this not only in mirror/commit/bdrv_commit(), but in
> fact for all truncate operations: Berto mentioned on IRC yesterday that
> you can get into the same situation with 'block_resize' monitor
> commands.
>=20
> So I tried to fix this yesterday, and I thought that I had a fix, when I
> noticed that bdrv_co_do_zero_pwritev() takes a 32 bit bytes parameter.
> So I'll still need to fix this. Other than that, I suppose the following
> fix should work (but is probably a bit too invasive for -rc3).
>=20
> Kevin
>=20
> diff --git a/block/io.c b/block/io.c
> index f75777f5ea..4118bf0118 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3382,6 +3382,32 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child=
, int64_t offset, bool exact,
>           goto out;
>       }
>=20
> +    /*
> +     * If the image has a backing file that is large enough that it woul=
d
> +     * provide data for the new area, we cannot leave it unallocated bec=
ause
> +     * then the backing file content would become visible. Instead, zero=
-fill
> +     * the area where backing file and new area overlap.
> +     */
> +    if (new_bytes && bs->backing && prealloc =3D=3D PREALLOC_MODE_OFF) {
> +        int64_t backing_len;
> +
> +        backing_len =3D bdrv_getlength(backing_bs(bs));
> +        if (backing_len < 0) {
> +            ret =3D backing_len;
> +            goto out;
> +        }
> +
> +        if (backing_len > old_size) {
> +            /* FIXME bytes parameter is 32 bits */
> +            ret =3D bdrv_co_do_zero_pwritev(child, old_size,
> +                                          MIN(new_bytes, backing_len - o=
ld_size),
> +                                          BDRV_REQ_ZERO_WRITE | BDRV_REQ=
_MAY_UNMAP, &req);
> +            if (ret < 0) {
> +                goto out;
> +            }
> +        }
> +    }
> +
>       ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "Could not refresh total sector co=
unt");
>=20

I'm not sure that it is safe enough: we may not have opened backing at the =
moment, but
still it may exist and managed by user.

PREALLOC_MODE_OFF is documented as
# @off: no preallocation

- not very descriptive, but I think it's nothing about making backing file =
available
through new clusters.

I think PREALLOC_MODE_OFF should always make new clusters "BDRV_BLOCK_ALLOC=
ATED". If
for some scenarios (are they exist at all?) we need to preallocate cluster =
in manner
that backing file would be visible through them, we'd better add another pr=
eallocation
mode which will directly document this behaviour, like PREALLOC_MODE_BACKIN=
G.

So, I'd consider PREALLOC_MODE_OFF as something that must not create UNALLO=
CATED (in POV
of backing chains) clusters, and should be fixed in all formats.. Or as a q=
uick fix may
we may write zeros from bdrv_co_truncate, but independently of backing file=
 existence
and length.

=3D=3D=3D

Also I think it's a wrong thing at all that qcow2 new file is transparent b=
y default..
It should be transparent only when we create snapshots and incremental back=
ups. But when
we create new disk for new vm it should be zeroed (and extending L1 table e=
ntry spec by
"zero bit" may help)

--=20
Best regards,
Vladimir

