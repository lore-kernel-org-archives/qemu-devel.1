Received: from eggs.gnu.org ([2001:4830:134:3::10]:59194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXES-00042b-MU
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXEP-0006KN-EL
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:11:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1csXEP-0006IH-4x
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:10:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26BCBC208088
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:10:56 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-3-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ba4b08e7-7e8d-5210-be2c-545be4cdeb99@redhat.com>
Date: Mon, 27 Mar 2017 18:10:52 +0200
MIME-Version: 1.0
In-Reply-To: <1490621195-2228-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7l7EMNLHmEROSGSpMnkrV9Dcn0MaQ7BsQ"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 02/11] rbd: Fix to cleanly
 reject -drive without pool or image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7l7EMNLHmEROSGSpMnkrV9Dcn0MaQ7BsQ
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com
Message-ID: <ba4b08e7-7e8d-5210-be2c-545be4cdeb99@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 02/11] rbd: Fix to cleanly reject -drive
 without pool or image
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 27.03.2017 15:26, Markus Armbruster wrote:
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
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/rbd.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--7l7EMNLHmEROSGSpMnkrV9Dcn0MaQ7BsQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZOY0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AqC0H/jGyFwNYIzfB+jXCg/4d0QGoo9jczqk+
LUPmKlz63OOPxMwKxQaF3gzJ7f+lFTbVUqmCn+gUwOwJafw5f5LN8/S8ZW7Ph1Kn
1nNnF0y7uPXGMbxsiyKmToBDcDvbiiEEhRQ+swW580dIh1XFj5P6xdwv3CJQBnFA
Ui/RLDvtUA0SacdvTaLPeRsaiwXEMQ1SsuqDBmiErRDZThn6UCnlxtcZtHkY9kjf
bjPmQYeR26JXOW4Up/xYxlksXvX4m0kv3ODXesCQg+nhlmOoEtRdIZz++Sj0kZBT
E4MShqKHwm0sH61YsdVzrrRsILPddg659zHdCXxkUV6zfSOTUGY9s/k=
=wod1
-----END PGP SIGNATURE-----

--7l7EMNLHmEROSGSpMnkrV9Dcn0MaQ7BsQ--
