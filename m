Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CB7C43215
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 10:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6576C2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 10:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UVKybxiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6576C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVYbP-00010w-HK
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 05:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iVYak-0000YH-EJ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iVYae-0002Y0-Q4
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:12:38 -0500
Received: from mail-eopbgr130132.outbound.protection.outlook.com
 ([40.107.13.132]:22244 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iVYaV-0002UL-Om; Fri, 15 Nov 2019 05:12:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkDDwI5RssRKEm6gjGZG1/FuWpO+Ac1IYghWYqEtFWfzn62+8ABTn/JmEA/w5uVPPlmAU6OEAbhCJgo70YlkGc1DvuV1m/BwpNVXpFwIxSd6HoqTjvoQcSKl4uW+cN7gZjf81vmMuvHRyc2h9akspTbsefwiXjOW4P+I8Ezh2YUqF/uTdhw+q6J/8vqhZRoNFHdlmmWa4G6o4boNpmh3HyXGGqCuCrvAK5rENY5bY3CDDt5quvXIFx6s2I11ITABZvSAxG/760MjwYdfr4wk20X69+6GN6o9/slYjDbgptRL0PsBC1Ik4+4Qxe/nqYS10jmbaI14TrG9r20IrsSRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzTgu8Vvppv79V29vl2KM7pg9/lc9nAzHgDQJ9SR42g=;
 b=Rk+R++yP/gJ369jWhGbHxbvAItqryBtNi4kPqk/5VCMhgCcISlGAkIbWSyv9fyXDtkT+NZ55EAWv2iw23rr3pQ4wOw3180PBfAs3KT4QhLAnNjxshZ+IhMW7F+t8B9hL5fr+QPsX3dFhsEZ+eq4u0GvUGWvnyMuDN+uDbH1z+mEysDL3WuOaXagOmWrhi6J8C3ZseHRcVlXo3vx3OpApzTVuQaCo6hN/TkJJ20ggurDs9wF380xsqGuAbcXUk5oBgHLGeK9x2OWVnuKI/TYLxvsmAwc5h8opxzhnystE2rFamPEnkynVkXpuDLM7iDV8HJ4kPbuxSOMHS6gN1FQfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzTgu8Vvppv79V29vl2KM7pg9/lc9nAzHgDQJ9SR42g=;
 b=UVKybxiRZC3DnZ+hSnokS4/C55//IhFiQfCW1rRsIS33CJIEh15j5GM8ELmF8crzd3qHWNOcphLB2xg7z1jnElineDstf6WYbATl/rDfqVe+nqm0ISBE0VyYW5TaxHDnbUuBG24V0lJbDG7XXql91j54USJ73di/8ShH4rK5CSE=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2886.eurprd08.prod.outlook.com (10.170.221.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 10:12:19 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b%4]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 10:12:19 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v7 1/3] block: introduce compress filter driver
Thread-Topic: [PATCH v7 1/3] block: introduce compress filter driver
Thread-Index: AQHVmlI7ZtlAnA1fRkKGu3L2kkMeYaeKiHMAgAAI8wCAAWlCgIAACwMA
Date: Fri, 15 Nov 2019 10:12:19 +0000
Message-ID: <93b162c7-21c3-93b4-8e95-bcf8861c4a1b@virtuozzo.com>
References: <1573670589-229357-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1573670589-229357-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a5dd3514-a804-6c63-2158-0dff9ac37ab3@redhat.com>
 <96bda153-8923-41fb-5374-10711098901d@virtuozzo.com>
 <dcc46a1b-cd8a-78e3-6353-bf9fb2210d9b@redhat.com>
In-Reply-To: <dcc46a1b-cd8a-78e3-6353-bf9fb2210d9b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0035.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::45) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0bceb2c-e798-4f35-aed3-08d769b44c3b
x-ms-traffictypediagnostic: DB6PR08MB2886:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB288693D55C69734654CA03D5F4700@DB6PR08MB2886.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39850400004)(396003)(136003)(366004)(189003)(199004)(71190400001)(71200400001)(52116002)(76176011)(2201001)(86362001)(66446008)(2501003)(5660300002)(64756008)(186003)(6512007)(66476007)(66556008)(6306002)(31696002)(66946007)(6486002)(6116002)(3846002)(5024004)(305945005)(6436002)(2616005)(11346002)(6246003)(256004)(229853002)(2906002)(446003)(107886003)(14454004)(476003)(478600001)(26005)(966005)(386003)(8936002)(102836004)(66066001)(99286004)(7736002)(4326008)(6506007)(486006)(53546011)(44832011)(31686004)(8676002)(81156014)(81166006)(25786009)(36756003)(316002)(110136005)(54906003)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2886;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxhz+rMkV6Hw97OrrovxgFwjIFVv7ab7/G7SoTrF6Un7HmgwMNcRmlL7Qp2l5M1C/DAzIXRqTPVwhK+rAvsCCHxIt0AinuXgAnM4pltr+uKwWlCXwct9esg+ip/2DADwjAoDw7isP358CDR/DsEyfxMw9Eo1eQQTxxvq3uwPuRmsp7eSBy9P/ixr99Lp2gUgJhtvsnBroSLIm5GmF9fp0ipWvhGEQ9Q7VmOekc6X2TT+HJL4MNB3WyBHQYaJkOhYBkbU/csHz/wUsWTco2z01MTwlKcVU8kjoj6qVzj1xo6LJDUI0f0HpQ2VUbru0nlJ05XB18TLfhSN9exGB8g/GRTRmeamr4bCUcNPaR7yr7yUCM9qGBvKG/j17aJyOTXl3GtCszsaQwhrJv5/PPqSsjDqxLe9Rq1eYtnXF+dHxOb94htNVQsOGG0DzIZsyNiu
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <D4F71EB8B6DC104C87421E712F0D7442@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bceb2c-e798-4f35-aed3-08d769b44c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 10:12:19.1516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEeuDlciPXrE4IRqOX7lwyw83th/orrImK2VmoOwVFTo0PnhntMGF9SsuqZmbic8qxDeL4vJHTVtc8cQ8bnDUm5DgIJ8js7xZCo/ibLD7Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2886
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.132
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
 "armbru@redhat.com" <armbru@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 15/11/2019 12:32, Max Reitz wrote:
