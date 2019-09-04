Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAF2C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 16:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CC020820
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 16:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CC020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Xq8-0008D7-Vg
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 12:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5XpJ-0007c4-Fh
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 12:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5XpH-0007cH-O0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 12:08:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i5XpC-0007aL-Uc; Wed, 04 Sep 2019 12:08:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4AE7BC0568FD;
 Wed,  4 Sep 2019 16:08:01 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 153CE5D9C9;
 Wed,  4 Sep 2019 16:08:00 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, armbru@redhat.com,
 qemu-devel@nongnu.org
References: <20190904152915.30755-1-dplotnikov@virtuozzo.com>
 <20190904152915.30755-4-dplotnikov@virtuozzo.com>
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
Message-ID: <2ff3dc82-ea8c-10a8-fb4c-8081abc3775e@redhat.com>
Date: Wed, 4 Sep 2019 11:07:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904152915.30755-4-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7zGgs8NWXMU97z2a32Fhn7tW44dVodMXv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 04 Sep 2019 16:08:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 3/3] qcow2: add zstd cluster compression
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7zGgs8NWXMU97z2a32Fhn7tW44dVodMXv
Content-Type: multipart/mixed; boundary="TkctiaJeoGqvFEX1PAT0QYifMUcaQupfV";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, armbru@redhat.com,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@virtuozzo.com,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org
Message-ID: <2ff3dc82-ea8c-10a8-fb4c-8081abc3775e@redhat.com>
Subject: Re: [PATCH v5 3/3] qcow2: add zstd cluster compression
References: <20190904152915.30755-1-dplotnikov@virtuozzo.com>
 <20190904152915.30755-4-dplotnikov@virtuozzo.com>
In-Reply-To: <20190904152915.30755-4-dplotnikov@virtuozzo.com>

--TkctiaJeoGqvFEX1PAT0QYifMUcaQupfV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/4/19 10:29 AM, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of compression ratio in comparison with
> zlib, which, at the moment, has been the only compression
> method available.
>=20
> The performance test results:
> Test compresses and decompresses qemu qcow2 image with just
> installed rhel-7.6 guest.
> Image cluster size: 64K. Image on disk size: 2.2G
>=20

>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---

> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    ssize_t ret;
> +    uint32_t *c_size =3D dest;

Potentially unaligned pointer...

> +    /* steal some bytes to store compressed chunk size */
> +    char *d_buf =3D ((char *) dest) + sizeof(*c_size);
> +
> +    /* sanity check that we can store the compressed data length */
> +    if (dest_size < sizeof(*c_size)) {
> +        return -ENOMEM;
> +    }
> +
> +    dest_size -=3D sizeof(*c_size);
> +
> +    ret =3D ZSTD_compress(d_buf, dest_size, src, src_size, 5);
> +
> +    if (ZSTD_isError(ret)) {
> +        if (ZSTD_getErrorCode(ret) =3D=3D ZSTD_error_dstSize_tooSmall)=
 {
> +            return -ENOMEM;
> +        } else {
> +            return -EIO;
> +        }
> +    }
> +
> +    /* store the compressed chunk size in the very beginning of the bu=
ffer */
> +    *c_size =3D cpu_to_be32(ret);

=2E..and you are storing into it.  You are using the wrong conversion
function; you want stl_be_p(dest, ret) or similar.

> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
> +                                     const void *src, size_t src_size)=

