Received: from eggs.gnu.org ([2001:4830:134:3::10]:44009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cikHh-0003xU-6X
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cikHg-00078U-Go
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:05:53 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-41-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <40e5ccab-e5e6-e4a6-8fe1-002869e21d29@redhat.com>
Date: Tue, 28 Feb 2017 17:05:42 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-41-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DpsxQlubU1i1wfsdriFUWxkUD3H29SN2V"
Subject: Re: [Qemu-devel] [PATCH v3 40/44] block: Pass BdrvChild to
 bdrv_aligned_preadv/pwritev and copy-on-read
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
--DpsxQlubU1i1wfsdriFUWxkUD3H29SN2V
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <40e5ccab-e5e6-e4a6-8fe1-002869e21d29@redhat.com>
Subject: Re: [PATCH v3 40/44] block: Pass BdrvChild to
 bdrv_aligned_preadv/pwritev and copy-on-read
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-41-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-41-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:54, Kevin Wolf wrote:
> This is where we want to check the permissions, so we need to have the
> BdrvChild around where they are stored.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--DpsxQlubU1i1wfsdriFUWxkUD3H29SN2V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1n9YSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AiSkH/1eVAfVIX5c7lwW2Tu2M9QXpD/Etbb/6
20zaJeNjMowm0MCfm0MK8fnZUXKrASTKx+XASHiE9P7h9sQPbZCoGUo4Z3Nl+8ts
DNq415sbRvKRoVVkT4esmWsSR6DYYw1eeN9cDfjQGc0x5VrcSPWER3ns68ORXHyQ
2Usja+QRpHsw+PISxYx8GwufhhahVEkC7HP1Ch0yoRFVPagSLCzXny7F6wxhYmOz
ywjJwH8Z9neXIbTmxSnMH2XbJx4INp0kVCMipI7YjMeK5TgWHhsb8WJN4YpxgIHR
1Et6Z9HaekHVfMTHHpcwtUpmd9s5EcRmoLHeEV91fNbGb2niYg/GjD4=
=T8Xo
-----END PGP SIGNATURE-----

--DpsxQlubU1i1wfsdriFUWxkUD3H29SN2V--
