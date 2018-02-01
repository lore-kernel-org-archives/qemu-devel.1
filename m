Received: from eggs.gnu.org ([2001:4830:134:3::10]:46126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKQN-0005hU-Bg
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:21:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKQM-0005MZ-43
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:21:31 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<0c81220cf2141a5b720629fb6eaff04f833e77a4.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <256a246d-fb05-d60c-b06a-3ba7c31450a8@redhat.com>
Date: Thu, 1 Feb 2018 20:21:17 +0100
MIME-Version: 1.0
In-Reply-To: <0c81220cf2141a5b720629fb6eaff04f833e77a4.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CEt3iZu7FOuiMHQwrC5qD7SVvx9ewl1LS"
Subject: Re: [Qemu-devel] [PATCH v3 26/39] qcow2: Prepare
 qcow2_update_snapshot_refcount() for adding L2 slice support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CEt3iZu7FOuiMHQwrC5qD7SVvx9ewl1LS
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <256a246d-fb05-d60c-b06a-3ba7c31450a8@redhat.com>
Subject: Re: [PATCH v3 26/39] qcow2: Prepare qcow2_update_snapshot_refcount()
 for adding L2 slice support
References: <cover.1516978645.git.berto@igalia.com>
 <0c81220cf2141a5b720629fb6eaff04f833e77a4.1516978645.git.berto@igalia.com>
In-Reply-To: <0c81220cf2141a5b720629fb6eaff04f833e77a4.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> Adding support for L2 slices to qcow2_update_snapshot_refcount() needs
> (among other things) an extra loop that iterates over all slices of
> each L2 table.
>=20
> Putting all changes in one patch would make it hard to read because
> all semantic changes would be mixed with pure indentation changes.
>=20
> To make things easier this patch simply creates a new block and
> changes the indentation of all lines of code inside it. Thus, all
> modifications in this patch are cosmetic. There are no semantic
> changes and no variables are renamed yet. The next patch will take
> care of that.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-refcount.c | 140 ++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 73 insertions(+), 67 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--CEt3iZu7FOuiMHQwrC5qD7SVvx9ewl1LS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzaK4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ArsUH/R5p/bKPRtTvlZwWhaRpbOL5Mx/294Pe
QnoyB/DFb+rjjigiP9o/j1MoTa1zDAyg3JzPPCkBt1g1sEGafinxvFdws+qfk+ev
8Kwq63GI2L4hC/EflsipdT/y4JegHL7wgqqhsZ5LKh4Hhr1MNzzFrCkT9GdJa+YB
kmClZ0NlrT0m2YNGJCV0FmtX+WOTOgs13T9XrHMfpjJrl6zbHtkPVKxUz2N/FFd9
ugJUQvpMpWbgN2vhZxp9v3gyIeISCaEFOl6EgGNr6SFFICo8U1qZqLi6nFHy5ymz
ULIF0ZGE0bHEu4kR+orfMr9hzYpXM0TN8AhSJJruVU+wE4VGV9/u/sI=
=BwTH
-----END PGP SIGNATURE-----

--CEt3iZu7FOuiMHQwrC5qD7SVvx9ewl1LS--
