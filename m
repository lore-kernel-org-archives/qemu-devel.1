Received: from eggs.gnu.org ([2001:4830:134:3::10]:34058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUVul-0006E7-GS
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUVuh-0000JU-BX
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:27:39 -0400
Date: Mon, 10 Jul 2017 20:24:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170710102433.GD4083@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
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


--n2Pv11Ogg/Ox8ay5
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

1 & 2 are straightforward enough that I've applied them already.  The
rest will take longer to review, obviously.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZY1XhAAoJEGw4ysog2bOSvfsQAJsepgCFX9V4FsV3hQ0WB+rx
awTH6E2JKtLCTIXSQWHp4nNSBV8VctHDOFudYKWdBw8pb6ZNlsZ/Vrp1znxBbzjG
DN8a4PkcAgfxxBb3E4X39jZFvTqn96CNXFJQCBT/pMbG7+GC9G6307T/KkM6FwAi
RawIKheQEmVCNIKuxNurIeppEswE/Y+5IxDC5Nr43j5rQ+UBmBGDR6kMB7D2XznP
l9DVjL72X6HwqQX7tsxJQnK8X2HkpMP4fvHTQ76aNkaOYUexeitsbZ1CjKXOw8u/
B4QdttdCccAj/5pPItGddv2zXCyWqCLBd17oxFaNccy8l1b2teXyySGMCiYiZxgR
3MZX4Ji/M1im2tAyV5Vl2C8hAxVTVOskZg1AeawJtq4GCoG3/rJ5uTfjNVodCFhu
Z4Y6+tcbjBQpw/JusclDqH32DLkUHAUl+nD6xANXStZfHj3KLIngY2YS8UDYcv07
WmO/ya0BM3qddPRRzwjvtNKKQhH2AmX2wng5c8Q0noqZlk37DrySKogWzmh+ngBd
71uOm5hSa/wE/rPJ3Lp27vQOywI46LI27E4IiRFlERj90HiUhAzlYMrPpI7lQ/pW
UWqMusbL3Y+sBu0I4+7oQrAKsW9tZ5V53kWreCCsigCC/CAjyevSylseksueNZNr
fUnbjj13Qf+5LDWv0+MO
=GrI3
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--
