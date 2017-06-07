Received: from eggs.gnu.org ([2001:4830:134:3::10]:52424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIiqV-0001YS-If
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIiqS-0008Mq-GT
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:50:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dIiqS-0008Kv-7D
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:50:28 -0400
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
	<20170607074632.13162-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9bf29800-aecc-aeca-44d2-7a208fcc602f@redhat.com>
Date: Wed, 7 Jun 2017 16:50:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170607074632.13162-3-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w1WbIus9qPKVaI9ig0G3PIPWBO5M6Itqt"
Subject: Re: [Qemu-devel] [PATCH 2/5] coccinelle: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w1WbIus9qPKVaI9ig0G3PIPWBO5M6Itqt
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
Message-ID: <9bf29800-aecc-aeca-44d2-7a208fcc602f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] coccinelle: use DIV_ROUND_UP
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
 <20170607074632.13162-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170607074632.13162-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 02:46 AM, Marc-Andr=C3=A9 Lureau wrote:
> The coccinelle/round.cocci script doesn't catch hard coded values.
>=20
> I used the following script over qemu code base:
>=20
> (
> - ((e1) + 3) / (4)
> + DIV_ROUND_UP(e1,4)

As in 1/5, can't you also write a search for ((e1) + (e2) - 1) / e2, to
cover non-constant divisions?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--w1WbIus9qPKVaI9ig0G3PIPWBO5M6Itqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOHUfAAoJEKeha0olJ0Nqs1oH/2fW1p7pAzG/TgfI+QtE89oW
y+qM2gG4u3Mqle2El3R0jKJNm+ESCRfqzAK3azAWEYvZGkQmpe9JspbJOLL+FpLF
fXuYog/RrgXOB5nNARi56PBO6AvWDWnQj4YWW3dZcgV8eQc+t6w8coesxlYWKkSZ
23T2n7FWqbfI9/V32MtxPZepdHPXuD9h7zKpMDPKyg6ywl5xD2x0e7ARgvezz5so
K9qsmXnEsvAklhsWNtoywxzB3FkVHbMxsQOYIekSfTmt26Zcqz9zThZ2PTjpXK9Q
/GvmLEB5nfJ5aVT4KxhP/yWdiNN0hquHzjnQhdlwiZrUMboacU4J0sqBWuKZwO8=
=+2xu
-----END PGP SIGNATURE-----

--w1WbIus9qPKVaI9ig0G3PIPWBO5M6Itqt--
