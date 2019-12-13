Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D0DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560A124125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FBzb9pwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560A124125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifizE-0005jr-I4
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 06:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ifiyQ-0005CU-HG
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ifiyO-0004sH-8t
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:19:06 -0500
Received: from mail-eopbgr70109.outbound.protection.outlook.com
 ([40.107.7.109]:54199 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ifiyN-0004m7-Ax; Fri, 13 Dec 2019 06:19:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR0eMeCo6aJgeeXjpG0+YbKjTwkFu6iBA6iehJTll6kj+JoQvkDflem+HFbPLBPl31XPtSOIE/aW2urE99OJclGxJtMA4AgbgjlzTU7Tu4SxNui4b3BQLugLO+Gc2x69sENX0QaZxATTaDUGGefQnwydzeAy4sQJFQt5t+sPru4F5zomD1u2XeJ1docMvNQTJk5lQBYKjsEADnluZow0pcW1h9OPjtdDUnf8nX9axencqse/zpZe64AkgHgJpkJWnNVS0hnGVywsuo+zhWc1VORmjSxukVVWOInde8uO6z4tHV6wu+VCsoMxp4FAxQen1JhMc3/98qIgy4dDJEzHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHOvPZLbdCAjqfMSyf1+QM/Omwc6Snkj+4z3gGBiG7w=;
 b=Xab1yM1KQg8kNQt7L+ekxu0rItqb2mYZi0ac7zmIPuzCxN4xPVQTRCrBBmnlSQpFiHM51G+TvSy32y3PjDV9+UKHuGuhE3aD9LxKPYlKk0ItOnJwhLg+PyIR9fa7HjqRo2I6KY1FZfHgaw3PWukrxDQ59tx/eAMzD+sxy5kQ05KbtdLjfFS/2vYABnWnsyxNHBHkshT+MPAkaMnVPVYajBMZo+tVjQv7sXsokj1/MPgQa9p3MKZo9vA/jVjomJaht651FvucxySmvO8QbVei88jrDQnSop53Jxyrl4HDQT7/qd0mVZP3kP9uRGz/axBHUzFvtY8avy3xlwPDB0912Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHOvPZLbdCAjqfMSyf1+QM/Omwc6Snkj+4z3gGBiG7w=;
 b=FBzb9pwc2NaXrCDH48rintLi7NicMTt5//VdtBKa8KHrWZwnHLEYEyqwSl03Fs41wv6+DDSWSrpAdHOVmpSJkdQsy0UWbvDr1K638w7II6+tzWZkJ7eF3rEz/DG2y9dT5/kbZPUrCKPtVfS4j27nTmkUaV8sp+glbc4g61HkUaE=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3382.eurprd08.prod.outlook.com (20.177.113.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 13 Dec 2019 11:19:00 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.020; Fri, 13 Dec 2019
 11:19:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Thread-Topic: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Thread-Index: AQHVmKmF9vX+IDkOrkmVWASxqmj2taenFHcAgAr4WQCABhAWAA==
Date: Fri, 13 Dec 2019 11:18:59 +0000
Message-ID: <9c1b3378-3509-23cc-a83a-f34d39fef239@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-16-mreitz@redhat.com>
 <7f50c050-38ca-a7f2-361b-a08e82b420af@virtuozzo.com>
 <c2fde7aa-21fc-f8bb-02fa-af28ddd297f7@redhat.com>
In-Reply-To: <c2fde7aa-21fc-f8bb-02fa-af28ddd297f7@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0046.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::17) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191213141857997
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8817dbd6-1484-4f99-530a-08d77fbe4066
x-ms-traffictypediagnostic: AM6PR08MB3382:
x-microsoft-antispam-prvs: <AM6PR08MB33827195ADE52026A50C2EC6C1540@AM6PR08MB3382.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(39840400004)(366004)(396003)(199004)(189003)(31696002)(52116002)(36756003)(6506007)(53546011)(31686004)(2616005)(66446008)(64756008)(71200400001)(6512007)(86362001)(66556008)(81156014)(66946007)(8676002)(81166006)(2906002)(66476007)(8936002)(26005)(6486002)(5660300002)(54906003)(186003)(478600001)(110136005)(4326008)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3382;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RETfq5RczkmWlSo9h/ipqAuF9h88YmP4lcrtdM9P1K1EyGR8a9NpoFIbp0Zgw9eP1emoBufImv+6rR43rp1HOQb3D1GMzVoWBYqin+bNvL0AlS83a79GOH0F8N7CC1/q0R8Mgcv/k5ZKsXG34Yyy66qiBVLC4M9Bm9uQMFNSOV6WEDRUL+ah8p25Z+wDCzJx7BiRweZEKfgAYw+vriKTntJMG8cXNq0Cggb84ojmmbkRhD7HV7vYGxj7jdTlaUbItkZabLSwYEun6X9gTBMB16PIUBTqK0aR1moA36w2oLN1O7mfZYxVxaOj8kh0FAdKof8oxRLyTSEysx6399A/MsSxGHIHtFy3qUQ7KzH/3RUeCX0ltawTdiwMLSF7Qg8bB8RFOqBLv9PisoUxSmeaisCpekW/0nV5O6c1q7CCDZnC8iKf+km0eVQIS0hrYaak
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <87D4253468AA4045AE2FDF13BD38EAF1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8817dbd6-1484-4f99-530a-08d77fbe4066
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 11:18:59.9354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxL3taf+OALrTkPmF1bJyVRGlVbM9ktCrpZ7R1HNx+5/t0LG3n03dg7rWpvQwdReLMxlG1rHQHBtOGS7EHyXqLVEM9TpvY6zSNwSlSPmqxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3382
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 40.107.7.109
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

