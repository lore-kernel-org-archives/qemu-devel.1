Received: from eggs.gnu.org ([2001:4830:134:3::10]:51995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWdR1-0007zv-PA
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 02:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWdR0-00010r-Ta
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 02:53:43 -0400
Date: Sun, 16 Jul 2017 16:53:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170716065327.GP17539@umbus.fritz.box>
References: <20170714061521.28300-1-david@gibson.dropbear.id.au>
	<CAFEAcA8kQF3xS6=uQiXf6FSbP56xmStPN9SoqWy1cmzMFFUpOQ@mail.gmail.com>
	<20170715024202.GH17539@umbus.fritz.box>
	<CAFEAcA_8nhPXE6y0PnYdQfjwqhqFMzg0wGL=KxgD_xb5jnZnfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MM5RgFPKyuP3gDcV"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_8nhPXE6y0PnYdQfjwqhqFMzg0wGL=KxgD_xb5jnZnfA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/18] ppc-for-2.10 queue 20170714
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, sbobroff@au1.ibm.com, Laurent Vivier <lvivier@redhat.com>


--MM5RgFPKyuP3gDcV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 15, 2017 at 08:45:13AM +0100, Peter Maydell wrote:
> On 15 July 2017 at 03:42, David Gibson <david@gibson.dropbear.id.au> wrot=
e:
> > On Fri, Jul 14, 2017 at 04:13:05PM +0100, Peter Maydell wrote:
> >> Hi. I'm afraid this fails to build on the w32 compiler:
> >>   CC      ppc64-softmmu/hw/ppc/spapr.o
> >> /home/petmay01/linaro/qemu-for-merges/hw/ppc/spapr.c: In function
> >> =E2=80=98spapr_get_resize_hpt=E2=80=99:
> >> /home/petmay01/linaro/qemu-for-merges/hw/ppc/spapr.c:2642:1: error:
> >> control reaches end of non-void functio
> >> n [-Werror=3Dreturn-type]
> >>  }
> >
> > Drat.  Is there an easy way to test compile for w32?
>=20
> I have a cross-compiler set up on an Ubuntu host; you
> can do it on Redhat hosts too; instructions on the wiki
> somewhere I think.

Ah, thanks, found them.

> In this case I think you're either getting caught by the
> age of the compiler or because this set of w32 headers
> have a bug where assert() doesn't get marked as fatal
> somehow, so it might or might not manifest on other
> w32 cross build setups.

Ah, right.

> > Yes, seems good.  Should I resend, or will you adjust in place?
>=20
> You'll need to resend -- I can't modify signed pull reqs.

Ah, yes of course.

I've also realised one of the patches breaks make check on Travis OSX
builds for reasons I haven't quite fathomed yet.  Investigating.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MM5RgFPKyuP3gDcV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllrDWcACgkQbDjKyiDZ
s5IDgA//ehZUoZKT8hwrQVbVcN1FNKHoglbO4CIslt1fxvzwRf7zTlagSBw3bHdG
zYZICdn47USbSjZmr8ylpPQgOE5zJKmDw+o4PQwsQdglP+HR6tCpUNXA45/cwVC0
UlosPOPTKlx++9XJXtLqZ921qaekjySvERXPg+1+GcGxDiLsZlpPAvzAuirG10zx
3N3LXeRw0/40PIZnUP0mQA9jFcRdoF36jFSC3SaMfdHnDjoJEnCcD8WRYtEaK4cu
mKQRJWBqgpvxrF4NbexrudQhjy309aCxdcsSGewAgEzP0wTAUNYQJct6FbCdvnA3
NwQvMSiF8tvZSuAFae7fU3TG7QZrjqfxzEmqlgeLXbK/wR/uBbjSwc7OiC5GotmR
k6C1pCxzI/hI46dVUZM+/OnDErAXENcoyq+nK6wddZfdRlTKfYT6ykrNYIlySW6/
XKmqYyn809zwbq2ugg/6dT4C//0UucxY2f0KH63304dd1vfu0qyUPEH/FxLRcnKg
AHWA99A+Kv/KbGKdLKP2WzZ24on152v6rSQgL6WDBbG4xPucX2bZKB3++FSHOJ8e
KlT3LjVhJOXAzetWk2X1B/rffwjZ80DF9By5oag1U9aqJigxr4MzbxplzO0myCF5
C8LT0erB2vSpgH9gefWB4E5DQRCQ1UFF3jtzVFvwChbAiN7mvvY=
=g4hh
-----END PGP SIGNATURE-----

--MM5RgFPKyuP3gDcV--
