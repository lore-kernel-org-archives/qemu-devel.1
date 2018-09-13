Received: from eggs.gnu.org ([2001:4830:134:3::10]:40365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0IvS-0001Qp-H7
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0IvO-0006wr-KH
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:08:18 -0400
Date: Thu, 13 Sep 2018 12:11:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180913021138.GQ7978@umbus.fritz.box>
References: <20180730171748.18562-1-clg@kaod.org>
	<33c16125-8127-a24a-718a-361f0066b853@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v+Mbu5iuT/5Blw/K"
Content-Disposition: inline
In-Reply-To: <33c16125-8127-a24a-718a-361f0066b853@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/1] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--v+Mbu5iuT/5Blw/K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2018 at 10:04:05AM +0200, C=E9dric Le Goater wrote:
> On 07/30/2018 07:17 PM, C=E9dric Le Goater wrote:
> > This is a model of the PCIe Host Bridge (PHB3) controller found on a
> > Power8 processor. The Power8 processor comes in different flavors:
> > Venice, Murano, Naple, each having a different number of PHBs. Multi
> > chip is supported, each chip adding its set of PHB3 controllers.
> >=20
> > There is no default device layout and PCI devices should be added to
> > the machine using command line options such as :
> >=20
> >   -device e1000e,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpcie.0,add=
r=3D0x0
> >   -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=
=3Dvirbr0,id=3Dhostnet0
> >=20
> >   -device megasas,id=3Dscsi0,bus=3Dpcie.1,addr=3D0x0
> >   -drive file=3D$disk,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,c=
ache=3Dnone
> >   -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=
=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2
> >=20
> > Git tree available here for testing, based on David's branch:
> >=20
> > 	https://github.com/legoater/qemu/tree/phb3-3.0
> >=20
>=20
> Would it be possible to have some feedback on this model ? It has proved=
=20
> to be useful these last years and it has been extensively modified to=20
> to fit mainline best practices.

Yeah, sorry, I've just been swamped with higher priority stuff.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--v+Mbu5iuT/5Blw/K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluZx1gACgkQbDjKyiDZ
s5JbhA//Vb/809pYaBV2wPxEJmBntAU/8CzIZ57K4W2h9b56LyaeL78f6SBLedGZ
JZMYmASFksqiVWkfJFXYzX+Dbok9eJ0FAaENf+egpDUcLP3Dlnj4IxIDkvAmMfGa
aGrHvJsNkJJzVAMinqX4xAy0qXdbIUgBTlPTxqMSaWQLSyFm5xCXUZxZjX5uCA6p
uyrKvSHeqpjHwZh1K9hW+Y2t1A3VHpkrJ6w2fMsuIrxfPlSGduTMYhA2wodgCALZ
Dcr48sqRX/V2BKPpL0+OYF0P0UNDSpPamM2X9/oNY+76zVacp4SM69yuSZo/T8p8
3UwzZ9wS8SJs1lfnzM9J3lBTrBkKPuAicLmoSz+E5X+FvLAt+45t7r8WYaQ+R5U9
vzzD4m0lMs4MyyfjcC+wRU2Wi26UBWM05t+zuOuOreTmw11vhY7OHkSfFNDJiV+F
cSOsZbgemWAXtzIrPsXlqYf30lNqDFV/j0grnqfw+nNIqk/zH0XjY9nQV8i+caY2
llJ69whJub/L6Ggg4so0MUoBhOAwRCfeDEe67BSDAFICjp1eljGycMuTjy213I37
BNqebBK8nsOgMcR/8bQVpthqezTPIZIVlXvJ1oFSsi0fvDzUM/vPDNvUJ2IEcNeN
NJIdgT5ZI4wlrAsBgJBnnwBcsyxnlJ8HjDA+qR2WljTy6ircpzU=
=iVrw
-----END PGP SIGNATURE-----

--v+Mbu5iuT/5Blw/K--
