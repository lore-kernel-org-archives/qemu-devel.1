Received: from eggs.gnu.org ([2001:4830:134:3::10]:35783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxCfx-0003Gj-9R
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxCfr-0005KA-RI
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:46:57 -0400
References: <20170927125340.12360-1-berrange@redhat.com>
	<20170927125340.12360-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2d2ea15-ffbd-a05c-225d-6a2345240227@redhat.com>
Date: Wed, 27 Sep 2017 08:46:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170927125340.12360-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Fh3UP5TR1J4wALfpnJWWlvocTBAIlosLt"
Subject: Re: [Qemu-devel] [PATCH v4 5/6] block: convert
 qcrypto_block_encrypt|decrypt to take bytes offset
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
--Fh3UP5TR1J4wALfpnJWWlvocTBAIlosLt
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <f2d2ea15-ffbd-a05c-225d-6a2345240227@redhat.com>
Subject: Re: [PATCH v4 5/6] block: convert qcrypto_block_encrypt|decrypt to
 take bytes offset
References: <20170927125340.12360-1-berrange@redhat.com>
 <20170927125340.12360-6-berrange@redhat.com>
In-Reply-To: <20170927125340.12360-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2017 07:53 AM, Daniel P. Berrange wrote:
> Instead of sector offset, take the bytes offset when encrypting
> or decrypting data.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Fh3UP5TR1J4wALfpnJWWlvocTBAIlosLt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnLq8MACgkQp6FrSiUn
Q2qkeggAi94fr3tW8W0XgYG+EVe0Uk5EAkjKXM4+p58U1z6SAQZmbnac/Ge5kwsX
oDW7Iqqc5GPGuNcFi1C9I/py2WilfyMN7oR6ZfeLDiwVtuevQJYZum6BCyl7TX9L
iTj9rM5E5d9KPtFNDDVOyC3/IYvARpOXuDCCc8dmgWdZt3oVxYGuNTh3p+uyW4aW
hCu1fCaGBv9z/rXFLvzfQ89yFfeX9a8LKCCI87qx393pH9qLZtXOz54NCyVBeiKy
KANkDDuFBpCsD6I5upNOSL4ZVRwCGFj4UHWYHbCRt87DWe5Df1Cdqe00hPhvOSi0
Ej/l9uiPZZor5RaeOh0sg1gCeQEk8A==
=y5MT
-----END PGP SIGNATURE-----

--Fh3UP5TR1J4wALfpnJWWlvocTBAIlosLt--
