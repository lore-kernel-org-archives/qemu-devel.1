Received: from eggs.gnu.org ([2001:4830:134:3::10]:35808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clgbP-0004a8-Jq
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clgbO-0005Gf-I7
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:46:23 -0500
Date: Wed, 8 Mar 2017 19:46:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170308184610.GE5211@noname.redhat.com>
References: <20170308181833.32110-1-mreitz@redhat.com>
	<e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
	<91dff396-0e71-cb32-8353-edc4b644d5af@redhat.com>
	<cf2a46ae-afd3-58ea-7a1b-2de4e1d89a16@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <cf2a46ae-afd3-58ea-7a1b-2de4e1d89a16@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Chrysostomos Nanakos <chris@include.gr>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.03.2017 um 19:32 hat Max Reitz geschrieben:
> On 08.03.2017 19:28, Eric Blake wrote:
> > On 03/08/2017 12:25 PM, Eric Blake wrote:
> >> On 03/08/2017 12:18 PM, Max Reitz wrote:
> >>> In order to use error_setg() and similar functions, we need to include
> >>> qapi/error.h.
> >>>
> >>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>> ---
> >>>  block/archipelago.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >>
> >> Does this mean our automated buildbots aren't building archipelago by
> >> default?
> >>
> >=20
> > Oh, I meant to add:
> >=20
> > Should probably mention that it was commit da34e65 that introduced the
> > problem (if I'm right?).  Does that mean we have not been compiling
> > archipelago.c since Mar 2016?
>=20
> At least here on my machine it does indeed compile before that commit
> and fails afterwards. So, yes, maybe we actually have not. :-)

In that case, maybe we should rather remove the driver because very
obviously nobody is interested in it, not even the maintainer. Keeping
things around that nobody tests (and consequently, nobody uses) is just
a useless maintenance burden.

Kevin

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYwFFyAAoJEH8JsnLIjy/WMvcP/jUGKHjV5zUB1WX3bQPS7fVR
7zYsTzwjCeGshZNc9gxoKMufjw9QxarPJEQNyY4RHLQuVKmbi484AyKwhCECJ0sy
dKOkIXUfC1skAJ1fqtJLkMQZ8ot4iQkamYyBFyDF7CNJ0TYdrpXOdG2EaOI9hIiz
ck3QG4dvHyK47GPAJdreipEtFT9N7C2YNYRBnHhP8/1PdakTPKAV15GOF0qIJn0D
wZp9+zGEm+peqlagltWmK/UJnVhYeLRM44e59B3k+m/Wl+43fSkiNol/oDi65yxh
PP3aF9TSLDWbTL5qQS9+SSW+DY7sfJjD1BMfkOgFRaSpm351pCkCJq8eFd1mFGF+
nl4hd3vwTzIA4AT4X97mj++MfiBIgAFk/FmSeZFYRcYFrb8JUFrqE59Kj2QmJB64
Z0w2H0UXHMQ+S5smpc0703sfKIrpvvsnQQk0J4HOljC2ED9QaGBB9E4Nug78H2sI
uJ6sSkzQqZdrK5YPc7eBm9c1dfEMvR8XhkDdaXOiT05Zl3bFEms9XBAJX1ZwmewO
n33fdfuq5vTnwmCpyn9wO+rF3wWf+ZhzDFXm+5x6Pbi1oE6ACKmitbYXn5haL3nG
kQT8a9x9/vZ3vmzYMBH3+kBbGAfNFQPIP2zUFm1ONolAAaejJGVB9y+fmZEZlb9m
FbzD+Gsm4zwWf7DvOfBG
=OPE4
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
