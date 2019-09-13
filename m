Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFDBC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CAA208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CAA208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8iyb-0000vK-GH
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 06:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i8ixp-0000FX-4Y
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i8ixn-00049V-Pg
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:38:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i8ixk-00042a-Cm; Fri, 13 Sep 2019 06:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6BCCC306141F;
 Fri, 13 Sep 2019 10:37:59 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-81.ams2.redhat.com
 [10.36.116.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DF1460C57;
 Fri, 13 Sep 2019 10:37:54 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190912223754.875-1-mlevitsk@redhat.com>
 <20190912223754.875-2-mlevitsk@redhat.com>
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
Message-ID: <abd660bc-5e3c-ec6d-e595-6830e1b6f0d1@redhat.com>
Date: Fri, 13 Sep 2019 12:37:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912223754.875-2-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I5Nbxt2ab1s8lIGSYsIXxx2SrdUuVuDJd"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 13 Sep 2019 10:37:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/3] block/qcow2: refactoring of
 threaded encryption code
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
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I5Nbxt2ab1s8lIGSYsIXxx2SrdUuVuDJd
Content-Type: multipart/mixed; boundary="82sd70ZdinVJcqrEInMbDVZivvi4eLPwA";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <abd660bc-5e3c-ec6d-e595-6830e1b6f0d1@redhat.com>
Subject: Re: [PATCH v3 1/3] block/qcow2: refactoring of threaded encryption
 code
References: <20190912223754.875-1-mlevitsk@redhat.com>
 <20190912223754.875-2-mlevitsk@redhat.com>
In-Reply-To: <20190912223754.875-2-mlevitsk@redhat.com>

--82sd70ZdinVJcqrEInMbDVZivvi4eLPwA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 00:37, Maxim Levitsky wrote:
> This commit tries to clarify few function arguments,
> and add comments describing the encrypt/decrypt interface
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/qcow2-cluster.c |  8 +++---
>  block/qcow2-threads.c | 63 ++++++++++++++++++++++++++++++++++---------=

>  2 files changed, 54 insertions(+), 17 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index f09cc992af..b95e64c237 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -463,8 +463,8 @@ static int coroutine_fn do_perform_cow_read(BlockDr=
iverState *bs,
>  }
> =20
>  static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
> -                                                uint64_t src_cluster_o=
ffset,
> -                                                uint64_t cluster_offse=
t,
> +                                                uint64_t guest_cluster=
_offset,
> +                                                uint64_t host_cluster_=
offset,
>                                                  unsigned offset_in_clu=
ster,
>                                                  uint8_t *buffer,
>                                                  unsigned bytes)
> @@ -474,8 +474,8 @@ static bool coroutine_fn do_perform_cow_encrypt(Blo=
ckDriverState *bs,
>          assert((offset_in_cluster & ~BDRV_SECTOR_MASK) =3D=3D 0);
>          assert((bytes & ~BDRV_SECTOR_MASK) =3D=3D 0);
>          assert(s->crypto);
> -        if (qcow2_co_encrypt(bs, cluster_offset,
> -                             src_cluster_offset + offset_in_cluster,
> +        if (qcow2_co_encrypt(bs, host_cluster_offset,
> +                             guest_cluster_offset + offset_in_cluster,=

>                               buffer, bytes) < 0) {
>              return false;
>          }
> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> index 3b1e63fe41..6da1838e95 100644
> --- a/block/qcow2-threads.c
> +++ b/block/qcow2-threads.c
> @@ -234,15 +234,19 @@ static int qcow2_encdec_pool_func(void *opaque)
>  }
> =20
>  static int coroutine_fn
> -qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
> -                  uint64_t offset, void *buf, size_t len, Qcow2EncDecF=
unc func)
> +qcow2_co_encdec(BlockDriverState *bs, uint64_t host_cluster_offset,
> +                uint64_t guest_offset, void *buf, size_t len,
> +                Qcow2EncDecFunc func)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
> +
> +    uint64_t offset =3D s->crypt_physical_offset ?
> +        host_cluster_offset + offset_into_cluster(s, guest_offset) :
> +        guest_offset;
> +
>      Qcow2EncDecData arg =3D {
>          .block =3D s->crypto,
> -        .offset =3D s->crypt_physical_offset ?
> -                      file_cluster_offset + offset_into_cluster(s, off=
set) :
> -                      offset,
> +        .offset =3D offset,
>          .buf =3D buf,
>          .len =3D len,
>          .func =3D func,
> @@ -251,18 +255,51 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t fi=
le_cluster_offset,
>      return qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
>  }
> =20
> +
> +/*
> + * qcow2_co_encrypt()
> + *
> + * Encrypts one or more contiguous aligned sectors
> + *
> + * @host_cluster_offset - underlying storage offset of the first clust=
er
> + * in which the encrypted data will be written
> + * Used as an initialization vector for encryption

s/as an/for generating the/

(AFAIU)

> + *
> + * @guest_offset - guest (virtual) offset of the first sector of the
> + * data to be encrypted
> + * Used as an initialization vector for older, qcow2 native encryption=


I wouldn=E2=80=99t be so specific here.  I think it=E2=80=99d be better t=
o just have a
common sentence like =E2=80=9CDepending on the encryption method, either =
of
these offsets may be used for generating the initialization vector for
encryption.=E2=80=9D

Well, technically, host_cluster_offset will not be used itself.  Before
we can use it, of course we have to add the in-cluster offset to it
(which qcow2_co_encdec() does).

This makes me wonder whether it wouldn=E2=80=99t make more sense to pass =
a
host_offset instead of a host_cluster_offset (i.e. make the callers add
the in-cluster offset to the host offset already)?

> + *
> + * @buf - buffer with the data to encrypt, that after encryption
> + *        will be written to the underlying storage device at
> + *        @host_cluster_offset

I think just =E2=80=9Cbuffer with the data to encrypt=E2=80=9D is suffici=
ent.  (The rest
is just the same as above.)

> + *
> + * @len - length of the buffer (in sector size multiplies)

=E2=80=9CIn sector size multiples=E2=80=9D to me means that it is a secto=
r count (in
that =E2=80=9Cone sector size multiple=E2=80=9D is equal to 512 byes).

Maybe =E2=80=9Cmust be a BDRV_SECTOR_SIZE multiple=E2=80=9D instead?

> + *
> + * Note that the group of the sectors, don't have to be aligned
> + * on cluster boundary and can also cross a cluster boundary.

Maybe =E2=80=9CNote that while the whole range must be aligned on sectors=
, it
does not have to be aligned on clusters and can also cross cluster
boundaries=E2=80=9D?

(=E2=80=9CThe group of sectors=E2=80=9D sounds a bit weird to me.  I don=E2=
=80=99t quite know,
why.  I think that for some reason it makes me think of a non-continuous
set of sectors.  Also, the caller doesn=E2=80=99t pass sector indices, bu=
t byte
offsets, that just happen to have to be aligned to sectors.  (I suppose
because that=E2=80=99s the simplest way to make it a multiple of the encr=
yption
block size.))

> + *
> + */
>  int coroutine_fn
> -qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> -                 uint64_t offset, void *buf, size_t len)
> +qcow2_co_encrypt(BlockDriverState *bs, uint64_t host_cluster_offset,
> +                 uint64_t guest_offset, void *buf, size_t len)
>  {
> -    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
> -                             qcrypto_block_encrypt);
> +    return qcow2_co_encdec(bs, host_cluster_offset, guest_offset, buf,=
 len,
> +                           qcrypto_block_encrypt);
>  }
> =20
> +
> +/*
> + * qcow2_co_decrypt()
> + *
> + * Decrypts one or more contiguous aligned sectors
> + * Similar to qcow2_co_encrypt

Hm.  This would make me wonder in what way it is only similar to
qcow2_co_encrypt().  Sure, it decrypts instead of encrypting, but maybe
there=E2=80=99s more...?

So maybe =E2=80=9CIts interface is the same as qcow2_co_encrypt()'s=E2=80=
=9D?

Max

> + *
> + */
> +
>  int coroutine_fn
> -qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
> -                 uint64_t offset, void *buf, size_t len)
> +qcow2_co_decrypt(BlockDriverState *bs, uint64_t host_cluster_offset,
> +                 uint64_t guest_offset, void *buf, size_t len)
>  {
> -    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
> -                             qcrypto_block_decrypt);
> +    return qcow2_co_encdec(bs, host_cluster_offset, guest_offset, buf,=
 len,
> +                           qcrypto_block_decrypt);
>  }
>=20



--82sd70ZdinVJcqrEInMbDVZivvi4eLPwA--

--I5Nbxt2ab1s8lIGSYsIXxx2SrdUuVuDJd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl17cYAACgkQ9AfbAGHV
z0CbAQf+J1WsEmeAXv0lN7ebgL2ALIE3d54VDmwzSZWAC+4Hvcv1qjpvvVYssH6X
iO3OmcAwIbDIhYuTuptq+u9crqcSoSMBfSn2/TugEI+IfsjwDU/CfUMZi3eDEoKX
xjaqIr5rhgkj1rGsP7HYzI3pPlKprkUvNg47CtpmqQ7kVXLMdUiBuOWzqCF01yGz
b2doBYWO2RBzoPeFSBmT3m/IQv7aacVit3SpY9UwpEdXnt7VDu6TpilCJL5m3O5y
C0cZB4Tro12wsNfR5/LCZ+SgGjvbkDMuk1fXejQr96RXrm5tQhl50ZXcMnNDbkqg
dbuk5BV6Bz74HQACBCDklTT3lALGWA==
=wx2D
-----END PGP SIGNATURE-----

--I5Nbxt2ab1s8lIGSYsIXxx2SrdUuVuDJd--

