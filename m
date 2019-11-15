Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C10C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 10:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFB82072B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 10:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="P25BhW4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFB82072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVZE2-0006KA-56
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 05:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVZDH-0005o9-6g
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVZDD-0003tF-EE
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:52:26 -0500
Received: from mail-eopbgr30096.outbound.protection.outlook.com
 ([40.107.3.96]:19758 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVZD6-0003r4-5o; Fri, 15 Nov 2019 05:52:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYtp7HuM6e4NpbbBPAAPJ60Pfu7gq0F1JoeKGFa7C5Q+jjnDhdD1y56Ebjj+w6QTYwEiiwcXILnfjPJwx4XwfZdZb6DJTEkYTuAhITRQECOoLB/j2GzFMenjyoScL6rGzd0zM5a1Lv7y65NNVGDmjhEapD/MHBsRf8mf3dcoIjlo/buH67hcrfyhLfKxuGt4w9Zg597AV/Hb991VZ8tq9l8GvQfcwsZvtRH6sbIWmT5f/Pg4ot9Ik6xrRjjsTp8pDObc9DEMc04stlBqb5UZ4K9Z/anOj1B8BV1ROJ/5YxHym45rlXQnX8h3s5w4vdUKSoIOEva9VtPBO8SXPe0lxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w4T4frHghiDFTh6nIg+oNbVjr/XsdVDrZdlBne7XsI=;
 b=OPM0ruonekELBHqhqIUDJ+acLTbUmINhG25ix6poU5AqzjtxEmm3meXXS5H3IWMlRDmaoUENyB56iYOQMzaJ+9NqnLb+pUnV7A9/3KG6I0KttBG/MugjgLmInuu+VqRhpZ7sApqvjwzS2fwXkNvbkvUpcOWpmJZA4H+oFA+iSGwL+iTkvnnfHr9XamX1j6vAk/xT55XdfVDvI94/fxuXLFLRcnv1oWEIC1fN+tki4vY1II3gVXv/aOAN8MtBL67AY0ql8J/nkg7B2ZR76HxhPZ8eiQ/ELQU9ENsXb+HM63uffH+tZGp9Ubyt6SyFTUm9/KAuhzeNvLhE3/LAxBXg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w4T4frHghiDFTh6nIg+oNbVjr/XsdVDrZdlBne7XsI=;
 b=P25BhW4Tc/ur+0pbepO/xUBYzlzBB3Hd34ygWjTLLklx155CUEIEaKC5NjzyYpOhNcCnPks7igZxJ/1ZyaGcN1+nm9ZRTj0v8sF8UPLVnu6ybVarqzSjiMMMxnJX5h61MV7DaDexzvBXaYbHCRzelwQWDLr0jyCjUUV984glJfM=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB2998.eurprd08.prod.outlook.com (52.135.168.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Fri, 15 Nov 2019 10:52:13 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 10:52:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v7 1/3] block: introduce compress filter driver
Thread-Topic: [PATCH v7 1/3] block: introduce compress filter driver
Thread-Index: AQHVmlI7eO4+ta1idUecy2WkuY5gm6eKiHMAgAAI8QCAAWlEgIAAFikA
Date: Fri, 15 Nov 2019 10:52:13 +0000
Message-ID: <36394cc3-9d68-5f56-7d44-ca56ff3cf7e3@virtuozzo.com>
References: <1573670589-229357-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1573670589-229357-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a5dd3514-a804-6c63-2158-0dff9ac37ab3@redhat.com>
 <96bda153-8923-41fb-5374-10711098901d@virtuozzo.com>
 <dcc46a1b-cd8a-78e3-6353-bf9fb2210d9b@redhat.com>
In-Reply-To: <dcc46a1b-cd8a-78e3-6353-bf9fb2210d9b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::47) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191115135210214
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd21a135-0014-48fa-8511-08d769b9df1e
x-ms-traffictypediagnostic: AM6PR08MB2998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB2998EF2216EFD58927DA3D37C1700@AM6PR08MB2998.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(136003)(346002)(39850400004)(396003)(189003)(199004)(5024004)(305945005)(71200400001)(71190400001)(14454004)(36756003)(99286004)(2501003)(7736002)(66066001)(81166006)(4326008)(107886003)(6246003)(486006)(81156014)(25786009)(86362001)(2616005)(476003)(8676002)(446003)(11346002)(8936002)(52116002)(76176011)(966005)(229853002)(186003)(31686004)(31696002)(386003)(6512007)(102836004)(53546011)(6506007)(6306002)(6486002)(478600001)(6436002)(2201001)(26005)(5660300002)(6116002)(3846002)(2906002)(66946007)(64756008)(66446008)(66476007)(66556008)(256004)(54906003)(110136005)(316002)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB2998;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BjuAFtr81msI7ukhGJ2MINdtJR/ezIUZ0Ome7nAE4QoJIaBogngO+pmSt6YJWMlHUBQso6puFYjYRUv3RvKAAfFPMbWT8PQziDMxaDpn/U9tvHNkk4PUhF7iRStmyrBtWCvstFiWrpflYH/jFqQIHE07cxfBEbGnZGyhMzpiiECklCORz94nRbkj/YKb98vniRo333WWDyDkk+SCvqL+UJvVw9CMB0pWcoZz3yX/cArGhd+/8TOXVP5v+I0Pm+U29rI2FN/Z4Sh5WxVA+XgIT7wYTG84IHB4LnoufHS73FWdEsVPCfLROodeXQFh0S/RPIe+3570QEk+LdmlyWDueJnRAxRnsLVsePdO0o5aNTgFV9wVFDpMySc7OQ0HdhBa/gNN2/r3WNVdW/lOO7Raa5Q6l6WBnwDVuFNTrdb2AHr6aGgb+fErAA1b23eyDpXH
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <55692AB67E4F0148B4C9CDD5344D7EB8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd21a135-0014-48fa-8511-08d769b9df1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 10:52:13.1468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhvX5E8d34u5dT4MLgqyQGJiXrPdyP8VhtRuCorC+wKuMJ5HEWBQZx2JIVOfrHYTVStLWzLcuZNne7HuIMq4n0E05T5l5IDy2vQqBZxrsPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2998
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.96
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

15.11.2019 12:32, Max Reitz wrote:
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

OK, got your point. Let's use file child in compress filter. Hope for your =
series!

--=20
Best regards,
Vladimir

