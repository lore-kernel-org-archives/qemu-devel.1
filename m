Received: from eggs.gnu.org ([2001:4830:134:3::10]:50694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdkq3-0007Dt-Hl
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdkq1-0005CY-Vx
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:40:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdkq1-0005C0-HY
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:40:41 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99A6B6AAC5
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 21:40:41 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-9-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <16f6aee4-0d2f-59e7-4e1c-e3fd2df479b0@redhat.com>
Date: Tue, 14 Feb 2017 15:40:39 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vxFjktTrPhPbcc9NMv7CQhlkq7KqbDubH"
Subject: Re: [Qemu-devel] [PATCH 08/24] util/cutils: Clean up control flow
 around qemu_strtol() a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vxFjktTrPhPbcc9NMv7CQhlkq7KqbDubH
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <16f6aee4-0d2f-59e7-4e1c-e3fd2df479b0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/24] util/cutils: Clean up control flow
 around qemu_strtol() a bit
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:25 AM, Markus Armbruster wrote:
> Reorder check_strtox_error() to make it obvious that we always store
> through a non-null @endptr.
>=20
> Transform
>=20
>     if (some error) {
>         error case ...
>         err =3D value for error case;
>     } else {
>         normal case ...
>         err =3D value for normal case;
>     }
>     return err;
>=20
> to
>=20
>     if (some error) {
>         error case ...
>         return value for error case;
>     }
>     normal case ...
>     return value for normal case;
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/cutils.c | 89 ++++++++++++++++++++++++++++++---------------------=
--------
>  1 file changed, 45 insertions(+), 44 deletions(-)

No real net change in lines, but I agree that it is more legible.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vxFjktTrPhPbcc9NMv7CQhlkq7KqbDubH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo3lXAAoJEKeha0olJ0NqyZcH/2kdeLuD2I4kJcdRrRnj3w5X
xm2DpC/TlxxEW6KEukhaB9LoV6rOCQbuBDTzFhiTuNdchjclP0JJbBJA05Vk3PoU
xdVVKpRWIS8l5I3t+WYIzl8JAOYh/K3gDKy+KkfiSBzUe1l31EPYE9W2iZQvlf99
h94O/vKWWC91LyHVlt0NliH20ZgS70VB0mmnwiPxPuiEACsQoZ+iG3fYvBQiUTBF
HAZnpvHVPyIyxZ459WEDM7Dr0Te0SZ/1NtBHp94P/YgOao6a0+a52ms/RcNo45Wj
Om05HlW/OazjYffknjn8Dk8LrSEQNrO9UYDvheJ3XxIQEv3z0CpcP/99IrYtu+4=
=jEKj
-----END PGP SIGNATURE-----

--vxFjktTrPhPbcc9NMv7CQhlkq7KqbDubH--
