Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EF9C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1976C2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1976C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvjeg-0001pP-C6
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 10:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58206)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hvjeG-0001N3-BG
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hvjeE-0001r0-Tm
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:44:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hvjeC-0001p1-0y; Thu, 08 Aug 2019 10:44:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DFC7330A5687;
 Thu,  8 Aug 2019 14:44:06 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E297A608AB;
 Thu,  8 Aug 2019 14:44:04 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 eblake@redhat.com, armbru@redhat.com
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-4-dplotnikov@virtuozzo.com>
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
Message-ID: <1785b389-aa43-aca7-e3d2-f2f2513491c5@redhat.com>
Date: Thu, 8 Aug 2019 16:44:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190704130949.14017-4-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="075vxhN76ttXLaLmQtv0VM2ORkgGJcedJ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 08 Aug 2019 14:44:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qcow2: add zstd cluster compression
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--075vxhN76ttXLaLmQtv0VM2ORkgGJcedJ
Content-Type: multipart/mixed; boundary="SCwr4FFMFLjagyPEhrUs0BYMd3VK6sDZq";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 eblake@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <1785b389-aa43-aca7-e3d2-f2f2513491c5@redhat.com>
Subject: Re: [PATCH v2 3/3] qcow2: add zstd cluster compression
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-4-dplotnikov@virtuozzo.com>
In-Reply-To: <20190704130949.14017-4-dplotnikov@virtuozzo.com>

--SCwr4FFMFLjagyPEhrUs0BYMd3VK6sDZq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.07.19 15:09, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of compression ratio in comparison with
> zlib, which, by the moment, has been the only compression
> method available.
>=20
> The performance test results:
> Test compresses and decompresses qemu qcow2 image with just
> installed rhel-7.6 guest.
> Image cluster size: 64K. Image on disk size: 2.2G
>=20
> The test was conducted with brd disk to reduce the influence
> of disk subsystem to the test results.
> The results is given in seconds.
>=20
> compress cmd:
>   time ./qemu-img convert -O qcow2 -c -o compression_type=3D[zlib|zstd]=

>                   src.img [zlib|zstd]_compressed.img
> decompress cmd
>   time ./qemu-img convert -O qcow2
>                   [zlib|zstd]_compressed.img uncompressed.img
>=20
>            compression               decompression
>          zlib       zstd           zlib         zstd
> ------------------------------------------------------------
> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
> user     65.0       15.8            5.3          2.5
> sys       3.3        0.2            2.0          2.0
>=20
> Both ZLIB and ZSTD gave the same compression ratio: 1.57
> compressed image size in both cases: 1.4G
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c          | 99 ++++++++++++++++++++++++++++++++++++++++++=

>  configure              | 32 ++++++++++++++
>  docs/interop/qcow2.txt | 19 ++++++++
>  qapi/block-core.json   |  3 +-
>  4 files changed, 152 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index a107f76e98..252eba636f 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -4092,6 +4103,84 @@ static ssize_t qcow2_zlib_decompress(void *dest,=
 size_t dest_size,
>      return ret;
>  }
> =20
> +#ifdef CONFIG_ZSTD
> +/*
> + * qcow2_zstd_compress()
> + *
> + * Compress @src_size bytes of data using zstd compression method
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: compressed size on success
> + *          a negative error code on fail
> + */
> +
> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    ssize_t ret;
> +    uint32_t *c_size =3D dest;
> +    /* steal some bytes to store compressed chunk size */
> +    char *d_buf =3D ((char *) dest) + sizeof(*c_size);
> +
> +    if (dest_size < sizeof(*c_size)) {
> +        return -ENOMEM;
> +    }
> +
> +    dest_size -=3D sizeof(*c_size);
> +
> +    ret =3D ZSTD_compress(d_buf, dest_size, src, src_size, 5);
> +
> +    if (ZSTD_isError(ret)) {
> +        if (ret =3D=3D ZSTD_error_dstSize_tooSmall) {

s/ret/ZSTD_getErrorCode(ret)/

> +            return -ENOMEM;
> +        } else {
> +            return -EIO;
> +        }
> +    }
> +
> +    /* store the compressed chunk size in the very beginning of the bu=
ffer */
> +    *c_size =3D ret;

I think this should be stored in big endian.

> +
> +    return ret + sizeof(ret);

s/sizeof(ret)/sizeof(*c_size)/

