Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5D0C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46A32084D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J7NBbyYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46A32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadln-0008B4-2S
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iadMI-0007yH-7U
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iadMD-0000rd-Lf
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:18:38 -0500
Received: from mail-eopbgr00095.outbound.protection.outlook.com
 ([40.107.0.95]:20709 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iadMC-0000bb-RB; Fri, 29 Nov 2019 05:18:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIVYwyroQodG1EimH0A/mr/JcGX4v5zq8/mJ4PAKebvgcPyQR0hK5RIwQEOUUXCbSs4lq3aTVityYTDqhCfsHEdwthUD1bfDjEjNR+LpAF31jdoTNzB3xOXwo4En2LjWlYaQtN7JW9h+Ta7IY7VZi21ubBHq46pQJdTQz+mZQoi3AoVd25qljCQwTjqXog62vSMQrlka+bgW8O5qB8/f7+ie8bxbCHJN5DkHVApgrJol3VF/+2jK8NepHaebepyBPKfaU8CmcPfo2IBLY2tBHwHvFPfMLHLtGY5o2RuxWyACk1DmyrC2HtqawLZo0laZcwa8LmQL5wO2PPnQDHNSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiqVrS8OdraGcR1bcEt/OjPd6bKCziR+PGkdCZIGZcA=;
 b=Gb5tpq080Z5jamhvxKl7fBOdW9dHjacmqyYKwfHQFQgBFupBmpQwjbh//E9vRiaqdr1jFUntihvCgGcDQWXBHTZqDmwRECSgnmbkZYW60vnFyZdl4g69epMRvUPH+QpGXfFa7NteJsa/Rj0gTdc9Tg5mEdpLB1/+0dWO51YaJMWVLm66ZEl1xLIH5H3LpyskC5kw29BW1ExrIWlX58gd3EFow6tCTXT6LPAZBCLCp6IA/sZl+uCQsuoCz95mQ+/FJtg6BMCvvyFawOJaWtxpRLSix2wlEzpdesY+OaXyIwdRQB0CdALU6YivRRFIzKKBz63i4A4aoE5Af2ey1ZFPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiqVrS8OdraGcR1bcEt/OjPd6bKCziR+PGkdCZIGZcA=;
 b=J7NBbyYyj6B5ZFdJ4dWcyC8FgqYRCeAZWrVRQoJQTwJ2/+wqwJWUCgOk6wFDnvIZDTnMtgZYLtS3QpguLJNMwm7XNGU1pB499GLVZYOW4S5+j1bkDXV1fv0OmkylXbi+X8l2oEJ/4Y3WAK/a/PfkqCwNcn2WTKyOz/Iuxdp2Epw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3656.eurprd08.prod.outlook.com (20.177.116.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Fri, 29 Nov 2019 10:18:31 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 10:18:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 10/23] quorum: Implement
 .bdrv_recurse_can_replace()
Thread-Topic: [PATCH for-5.0 v2 10/23] quorum: Implement
 .bdrv_recurse_can_replace()
Thread-Index: AQHVmKl724VRars9BkWhmWsgSuFOoaeiC12A
Date: Fri, 29 Nov 2019 10:18:31 +0000
Message-ID: <e3424764-3205-2170-ee00-1d76bfea6df2@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-11-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-11-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0077.eurprd07.prod.outlook.com
 (2603:10a6:3:64::21) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129131829064
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5d89162-891f-48ad-372e-08d774b57bb1
x-ms-traffictypediagnostic: AM6PR08MB3656:
x-microsoft-antispam-prvs: <AM6PR08MB3656044030C92F278D0A051AC1460@AM6PR08MB3656.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(36756003)(11346002)(99286004)(446003)(305945005)(5660300002)(7736002)(2616005)(66066001)(316002)(54906003)(66476007)(66556008)(64756008)(66446008)(66946007)(31686004)(71190400001)(71200400001)(478600001)(229853002)(110136005)(2906002)(31696002)(8676002)(81156014)(81166006)(86362001)(8936002)(14454004)(3846002)(25786009)(4326008)(6116002)(52116002)(256004)(6246003)(186003)(76176011)(6506007)(26005)(102836004)(6512007)(6436002)(6486002)(2501003)(386003)(142923001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3656;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qe8I9uFSTbBOYgTEdOlfD4a43n0jgJWh3Ru7te2saFRx1VHqCupHCCVuIzYXqSsw6wkfb1T42pdS6E+HXH+JgWi8rjpu4RqucQrypYPwba71Sb/M5gc0J47TBIGIYcMpkn3i0PGA7Bz9hdEXB8wwxpN0Irae7JqcjH8CWPO4rfVBwRl7u6gWb9wi1al5Rt2RoVjTkhXaCuDUunyo+MMPt6N4K4glMisAvATGaGxQmg1uRS4SIDPU0Thh8KhCRfa1u1wW72YBx7nsHtMepUMHzJf4EBuZkjEZckW0Jgdtq0f+4rOqg+Od1BDduxPd2D9wpKb2Kh86CC7aloM0o/VmwKlxE6CfLhhyVhA+LUAUhP/Bcacun8siJnM8ASKu02iEsqCeLo4U7gcKWWrYu3gu8G8tf411fy6OemBD2I7GxK2u1SqTsIMlFI0ZizpHoq7K
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9E1069D1370E5F4B89012C866DD80362@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d89162-891f-48ad-372e-08d774b57bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 10:18:31.0937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIwqamRigDq8jzDfLUvtyMBE9VE70zwolAWDKZQ2JNRXOi+iEbhZunh5SUzvhkXkg+HQZVvR7Vr9DqJDIm3EaUQLBoflkxDtxABDxrnxEm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3656
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.95
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
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/quorum.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
>=20
> diff --git a/block/quorum.c b/block/quorum.c
> index 3a824e77e3..8ee03e9baf 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -825,6 +825,67 @@ static bool quorum_recurse_is_first_non_filter(Block=
DriverState *bs,
>       return false;
>   }
>  =20
> +static bool quorum_recurse_can_replace(BlockDriverState *bs,
> +                                       BlockDriverState *to_replace)
> +{
> +    BDRVQuorumState *s =3D bs->opaque;
> +    int i;
> +
> +    for (i =3D 0; i < s->num_children; i++) {
> +        /*
> +         * We have no idea whether our children show the same data as
> +         * this node (@bs).  It is actually highly likely that
> +         * @to_replace does not, because replacing a broken child is
> +         * one of the main use cases here.
> +         *
> +         * We do know that the new BDS will match @bs, so replacing
> +         * any of our children by it will be safe.  It cannot change
> +         * the data this quorum node presents to its parents.
> +         *
> +         * However, replacing @to_replace by @bs in any of our
> +         * children's chains may change visible data somewhere in
> +         * there.  We therefore cannot recurse down those chains with
> +         * bdrv_recurse_can_replace().
> +         * (More formally, bdrv_recurse_can_replace() requires that
> +         * @to_replace will be replaced by something matching the @bs
> +         * passed to it.  We cannot guarantee that.)
> +         *
> +         * Thus, we can only check whether any of our immediate
> +         * children matches @to_replace.
> +         *
> +         * (In the future, we might add a function to recurse down a
> +         * chain that checks that nothing there cares about a change
> +         * in data from the respective child in question.  For
> +         * example, most filters do not care when their child's data
> +         * suddenly changes, as long as their parents do not care.)
> +         */
> +        if (s->children[i].child->bs =3D=3D to_replace) {
> +            Error *local_err =3D NULL;

bdrv_child_refresh_perms returns int, so I suggest instead:


bool ok;

> +
> +            /*
> +             * We now have to ensure that there is no other parent
> +             * that cares about replacing this child by a node with
> +             * potentially different data.
> +             */
> +            s->children[i].to_be_replaced =3D true;
> +            bdrv_child_refresh_perms(bs, s->children[i].child, &local_er=
r);

ok =3D !bdrv_child_refresh_perms(bs, s->children[i].child, NULL);

> +
> +            /* Revert permissions */
> +            s->children[i].to_be_replaced =3D false;
> +            bdrv_child_refresh_perms(bs, s->children[i].child, &error_ab=
ort);

return ok;

Or similar with // int ret; // ret =3D // return !ret; //

> +
> +            if (local_err) {
> +                error_free(local_err);
> +                return false;
> +            }
> +
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>   static int quorum_valid_threshold(int threshold, int num_children, Erro=
r **errp)
>   {
>  =20
> @@ -1195,6 +1256,7 @@ static BlockDriver bdrv_quorum =3D {
>  =20
>       .is_filter                          =3D true,
>       .bdrv_recurse_is_first_non_filter   =3D quorum_recurse_is_first_non=
_filter,
> +    .bdrv_recurse_can_replace           =3D quorum_recurse_can_replace,
>  =20
>       .strong_runtime_opts                =3D quorum_strong_runtime_opts,
>   };
>=20

with or without my suggestion:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir

