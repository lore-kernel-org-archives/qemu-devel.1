Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39E9C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 18:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0AB2053B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 18:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0AB2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGSga-0007nD-3i
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 14:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iGSWP-00033X-AN
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iGSWN-000265-UZ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:41:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iGSWI-00023q-7a; Fri, 04 Oct 2019 14:41:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 78AB3C075BD2;
 Fri,  4 Oct 2019 18:41:37 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B61E019C4F;
 Fri,  4 Oct 2019 18:41:30 +0000 (UTC)
Subject: Re: [PATCH v2 05/11] block/crypto: implement the encryption key
 management
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-6-mlevitsk@redhat.com>
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
Message-ID: <bcc8844d-ec0f-93d1-209b-7b7af4f2c24a@redhat.com>
Date: Fri, 4 Oct 2019 20:41:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190912223028.18496-6-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RoQBTW66M6aB0Wq27WZhC9VvC1g5fkdbz"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 04 Oct 2019 18:41:37 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RoQBTW66M6aB0Wq27WZhC9VvC1g5fkdbz
Content-Type: multipart/mixed; boundary="MemsBdKijLAv3NxoNfQwSfMT0Nj4b3TfE"

--MemsBdKijLAv3NxoNfQwSfMT0Nj4b3TfE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 00:30, Maxim Levitsky wrote:
> This implements the encryption key management
> using the generic code in qcrypto layer
> (currently only for qemu-img amend)
>=20
> This code adds another 'write_func' because the initialization
> write_func works directly on the underlying file,
> because during the creation, there is no open instance
> of the luks driver, but during regular use, we have it,
> and should use it instead.
>=20
>=20
> This commit also adds a	'hack/workaround' I and	Kevin Wolf (thanks)
> made to	make the driver	still support write sharing,
> but be safe against concurrent  metadata update (the keys)
> Eventually write sharing for luks driver will be deprecated
> and removed together with this hack.
>=20
> The hack is that we ask	(as a format driver) for
> BLK_PERM_CONSISTENT_READ always
> (technically always unless opened with BDRV_O_NO_IO)
>=20
> and then when we want to update	the keys, we
> unshare	that permission. So if someone else
> has the	image open, even readonly, this	will fail.
>=20
> Also thanks to Daniel Berrange for the variant of
> that hack that involves	asking for read,
> rather that write permission
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/crypto.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++--=

>  1 file changed, 115 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index a6a3e1f1d8..f42fa057e6 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -36,6 +36,7 @@ typedef struct BlockCrypto BlockCrypto;
> =20
>  struct BlockCrypto {
>      QCryptoBlock *block;
> +    bool updating_keys;
>  };
> =20
> =20
> @@ -70,6 +71,24 @@ static ssize_t block_crypto_read_func(QCryptoBlock *=
block,
>      return ret;
>  }
> =20
> +static ssize_t block_crypto_write_func(QCryptoBlock *block,
> +                                       size_t offset,
> +                                       const uint8_t *buf,
> +                                       size_t buflen,
> +                                       void *opaque,
> +                                       Error **errp)

There=E2=80=99s already a function of this name for creation.

> +{
> +    BlockDriverState *bs =3D opaque;
> +    ssize_t ret;
> +
> +    ret =3D bdrv_pwrite(bs->file, offset, buf, buflen);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Could not write encryption heade=
r");
> +        return ret;
> +    }
> +    return ret;
> +}
> +
> =20
>  struct BlockCryptoCreateData {
>      BlockBackend *blk;

[...]

> +static void
> +block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
> +                         const BdrvChildRole *role,
> +                         BlockReopenQueue *reopen_queue,
> +                         uint64_t perm, uint64_t shared,
> +                         uint64_t *nperm, uint64_t *nshared)
> +{
> +
> +    BlockCrypto *crypto =3D bs->opaque;
> +
> +    /*
> +     * Ask for consistent read permission so that if
> +     * someone else tries to open this image with this permission
> +     * neither will be able to edit encryption keys
> +     */
> +    if (!(bs->open_flags & BDRV_O_NO_IO)) {
> +        perm |=3D BLK_PERM_CONSISTENT_READ;
> +    }
> +
> +    /*
> +     * This driver doesn't modify LUKS metadata except
> +     * when updating the encryption slots.
> +     * Thus unlike a proper format driver we don't ask for
> +     * shared write permission. However we need it
> +     * when we area updating keys, to ensure that only we
> +     * had opened the device r/w
> +     *
> +     * Encryption update will set the crypto->updating_keys
> +     * during that period and refresh permissions
> +     *
> +     */
> +
> +    if (crypto->updating_keys) {
> +        /*need exclusive write access for header update  */
> +        perm |=3D BLK_PERM_WRITE;
> +        shared &=3D ~(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE);
> +    }
> +
> +    bdrv_filter_default_perms(bs, c, role, reopen_queue,
> +            perm, shared, nperm, nshared);
> +}

This will probably work, but usually drivers do it the other way around:
First call any of the default_perms(), and then adjust *nperm and
*nshared as required.

(perm/shared are what the parents need, *nperm/*nshared is what this
driver needs, so it makes more sense that way; and this way nobody has
to check whether the settings survived the default_perms() call.)

((But the permissions themselves do look correct.))

Max


--MemsBdKijLAv3NxoNfQwSfMT0Nj4b3TfE--

--RoQBTW66M6aB0Wq27WZhC9VvC1g5fkdbz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2XklkACgkQ9AfbAGHV
z0BINQf9Hj21q3YV5h5AXWwK5ZiA+GOKZTQH4VgzKKobCy5YBlKEaKHHAeupbm2F
hTZgBMtlxHy6T2WWMSMj4G8ExtY/Gl4pmpQg2jKlx01ao6s4nHtnImpJZSsSvdyD
STaLExoYwA9EYu6Yup4JArKJ0/FvN6hdRxuMPA8Z40PTjjwGwNKb997uGZX7a9j4
cEjA6qSZ7/hdhxlxCuXurYe1B/ff899RMxmHUrHP6dSeGjFHnQo3w5GremUQg2KV
RyYXIqPkou/MfYeTfqbLgDOGFNXPJTpqvdKJ2f3Ws38We5svVU9JVVvOaqlb0khy
D2Bg2r9GAZ7C4klgPPivvz5fu3CRZQ==
=D+aH
-----END PGP SIGNATURE-----

--RoQBTW66M6aB0Wq27WZhC9VvC1g5fkdbz--

