Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C614FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954BA21726
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954BA21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0o5x-00046E-Ok
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i0o4s-0003BB-1r
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i0o4q-0003eM-2n
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:28:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i0o4m-0003cN-6d; Thu, 22 Aug 2019 10:28:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4F4C410C6967;
 Thu, 22 Aug 2019 14:28:31 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8535860BF3;
 Thu, 22 Aug 2019 14:28:29 +0000 (UTC)
To: Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org
References: <20190816212122.8816-1-nsoffer@redhat.com>
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
Message-ID: <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
Date: Thu, 22 Aug 2019 16:28:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816212122.8816-1-nsoffer@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ud6eFQXz0KeVJCd3iWKTu4dUcqz8zXoln"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 22 Aug 2019 14:28:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block: posix: Always allocate the first
 block
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ud6eFQXz0KeVJCd3iWKTu4dUcqz8zXoln
Content-Type: multipart/mixed; boundary="3ARmzi4RgmyY8rSfiiwJw5hsvC6HjWbZO";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Nir Soffer <nsoffer@redhat.com>
Message-ID: <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
Subject: Re: [PATCH] block: posix: Always allocate the first block
References: <20190816212122.8816-1-nsoffer@redhat.com>
In-Reply-To: <20190816212122.8816-1-nsoffer@redhat.com>

--3ARmzi4RgmyY8rSfiiwJw5hsvC6HjWbZO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.08.19 23:21, Nir Soffer wrote:
> When creating an image with preallocation "off" or "falloc", the first
> block of the image is typically not allocated. When using Gluster
> storage backed by XFS filesystem, reading this block using direct I/O
> succeeds regardless of request length, fooling alignment detection.
>=20
> In this case we fallback to a safe value (4096) instead of the optimal
> value (512), which may lead to unneeded data copying when aligning
> requests.  Allocating the first block avoids the fallback.
>=20
> When using preallocation=3Doff, we always allocate at least one filesys=
tem
> block:
>=20
>     $ ./qemu-img create -f raw test.raw 1g
>     Formatting 'test.raw', fmt=3Draw size=3D1073741824
>=20
>     $ ls -lhs test.raw
>     4.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16 23:48 test.raw
>=20
> I did quick performance tests for these flows:
> - Provisioning a VM with a new raw image.
> - Copying disks with qemu-img convert to new raw target image
>=20
> I installed Fedora 29 server on raw sparse image, measuring the time
> from clicking "Begin installation" until the "Reboot" button appears:
>=20
> Before(s)  After(s)     Diff(%)
> -------------------------------
>      356        389        +8.4
>=20
> I ran this only once, so we cannot tell much from these results.

So you=E2=80=99d expect it to be fast but it was slower?  Well, you only =
ran it
once and it isn=E2=80=99t really a precise benchmark...

