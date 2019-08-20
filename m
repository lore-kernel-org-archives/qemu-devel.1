Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D247BC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BD322DA7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BD322DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i084m-0003Br-Qv
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 13:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i0845-0002g0-3c
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i0843-00071y-CL
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:37:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i083y-0006zP-Qi; Tue, 20 Aug 2019 13:36:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C70D410C0316;
 Tue, 20 Aug 2019 17:36:53 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49E5127CCD;
 Tue, 20 Aug 2019 17:36:49 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-3-mlevitsk@redhat.com>
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
Message-ID: <4d242249-f823-7465-4b31-64fce484679f@redhat.com>
Date: Tue, 20 Aug 2019 19:36:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814202219.1870-3-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cURnaqahWlZMbiekiApkvBgwKo6URXHsL"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 20 Aug 2019 17:36:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/13] qcrypto-luks: misc refactoring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cURnaqahWlZMbiekiApkvBgwKo6URXHsL
Content-Type: multipart/mixed; boundary="R1gzTPmd3H1VIwUBqFyOY3lpfLiKj1fmQ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>
Message-ID: <4d242249-f823-7465-4b31-64fce484679f@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: misc refactoring
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-3-mlevitsk@redhat.com>
In-Reply-To: <20190814202219.1870-3-mlevitsk@redhat.com>

--R1gzTPmd3H1VIwUBqFyOY3lpfLiKj1fmQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.08.19 22:22, Maxim Levitsky wrote:
> This is also a preparation for key read/write/erase functions
>=20
> * use master key len from the header
> * prefer to use crypto params in the QCryptoBlockLUKS
>   over passing them as function arguments
> * define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME
> * Add comments to various crypto parameters in the QCryptoBlockLUKS
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 213 ++++++++++++++++++++++----------------------=

>  1 file changed, 105 insertions(+), 108 deletions(-)
>=20
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 409ab50f20..48213abde7 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c

[...]

> @@ -199,13 +201,25 @@ QEMU_BUILD_BUG_ON(sizeof(struct QCryptoBlockLUKSH=
eader) !=3D 592);
>  struct QCryptoBlockLUKS {
>      QCryptoBlockLUKSHeader header;
> =20
> -    /* Cache parsed versions of what's in header fields,
> -     * as we can't rely on QCryptoBlock.cipher being
> -     * non-NULL */

Hm, why remove this comment?

> +    /* Main encryption algorithm used for encryption*/
>      QCryptoCipherAlgorithm cipher_alg;
> +
> +    /* Mode of encryption for the selected encryption algorithm */
>      QCryptoCipherMode cipher_mode;
> +
> +    /* Initialization vector generation algorithm */
>      QCryptoIVGenAlgorithm ivgen_alg;
> +
> +    /* Hash algorithm used for IV generation*/
>      QCryptoHashAlgorithm ivgen_hash_alg;
> +
> +    /*
> +     * Encryption algorithm used for IV generation.
> +     * Usually the same as main encryption algorithm
> +     */
> +    QCryptoCipherAlgorithm ivgen_cipher_alg;
> +
> +    /* Hash algorithm used in pbkdf2 function */
>      QCryptoHashAlgorithm hash_alg;
>  };
> =20
> @@ -397,6 +411,12 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgor=
ithm cipher,
>      }
>  }
> =20
> +static int masterkeylen(QCryptoBlockLUKS *luks)

This should be a const pointer.

> +{
> +    return luks->header.key_bytes;
> +}
> +
> +
>  /*
>   * Given a key slot, and user password, this will attempt to unlock
>   * the master encryption key from the key slot.
> @@ -410,21 +430,15 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgo=
rithm cipher,
>   */
>  static int
>  qcrypto_block_luks_load_key(QCryptoBlock *block,
> -                            QCryptoBlockLUKSKeySlot *slot,
> +                            uint slot_idx,

Did you use uint on purpose or do you mean a plain =E2=80=9Cunsigned=E2=80=
=9D?

>                              const char *password,
> -                            QCryptoCipherAlgorithm cipheralg,
> -                            QCryptoCipherMode ciphermode,
> -                            QCryptoHashAlgorithm hash,
> -                            QCryptoIVGenAlgorithm ivalg,
> -                            QCryptoCipherAlgorithm ivcipheralg,
> -                            QCryptoHashAlgorithm ivhash,
>                              uint8_t *masterkey,
> -                            size_t masterkeylen,
>                              QCryptoBlockReadFunc readfunc,
>                              void *opaque,
>                              Error **errp)
>  {
>      QCryptoBlockLUKS *luks =3D block->opaque;
> +    QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[slot_idx=
];

I think this is a great opportunity to make this a const pointer.

>      uint8_t *splitkey;
>      size_t splitkeylen;
>      uint8_t *possiblekey;

[...]

> @@ -710,6 +696,8 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>          goto fail;
>      }
> =20
> +    cipher_mode =3D g_strdup(luks->header.cipher_mode);
> +

