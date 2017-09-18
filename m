Received: from eggs.gnu.org ([2001:4830:134:3::10]:36446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwWy-0007f7-UV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwWy-0007Q9-3o
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:56:13 -0400
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cc9d51c6-ba58-9cb1-c4c4-4c67f5e055c4@redhat.com>
Date: Mon, 18 Sep 2017 08:56:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170912112855.24269-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Fsr8MKO3E7AQ7dUNHpADdSTIha30CwaJQ"
Subject: Re: [Qemu-devel] [PATCH v3 3/7] block: fix data type casting for
 crypto payload offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fsr8MKO3E7AQ7dUNHpADdSTIha30CwaJQ
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <cc9d51c6-ba58-9cb1-c4c4-4c67f5e055c4@redhat.com>
Subject: Re: [PATCH v3 3/7] block: fix data type casting for crypto payload
 offset
References: <20170912112855.24269-1-berrange@redhat.com>
 <20170912112855.24269-4-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 06:28 AM, Daniel P. Berrange wrote:
> The crypto APIs report the offset of the data payload as an uint64_t
> type, but the block driver is casting to size_t or ssize_t which will
> potentially truncate.
>=20
> Most of the block APIs use int64_t for offsets meanwhile, so even if
> using uint64_t in the crypto block driver we are still at risk of
> truncation.
>=20
> Change the block crypto driver to use uint64_t, but add asserts that
> the value is less than INT64_MAX.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Fsr8MKO3E7AQ7dUNHpADdSTIha30CwaJQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/0HQACgkQp6FrSiUn
Q2qDbAf/emvNJMSyAZe8NAFIsQ4PLBGRM61TPgk50i3hHVqm19vr4GlIdjusZXWe
onrGB2HpJH3JfrSpKbUzvLgLT+qbS6nTQNgWSWKnFS4jau6lThfw3XfurfSYpyoS
JzJxCl04AZ831RRCXXjefy7y0lSZNkqvqChmD5IJllAoTCVHVCeNCfsvJcAazxFk
zCh9CsOjwnnnwgMEbdN7+90eFs0iziHjyDReL3hkn1rE1UZC63hqRaFDIW+rUqdt
WXHMcI9F4JAnbMtwDer0PYeNmGP6LoxXrgyZo2VLrAreZOhYSHA4eRTRhwd2FjK5
Gbm/a9XTnXUVL4VcCYCApbfZpamUJw==
=CI9M
-----END PGP SIGNATURE-----

--Fsr8MKO3E7AQ7dUNHpADdSTIha30CwaJQ--
