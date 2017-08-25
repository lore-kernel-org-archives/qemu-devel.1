Received: from eggs.gnu.org ([2001:4830:134:3::10]:56134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl6pS-00063h-V0
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl6pP-0001Zc-PL
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:06:46 -0400
Date: Fri, 25 Aug 2017 15:05:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825050551.GE2772@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ac6a19d43a6d36ae6f7cab99a1ac25d2515339ad.1503249785.git.balaton@eik.bme.hu>
	<20170823023945.GM5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708231108430.76247@zero.eik.bme.hu>
	<20170824023552.GY5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708242222520.96438@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1708242222520.96438@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 13/15] ppc4xx: Add more PLB registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 10:28:15PM +0200, BALATON Zoltan wrote:
> On Thu, 24 Aug 2017, David Gibson wrote:
> > On Wed, Aug 23, 2017 at 12:16:24PM +0200, BALATON Zoltan wrote:
> > > On Wed, 23 Aug 2017, David Gibson wrote:
> > > > On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> > > > > These registers are present in 440 SoCs (and maybe in others too)=
 and
> > > > > U-Boot accesses them when printing register info. We don't emulate
> > > > > these but add them to avoid crashing when they are read or writte=
n.
> > > > >=20
> > > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > >=20
> > > > I'm ok with stub implementation, but I'm a bit uncomfortable with
> > > > registering these DCRs unconditionally rather than just on the chips
> > > > that actually implement them.
> > >=20
> > > Problem is that I don't know which chips have these. I can only try t=
o find
> > > out from the U-Boot sources where a comment says these are common reg=
isters
> > > for all SoCs (in u-boot/arch/powerpc/include/asm/ppc4xx.h:
> > >=20
> > > http://git.denx.de/?p=3Du-boot.git;a=3Dblob;f=3Darch/powerpc/include/=
asm/ppc4xx.h;h=3D45ff5dbacd9243e83bb2f6551e2dd64a7e544bf5;hb=3De2351d5cf1e9=
7408b4c52bafeaa85e0ca85c920c
> > >=20
> > > while looking for this I've just noticed that u-boot has removed ppc4=
40
> > > support just before 2017.07-rc3 so this is the last version that stil=
l has
> > > these files). So if that's true it should be OK for 405 too.
> >=20
> > Ok, just to make sure I'm understanding correctly are you saying:
> >=20
> > 1) You suspect these registers were actually on all versions of the
> >   device, they just weren't implemented until now.
>=20
> That's what I suspect from the comment in the file quoted above but I don=
't
> have any other evidence.
>=20
> > or
> >=20
> > 2) The registers are definitely on only some versions of the device,
> >   but you're not sure which ones
>=20
> I don't know any of these devices very well and have no definitive sources
> to confirm so I'm not sure but I think these should be on all the versions
> (at least on all three that QEMU emulates, namely 405, 440 and
> 460ex).

Ah, ok.  I couldn't seem to find any relevant manuals either.  Ok,
given the scanty evidence we have I'm ok with including the registers
always, as proposed.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmfsCwACgkQbDjKyiDZ
s5J7Ag/+K/MK4lCEFG6LnRaA6DtPklIiAIDzDorNp6Pnpo/bJePZBbxy80EyQgvw
pYjLJIy8aieNQz4XTjSmnJZwQPyj2aAqO6u6f8kOpS7rprBc6r2oPVz5+fKPPQ4P
zqaCmQl6uVk/3xUxkCpe+Fr0lPpwlMpMlzLSWXHTFATwHW66G6WZvWVD39HabSAZ
d1D2LYc52BPWOl+SxuOdiBNsPaMFanr4tt+Zt8p/b+ivhuToAmF2cc8zsm00+8OQ
0D8VtZZ14nvi/yOPk/bSm9siNPAdb0Wq64lrtQz3uwldQMOboXXs2W+FiJt5moJO
XcMX93n3wlsvQvDD0iigcDLzRrKjh+4pvwUmezcvI/KyuX2mK0fIwRKVRPpdOkXA
5ZK2SI6uq6w0xoaGDoY5dRDpEXj6zQdiExnlSN4KOW8k7VEulyJ/YfusD6LFsgd+
tqlZmad4wtQ4fypJpyvuhEon+jTrei5Ug5AzDFUhRH/vTMMy68sPkDXnJ+Wdx95J
28PUXToqIFoNeUwx03kOVZsFtebKezLi4tE/G71xvqaa2ZlAIeGhgFy9B+v0ClTQ
T7yQtUCjlv8K5bFfM9cgDUi4NEI4cuxbi0cVcBbq99E/thKtPtwCYxyMPcN/o9p9
kqQbxewA4JVEnkp7lf4h7FyjWipOJSMlj9QwzxdHdBO/+X7351c=
=mCcn
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--
