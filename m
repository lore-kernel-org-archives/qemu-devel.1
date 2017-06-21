Received: from eggs.gnu.org ([2001:4830:134:3::10]:33881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNbJq-0008Kp-8a
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNbJp-0003Jw-07
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:48:58 -0400
Date: Wed, 21 Jun 2017 16:18:17 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170621081817.GE12089@umbus>
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
	<20170620015332.13874-4-david@gibson.dropbear.id.au>
	<20170620185145.2673e759@bahia.lab.toulouse-stg.fr.ibm.com>
	<149798664805.10485.16662705281385907661@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <149798664805.10485.16662705281385907661@loki>
Subject: Re: [Qemu-devel] [PATCH 3/5] spapr: Add DRC release method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, bharata@linux.vnet.ibm.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 02:24:08PM -0500, Michael Roth wrote:
> Quoting Greg Kurz (2017-06-20 11:51:45)
> > On Tue, 20 Jun 2017 09:53:30 +0800
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > At the moment, spapr_drc_release() has an ugly switch on the DRC type=
 to
> > > call the right, device-specific release function.  This cleans it up =
by
> > > doing that via a proper QOM method.
> > >=20
> > > It's still arguably an abstraction violation for the DRC code to call=
 into
> > > the specific device code, but one mess at a time.
> > >=20
> >=20
> > Maybe a second step would be to move DRC subclasses to spapr.c (CPU, LM=
B) and
> > spapr_pci.c (PCI) ? This would allow each device-specific release funct=
ion to
> > have local scope at least.

I was already thinking of doing that in a future patch :)

> I kind of prefer the proposed approach of registering a callback
> function via drc_new(). This would make it easier to implement
> unit tests without needing to rely on stub functions, and keeps the
> type-specific handling constrained to matters relating to the DRC
> itself and not the resources associated with them.

True.  We went from the callback to this ugly switch when we made the
DRCs migratable (well, sort of, except for the many remaining
migration problems these cleanups are addressing amongst other
things).  But moving the callback registration from attach time to new
time would do just as well.  Well I'll think about it and do one or
the other in future.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZSivIAAoJEGw4ysog2bOSJMwP/1wQCIH3SFTDQU/GXif+KNfI
wcLnQfvLcokb+rzSWfIG111mo/xmjJKxTX1MvS/BKxPjIEOkukwiDR4oV/03paSF
Hrm0YyOXhjpxjOfXYMMih8hO4XiK/mbBwo8CVueXObqj+GwKyPJ9ogaMWBUwhA0t
rGS41MaID0jH7Kn2Of86jhYz41fttNoHNR0E2cWUILPNyTq6rpY1l1WRQMGCbvEW
ZnGKBMSoGr3FFqjTHFm0cRHTrcTXKng2wJLJncKmE3XGzzeH0vAdKt3vRQHLvXdR
RwmgEUzE9a9w3chSl9ZlBt0yczPbG26ugljJn9B5JAEBO8QjHUUjOkh26E3kFPFN
c3Mz+Ietl2Xiif0m1ZFzhcOraIqRTChpLGhz3QBe3qtC5eLMsq5Z/scRkTeymjxX
A5GyO20rwI6WkXiGCL5DJR4aOZ/A1JGTDVf+Z+6vD9Rnu18Muf5rLsb2I+GTa1ul
P1vbcggbvEK22E/W9eGMaJjC87S+mttHyH8laXVL3JqT0Ntc9AGNmLzWi3Y51m+R
uM7utx4oPKtTVbbjVub+JOTjBjDkbSaBwWf1ZnxGsJIJRjAOHXgN2T6wcsjm+P2K
k63NS+DjtYgP9xvQNp4QlLItnCyYh49q5+cyhQrq94Jmywxbsmz+jF9AUkbVAalW
pCYK0m5YAvjIc6AtlLG3
=bnfa
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
