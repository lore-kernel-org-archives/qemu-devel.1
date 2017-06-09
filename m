Received: from eggs.gnu.org ([2001:4830:134:3::10]:57233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJPlC-0005h1-By
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJPl7-0001Th-QX
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:39:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dJPl7-0001S0-H4
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:39:49 -0400
References: <cover.e0862272629975a2a7296103cf5d5f8de70abc01.1497035841.git-series.knut.omang@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b358f743-e2d2-6b6f-cb82-0452574e6b27@redhat.com>
Date: Fri, 9 Jun 2017 14:39:44 -0500
MIME-Version: 1.0
In-Reply-To: <cover.e0862272629975a2a7296103cf5d5f8de70abc01.1497035841.git-series.knut.omang@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1sHKfIGp0TngWt3O2mNidPxhRmqtDPM3f"
Subject: Re: [Qemu-devel] [PATCH 0/2] Unit test+fix for problem with QEMU
 handling of multiple bind()s to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>, "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1sHKfIGp0TngWt3O2mNidPxhRmqtDPM3f
From: Eric Blake <eblake@redhat.com>
To: Knut Omang <knut.omang@oracle.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <b358f743-e2d2-6b6f-cb82-0452574e6b27@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Unit test+fix for problem with QEMU
 handling of multiple bind()s to the same port
References: <cover.e0862272629975a2a7296103cf5d5f8de70abc01.1497035841.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.e0862272629975a2a7296103cf5d5f8de70abc01.1497035841.git-series.knut.omang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2017 02:19 PM, Knut Omang wrote:
> This series contains:
> * a unit test that exposes a race condition which causes QEMU to fail
>   to find a port even when there is plenty of available ports.
> * a refactor of the qemu-sockets inet_listen_saddr() function
>   to better handle this situation.
>=20
> Thanks,
> Knut
>=20
> Knut Omang (2):
>   Add test-listen - a stress test for QEMU socket listen
>   socket: Handle race condition between binds to the same port
>=20

I'd reorder the series, to put the fix first and the test second, rather
than the (crippled) test first.  Someone that wants to prove that the
test works can easily apply the patches out of order.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1sHKfIGp0TngWt3O2mNidPxhRmqtDPM3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOvmAAAoJEKeha0olJ0Nqf+EIAI4J2krRlI7ERhHxRGnPmomo
E2MNMjSorWCjSUOnTVyZ6Pb6A5rW0qv8VPkgwTj3G4S1TkRYADJt8nvTF/3WZ+uA
lM04bo9w7x+JIRK1WRSJGaHNN0k3UeAO41ASeeokJeGqIHufCS2hKy3x5R49wnpA
u3PRg2I1ZMZaPvToAqT1skKfU7CDXAh0lMNTTYd0EtrIlC6mP/vcz2h3k0zFe6Dz
guRsAQ//LvZUbxLJizyvZjNPUQx/R2S9tafrO2B2GMDDgz141FCRlEqZov9bjopa
L+uh+jl2ycUcJAouXOP6/Zvh3L+rpe5ea78iFwE7nWqIwmC+ncAo+8HdCocmhY8=
=QwP+
-----END PGP SIGNATURE-----

--1sHKfIGp0TngWt3O2mNidPxhRmqtDPM3f--
