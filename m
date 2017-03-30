Received: from eggs.gnu.org ([2001:4830:134:3::10]:40539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cteOr-0006ZQ-Rm
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 14:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cteOm-0000iU-28
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 14:02:21 -0400
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
	<1490895797-29094-8-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <85690c7d-93c9-d370-ab7b-c5b0714a1332@redhat.com>
Date: Thu, 30 Mar 2017 13:02:10 -0500
MIME-Version: 1.0
In-Reply-To: <1490895797-29094-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AW2LUdVVWauMm1TwrsNwRsgfJcGqOK2eB"
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9 7/9] sockets: New helper
 socket_address_crumple()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AW2LUdVVWauMm1TwrsNwRsgfJcGqOK2eB
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com
Message-ID: <85690c7d-93c9-d370-ab7b-c5b0714a1332@redhat.com>
Subject: Re: [PATCH v3 for-2.9 7/9] sockets: New helper
 socket_address_crumple()
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
 <1490895797-29094-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1490895797-29094-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 12:43 PM, Markus Armbruster wrote:
> SocketAddress is a simple union, and simple unions are awkward: they
> have their variant members wrapped in a "data" object on the wire, and
> require additional indirections in C.  I intend to limit its use to
> existing external interfaces.  New ones should use SocketAddressFlat.
> I further intend to convert all internal interfaces to
> SocketAddressFlat.  This helper should go away then.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qemu/sockets.h | 11 +++++++++++
>  util/qemu-sockets.c    | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--AW2LUdVVWauMm1TwrsNwRsgfJcGqOK2eB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3UgiAAoJEKeha0olJ0NqaFEIALA3tEWjqNvsCJMzardIy8pH
5y5U606w1fh/KGF2hXVhdQWtCwHG1GioqK7aX5ILjDt5sSbaAEFW2BmgobVKm1qa
lFaOt93VALlMyOZmjiy5lVWqd9/Gf6P+fx9e+TMTa3BavjpHN5YyLKDt2Yn66Loi
WX0HHukHyask3eZxgOCwdUYUVdyviWpwtkBhSeRgkp9rbkUygCjMNVNaXcTs8/pF
V+sjxd64vDPQidK45mbPuRzppDcTqTWVpEzxT8Hezg56/mwrURQj1mctlpd6AwGb
0e6C9tFm7tHYxBPVWqognqjgx73mkKAeVaXfLqWZg9N8ynXSQc36+qQ+sQVz3n0=
=sMTr
-----END PGP SIGNATURE-----

--AW2LUdVVWauMm1TwrsNwRsgfJcGqOK2eB--
