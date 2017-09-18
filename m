Received: from eggs.gnu.org ([2001:4830:134:3::10]:38687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du36D-0002Yo-VZ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 16:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du36D-0008LL-0k
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 16:57:02 -0400
References: <20170918202529.28379-1-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5d1bdb68-4c64-b211-6090-348d61f7f8e9@redhat.com>
Date: Mon, 18 Sep 2017 15:56:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170918202529.28379-1-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EtiWW0mcQTWWBj038OHvm5tKuOhM2deMF"
Subject: Re: [Qemu-devel] [PATCH] block/throttle-groups.c: allocate
 RestartData on the heap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EtiWW0mcQTWWBj038OHvm5tKuOhM2deMF
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <5d1bdb68-4c64-b211-6090-348d61f7f8e9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/throttle-groups.c: allocate
 RestartData on the heap
References: <20170918202529.28379-1-el13635@mail.ntua.gr>
In-Reply-To: <20170918202529.28379-1-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 03:25 PM, Manos Pitsidianakis wrote:
> RestartData is the opaque data of the throttle_group_restart_queue_entr=
y
> coroutine. By being stack allocated, it isn't available anymore if
> aio_co_enter schedules the coroutine with a bottom halve and runs after=


s/halve/half/

> throttle_group_restart_queue returns.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/throttle-groups.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EtiWW0mcQTWWBj038OHvm5tKuOhM2deMF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnAMxQACgkQp6FrSiUn
Q2q41Af+Irf3aFWnkZGD7FaSRDge0A13J+l2Iainw+WhWRfWxkbdZvgds7el+COq
A+4Qxs73CKHzrEZSJmSZACFF4W9thN3Di5lN4pqdXh/tqQYlQXWex7WA7mcvkbEW
zfVn+k/fubgjl+VhfA/viywZ2Pohde6+s6z0A5Pj3eXyWGPWWb7vYEq6FAAiCOl+
JtRR8fYCD4nndughq5YzxY+qRPixsiVSCX7Hp3euEOR4inAzeUkwtrUbyEJvKJe+
MOvYmbXy/ffDva5qh8+4020Fa2bYOqq78daw06ofp1s0OHcgutJTFH1tlS0m1npF
XukzqCHFAaVJax4tfGEBelrLx5eEnA==
=3dHu
-----END PGP SIGNATURE-----

--EtiWW0mcQTWWBj038OHvm5tKuOhM2deMF--
