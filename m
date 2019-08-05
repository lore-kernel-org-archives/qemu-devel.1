Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F073C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8004206A2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8004206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hubYk-0000KJ-69
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 07:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38209)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hubY7-0008Gp-KH
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hubY5-0001JE-Oq
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:53:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41416)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hubXz-0001Dj-6w; Mon, 05 Aug 2019 07:53:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7144D3082132;
 Mon,  5 Aug 2019 11:53:02 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4F6060F8C;
 Mon,  5 Aug 2019 11:52:58 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190805114923.23701-1-mreitz@redhat.com>
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
Message-ID: <b2b73872-9412-8752-a7c4-8c2dd1c7bc4c@redhat.com>
Date: Mon, 5 Aug 2019 13:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805114923.23701-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HtO3eGviu7wjxFnYCJE7MyjHctlTujIHc"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 05 Aug 2019 11:53:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] mirror: Only mirror granularity-aligned
 chunks
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HtO3eGviu7wjxFnYCJE7MyjHctlTujIHc
Content-Type: multipart/mixed; boundary="6hLWo0KeInaC5z9H05JQIn0WbPLlGTdcs";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b2b73872-9412-8752-a7c4-8c2dd1c7bc4c@redhat.com>
Subject: Re: [PATCH] mirror: Only mirror granularity-aligned chunks
References: <20190805114923.23701-1-mreitz@redhat.com>
In-Reply-To: <20190805114923.23701-1-mreitz@redhat.com>

--6hLWo0KeInaC5z9H05JQIn0WbPLlGTdcs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.08.19 13:49, Max Reitz wrote:
> In write-blocking mode, all writes to the top node directly go to the
> target.  We must only mirror chunks of data that are aligned to the
> job's granularity, because that is how the dirty bitmap works.
> Therefore, the request alignment for writes must be the job's
> granularity (in write-blocking mode).
>=20
> Unfortunately, this forces all reads and writes to have the same
> granularity (we only need this alignment for writes to the target, not
> the source), but that is something to be fixed another time.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> This is an alternative to Vladimir's "util/hbitmap: fix unaligned reset=
"
> patch.  I don't mind much either way, both of pros and cons.  Comparing=


I don=E2=80=99t know why I can=E2=80=99t write (especially lately).  s/of=
/have/, of course.

Max

> this patch to Vladimir's:
>=20
> + Makes copy-mode=3Dwrite-blocking really work (unless I'm mistaken)
> - Lowers performance with copy-mode=3Dwrite-blocking unnecessarily
> ---
>  block/mirror.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 8cb75fb409..3f9c5a178a 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1481,6 +1481,15 @@ static void bdrv_mirror_top_child_perm(BlockDriv=
erState *bs, BdrvChild *c,
>      *nshared =3D BLK_PERM_ALL;
>  }
> =20
> +static void bdrv_mirror_top_refresh_limits(BlockDriverState *bs, Error=
 **errp)
> +{
> +    MirrorBDSOpaque *s =3D bs->opaque;
> +
> +    if (s && s->job && s->job->copy_mode =3D=3D MIRROR_COPY_MODE_WRITE=
_BLOCKING) {
> +        bs->bl.request_alignment =3D s->job->granularity;
> +    }
> +}
> +
>  /* Dummy node that provides consistent read to its users without requi=
ring it
>   * from its backing file and that allows writes on the backing file ch=
ain. */
>  static BlockDriver bdrv_mirror_top =3D {
> @@ -1493,6 +1502,7 @@ static BlockDriver bdrv_mirror_top =3D {
>      .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,=

>      .bdrv_refresh_filename      =3D bdrv_mirror_top_refresh_filename,
>      .bdrv_child_perm            =3D bdrv_mirror_top_child_perm,
> +    .bdrv_refresh_limits        =3D bdrv_mirror_top_refresh_limits,
>  };
> =20
>  static BlockJob *mirror_start_job(
> @@ -1678,6 +1688,8 @@ static BlockJob *mirror_start_job(
> =20
>      QTAILQ_INIT(&s->ops_in_flight);
> =20
> +    bdrv_refresh_limits(mirror_top_bs, &error_abort);
> +
>      trace_mirror_start(bs, s, opaque);
>      job_start(&s->common.job);
> =20
>=20



--6hLWo0KeInaC5z9H05JQIn0WbPLlGTdcs--

--HtO3eGviu7wjxFnYCJE7MyjHctlTujIHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1IGJkACgkQ9AfbAGHV
z0AbDQf9FwMXzYysP8ScNtCVxXctyQwKoZHzIHMIWd88EDGrfRzUJnkE/43qJnr0
jNXg+gsSB9TgTevp2Y3QEaQ2Dym1KLeoDrKqFVihGo7rUWsadHOfuJF6xdY5hQWS
rnFvo1v6fG3fGSbABw6NGnAhaqgD6qyU6i6NpbuZs1oAKWVv0J4Yip4whF2qodp3
ZQJ6IMFtCCyj4Wes4EoEJyn9OlFZltmgcKlBs7BoKzzP9fMD3ca/dx1s9GkoVt5/
64MjAbKveZkrBnMvlVR9vqsMrJLKoAnHMbL0FqqJflv8EmR6GPD0OmNTROq32x/r
zjd4W4ZFqXgAzXklmivWNiyzYuIoAQ==
=896s
-----END PGP SIGNATURE-----

--HtO3eGviu7wjxFnYCJE7MyjHctlTujIHc--

