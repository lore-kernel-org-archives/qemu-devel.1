Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D0FC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4038820715
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vYFrhWzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4038820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibkZw-00074v-Cg
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 07:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ibkZ5-0006Z2-Hk
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ibkZ3-0004oz-Mn
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:12:31 -0500
Received: from mail-eopbgr50114.outbound.protection.outlook.com
 ([40.107.5.114]:2623 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ibkZ3-0004oC-0m; Mon, 02 Dec 2019 07:12:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7cfLSOzF5CffjUa0ILFCGrNx2jfPxIvX2jNUvwMX71viTku5SICLjsOU9SHSu5Y0ugtssTsvhHKgRz1yzYvJ7x7YvTAk6O+KIIUmP4x90RHy/d8uykFmmCJ5baIX+YRAEx20akWJ3RMR+y4GsllqVUspcP8aAEtJLbsHXWMKyW2OadzIgT0xKx3ty3aSfGnAfiU+QzKvm7c7oVaGK8PWpuP2gK3K5qtL3jOXlvUQ4Jmh+Vak4/hnnE94tROiW0KPTDWo78G6ds2b8QIOwh/fgY2StbA7JCdFHrmu+nItZVuF8ZH6BS+Np/e17pVQ1oVdFGBJO4Qy6LWVhn0JHCW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o43CgkJCpsBFQrMqcNeJ/CqwSySVDJL015wh+3IiG10=;
 b=f4JHibsSISLskJJdhxoBdTGm5b/cXLCY8CnHx5SCAehuI4iHDWBNDIbPZYlDKAX7oD2js0y+P9uHiLMI/GyIqV5azK9WBQbK5uGFyMaO+hvan+Ojd0ZDUKmX1SPo9tVvk+OKWIXE5LiIMUkOZLj1GF4D/dJN2tFgRTuNMLqF/2LvFefkGNKeau5sofXs7JMdYs5QnWTfNCHXjt8gsJ+AoAlvbLatAT1PO0ciYY59s5fpwgbB2+tCtkW7zUNnf3by5CLJuC2OTddDnCpWA9zrtyNkdkbaONzg7ubAnvJfy4irJLtIS2i/t3ibmAdjRvuJb3XC9NZgHjTzeRNhz+4EFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o43CgkJCpsBFQrMqcNeJ/CqwSySVDJL015wh+3IiG10=;
 b=vYFrhWzFhwx5POq04MWJorWK4Rlf/rvqi+M6IIZ0OvTHYsgycrzbu4j/W0vkICVg7Mc38Y+HJNiwu0w72mCtRDPCjRESbxG4xSk6PvQoC7iA1u8QM2ulmm65iGppiCidOT5b1Q0Oqw7jOJhRssE7BayrEDKg9uMLZAtptRQsyFg=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4626.eurprd08.prod.outlook.com (10.255.96.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Mon, 2 Dec 2019 12:12:24 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 12:12:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Thread-Topic: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Thread-Index: AQHVmKmF9vX+IDkOrkmVWASxqmj2taem4i0A
Date: Mon, 2 Dec 2019 12:12:24 +0000
Message-ID: <7f50c050-38ca-a7f2-361b-a08e82b420af@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-16-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-16-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0050.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::39) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191202151222625
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9420302-f674-47bf-768a-08d77720e3dd
x-ms-traffictypediagnostic: AM6PR08MB4626:
x-microsoft-antispam-prvs: <AM6PR08MB4626BFE38354E903CD999578C1430@AM6PR08MB4626.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(8936002)(6246003)(6512007)(81166006)(86362001)(8676002)(81156014)(186003)(446003)(66066001)(11346002)(76176011)(52116002)(71200400001)(31686004)(478600001)(14454004)(4326008)(26005)(102836004)(386003)(6506007)(2501003)(110136005)(6436002)(2906002)(229853002)(6486002)(54906003)(7736002)(256004)(25786009)(71190400001)(2616005)(66556008)(66946007)(66446008)(64756008)(66476007)(305945005)(316002)(6116002)(5660300002)(3846002)(99286004)(36756003)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4626;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzQx1KK4neoulnGnjy4F0+g6zL18UducALL8981SN6xsAOBbIZ/Od5+FwDIn0z3XVSI5m2Awh7ea0s6wwsxpoZJezyADhlWm+E0TTR42SkNvV874mqEqdTaD/CtEhgEMPvu7l1NgHrsrdyYa/GbF1hqgigOvCupfjjBa6+xMD6nYtSxURt6byua08Ca87lHlsfn1lh7WS6T61KremT4kc1djZBOznlH07X5wtK0ohJitWXYDtxgjz1kXm8UGtxnphoZHq5Fku/I73m+eROn9qvmcbMV7xuRozziheBrOgoG1IqLzqHqxWST54G+t5ltwrrrccYARrQDLSkVwjIgWTppnLiyh8L6DvzWJPPVYAPesjeckxJsKCMXhu6BNmvceirsL8GG2q1/FP62jZyUK3sRpODE6Pa30N7PiUKmFBwwJBQXYn+F/b6wCyvqTUj83
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E84B068539A2494EAF22D02E040749A5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9420302-f674-47bf-768a-08d77720e3dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 12:12:24.3484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wTRJx8m8v6kajtnPHzGGxyw24GKCKMEOAS0HuS51SRA2SquK0YSQHhvFIh18zBuayUTOXDBtKpyaWHGXJ9ZxHSkMAjcq09rcv26EQbw1iU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4626
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.114
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

you may swap if and else branch, dropping "!" mark..

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

here min_level=3D1, so we don't handle the case, described in mirror_exit_c=
ommon..
I don't see why.. blockdev_mirror_common is called from qmp_drive_mirror,
including the case with MIRROR_SYNC_MODE_NONE and NEW_IMAGE_MODE_ABSOLUTE_P=
ATHS..

What I'm missing?

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

hmm.. so for MODE_NONE we disallow to_replace =3D=3D src?

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