This should be freed under the fail label.

(And maybe the fact that this no longer modifies
luks->header.cipher_mode should be mentioned in the commit message, I
don=E2=80=99t know.)

>      /*
>       * The cipher_mode header contains a string that we have
>       * to further parse, of the format

[...]

> @@ -730,13 +718,13 @@ qcrypto_block_luks_open(QCryptoBlock *block,
> =20
>      ivhash_name =3D strchr(ivgen_name, ':');
>      if (!ivhash_name) {
> -        ivhash =3D 0;
> +        luks->ivgen_hash_alg =3D 0;

*luks is initialized to 0 anyway, but it doesn=E2=80=99t hurt, of course.=


>      } else {
>          *ivhash_name =3D '\0';
>          ivhash_name++;
> =20
> -        ivhash =3D qcrypto_block_luks_hash_name_lookup(ivhash_name,
> -                                                     &local_err);
> +        luks->ivgen_hash_alg =3D qcrypto_block_luks_hash_name_lookup(i=
vhash_name,
> +                                                                   &lo=
cal_err);
>          if (local_err) {
>              ret =3D -ENOTSUP;
>              error_propagate(errp, local_err);
> @@ -744,25 +732,27 @@ qcrypto_block_luks_open(QCryptoBlock *block,

[...]

> =20
> -    hash =3D qcrypto_block_luks_hash_name_lookup(luks->header.hash_spe=
c,
> +    luks->hash_alg =3D
> +            qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec=
,
>                                                 &local_err);

Indentation is off now.

>      if (local_err) {
>          ret =3D -ENOTSUP;

[...]

> @@ -930,6 +922,17 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>              luks_opts.has_ivgen_hash_alg =3D true;
>          }
>      }
> +
> +    luks =3D g_new0(QCryptoBlockLUKS, 1);
> +    block->opaque =3D luks;
> +
> +    luks->cipher_alg =3D luks_opts.cipher_alg;
> +    luks->cipher_mode =3D luks_opts.cipher_mode;
> +    luks->ivgen_alg =3D luks_opts.ivgen_alg;
> +    luks->ivgen_hash_alg =3D luks_opts.ivgen_hash_alg;
> +    luks->hash_alg =3D luks_opts.hash_alg;
> +
> +

Why did you pull this up?  Now @luks is leaked in both of the next error
paths.

>      /* Note we're allowing ivgen_hash_alg to be set even for
>       * non-essiv iv generators that don't need a hash. It will
>       * be silently ignored, for compatibility with dm-crypt */

[...]

> @@ -1003,6 +1004,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>          ivcipheralg =3D luks_opts.cipher_alg;
>      }
> =20
> +    luks->ivgen_cipher_alg =3D ivcipheralg;
> +

What=E2=80=99s the point in having a dedicated ivcipheralg variable then?=


Max

>      strcpy(luks->header.cipher_name, cipher_alg);
>      strcpy(luks->header.cipher_mode, cipher_mode_spec);
>      strcpy(luks->header.hash_spec, hash_alg);


--R1gzTPmd3H1VIwUBqFyOY3lpfLiKj1fmQ--

--cURnaqahWlZMbiekiApkvBgwKo6URXHsL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1cL68ACgkQ9AfbAGHV
z0A5fggAkC4Cbs02xDuzTfpwoVY9DVQHv0eDpC5kNLl1qNDRoclNuoq8VCSN6vHJ
afhWCtTeuqGjJrfArkENjyE4Ja5LiP+er94DWntDRUJAELCfnH+ZMSETxUlEK8oS
FLZFDIYYY2HO10nFkT9M30IHNDFKw1iscU7rWWacQlycxvWErcUOWg1sltAwlJJm
tGT0THXMmXj2LiX4NKC/4Y/dRG1bOQ/nTRYKgpAwhDYZJqZe3cNomIdEN8nD8QEc
PqePTA2peu5ylybxWYBvUEJepmIZxq58POT2ljcpNJxenCBwhUpfN+lk48TOVrJT
tp+zctJU3e2Ovm5OrvWxJ6lAyb6ywg==
=M7CC
-----END PGP SIGNATURE-----

--cURnaqahWlZMbiekiApkvBgwKo6URXHsL--

