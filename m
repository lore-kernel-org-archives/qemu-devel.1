Received: from eggs.gnu.org ([2001:4830:134:3::10]:45709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebcKL-0004dG-Mq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 20:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebcKI-00050s-HL
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 20:15:41 -0500
Date: Wed, 17 Jan 2018 12:15:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180117011527.GX30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<1516110433.10494.5.camel@redhat.com>
	<20180116135459.GN30352@umbus.fritz.box>
	<1516113980.3278.1.camel@redhat.com>
	<20180116223413.GQ30352@umbus.fritz.box>
	<62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
	<20180116233043.GR30352@umbus.fritz.box>
	<82382b6b-7105-550e-f19e-8013e6c8a466@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3rzwkXnKuCXxoL5m"
Content-Disposition: inline
In-Reply-To: <82382b6b-7105-550e-f19e-8013e6c8a466@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 0/6] target/ppc:
 Rework spapr_caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Andrea Bolognani <abologna@redhat.com>, paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--3rzwkXnKuCXxoL5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 10:46:45AM +1100, Alexey Kardashevskiy wrote:
> On 17/01/18 10:30, David Gibson wrote:
> > On Wed, Jan 17, 2018 at 10:26:28AM +1100, Alexey Kardashevskiy wrote:
> >> On 17/01/18 09:34, David Gibson wrote:
> >>> On Tue, Jan 16, 2018 at 03:46:20PM +0100, Andrea Bolognani wrote:
> >>>> On Wed, 2018-01-17 at 00:54 +1100, David Gibson wrote:
> >>>>>> Correct me if I'm wrong, but it seems to me like there's no way
> >>>>>> to figure out through QMP whether these new machine options can be
> >>>>>> used for a given QEMU binary.
> >>>>>
> >>>>> Uh, I don't think so.  These are machine options like any other (ju=
st
> >>>>> constructed a bit differently).  So they'll appear in qemu -machine
> >>>>> pseries,? and I believe that info can also be retrieved with QMP.
> >>>>
> >>>> Yes, they will indeed show up in the output of -machine pseries,?
> >>>> but there's AFAICT no way to retrieve them via QMP.
> >>>
> >>> Really!?  I thought introspecting object properties was QMP's bread
> >>> and butter.
> >>
> >>
> >> On a guest started with '-S':
> >> {"execute": "qom-list", "arguments": {"path": "/machine"}}
> >>
> >> returns:
> >> {   'return': [   {'name': 'graphics', 'type': 'bool'},
> >>                   {'name': 'phandle-start', 'type': 'int'},
> >>                   {'name': 'dump-guest-core', 'type': 'bool'},
> >>                   {'name': 'kernel-irqchip', 'type': 'OnOffSplit'},
> >>                   {'name': 'accel', 'type': 'string'},
> >>                   {'name': 'append', 'type': 'string'},
> >>                   {'name': 'dumpdtb', 'type': 'string'},
> >>                   {'name': 'igd-passthru', 'type': 'bool'},
> >>                   {'name': 'dt-compatible', 'type': 'string'},
> >>                   {'name': 'kernel', 'type': 'string'},
> >>                   {'name': 'usb', 'type': 'bool'},
> >>                   {'name': 'suppress-vmdesc', 'type': 'bool'},
> >>                   {'name': 'dtb', 'type': 'string'},
> >>                   {'name': 'firmware', 'type': 'string'},
> >>                   {'name': 'mem-merge', 'type': 'bool'},
> >>                   {'name': 'initrd', 'type': 'string'},
> >>                   {'name': 'enforce-config-section', 'type': 'bool'},
> >>                   {'name': 'kvm-shadow-mem', 'type': 'int'},
> >>                   {'name': 'cap-dfp', 'type': 'bool'},
> >>                   {'name': 'cap-htm', 'type': 'bool'},
> >>                   {'name': 'cap-vsx', 'type': 'bool'},
> >                               ^^^^^^^
> > Here are the cap properties.  Is it just Suraj's new tristate ones
> > that aren't showing up?  If so that's weird...  are you sure you built
> > with those patches included?
>=20
> I am sure I do not have them, my point was that QMP has it all if they are
> present in qemu :)

Oh sorry, I wasn't paying attention.  I thought that mail was from
Andrea, not you.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3rzwkXnKuCXxoL5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpeo68ACgkQbDjKyiDZ
s5L/gQ//VffLNd8VGu6bMQfgfKi6tHsrUHy3TM4LGVjaBk7mRwLLE4CJaaHmwV9t
tLxreWZcEVZed/t125rHkJiocJRAiYrWEJB0diwPTOkhGEp2yX5LQoKGLsgLDKSG
eIUcTr/NrYZoJYR0u+8tdUu/H642A7ofE38Y6J13VhD95q99qlieH8NDyjU58xx2
kVrn8xfXW1ICGuom+4Ad3ZAJSCeUX6YCdbNXA+qJM5INn0bt8nCU5slzu607sEt5
NBmJBGiOawzGLFFolcD3Wymw38k9sRXUI+NFm7tkJgECHADA8gQgzCK0MKOG3jlb
t3HbAaORq2iugeh5zoFnvWoBpBUbkFqxCco6MuSQno3Y9soOEjqVQfEtAXTc67CE
RITy20CWahouABILkyxe1IofYG4lH5M/i+mFBbbjq9HLN3i2THIDyztMWmzHkXwW
ouwW96TkAOPv7sFgaulOQvagimY7raq+YYFk6vFxPscCC/IkfR6IMDerfUZnFnJi
axJg94iTy9bvy8JIIdFl3LdQfxyQ74D3nOV1XfgLXj1Bm/d5VEuniZYcoBCAarl1
jpsEULRJl0TSTpIYllKhs+HMp+dfGQZnUmSB7Ef6SlLwNW6FgTPQ5SZ9/29sAsrY
T0ygLmgEI3YsmQENJGYmgSW0yb/vuBeLAkBFhTvF4FANrNdAEWU=
=ca6g
-----END PGP SIGNATURE-----

--3rzwkXnKuCXxoL5m--
