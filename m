Received: from eggs.gnu.org ([2001:4830:134:3::10]:42914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnsYo-0004qk-Kr
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnsYk-0005Yv-AH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:56:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnsYk-0005Y7-1A
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:56:42 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-30-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0c8726bd-d9ee-b2e8-e7e6-6d24ce4e3e42@redhat.com>
Date: Tue, 14 Mar 2017 14:56:39 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-30-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CHCdrPRR5uVILim74lIpENo4P2eWTMdqs"
Subject: Re: [Qemu-devel] [PATCH for-2.9 29/47] qapi2texi: Use category
 "Object" for all object types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CHCdrPRR5uVILim74lIpENo4P2eWTMdqs
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <0c8726bd-d9ee-b2e8-e7e6-6d24ce4e3e42@redhat.com>
Subject: Re: [PATCH for-2.9 29/47] qapi2texi: Use category "Object" for all
 object types
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-30-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-30-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> At the protocol level, the distinction between struct, flat union and
> simple union is meaningless, they are all JSON objects.  Document them
> that way.
>=20
> Example change (qemu-qmp-ref.txt):
>=20
> - -- Simple Union: InputEvent
> + -- Object: InputEvent
>=20
>       Input event union.

Yay - and even addresses one of my comments earlier in the series about
a needless distinction between simple and flat unions.

>=20
> This also fixes the completely broken headings for flat and simple
> unions in qemu-qmp-ref.7 and qemu-ga-ref.7, by sidestepping a bug in
> texi2pod.pl.  For instance, it mistranslates "@deftp {Simple Union}
> InputEvent" to "B<Union> (Simple)", but translates "@deftp Object
> InputEvent" to "B<SocketAddress> (Object)".
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi2texi.py | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CHCdrPRR5uVILim74lIpENo4P2eWTMdqs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyEr3AAoJEKeha0olJ0NqqbUH/A2R7wZmQzVSYLLv4vXYADfC
5ZbViMNkNz+xaEY5/n35Df3yJZ8hMjuVn7ga2McH2K0THC/1wCODtmgtyRmnAhT9
sOtZPfTAUTJPVqghz+E5G9f6RWpddFpn/lgOyYyE/r4k/xkC5aSbkqs1GUNyGC+R
hKm8mcQEv+pewM3kho+LQ9WHLq/NlHYV6w/Nh2v6u4slvX87X17U6VaHCTJgvv6r
2DI4yhAVTDxdhEJg+Ljs8vIaLFuod3BMVH/rf+O0+VqHKH9GHqN7YEjpOe/hVV3t
XpubY5xyjPUrY9LuLjdf0sJQna2PQKC0cCIf6uz8VdFer4GJpkTG8NMP5isHY44=
=3Our
-----END PGP SIGNATURE-----

--CHCdrPRR5uVILim74lIpENo4P2eWTMdqs--
