Received: from eggs.gnu.org ([2001:4830:134:3::10]:60709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctIlM-00039E-H4
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctIlL-0004hO-N4
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:56:08 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-2-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2f390820-12e3-603d-d789-e5671818b3c0@redhat.com>
Date: Wed, 29 Mar 2017 20:55:55 +0200
MIME-Version: 1.0
In-Reply-To: <1490805920-17029-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1HkepKsQQ5reXKvSTogDMJCP9PmNKiAqB"
Subject: Re: [Qemu-devel] [for-2.9 1/8] nbd sockets vnc: Mark problematic
 address family tests TODO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com, pbonzini@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1HkepKsQQ5reXKvSTogDMJCP9PmNKiAqB
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
Message-ID: <2f390820-12e3-603d-d789-e5671818b3c0@redhat.com>
Subject: Re: [for-2.9 1/8] nbd sockets vnc: Mark problematic address family
 tests TODO
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 29.03.2017 18:45, Markus Armbruster wrote:
> Certain features make sense only with certain address families.  For
> instance, passing file descriptors requires AF_UNIX.  Testing
> SocketAddress's saddr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX is obvious,=

> but problematic: it can't recognize AF_UNIX when type =3D=3D
> SOCKET_ADDRESS_KIND_FD.
>=20
> Mark such tests of saddr->type TODO.  We may want to check the address
> family with getsockname() there.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/nbd.c           | 1 +
>  blockdev-nbd.c        | 1 +
>  chardev/char-socket.c | 5 ++---
>  ui/vnc.c              | 1 +
>  util/qemu-sockets.c   | 4 ++++
>  5 files changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--1HkepKsQQ5reXKvSTogDMJCP9PmNKiAqB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljcAzsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASUQH/jNWHO+P1OUyYPr4ecfArznIdqZLhw/m
OcCFekBmNuA3mH2EYw1MhODccZ926/VW6GKQZVcJE3kpNs7Fr5j2Xaf77fGck2R2
FDounTPZeIZ/RuXoyCT3dkSCGsPZ6ULnr6CsLk6+EkuHhrWgMREn//oswyK9iHDj
HFa9cYfVD6K3hOx2bCqTbOjT8AFDoxACdgUPPaqzXCSr6M/FAVaNftgDczUYI9Gp
VTSnF2P5GBPp48Wcr1MZwEtkCI0FZKR2XA7p1WzJFS2Y9To8q4WVhixmPLTPXyq+
dr4Q7sdfrtt3JSTwK51ylmsGEPrIuM3ar8LtbBVdUMdyVfXv/89Vpuc=
=lyxB
-----END PGP SIGNATURE-----

--1HkepKsQQ5reXKvSTogDMJCP9PmNKiAqB--
