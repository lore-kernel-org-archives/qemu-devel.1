Received: from eggs.gnu.org ([2001:4830:134:3::10]:35329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etDcY-0001w7-4o
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etDcR-00055i-V5
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:31:14 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1etDcR-00055D-O7
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:31:07 -0500
Received: by mail-wr0-x242.google.com with SMTP id p104so21131085wrc.12
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 06:31:07 -0800 (PST)
Date: Tue, 6 Mar 2018 14:31:04 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306143104.GI31045@stefanha-x1.localdomain>
References: <1519987399-19160-1-git-send-email-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ijf6z65S790CMqo8"
Content-Disposition: inline
In-Reply-To: <1519987399-19160-1-git-send-email-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch: add a warning for
 basename/dirname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--ijf6z65S790CMqo8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 01:43:19PM +0300, Julia Suvorova wrote:
> g_path_get_* do the same as g_strdup(basename/dirname(...)) but
> without modifying the argument.
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  scripts/checkpatch.pl | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--ijf6z65S790CMqo8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanqYoAAoJEJykq7OBq3PI0ZEH/AwLSNPBFGoQ7fzjShX3z1qu
N6ZFWPb8EBJavT6O5SiN09eyBkwtrX5K65LnsqyqAcTEm6L42+yybLlQ/TyEWniE
DhoEl8T+BmqUSKpcKhQ6TzD4ow5IgAtpds73SH1Few3LIu2tYSJ2zmrwpApZTBug
RgICVPNkF9lgetCp7qiiP2RWgI2t9YTEU5Ozh4jPxoMUuHGwvx3FQiUc8gvSkd+t
jYL+DNVxOg7y6iWunJCCTvUl28jp3mlCbH0XU5lSIbCR8avalbgsaCSpvU1Eh1eo
rYpSn+okQzvTJ+jYPkxSqNgvMfKZbMU0/x02y1Zsq6wNIVWZLvpqNXMmruWPk/k=
=Sx+i
-----END PGP SIGNATURE-----

--ijf6z65S790CMqo8--
