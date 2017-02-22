Received: from eggs.gnu.org ([2001:4830:134:3::10]:57910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXFf-0004jq-Pj
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXFf-0002cY-5c
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:46:39 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-14-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dac16009-81ad-040b-f7ae-b0d13fb14737@redhat.com>
Date: Wed, 22 Feb 2017 14:46:30 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-14-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IMlKF0kHTE7F2j2BOQug9dPfDPaiptmHa"
Subject: Re: [Qemu-devel] [PATCH 13/54] block: Add Error argument to
 bdrv_attach_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IMlKF0kHTE7F2j2BOQug9dPfDPaiptmHa
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <dac16009-81ad-040b-f7ae-b0d13fb14737@redhat.com>
Subject: Re: [PATCH 13/54] block: Add Error argument to bdrv_attach_child()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-14-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-14-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> It will have to return an error soon, so prepare the callers for it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c               | 16 +++++++++++++---
>  block/quorum.c        |  9 ++++++++-
>  include/block/block.h |  3 ++-
>  3 files changed, 23 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--IMlKF0kHTE7F2j2BOQug9dPfDPaiptmHa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitljYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AahoH/3ZF1IEQcmQw7yWokS0cFTHa//5syYhy
WnUxbD+Mvw5mUM3YQdxxmQEV81H7a8wyAHgAoJLKAO8YKOuf3by5sfXVADWqHw62
E4FIqcqU9yALZ1cc0jVJyuV9UeNB0hNpfSBqnyCLa/0j0hFGqbkmQZRiYIXml9q9
HV+YjmgbUzBLDXYpFPojwJLkrqr+iPWF0tmmN78ZzDFrdewDgjK0LkFOGabHbxHw
V2r6jP4tctj4LZaS05MigVNPWdjlIJtJXdXpDtZu7FsgqxfAJ0GE82zmlOwwnABn
VV6tvVPWxKW5yeO5H+Xc1ouExLD8tqZr1EYK/PUscUllDE+MncPVCYs=
=Sj4C
-----END PGP SIGNATURE-----

--IMlKF0kHTE7F2j2BOQug9dPfDPaiptmHa--
