Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E91C43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 22:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E039520679
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 22:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E039520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49163 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKsNu-0000nU-5S
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 18:34:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hKsN0-0000RF-MM
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 18:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hKsLj-00075I-Mo
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 18:32:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hKsLh-00073S-Ub; Sun, 28 Apr 2019 18:32:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3916F309178C;
	Sun, 28 Apr 2019 22:32:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-32.brq.redhat.com
	[10.40.204.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E827C10018E0;
	Sun, 28 Apr 2019 22:32:36 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com
References: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
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
Message-ID: <cd22d738-d09c-4e2f-5ec6-8d3d34e2b341@redhat.com>
Date: Mon, 29 Apr 2019 00:32:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6S5hCFRNsHRbRe9kOzQF3AWHoioq0dCDV"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Sun, 28 Apr 2019 22:32:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] [RFC] qcow2: add compression type feature
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190428223234.SDT9p1ZMjXq7CZaDxMyltbJCo8epSzH0okyyCxCorG8@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6S5hCFRNsHRbRe9kOzQF3AWHoioq0dCDV
From: Max Reitz <mreitz@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 eblake@redhat.com
Message-ID: <cd22d738-d09c-4e2f-5ec6-8d3d34e2b341@redhat.com>
Subject: Re: [PATCH] [RFC] qcow2: add compression type feature
References: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.02.19 10:08, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type=

> feature into QCOW2 header that indicates that *all* compressed clusters=

> must be (de)compressed using a certain compression type.
>=20
> It is implied that the compression type is set on the image creation an=
d
> can be changed only later by image convertion, thus the only compressio=
n
> algorithm is used for the image.
>=20
> The plan is to add support for ZSTD and then may be something more effe=
ctive
> in the future.
>=20
> ZSDT compression algorithm consumes 3-5 times less CPU power with a
> comparable comression ratio with zlib. It would be wise to use it for
> data compression f.e. for backups.
>=20
> The default compression is ZLIB.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c | 25 +++++++++++++++++++++++++
>  block/qcow2.h | 26 ++++++++++++++++++++++----
>  2 files changed, 47 insertions(+), 4 deletions(-)

Are there plans to pursue this further?

[...]

> diff --git a/block/qcow2.h b/block/qcow2.h
> index 32cce9eee2..fdde5bbefd 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -112,6 +112,10 @@
>  #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
>  #define QCOW2_OPT_CACHE_CLEAN_INTERVAL "cache-clean-interval"
> =20
> +/* Compression types */
> +#define QCOW2_COMPRESSION_TYPE_ZLIB    0
> +#define QCOW2_COMPRESSION_TYPE_ZSTD    1

We probably want QAPI types anyway (qemu-img info should report the
compression type), so I think we could use them instead.

>  typedef struct QCowHeader {
>      uint32_t magic;
>      uint32_t version;
> @@ -197,10 +201,13 @@ enum {
> =20
>  /* Incompatible feature bits */
>  enum {
> -    QCOW2_INCOMPAT_DIRTY_BITNR   =3D 0,
> -    QCOW2_INCOMPAT_CORRUPT_BITNR =3D 1,
> -    QCOW2_INCOMPAT_DIRTY         =3D 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
> -    QCOW2_INCOMPAT_CORRUPT       =3D 1 << QCOW2_INCOMPAT_CORRUPT_BITNR=
,
> +    QCOW2_INCOMPAT_DIRTY_BITNR            =3D 0,
> +    QCOW2_INCOMPAT_CORRUPT_BITNR          =3D 1,
> +    QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR =3D 2,
> +    QCOW2_INCOMPAT_DIRTY                  =3D 1 << QCOW2_INCOMPAT_DIRT=
Y_BITNR,
> +    QCOW2_INCOMPAT_CORRUPT                =3D 1 << QCOW2_INCOMPAT_CORR=
UPT_BITNR,
> +    QCOW2_INCOMPAT_COMPRESSION_TYPE       =3D
> +                                    1 << QCOW2_INCOMPAT_COMPRESSION_TY=
PE_BITNR,
> =20
>      QCOW2_INCOMPAT_MASK          =3D QCOW2_INCOMPAT_DIRTY
>                                   | QCOW2_INCOMPAT_CORRUPT,

This mask needs to be expanded by QCOW2_INCOMPAT_COMPRESSION_TYPE.

> @@ -256,6 +263,10 @@ typedef struct Qcow2BitmapHeaderExt {
>      uint64_t bitmap_directory_offset;
>  } QEMU_PACKED Qcow2BitmapHeaderExt;
> =20
> +typedef struct Qcow2CompressionTypeExt {
> +    uint32_t compression_type;
> +} QEMU_PACKED Qcow2CompressionTypeExt;
> +
>  typedef struct BDRVQcow2State {
>      int cluster_bits;
>      int cluster_size;
> @@ -340,6 +351,13 @@ typedef struct BDRVQcow2State {
> =20
>      CoQueue compress_wait_queue;
>      int nb_compress_threads;
> +    /**
> +     * Compression type used for the image. Default: 0 - ZLIB
> +     * The image compression type is set on image creation.
> +     * The only way to change the compression type is to convert the i=
mage
> +     * with the desired compresion type set

*compression

And, well, ideally qemu-img amend could perform this operation, too.

Max

> +     */
> +    uint32_t compression_type;
>  } BDRVQcow2State;
> =20
>  typedef struct Qcow2COWRegion {
>=20



--6S5hCFRNsHRbRe9kOzQF3AWHoioq0dCDV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzGKgIACgkQ9AfbAGHV
z0B0/Qf/a9epd/IVJODcHCMTjUeoOlsFDEgxj4KIdlFk/Rjzse7P4nIFqr4QmY6l
WYPE/1lZOUBQ/3DIuosc2vktphIQoImjN7W0W7JEZdV0ptAL4vqFIeCraRI7BeVz
KQExc3Ozugq+LT/jYWwTlMOAaFvVwQy2Zm00kp5k1Ev3QRjzBiH5SSH+qLZBMeza
i6fS+U8k9RistuvJE1lyksbZqxUaLi7Zd+Be5fT4MV4hUKfsD10B+cmmUexlu6E1
Ts/Ahr7SjNyH7JAPFE3evWscj3DMl0Xvs/vGG0MLx6cTU4yJTgshubSHgdHHhr8y
gSRB9S12bIniXa2w98VERif97Dx3dg==
=j6ah
-----END PGP SIGNATURE-----

--6S5hCFRNsHRbRe9kOzQF3AWHoioq0dCDV--

