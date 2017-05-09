Received: from eggs.gnu.org ([2001:4830:134:3::10]:38109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d88s0-0007A6-1W
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d88rw-0004VP-Ul
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:24:20 -0400
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-4-f4bug@amsat.org>
	<2ad7eaf6-3691-f9f1-4d09-204444adbd19@redhat.com>
	<5b9ad5c0-0bcf-2167-57ba-446d1253cdd1@amsat.org>
	<bdc0fa6a-a90c-3f7a-a37c-bc901a6022c2@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4cb5814d-d8bb-db4f-3c85-9ef245534f33@redhat.com>
Date: Tue, 9 May 2017 12:24:13 -0500
MIME-Version: 1.0
In-Reply-To: <bdc0fa6a-a90c-3f7a-a37c-bc901a6022c2@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0MRsv8liP4MaKb0iC1rWc503euCCWmk3d"
Subject: Re: [Qemu-devel] [PATCH 03/11] hw/misc: add missing includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0MRsv8liP4MaKb0iC1rWc503euCCWmk3d
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <4cb5814d-d8bb-db4f-3c85-9ef245534f33@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/11] hw/misc: add missing includes
References: <20170508233918.9043-1-f4bug@amsat.org>
 <20170508233918.9043-4-f4bug@amsat.org>
 <2ad7eaf6-3691-f9f1-4d09-204444adbd19@redhat.com>
 <5b9ad5c0-0bcf-2167-57ba-446d1253cdd1@amsat.org>
 <bdc0fa6a-a90c-3f7a-a37c-bc901a6022c2@amsat.org>
In-Reply-To: <bdc0fa6a-a90c-3f7a-a37c-bc901a6022c2@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 12:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:

> What about the other include, "hw/sysbus.h"?
> The inlined function create_unimplemented_device() calls
> sysbus_mmio_map_overlap(). Anyone willing to use "hw/misc/unimp.h" will=

> get a compilation failure if he does not include "hw/sysbus.h" and I
> don't think it belongs to "qemu/osdep.h".

That one's probably okay.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0MRsv8liP4MaKb0iC1rWc503euCCWmk3d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEfs9AAoJEKeha0olJ0Nq5k8IAIu4QdrYdh+3WbH/YkQ9J7is
s3LOwCuFydYRyl+ddnP7+yTEgeCiE8wbE1sPaMJC5JieBbIQzcohDy1hg3MGuPEy
0y+nB8TRIbh7bsq+Zb0bk5aj1yM7wAL7aN81Vs1SQXz0b9YCK6IN2k8Y1vHUC/zs
d8hhLaRi0NYBXGrr60qHK+eGTn47nY0JWu3ZTjYzWQjBWeqxAu4gr/k6zTZfx7qu
mvP0bdx1YMZ/H0qjwoto8OUrTqCbwj38xfs9k+SjRwthW0wTskRDIxQ2X4O9YXMm
zcxfCOx5ZW3YUZ7I/H8ig1Vj4Pnp4+bLPr0+4lh622C37cT8hEnZGtxUPetBuO0=
=wtYw
-----END PGP SIGNATURE-----

--0MRsv8liP4MaKb0iC1rWc503euCCWmk3d--
