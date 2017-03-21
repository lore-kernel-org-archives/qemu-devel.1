Received: from eggs.gnu.org ([2001:4830:134:3::10]:43583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqNHN-0007Qj-3H
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqNHJ-0003Fm-S7
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:09:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqNHJ-0003Fb-Ka
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:09:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B78F17EBAA
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 17:09:01 +0000 (UTC)
References: <1490115473-24839-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d301cea-76ba-dc75-0404-c14246a037c4@redhat.com>
Date: Tue, 21 Mar 2017 12:08:41 -0500
MIME-Version: 1.0
In-Reply-To: <1490115473-24839-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wKv17keA1jbg18B6U0AoCcluNo9xm0d71"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wKv17keA1jbg18B6U0AoCcluNo9xm0d71
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, mreitz@redhat.com
Message-ID: <9d301cea-76ba-dc75-0404-c14246a037c4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Declare blockdev-add and
 blockdev-del supported
References: <1490115473-24839-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1490115473-24839-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2017 11:57 AM, Markus Armbruster wrote:
> It's been a long journey, but here we are.
>=20
> x-blockdev-remove-medium, x-blockdev-insert-medium and
> x-blockdev-change need a bit more work, so leave them alone for now.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  blockdev.c             |  4 ++--
>  qapi/block-core.json   | 14 +++++---------
>  tests/qemu-iotests/139 |  8 ++++----
>  tests/qemu-iotests/141 |  4 ++--
>  tests/qemu-iotests/147 |  2 +-
>  5 files changed, 14 insertions(+), 18 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wKv17keA1jbg18B6U0AoCcluNo9xm0d71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0V4ZAAoJEKeha0olJ0NqVZ0H/jbs4AayyTpggbq+OT46Wx+X
4sLeBIhBoO6ixnQAth+9ITF8j/Aq0vktr5xBi+2spddz+sMpXgJ3mGaw6zNWIJ1X
Udk1LH2pinc0q1TjpuQ9hTRXwhC233GtGk1g7aX/3OTjbsKRYtkNipGTilzZ7OYL
CXx92XqFK+bacR6Z4eBNMJPbuB0TzWhuVxU+R8T1rXt7M6/fAa/G1Tlkx9Gb40Fz
V/FAXayYy97pyG5DWm2zhL0TpNGOIkUySsJlECE8YdLhLkgWCBxe8XBYFs7wN8oQ
gx0oPj1h64Q1+YvFaI9oypxZhtryZ/5Njqi7b3zAWfLNeOLwKr7wCNmOYTlDVW4=
=NCS8
-----END PGP SIGNATURE-----

--wKv17keA1jbg18B6U0AoCcluNo9xm0d71--
