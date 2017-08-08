Received: from eggs.gnu.org ([2001:4830:134:3::10]:52927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfB9N-0005TC-9o
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfB9M-0003EX-3m
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:30:49 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-4-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <45a96c91-8261-d1f7-e312-3d872051e7d8@redhat.com>
Date: Tue, 8 Aug 2017 15:30:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170808183306.27474-4-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="30vMa2b7ukLhjeltuvkxL9Q4KkmggvH5k"
Subject: Re: [Qemu-devel] [PATCH 3/9] IDE: add tracing for data ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--30vMa2b7ukLhjeltuvkxL9Q4KkmggvH5k
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <45a96c91-8261-d1f7-e312-3d872051e7d8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/9] IDE: add tracing for data ports
References: <20170808183306.27474-1-jsnow@redhat.com>
 <20170808183306.27474-4-jsnow@redhat.com>
In-Reply-To: <20170808183306.27474-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 01:33 PM, John Snow wrote:
> To be used sparingly, but still interesting in the case of small
> firmwares designed to reproduce bugs in QEMU IDE.

Is that because the trace would fire so frequently in normal usage that
it will drown the user in noise?

>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--30vMa2b7ukLhjeltuvkxL9Q4KkmggvH5k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKH2YACgkQp6FrSiUn
Q2p9hgf/cU/9VSFy6405t7V9JuKL0PTr0RBoH+EM/z+3/1Gnn8s1ncTzjdZOqOK0
mPrp0N+B6P7ErVcBmCO+FQGyYcm4kIVTrGz/EhbQcTgdicW9hn0/GEPc2nTVSW49
n3zKr2Dv/Ts8GC+x/9+Sje/ZVHjhybcTN0pm4fxNUe40u0NpTDw/nJ5BfxNY5eQ7
z8TUw0CMBY2C8KnQHg7N2qAg8hlqIJSBFYdJiVkcGFfyb0hOaAzGdA9/Ej+BqKqA
MFNaWZukT5GD0bv5FNkWGPsgSQQK2/ETlV4I39PGSY13DJzBie9+kobHc2HBvhO9
YBRQ22KrN/Y8Zk79Lrplt1ItP0hs6g==
=kGnY
-----END PGP SIGNATURE-----

--30vMa2b7ukLhjeltuvkxL9Q4KkmggvH5k--
