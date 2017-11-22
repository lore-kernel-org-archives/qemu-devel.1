Received: from eggs.gnu.org ([2001:4830:134:3::10]:53601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOn-0002hZ-T7
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOm-0002XT-Qr
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:33 -0500
Date: Wed, 22 Nov 2017 15:12:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171122041217.GP2380@umbus.fritz.box>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tZCmRiovzb4sxAVa"
Content-Disposition: inline
In-Reply-To: <20171120032420.9134-1-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 00/12] Add MVME3100 PPC SBC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--tZCmRiovzb4sxAVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 09:24:08PM -0600, Michael Davidsaver wrote:
> This series adds simulation of MVME3100 powerpc SBCs, originally from Mot=
orola,
> and now sold by Artesyn[1].  There are two variants differing in CPU
> speed and memory size.
>=20
> I've been working on this sporadically for the past 2 year.  Recently I've
> finished all the features which I have in mind.  If this series is accept=
ed
> there is a continuation which adds VME bus.  I've found it
> useful in software compatibility testing.  I wonder if there is
> any interest at large?
>=20
>=20
> There are two main parts of this series.  1-5 are changing code common
> with the "ppce500" and "mpc8544ds" boards, with the remainder being
> additions.
>=20
> The changes are to how the CCSR region is handled in order to support
> the CCSRBAR register which allows the whole region to be relocated.
> Also added are a couple of memory and clock configuration registers
> which RTEMS guests read.
>=20
> #3 is actually a minor issue I found recently with the mpc8544 PCI host b=
ridge,
> which I'm uncertain how to address.  The host bridge device 0:0 identifies
> itself as a bridge, but doesn't properly implement the bridge config regi=
sters.
> This confuses Linux, which then does a full re-enumeration (successfully).
>=20
> The rest are additions of an I2C controller, an I2C eeprom, an I2C RTC,
> and new board code.
>=20
> My testing has been almost exclusively with an RTEMS guest[2].
> Though I have recently done a little with Linux.
>=20
> RTEMS guests (and Linux too for now) require a stub bootloader[3] to
> put the system in the same state as the real bootloader.
> RTEMS has an unfortunately strong dependence on bootloader
> provided configuration (eg. it doesn't re-enumerate the PCI bus).

I've applied several patches from this series to ppc-for-2.12, others
I've commented on.  If you could address the comments and rebase
what's left on ppc-for-2.12, that would be great.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tZCmRiovzb4sxAVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloU+SAACgkQbDjKyiDZ
s5Kr1BAAsbq9OzMRVWYwHYqHRj02vj0wjAUWSL2WDCQGOjN59qaD1v/df/Apm2/s
xP4OGXseYwlJ3KWzrvZWBx65+jZVi/qKTSP5loH37u4R+RFGho4rkbtJ946Hof+C
YHWOM6oZR4n7FCgdv9mnB2XcIgzFQR2Wkt98jctMaLLHp1mtlgropYZ0wSzR4Q5v
K1VXeaiHVcxTztWUei/Tttc/M5ROvFdZ45A3pZbGdAYG8xFVVCm1CEw9U9PLyrXJ
8733qMpbBVLRLMieNhEHDRZ2lF1mTaAMfA1ldWT0buZKdyYv72GkHbMWflyeY63O
Nsibt/cX7pTvaWBxU+jEBteK0JozSmnC1peTfsCfCMO1EkG0pvxzqfqwQ/X5b0w7
uMEpvtrJ/oqYW9CO+tSUKgANrj2XW6Yz15UkXIadeGvoWSsOfwisQpdkbkumfaA0
fdjCIzrd3Ln1GC8krJ0P80emf1/sD9kW3k5woLPp75YSWY38fyZbyc+Zfsm7fP8C
xRHh4HQBU5wUTq67/TgpbnQbk08wAjgNCsyrBaFsdYz16FN5yAihOIxumv4FSlaE
C+A0HPFgsbLlK6wbodbiYglcwuqcOrWzJHEG4/7gtIPLKHpukl37PgfdXMq7mS1f
vuhb/vguejKAxcd59mKZl36/9oQKRCB5K16JN5klHwRfrUMvVBo=
=bjYM
-----END PGP SIGNATURE-----

--tZCmRiovzb4sxAVa--
