Received: from eggs.gnu.org ([2001:4830:134:3::10]:53677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXfcs-0000pd-0v
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXfcq-0007JM-Dp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:26:13 -0400
Date: Wed, 19 Jul 2017 13:00:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170719030053.GP3140@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X78YbkCBd9ye7Cvs"
Content-Disposition: inline
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 00/26] guest exploitation of the XIVE
 interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--X78YbkCBd9ye7Cvs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 07:13:13PM +0200, C=E9dric Le Goater wrote:
> On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
> negotiation process determines whether the guest operates with an
> interrupt controller using the XICS legacy model, as found on POWER8,
> or in XIVE exploitation mode, the newer POWER9 interrupt model. This
> patchset is a first proposal to add XIVE support in the sPAPR machine.
>=20
> The first patches introduce the XIVE exploitation mode in CAS.
>=20
> Follow models for the XIVE interrupt controller, source and presenter.
> We try to reuse the ICS and ICP models of XICS because the sPAPR
> machine is tied to the XICSFabric interface and should be using a
> common framework to be able to switch from one controller model to
> another. To be discussed of course.
>=20
> Then comes support for the Hypervisor's call which are used to
> configure the interrupt sources and the event/notification queues of
> the guest.
>=20
> Finally, the last patches try to integrate the XIVE interrupt model in
> the sPAPR machine and this not without a couple of serious hacks to
> have something to test. See 'Caveats' below for more details.
>=20
> This is a first draft and I expect a lot of rewrite before it reaches
> mainline QEMU. Nevertheless, it compiles, boots and can be used for
> some testing.

So, this is probably obvious, but I'm not considering this a candidate
for qemu 2.10 (seeing as the soft freeze was yesterday).  I'll still
try to review and, once ready, queue for 2.11.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X78YbkCBd9ye7Cvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlluy2UACgkQbDjKyiDZ
s5Ib5RAAgR1Vr2nQKrBRT8V+lSPDuzzoFu7K/VfL80iKlFQFA/bL0w2CzgjPcqXY
0Tpe1OZrpgTRlXpopHmSR9nczZZMTBDPS7KPXFkbNMr5juQVuh/mBEkAYlmHlqBk
aPiloqCb0JTuJYJI+vrU9jYpvlnfI3u/5NlhbWQwzsMxxYgTgEvVrt5JVrVU6RET
HzapLSPmWqUSqcJwuClE5HW81bemCwpPhRtTJEPnpC9ZINkRm9nsyzWQHZE3Z8rR
4zvlCyvPbd7QqSOI712VsEChzLaYPrpZI5hWhEwnqSU5Mp0/PDpzxbqsDWet7LGe
z12P2lqXY3m13a23M1vSF5OS6o6B9LoT9m+2ub/UW6mEAl0NvohGqjrDb07q73U1
LzpVRBPq9rX3n2Ng7pSoAvVtqyRTL7GPJ50zwZisiz56cWmO7C/ukIxdYQSMGCWs
8UrjBIHgPvaqDIwiPZMVDvIsTLD9bKwtqexiL97G/qo3cv+q5yu/qCRniLwSMoI0
GPSx8Blqgzcvmns4eddSyLi4kV4P9S2ZZvqkxRTXehCht2i9liYx/FN5d4xYflYK
6pX8tJihXEJwT3rQOpgu93MUD+RESwABYP1VmKURqKvBuSgRZOBqZM3kNDWM9ErO
j8djb8ozVebOWLSk/gHua+MIE0lTNP18/BHt9qdzs7EXaYlYkVo=
=J9D5
-----END PGP SIGNATURE-----

--X78YbkCBd9ye7Cvs--
