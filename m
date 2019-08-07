Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A7C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 21:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92152186A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 21:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92152186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvTT3-0000XX-0r
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 17:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41599)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hvTSd-0008Vb-6y
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 17:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hvTSc-000803-71
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 17:27:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hvTSa-0007xw-1a; Wed, 07 Aug 2019 17:27:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E4E34C034DF3;
 Wed,  7 Aug 2019 21:27:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-24.brq.redhat.com
 [10.40.204.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5E4360852;
 Wed,  7 Aug 2019 21:27:00 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190807144628.4988-1-kwolf@redhat.com>
 <20190807144628.4988-3-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <b5fc43d9-6a67-38e9-d24a-93d5646fdf6d@redhat.com>
Date: Wed, 7 Aug 2019 23:26:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807144628.4988-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aixYN0erR78p5ebHFSGeJ4EKRy7QKbg8m"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 07 Aug 2019 21:27:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/3] mirror: Keep mirror_top_bs drained
 after dropping permissions
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
Cc: qemu-devel@nongnu.org, dplotnikov@virtuozzo.com, vsementsov@virtuozzo.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aixYN0erR78p5ebHFSGeJ4EKRy7QKbg8m
Content-Type: multipart/mixed; boundary="X8KNy67oDeSdpoJvIycMQovcW193laVQz";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, dplotnikov@virtuozzo.com, vsementsov@virtuozzo.com,
 den@virtuozzo.com, qemu-devel@nongnu.org
Message-ID: <b5fc43d9-6a67-38e9-d24a-93d5646fdf6d@redhat.com>
Subject: Re: [PATCH v2 2/3] mirror: Keep mirror_top_bs drained after dropping
 permissions
References: <20190807144628.4988-1-kwolf@redhat.com>
 <20190807144628.4988-3-kwolf@redhat.com>
In-Reply-To: <20190807144628.4988-3-kwolf@redhat.com>

--X8KNy67oDeSdpoJvIycMQovcW193laVQz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.08.19 16:46, Kevin Wolf wrote:
> mirror_top_bs is currently implicitly drained through its connection to=

> the source or the target node. However, the drain section for target_bs=

> ends early after moving mirror_top_bs from src to target_bs, so that
> requests can already be restarted while mirror_top_bs is still present
> in the chain, but has dropped all permissions and therefore runs into a=
n
> assertion failure like this:
>=20
>     qemu-system-x86_64: block/io.c:1634: bdrv_co_write_req_prepare:
>     Assertion `child->perm & BLK_PERM_WRITE' failed.
>=20
> Keep mirror_top_bs drained until all graph changes have completed.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 9f5c59ece1..642d6570cc 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -656,7 +656,10 @@ static int mirror_exit_common(Job *job)
>      s->target =3D NULL;
> =20
>      /* We don't access the source any more. Dropping any WRITE/RESIZE =
is
> -     * required before it could become a backing file of target_bs. */=

> +     * required before it could become a backing file of target_bs. No=
t having
> +     * these permissions any more means that we can't allow any new re=
quests on
> +     * mirror_top_bs from now on, so keep it drained. */

You=E2=80=99re lucky Patchew broke or it would have complained about mult=
i-line
comments needing /* and */ on separate lines. :-)

I=E2=80=99m perfectly happy with this style, though:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +    bdrv_drained_begin(mirror_top_bs);
>      bs_opaque->stop =3D true;
>      bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
>                               &error_abort);
> @@ -724,6 +727,7 @@ static int mirror_exit_common(Job *job)
>      bs_opaque->job =3D NULL;
> =20
>      bdrv_drained_end(src);
> +    bdrv_drained_end(mirror_top_bs);
>      s->in_drain =3D false;
>      bdrv_unref(mirror_top_bs);
>      bdrv_unref(src);
>=20



--X8KNy67oDeSdpoJvIycMQovcW193laVQz--

--aixYN0erR78p5ebHFSGeJ4EKRy7QKbg8m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1LQiMACgkQ9AfbAGHV
z0BH2AgAqB2X647c90rL/EenZNxb7XNzJT/d/MBnTJpbaFfYMo11sMSCfPIH6Chj
l/wVX0vxvUN6e4emefuC3f1FSZJD7DUhWfUkunq4xJj6U0ybGIlYse9c/oyU9eKX
GNA6yVFxjRDKlOG3vBasdbhlHCapWRR27anJXvhhP7eCMuOEY13n5tMFkNIZr4vC
r53ZyWaHOUDpzbjCRouGscm1FKr3EQykzakRpTiNvrH7u+kv7GdVRzMtnUpQvFLB
b7gHW3yrv/Rpzj4ELhZMDkmRjnsoNY7LMzIgFAo+WiV8L5+kScck3UnwVphcXJMw
9lXNezWNFr8d1D8cKj19lGhmfOZZpQ==
=XT3P
-----END PGP SIGNATURE-----

--aixYN0erR78p5ebHFSGeJ4EKRy7QKbg8m--

