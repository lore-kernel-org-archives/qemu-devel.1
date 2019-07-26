Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8BEC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B767F2171F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B767F2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwuq-0000CU-HR
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33454)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqwuX-0008BH-6f
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqwuS-00007M-SS
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:53:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqwuL-0007uW-Qj; Fri, 26 Jul 2019 05:53:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6AE343082D6C;
 Fri, 26 Jul 2019 09:52:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-164.ams2.redhat.com
 [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B23260C5F;
 Fri, 26 Jul 2019 09:52:54 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190725162704.12622-1-kwolf@redhat.com>
 <20190725162704.12622-4-kwolf@redhat.com>
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
Message-ID: <d6466e56-b57b-7cf7-1a39-8cd38db14ede@redhat.com>
Date: Fri, 26 Jul 2019 11:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725162704.12622-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zQh4FZi6vHr42oTttiCpc9B4BmZr8WjSD"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 26 Jul 2019 09:52:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] mirror: Keep target drained until
 graph changes are done
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
Cc: dplotnikov@virtuozzo.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zQh4FZi6vHr42oTttiCpc9B4BmZr8WjSD
Content-Type: multipart/mixed; boundary="8SHO8knjZddpNVpcQxgsO5NwgwxeYhGaU";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: dplotnikov@virtuozzo.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-devel@nongnu.org
Message-ID: <d6466e56-b57b-7cf7-1a39-8cd38db14ede@redhat.com>
Subject: Re: [PATCH 3/4] mirror: Keep target drained until graph changes are
 done
References: <20190725162704.12622-1-kwolf@redhat.com>
 <20190725162704.12622-4-kwolf@redhat.com>
In-Reply-To: <20190725162704.12622-4-kwolf@redhat.com>

--8SHO8knjZddpNVpcQxgsO5NwgwxeYhGaU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.07.19 18:27, Kevin Wolf wrote:
> Calling bdrv_drained_end() for target_bs can restarts requests too
> early, so that they would execute on mirror_top_bs, which however has
> already dropped all permissions.
>=20
> Keep the target node drained until all graph changes have completed.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 8cb75fb409..7483051f8d 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -644,6 +644,11 @@ static int mirror_exit_common(Job *job)
>      bdrv_ref(mirror_top_bs);
>      bdrv_ref(target_bs);
> =20
> +    /* The mirror job has no requests in flight any more, but we need =
to
> +     * drain potential other users of the BDS before changing the grap=
h. */
> +    assert(s->in_drain);
> +    bdrv_drained_begin(target_bs);
> +

In contrast to what Eric said, I think it is a problem that this is just
code motion.

The comment doesn=E2=80=99t tell the reason why the target needs to be dr=
ained
here.  Other users of the BDS have their own BdrvChild and thus their
own permissions, their requests do not go through mirror.

So in addition to why the target needs to be drained around
bdrv_replace_node(), the comment should tell why we need to drain it
here, like the commit message does.

Now, the thing is, I don=E2=80=99t quite understand the connection betwee=
n the
target and mirror_top_bs that the commit message wants to establish.

I see the following problem:
(1) We drain src (at the end of mirror_run()).
(2) This implicitly drains mirror_top_bs.
(3) We drain target.
(4) bdrv_replace_node() replaces src by target, thus replacing the drain
    on mirror_top_bs from src by the one from target.
(5) We undrain target, thus also undraining mirror_top_bs.
(6) After all is done, we undrain src, which has no effect on
    mirror_top_bs, because they haven=E2=80=99t been connected since (4).=


I suppose (5) is the problem.  This patch moves it down to (6), so
mirror_top_bs is drained as long as src is drained.

(If to_replace is not src, then src will stay attached, which keeps
mirror_top_bs drained, too.)

This makes it seem to me like the actually important thing is to drain
mirror_top_bs, not target.  If so, it would seem more obvious to me to
just add a drain on mirror_top_bs than to move the existing target drain.=


>      /* Remove target parent that still uses BLK_PERM_WRITE/RESIZE befo=
re
>       * inserting target_bs at s->to_replace, where we might not be abl=
e to get
>       * these permissions.
> @@ -684,12 +689,7 @@ static int mirror_exit_common(Job *job)
>              bdrv_reopen_set_read_only(target_bs, ro, NULL);
>          }
> =20
> -        /* The mirror job has no requests in flight any more, but we n=
eed to
> -         * drain potential other users of the BDS before changing the =
graph. */
> -        assert(s->in_drain);
> -        bdrv_drained_begin(target_bs);

By the way, don=E2=80=99t we need to drain to_replace also?  In case it i=
sn=E2=80=99t src?

Max

>          bdrv_replace_node(to_replace, target_bs, &local_err);
> -        bdrv_drained_end(target_bs);
>          if (local_err) {
>              error_report_err(local_err);
>              ret =3D -EPERM;
> @@ -704,7 +704,6 @@ static int mirror_exit_common(Job *job)
>          aio_context_release(replace_aio_context);
>      }
>      g_free(s->replaces);
> -    bdrv_unref(target_bs);
> =20
>      /*
>       * Remove the mirror filter driver from the graph. Before this, ge=
t rid of
> @@ -724,9 +723,12 @@ static int mirror_exit_common(Job *job)
>      bs_opaque->job =3D NULL;
> =20
>      bdrv_drained_end(src);
> +    bdrv_drained_end(target_bs);
> +
>      s->in_drain =3D false;
>      bdrv_unref(mirror_top_bs);
>      bdrv_unref(src);
> +    bdrv_unref(target_bs);
> =20
>      return ret;
>  }
>=20



--8SHO8knjZddpNVpcQxgsO5NwgwxeYhGaU--

--zQh4FZi6vHr42oTttiCpc9B4BmZr8WjSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl06zXUACgkQ9AfbAGHV
z0AYWQgAmQtPG4ugyqHMAIPqRWkPQlGhn8HPD/nGSPaJR8pvWdlP6Q6RmNO+U0+y
pCWcaV91SvKfJVQXD2xA6iDmmiZKc2eiyqvuiCMpbTAD7kmFsRVrOr5Hfgkg6XbI
3nl1hDmRfO5Np3WuGP3JI0bM1k0MB0vGfntnyiB1TeHpvFVy1yXISYBV60BPGIhW
9nqW5ITN/KU1mAP824ICXBiqgxuTTl2edkLp5A3mUEqn2+JbbomaVkAto105KvAy
tT5kmRpspo0xngNL8Y5wWevh44o7BiODoWAOHANfoHLnoYB/toiUf2SLVrqDFpk3
1whFlbYGd1TRGEosi8sPCPGJ18Vg0g==
=R3zK
-----END PGP SIGNATURE-----

--zQh4FZi6vHr42oTttiCpc9B4BmZr8WjSD--