> +{
> +    ssize_t ret;
> +    /*
> +     * zstd decompress wants to know the exact length of the data
> +     * for that purpose, on the compression the length is stored in

s/data for/data. For/
s/on the compression/on compression,/

> +     * the very beginning of the compressed buffer
> +     */
> +    uint32_t s_size;
> +    const char *s_buf =3D ((const char *) src) + sizeof(s_size);
> +
> +    /* sanity check that we can read the content length */
> +    if (src_size < sizeof(s_size)) {

Should this use <=3D?  After all, I seriously doubt you can get a 0-byte
compression stream.

> +        return -EIO;
> +    }
> +
> +    s_size =3D be32_to_cpu(*(const uint32_t *) src);

As written, this looks like you may be dereferencing an unaligned
pointer.  It so happens that be32_to_cpu() applies & to your * to get
back at the raw pointer, and then is careful to handle unaligned
pointers, so it works; but it would look a lot nicer as merely:

s_size =3D be32_to_cpu(src);

> +
> +    /* sanity check that the buffer is big enough to read the content =
*/
> +    if (src_size - sizeof(s_size) < s_size) {

Why < and not !=3D?  As written, you are silently ignoring trailing
garbage, instead of treating it as a client that did not write the data
correctly.

> +++ b/docs/interop/qcow2.txt
> @@ -181,6 +181,7 @@ in the description of a field.
>                      must be set.
>                      Available compression type values:
>                          0: zlib <https://www.zlib.net/> (default)
> +                        1: zstd <http://github.com/facebook/zstd>

At this point, this listing is almost redundant with the more-detailed
header below.  Maybe it is worth just forward referencing that section
for a listing of valid values, and then mentioning the values 0 and 1 in
that section?

> =20
>  Directly after the image header, optional sections called header exten=
sions can
>  be stored. Each extension has a structure like the following:
> @@ -536,6 +537,9 @@ Compressed Clusters Descriptor (x =3D 62 - (cluster=
_bits - 8)):
>                      Another compressed cluster may map to the tail of =
the final
>                      sector used by this compressed cluster.
> =20
> +                    The layout of the compressed data depends on the c=
ompression
> +                    type used for the image (see compressed cluster la=
yout).
> +
>  If a cluster is unallocated, read requests shall read the data from th=
e backing
>  file (except if bit 0 in the Standard Cluster Descriptor is set). If t=
here is
>  no backing file or the backing file is smaller than the image, they sh=
all read
> @@ -788,3 +792,19 @@ In the image file the 'enabled' state is reflected=
 by the 'auto' flag. If this
>  flag is set, the software must consider the bitmap as 'enabled' and st=
art
>  tracking virtual disk changes to this bitmap from the first write to t=
he
>  virtual disk. If this flag is not set then the bitmap is disabled.
> +
> +=3D=3D=3D Compressed cluster layout =3D=3D=3D

As written, you have made this a child to '=3D=3D Bitmaps =3D=3D' (and si=
bling
to '=3D=3D=3D Dirty tracking bitmaps =3D=3D=3D'); that feels wrong.  I wo=
uld place
this subsection belong under '=3D=3D Cluster mapping =3D=3D' right after =
the
'Compressed Clusters Descriptor'.

> +
> +The compressed cluster data may have a different layout depending on t=
he
> +compression type used for the image, and store specific data for the p=
articular
> +compression type.
> +
> +Compressed data layout for the available compression types:

Wordy; maybe:

The compressed cluster data has a layout depending on the compression
type used for the image, as follows:

> +(x =3D data_space_length - 1)
> +
> +    zlib <http://zlib.net/>:
> +        Byte  0 -  x:     the compressed data content
> +                          all the space provided used for compressed d=
ata

Worth a mention that this is compression type 0?

> +    zstd <http://github.com/facebook/zstd>:
> +        Byte  0 -  3:     the length of compressed data in bytes
> +              4 -  x:     the compressed data content

Worth a mention that this is compression type 1?

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 2c002ca6a9..9e458d5b40 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4283,11 +4283,12 @@
>  # Compression type used in qcow2 image file
>  #
>  # @zlib:  zlib compression, see <http://zlib.net/>
> +# @zstd:  zstd compression, see <http://github.com/facebook/zstd>
>  #
>  # Since: 4.2
>  ##
>  { 'enum': 'Qcow2CompressionType',
> -  'data': [ 'zlib' ] }
> +  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ]=
 }
> =20
>  ##
>  # @BlockdevCreateOptionsQcow2:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--TkctiaJeoGqvFEX1PAT0QYifMUcaQupfV--

--7zGgs8NWXMU97z2a32Fhn7tW44dVodMXv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1v4V8ACgkQp6FrSiUn
Q2pMCgf7BL+Hfa1I+AKCiKELjpn9JRc4YS2jUnpSxr9ZlZ8TooTb66FTjfCLe/hw
IFs2rO3MlDqQSIwA6QE2qGOsTMxD3TjthtOf5whcgay8r3EN+INTRCm7K6a+GpOT
8zKPPSgTNOpQuleSnRZON96yOi23rhC6QLY3gtQ/ySnp2BYhTfasvfGVrgzRn1NR
Tk/kXhZtaxSIjI1pwMOPiFkgzoinDh8BCSy4kHDmfkpucmXcVDRFJ6XMbKVlOmys
sbQysHr/F/8iISjxHeCgzgoxpkH3OSl9q1Q5qNhPHKYU51YbSialsdLDtbpr7cPf
3IX9Y1psBdptZn71BcXauMoPktcP/A==
=5lEy
-----END PGP SIGNATURE-----

--7zGgs8NWXMU97z2a32Fhn7tW44dVodMXv--

