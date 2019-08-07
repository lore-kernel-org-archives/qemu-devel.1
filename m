Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BB6C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 23:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D772184E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 23:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D772184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvV7O-0001by-43
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 19:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55504)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hvV6y-00018A-Aq
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 19:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hvV6w-0002ng-CP
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 19:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hvV6s-0002lG-Gg; Wed, 07 Aug 2019 19:12:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1CB42300247E;
 Wed,  7 Aug 2019 23:12:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-24.brq.redhat.com
 [10.40.204.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14AA65D71C;
 Wed,  7 Aug 2019 23:12:42 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 eblake@redhat.com, armbru@redhat.com
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-2-dplotnikov@virtuozzo.com>
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
Message-ID: <f7f3b12c-2c04-87bc-a88f-f89a2e50bc4e@redhat.com>
Date: Thu, 8 Aug 2019 01:12:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190704130949.14017-2-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Tp1nbE50JmkGekn9N6DPF2wtzGtgPpE6P"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 07 Aug 2019 23:12:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qcow2: introduce compression type
 feature
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
--Tp1nbE50JmkGekn9N6DPF2wtzGtgPpE6P
Content-Type: multipart/mixed; boundary="UnTRkWEAx4g1Tj3KGfVciqbWdfkpIEgxM";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 eblake@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <f7f3b12c-2c04-87bc-a88f-f89a2e50bc4e@redhat.com>
Subject: Re: [PATCH v2 1/3] qcow2: introduce compression type feature
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-2-dplotnikov@virtuozzo.com>
In-Reply-To: <20190704130949.14017-2-dplotnikov@virtuozzo.com>

--UnTRkWEAx4g1Tj3KGfVciqbWdfkpIEgxM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.07.19 15:09, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type=

> feature to QCOW2 header that indicates that *all* compressed clusters
> must be (de)compressed using a certain compression type.
>=20
> It is implied that the compression type is set on the image creation an=
d
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image.
>=20
> The goal of the feature is to add support of other compression algorith=
ms
> to qcow2. For example, ZSTD which is more effective on compression than=
 ZLIB.
> It works roughly 2x faster than ZLIB providing a comparable compression=
 ratio
> and therefore provide a performance advantage in backup scenarios.
>=20
> The default compression is ZLIB. Images created with ZLIB compression t=
ype
> are backward compatible with older qemu versions.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c             | 95 +++++++++++++++++++++++++++++++++++++++=

>  block/qcow2.h             | 26 ++++++++---
>  docs/interop/qcow2.txt    | 21 ++++++++-
>  include/block/block_int.h |  1 +
>  qapi/block-core.json      | 22 ++++++++-
>  5 files changed, 155 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 3ace3b2209..8fa932a349 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1202,6 +1202,32 @@ static int qcow2_update_options(BlockDriverState=
 *bs, QDict *options,
>      return ret;
>  }
> =20
> +static int check_compression_type(BDRVQcow2State *s, Error **errp)
> +{
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        break;
> +
> +    default:
> +        error_setg(errp, "qcow2: unknown compression type: %u",
> +                   s->compression_type);
> +        return -ENOTSUP;
> +    }
> +
> +    /*
> +     * if the compression type differs from QCOW2_COMPRESSION_TYPE_ZLI=
B
> +     * the incompatible feature flag must be set
> +     */
> +
> +    if (s->compression_type !=3D QCOW2_COMPRESSION_TYPE_ZLIB &&
> +        !(s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE))=
 {
> +            error_setg(errp, "qcow2: Invalid compression type setting"=
);
> +            return -EINVAL;

(1) Why is this block indented twice?

(2) Do we need this at all?  Sure, it=E2=80=99s a corruption, but do we n=
eed to
reject the image because of it?

> +    }
> +
> +    return 0;
> +}
> +

Overall, I don=E2=80=99t see the purpose of this function.  I don=E2=80=99=
t see any need
to call it in qcow2_update_header().  And without =E2=80=9Cdoes non-zlib
compression imply the respective incompatible flag?=E2=80=9D check, you c=
an just
inline the rest (checking that we recognize the compression type) into
qcow2_do_open().

