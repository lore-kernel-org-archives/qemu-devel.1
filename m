Received: from eggs.gnu.org ([2001:4830:134:3::10]:53832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cF0su-0005GZ-Br
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cF0sr-0004bI-A8
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:45:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cF0sr-0004b9-1p
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:45:21 -0500
References: <1481164408-194252-1-git-send-email-longpeng2@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e88d4b8b-651d-4821-517a-a8201750bafb@redhat.com>
Date: Thu, 8 Dec 2016 09:45:13 -0600
MIME-Version: 1.0
In-Reply-To: <1481164408-194252-1-git-send-email-longpeng2@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s39bXxptWgLio8a6sBi57pHC357rMg1i2"
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] crypto: add 3des-ede support
 when using libgcrypt/nettle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, berrange@redhat.com, armbru@redhat.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s39bXxptWgLio8a6sBi57pHC357rMg1i2
From: Eric Blake <eblake@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, berrange@redhat.com,
 armbru@redhat.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com,
 qemu-devel@nongnu.org
Message-ID: <e88d4b8b-651d-4821-517a-a8201750bafb@redhat.com>
Subject: Re: [PATCH for-2.9 v2] crypto: add 3des-ede support when using
 libgcrypt/nettle
References: <1481164408-194252-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481164408-194252-1-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2016 08:33 PM, Longpeng(Mike) wrote:
> Libgcrypt and nettle support 3des-ede, so this patch add 3des-ede
> support when using libgcrypt or nettle.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---

> +++ b/qapi/crypto.json
> @@ -63,6 +63,7 @@
>  # @aes-192: AES with 192 bit / 24 byte keys
>  # @aes-256: AES with 256 bit / 32 byte keys
>  # @des-rfb: RFB specific variant of single DES. Do not use except in V=
NC.
> +# @3des: 3DES(EDE) with 192 bit / 24 byte keys (since 2.9)
>  # @cast5-128: Cast5 with 128 bit / 16 byte keys
>  # @serpent-128: Serpent with 128 bit / 16 byte keys
>  # @serpent-192: Serpent with 192 bit / 24 byte keys
> @@ -75,7 +76,7 @@
>  { 'enum': 'QCryptoCipherAlgorithm',
>    'prefix': 'QCRYPTO_CIPHER_ALG',
>    'data': ['aes-128', 'aes-192', 'aes-256',
> -           'des-rfb',
> +           'des-rfb', '3des',

Not your fault that this is yet another enum name that is not a valid C
identifier. QAPI at least handles it when referring to the enum constant
(since we already have other such enums, in describing key codes), but
it might make it awkward if we later want to use the enum type as a
discriminator of a flat union (where I'm not sure that QAPI will still
do the right thing).  Is there some name we can pick that starts with a
letter, to reduce the worry?  But if not, I can live with '3des'.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--s39bXxptWgLio8a6sBi57pHC357rMg1i2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSYAJAAoJEKeha0olJ0Nq7wsH/0BiOQvWVEu/utZ677Jo5omk
a4DWb1WPuxFFuAfqggaH/leEOYo4sp1U2AFI10PbK0/SHdpo4Nl/uFdsk0ZVyWgN
Pbj9guneUtrhI2URZaTeySXitBDQCQIFflkjG9Us0kQvuwH4NvxDKf8o39a1mOk/
iFKgCBQ5joG3K8ICODx8Hsg63JkycLOtEjgvcLGvSy5s+GaxVwtCBeSXi/SOd+O6
IQZOrowrR3YaKDuH+UbMD8tL9tyzZBouFTPTQTvg6FOH0knbDPyhjDyBKDjVg+hZ
z1Nus2wN8OuXlm9pL8MJYwKW3PMPnrdCECYwCW6CBLUGxl9HasHIz3AcCkzu/Sc=
=6H/7
-----END PGP SIGNATURE-----

--s39bXxptWgLio8a6sBi57pHC357rMg1i2--
