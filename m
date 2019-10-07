Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF6EECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6281D206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6281D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTqb-00086U-HT
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 10:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iHTpa-0007GW-DZ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iHTpZ-0005LH-19
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:17:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15239)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iHTpU-0005Jq-Uj; Mon, 07 Oct 2019 10:17:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D10A5307D934;
 Mon,  7 Oct 2019 14:17:39 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B825E5EE1D;
 Mon,  7 Oct 2019 14:17:35 +0000 (UTC)
Subject: Re: [PATCH 3/6] block/block-copy: refactor copying
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191003171539.12327-1-vsementsov@virtuozzo.com>
 <20191003171539.12327-4-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <dacae11a-0da6-d08e-05a7-d605466a5743@redhat.com>
Date: Mon, 7 Oct 2019 16:17:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003171539.12327-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Y0hkN06j3Lvxs8jKc9qz1uf6YUCA7d4wP"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 07 Oct 2019 14:17:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y0hkN06j3Lvxs8jKc9qz1uf6YUCA7d4wP
Content-Type: multipart/mixed; boundary="grq8MN6miZ9EYQ8W7Jhwjsp4IKVobnKnC"

--grq8MN6miZ9EYQ8W7Jhwjsp4IKVobnKnC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.10.19 19:15, Vladimir Sementsov-Ogievskiy wrote:
> Merge copying code into one function block_copy_do_copy, which only
> calls bdrv_ io functions and don't do any synchronization (like dirty
> bitmap set/reset).
>=20
> Refactor block_copy() function so that it takes full decision about
> size of chunk to be copied and does all the synchronization (checking
> intersecting requests, set/reset dirty bitmaps).
>=20
> It will help:
>  - introduce parallel processing of block_copy iterations: we need to
>    calculate chunk size, start async chunk copying and go to the next
>    iteration
>  - simplify synchronization improvement (like memory limiting in
>    further commit and reducing critical section (now we lock the whole
>    requested range, when actually we need to lock only dirty region
>    which we handle at the moment))
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/block-copy.c | 113 ++++++++++++++++++++-------------------------=

>  block/trace-events |   6 +--
>  2 files changed, 53 insertions(+), 66 deletions(-)

Looks good to me, just some clean-up path nit picks below.

> diff --git a/block/block-copy.c b/block/block-copy.c
> index 75287ce24d..cc49d2345d 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -126,25 +126,43 @@ void block_copy_set_callbacks(
>  }
> =20
>  /*
> - * Copy range to target with a bounce buffer and return the bytes copi=
ed. If
> - * error occurred, return a negative error number
> + * block_copy_do_copy
> + *
> + * Do copy of cluser-aligned chunk. @end is allowed to exceed s->len o=
nly to
> + * cover last cluster when s->len is not aligned to clusters.
> + *
> + * No sync here: nor bitmap neighter intersecting requests handling, o=
nly copy.
> + *
> + * Returns 0 on success.
>   */
> -static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *=
s,
> -                                                      int64_t start,
> -                                                      int64_t end,
> -                                                      bool *error_is_r=
ead)
> +static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
> +                                           int64_t start, int64_t end,=

> +                                           bool *error_is_read)
>  {
>      int ret;
> -    int nbytes;
> -    void *bounce_buffer =3D qemu_blockalign(s->source->bs, s->cluster_=
size);
> +    int nbytes =3D MIN(end, s->len) - start;
> +    void *bounce_buffer =3D NULL;
> =20
>      assert(QEMU_IS_ALIGNED(start, s->cluster_size));
> -    bdrv_reset_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
> -    nbytes =3D MIN(s->cluster_size, s->len - start);
> +    assert(QEMU_IS_ALIGNED(end, s->cluster_size));
> +    assert(end < s->len || end =3D=3D QEMU_ALIGN_UP(s->len, s->cluster=
_size));
> +
> +    if (s->use_copy_range) {
> +        ret =3D bdrv_co_copy_range(s->source, start, s->target, start,=
 nbytes,
> +                                 0, s->write_flags);
> +        if (ret < 0) {
> +            trace_block_copy_copy_range_fail(s, start, ret);
> +            s->use_copy_range =3D false;
> +        } else {
> +            return ret;

Maybe the =E2=80=9Cfail=E2=80=9D label should be called =E2=80=9Dout=E2=80=
=9D and then we could go there
from here.  Doesn=E2=80=99t make much of a difference here (1 LoC either =
way),
but maybe it=E2=80=99s a bit cleaner to always use the clean-up path in t=
his
function (even when there=E2=80=99s nothing to clean up).

*shrug*

> +        }
> +    }
> +
> +    bounce_buffer =3D qemu_blockalign(s->source->bs, nbytes);
> =20
>      ret =3D bdrv_co_pread(s->source, start, nbytes, bounce_buffer, 0);=

>      if (ret < 0) {
> -        trace_block_copy_with_bounce_buffer_read_fail(s, start, ret);
> +        trace_block_copy_read_fail(s, start, ret);
>          if (error_is_read) {
>              *error_is_read =3D true;
>          }

[...]

> @@ -163,42 +181,12 @@ static int coroutine_fn block_copy_with_bounce_bu=
ffer(BlockCopyState *s,
> =20
>      qemu_vfree(bounce_buffer);
> =20
> -    return nbytes;
> +    return 0;
> +
>  fail:
>      qemu_vfree(bounce_buffer);
> -    bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
> -    return ret;
> -
> -}

Wouldn=E2=80=99t it be simpler to drop the =E2=80=9Cqemu_vfree(bounce_buf=
fer); return
0;=E2=80=9D above the fail label and just fall through?

In any case:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--grq8MN6miZ9EYQ8W7Jhwjsp4IKVobnKnC--

--Y0hkN06j3Lvxs8jKc9qz1uf6YUCA7d4wP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2bSP4ACgkQ9AfbAGHV
z0BylQf9G0u+sKOASEl+ZCWljQ04VpOSDv7Dl5F+1LhNXP/S9UcHoDBTP7r51eUR
Q98QppZRlOKYinfbbVq/XQuC69W4J5vO7TBq6EyodCdUqhPD80y3h0Zv3+8+Gzk3
masUp0TYjfj2WCjR01vDMugrd8LydxDJ0nCsyDQJKdmLpjm9tX62PX8tC3C+GL3u
Y3fQ97EuqudcVSY6UOaLF4ytuPjZ4F7SQrqakrFreazoJNhwGuqLkd97EhJAwK68
If/oGDQYBfGlPFzesC2bZVJ0zvsGq5fMOp+4Z5EnjvDxeYjn6r0i8MEka/Em7fzf
fwZiVLsYM64uR3dsuyL902aQIsSBew==
=FhRE
-----END PGP SIGNATURE-----

--Y0hkN06j3Lvxs8jKc9qz1uf6YUCA7d4wP--