> +}
> +
> +/*
> + * qcow2_zstd_decompress()
> + *
> + * Decompress some data (not more than @src_size bytes) to produce exa=
ctly
> + * @dest_size bytes using zstd compression method
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: 0 on success
> + *          -EIO on fail
> + */
> +
> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
> +                                     const void *src, size_t src_size)=

> +{
> +    ssize_t ret;
> +    /*
> +     * zstd decompress wants to know the exact lenght of the data

*length

> +     * for that purpose, on the compression the length is stored in
> +     * the very beginning of the compressed buffer
> +     */
> +    const uint32_t *s_size =3D src;
> +    const char *s_buf =3D ((char *) src) + sizeof(*s_size);

If you want to be strict, s/(char *)/(const char *)/.

> +
> +    ret =3D ZSTD_decompress(dest, dest_size, s_buf, *s_size);
> +
> +    if (ZSTD_isError(ret)) {
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +#endif
> +
>  #define MAX_COMPRESS_THREADS 4
> =20
>  typedef ssize_t (*Qcow2CompressFunc)(void *dest, size_t dest_size,

[...]

> diff --git a/configure b/configure
> index 1c563a7027..57a80e38e7 100755
> --- a/configure
> +++ b/configure

[...]

> @@ -2374,6 +2380,29 @@ EOF
>      fi
>  fi
> =20
> +#########################################
> +# zstd check
> +
> +if test "$zstd" !=3D "no" ; then
> +    if $pkg_config --exists libzstd; then
> +        zstd_cflags=3D$($pkg_config --cflags libzstd)
> +        zstd_libs=3D$($pkg_config --libs libzstd)
> +        QEMU_CFLAGS=3D"$zstd_cflags $QEMU_CFLAGS"
> +        LIBS=3D"$zstd_libs $LIBS"
> +    else
> +        cat > $TMPC << EOF
> +#include <zstd.h>
> +int main(void) { ZSTD_versionNumber(); return 0; }
> +EOF
> +        if compile_prog "" "-lzstd" ; then
> +            LIBS=3D"$LIBS -lzstd"
> +        else
> +            error_exit "zstd check failed" \
> +                "Make sure to have the zstd libs and headers installed=
=2E"

(1) When the user doesn=E2=80=99t specify anything and doesn=E2=80=99t ha=
ve zstd
installed, this will throw an error.  That shouldn=E2=80=99t be, it shoul=
d just
set zstd to "no", unless zstd was explicitly "yes".

(2) All other places use feature_not_found.  I think this should, too.

> +        fi
> +    fi

You must set zstd to "yes" if it was found.

(So it is used when available, even if the user did not explicitly pass
--enable-zstd.)

> +fi
> +
>  ##########################################
>  # libseccomp check
> =20
> @@ -7253,6 +7282,9 @@ fi
>  if test "$sheepdog" =3D "yes" ; then
>    echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak
>  fi
> +if test "$zstd" =3D "yes" ; then
> +  echo "CONFIG_ZSTD=3Dy" >> $config_host_mak
> +fi
> =20
>  if test "$tcg_interpreter" =3D "yes"; then
>    QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"

The status should be printed in the list of what features are enabled.

Max


--SCwr4FFMFLjagyPEhrUs0BYMd3VK6sDZq--

--075vxhN76ttXLaLmQtv0VM2ORkgGJcedJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1MNTMACgkQ9AfbAGHV
z0DSOwf+Nxp8joOed/6vmQKf4ZHsLgOy6To4KYReHjh+kYhHSNjkQ+/VdtThLo+D
S7+bHySa//u750B3rpA/PeAOZ+X3kHmkxQJ7Ynaw8jAiJq6nYSz6hEFJtpvz8z9S
2j2Cnpo/r6uGfM0/L33wPo6VoUNQrAy5yZheSVa4OtMp+OjsXd83nbxEjDIxN+dp
xg9owMzPWPxQq65qgWVaRAjnXfuYxHw9EhTOS6tmslDysRkoiR5UqstoAsnVTwA9
Zw5Al32DD/AdKy7K3AtR1u5Kd1GrMKUmOQywX0OnWe+arrZFLz8N0h3iJZ8/+Cqh
mRd4bpmzliQkQI3SWJCm2qCzRqJ7cA==
=S/TR
-----END PGP SIGNATURE-----

--075vxhN76ttXLaLmQtv0VM2ORkgGJcedJ--

