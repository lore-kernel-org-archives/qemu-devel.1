Received: from eggs.gnu.org ([2001:4830:134:3::10]:37737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFf4c-0003vc-Gd
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFf4b-0003H8-Gs
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:12:26 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFf4b-0003H1-Ba
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:12:25 -0400
Date: Tue, 30 May 2017 13:12:23 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170530111223.yiibyjcfljjt53b2@aurel32.net>
References: <20170529193016.6888-1-aurelien@aurel32.net>
	<20170529193016.6888-2-aurelien@aurel32.net>
	<20170530095230.GP11362@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zsxz7pmqsjel4run"
Content-Disposition: inline
In-Reply-To: <20170530095230.GP11362@stefanha-x1.localdomain>
Sender: Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [Qemu-devel] [PULL 1/5] target/sh4: log unauthorized accesses
 using qemu_log_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>


--zsxz7pmqsjel4run
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-05-30 10:52, Stefan Hajnoczi wrote:
> On Mon, May 29, 2017 at 09:30:12PM +0200, Aurelien Jarno wrote:
> > qemu_log_mask() is preferred over fprintf() for logging errors.
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Reviewed-by: Richard Henderson <rth@twiddle.net>
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  target/sh4/helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> I don't see a pull request cover letter but your git repo is up-to-date
> and the pull-target-sh4-20170529 tag is signed correctly.  Therefore I
> have merged this pull request.

Indeed, I send it to your email, but failed to send it to the mailing
list. Sorry about that. I'll try to do better in the next pull request.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

--zsxz7pmqsjel4run
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEd0YmQqnvlP0Pdxltupx4Bh3djJsFAlktU5YACgkQupx4Bh3d
jJvJxA/+JQHfELDElf4hL/7BhF6n1Xpk4tyt46ceZlLF8X92Pw0UJ21BCBF8v/OT
HHPJTVq0USLqYeOtWZmgiTJaedNIX/vb6Sgi6R7WHXZgTMQtsIHvjwAA6STDYv0Q
xtLRk9BRFkVK9GkxpOm8y7WV2KrW0T7l/f6SnLpCTk4ptFTZhMcIA566omSdkxIB
lY4teJ9oP/eu1IxXMibeF0z7whJXC9JM/wc2SUc1gnp8mdhjujyAmA7bV0irE2bu
j931QKkjvGEuymmNsgrA9B4QNpRwP9Do+l5wQxIy4bJTeVHHPwWgHOu6yMB7nvXD
WTX+7Yj3npBwry+y7hJQ54F34aI4udxUzDPzs3w/fH9xLoG/drZFqe1ammOCoJot
k1r1KWP9i6fEiGQMc8arXsufntbhrCgQ0Xc6H0tjOnNz91Caox13D0raqiJUfT72
EcKsugxOF/erUOO+mjQ6h6W/NwQXA9yQCQa1bQFATCxGNdwP8faD+FemYFUHck9d
RJm7p8H6WJoqUMeBrtUCbtl/8XPXCQSo8FFJ7aN9Qzwhf8qJ3VLe2XDPZPKMdhvP
hOPbK+re0AamhzBzIOtUa5ANna+itTH4ORbouuQDzYu8QZ38crmRESSVtjk7OlSw
vwmcLzkk55MGNh3OvhBKUkbOEjcejdOGpRfrxnblKgm7vvU+wuA=
=mFEv
-----END PGP SIGNATURE-----

--zsxz7pmqsjel4run--
