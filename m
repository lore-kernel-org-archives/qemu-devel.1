Received: from eggs.gnu.org ([2001:4830:134:3::10]:46328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAyNR-0004vV-SQ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAyNO-0004QG-01
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:48:29 -0400
Date: Wed, 17 May 2017 13:48:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170517124822.GF8260@stefanha-x1.localdomain>
References: <20170516001150.11508-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Content-Disposition: inline
In-Reply-To: <20170516001150.11508-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] oslib: strip trailing '\n' from
 error_setg() string argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 09:11:49PM -0300, Philippe Mathieu-Daud=E9 wrote:
> spotted by Coccinelle script scripts/coccinelle/err-bad-newline.cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  util/oslib-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please send multi-patch series with a cover letter and proper patch
numbering ([PATCH 0/2], [PATCH 1/2], [PATCH 2/2]).  git-format-patch and
git-send-email normally do this.  It's important so that patch
management tools and continuous integration systems can track your
patches.

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHEaWAAoJEJykq7OBq3PIpJoH/0vWGUIn40Ic36J/yaA0wAwk
/CPm7lLd+Rj5LrHdy+rWcU9cSD7hUgVdFo9l4tbcKLHSjTunvIymsWxlLoNYL4g0
sGi7bEhg9jTMjkMsACvJmpO3FMxYkURZBtbkO+IOQsAv8FrH8dWyFttoym7cGciO
8/5WRzTPL8zJjOoxDKtaQkso+pjOrB3/7dEijF49FolVatzy7TqhfSuYuYHCxDCK
XSNrBTMc2rCJjeyrFxb5E8rd5zTre4YT/ZSEjnxAaciOIHxglx7fbxaJbwaspRy6
CfPmQJHYWx6ZzDWTiyfhe4JbuaHqw5WcU75qFLw0ASKG0kCF3xj0A+1JuRrkJpU=
=7koE
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
