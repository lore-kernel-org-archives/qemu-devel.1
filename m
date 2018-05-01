Received: from eggs.gnu.org ([2001:4830:134:3::10]:34030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fDUx0-00013Y-SV
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fDUwx-0002MM-Pf
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:04:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fDUwx-0002M8-Ju
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:04:07 -0400
Date: Tue, 1 May 2018 14:04:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180501130406.GD14803@stefanha-x1.localdomain>
References: <20180430124651.10340-1-stefanha@redhat.com>
	<152509298983.2409.13656791008049355574@71c20359a636>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <152509298983.2409.13656791008049355574@71c20359a636>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] checkpatch: backport UTF-8 fixes
 and MAINTAINERS check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, armbru@redhat.com, marcandre.lureau@gmail.com


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 05:56:30AM -0700, no-reply@patchew.org wrote:
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/5: checkpatch: add a --strict check for utf-8 in commit =
logs...
> WARNING: line over 80 characters
> #101: FILE: scripts/checkpatch.pl:1420:
> +			WARN("8-bit UTF-8 used in possible commit log\n" . $herecurr);
>=20
> total: 0 errors, 1 warnings, 66 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 2/5: checkpatch: check utf-8 content from a commit log whe=
n it's missing from charset...
> Checking PATCH 3/5: checkpatch: ignore email headers better...
> Checking PATCH 4/5: checkpatch: emit a warning on file add/move/delete...
> WARNING: line over 80 characters
> #46: FILE: scripts/checkpatch.pl:1397:
> +		     ($line =3D~ /\{\s*([\w\/\.\-]*)\s*\=3D\>\s*([\w\/\.\-]*)\s*\}/ &&
>=20
> ERROR: line over 90 characters
> #49: FILE: scripts/checkpatch.pl:1400:
> +			WARN("added, moved or deleted file(s), does MAINTAINERS need updating=
?\n" . $herecurr);
>=20
> total: 1 errors, 1 warnings, 24 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> Checking PATCH 5/5: checkpatch: reduce MAINTAINERS update message frequen=
cy...
> =3D=3D=3D OUTPUT END =3D=3D=3D

If there are no objections I'd like to keep this in sync with upstream,
and error messages are exempt from the 80 char limit to aid grepping.

Stefan

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa6GXGAAoJEJykq7OBq3PIYLMH/A5Cqod/4AzUV+4lJ09PivC9
dCYKX7LDEbPdtUPlcYVtfeoTOkJTZXyHtjc9xMoDoFtP68+41r0l1knzi1JYdZpi
C9GGmfjLCnlTuP4/mcUBMODxgFOH1LR53k2SlN1i06hKrwbiOZSsL7tOXDzVAsDp
AXbl9aPkPf2twAVgVm3ytOotumHRoh4wevfqu/lPkT7scD2aZi7jPQ1dKCIpdlN1
z/l1Mry5tBiy100Rhl8H7StdQXRTh+RqyvvFmV/w0y+yDMd3/XrI5ZGalp1MDDmW
71Ac2IlrE1Sddo2g+Yqae/4zy38Wn2ydXbV2j2sZEEm1tfcJHV34ctGOrNFcj00=
=oQcc
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
