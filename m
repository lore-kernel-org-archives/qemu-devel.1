Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCABC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65D4218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65D4218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hig38-0006yU-G5
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 10:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52137)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hig2U-000694-Hx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hig2S-000664-HE
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:15:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hig2O-0005gu-8k; Wed, 03 Jul 2019 10:15:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6DFEB3162912;
 Wed,  3 Jul 2019 14:14:37 +0000 (UTC)
Received: from [10.3.116.152] (ovpn-116-152.phx2.redhat.com [10.3.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D9E46013C;
 Wed,  3 Jul 2019 14:14:33 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
 <20190703110044.25610-2-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <f41f5552-a625-3306-ba3b-50d60dbefe22@redhat.com>
Date: Wed, 3 Jul 2019 09:14:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703110044.25610-2-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E36TJSXbIcuQgizgqmebpI09Z80uI8kpN"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 03 Jul 2019 14:14:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 1/3] qcow2: introduce compression type
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
--E36TJSXbIcuQgizgqmebpI09Z80uI8kpN
Content-Type: multipart/mixed; boundary="VMvCG9CKiurKsz3tSkjiw0wlAAGBP8BHd";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <f41f5552-a625-3306-ba3b-50d60dbefe22@redhat.com>
Subject: Re: [PATCH v1 1/3] qcow2: introduce compression type feature
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
 <20190703110044.25610-2-dplotnikov@virtuozzo.com>
In-Reply-To: <20190703110044.25610-2-dplotnikov@virtuozzo.com>

--VMvCG9CKiurKsz3tSkjiw0wlAAGBP8BHd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/3/19 6:00 AM, Denis Plotnikov wrote:
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
> It works roughly x2 faster than ZLIB providing a comparable compression=
 ratio

2x

> and therefore provide a performance advantage in backup scenarios.
>=20
> The default compression is ZLIB. Images created with ZLIB compression t=
ype
> is backward compatible with older qemu versions.

s/is/are/

>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c             | 94 +++++++++++++++++++++++++++++++++++++++=

>  block/qcow2.h             | 26 ++++++++---
>  docs/interop/qcow2.txt    | 22 ++++++++-
>  include/block/block_int.h |  1 +
>  qapi/block-core.json      | 22 ++++++++-
>  5 files changed, 155 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 3ace3b2209..921eb67b80 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1202,6 +1202,47 @@ static int qcow2_update_options(BlockDriverState=
 *bs, QDict *options,
>      return ret;
>  }
> =20
> +static int check_compression_type(BDRVQcow2State *s, Error **errp)
> +{
> +    bool is_set;
> +    int ret =3D 0;
> +
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        break;
> +
> +    default:
> +        if (errp) {

Useless check for errp being non-NULL.  What's worse, if the caller
passes in NULL because they don't care about the error, then your code
behaves differently.  Just call error_setg() and return -ENOTSUP
unconditionally.

> +            error_setg(errp, "qcow2: unknown compression type: %u",
> +                       s->compression_type);
> +            return -ENOTSUP;
> +        }
> +    }
> +
> +    /*
> +     * with QCOW2_COMPRESSION_TYPE_ZLIB the corresponding incompatible=

> +     * feature flag must be absent, with other compression types the
> +     * incompatible feature flag must be set

Is there a strong reason for forbid the incompatible feature flag with
ZLIB?  Sure, it makes the image impossible to open with older qemu, but
it doesn't get in the way of newer qemu opening it. I'll have to see how
your spec changes documented this, to see if you could instead word it
as 'for ZLIB, the incompatible feature flag may be absent'.

> +     */
> +    is_set =3D s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_T=
YPE;
> +
> +    if (s->compression_type =3D=3D QCOW2_COMPRESSION_TYPE_ZLIB) {
> +        if (is_set) {
> +            ret =3D -EINVAL;
> +        }
> +    } else {
> +        if (!is_set) {
> +            ret =3D -EINVAL;
> +        }
> +    }

More compact as:

if ((s->compression_type =3D=3D QCOW2_COMPRESSION_TYPE_ZLIB) =3D=3D is_se=
t)

> +
> +    if (ret && errp) {
> +        error_setg(errp, "qcow2: Illegal compression type setting");

s/Illegal/Invalid/ (the user isn't breaking a law)

Also, don't check whether errp is non-NULL.  Just blindly call
error_setg() if ret is non-zero.

> +    }
> +
> +    return ret;

Or even shorter (psuedocode):

if ((compression =3D=3D ZLIB) !=3D is_set) {
    error_setg();
    return -EINVAL;
}
return 0;

> +}
> +
>  /* Called with s->lock held.  */
>  static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *opt=
ions,
>                                        int flags, Error **errp)
> @@ -1318,6 +1359,24 @@ static int coroutine_fn qcow2_do_open(BlockDrive=
rState *bs, QDict *options,
>      s->compatible_features      =3D header.compatible_features;
>      s->autoclear_features       =3D header.autoclear_features;
> =20
> +    /* Handle compression type */
> +    if (header.header_length > 104) {

Magic number. Please spell this as header.header_length > offsetof (xxx,
compression_type) for the appropriate xxx type.  Also, do you need to
sanity check for an image using a length of 105-107 (invalid) vs. an
image of 108 or larger?

> +        header.compression_type =3D be32_to_cpu(header.compression_typ=
e);
> +        s->compression_type =3D header.compression_type;
> +    } else {
> +        /*
> +         * older qcow2 images don't contain the compression type heade=
r
> +         * field, distinguish them by the header length and use
> +         * the only valid compression type in that case
> +         */
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
> @@ -2434,6 +2493,13 @@ int qcow2_update_header(BlockDriverState *bs)
>      total_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
>      refcount_table_clusters =3D s->refcount_table_size >> (s->cluster_=
bits - 3);
> =20
> +    ret =3D check_compression_type(s, NULL);

Why are you ignoring the error here?


> @@ -5239,6 +5327,12 @@ static QemuOptsList qcow2_create_opts =3D {
>              .help =3D "Width of a reference count entry in bits",
>              .def_value_str =3D "16"
>          },
> +        {
> +            .name =3D BLOCK_OPT_COMPRESSION_TYPE,
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "Compression method used for image clusters comp=
ression",
> +            .def_value_str =3D "0"

Eww. Why are we exposing an integer rather than an enum value as the
default value?  This should probably be "zlib".


> +++ b/docs/interop/qcow2.txt
> @@ -109,7 +109,12 @@ in the description of a field.
>                                  An External Data File Name header exte=
nsion may
>                                  be present if this bit is set.
> =20
> -                    Bits 3-63:  Reserved (set to 0)
> +                    Bit 3:      Compression type bit. The bit must be =
set if
> +                                the compression type differs from defa=
ult: zlib.

Maybe: "differs from the default of zlib".

Up to here is okay.

> +                                If the compression type is default the=
 bit must
> +                                be unset.

Is this restriction necessary?

> +
> +                    Bits 4-63:  Reserved (set to 0)
> =20
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation =
can
> @@ -165,6 +170,21 @@ in the description of a field.
>                      Length of the header structure in bytes. For versi=
on 2
>                      images, the length is always assumed to be 72 byte=
s.
> =20
> +        104 - 107:  compression_type
> +                    Defines the compression method used for compressed=
 clusters.
> +                    A single compression type is applied to all compre=
ssed image
> +                    clusters.
> +                    The compression type is set on image creation only=
=2E
> +                    The default compression type is zlib.

Where is the documentation that a value of 0 corresponds to zlib?

> +                    When the deafult compression type is used the comp=
ression

default

> +                    type bit (incompatible feature bit 3) must be unse=
t.

Is this restriction necessary?

> +                    When any other compression type is used the compre=
ssion
> +                    type bit must be set.
> +                    Qemu versions older than 4.1 can use images create=
d with
> +                    the default compression type without any additiona=
l
> +                    preparations and cannot use images created with an=
y other
> +                    compression type.
> +
>  Directly after the image header, optional sections called header exten=
sions can
>  be stored. Each extension has a structure like the following:
> =20
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
> index 7ccbfff9d0..6aa8b99993 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -78,6 +78,8 @@
>  #
>  # @bitmaps: A list of qcow2 bitmap details (since 4.0)
>  #
> +# @compression-type: the image cluster compression method (since 4.1)
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
> +      '*compression-type': 'Qcow2CompressionType'

Why is this field optional? Can't we always populate it, even for older
images?

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

But this one must indeed be optional.

> =20
>  ##
>  # @BlockdevCreateOptionsQed:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--VMvCG9CKiurKsz3tSkjiw0wlAAGBP8BHd--

--E36TJSXbIcuQgizgqmebpI09Z80uI8kpN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0cuEgACgkQp6FrSiUn
Q2q+lwgAruSwCVeK8HZQnZ5AIh/hVOOA9ierW2J1GTGtYRQLk8uwE27xzE26dZVu
gTty6EY3NbQy0JNoP3a3A5MqaXAvCM/yhqCPab3ilRHJmIZKsXoVH1t8lPD/NeE6
8hUayaYb9hU+AFgitxsVs6BCikzJI9OodsBLcJ/YtxyeCSrlnXqKt1W3b35QgGjy
T+ddWVa80LvWhzAG53GLGk7W6tMD9C2z9oxSdVKXcUmkK8r2qaKq+GzAi7NAvJw1
NBaXrueUfp/VwgZNpuxyVPvxJqlB3L3qQ9k4hxLumksXjMlsJFYMTOQfhu6eRjs5
ymPmZJqlHqXQUsrrzoW+BfA/DRY2Lg==
=TpDc
-----END PGP SIGNATURE-----

--E36TJSXbIcuQgizgqmebpI09Z80uI8kpN--

