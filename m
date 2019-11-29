Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EDAC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503B8216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qFtRY8au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503B8216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafKP-0002Hn-Eh
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iaeyK-0003Bs-2A
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iaeyD-0000Dm-Lc
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:02:03 -0500
Received: from mail-eopbgr30100.outbound.protection.outlook.com
 ([40.107.3.100]:59623 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iaeyB-000070-2Y; Fri, 29 Nov 2019 07:01:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ks05jamIn3/v/jG1sek8TloL8KJ+nZ3hPLxHESJQA2QnJfIZdNtCJcUOxSoqyTWtnkO4b7PyobX+BICXanojNeUM1kWrJtyHkrjhz5rBQRL1RN9NKpL9NqTuKZ0bfycGsL8ZbHYkGP+11/OeJ1oqN4p3H38PS42dZ8Ui2sFER82UXDzM1YIjzmfyBH5dZN18PUwYjL4nzTU+Op56hNx+mJ5lBkM+zRffwHf4Q7H0eTuBNsMkjMDJ1/Yh8zlvFDv1n9mqPM3sWK5dIXyWkluQBMnEFd9IF9gm56p60evtUYPcreFmT9lQoy3TndpyK4jpmvw/Pmdn3sWAUnVZ9oV+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frQcL02O5iuxK+6HPiDoj4+S+XPeyOl0kkupxHEpsWA=;
 b=Z6sJsxVJxSbOl7SpG9ZCji6ROrCtnmY4WPF4Z99N4P6Kcp+vxb4b2+9lecf14doTDBGWGp1Yf17yICHrNUYX0xtRwJcZSs9PtCwf4FWveEuxCn8a/zT/8+a8gjkq45f4L8tqGdiEJfsjkZoLUUONixmgIc9xhof6/7/ZKnwOHHTvpauNDkbOiNFEBXKXTBxnps7BatITJjr9rueYhCerLOxKAImxtH7FhwFHQe0H3/QSSVWBe36Nbve5qj/D9mebDh866hkgTWl5i9UFGwQlnLGi2ex/K8Kd6mJa5/kzjrZNnCeNMJs5PsCy0rRH2piM6luzQn5/z4Rdo/5xs+E9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frQcL02O5iuxK+6HPiDoj4+S+XPeyOl0kkupxHEpsWA=;
 b=qFtRY8auTIgShbv9HLvXpJ3s/Hq2UeSCMNOJu3pOUuL68+syoTLov1wKqNlnA63WMpDkqf+7I7TWT0N4NVl2Ihq1LchpA6ZItrNE0JI89MmEQqtFSkVnDwIp7N2djVTyFRqYhm3hobC5ImkkkkpvkfxG0p1URa6JSgnAzYiilDE=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3240.eurprd08.prod.outlook.com (52.135.165.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 12:01:50 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 12:01:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Thread-Topic: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Thread-Index: AQHVmKmF9vX+IDkOrkmVWASxqmj2taeiKDmA
Date: Fri, 29 Nov 2019 12:01:50 +0000
Message-ID: <2c47c1be-e633-c769-88fe-684fe1ebe80f@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-16-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-16-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0001.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::11) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129150147144
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fdf200f-5831-4782-b840-08d774c3ea93
x-ms-traffictypediagnostic: AM6PR08MB3240:
x-microsoft-antispam-prvs: <AM6PR08MB3240AF3CF4112D1CDFB503D4C1460@AM6PR08MB3240.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39840400004)(199004)(189003)(66476007)(3846002)(6116002)(36756003)(66946007)(64756008)(186003)(66556008)(316002)(8676002)(66446008)(26005)(8936002)(71200400001)(25786009)(14454004)(11346002)(2906002)(71190400001)(256004)(2616005)(446003)(99286004)(54906003)(6486002)(6436002)(31686004)(110136005)(2501003)(31696002)(5660300002)(4326008)(81166006)(81156014)(305945005)(52116002)(7736002)(478600001)(6506007)(76176011)(6246003)(229853002)(102836004)(66066001)(86362001)(6512007)(386003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3240;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9E+Ydkm7boZOpTXi3iPMxtDjrkdaKt0U9t1ofJ3FzsrCkGxSzeSrtEkoT8m9gF7bQ2Fm97aH9aKLjHryKxwuFxXrjDuqJgzMml72xoO6VIbQsQyOdFwqqWsbm87+FSBcbXB21Xp6UJown4oNIknDBXr3XuB0s0iSlIMCklxTXsXPodOuiFHxqz+1sbjMO807Ipnhi/VayLEGFvY1oU3De/ZyJVVsj6SE7Dnq1conLpERb/tzRY2GIjhKoHj8+gm9lADKm0DTfW8nap+tl7rzAe1SFx9xB7cDjZ4qWVlzU060hrGvrog8n9rIdYiPx4unYqvbn9NURQm65qvA+GQkVBp+RuWbUynWuYSSKioOBJSrj4sp0b/Ey7+/SBoV8DaG9CctyLxdQEvTvSOkttS6fAqL1BFa+rfepXX0CGtBAlofPmnk5E+lYjO18Q6ZD7Oy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9E7B830D41E5194A8FDA2CAA4FF71DF3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdf200f-5831-4782-b840-08d774c3ea93
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 12:01:50.0657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dDC4+AqaujsfiRx9sAPBafX+lCJesNcD3O9tCT6VJzdmFZWmjF+MCKPD8iM4bwbDd3ybg0xbCc/Qe8TYagb9aZul1kgc3ftH1TOqw7bgzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3240
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.100
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

11.11.2019 19:02, Max Reitz wrote:
> While bdrv_replace_node() will not follow through with it, a specific
> @replaces asks the mirror job to create a loop.
>=20
> For example, say both the source and the target share a child where the
> source is a filter; by letting @replaces point to the common child, you
> ask for a loop.
>=20
> Or if you use @replaces in drive-mirror with sync=3Dnone and
> mode=3Dabsolute-paths, you generally ask for a loop (@replaces must point
> to a child of the source, and sync=3Dnone makes the source the backing
> file of the target after the job).
>=20
> bdrv_replace_node() will not create those loops, but by doing so, it
> ignores the user-requested configuration, which is not ideally either.
> (In the first example above, the target's child will remain what it was,
> which may still be reasonable.  But in the second example, the target
> will just not become a child of the source, which is precisely what was
> requested with @replaces.)
>=20
> So prevent such configurations, both before the job, and before it
> actually completes.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c                   | 30 ++++++++++++++++++++++++
>   block/mirror.c            | 19 +++++++++++++++-
>   blockdev.c                | 48 ++++++++++++++++++++++++++++++++++++++-
>   include/block/block_int.h |  3 +++
>   4 files changed, 98 insertions(+), 2 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 0159f8e510..e3922a0474 100644
> --- a/block.c
> +++ b/block.c
> @@ -6259,6 +6259,36 @@ out:
>       return to_replace_bs;
>   }
>  =20
> +/*
> + * Return true iff @child is a (recursive) child of @parent, with at
> + * least @min_level edges between them.
> + *
> + * (If @min_level =3D=3D 0, return true if @child =3D=3D @parent.  For
> + * @min_level =3D=3D 1, @child needs to be at least a real child; for
> + * @min_level =3D=3D 2, it needs to be at least a grand-child; and so on=
.)
> + */
> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *parent,
> +                      int min_level)
> +{
> +    BdrvChild *c;
> +
> +    if (child =3D=3D parent && min_level <=3D 0) {
> +        return true;
> +    }
> +
> +    if (!parent) {
> +        return false;
> +    }
> +
> +    QLIST_FOREACH(c, &parent->children, next) {
> +        if (bdrv_is_child_of(child, c->bs, min_level - 1)) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>   /**
>    * Iterates through the list of runtime option keys that are said to
>    * be "strong" for a BDS.  An option is called "strong" if it changes
> diff --git a/block/mirror.c b/block/mirror.c
> index 68a4404666..b258c7e98b 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -701,7 +701,24 @@ static int mirror_exit_common(Job *job)
>            * there.
>            */
>           if (bdrv_recurse_can_replace(src, to_replace)) {
> -            bdrv_replace_node(to_replace, target_bs, &local_err);
> +            /*
> +             * It is OK for @to_replace to be an immediate child of
> +             * @target_bs, because that is what happens with
> +             * drive-mirror sync=3Dnone mode=3Dabsolute-paths: target_bs=
's
> +             * backing file will be the source node, which is also
> +             * to_replace (by default).
> +             * bdrv_replace_node() handles this case by not letting
> +             * target_bs->backing point to itself, but to the source
> +             * still.
> +             */

Hmm.. So, we want the following valid case:

(other parents of source) ----> source =3D to_replace <--- backing --- targ=
et

becomes

(other parents of source) ----> target --- backing ---> source

But it seems for me, that the following is not less valid:

(other parents of source) ----> source =3D to_replace <--- backing --- X <-=
-- backing --- target

becomes

(other parents of source) ----> target --- backing ---> X --- backing ---> =
source

And what we actually want to prevent, is when to_replace is not source, but=
 child (may be not direct)
of source..

Also, with your check you still allow silent no-change in the following cas=
e:

source --- backing --> to_replace <-- backing -- target

=3D=3D=3D=3D

In other words, replacing make sense, only if to_replace has some other par=
ents, which are not
children (may be not direct) of target.. And the only known such case is wh=
en in the same time
to_replace =3D=3D source.

so, shouldn't the following be

if (to_replace =3D=3D src || !bdrv_is_child_of(to_replace, target_bs, 1) {

or, may be, to allow also replace filters above src, keeping backing link :

if (bdrv_is_child_of(src, to_replace, 0) || !bdrv_is_child_of(to_replace, t=
arget_bs, 1) {

> +            if (!bdrv_is_child_of(to_replace, target_bs, 2)) {
> +                bdrv_replace_node(to_replace, target_bs, &local_err);
> +            } else {
> +                error_setg(&local_err, "Can no longer replace '%s' by '%=
s', "
> +                           "because the former is now a child of the lat=
ter, "
> +                           "and doing so would thus create a loop",
> +                           to_replace->node_name, target_bs->node_name);
> +            }
>           } else {
>               error_setg(&local_err, "Can no longer replace '%s' by '%s',=
 "
>                          "because it can no longer be guaranteed that doi=
ng so "
> diff --git a/blockdev.c b/blockdev.c
> index 9dc2238bf3..d29f147f72 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3824,7 +3824,7 @@ static void blockdev_mirror_common(const char *job_=
id, BlockDriverState *bs,
>       }
>  =20
>       if (has_replaces) {
> -        BlockDriverState *to_replace_bs;
> +        BlockDriverState *to_replace_bs, *target_backing_bs;
>           AioContext *replace_aio_context;
>           int64_t bs_size, replace_size;
>  =20
> @@ -3839,6 +3839,52 @@ static void blockdev_mirror_common(const char *job=
_id, BlockDriverState *bs,
>               return;
>           }
>  =20
> +        if (bdrv_is_child_of(to_replace_bs, target, 1)) {
> +            error_setg(errp, "Replacing %s by %s would result in a loop,=
 "
> +                       "because the former is a child of the latter",
> +                       to_replace_bs->node_name, target->node_name);
> +            return;
> +        }
> +
> +        if (backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN ||
> +            backing_mode =3D=3D MIRROR_OPEN_BACKING_CHAIN)
> +        {
> +            /*
> +             * While we do not quite know what OPEN_BACKING_CHAIN
> +             * (used for mode=3Dexisting) will yield, it is probably
> +             * best to restrict it exactly like SOURCE_BACKING_CHAIN,
> +             * because that is our best guess.
> +             */
> +            switch (sync) {
> +            case MIRROR_SYNC_MODE_FULL:
> +                target_backing_bs =3D NULL;
> +                break;
> +
> +            case MIRROR_SYNC_MODE_TOP:
> +                target_backing_bs =3D backing_bs(bs);
> +                break;
> +
> +            case MIRROR_SYNC_MODE_NONE:
> +                target_backing_bs =3D bs;
> +                break;
> +
> +            default:
> +                abort();
> +            }
> +        } else {
> +            assert(backing_mode =3D=3D MIRROR_LEAVE_BACKING_CHAIN);
> +            target_backing_bs =3D backing_bs(target);
> +        }
> +
> +        if (bdrv_is_child_of(to_replace_bs, target_backing_bs, 0)) {
> +            error_setg(errp, "Replacing '%s' by '%s' with this sync mode=
 would "
> +                       "result in a loop, because the former would be a =
child "
> +                       "of the latter's backing file ('%s') after the mi=
rror "
> +                       "job", to_replace_bs->node_name, target->node_nam=
e,
> +                       target_backing_bs->node_name);
> +            return;
> +        }
> +
>           replace_aio_context =3D bdrv_get_aio_context(to_replace_bs);
>           aio_context_acquire(replace_aio_context);
>           replace_size =3D bdrv_getlength(to_replace_bs);
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 589a797fab..7064a1a4fa 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1266,6 +1266,9 @@ void bdrv_format_default_perms(BlockDriverState *bs=
, BdrvChild *c,
>   bool bdrv_recurse_can_replace(BlockDriverState *bs,
>                                 BlockDriverState *to_replace);
>  =20
> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *parent,
> +                      int min_level);
> +
>   /*
>    * Default implementation for drivers to pass bdrv_co_block_status() to
>    * their file.
>=20


--=20
Best regards,
Vladimir

