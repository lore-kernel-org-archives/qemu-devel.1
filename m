Received: from eggs.gnu.org ([2001:4830:134:3::10]:49324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eF2z6-0001NM-Qq
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eF2z5-0006iK-Md
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:04:28 -0500
References: <20171115180732.31753-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e26e9557-d3ad-e267-03fa-7fc06892bf08@redhat.com>
Date: Wed, 15 Nov 2017 13:04:19 -0600
MIME-Version: 1.0
In-Reply-To: <20171115180732.31753-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S7BUUTthbSujq0bFjKiH3OV1EPrnT1X3w"
Subject: Re: [Qemu-devel] [PATCH] iotests: Make 087 pass without AIO enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S7BUUTthbSujq0bFjKiH3OV1EPrnT1X3w
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <e26e9557-d3ad-e267-03fa-7fc06892bf08@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Make 087 pass without AIO enabled
References: <20171115180732.31753-1-mreitz@redhat.com>
In-Reply-To: <20171115180732.31753-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/15/2017 12:07 PM, Max Reitz wrote:
> If AIO has not been enabled in the qemu build that is to be tested, we
> should skip the "aio=3Dnative without O_DIRECT" test instead of failing=
=2E
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Cleber wanted to fix this in July with his "build configuration query
> tool and conditional (qemu-io)test skip" series
> (https://lists.gnu.org/archive/html/qemu-block/2017-07/msg01303.html),
> but unfortunately there hasn't been any activity on that (as far as I
> can see), so let's just solve it the simple way.
> ---
>  tests/qemu-iotests/087 | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Yep, that's about as simple as possible.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--S7BUUTthbSujq0bFjKiH3OV1EPrnT1X3w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloMj7MACgkQp6FrSiUn
Q2qBLQf9GUqyCIrVXl8bJWASvLPGbkPA30a3TtS9RygGDmGhFBdliTavtCF7IJQZ
KAHoXktqvtgzcfvr6/qRj0wFoJSDdizigLQYR1BIJbMmmzV8swakjUPKLUx+jCIE
C/gkKhxRtOBTpw0mkw905GkayRq8A4apK2sGQLM9a/lrdSS3TUEICk6O6hRTyZLy
U2d3rxEkPNo3S6iwBXJ0ySQfVBF1UXFJR/syNHHevVocqMDPTtkdAtKdP8mfhKd5
TzsxH1KaBxOq/ShEVIKQR7AUz2mTbkS+JfNYN5d0vzRIuN1WCml50WzsUi54WPsb
2glk+wHrbQHb5IB25NMh9/U1VBs4yQ==
=c3x5
-----END PGP SIGNATURE-----

--S7BUUTthbSujq0bFjKiH3OV1EPrnT1X3w--