09.12.2019 17:43, Max Reitz wrote:
> On 02.12.19 13:12, Vladimir Sementsov-Ogievskiy wrote:
>> 11.11.2019 19:02, Max Reitz wrote:
>>> While bdrv_replace_node() will not follow through with it, a specific
>>> @replaces asks the mirror job to create a loop.
>>>
>>> For example, say both the source and the target share a child where the
>>> source is a filter; by letting @replaces point to the common child, you
>>> ask for a loop.
>>>
>>> Or if you use @replaces in drive-mirror with sync=3Dnone and
>>> mode=3Dabsolute-paths, you generally ask for a loop (@replaces must poi=
nt
>>> to a child of the source, and sync=3Dnone makes the source the backing
>>> file of the target after the job).
>>>
>>> bdrv_replace_node() will not create those loops, but by doing so, it
>>> ignores the user-requested configuration, which is not ideally either.
>>> (In the first example above, the target's child will remain what it was=
,
>>> which may still be reasonable.  But in the second example, the target
>>> will just not become a child of the source, which is precisely what was
>>> requested with @replaces.)
>>>
>>> So prevent such configurations, both before the job, and before it
>>> actually completes.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    block.c                   | 30 ++++++++++++++++++++++++
>>>    block/mirror.c            | 19 +++++++++++++++-
>>>    blockdev.c                | 48 +++++++++++++++++++++++++++++++++++++=
+-
>>>    include/block/block_int.h |  3 +++
>>>    4 files changed, 98 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block.c b/block.c
>>> index 0159f8e510..e3922a0474 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -6259,6 +6259,36 @@ out:
>>>        return to_replace_bs;
>>>    }
>>>   =20
>>> +/*
>>> + * Return true iff @child is a (recursive) child of @parent, with at
>>> + * least @min_level edges between them.
>>> + *
>>> + * (If @min_level =3D=3D 0, return true if @child =3D=3D @parent.  For
>>> + * @min_level =3D=3D 1, @child needs to be at least a real child; for
>>> + * @min_level =3D=3D 2, it needs to be at least a grand-child; and so =
on.)
>>> + */
>>> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *paren=
t,
>>> +                      int min_level)
>>> +{
>>> +    BdrvChild *c;
>>> +
>>> +    if (child =3D=3D parent && min_level <=3D 0) {
>>> +        return true;
>>> +    }
>>> +
>>> +    if (!parent) {
>>> +        return false;
>>> +    }
>>> +
>>> +    QLIST_FOREACH(c, &parent->children, next) {
>>> +        if (bdrv_is_child_of(child, c->bs, min_level - 1)) {
>>> +            return true;
>>> +        }
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>>    /**
>>>     * Iterates through the list of runtime option keys that are said to
>>>     * be "strong" for a BDS.  An option is called "strong" if it change=
s
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index 68a4404666..b258c7e98b 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -701,7 +701,24 @@ static int mirror_exit_common(Job *job)
>>>             * there.
>>>             */
>>>            if (bdrv_recurse_can_replace(src, to_replace)) {
>>> -            bdrv_replace_node(to_replace, target_bs, &local_err);
>>> +            /*
>>> +             * It is OK for @to_replace to be an immediate child of
>>> +             * @target_bs, because that is what happens with
>>> +             * drive-mirror sync=3Dnone mode=3Dabsolute-paths: target_=
bs's
>>> +             * backing file will be the source node, which is also
>>> +             * to_replace (by default).
>>> +             * bdrv_replace_node() handles this case by not letting
>>> +             * target_bs->backing point to itself, but to the source
>>> +             * still.
>>> +             */
>>> +            if (!bdrv_is_child_of(to_replace, target_bs, 2)) {
>>> +                bdrv_replace_node(to_replace, target_bs, &local_err);
>>> +            } else {
>>> +                error_setg(&local_err, "Can no longer replace '%s' by =
'%s', "
>>> +                           "because the former is now a child of the l=
atter, "
>>> +                           "and doing so would thus create a loop",
>>> +                           to_replace->node_name, target_bs->node_name=
);
>>> +            }
>>
>> you may swap if and else branch, dropping "!" mark..
>=20
> Yes, but I just personally prefer to have the error case in the else bran=
ch.
>=20
>>>            } else {
>>>                error_setg(&local_err, "Can no longer replace '%s' by '%=
s', "
>>>                           "because it can no longer be guaranteed that =
doing so "
>>> diff --git a/blockdev.c b/blockdev.c
>>> index 9dc2238bf3..d29f147f72 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>> @@ -3824,7 +3824,7 @@ static void blockdev_mirror_common(const char *jo=
b_id, BlockDriverState *bs,
>>>        }
>>>   =20
>>>        if (has_replaces) {
>>> -        BlockDriverState *to_replace_bs;
>>> +        BlockDriverState *to_replace_bs, *target_backing_bs;
>>>            AioContext *replace_aio_context;
>>>            int64_t bs_size, replace_size;
>>>   =20
>>> @@ -3839,6 +3839,52 @@ static void blockdev_mirror_common(const char *j=
ob_id, BlockDriverState *bs,
>>>                return;
>>>            }
>>>   =20
>>> +        if (bdrv_is_child_of(to_replace_bs, target, 1)) {
>>> +            error_setg(errp, "Replacing %s by %s would result in a loo=
p, "
>>> +                       "because the former is a child of the latter",
>>> +                       to_replace_bs->node_name, target->node_name);
>>> +            return;
>>> +        }
>>
>> here min_level=3D1, so we don't handle the case, described in mirror_exi=
t_common..
>> I don't see why.. blockdev_mirror_common is called from qmp_drive_mirror=
,
>> including the case with MIRROR_SYNC_MODE_NONE and NEW_IMAGE_MODE_ABSOLUT=
E_PATHS..
>>
>> What I'm missing?
>=20
> Hmm.  Well.
>=20
> If it broke drive-mirror sync=3Dnone, I suppose I would have noticed by
> running the iotests.  But I didn=92t, and that=92s because this code here=
 is
> reached only if the user actually specified @replaces.  (As opposed to
> the mirror_exit_common code, where @to_replace may simply be @src if not
> overridden by the user.)
>=20
> The only reason why I allow it in mirror_exit_common is because we have
> to.  But if the user manually specifies this configuration, we can=92t
> guarantee it=92s safe.
>=20
> OTOH, well, if we allow it for drive-mirror sync=3Dnone, why not allow it
> when manually specified with blockdev-mirror?
>=20
> What=92s your opinion?

Hmm, I think, that allowing to_replaces to be direct backing child of targe=
t
(like in mirror_exit_common) is safe enough. User doesn't know that
such replacing includes also replacing own child of the target,
which leads to the loop.. It's not obvious. And behavior of
bdrv_replace_node() which just doesn't create this loop, doesn't
seem something too tricky. Hmm..

We could mention in qapi spec, that replacing doesn't break backing
link of the target, for it to be absolutely defined.

But should we allow replaces to be some other (not backing and not filtered=
)
child of target?..

>=20
>>> +
>>> +        if (backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN ||
>>> +            backing_mode =3D=3D MIRROR_OPEN_BACKING_CHAIN)
>>> +        {
>>> +            /*
>>> +             * While we do not quite know what OPEN_BACKING_CHAIN
>>> +             * (used for mode=3Dexisting) will yield, it is probably
>>> +             * best to restrict it exactly like SOURCE_BACKING_CHAIN,
>>> +             * because that is our best guess.
>>> +             */
>>> +            switch (sync) {
>>> +            case MIRROR_SYNC_MODE_FULL:
>>> +                target_backing_bs =3D NULL;
>>> +                break;
>>> +
>>> +            case MIRROR_SYNC_MODE_TOP:
>>> +                target_backing_bs =3D backing_bs(bs);
>>> +                break;
>>> +
>>> +            case MIRROR_SYNC_MODE_NONE:
>>> +                target_backing_bs =3D bs;
>>> +                break;
>>> +
>>> +            default:
>>> +                abort();
>>> +            }
>>> +        } else {
>>> +            assert(backing_mode =3D=3D MIRROR_LEAVE_BACKING_CHAIN);
>>> +            target_backing_bs =3D backing_bs(target);
>>> +        }
>>> +
>>> +        if (bdrv_is_child_of(to_replace_bs, target_backing_bs, 0)) {
>>> +            error_setg(errp, "Replacing '%s' by '%s' with this sync mo=
de would "
>>> +                       "result in a loop, because the former would be =
a child "
>>> +                       "of the latter's backing file ('%s') after the =
mirror "
>>> +                       "job", to_replace_bs->node_name, target->node_n=
ame,
>>> +                       target_backing_bs->node_name);
>>> +            return;
>>> +        }
>>
>> hmm.. so for MODE_NONE we disallow to_replace =3D=3D src?
>=20
> I suppose that=92s basically the same as above.  Should we allow this cas=
e
> when specified explicitly by the user?
>=20

I'm a bit more closer to allowing it, for consistency with automatic path, =
with
unspecified replaces. Are we sure that nobody uses it?

>=20
>>> +
>>>            replace_aio_context =3D bdrv_get_aio_context(to_replace_bs);
>>>            aio_context_acquire(replace_aio_context);
>>>            replace_size =3D bdrv_getlength(to_replace_bs);
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index 589a797fab..7064a1a4fa 100644
>>> --- a/include/block/block_int.h
>>> +++ b/include/block/block_int.h
>>> @@ -1266,6 +1266,9 @@ void bdrv_format_default_perms(BlockDriverState *=
bs, BdrvChild *c,
>>>    bool bdrv_recurse_can_replace(BlockDriverState *bs,
>>>                                  BlockDriverState *to_replace);
>>>   =20
>>> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *paren=
t,
>>> +                      int min_level);
>>> +
>>>    /*
>>>     * Default implementation for drivers to pass bdrv_co_block_status()=
 to
>>>     * their file.
>>>
>>
>>
>=20
>=20


--=20
Best regards,
Vladimir

