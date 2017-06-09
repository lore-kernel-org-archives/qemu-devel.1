Received: from eggs.gnu.org ([2001:4830:134:3::10]:53031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJHbM-0007j1-AI
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJHbJ-00061B-8W
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:57:12 -0400
Date: Fri, 9 Jun 2017 20:27:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170609102714.GK26521@umbus.fritz.box>
References: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
	<20170609020141.GB26521@umbus.fritz.box>
	<87mv9heota.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OX2aLCKeO1apYW07"
Content-Disposition: inline
In-Reply-To: <87mv9heota.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH RFC] spapr: ignore interrupts during reset
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net, alex.bennee@linaro.org, bharata@linux.vnet.ibm.com


--OX2aLCKeO1apYW07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 10:32:25AM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Thu, Jun 08, 2017 at 12:06:08PM +0530, Nikunj A Dadhania wrote:
> >> Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.
> >
> > Ouch.  When exactly did this happen?
>=20
> Broken since long
>=20
> > I know that smp boot used to work under TCG, albeit very slowly.
>=20
> SMP boot works, its the reboot issued from the guest doesn't boot and
> crashes in SLOF.

Oh, sorry, I misunderstood.

>=20
> >> When reset happens, all the CPUs are in halted state. First CPU is bro=
ught out
> >> of reset and secondary CPUs would be initialized by the guest kernel u=
sing a
> >> rtas call start-cpu.
> >>=20
> >> However, in case of TCG, decrementer interrupts keep on coming and wak=
ing the
> >> secondary CPUs up.
> >
> > Ok.. how is that happening given that the secondary CPUs should have
> > MSR[EE] =3D=3D 0?
>=20
> Basically, the CPU is in halted condition and has_work() does not check
> for MSR_EE in that case. But I am not sure if checking MSR_EE is
> sufficient, as the CPU does go to halted state (idle) while running as
> well.

Ok, but we definitely should be able to fix this without new
variables.  If we can quiesce the secondary CPUs for the first boot,
we should be able to duplicate that for subsequent boots.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OX2aLCKeO1apYW07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOnf9AAoJEGw4ysog2bOSHvkQAL1E1MA4yTf8M/Ro+i53m4ww
3yIBld1t0YEDkXhtq+Wvx5NRAJxE1Y1SiuOlpfwLOsL+Qxd7DUidXURyY12n3lO+
cZfKISCFv/enwEKVszualzkhJjFhFZHqQUqskiAx5IZuSao+EGDsgq1qqY4ZP+3T
xRLsRqbBYvXrTSU8+BYj2OrG3cmuB4L0U9LfMS+VehVM/oWWKDVWCU+uSSWtu347
R8tQft+9Pt8kdxiPYqaL6SpE07UntWKVGjHYCXejldBHf09j65vKQwEGIt6tEz74
xqpHp6Cqsdp04e1DD8YNd+FpMZGtSEEH2JQb2ItPiKhMT62md0/i9OTm18OtQVs9
gW3w3izapJZjq3qJzE1XsbNxXjerEYopLLlcFXswVIMchln9ZQq4W/+1WJj1wU7O
IZ4BWvOKxpuyn4a4UvsmOr3YBIU4iMkGxJAPv1NEdjnvqPxSrXhrx61kdH8U4JR4
aQo84wnHiWt287/fjXjgFGrCNwxEF+H/n0PYmB4TJaWGECZTdlKbq0WwGpPy3gfo
s9hbJv7Xa8CY/lpEHa2iyr7Ze7xtFQ73xb6o7AAjBNEHnuRuDzWfN5MsU9h5zmSI
TtAK6tLHVKueM5EkCJ/oV80jStNJu6wWUJTFZHjo/Hpjyn36f17lACPOeEkfWb7D
1bxWGlH7qZq6GlPeYDWT
=1ViN
-----END PGP SIGNATURE-----

--OX2aLCKeO1apYW07--
