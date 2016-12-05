Received: from eggs.gnu.org ([2001:4830:134:3::10]:58403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDyk3-0000Gd-7n
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 14:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDyjz-0006eC-94
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 14:15:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cDyjz-0006dp-0l
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 14:15:55 -0500
References: <1480928380-161760-1-git-send-email-longpeng2@huawei.com>
	<1480928380-161760-2-git-send-email-longpeng2@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <50e11e16-6378-8ce0-241a-252272f5b99a@redhat.com>
Date: Mon, 5 Dec 2016 13:15:48 -0600
MIME-Version: 1.0
In-Reply-To: <1480928380-161760-2-git-send-email-longpeng2@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jM1Hnh2nObqUO2p6Ut9EuWMRuifduWEu5"
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/3] crypto: add standard des
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, berrange@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, wu.wubin@huawei.com, jianjay.zhou@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jM1Hnh2nObqUO2p6Ut9EuWMRuifduWEu5
From: Eric Blake <eblake@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, berrange@redhat.com,
 armbru@redhat.com, arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, wu.wubin@huawei.com, jianjay.zhou@huawei.com
Message-ID: <50e11e16-6378-8ce0-241a-252272f5b99a@redhat.com>
Subject: Re: [PATCH for-2.9 1/3] crypto: add standard des support
References: <1480928380-161760-1-git-send-email-longpeng2@huawei.com>
 <1480928380-161760-2-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1480928380-161760-2-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2016 02:59 AM, Longpeng(Mike) wrote:
> This patch add standart DES support.

s/standart/standard/

>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---

> +++ b/qapi/crypto.json
> @@ -75,7 +75,7 @@
>  { 'enum': 'QCryptoCipherAlgorithm',
>    'prefix': 'QCRYPTO_CIPHER_ALG',
>    'data': ['aes-128', 'aes-192', 'aes-256',
> -           'des-rfb',
> +           'des-rfb', 'des',

Missing documentation that includes a (since 2.9) blurb

>             'cast5-128',
>             'serpent-128', 'serpent-192', 'serpent-256',
>             'twofish-128', 'twofish-192', 'twofish-256']}
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--jM1Hnh2nObqUO2p6Ut9EuWMRuifduWEu5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRbzkAAoJEKeha0olJ0Nq8ecH/1uVxt9ymZds7AqR8S8gZYSP
ZaKVNxEJtdfEXJewzt6wszKJn9LS9RRFvyZggPtWEeoER0gh/gXAjLxA0LMDCQ6c
PTEHkxkpXs5M+1LP33iKzQiRleMyZ2Vzv2sRwyVVqU9ZFFouJsFZQPkDAsF55PYG
n0eFXn6Grmt+zPJdYPu1UoNcobKHPwnr5ualyXiTIKj+6t5nw3NFoP8Uob1QQI/t
O2+nlu2Ys4Wq3188vFY/2o+RZfpAOomI0YqMPUylqWkbKSefBuZ8Ow7ur6dRomkY
c3DYciknQJUWKicGzI/jtBsvFAFJS+RXkZxV946Z5mpETa20Y79I7tqh2vkLH4w=
=NR8Q
-----END PGP SIGNATURE-----

--jM1Hnh2nObqUO2p6Ut9EuWMRuifduWEu5--
