Received: from eggs.gnu.org ([2001:4830:134:3::10]:39136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTeDE-0002nu-HZ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTeDA-0004rQ-Ec
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:11:40 -0400
Date: Fri, 15 Jun 2018 11:34:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615013441.GH4129@umbus.fritz.box>
References: <20180614044129.13606-1-david@gibson.dropbear.id.au>
	<20180614044129.13606-7-david@gibson.dropbear.id.au>
	<2e5b66b8-1eec-48b4-b032-5df522627704@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/9ZOS6odDaRI+0hI"
Content-Disposition: inline
In-Reply-To: <2e5b66b8-1eec-48b4-b032-5df522627704@kaod.org>
Subject: Re: [Qemu-devel] [PATCHv3 6/7] target/ppc: Replace intc pointer
 with a general machine_data pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--/9ZOS6odDaRI+0hI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 05:20:56PM +0200, C=E9dric Le Goater wrote:
> On 06/14/2018 06:41 AM, David Gibson wrote:
> > PowerPCCPU contains an (Object *)intc used to point to the cpu's interr=
upt
> > controller.  Or more precisely to the "presentation" component of the
> > interrupt controller relevant to this cpu.
> >=20
> > Really, this field is machine specific.  The machines which use it can
> > point it to different types of object depending on their needs, and most
> > machines don't use it at all (since they have older style PICs which do=
n't
> > have per-cpu presentation components).
> >=20
> > There's also other information that's per-cpu, but platform/machine
> > specific.  So replace the intc pointer with a (void *)machine_data which
> > can be managed as the machine type likes to conveniently store per cpu
> > information.
>=20
> I took a closer look. I tried to port the XIVE models on top this=20
> new machine data field and it does not work out at all.=20
>=20
> The problem is that the XIVE models are common to PowerNV and sPAPR,
> they are machine agnostic, and when the cpu->intc pointer is used in
> the TIMA ops, we have no idea in which machine the CPU are running.=20
> We only expect the CPU to be a POWER9. We need a CPU related pointer=20
> and not a machine data pointer, but we could imagine having a machine=20
> data pointer under the CPU data pointer but the first need is a CPU=20
> data.
>=20
> Sorry, not have said it ealier, but I will just add back the intc=20
> pointer under the CPU, for the moment.

Bother.  Long term, I'm not sure what to do about this.  Fow now, I'll
back out the patch which moved intc to the machine_data (and rework
the vpa -> machine_data patch to apply without it).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/9ZOS6odDaRI+0hI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjF64ACgkQbDjKyiDZ
s5Kcxg//TaTlB64jZqoe6CFqqaUd9tUWuKHozdpagoKrdi883PZ+rDXW9/0QxLJy
pjYID3bmfXsrpD5Sukn4t5sb8eeSjs8ukdNJ/7mG53NbeDjHPeDRazPQ2Xh/PVMJ
GgA00jVxKUyOh5yfzbCq6cIrDxSiKdORhT1Re5hKghkXm9y9/dr2iNayc5/roBBk
6LruHcdlj14QKIvpDjCw7bl+CT8ZyfHeGM/cJ/+J1ME5X9t0glDwTB2Yggzf/5bo
sILVUyF7h2z93J52kjPjRRPhyfBszM6xvihBZ+KCzzodr4cl0220tlIQIyamRvtX
d3uAlDsZU/7eWgT98QrmC5vxnZMYBlrcVtyJT1/oozg5Mjpo0jKHKRNQVTOYZFnI
RzbAmLdvWt98bzjbW4PRSwJvq3NtKhBT8hbPeq175S1Sku6hBxZYA77bXKmhD+2v
uboY0N8KJVB/AByfpZv7gq9q3yXlJkbGfmeT52M3VK/f4/W+/tL8V3N/GE8UYlYd
V7Oyun/P/UDIWq2x0B7KNqrEL/7bZy+p+m7CUzVBJBBghMvziFU/FfJFo4t51TE5
PK7hDCQCuuDRM5WDzoONsJ4g5TkI9YFDR3PBngpGASt3+0A1FW+rfFg+VGP2fZ2S
OVUJBTVdEurb9PwD6BfINQLAGaMiKgy7z2faW4avXHG3XOF4i3w=
=dsj5
-----END PGP SIGNATURE-----

--/9ZOS6odDaRI+0hI--
