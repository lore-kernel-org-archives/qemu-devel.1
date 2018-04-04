Received: from eggs.gnu.org ([2001:4830:134:3::10]:56839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3gHh-0006ZR-RZ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3gHg-0006ov-MK
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:08:57 -0400
Date: Wed, 4 Apr 2018 20:56:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180404105659.GC20851@umbus.fritz.box>
References: <20180402150254.38B857456A2@zero.eik.bme.hu>
	<alpine.BSF.2.21.1804041123590.39205@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1804041123590.39205@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] roms/u-boot-sam460ex: Change to
 qemu git mirror and update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 11:27:09AM +0200, BALATON Zoltan wrote:
> On Mon, 2 Apr 2018, BALATON Zoltan wrote:
> > Now that we have a mirror of this repo on git.qemu.org change the
> > submodule to use that and also update it to latest HEAD which has a
> > commit to fix a dangling symlink.
> >=20
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > ---
> > .gitmodules          | 2 +-
> > roms/u-boot-sam460ex | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/.gitmodules b/.gitmodules
> > index c613722..49e9c2e 100644
> > --- a/.gitmodules
> > +++ b/.gitmodules
> > @@ -45,4 +45,4 @@
> > 	url =3D git://github.com/hdeller/seabios-hppa.git
> > [submodule "roms/u-boot-sam460ex"]
> > 	path =3D roms/u-boot-sam460ex
> > -	url =3D git://github.com/zbalaton/u-boot-sam460ex
> > +	url =3D git://git.qemu.org/u-boot-sam460ex.git
> > diff --git a/roms/u-boot-sam460ex b/roms/u-boot-sam460ex
> > index 119aa27..930735b 160000
> > --- a/roms/u-boot-sam460ex
> > +++ b/roms/u-boot-sam460ex
> > @@ -1 +1 @@
> > -Subproject commit 119aa277f74a4a2d3f7ab6c9471292308eba14e4
> > +Subproject commit 930735bdd6edbb0588d6a54882feb58ab3cb2d08
>=20
> Forgot to cc MJT and mark it as for-2.12. Will this be taken before relese
> to fix dangling symlink in tarball?

Ok, I've applied this to ppc-for-2.12.  Unfortunately, my queue is
blocked because of a regression in the SCSI code.  I believe a fix is
on the way, but right now it means I can't complete my usual test cycle.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrEr3kACgkQbDjKyiDZ
s5Lo1BAAttR6Z5XPRpG8S9i+NFS/9lxhgE1LU+HO6yoP4rkPQcOWqZfIb/23qODm
KjjeBJ9+0VXz+u5o57YygvPWPbWXmsZxFvvhgEidZwuN+oCSFSN8/yu2DRaTHOje
aGSmJVQ43WmLBo6wmho/h+HUrTH9pEjVoscm4ckMZQhSVGlJTGl6ywH9AwxIH/L5
a1bRzX6lpJxLVJNGfWsmnp5/XzjGtpB+N1FT4utx63mIgDZKkMBVAiQ2zo+pCV06
BS/8qhybetBldfpeJ7rQNcKB8QCIpOkwIGT+Ha+/UymmhpcfX07PWY9ED9GzNFuD
Jzz0pdX/qI8HIoZ+z9I4LR08bEOWHrQ1VeRdngQJDj/Apa/tWmZTR5RlhGHGCieA
1VRDd58Le2pWzFsYqx+iOCJncGZMilzpeqiaxE9tiSDQzNhUMNdaWRYeZKLnGdLb
++4gI3hgoLhfmcLiEcwoZgabJbtQa33f1FKyd9YtIU/uLz59ciIRQGoXOEP7SXCL
DYwrUJhjvRzfJVWi0D4P9YeqFahWQ+cf7d4SsFW3MvZArjJn0u70kPi6cl7nbA8G
iOQZi1tIoLq+EEnqenTsMWTRrSUX1kV0oV7sLIeO61BEC35hFpZUS0nql7WLboDl
yO9OtZEXj3FiSRe2nOiPuPMq3qF/FMD0pSCg8nb0CfhqceMiu7E=
=Om4c
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
