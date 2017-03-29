Received: from eggs.gnu.org ([2001:4830:134:3::10]:47467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctJcj-0007aq-0x
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctJci-0003v8-Ap
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:51:17 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01c9ded7-36e4-4543-8407-36df50048264@redhat.com>
Date: Wed, 29 Mar 2017 14:51:07 -0500
MIME-Version: 1.0
In-Reply-To: <1490805920-17029-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rfC3fNeMHCSkPxiurqqdvj7d09N7MVr52"
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
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rfC3fNeMHCSkPxiurqqdvj7d09N7MVr52
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
Message-ID: <01c9ded7-36e4-4543-8407-36df50048264@redhat.com>
Subject: Re: [for-2.9 1/8] nbd sockets vnc: Mark problematic address family
 tests TODO
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/29/2017 11:45 AM, Markus Armbruster wrote:
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

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rfC3fNeMHCSkPxiurqqdvj7d09N7MVr52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3BArAAoJEKeha0olJ0NqZb4H+gOlzE904JGpZny8BSF6xisf
Gdl0OMmJbjwyDpH2xSNc8RIzL35J8RjSxBinZkKgRI5ClYrUm/kg0kTB9rX7GOrN
2qd8qEdVhGiBZPNXOFjPJg0rrA+hK9BaXuMFhyI1//rzwtqK+S0a02RL3r6F/R3e
Ob1qTG4koiVdLJJDQPuVJY1HQf+4GDrzUtDxHf4o297J68aMC+bbw975rjo+LdRe
6tjnCSP/I/otAwbReKMClnPaiSr9H6lbZUuFEc+Q6QxOUCZ8ps8aW/22vO5QYAMK
85KJdeVJKAm2yXuPUi+wyrnzM3t9Kv7InOZqirI67xNBt2Pq1JNNoVOJzfF4KEg=
=dQo0
-----END PGP SIGNATURE-----

--rfC3fNeMHCSkPxiurqqdvj7d09N7MVr52--
