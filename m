Received: from eggs.gnu.org ([2001:4830:134:3::10]:48443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIiVS-0002MS-1M
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIiVO-0000Lj-QO
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:28:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dIiVO-0000LT-I4
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:28:42 -0400
References: <20170607184921.28407-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09672a3e-0ab8-18f5-7b1b-24f48b967490@redhat.com>
Date: Wed, 7 Jun 2017 16:28:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170607184921.28407-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g9Jl5BjBPNXA9WFlmJUb1EohE8O0aUWt6"
Subject: Re: [Qemu-devel] [PATCH 0/3] char: fix chardev aliases regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g9Jl5BjBPNXA9WFlmJUb1EohE8O0aUWt6
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, pbonzini@redhat.com
Message-ID: <09672a3e-0ab8-18f5-7b1b-24f48b967490@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] char: fix chardev aliases regression
References: <20170607184921.28407-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170607184921.28407-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 01:49 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> The patch "char: move CharBackend handling in char-fe unit" broke
> chardev aliases. Here is a small series to fix it, and add a simple
> unit test to check the alias keep working.
>=20
> Marc-Andr=C3=A9 Lureau (3):
>   char: fix alias devices regression
>   chardev: don't use alias names in parse_compat()
>   test-char: start a /char/serial test
>=20
>  chardev/char.c    |  6 ++++--
>  tests/test-char.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--g9Jl5BjBPNXA9WFlmJUb1EohE8O0aUWt6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOHAFAAoJEKeha0olJ0NqrxAH/A7MQ2C6ksSiqnyZuP3V47xF
hX+1vwbxepbIf+zYTtVN63pgnryRdzLBJ9fujvYQje9O9c960+/BDdt5surti3iG
8ANImSB+RT97/Iih3SQjiqDkVX7IhNs7qe/VXy/RNwHDJN4TXYd4thhEYLo1TdoO
0KMbTrsk1AKH9QPk+iS243R6m4S+qiPGCZ0Pfid9X4XDj2SXRS5i0/iSyv5hRjOV
wKa04re/kdBe7GNX8HuSmsmgx78VaqzXOlKGCXhbmHtgVo7LjrFGUkyuNiLZTfz9
ZW4rvHO0XtlhBlKEpN7ZXgFYPZ/OMEKu8Jnse43izO5wIMMThMSccGcPoG1Sm64=
=JRGS
-----END PGP SIGNATURE-----

--g9Jl5BjBPNXA9WFlmJUb1EohE8O0aUWt6--
