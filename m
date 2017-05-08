Received: from eggs.gnu.org ([2001:4830:134:3::10]:52475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leo@gaspard.io>) id 1d7kfy-0007mK-2o
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leo@gaspard.io>) id 1d7kfv-0007Gi-FV
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:34:18 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:46286
	helo=smtp.smtpout.orange.fr)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leo@gaspard.io>) id 1d7kfv-0007Dh-3n
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:34:15 -0400
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
From: Leo Gaspard <leo@gaspard.io>
Message-ID: <3d315a77-3e48-8441-de03-36b2cdda7a66@gaspard.io>
Date: Mon, 8 May 2017 17:33:43 +0200
MIME-Version: 1.0
In-Reply-To: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bCEAf8EA49mGCpmalh4OObUQq6N0lMMUO"
Subject: Re: [Qemu-devel] [PATCH 0/5] 9pfs: local: fix metadata of
 mapped-file security mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bCEAf8EA49mGCpmalh4OObUQq6N0lMMUO
From: Leo Gaspard <leo@gaspard.io>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>
Message-ID: <3d315a77-3e48-8441-de03-36b2cdda7a66@gaspard.io>
Subject: Re: [PATCH 0/5] 9pfs: local: fix metadata of mapped-file security
 mode
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
In-Reply-To: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Greg,

I just tested on 2.9.0 with the 5 patches applied, and it appears to
work on my setup, thanks!

Just a side note: .virtfs_metadata_root is set as u=3Drwx on the host fil=
e
system (the "ret =3D fchmod(map_fd, 0700);" line in patch 4 I guess),
while u=3Drw would be more appropriate, I think.

Thank you,
Leo


On 05/05/2017 04:36 PM, Greg Kurz wrote:
> This series fixes two issues in the local backend when using the mapped=
-file
> security mode:
> - allow chmod and chown to succeed on the virtfs root (patch 4)
> - completely hide the metadata files from the client (patch 5)
>=20
> Patch 2 resolves '.' and '..' in paths, and patch 3 reworks the way we =
open
> files accordingly. They could be squashed together in a single patch (t=
his
> was the case in earlier versions actually), but I decided to separate t=
hem
> for easier review.
>=20
> L=C3=A9o,
>=20
> I'd appreciate if you could test this series (especially patch 4) on yo=
ur
> setup.
>=20
> Cheers.
>=20
> --
> Greg
>=20
> ---
>=20
> Greg Kurz (5):
>       9pfs: check return value of v9fs_co_name_to_path()
>       9pfs: local: resolve special directories in paths
>       9pfs: local: simplify file opening
>       9pfs: local: metadata file for the VirtFS root
>       9pfs: local: forbid client access to metadata
>=20
>=20
>  hw/9pfs/9p-local.c |  164 ++++++++++++++++++++++++++++++++++++++++----=
--------
>  hw/9pfs/9p-util.c  |   26 +++-----
>  hw/9pfs/9p.c       |   36 ++++++++---
>  3 files changed, 160 insertions(+), 66 deletions(-)
>=20


--bCEAf8EA49mGCpmalh4OObUQq6N0lMMUO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEplquSIS+CbvsrRWvilWEi2CQ+c8FAlkQj9cACgkQilWEi2CQ
+c/9CQv+NqzsccgAxWlC7IUDiURsgc5PDSlHjcqTFpcX0PwKd44JrubSRC796+8J
/FhoITxTBtGujRQkOflGQzU6MB8YS4wPxBk2juqwKHpulHE2f1yFYpyftU/EnYPa
2CVa1QlJGcQX9QvCDSq7mstoD/IHmBLj7rZtQJEjObHdSQYeqvwuY3TKrZeB5/yX
/i9P7XDsVo/W3bO2bmTwHLITZCAO49jOnUQRJGP4cld40EgJNNHyqB/O+XUcwSyl
Tk4AoqYhqATIZCbTED2DKNqd6FM7Ai/r0LZyIh0c2KN87caqPMfYk+hxqPF0uBzd
ghbWGCPwzbjflosdpVTxGh0SulghNm20ukXcZJTFTTIrcE6v49AROs9oLxTDxu2D
hHdF+vtrSXdwPftSNSFy4iP6kmSaU/Z8SoXL0MQX0lAAcFdnIE76Cn4SsAmgEGpc
ONhGmmPiUPt4OuTCKQ8XcPRZYjQNVFeRpFmX5pTRnFsWUcxd8nTNqUzZ75tDX/9q
tAT8GFTK
=4IX3
-----END PGP SIGNATURE-----

--bCEAf8EA49mGCpmalh4OObUQq6N0lMMUO--
