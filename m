Received: from eggs.gnu.org ([2001:4830:134:3::10]:44073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIxV4-0005Xv-Eu
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIxV1-0000JT-AH
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:29:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dIxV1-0000Iy-1O
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:29:19 -0400
References: <20170608115939.30985-1-marcandre.lureau@redhat.com>
	<20170608115939.30985-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3e0f4e1-0594-0563-aa9c-4b26d0eecd0f@redhat.com>
Date: Thu, 8 Jun 2017 08:29:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170608115939.30985-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KNXg4gk3Ton0ulN7fHT6qq1TnoF3aFHMl"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] char: fix alias devices regression
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
--KNXg4gk3Ton0ulN7fHT6qq1TnoF3aFHMl
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, pbonzini@redhat.com
Message-ID: <b3e0f4e1-0594-0563-aa9c-4b26d0eecd0f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] char: fix alias devices regression
References: <20170608115939.30985-1-marcandre.lureau@redhat.com>
 <20170608115939.30985-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170608115939.30985-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2017 06:59 AM, Marc-Andr=C3=A9 Lureau wrote:
> Fix regression from commit 4d43a603c71, where the serial and parallel
> headers got removed from char.c, which broke the alias table.
>=20
> Move the HAVE_CHARDEV_SERIAL/HAVE_CHARDEV_PARPORT to osdep.h instead
> of being in seperate headers.

s/seperate/separate/

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/chardev/char-parallel.h |  5 -----
>  include/chardev/char-serial.h   |  8 --------
>  include/qemu/osdep.h            | 13 +++++++++++++
>  3 files changed, 13 insertions(+), 13 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KNXg4gk3Ton0ulN7fHT6qq1TnoF3aFHMl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOVEqAAoJEKeha0olJ0Nqi7kIAKClCJfwC411KsB5S3J/2Ppt
imUkicNib+L4FlmBKAWlk1OGVzpBJli6bF5KxpFoq65GnWbuzWHOzYbmr8nooyNr
Y9drQKptjM1Dxn4L/7fEFEO1HKD4R6GweO2S+3U835XIPJM3GdaFQgPC5GJ6MSF6
cegs7nlFMMwFWU0Jl/HZy++JBCuyliuyUGksyeOB5/qE3GEEfAM9V5LgJ5bHGJpN
TJ3lmUOFzoi2lScJ4z7j0+UQPwiwMavpUh4r1Gzamu/0KVdVIG1oHJkEEFVvdBE1
AcLkxdhVCZ8DgUx7uZ4ns53d3sVmfbmieATNmRsELK0iwF/bMMlGyAF8IDznM88=
=xxGl
-----END PGP SIGNATURE-----

--KNXg4gk3Ton0ulN7fHT6qq1TnoF3aFHMl--
