Received: from eggs.gnu.org ([2001:4830:134:3::10]:50662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6KYi-0003Z5-Q8
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6KYh-0000W9-Q1
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:33:28 -0400
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9af8d25-4a6e-ec69-6b2e-129f1603e8a4@redhat.com>
Date: Wed, 11 Apr 2018 13:33:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180411163940.2523-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vxZOWlyPMGYPyi7rVo0kaEIV3Kc0eBeSK"
Subject: Re: [Qemu-devel] [PATCH 05/19] tests/test-bdrv-drain:
 bdrv_drain_all() works in coroutines now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vxZOWlyPMGYPyi7rVo0kaEIV3Kc0eBeSK
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <c9af8d25-4a6e-ec69-6b2e-129f1603e8a4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/19] tests/test-bdrv-drain:
 bdrv_drain_all() works in coroutines now
References: <20180411163940.2523-1-kwolf@redhat.com>
 <20180411163940.2523-6-kwolf@redhat.com>
In-Reply-To: <20180411163940.2523-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2018 11:39 AM, Kevin Wolf wrote:
> Since we use bdrv_do_drained_begin/end() for bdrv_drain_all_begin/end()=
,
> coroutine context is automatically left with a BH, preventing the
> deadlocks that made bdrv_drain_all*() unsafe in coroutine context. We
> can consider it compatible now the latest, after having removed the old=


s/the latest/at last/ ?

> polling code as dead code.
>=20
> Enable the coroutine test cases for bdrv_drain_all().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/test-bdrv-drain.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vxZOWlyPMGYPyi7rVo0kaEIV3Kc0eBeSK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrOVO4ACgkQp6FrSiUn
Q2rQjQgAjrvV6orLl5OB+eFEZhy5kCvWFNhXQqfwY11k1otIEyqxvFHp1ScVDSb+
uQ2CkncPs691sT5JUwvV2Lm+8KDFsuC98tC7Kp/p+RYZAaWUr+1Uo5QI3CMa0JPI
YD31kFGpMOZh4Mk1qklUg54GTRMoHd2d6XdpeCIqcmjnkbbGf4rlBnX/GPgUFrGG
ci/KqayQpXIfzFMmniDI0ZLA+eZ8EfI39/IPc8E7XI7bCvyqkD5dai3wlIPQ8Oi7
pxlvHZwnjtuOfdxq7YWvdl2PZslmVFFscFF72MUdvkeetiz6ioqA5CmBirLV3hLA
BOBbQoNyl9G82TF6kOevz7R3Cr8b8A==
=f0Ik
-----END PGP SIGNATURE-----

--vxZOWlyPMGYPyi7rVo0kaEIV3Kc0eBeSK--
