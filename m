Received: from eggs.gnu.org ([2001:4830:134:3::10]:49349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crTsW-0007lP-J7
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crTsT-0008NU-9N
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:24:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crTsT-0008NE-0S
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:23:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2F1CC04BD35
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 18:23:56 +0000 (UTC)
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
	<1490377482-13337-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40ed2813-4772-c8b3-8760-672944659ebe@redhat.com>
Date: Fri, 24 Mar 2017 13:23:51 -0500
MIME-Version: 1.0
In-Reply-To: <1490377482-13337-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9g7Swn2iqqgPGEM3J2AT2CR62VWS8B46H"
Subject: Re: [Qemu-devel] [PATCH RFC v2 2/9] rbd: Fix to cleanly reject
 -drive without pool or image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9g7Swn2iqqgPGEM3J2AT2CR62VWS8B46H
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <40ed2813-4772-c8b3-8760-672944659ebe@redhat.com>
Subject: Re: [PATCH RFC v2 2/9] rbd: Fix to cleanly reject -drive without pool
 or image
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
 <1490377482-13337-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1490377482-13337-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 12:44 PM, Markus Armbruster wrote:
> qemu_rbd_open() neglects to check pool and image are present.
> Reproducer:
>=20
>     $ qemu-system-x86_64 -nodefaults -drive if=3Dnone,driver=3Drbd,pool=
=3Dp
>     Segmentation fault (core dumped)
>     $ qemu-system-x86_64 -nodefaults -drive if=3Dnone,driver=3Drbd,imag=
e=3Di
>     qemu-system-x86_64: -drive if=3Dnone,driver=3Drbd,image=3Di: error =
opening pool (null)
>=20
> Doesn't affect -drive with file=3D..., because qemu_rbd_parse_filename(=
)
> always sets both pool and image.
>=20
> Doesn't affect -blockdev, because pool and image are mandatory in the
> QAPI schema.
>=20
> Fix by adding the missing checks.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9g7Swn2iqqgPGEM3J2AT2CR62VWS8B46H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1WQ3AAoJEKeha0olJ0NqK1kH/jmuPrTF10wTqx+4pU8VyIgo
cKoQVu61sa6PITZcGb5uQvT6SOuOViQSn0uwAayf0a7OobLFiyWCtGl4bQMtw1F1
Ox+gX8lNVb7SlMREulsr0BxkG3Sozqamj0CmHib84E5qKcxj9ZnoPyyz5r3jAuTw
bUsRSGkukQ87NRsLtztHCaVa518lN2/I7jXrkg6xKa1kI8zIWkPHCT+Hbg80yHWi
Dkcy+PAXWHPS6GYBY/bWSTmMNTPTq5GGbUh5AH//FSolOaE00JKWWVzE2fyWjYkU
WNrPmRcADVDrvfGz95e2+BtGxjX6MYEbXaMTynb42DTPyZEgXEQC8u6XghB285s=
=vRj5
-----END PGP SIGNATURE-----

--9g7Swn2iqqgPGEM3J2AT2CR62VWS8B46H--
