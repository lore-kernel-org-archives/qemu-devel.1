Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68253C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A2B20679
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A2B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40516 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQwv-0008LC-EF
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57706)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbQ9o-0003Nf-KL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbQ9i-0004uU-UU
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:52:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbQ9H-0004be-2i; Thu, 13 Jun 2019 09:52:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2BED63082126;
 Thu, 13 Jun 2019 13:52:04 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EF2119C67;
 Thu, 13 Jun 2019 13:51:56 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-4-vsementsov@virtuozzo.com>
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
Message-ID: <f98f4baf-941c-120c-5bb3-b857c175003e@redhat.com>
Date: Thu, 13 Jun 2019 15:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529154654.95870-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QtqnhJuSN7hb5Cqm8jlpcHGHiyPEVrZuf"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 13 Jun 2019 13:52:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 3/7] block: allow not one child for
 implicit node
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QtqnhJuSN7hb5Cqm8jlpcHGHiyPEVrZuf
Content-Type: multipart/mixed; boundary="ehVlzWM7BC7ogOPN5zUdn3FqB3qtkspO1";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com
Message-ID: <f98f4baf-941c-120c-5bb3-b857c175003e@redhat.com>
Subject: Re: [PATCH v8 3/7] block: allow not one child for implicit node
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190529154654.95870-4-vsementsov@virtuozzo.com>

--ehVlzWM7BC7ogOPN5zUdn3FqB3qtkspO1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.05.19 17:46, Vladimir Sementsov-Ogievskiy wrote:
> Upcoming backup-top filter wants to operate like usual implicit filter
> node with fall-through to backing child. But also needs additional
> target child, let's support that.
>=20
> On the other hand, after backup completion (before job dismiss) filter
> is still attached to job blk, but don't have any children. Support this=

> too.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 57216f4115..3f4de3ae32 100644
> --- a/block.c
> +++ b/block.c
> @@ -6200,9 +6200,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)=

>      }
> =20
>      if (bs->implicit) {
> -        /* For implicit nodes, just copy everything from the single ch=
ild */
> +        /*
> +         * For implicit nodes, just copy everything from the single ch=
ild or
> +         * from backing, if there are several children.
> +         * If there are no children for some reason (filter is still a=
ttached
> +         * to block-job blk, but already removed from backing chain of=
 device)
> +         * do nothing.
> +         */
>          child =3D QLIST_FIRST(&bs->children);
> -        assert(QLIST_NEXT(child, next) =3D=3D NULL);
> +        if (!child) {
> +            return;
> +        } else if (QLIST_NEXT(child, next)) {
> +            assert(bs->backing);
> +            child =3D bs->backing;
> +        }
> =20
>          pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
>                  child->bs->exact_filename);

Reviewed-by: Max Reitz <mreitz@redhat.com>

(To be changed to bdrv_filtered_rw_bs(), of course)


--ehVlzWM7BC7ogOPN5zUdn3FqB3qtkspO1--

--QtqnhJuSN7hb5Cqm8jlpcHGHiyPEVrZuf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0CVPoACgkQ9AfbAGHV
z0C+KQgAhx8URyW+l2AWbk1qaInQw0i7R57ZQlYlZc4RPrnI1a1jCKfAOQDzbiBR
cel/qaYB+rWjUEjO2kZtjd8j+I9hrNmtMnCkWTMd+E1k1DoyToPDaZhsz6woS4WM
Mw9uL5T1NHoDBbYE2nI5+Gi6ismA5TqTnganf92DGZsSzGTOCsEUeQ36wPbo3TJa
wUvGk0VlJyoKiMtWxUm69e77YK0S9yh5gV3L576BAb/8m3BhCUOcrDLwSlmYAwuM
c5a+ko06NgfU+0A3PoKCogOrEaZMQmhNfpzR929/8VUtpjheigm58fcAf/Mp1Hek
hB98JltjPU3h3TMmliUoqd2g6zrytw==
=Z2do
-----END PGP SIGNATURE-----

--QtqnhJuSN7hb5Cqm8jlpcHGHiyPEVrZuf--