> On 14.11.19 12:59, Vladimir Sementsov-Ogievskiy wrote:
>> 14.11.2019 14:27, Max Reitz wrote:
>>> On 13.11.19 19:43, Andrey Shinkevich wrote:
>>>> Allow writing all the data compressed through the filter driver.
>>>> The written data will be aligned by the cluster size.
>>>> Based on the QEMU current implementation, that data can be written to
>>>> unallocated clusters only. May be used for a backup job.
>>>>
>>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>>    block/Makefile.objs     |   1 +
>>>>    block/filter-compress.c | 201 +++++++++++++++++++++++++++++++++++++=
+++++++++++
>>>>    qapi/block-core.json    |  10 ++-
>>>>    3 files changed, 208 insertions(+), 4 deletions(-)
>>>>    create mode 100644 block/filter-compress.c
>>>>
>>>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>>>> index e394fe0..330529b 100644
>>>> --- a/block/Makefile.objs
>>>> +++ b/block/Makefile.objs
>>>> @@ -43,6 +43,7 @@ block-obj-y +=3D crypto.o
>>>>   =20
>>>>    block-obj-y +=3D aio_task.o
>>>>    block-obj-y +=3D backup-top.o
>>>> +block-obj-y +=3D filter-compress.o
>>>>   =20
>>>>    common-obj-y +=3D stream.o
>>>>   =20
>>>> diff --git a/block/filter-compress.c b/block/filter-compress.c
>>>> new file mode 100644
>>>> index 0000000..64b1ee5
>>>> --- /dev/null
>>>> +++ b/block/filter-compress.c
>>>> @@ -0,0 +1,201 @@
>>>> +/*
>>>> + * Compress filter block driver
>>>> + *
>>>> + * Copyright (c) 2019 Virtuozzo International GmbH
>>>> + *
>>>> + * Author:
>>>> + *   Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> + *   (based on block/copy-on-read.c by Max Reitz)
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU General Public License as
>>>> + * published by the Free Software Foundation; either version 2 or
>>>> + * (at your option) any later version of the License.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU General Public License
>>>> + * along with this program; if not, see <http://www.gnu.org/licenses/=
>.
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "block/block_int.h"
>>>> +#include "qemu/module.h"
>>>> +
>>>> +
>>>> +static int compress_open(BlockDriverState *bs, QDict *options, int fl=
ags,
>>>> +                         Error **errp)
>>>> +{
>>>> +    bs->backing =3D bdrv_open_child(NULL, options, "file", bs, &child=
_file, false,
>>>> +                                  errp);
>>>
>>> Please don=92t attach something that the QAPI schema calls =93file=94 a=
s
>>> bs->backing.
>>
>>
>> Agree, it's a mistake. If we want backing and user set backing in option=
s, it's opened automatically, I think..
>>
>>>
>>> Yes, attaching it as bs->file would break backing chains.  That=92s a b=
ug
>>> in the block layer.  I=92ve been working on a fix for a long time.
>>>
>>> Please don=92t introduce more weirdness just because we have a bug in t=
he
>>> block layer.
>>>
>>> (Note that I=92d strongly oppose calling the child =93backing=94 in the=
 QAPI
>>> schema, as this would go against what all other user-creatable filters =
do.)
>>>
>>
>> So, are you opposite to correct backing-based user-creatable filter (wit=
h backing both
>> in QAPI and code)?
>=20
> I=92m not opposed to fixing it, but I don=92t think the fix is to make al=
l
> filters use bs->backing.
>=20
>> Do you think, that if we make backup-top to be user-creatable, we should=
 move it to be
>> file-child-based, or support both backing and file child?
>=20
> I definitely don=92t think it would be wrong.
>=20
> It depends on how difficult it is.  I=92m currently working on (more
> groundwork for the filter series v7) a series to rework BdrvChildRole so
> we can see from it what a child is used for (data, metadata, filter,
> COW).  I can already see that it won=91t work out perfectly because
> whenever we attach "backing", the question is whether that=92s a COW chil=
d
> now or whether it=92s a filtered child.  I suppose I=92m going to guess C=
OW
> when there=92s no way to get the information, and maybe sometimes be wron=
g.
>=20
> In my honest opinion, reusing bs->backing for filters was wrong.  I=92m
> not saying that bs->file was any better.  But I have a bit of a gripe
> with filters using bs->backing, because it=92s acknowledging a bug but no=
t
> fixing it at the same time.  Had we fixed the bug when we first noticed
> it with the introduction of the mirror filter, maybe we wouldn=92t be in
> this position now.  Or maybe we should have just added a bs->filtered lin=
k.
>=20
> But maybes aside, it still means that using bs->backing instead of
> bs->file is not really better.  Right now it=92s both wrong, and we need
> to fix the block layer so it isn=92t.
>=20
> So what to do for new filters?  Sure, bs->backing works around a bug
> now.  But it=92ll be weird once the bug is fixed.  Then we=92ll have filt=
ers
> that use @file and others will use @backing.  I don=92t think we want
> that, I think we want a uniform interface for all filters.
>=20
> And yes, that implies we probably should change backup-top to use file
> instead of backing once it gets an external interface.
>=20
> (Compare
> https://lists.nongnu.org/archive/html/qemu-block/2017-09/msg00380.html
> )
>=20
> Max
>=20

What if we modify backing_bs() as something like this
(to work around braking a backing chain):

static BlockDriverState *child_file_bs(BlockDriverState *bs)
{
     return bs->file ? bs->file->bs : NULL;
}

static BlockDriverState *skip_filter(BlockDriverState *bs)
{
     BlockDriverState *ret_bs =3D bs;

     while (ret_bs && ret_bs->drv && ret_bs->drv->is_filter) {
         ret_bs =3D child_file_bs(ret_bs);
     }

     return ret_bs;
}

static BlockDriverState *backing_bs(BlockDriverState *bs)
{
     BlockDriverState *ret_bs =3D skip_filter(bs);

     if (!ret_bs) {
         return NULL;
     }

     return ret_bs->backing ? ret_bs->backing->bs : NULL;
}

--=20
With the best regards,
Andrey Shinkevich


