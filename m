Received: from eggs.gnu.org ([2001:4830:134:3::10]:50601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUvQK-00060r-AZ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUvQH-0005mE-3l
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:41:56 -0400
Date: Tue, 11 Jul 2017 23:27:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170711132751.GJ4083@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-4-git-send-email-clg@kaod.org>
	<20170710102655.GE4083@umbus.fritz.box>
	<9a7a16a0-f14f-bc65-d503-e2aee028633f@kaod.org>
	<1499720443.2865.15.camel@kernel.crashing.org>
	<57c22926-8ac9-1251-aba9-590b344673c6@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="huG+SbfbdD6eblZQ"
Content-Disposition: inline
In-Reply-To: <57c22926-8ac9-1251-aba9-590b344673c6@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 03/26] target/ppc/POWER9: add
 POWERPC_EXCP_POWER9
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


--huG+SbfbdD6eblZQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 11:01:15AM +0200, C=E9dric Le Goater wrote:
> On 07/10/2017 11:00 PM, Benjamin Herrenschmidt wrote:
> > On Mon, 2017-07-10 at 14:49 +0200, C=E9dric Le Goater wrote:
> >> On 07/10/2017 12:26 PM, David Gibson wrote:
> >>> On Wed, Jul 05, 2017 at 07:13:16PM +0200, C=E9dric Le Goater wrote:
> >>>> Prepare ground for the new exception model XIVE of POWER9.
> >>>
> >>> I'm a bit confused by this.  The excp_model is about the CPU core's
> >>> irq model, not the external irq controller's.
> >>
> >> yes this is true, but the POWER9 CPU is the only criteria we have=20
> >> to distinguish a machine supporting XIVE and XICS from one only=20
> >> supporting XICS.
> >=20
> > Why ? I don't understand.
> >=20
> > We do want an EXCP_POWER9 for other things, like the fact that we have
> > a separate interrupt input for hypervisor, with associated vectors
> > etc...  but that still doesn't relate to what interrupt controller is
> > there.
> >=20
> >> My idea was to use this flag to activate the OV5_XIVE_EXPLOIT bit=20
> >> in ibm,arch-vec-5-platform-support ov5_platform, like this is done
> >> for the MMU. See spapr_dt_ov5_platform_support()
> >=20
> > I disagree, the MMU is in the core, the XIVE isn't. It would be
> > possibly to make a P9 core if a XICS in theory :-)
>=20
> ok. I understand. We could even "build" one in QEMU. HW would be=20
> another story ...=20
>=20
> So should XIVE support be a sPAPR machine property only enabled if=20
> 'cpu_model' matches "POWER9.*" ? The XICS/XIVE initialization is done=20
> quite early in the machine init so this needs some checks.

Basically, yes.  The interrupt controller setup is generally something
the machine looks after.  What I'd actually suggest is a machine
parameter for XICS vs. XIVE, whose default value is based on the CPU
model.  Just as we could build a POWER9 with XICS in qemu, we could
build a POWER8 with XIVE.

>=20
> >>> Now.. I could imagine the POWER9 having a different core model that
> >>> came along with XIVE, but I can't see this new model being used for
> >>> anything anywhere in the rest of the series.
> >>
> >> See patch 26. But, maybe, I am taking a shortcut and we need another
> >> family of flags.=20
> >=20
> > Or just some kind of enum for the interrupt controller, how do we do
> > with OpenPIC vs. XICS already ? Old POWER3 had OpenPIC.
>=20
> AFAICT, we don't have such a CPU in QEMU/ppc.

More to the point we don't have any machine type for those old POWER3
setups.

> We could use some extra flag to change the ICS behavior. The path I am
> taking duplicates the ICS code but in real, we only need to change the
> irq handlers.=20
>=20
> Thanks,
>=20
> C.=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--huG+SbfbdD6eblZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZNJUAAoJEGw4ysog2bOS9ToP/jELz9qwxWYj79Bbci7K0bN0
jl8sq6wBjiXCsp/xmyb9gdHa2cvfCWylTsokJGo/89wc2Qyvgs6DvhejBocBu8Nb
KNlVhJbfkif8O0SjM8QvmiILWnqvBYRCc24smT7bugm2wYUGLkeW33+36wdJpsV0
B5ixhT4iEsu2OqcC8UJoC2Xu5VGy+5cfc/Zw2gyGLXc7JgzNRz4EYFdv/7lRSnza
Q04UbqJ51uICkRhBTjR7O0LYmbIlkmwoNQsgrd8h5hlr2iY8A+yppWgPqCSoZ9uZ
qJmzCu4xEGgd8UKMH8+C0WPNAwsYpkPPvJjExVwuBABj3W+yRKaunxoxo72W6J2I
yx2IiyluXMUTjjlWl6jdvqSByJYN25ZAaLMrOGR3fxhYa7DLHTxHtiM9wGBTBsGe
PI4k30+oZlF8B2CmDuvcTDCKmj6NrVZgiOEu04RQsidYHnElcxzEo1pGe4A6cz2U
cpuvGTbaobXEeltnLbd9rB1hht/63ggRE+1lppH2pMJhnfTsO8Cl0PwieYc3vRRN
cuAvA8ebrNUslG0c1S+0ajXNXGAjqe2G5iB6zVVcgPyULUb/YFpL0QdJzFZHn+nV
bVPjNvRn4Oy55PP6I8kBKHjy9XH2Fvf1kVuU2Mul6j4I5vurBSTznu5Pv4RX+iYk
zlyCbJ1BERl8UPhKK3L0
=6JuX
-----END PGP SIGNATURE-----

--huG+SbfbdD6eblZQ--
