Received: from eggs.gnu.org ([2001:4830:134:3::10]:48120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTgHE-00031c-Ds
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 00:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTgHB-0005iu-8q
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 00:23:56 -0400
Date: Fri, 15 Jun 2018 14:08:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615040830.GQ4129@umbus.fritz.box>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<8c404c8c4ee1bfd2e4d079877d481094f797df8f.1528291908.git.balaton@eik.bme.hu>
	<6aa1bc4e-a4b0-d7be-b9eb-85dfe8c06781@amsat.org>
	<alpine.BSF.2.21.1806061920120.94568@zero.eik.bme.hu>
	<20180613041115.GS30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131044020.620@zero.eik.bme.hu>
	<20180613100339.GK30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131603270.90524@zero.eik.bme.hu>
	<20180614012754.GB3042@umbus.fritz.box>
	<alpine.BSF.2.21.1806140951530.19899@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JaBjgNvtdKe5H086"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806140951530.19899@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 5/8] hw/timer: Add basic
 M41T80 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--JaBjgNvtdKe5H086
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 09:54:41AM +0200, BALATON Zoltan wrote:
> On Thu, 14 Jun 2018, David Gibson wrote:
> > On Wed, Jun 13, 2018 at 04:13:57PM +0200, BALATON Zoltan wrote:
> > > I don't see the problem. The addr register selects the register to re=
ad or
> > > write. It is set by the first write when the device is accessed the f=
irst
> > > time (this is denoted by addr =3D=3D -1 (or really any negative value=
). The
> > > device has 20 registers and trying to read any register outside addr =
between
> > > 0-19 will result in returning 0 and logging a warning about invalid r=
egister
> > > in m41t80_recv. What could fail here when guest sends garbage? It wil=
l set
> > > addr to invalid value and try to read non-exitent register and get an=
 error
> > > just like for any other nonexistent value of addr (or start to read f=
rom
> > > register 0 if it manages to set a negative value). All writes of regi=
sters
> > > are ignored currently (except setting addr by the first write). What =
should
> > > be enforced here?
> >=20
> > Ah, I see your point.  I mean strictly we should match the hardware
> > behaviour if you write garbage addresses here, but really I don't
> > think it matters much.
>=20
> Problem is like usual I have no idea what the real hardware does. I've on=
ly
> seen the datasheet, never seen real device and have no way to test. All t=
he
> clients I've tested seem to be OK with the current emulation so unless
> someone has more info on how this should work I think we can live with th=
is
> version and then fix it later if found to be needed.

Ok, fair enough.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JaBjgNvtdKe5H086
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjO7wACgkQbDjKyiDZ
s5L0HQ/+Jg4YHBK/nmDV2Dd8VkEfPBY+cHHHKhTeL+m/3Y/gz2DKz5cxd0q3H3sn
VT+o/ojv3h2GasjKHPQBigNpaxl0g2fcy8S0VLPebAVMV+I07gvaN+gthLZMAAGL
l6fTYVCkucDqdNXzX/IxkNRYbVAS8OPTWSu5RHeQQHlqmOJyP0JXQPgqHtwC6Ect
cE0rNS7rzpRGJkAOE/1HsbYElp5Wg+ideFn5jMa/Q46GFP6Unp27gISTHeQ1duLO
u0YaCkkzZcRXpPIQTUJGJjQuvVr1/SaYhQNU3FDgxuBeXRRKTCrE0v2fsIFKGADq
pqBKhixcLAAH3tZzUjcEErDdtFx5Ev+1BTxTkEn5Zl2p+lzL1ewJ30Iyln+BRh8X
Eqzdxtk3psDjIUKIU6Lw8aQHSBxHXMh1SO/G1Ci6zLKFzh8ggIAbcOlWHYgmv1WA
eamMXA5AEe5g8NnNE6YIVeE2sO5hGC70t36NNcef+8uSbj9Lm98/hM8p1zJkhvLD
ufsCH8capxoftdJxF7YQXXs+79pnGnMXEomskHsRS08bJFMx/fG7R/sCUnZPHSCV
jzPJrr3MlFDv//JTH8zXfNYU6VRQcj9sS5N/2MP8d6HMF93zhEtG7OretrEnvbUS
xAicAzMkXM28UARxnV2/JJYvGJuXmDAUEZ8uy449VjL5HIXXCgE=
=tLhn
-----END PGP SIGNATURE-----

--JaBjgNvtdKe5H086--
