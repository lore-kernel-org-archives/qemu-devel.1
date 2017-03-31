Received: from eggs.gnu.org ([2001:4830:134:3::10]:55860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctxAF-00042k-MI
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctxAE-0000Vq-MU
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:04:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ctxAE-0000U4-EY
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:04:30 -0400
References: <1490963801-27870-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <903078f5-1f4b-e316-d1bb-2a3e755e8cb2@redhat.com>
Date: Fri, 31 Mar 2017 09:04:26 -0500
MIME-Version: 1.0
In-Reply-To: <1490963801-27870-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jhVCxaVXMvnMuNr5AdK8P9KxDWGLqeus9"
Subject: Re: [Qemu-devel] [PATCH] tests/libqtest.c: Delete possible stale
 unix sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jhVCxaVXMvnMuNr5AdK8P9KxDWGLqeus9
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <903078f5-1f4b-e316-d1bb-2a3e755e8cb2@redhat.com>
Subject: Re: [PATCH] tests/libqtest.c: Delete possible stale unix sockets
References: <1490963801-27870-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1490963801-27870-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 07:36 AM, Peter Maydell wrote:
> Occasionally if a test crashes or is interrupted by the user
> at the wrong moment it could leave behind a stale UNIX
> socket in /tmp/. This will then cause a subsequent test
> run to fail spuriously with
>  tests/libqtest.c:70:init_socket: assertion failed (ret !=3D -1): (-1 !=
=3D -1)
> if it happens to reuse the same PID.
>=20
> Defend against this by deleting any stray stale socket before
> trying to open the new ones for this test.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This seems like an easy way to shut up this infrequent but irritating
> error case...

There is a related failure in qemu-iotests that I hit yesterday:

+mkfifo: cannot create fifo
'/home/eblake/qemu/tests/qemu-iotests/scratch/qmp-out-3812_0': File exist=
s

that is probably also worth addressing, but that can be a separate patch.=


Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--jhVCxaVXMvnMuNr5AdK8P9KxDWGLqeus9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3mHqAAoJEKeha0olJ0Nq8WAH/jifvPqZymaU5ALa975n4eVR
0VD2WJb+jUm/VbkQjb94YiMUoZBMK2afpcPV+p2DUE/Dhpbwh5Pep333IB63Z4RI
vg7h41enDB30iMiJgXiT22x7KOx7jkXBO+lBkJX8kY4ufCS+/QbUnyC3iGIyzJYd
+6HafcuJnyvXyqN3OvKPt8HD+qzVEN7zELUmoR4DKFjYbTImtbHc6N/rfNp1Gef5
wkmX7+tbama6Lnh3NYQ/1vm36I8HOPzETKbAqIkcivrNbDRWWlPzlbrJtwDEMuQm
2R62Y9b6CiTzqvTWMiqkIW2kKPM446l3qRRtg3ZUkq5WEd+TssTloyVp+dVLe2A=
=jI/u
-----END PGP SIGNATURE-----

--jhVCxaVXMvnMuNr5AdK8P9KxDWGLqeus9--