>  /* Called with s->lock held.  */
>  static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *opt=
ions,
>                                        int flags, Error **errp)
> @@ -1318,6 +1344,35 @@ static int coroutine_fn qcow2_do_open(BlockDrive=
rState *bs, QDict *options,
>      s->compatible_features      =3D header.compatible_features;
>      s->autoclear_features       =3D header.autoclear_features;
> =20
> +    /*
> +     * Handle compression type
> +     * Older qcow2 images don't contain the compression type header.
> +     * Distinguish them by the header length and use
> +     * the only valid (default) compression type in that case
> +     */
> +    if (header.header_length > offsetof(QCowHeader, compression_type))=
 {
> +        /* sanity check that we can read a compression type */
> +        size_t min_len =3D offsetof(QCowHeader, compression_type) +
> +                         sizeof(header.compression_type);
> +        if (header.header_length < min_len) {
> +            error_setg(errp,
> +                       "Could not read compression type."
> +                       "qcow2 header is too short");

This will read as =E2=80=9CCould not read compression type.qcow2 header i=
s too
short=E2=80=9D.  There should be a space after the full stop (and the ful=
l stop
should maybe be a comma instead).

> +           ret =3D -EINVAL;
> +           goto fail;

These two lines are incorrectly aligned.

> +        }
> +
> +        header.compression_type =3D be32_to_cpu(header.compression_typ=
e);
> +        s->compression_type =3D header.compression_type;
> +    } else {
> +        s->compression_type =3D QCOW2_COMPRESSION_TYPE_ZLIB;
> +    }
> +
> +    ret =3D check_compression_type(s, errp);
> +    if (ret) {
> +        goto fail;
> +    }
> +
>      if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
>          void *feature_table =3D NULL;
>          qcow2_read_extensions(bs, header.header_length, ext_end,
> @@ -2434,6 +2489,13 @@ int qcow2_update_header(BlockDriverState *bs)
>      total_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
>      refcount_table_clusters =3D s->refcount_table_size >> (s->cluster_=
bits - 3);
> =20
> +    ret =3D check_compression_type(s, NULL);
> +
> +    if (ret) {
> +        goto fail;
> +    }
> +
> +

Again, I don=E2=80=99t see why this function should be called here.  If
anything, we should set the non-zlib incompatible flag here
automatically if a non-zlib compression type is used.

(And I don=E2=80=99t really see the point in checking that s->compression=
_type
is valid =E2=80=93 because why shouldn=E2=80=99t it be?)

>      *header =3D (QCowHeader) {
>          /* Version 2 fields */
>          .magic                  =3D cpu_to_be32(QCOW_MAGIC),

[...]

> @@ -3126,6 +3195,24 @@ qcow2_co_create(BlockdevCreateOptions *create_op=
tions, Error **errp)
>              cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
>      }
> =20
> +    if (qcow2_opts->has_compression_type &&
> +        qcow2_opts->compression_type !=3D QCOW2_COMPRESSION_TYPE_ZLIB)=
 {
> +
> +        switch(qcow2_opts->compression_type) {

In qemu, we generally put a space between =E2=80=9Cswitch=E2=80=9D and th=
e opening
parenthesis.


Also, just a hint: If you don=E2=80=99t like the visual appearance of

    if (long &&
        condition) {
        block_statement;

(I know I don=E2=80=99t)

you can (whenever a condition spans multiple lines) put the opening
curly bracket on a separate line:

    if (long &&
        condition)
    {
        block_statement;

(I personally prefer that over an empty line.)

> +        case QCOW2_COMPRESSION_TYPE_ZLIB:

Well, a bit useless considering you just excluded this case in the if
condition, but I suppose the compiler forced you to include this arm.

I suppose we should abort() here because you made the specification
state that the incompatible features must not be set with zlib
compression mode, so it looks weird to just accept this case here and
then set the incompatible flag below.

> +            break;
> +
> +        default:
> +            error_setg_errno(errp, -EINVAL, "Unknown compression type"=
);

I think a plain abort() is fine here.  This is an enum after all, it
cannot have any other values.

> +            goto out;
> +        }
> +
> +        header->compression_type =3D cpu_to_be32(qcow2_opts->compressi=
on_type);
> +
> +        header->incompatible_features |=3D
> +            cpu_to_be64(QCOW2_INCOMPAT_COMPRESSION_TYPE);
> +    }
> +
>      ret =3D blk_pwrite(blk, 0, header, cluster_size, 0);
>      g_free(header);
>      if (ret < 0) {

[...]

> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 01e855a066..814917baec 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -58,6 +58,7 @@
>  #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
>  #define BLOCK_OPT_DATA_FILE         "data_file"
>  #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
> +#define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
> =20
>  #define BLOCK_PROBE_BUF_SIZE        512
> =20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ccbfff9d0..835dd3c37f 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -78,6 +78,8 @@
>  #
>  # @bitmaps: A list of qcow2 bitmap details (since 4.0)
>  #
> +# @compression-type: the image cluster compression method (since 4.1)

s/1/2/

> +#
>  # Since: 1.7
>  ##
>  { 'struct': 'ImageInfoSpecificQCow2',
> @@ -89,7 +91,8 @@
>        '*corrupt': 'bool',
>        'refcount-bits': 'int',
>        '*encrypt': 'ImageInfoSpecificQCow2Encryption',
> -      '*bitmaps': ['Qcow2BitmapInfo']
> +      '*bitmaps': ['Qcow2BitmapInfo'],
> +      'compression-type': 'Qcow2CompressionType'
>    } }
> =20
>  ##
> @@ -4206,6 +4209,18 @@
>    'data': [ 'v2', 'v3' ] }
> =20
> =20
> +##
> +# @Qcow2CompressionType:
> +#
> +# Compression type used in qcow2 image file
> +#
> +# @zlib:  zlib compression, see <http://zlib.net/>
> +#
> +# Since: 4.1

s/1/2/

> +##
> +{ 'enum': 'Qcow2CompressionType',
> +  'data': [ 'zlib' ] }
> +
>  ##
>  # @BlockdevCreateOptionsQcow2:
>  #
> @@ -4228,6 +4243,8 @@
>  # @preallocation    Preallocation mode for the new image (default: off=
)
>  # @lazy-refcounts   True if refcounts may be updated lazily (default: =
off)
>  # @refcount-bits    Width of reference counts in bits (default: 16)
> +# @compression-type The image cluster compression method
> +#                   (default: zlib, since 4.1)

s/1/2/

Max

>  #
>  # Since: 2.12
>  ##
> @@ -4243,7 +4260,8 @@
>              '*cluster-size':    'size',
>              '*preallocation':   'PreallocMode',
>              '*lazy-refcounts':  'bool',
> -            '*refcount-bits':   'int' } }
> +            '*refcount-bits':   'int',
> +            '*compression-type': 'Qcow2CompressionType' } }
> =20
>  ##
>  # @BlockdevCreateOptionsQed:
>=20



--UnTRkWEAx4g1Tj3KGfVciqbWdfkpIEgxM--

--Tp1nbE50JmkGekn9N6DPF2wtzGtgPpE6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1LWukACgkQ9AfbAGHV
z0DyXwgAp+K1rdKg7MRW4msp2tCd5jvs1ggi/J+AjpZ6/H9dmhQtnEFhalUJ31Gg
YQMxha3Erz2XK/xdPpUF8XLWcoUAFouNmfrp91+eZcBnLWbbQ4T+ApVEz3v0aw1A
UyfM7jEzIDonWLKM30fE6TN7GDLhMxUE+DJ8kO1/+KRn4qnbPPUhb52xLfPEQtpC
UuUIpLDVuiLSIrhyoa5QFnbokmdTmqFWUoT6alQguOivRLkkLeXa6REbethp8DJk
VEoEpr+4u88RFVrzlfZdJD11WpKHTqKdIfwfISyFcJOJVqQXXwySstpUtuhYMAiS
+ts1NT1vHzDGAj388ZCW4Yxr+sJPow==
=X1vx
-----END PGP SIGNATURE-----

--Tp1nbE50JmkGekn9N6DPF2wtzGtgPpE6P--

