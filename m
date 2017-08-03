Received: from eggs.gnu.org ([2001:4830:134:3::10]:38925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddI1q-0002Ii-MK
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddI1p-0003Wi-NN
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:27:14 -0400
References: <20170803150301.10177-1-kwolf@redhat.com>
	<20170803150301.10177-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <21ccb7fc-22e1-f97c-1b41-b382e43fad22@redhat.com>
Date: Thu, 3 Aug 2017 10:27:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170803150301.10177-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gChMBX3xtW44BVNULJVNLDjxM2bpg4bpP"
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/5] block: Set BDRV_O_ALLOW_RDWR
 during rw reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gChMBX3xtW44BVNULJVNLDjxM2bpg4bpP
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <21ccb7fc-22e1-f97c-1b41-b382e43fad22@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/5] block: Set BDRV_O_ALLOW_RDWR
 during rw reopen
References: <20170803150301.10177-1-kwolf@redhat.com>
 <20170803150301.10177-4-kwolf@redhat.com>
In-Reply-To: <20170803150301.10177-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 10:02 AM, Kevin Wolf wrote:
> Reopening an image should be consistent with opening it, so we should
> set BDRV_O_ALLOW_RDWR for any image that is reopened read-write like in=

> bdrv_open_inherit().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gChMBX3xtW44BVNULJVNLDjxM2bpg4bpP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmDQMgACgkQp6FrSiUn
Q2o4hQf+POUXifr1Z7B0SSenI+CiOgG3RPvNw4HrA93hcgFwAHRhvkcAbLbUkwzH
12LhpyfrI1ctlfujGdcVpazowiAj+5+f0UNkfUkd29fqBJRwgQIAksS88KOnw2Vw
ybqg/Duhip2ksrcYNLAeRYSksshF5OqxyuUp95cHjYTAF21aIJW1DOhuQr+Jlow7
AIBwAc1dkkkD8jVZ+ya6B0w1dlr+QeG88yMnD4+HqaQ38cpZR2v43Q6glsrqKDpe
+90CmIjGaCkTUsG8EyeSeCTdQpgguTB0CnJEtZfy6b35TUzqcX+pKjw1Hy7/trHF
PoH042F3SKa5dIfPmX2nhcqUBZaWUA==
=qnGS
-----END PGP SIGNATURE-----

--gChMBX3xtW44BVNULJVNLDjxM2bpg4bpP--
