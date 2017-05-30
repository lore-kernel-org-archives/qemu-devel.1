Received: from eggs.gnu.org ([2001:4830:134:3::10]:48661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdpN-0006SR-H9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdpJ-0004uT-Lx
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:52:37 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFdpJ-0004uE-Dx
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:52:33 -0400
Received: by mail-wm0-x244.google.com with SMTP id k15so23944631wmh.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:52:33 -0700 (PDT)
Date: Tue, 30 May 2017 10:52:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530095230.GP11362@stefanha-x1.localdomain>
References: <20170529193016.6888-1-aurelien@aurel32.net>
	<20170529193016.6888-2-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZMy3ZKywLyoHonN"
Content-Disposition: inline
In-Reply-To: <20170529193016.6888-2-aurelien@aurel32.net>
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
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>


--7ZMy3ZKywLyoHonN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2017 at 09:30:12PM +0200, Aurelien Jarno wrote:
> qemu_log_mask() is preferred over fprintf() for logging errors.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/sh4/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't see a pull request cover letter but your git repo is up-to-date
and the pull-target-sh4-20170529 tag is signed correctly.  Therefore I
have merged this pull request.

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--7ZMy3ZKywLyoHonN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLUDeAAoJEJykq7OBq3PIqREH/iemiCa/nQA8KC+6Vofz7vIi
Lm9V3KqPSCuevC1KAKSN5vXAmdP4pb+ZRLojUVCBIF12QSjAFZa+JAwUtxGimtKH
qvqxFs9vulhj85tjcutK0zyBVeYV7Vb7teN2coa8tcehmX2iAv1jq7/F3UTx9Bd/
3NxQx2Z6VrtG0IpOW3g8L9+iK42Fm0l7u1tt0G/j+NTcJvZAHiEE98WEglK6XkW5
Lm9x8O4elp1fRKG1hiGjY7RSI/OJWofTGGEOxrfz/Tl9pt9q1d+JgiY+T7FjFm/v
GmG9NRp9peW+s8HvepgNNJneFppFGDuWXW/qAsdGDjXVsoqtUmdClYcNdCIMc8k=
=z04B
-----END PGP SIGNATURE-----

--7ZMy3ZKywLyoHonN--
