Received: from eggs.gnu.org ([2001:4830:134:3::10]:58304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fMEb8-00066C-7T
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fMEb7-0003wk-BF
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:25:42 -0400
Date: Fri, 25 May 2018 16:25:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180525152533.GE21895@stefanha-x1.localdomain>
References: <20180523030436.29097-1-famz@redhat.com>
	<20180523030436.29097-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline
In-Reply-To: <20180523030436.29097-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 04/10] qcow2: Implement copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, eblake@redhat.com


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2018 at 11:04:30AM +0800, Fam Zheng wrote:
> The two callbacks are implemented quite similarly to the read/write
> functions: bdrv_co_copy_range_from maps for read and calls into bs->file
> or bs->backing depending on the allocation status; bdrv_co_copy_range_to
> maps for write and calls into bs->file.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/qcow2.c | 226 ++++++++++++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 196 insertions(+), 30 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbCCrtAAoJEJykq7OBq3PIFxUH/1rOm6Rx1CuRrCiLO2/AIX6k
d0ilgV1AAYzPXnsyJWLsMI6Oiwqv8HiSF/CqFALyfYPzZ3WQJomCF5pEYhOBx/Ve
byHpSXwYh7z/pDdibkbkb4dkKrzYvpPPT5AxTmxmtaT0QXnBvbdfknLNzh68HPHy
G0PqzSFFFPdhJp35HMVePxNWkpMNumDbh5TgGDLI1tjUumbwf5/2qpHZbujV6Y+I
7Tl1ovHn3HlMGfpgLsnnT44pjvKI556FJnOVXboXCVR2550n28uo5xMJZzPd5oPp
BjPbLnBF2+NbwOcwf3JvZLinbR89gAllwl+QnFRyln0+D1B77WGks81tmpyw/Lg=
=tc/s
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--
