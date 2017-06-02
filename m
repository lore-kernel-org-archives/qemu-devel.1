Received: from eggs.gnu.org ([2001:4830:134:3::10]:58577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGccn-0000MW-Hi
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 22:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGcck-0003iu-Fq
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 22:47:41 -0400
Date: Fri, 2 Jun 2017 11:55:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170602015509.GG13397@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170530011416.01eea576@bahia.ttt.fr.ibm.com>
	<20170530061852.GE12163@umbus.fritz.box>
	<20170530100136.680ce96f@bahia.ttt.fr.ibm.com>
	<20170531025748.GG12163@umbus.fritz.box>
	<20170531105857.62a25a84@bahia.ttt.fr.ibm.com>
	<20170601065233.GD13397@umbus.fritz.box>
	<f353022f-6b48-ab18-f156-bd8fac8cf884@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline
In-Reply-To: <f353022f-6b48-ab18-f156-bd8fac8cf884@kaod.org>
Subject: Re: [Qemu-devel] [PATCHv4 0/5] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 01:59:14PM +0200, C=E9dric Le Goater wrote:
> On 06/01/2017 08:52 AM, David Gibson wrote:
> > On Wed, May 31, 2017 at 10:58:57AM +0200, Greg Kurz wrote:
> >> On Wed, 31 May 2017 12:57:48 +1000
> >> David Gibson <david@gibson.dropbear.id.au> wrote:
> >>> [...]
> >>>> All old non-pseries machine types already complain when started with
> >>>> a POWER7 or newer CPU. Providing the extra error message looks weird:
> >>>>
> >>>> qemu-system-ppc64 -machine ppce500 \
> >>>>                   -cpu POWER7,compat=3Dpower6
> >>>> qemu-system-ppc64: CPU 'compat' property is deprecated and has no ef=
fect;
> >>>>  use max-cpu-compat machine property instead
> >>>> MMU model 983043 not supported by this machine.
> >>>>
> >>>> but I guess it's better than crashing. :) =20
> >>>
> >>> Well, sure POWER7 doesn't make sense for an e500 machine for other
> >>> reasons.  But POWER7 or POWER8 _would_ make sense for powernv, where
> >>> compat=3D doesn't.
> >>>
> >>
> >> The powernv machine type doesn't even support CPU features at all:
> >>
> >>     chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->cp=
u_model);
> >>     if (!object_class_by_name(chip_typename)) {
> >>         error_report("invalid CPU model '%s' for %s machine",
> >>                      machine->cpu_model, MACHINE_GET_CLASS(machine)->n=
ame);
> >>         exit(1);
> >>     }
> >=20
> > Ah, well, that's another bug, but not one that's in scope for this
> > series.
>=20
> PowerNV is still work in progress. I would not worry about it too much.

I wasn't intending to :).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMMV6AAoJEGw4ysog2bOSiygQAMBB7rSR0YpGLUw3BbMu3c2p
y9ZMN3yu1YyMWudPG/dmZIlbH+wqixdxFKMsG0xzR7lD4xOtCPr047K9DZ8kVCD9
MXMQwfF0M/dRICslUga0Eds46MOYEgNCdfBqK1L/DGt9HHUlmn4b+s6LjOM5BmVd
AAig940hpqd/AQXC7xZtVzISnYzHxoHAurBRSnsk5rLCwagTf2el/YBh3d7plWlO
VKRuqFIxP3QEoz5ay26RWUe1Tp3a13Prtup///W5WUKZTF2zJjDpkbXgXSfCJIR/
zJtoeuAkDvkmk1sZgICkDa/lo/gRSmXl8dIweFtmJdOJUo546cBJafP3LPBG3BJi
nJxbIgqxIqbRrI7sdll23dTB7RNNygT6Hnk6XwfY9IDwjkh3imAm0ozrtQ1tG0pr
mlZGBqwVtrlYFspWemlL+gDdJ9ndGeweKzW4dfA8c+ujwZY5nUkOQg1/UJHhBT4W
O5oEVd8FQ7kQyHxkzaPxzCQ7QvDRcNmr173zRowemQ96pPAiqUwqyu7tdv7YkjjA
JNqVUqxu33k1+XY4bOWaveSs698jEUGskpTold8DY4zIFjmIVm8ceEPMYIlvnGd0
mKWvPGYDle+fG2ZCU5ihw28U/G+WWm6CidaHo+3Y0j46zmQyt4CCmlmcarTbmyRG
DUhfPVvZW0gXtq2RBTRu
=uwRA
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
