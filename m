Received: from eggs.gnu.org ([2001:4830:134:3::10]:58641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZfih-0003dF-Du
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZfic-0005Rq-98
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:24:15 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cZfic-0005RE-2P
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:24:10 -0500
Received: by mail-wm0-x241.google.com with SMTP id r18so5025574wmd.3
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 07:24:09 -0800 (PST)
Date: Fri, 3 Feb 2017 15:24:07 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170203152407.GH642@stefanha-x1.localdomain>
References: <165854135.894789.1486069129896.JavaMail.zimbra@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Content-Disposition: inline
In-Reply-To: <165854135.894789.1486069129896.JavaMail.zimbra@research.iiit.ac.in>
Subject: Re: [Qemu-devel] regarding codebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shubham Kumar <kumar.shubham@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2017 at 02:28:49AM +0530, Shubham Kumar wrote:
> I'm having difficulty in understanding the codebase of QEMU .There seem t=
o have hundreds of code files and header files in the directory and I'm una=
ble to figure out the functionality of each file.Is there any way to unders=
tand the function of each file ??

vl.c is the main() function for the qemu-system-* family of programs
(the "system emulators").  You could start exploring the source code
=66rom there.  That's what I did when I first started hacking on QEMU.

Be prepared to read code.  QEMU isn't an educational codebase and the
code reflects the requirements of many contributors over the years.
Most of their requirements may not be relevant to you.  You will learn
to skip the stuff that doesn't affect you and to see the big picture.

If you have a specific area you are interested in, let us know and we
can tell you which source files are involved.

Stefan

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYlKCXAAoJEJykq7OBq3PIZK4H/j5zWhvc+P4oZWTfrw/IJ1T2
9YSlcnvFYQqmeOvGCHEhsxGNZIJGeR46ewa5RNklD08YtIcrvwPPbdGcGYReNOIR
d/sWircJfr8ri9Ej9CJ3fe2FSVSzCanqcqGSDxT3E2IBucu3DDXUV/KLbgbyR7gz
y8wTlaAFtSzVxITn5IhLV2MDIqX34+enVGyB3WFioKCaY1pt7ncyv4X/acU5zuhR
NIzEkqgOKNpnSaP4qaT0QxbqXMSX7y6ij/s1+BiAw1z9dgsWoLsxOsoeE2x+Kcyi
oNQOYwyEhA5UMswfHTcUzXCbQGaBqiKdjf8HPkSwSZTwO1yesBPrOMvFEftWDiA=
=cLZ3
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--
