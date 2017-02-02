Received: from eggs.gnu.org ([2001:4830:134:3::10]:33566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cZNe3-0003cf-8b
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cZNe2-0000nQ-Cg
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:06:15 -0500
References: <87bmukmlau.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2994b33-19f7-f6ed-87a6-04f4b22fadd8@redhat.com>
Date: Thu, 2 Feb 2017 14:06:07 -0600
MIME-Version: 1.0
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vxDMprdcPIwkp4TC8losUBGBB2NWol0r3"
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vxDMprdcPIwkp4TC8losUBGBB2NWol0r3
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <e2994b33-19f7-f6ed-87a6-04f4b22fadd8@redhat.com>
Subject: Re: Non-flat command line option argument syntax
References: <87bmukmlau.fsf@dusky.pond.sub.org>
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2017 01:42 PM, Markus Armbruster wrote:

quick comment before I reply to the overall message...


> Arbitrary nesting with dotted key convention:
>=20
>     -drive driver=3Dqcow2,file.driver=3Dgluster,
>            file.volume=3Dtestvol,file.path=3D/path/a.qcow2,file.debug=3D=
9,
>            file.server.0.type=3Dtcp,
>            file.server.0.host=3D1.2.3.4,
>            file.server.0.port=3D24007,
>            file.server.1.type=3Dunix,
>            file.server.1.socket=3D/var/run/glusterd.socket

>=20
> Lines broken and indented for legibility; you need to join them for
> actual use.  Once you do, both variants are basically illegible.=20

It should be relatively simple to tweak QemuOpts to support:

-drive 'driver=3Dqcow2,
        file.driver=3Dgluster,
        file....'

where all whitespace after comma is ignored, with a nice effect of much
more legibility in long command lines.  I might just submit a patch for
that, regardless of what else we do to get rid of QemuOpts.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vxDMprdcPIwkp4TC8losUBGBB2NWol0r3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYk5EvAAoJEKeha0olJ0Nqk9YH/iusI+eYcbBqn5+1Vt9mjyQF
mdusX0ononfPHHx1dYEwa3J9ouMRqdazIvHaK2ZZqX1HsUlHawTvXl4J5WvfOhhL
vrqp8rSv3g5SQTF6fRhmf0YkatGzpefHUKfYI6ED9AvVqjpDCgpnCs9DYIe/+gne
OvAZDxaOUbGG0byxBUOjfrOuw63n8Ajow7MnJuV8MHkX6LkT/cc1IOexx30xEMgh
k0hJruo/dfwQ1nIaeQY9oqeeKtmSKmreezHtJrnqvMjiw7DV1H6nG+h18WQPrKMF
TzRJ54Nvi4iPyxi8TP34OD96YtiB+QoZvpKtnIiQohbOIFQwbVh06/u1aH+06HQ=
=9PQ8
-----END PGP SIGNATURE-----

--vxDMprdcPIwkp4TC8losUBGBB2NWol0r3--
