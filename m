Received: from eggs.gnu.org ([209.51.188.92]:49816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlVH-00037k-Hx
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlVG-0001ei-RB
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:22:15 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-15-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b0d316c-0113-9a0f-2d5b-bbd429eae7bb@redhat.com>
Date: Thu, 7 Feb 2019 09:21:53 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-15-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uB5xZfZcYKK5boFa87iuVaZH79UHXtOqA"
Subject: Re: [Qemu-devel] [PATCH v3 14/17] tests/test-bdrv-drain: use
 QEMU_IOVEC_INIT_BUF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uB5xZfZcYKK5boFa87iuVaZH79UHXtOqA
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <4b0d316c-0113-9a0f-2d5b-bbd429eae7bb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 14/17] tests/test-bdrv-drain: use
 QEMU_IOVEC_INIT_BUF
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-15-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-15-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new QEMU_IOVEC_INIT_BUF() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/test-bdrv-drain.c | 29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--uB5xZfZcYKK5boFa87iuVaZH79UHXtOqA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcTRIACgkQp6FrSiUn
Q2ortAf/XOKa1vx8XnUryBjOxPA/FbScwUMCzWIXmK9z/AZdB3SnWsv3Ux7GcWdc
xfMA81VxEr1xuAvdF7/FtxCuNGE+ZlyFB4IdfZ+X8pwsdQhDh++AwxcPRPLNaPgS
jjG1/EzJMy+rzZTR4ij+A4eL4s57ssX9qmeBYmVhFhl/GUegtc+TelmlMwSHQppV
xUfMOAJA9w5cviVwZPmmJfhjoNfSmiBn/PT2Ytww6r0m81UIw0oP/8DX/W5Ga1so
oTytJppJ8OqBIyJ2gaxUobOwLzUbR/COZF61VmrnmVIcmH4pkqqDNeLAcnrTF8KR
VDKfD7o0ETbHMC4OdMDQrvK1lw0geg==
=O0qA
-----END PGP SIGNATURE-----

--uB5xZfZcYKK5boFa87iuVaZH79UHXtOqA--
