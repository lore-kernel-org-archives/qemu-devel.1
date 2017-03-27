Received: from eggs.gnu.org ([2001:4830:134:3::10]:35370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXUg-0006hM-09
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXUc-0005M4-2Y
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:27:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1csXUb-0005Lt-T1
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:27:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8730569E
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:27:40 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-5-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aac619f7-f439-638f-23cb-ccadd9535b05@redhat.com>
Date: Mon, 27 Mar 2017 18:27:37 +0200
MIME-Version: 1.0
In-Reply-To: <1490621195-2228-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ICPQi4tgDENFWv0VsdRrLHExV3r8rBxCM"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 04/11] rbd: Clean up after
 the previous commit
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
--ICPQi4tgDENFWv0VsdRrLHExV3r8rBxCM
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com
Message-ID: <aac619f7-f439-638f-23cb-ccadd9535b05@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 04/11] rbd: Clean up after the previous
 commit
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 27.03.2017 15:26, Markus Armbruster wrote:
> This code in qemu_rbd_parse_filename()
>=20
>     found_str =3D qemu_rbd_next_tok(p, '\0', &p);
>     p =3D found_str;
>=20
> has no effect.  Drop it, and simplify qemu_rbd_next_tok().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/rbd.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ICPQi4tgDENFWv0VsdRrLHExV3r8rBxCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZPXkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AolIIAKYelw2auHlvit2T1TzRTbZARIaRK1hz
fGWccS9svg9TLGbbN35n44QwCf8tUyeki4fqGm8w+6WHd3x1jyXzKcKOdqbB9EHd
y0QtY8jo852PJGT9zOcxiKk8E7owzyfIoRpsKqRbr5A1V7JzASahvAzCBxcx5bzD
PqoKZTcCVbiVziAbUGgoB4X7nzerUEKQQPpECh0iA9so8Bpyya9+gjrHhcw6Hwhb
vGi3LP+SOOmkPaP9EBtusY1iUG0i9Wul8nqohm9PZd+V2sWWVRL+iWEOtsBjNDoE
IjaOZWxXUzLFhMPWSOyup280rpITkN3IuM99g7SYogzgaoFkldhXKfs=
=/S+p
-----END PGP SIGNATURE-----

--ICPQi4tgDENFWv0VsdRrLHExV3r8rBxCM--
