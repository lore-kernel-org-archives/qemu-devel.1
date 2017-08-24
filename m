Received: from eggs.gnu.org ([2001:4830:134:3::10]:46635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkuQn-0001cE-09
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkuQm-0001bs-3f
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:52:29 -0400
References: <20170824153345.2244-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <440320ce-5bd1-bb3d-fedd-2e2ed00f1f19@redhat.com>
Date: Thu, 24 Aug 2017 10:52:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170824153345.2244-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vlXXvhCw04cJHRUfgOn08LARarmxXtS5U"
Subject: Re: [Qemu-devel] [PATCH 0/3] nbd-client: enter read_reply_co during
 init to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vlXXvhCw04cJHRUfgOn08LARarmxXtS5U
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <440320ce-5bd1-bb3d-fedd-2e2ed00f1f19@redhat.com>
Subject: Re: [PATCH 0/3] nbd-client: enter read_reply_co during init to avoid
 crash
References: <20170824153345.2244-1-stefanha@redhat.com>
In-Reply-To: <20170824153345.2244-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 10:33 AM, Stefan Hajnoczi wrote:
> See Patch 1 for the segfault fix.  Patches 2 & 3 add qemu-iotests cover=
age.
>=20
> This is a rare crash that we'll probably only see in testing.  It only =
seems to
> happen with UNIX domain sockets.

Rare enough that I don't think it is 2.10-rc4 material.  I'll review,
and if I don't find anything needing a respin, I'll add it to my NBD
queue for 2.11.

>=20
> Stefan Hajnoczi (3):
>   nbd-client: enter read_reply_co during init to avoid crash
>   qemu-iotests: improve nbd-fault-injector.py startup protocol
>   qemu-iotests: test NBD over UNIX domain sockets in 083
>=20
>  block/nbd-client.c                       |   2 +-
>  tests/qemu-iotests/083                   | 138 ++++++++++++++++++-----=
------
>  tests/qemu-iotests/083.out               | 145 +++++++++++++++++++++++=
++++----
>  tests/qemu-iotests/common.filter         |   4 +-
>  tests/qemu-iotests/nbd-fault-injector.py |   4 +
>  5 files changed, 220 insertions(+), 73 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vlXXvhCw04cJHRUfgOn08LARarmxXtS5U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlme9jIACgkQp6FrSiUn
Q2qoaggAl8gEmMaun7iKui8mBndVxcw7cAhXzaEwOMwpRoi2+J8hi6wbIo+oTIiC
3wZ26qV/1W/qchDPk71k1l1CHoyxqIuYcRs1IkxU3vPBv09xQ+oCX33as0lHAjKg
hl4gdMZ7CLfosWIxitmXCTyr9SibRhMK7wsq98pNAjnYB+aSx2yj7InrvtnitikN
Rf7wSMhU7/Ug+xO11QtAvqTL16X+oLa/G24AGidFde3oKOI8rtTSjTEaxn/wRAlc
zc3kO70cfoa1TeBPYDtrcOGu6As5VMx/ZawHkeGVBcBorrg4Y6tCKRhqUu3QI1SK
hM5sIoTlky/TlptFYVVLn8SVxNvIew==
=c3VC
-----END PGP SIGNATURE-----

--vlXXvhCw04cJHRUfgOn08LARarmxXtS5U--
