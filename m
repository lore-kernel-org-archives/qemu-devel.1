Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97957C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547642467F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RTwmBZVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547642467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiH71-0002mP-31
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iiGsJ-0005zH-8w
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:55:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iiGsG-0003lK-8V
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:55:18 -0500
Received: from mail-eopbgr00094.outbound.protection.outlook.com
 ([40.107.0.94]:55989 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iiGsF-0003bu-2W; Fri, 20 Dec 2019 06:55:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECh/TrIeekuDLrrpudzYxzWtKcnuxSNKgLFbBXk+YfqbU+CDDFcXbooJu1luvRUbRIPlnrunOgfttSIyYWNkvv2GURx8MoDXAm8257h5DkRest6EviaVxOUnehbUfX2jAb52CJuXGuilXSdy5NOgLi6mmINRzzSW8eLI83CMYNNOBiyIsa49mD/ktktrP/BDSGReKp4604JGzn3haOdopDQScO40h3PKX2W0dy0CYutkk6cHvQfcrQgN20U74GNhyZnN2hQMahmHo/5PXMKZT/6Mja8eFcMJk19A/2gT7aL/gaJ3ghnwWOYp1wmBsXu/fiPLuZtOM7MWocMAOR0Wcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov0bNpwr7R+JljVbRNdNfbmza+SM36RXEdFh0k4sDgo=;
 b=ZsCgOrUaNGASt3V7a+pLgpGwGYM8lCIXtPYH/G4h6uwsdZZpMePcI9WhNPwWC0qXoQ702Vqi1bDc4/v7Twbi+cg+YwagGbjF7GjXmkpOcxo5Ij8ajgXsXB2HSdBtux6ty3rvSE4VVDTqaoUsHD+KO7Y1EZkszH7B2U2NZRc1ZPkaE66E6WfbTFrB1B1EjxWujGbHD9NLDSt/GeFlOgOvlRDPb5mDdrsLLisIknBt964egoJsq37B3UL6kIpKTOstqUDv/xnyd2XLPTOBrQDPzpo4YdF7LnDjcpAVYO+e1MHE3Xa4RKvCUjuw6HKHzJqt3ZoPNMM67SF/YOHk1qJeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov0bNpwr7R+JljVbRNdNfbmza+SM36RXEdFh0k4sDgo=;
 b=RTwmBZVb0KY7rStqGlSI+804X4kcwMyeQ9TPW26yNGZ1zU0sMoCvuo3X1UIyH1vNU1PbDAKigt0wadPbK+Wh8ja2bRIZKkF8T9cIfHgiH4NzA5WUwL25RaeBMrqdoZKGHGUsKiCQoxmvvYm3yWhD5WCjNdUs0hQfB0DTBXYXWgI=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4820.eurprd08.prod.outlook.com (10.255.99.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 11:55:12 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 11:55:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Thread-Topic: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Thread-Index: AQHVmKmF9vX+IDkOrkmVWASxqmj2taenFHcAgAr4WQCABhAWAIALBfwAgAAEcoA=
Date: Fri, 20 Dec 2019 11:55:12 +0000
Message-ID: <e2e89921-9121-a67a-474c-1f7f11a305ef@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-16-mreitz@redhat.com>
 <7f50c050-38ca-a7f2-361b-a08e82b420af@virtuozzo.com>
 <c2fde7aa-21fc-f8bb-02fa-af28ddd297f7@redhat.com>
 <9c1b3378-3509-23cc-a83a-f34d39fef239@virtuozzo.com>
 <0ef67269-4744-dc1e-cc71-09d947d8635b@redhat.com>
In-Reply-To: <0ef67269-4744-dc1e-cc71-09d947d8635b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191220145509832
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f8a694e-2920-491a-3ff5-08d78543780b
x-ms-traffictypediagnostic: AM6PR08MB4820:
x-microsoft-antispam-prvs: <AM6PR08MB4820F5F5C83D49A241074DE7C12D0@AM6PR08MB4820.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(376002)(346002)(366004)(396003)(189003)(199004)(71200400001)(186003)(8936002)(26005)(110136005)(86362001)(6506007)(81166006)(66946007)(316002)(6486002)(66556008)(64756008)(6512007)(66476007)(2906002)(36756003)(66446008)(81156014)(52116002)(31696002)(2616005)(53546011)(4326008)(8676002)(478600001)(54906003)(31686004)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4820;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DO06H9DGImLE7GUC7QgxHjyfxBwb0l2GdRkPwS1mFQUdYEvIr0z57VAD9+HMNFTJaot1fkehMOxPv+Hbi3iF4o7i4xvQsyj2fQl6L4RdLQxMi6IzjNS+sAmGoODr8ll2AGBjvhBnVvzg4NOVO8l4EfN9xRvP+rodq4/+dnS1Llswew/zr16sPb8Gzs2mMeNPj7qrZcSv1bh7xeaFhnge+CWQKlEYQRrhDrVTNJkqRdt1kRxgMqLRXUd/hDJEjfQNfbJxC70c3YTqzoJREe+Pmwi2bRBbtV0s+5nBL6P1aAGiRMXjbZ8P5ZrYF43ZguIQPmEsEp/miHvalCCVCLKsF5xkkBvQFvfsTW5EiJcw6FebjQHjEufihq5O/1pvvLZ8yQTfTCAag3F1u1/dR5aZotk3rUVCDyaTf8vqfagfLpxcoJNYWiFKri9qGwER2Eva
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <55B10187469B6F46A71A5A46C9F21C52@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8a694e-2920-491a-3ff5-08d78543780b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 11:55:12.0620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnWwlBJeeRwn04C7oK13gzdAcLsh3e8iHgAlAcWXxXFxZ70Kg1VXxl/VsUXjPd29Ej49WpFb0BuBtukHSof3HGsj9nlugRyIVodu87r1tng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4820
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.94
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.12.2019 14:39, Max Reitz wrote:
> On 13.12.19 12:18, Vladimir Sementsov-Ogievskiy wrote:
>> 09.12.2019 17:43, Max Reitz wrote:
>>> On 02.12.19 13:12, Vladimir Sementsov-Ogievskiy wrote:
>>>> 11.11.2019 19:02, Max Reitz wrote:
>>>>> While bdrv_replace_node() will not follow through with it, a specific
>>>>> @replaces asks the mirror job to create a loop.
>>>>>
>>>>> For example, say both the source and the target share a child where t=
he
>>>>> source is a filter; by letting @replaces point to the common child, y=
ou
>>>>> ask for a loop.
>>>>>
>>>>> Or if you use @replaces in drive-mirror with sync=3Dnone and
>>>>> mode=3Dabsolute-paths, you generally ask for a loop (@replaces must p=
oint
>>>>> to a child of the source, and sync=3Dnone makes the source the backin=
g
>>>>> file of the target after the job).
>>>>>
>>>>> bdrv_replace_node() will not create those loops, but by doing so, it
>>>>> ignores the user-requested configuration, which is not ideally either=
.
>>>>> (In the first example above, the target's child will remain what it w=
as,
>>>>> which may still be reasonable.  But in the second example, the target
>>>>> will just not become a child of the source, which is precisely what w=
as
>>>>> requested with @replaces.)
>>>>>
>>>>> So prevent such configurations, both before the job, and before it
>>>>> actually completes.
>>>>>
>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>>     block.c                   | 30 ++++++++++++++++++++++++
>>>>>     block/mirror.c            | 19 +++++++++++++++-
>>>>>     blockdev.c                | 48 ++++++++++++++++++++++++++++++++++=
++++-
>>>>>     include/block/block_int.h |  3 +++
>>>>>     4 files changed, 98 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/block.c b/block.c
>>>>> index 0159f8e510..e3922a0474 100644
>>>>> --- a/block.c
>>>>> +++ b/block.c
>>>>> @@ -6259,6 +6259,36 @@ out:
>>>>>         return to_replace_bs;
>>>>>     }
>>>>>    =20
>>>>> +/*
>>>>> + * Return true iff @child is a (recursive) child of @parent, with at
>>>>> + * least @min_level edges between them.
>>>>> + *
>>>>> + * (If @min_level =3D=3D 0, return true if @child =3D=3D @parent.  F=
or
>>>>> + * @min_level =3D=3D 1, @child needs to be at least a real child; fo=
r
>>>>> + * @min_level =3D=3D 2, it needs to be at least a grand-child; and s=
o on.)
>>>>> + */
>>>>> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *par=
ent,
>>>>> +                      int min_level)
>>>>> +{
>>>>> +    BdrvChild *c;
>>>>> +
>>>>> +    if (child =3D=3D parent && min_level <=3D 0) {
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>> +    if (!parent) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    QLIST_FOREACH(c, &parent->children, next) {
>>>>> +        if (bdrv_is_child_of(child, c->bs, min_level - 1)) {
>>>>> +            return true;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    return false;
>>>>> +}
>>>>> +
>>>>>     /**
>>>>>      * Iterates through the list of runtime option keys that are said=
 to
>>>>>      * be "strong" for a BDS.  An option is called "strong" if it cha=
nges
>>>>> diff --git a/block/mirror.c b/block/mirror.c
>>>>> index 68a4404666..b258c7e98b 100644
>>>>> --- a/block/mirror.c
>>>>> +++ b/block/mirror.c
>>>>> @@ -701,7 +701,24 @@ static int mirror_exit_common(Job *job)
>>>>>              * there.
>>>>>              */
>>>>>             if (bdrv_recurse_can_replace(src, to_replace)) {
>>>>> -            bdrv_replace_node(to_replace, target_bs, &local_err);
>>>>> +            /*
>>>>> +             * It is OK for @to_replace to be an immediate child of
>>>>> +             * @target_bs, because that is what happens with
>>>>> +             * drive-mirror sync=3Dnone mode=3Dabsolute-paths: targe=
t_bs's
>>>>> +             * backing file will be the source node, which is also
>>>>> +             * to_replace (by default).
>>>>> +             * bdrv_replace_node() handles this case by not letting
>>>>> +             * target_bs->backing point to itself, but to the source
>>>>> +             * still.
>>>>> +             */
>>>>> +            if (!bdrv_is_child_of(to_replace, target_bs, 2)) {
>>>>> +                bdrv_replace_node(to_replace, target_bs, &local_err)=
;
>>>>> +            } else {
>>>>> +                error_setg(&local_err, "Can no longer replace '%s' b=
y '%s', "
>>>>> +                           "because the former is now a child of the=
 latter, "
>>>>> +                           "and doing so would thus create a loop",
>>>>> +                           to_replace->node_name, target_bs->node_na=
me);
>>>>> +            }
>>>>
>>>> you may swap if and else branch, dropping "!" mark..
>>>
>>> Yes, but I just personally prefer to have the error case in the else br=
anch.
>>>
>>>>>             } else {
>>>>>                 error_setg(&local_err, "Can no longer replace '%s' by=
 '%s', "
>>>>>                            "because it can no longer be guaranteed th=
at doing so "
>>>>> diff --git a/blockdev.c b/blockdev.c
>>>>> index 9dc2238bf3..d29f147f72 100644
>>>>> --- a/blockdev.c
>>>>> +++ b/blockdev.c
>>>>> @@ -3824,7 +3824,7 @@ static void blockdev_mirror_common(const char *=
job_id, BlockDriverState *bs,
>>>>>         }
>>>>>    =20
>>>>>         if (has_replaces) {
>>>>> -        BlockDriverState *to_replace_bs;
>>>>> +        BlockDriverState *to_replace_bs, *target_backing_bs;
>>>>>             AioContext *replace_aio_context;
>>>>>             int64_t bs_size, replace_size;
>>>>>    =20
>>>>> @@ -3839,6 +3839,52 @@ static void blockdev_mirror_common(const char =
*job_id, BlockDriverState *bs,
>>>>>                 return;
>>>>>             }
>>>>>    =20
>>>>> +        if (bdrv_is_child_of(to_replace_bs, target, 1)) {
>>>>> +            error_setg(errp, "Replacing %s by %s would result in a l=
oop, "
>>>>> +                       "because the former is a child of the latter"=
,
>>>>> +                       to_replace_bs->node_name, target->node_name);
>>>>> +            return;
>>>>> +        }
>>>>
>>>> here min_level=3D1, so we don't handle the case, described in mirror_e=
xit_common..
>>>> I don't see why.. blockdev_mirror_common is called from qmp_drive_mirr=
or,
>>>> including the case with MIRROR_SYNC_MODE_NONE and NEW_IMAGE_MODE_ABSOL=
UTE_PATHS..
>>>>
>>>> What I'm missing?
>>>
>>> Hmm.  Well.
>>>
>>> If it broke drive-mirror sync=3Dnone, I suppose I would have noticed by
>>> running the iotests.  But I didn=92t, and that=92s because this code he=
re is
>>> reached only if the user actually specified @replaces.  (As opposed to
>>> the mirror_exit_common code, where @to_replace may simply be @src if no=
t
>>> overridden by the user.)
>>>
>>> The only reason why I allow it in mirror_exit_common is because we have
>>> to.  But if the user manually specifies this configuration, we can=92t
>>> guarantee it=92s safe.
>>>
>>> OTOH, well, if we allow it for drive-mirror sync=3Dnone, why not allow =
it
>>> when manually specified with blockdev-mirror?
>>>
>>> What=92s your opinion?
>>
>> Hmm, I think, that allowing to_replaces to be direct backing child of ta=
rget
>> (like in mirror_exit_common) is safe enough. User doesn't know that
>> such replacing includes also replacing own child of the target,
>> which leads to the loop.. It's not obvious. And behavior of
>> bdrv_replace_node() which just doesn't create this loop, doesn't
>> seem something too tricky. Hmm..
>>
>> We could mention in qapi spec, that replacing doesn't break backing
>> link of the target, for it to be absolutely defined.
>>
>> But should we allow replaces to be some other (not backing and not filte=
red)
>> child of target?..
>=20
> Well, my opinion is that this is a bit of weird thing to do and that it
> basically does ask for a loop.
>=20
> I=92m OK with excluding the sync=3Dnone case, because (1) that=92s so
> obviously a loop that it can=92t be what the user honestly wants; (2) how
> it=92s resolved is rather obvious, too: There is exactly one edge that
> causes the loop, so you simply don=92t change that one; (3) drive-mirror
> sync=3Dnone does this case automatically, so we should probably allow
> users to do it manually with blockdev-mirror, too.
>=20
>>>>> +
>>>>> +        if (backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN ||
>>>>> +            backing_mode =3D=3D MIRROR_OPEN_BACKING_CHAIN)
>>>>> +        {
>>>>> +            /*
>>>>> +             * While we do not quite know what OPEN_BACKING_CHAIN
>>>>> +             * (used for mode=3Dexisting) will yield, it is probably
>>>>> +             * best to restrict it exactly like SOURCE_BACKING_CHAIN=
,
>>>>> +             * because that is our best guess.
>>>>> +             */
>>>>> +            switch (sync) {
>>>>> +            case MIRROR_SYNC_MODE_FULL:
>>>>> +                target_backing_bs =3D NULL;
>>>>> +                break;
>>>>> +
>>>>> +            case MIRROR_SYNC_MODE_TOP:
>>>>> +                target_backing_bs =3D backing_bs(bs);
>>>>> +                break;
>>>>> +
>>>>> +            case MIRROR_SYNC_MODE_NONE:
>>>>> +                target_backing_bs =3D bs;
>>>>> +                break;
>>>>> +
>>>>> +            default:
>>>>> +                abort();
>>>>> +            }
>>>>> +        } else {
>>>>> +            assert(backing_mode =3D=3D MIRROR_LEAVE_BACKING_CHAIN);
>>>>> +            target_backing_bs =3D backing_bs(target);
>>>>> +        }
>>>>> +
>>>>> +        if (bdrv_is_child_of(to_replace_bs, target_backing_bs, 0)) {
>>>>> +            error_setg(errp, "Replacing '%s' by '%s' with this sync =
mode would "
>>>>> +                       "result in a loop, because the former would b=
e a child "
>>>>> +                       "of the latter's backing file ('%s') after th=
e mirror "
>>>>> +                       "job", to_replace_bs->node_name, target->node=
_name,
>>>>> +                       target_backing_bs->node_name);
>>>>> +            return;
>>>>> +        }
>>>>
>>>> hmm.. so for MODE_NONE we disallow to_replace =3D=3D src?
>>>
>>> I suppose that=92s basically the same as above.  Should we allow this c=
ase
>>> when specified explicitly by the user?
>>>
>>
>> I'm a bit more closer to allowing it, for consistency with automatic pat=
h, with
>> unspecified replaces. Are we sure that nobody uses it?
>=20
> Well, there are multiple cases, as shown in the commit message.  I think
> that for drive-mirror sync=3Dnone, nobody uses @replaces, because it just
> doesn=92t work.
>=20
> But, well, that=92s just because drive-mirror does graph manipulation tha=
t
> blockdev-mirror doesn=92t (i.e., changing the target=92s backing file on
> completion).  So maybe we should just prevent loops for drive-mirror,
> but let the user do what they want when they use blockdev-mirror?
>=20

Well, the question finally is, how much to restrict from things for which w=
e
don't know are they useful or not. I don't know) I think, finally, I'm OK w=
ith
either way we discussed, or with this patch as is. If it breaks some existi=
ng
scenario it will be easy to fix.

--=20
Best regards,
Vladimir

