Received: from eggs.gnu.org ([2001:4830:134:3::10]:57937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekqCn-00048z-04
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 06:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekqCj-00083d-V5
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 06:54:01 -0500
Date: Sun, 11 Feb 2018 22:22:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180211112212.GD11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-6-mark.cave-ayland@ilande.co.uk>
	<20180210223214.GS11634@umbus.fritz.box>
	<20180210231103.GV11634@umbus.fritz.box>
	<ccd8f330-6ab2-977b-09a6-0c259398052e@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PUgybOivvlPvn0/l"
Content-Disposition: inline
In-Reply-To: <ccd8f330-6ab2-977b-09a6-0c259398052e@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2 05/12] cuda: rename frequency property to
 tb_frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--PUgybOivvlPvn0/l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2018 at 10:59:05AM +0000, Mark Cave-Ayland wrote:
> On 10/02/18 23:11, David Gibson wrote:
>=20
> > On Sun, Feb 11, 2018 at 09:32:14AM +1100, David Gibson wrote:
> > > On Fri, Feb 09, 2018 at 06:51:35PM +0000, Mark Cave-Ayland wrote:
> > > > This allows us to more easily differentiate between the timebase fr=
equency used
> > > > to calibrate the MacOS timers and the actual frequency of the hardw=
are clock as
> > > > indicated by CUDA_TIMER_FREQ.
> > > >=20
> > > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > >=20
> > > Applied, thanks.
> >=20
> > Actually, this patch doesn't compile, because you've changed
> > ti->frequency in a couple of places where you should only be changing
> > s->frequency.  I've fixed it up in my tree.
>=20
> Ah apologies there - this was a mistake I made quite early on in the
> patchset which I must have accidentally brought back in during a subseque=
nt
> rebase :(
>=20
> I've just done a check on patch 7 ("cuda: set timer 1 frequency property =
to
> CUDA_TIMER_FREQ") and confirmed that the cuda.c version in your ppc-for-2=
=2E12
> branch matches that in my local branch, so your fixups are good.

Ok, great.

> Any thoughts on the last few patches? I know Philippe had a question for
> Stefan re: the trace-events patch, however it would be useful for patches
> 10/11 to be applied as they complete the transition from CUDA over to usi=
ng
> the mos6522 device (also providing an initial example as to how it can be
> used).

Haven't had a chance to look at them yet.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PUgybOivvlPvn0/l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqAJ18ACgkQbDjKyiDZ
s5LH0RAAiKNp8rV0raU8etmdAZuCFbsUHbaW4whm49E7aPNf7ks4UN3nXaiAOCLZ
S9uHQwkyEAbUoJ66T7CAD/aWELBuvqn3WVG0HXJcnVYt/2J+lEdUqWeTn8SY5eU1
rVJsM5UsBmlRnmo3vy6ZG9wJWpw1aO7MAOykEat10WtA+Q2ifKBhq4FwGxkkCAcy
FCLsCkOrr495awe4klYr4BXvuoLGU+nwNNbb5L30VObn3VYsPtSz9K5i71aJ1kFp
cAfpv7YTUeEqGdMZa4UAwIFcuxNF+VbAfgltsEgHQ3NkOevOeUufzC4jKF39rMCf
m+Zo5kpFx5/Oceroy4aTmchvQ18F8RcjvVUdlxZLbCsB7TvWxU32I7OK2fvbYnAY
gniG6Jx7bWgTMgITltymtasGxhq53w8TKuZnN31YMgg5yIbhdv3+igI8O0vEnrVz
1GRQBv0flns2sMAPAn0d5gfK/GJyUrMOgud1D9AONIsBbtp6lJ8jNsgSsYPdYyYc
/KzwqDKU6GRvfoey4ippo9IXCzuQGrH2M2yN8G8eaSL9sh+6m0kLOJ9hLbnZ248e
Vfl7zsoYrnoGQdqh2pipPYVppADx2dFQly2hstYCGnYj0pDJW4Sfjl++DKJHVWnV
gtATqoXJxW13/JbUdTOTMSF8x5RlYxK80vOuSNS4s1nPbii7Rco=
=acoW
-----END PGP SIGNATURE-----

--PUgybOivvlPvn0/l--
