Received: from eggs.gnu.org ([2001:4830:134:3::10]:59025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gKNzx-0000cm-TP
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gKNzw-0005X3-V7
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:35:57 -0500
References: <20181107063644.2254-1-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <10dd2dbc-716e-4b97-1de7-6556ec026e59@redhat.com>
Date: Wed, 7 Nov 2018 14:35:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181107063644.2254-1-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4dtu8Vi9rGfDYYveHwaWx17xRn4dO8JcW"
Subject: Re: [Qemu-devel] [PATCH v2] block: Make more block drivers
 compile-time configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jeff@codyprime.org, kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4dtu8Vi9rGfDYYveHwaWx17xRn4dO8JcW
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jeff@codyprime.org, kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <10dd2dbc-716e-4b97-1de7-6556ec026e59@redhat.com>
Subject: Re: [PATCH v2] block: Make more block drivers compile-time
 configurable
References: <20181107063644.2254-1-armbru@redhat.com>
In-Reply-To: <20181107063644.2254-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.11.18 07:36, Markus Armbruster wrote:
> From: Jeff Cody <jcody@redhat.com>
>=20
> This adds configure options to control the following block drivers:
>=20
> * Bochs
> * Cloop
> * Dmg
> * Qcow (V1)
> * Vdi
> * Vvfat
> * qed
> * parallels
> * sheepdog
>=20
> Each of these defaults to being enabled.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> v2: Fix handling of dmg-bz2.o [Max]
>=20
>  block/Makefile.objs | 22 ++++++++---
>  configure           | 91 +++++++++++++++++++++++++++++++++++++++++++++=

>  2 files changed, 107 insertions(+), 6 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--4dtu8Vi9rGfDYYveHwaWx17xRn4dO8JcW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvi6jIACgkQ9AfbAGHV
z0C5KAgAuDrOuDo7mQEAYz7CMriGOMUgSCHjZ5JdF9qTU0aC+J9yKMqOxlZbXJdA
JaHooosY3b0qS7p3Nd0wNylfSJxYh3yOk4pxIkYL9iHHqkXHU1xLQ3bQUMbk71d9
Npd++Tl8+lBzCiDW9Wo0nUWyWe41VmxJLDr49bGvQckFalnAHx33X8eMpCFFk+tc
7QwI1Ih8GNuJeBScbiW/JPvWy1PRSsL/qtwhjBqJrnRdsjASmsT2tmf+RqZ01uty
1wlJLKwV018iyUoEjaEejVBAmq3omMOKlxZuq7ZI0fpXtucw6iVuMDFKB988+TFS
zplWEnB1DDzj9Y59kC5t4kiBG8Gguw==
=+u2T
-----END PGP SIGNATURE-----

--4dtu8Vi9rGfDYYveHwaWx17xRn4dO8JcW--