> The second test was cloning the installation image with qemu-img
> convert, doing 10 runs:
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
> Here we see very clear improvement in CPU usage.
>=20
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  block/file-posix.c         | 25 +++++++++++++++++++++++++
>  tests/qemu-iotests/150.out |  1 +
>  tests/qemu-iotests/160     |  4 ++++
>  tests/qemu-iotests/175     | 19 +++++++++++++------
>  tests/qemu-iotests/175.out |  8 ++++----
>  tests/qemu-iotests/221.out | 12 ++++++++----
>  tests/qemu-iotests/253.out | 12 ++++++++----
>  7 files changed, 63 insertions(+), 18 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index b9c33c8f6c..3964dd2021 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1755,6 +1755,27 @@ static int handle_aiocb_discard(void *opaque)
>      return ret;
>  }
> =20
> +/*
> + * Help alignment detection by allocating the first block.
> + *
> + * When reading with direct I/O from unallocated area on Gluster backe=
d by XFS,
> + * reading succeeds regardless of request length. In this case we fall=
back to
> + * safe aligment which is not optimal. Allocating the first block avoi=
ds this
> + * fallback.
> + *
> + * Returns: 0 on success, -errno on failure.
> + */
> +static int allocate_first_block(int fd)
> +{
> +    ssize_t n;
> +
> +    do {
> +        n =3D pwrite(fd, "\0", 1, 0);

This breaks when fd has been opened with O_DIRECT.

(Which happens when you open some file with cache.direct=3Don, and then
use e.g. QMP=E2=80=99s block_resize.)

It isn=E2=80=99t that bad because eventually you simply ignore the error.=
  But
it still makes me wonder whether we shouldn=E2=80=99t write like the bigg=
est
power of two that does not exceed the new file length or MAX_BLOCKSIZE.

> +    } while (n =3D=3D -1 && errno =3D=3D EINTR);
> +
> +    return (n =3D=3D -1) ? -errno : 0;
> +}
> +
>  static int handle_aiocb_truncate(void *opaque)
>  {
>      RawPosixAIOData *aiocb =3D opaque;
> @@ -1794,6 +1815,8 @@ static int handle_aiocb_truncate(void *opaque)
>                  /* posix_fallocate() doesn't set errno. */
>                  error_setg_errno(errp, -result,
>                                   "Could not preallocate new data");
> +            } else if (current_length =3D=3D 0) {
> +                allocate_first_block(fd);

Should posix_fallocate() not take care of precisely this?

>              }
>          } else {
>              result =3D 0;

[...]

> diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
> index df89d3864b..ad2d054a47 100755
> --- a/tests/qemu-iotests/160
> +++ b/tests/qemu-iotests/160
> @@ -57,6 +57,10 @@ for skip in $TEST_SKIP_BLOCKS; do
>      $QEMU_IMG dd if=3D"$TEST_IMG" of=3D"$TEST_IMG.out" skip=3D"$skip" =
-O "$IMGFMT" \
>          2> /dev/null
>      TEST_IMG=3D"$TEST_IMG.out" _check_test_img
> +
> +    # We always write the first byte of an image.
> +    printf "\0" > "$TEST_IMG.out.dd"
> +
>      dd if=3D"$TEST_IMG" of=3D"$TEST_IMG.out.dd" skip=3D"$skip" status=3D=
none

Won=E2=80=99t this dd completely overwrite $TEST_IMG.out.dd (especially g=
iven
the lack of conv=3Dnotrunc)?

> =20
>      echo
> diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
> index 51e62c8276..c6a3a7bb1e 100755
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
> +    sed -e "s/blocks=3D$((extra_blocks + min_blocks))\\(\$\\|[^0-9]\\)=
/min allocation/" \

I don=E2=80=99t think adding extra_blocks to min_blocks makes sense.  Jus=
t
min_blocks alone should be what we want here.

Max


--3ARmzi4RgmyY8rSfiiwJw5hsvC6HjWbZO--

--Ud6eFQXz0KeVJCd3iWKTu4dUcqz8zXoln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1eposACgkQ9AfbAGHV
z0A1ewf5ASYMiADmz2KMDFYCkrwKgTnRvFlBcqdJWANiCKMxUB3lfK+x8ZGo+OU1
wb8StzYd/OqsT/40gFSA+POVroc6aREZzy0aO1sUMYGJSucMPwKveEA7p/9nmXX4
5L5VVvQCNUXNFsu1KxWOJx/unKSeV6frOyHzTB/0zP+8gH/ZBb3sWVMMGRi5qOmb
jT771hMMkEF0rLcqtxqvd9gbhMbWJthBSNNF/UVYnVqtUuopslLtZt++abo7zdQz
hF9Yf+dORJOxT4GFpPitos/64XboZLhH9WTk/tSD0tbgIgGEzS6mncq7bXMDb/DM
Cef5HYvalvRe0364/6tnEDQKOg3i5A==
=vqOV
-----END PGP SIGNATURE-----

--Ud6eFQXz0KeVJCd3iWKTu4dUcqz8zXoln--

