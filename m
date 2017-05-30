Received: from eggs.gnu.org ([2001:4830:134:3::10]:37752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFf4t-00042C-Ia
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFf4s-0003JO-F1
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:12:43 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFf4s-0003JI-8W
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:12:42 -0400
Date: Tue, 30 May 2017 13:12:40 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170530111240.jlcouhb3yheeiove@aurel32.net>
References: <20170529193016.6888-1-aurelien@aurel32.net>
	<20170529193016.6888-2-aurelien@aurel32.net>
	<20170530101840.GB25884@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="smldxgonidhpi6it"
Content-Disposition: inline
In-Reply-To: <20170530101840.GB25884@stefanha-x1.localdomain>
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


--smldxgonidhpi6it
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-05-30 11:18, Stefan Hajnoczi wrote:
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
> Had to drop this series due to a merge conflict.  Please see my reply
> regarding qemu_system_reset_request() with info on how to fix it.

Ok, I'll do that tonight.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

--smldxgonidhpi6it
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEd0YmQqnvlP0Pdxltupx4Bh3djJsFAlktU6gACgkQupx4Bh3d
jJvp1w/+PKiLICcgZ1v57RR2HPAunqf+00wJwB+cvkc1yEc1eYiTG4J3CmAoCGVL
Ag/Un+66+W0FMLRIb2kaEUR5z9Vo9qXjbEJq2xRCcbe9el2cM4WlADn0gyAw5QSW
bE/pGHjkfqHH+xMjc2CUqE3gEWvzxPqgMVJ2lhVcI9u3r5BNBzA6uZ60SVRVu1mI
JfRqnZpAXLtu+WrWHWGTxHQbv0ZXsHCrnb/KdW4JEUtqee+PNX3XVZwrsOczKGbO
IIwyjmIVbt8YgPC9QsfGT79B6zaLpmdEO45EsBG8htCGmqJghOS01h8+m+WizTH1
/1BCCWRPwQOKT3lEG7Gmfs3KpIEY6qw8/mD360uXVMoyBK63TFmhLdu2jbsikYnb
8ayrf9VdkldO+pkLZWujZ6+LXBdHqTqUiwL2FXpG1XH7PpJ+wTc2jullWX3ENs7W
YNNw4DCxIGLzeopVNd9XV81bLLES5btY1dWVQCPD3uj7Ew5uNfVTS0E9CgRe2mVF
T8br2lQFooW6qfqSSagbU8VwqoDh/JxSnHiOIqp993hSusv4l2tBBWdWKjUj00xH
k/8dbvUcsuQw1mDyYjdy74QwLAZ8M8AY1ljZeRsIqrDaxfoQIiRYEORBYzkMipVN
9mUFLCDqXRSd6BIAgBMrm9tW7Luir+ksSFveUzw/z0bpbGmDvY8=
=UYwy
-----END PGP SIGNATURE-----

--smldxgonidhpi6it--
