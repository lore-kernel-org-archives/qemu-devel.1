Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78BCC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 12:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8522520874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 12:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8522520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2EBb-0003jk-Lq
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 08:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i2EAG-0003D5-3H
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 08:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i2EAE-0001rF-I1
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 08:32:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34514)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i2EAA-0001pO-4e; Mon, 26 Aug 2019 08:31:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C6B38C0546D5;
 Mon, 26 Aug 2019 12:31:56 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C07960610;
 Mon, 26 Aug 2019 12:31:55 +0000 (UTC)
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
References: <20190825220329.7942-1-nsoffer@redhat.com>
 <20190825220329.7942-2-nsoffer@redhat.com>
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
Message-ID: <e4e45496-b867-4e57-5b25-d0f1425d4824@redhat.com>
Date: Mon, 26 Aug 2019 14:31:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190825220329.7942-2-nsoffer@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ObJtstHnuXcG0EtQvXtslZJI7XV0IHvrw"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 26 Aug 2019 12:31:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block: posix: Always allocate the
 first block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ObJtstHnuXcG0EtQvXtslZJI7XV0IHvrw
Content-Type: multipart/mixed; boundary="H7llXfBkdRR2LsP0QMLl8BtnJS3gnPh3V";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Nir Soffer <nsoffer@redhat.com>
Message-ID: <e4e45496-b867-4e57-5b25-d0f1425d4824@redhat.com>
Subject: Re: [PATCH v2 1/2] block: posix: Always allocate the first block
References: <20190825220329.7942-1-nsoffer@redhat.com>
 <20190825220329.7942-2-nsoffer@redhat.com>
In-Reply-To: <20190825220329.7942-2-nsoffer@redhat.com>

--H7llXfBkdRR2LsP0QMLl8BtnJS3gnPh3V
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.08.19 00:03, Nir Soffer wrote:
> When creating an image with preallocation "off" or "falloc", the first
> block of the image is typically not allocated. When using Gluster
> storage backed by XFS filesystem, reading this block using direct I/O
> succeeds regardless of request length, fooling alignment detection.
>=20
> In this case we fallback to a safe value (4096) instead of the optimal
> value (512), which may lead to unneeded data copying when aligning
> requests.  Allocating the first block avoids the fallback.
>=20
> Since we allocate the first block even with preallocation=3Doff, we no
> longer create images with zero disk size:
>=20
>     $ ./qemu-img create -f raw test.raw 1g
>     Formatting 'test.raw', fmt=3Draw size=3D1073741824
>=20
>     $ ls -lhs test.raw
>     4.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16 23:48 test.raw
>=20
> And converting the image requires additional cluster:
>=20
>     $ ./qemu-img measure -f raw -O qcow2 test.raw
>     required size: 458752
>     fully allocated size: 1074135040
>=20
> I did quick performance test for copying disks with qemu-img convert to=

> new raw target image to Gluster storage with sector size of 512 bytes:
>=20
>     for i in $(seq 10); do
>         rm -f dst.raw
>         sleep 10
>         time ./qemu-img convert -f raw -O raw -t none -T none src.raw d=
st.raw
>     done
>=20
> Here is a table comparing the total time spent:
>=20
> Type    Before(s)   After(s)    Diff(%)
> ---------------------------------------
> real      530.028    469.123      -11.4
> user       17.204     10.768      -37.4
> sys        17.881      7.011      -60.7
>=20
> We can see very clear improvement in CPU usage.
>=20
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  block/file-posix.c                            | 43 +++++++++++++++++++=

>  tests/qemu-iotests/{150.out =3D> 150.out.qcow2} |  0
>  tests/qemu-iotests/150.out.raw                | 12 ++++++
>  tests/qemu-iotests/175                        | 19 +++++---
>  tests/qemu-iotests/175.out                    |  8 ++--
>  tests/qemu-iotests/178.out.qcow2              |  4 +-
>  tests/qemu-iotests/221.out                    | 12 ++++--
>  tests/qemu-iotests/253.out                    | 12 ++++--
>  8 files changed, 90 insertions(+), 20 deletions(-)
>  rename tests/qemu-iotests/{150.out =3D> 150.out.qcow2} (100%)
>  create mode 100644 tests/qemu-iotests/150.out.raw
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index fbeb0068db..51688ae3fc 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1749,6 +1749,39 @@ static int handle_aiocb_discard(void *opaque)
>      return ret;
>  }
> =20
> +/*
> + * Help alignment probing by allocating the first block.
> + *
> + * When reading with direct I/O from unallocated area on Gluster backe=
d by XFS,
> + * reading succeeds regardless of request length. In this case we fall=
back to
> + * safe alignment which is not optimal. Allocating the first block avo=
ids this
> + * fallback.
> + *
> + * fd may be opened with O_DIRECT, but we don't know the buffer alignm=
ent or
> + * request alignment, so we use safe values.
> + *
> + * Returns: 0 on success, -errno on failure. Since this is an optimiza=
tion,
> + * caller may ignore failures.
> + */
> +static int allocate_first_block(int fd, size_t max_size)
> +{
> +    size_t write_size =3D MIN(MAX_BLOCKSIZE, max_size);

Hm, well, there was a reason why I proposed rounding this down to the
next power of two.  If max_size is not a power of two but below
MAX_BLOCKSIZE, write_size will not be a power of two, and thus the write
below may fail even if write_size exceeds the physical block size.

You can see that in the test case you add by using e.g. 768 as the
destination size (provided your test filesystem has a block size of 512).=


Now I would like to say that it=E2=80=99s stupid to resize an O_DIRECT fi=
le to a
size that is not a multiple of the block size; but I=E2=80=99ve had a bug=

assigned to me before because that didn=E2=80=99t work.

But maybe it=E2=80=99s actually better if it doesn=E2=80=99t work.  I don=
=E2=80=99t know.

> +    size_t max_align =3D MAX(MAX_BLOCKSIZE, getpagesize());
> +    void *buf;
> +    ssize_t n;
> +
> +    buf =3D qemu_memalign(max_align, write_size);
> +    memset(buf, 0, write_size);
> +
> +    do {
> +        n =3D pwrite(fd, buf, write_size, 0);
> +    } while (n =3D=3D -1 && errno =3D=3D EINTR);
> +
> +    qemu_vfree(buf);
> +
> +    return (n =3D=3D -1) ? -errno : 0;
> +}
> +
>  static int handle_aiocb_truncate(void *opaque)
>  {
>      RawPosixAIOData *aiocb =3D opaque;
> @@ -1788,6 +1821,13 @@ static int handle_aiocb_truncate(void *opaque)
>                  /* posix_fallocate() doesn't set errno. */
>                  error_setg_errno(errp, -result,
>                                   "Could not preallocate new data");
> +            } else if (current_length =3D=3D 0) {
> +                /*
> +                 * Needed only if posix_fallocate() used fallocate(), =
but we
> +                 * don't have a way to detect that.

This sounds a bit weird because fallocate() is what we call
posix_fallocate() for.  I=E2=80=99d=E2=80=99ve liked something that state=
s more
explicitly that unaligned reads from fallocated areas may succeed even
with O_DIRECT, hence the need for allocate_first_block().

>                                                      Optimize future al=
ignment
> +                 * probing; ignore failures.
> +                 */
> +                allocate_first_block(fd, offset);
>              }
>          } else {
>              result =3D 0;

[...]

> diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
> index 51e62c8276..d54cb43c39 100755
> --- a/tests/qemu-iotests/175
> +++ b/tests/qemu-iotests/175
> @@ -37,14 +37,16 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # the file size.  This function hides the resulting difference in the
>  # stat -c '%b' output.
>  # Parameter 1: Number of blocks an empty file occupies
> -# Parameter 2: Image size in bytes
> +# Parameter 2: Minimal number of blocks in an image
> +# Parameter 3: Image size in bytes
>  _filter_blocks()
>  {
>      extra_blocks=3D$1
> -    img_size=3D$2
> +    min_blocks=3D$2
> +    img_size=3D$3
> =20
> -    sed -e "s/blocks=3D$extra_blocks\\(\$\\|[^0-9]\\)/nothing allocate=
d/" \
> -        -e "s/blocks=3D$((extra_blocks + img_size / 512))\\(\$\\|[^0-9=
]\\)/everything allocated/"
> +    sed -e "s/blocks=3D$((min_blocks))\\(\$\\|[^0-9]\\)/min allocation=
/" \

Superfluous parentheses ($(())), but not wrong.

So I think I can give a

Reviewed-by: Max Reitz <mreitz@redhat.com>


--H7llXfBkdRR2LsP0QMLl8BtnJS3gnPh3V--

--ObJtstHnuXcG0EtQvXtslZJI7XV0IHvrw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1j0TkACgkQ9AfbAGHV
z0BRRwf9EqnKsJaDRvdAJ2uh3HlYRWNdcMokqGtWj82+kSBecs5kO58TFMvw48K2
x9/cuYr6k0dUXkBDMs1ZHNOUwfbJOPc9IONCzgNnET4EkKMonjJNQFYz77xM67IA
GORPJNI0VZut15DVdiiTDb/pVtBYHIzLGa9ZhfB1hlnT+eC6W8tg6iR/TVV0LyHQ
XW6QUtOCSZ5bZAR7tJ/PgwbDgR68CrXli6KUYBpUKkDZyLnphQ7yBFBdEwdGZfgL
6+uHJMpCArG1ZjqVWAZGao2iE2CNBZJlKP6CFYwn7RnovgJHqQ68YNv3qyqypySE
MZWEsP6auec3PJNdiiqYmzctApkmWA==
=X5/B
-----END PGP SIGNATURE-----

--ObJtstHnuXcG0EtQvXtslZJI7XV0IHvrw--

