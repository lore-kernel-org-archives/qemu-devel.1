Received: from eggs.gnu.org ([2001:4830:134:3::10]:34007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebagz-0007gU-3h
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebagx-0004Do-Sa
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:30:57 -0500
Date: Wed, 17 Jan 2018 10:30:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180116233043.GR30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<1516110433.10494.5.camel@redhat.com>
	<20180116135459.GN30352@umbus.fritz.box>
	<1516113980.3278.1.camel@redhat.com>
	<20180116223413.GQ30352@umbus.fritz.box>
	<62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vvRocJ6whMXXNc9q"
Content-Disposition: inline
In-Reply-To: <62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
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


--vvRocJ6whMXXNc9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 10:26:28AM +1100, Alexey Kardashevskiy wrote:
> On 17/01/18 09:34, David Gibson wrote:
> > On Tue, Jan 16, 2018 at 03:46:20PM +0100, Andrea Bolognani wrote:
> >> On Wed, 2018-01-17 at 00:54 +1100, David Gibson wrote:
> >>>> Correct me if I'm wrong, but it seems to me like there's no way
> >>>> to figure out through QMP whether these new machine options can be
> >>>> used for a given QEMU binary.
> >>>
> >>> Uh, I don't think so.  These are machine options like any other (just
> >>> constructed a bit differently).  So they'll appear in qemu -machine
> >>> pseries,? and I believe that info can also be retrieved with QMP.
> >>
> >> Yes, they will indeed show up in the output of -machine pseries,?
> >> but there's AFAICT no way to retrieve them via QMP.
> >=20
> > Really!?  I thought introspecting object properties was QMP's bread
> > and butter.
>=20
>=20
> On a guest started with '-S':
> {"execute": "qom-list", "arguments": {"path": "/machine"}}
>=20
> returns:
> {   'return': [   {'name': 'graphics', 'type': 'bool'},
>                   {'name': 'phandle-start', 'type': 'int'},
>                   {'name': 'dump-guest-core', 'type': 'bool'},
>                   {'name': 'kernel-irqchip', 'type': 'OnOffSplit'},
>                   {'name': 'accel', 'type': 'string'},
>                   {'name': 'append', 'type': 'string'},
>                   {'name': 'dumpdtb', 'type': 'string'},
>                   {'name': 'igd-passthru', 'type': 'bool'},
>                   {'name': 'dt-compatible', 'type': 'string'},
>                   {'name': 'kernel', 'type': 'string'},
>                   {'name': 'usb', 'type': 'bool'},
>                   {'name': 'suppress-vmdesc', 'type': 'bool'},
>                   {'name': 'dtb', 'type': 'string'},
>                   {'name': 'firmware', 'type': 'string'},
>                   {'name': 'mem-merge', 'type': 'bool'},
>                   {'name': 'initrd', 'type': 'string'},
>                   {'name': 'enforce-config-section', 'type': 'bool'},
>                   {'name': 'kvm-shadow-mem', 'type': 'int'},
>                   {'name': 'cap-dfp', 'type': 'bool'},
>                   {'name': 'cap-htm', 'type': 'bool'},
>                   {'name': 'cap-vsx', 'type': 'bool'},
                              ^^^^^^^
Here are the cap properties.  Is it just Suraj's new tristate ones
that aren't showing up?  If so that's weird...  are you sure you built
with those patches included?

>                   {'name': 'vfio-no-msix-emulation', 'type': 'bool'},
>                   {'name': 'kvm-type', 'type': 'string'},
>                   {'name': 'max-cpu-compat', 'type': 'string'},
>                   {   'name': 'dr-connector[268435480]',
>                       'type': 'child<spapr-drc-cpu>'},
>                   {'name': 'peripheral', 'type': 'child<container>'},
>                   {   'name': 'dr-connector[268435472]',
>                       'type': 'child<spapr-drc-cpu>'},
>                   {'name': 'modern-hotplug-events', 'type': 'bool'},
>                   {   'name': 'dr-connector[268435464]',
>                       'type': 'child<spapr-drc-cpu>'},
>                   {   'name': 'dr-connector[268435456]',
>                       'type': 'child<spapr-drc-cpu>'},
>                   {'name': 'peripheral-anon', 'type': 'child<container>'},
>                   {'name': 'ics', 'type': 'child<icskvm>'},
>                   {'name': 'vsmt', 'type': 'uint32'},
>                   {'name': 'type', 'type': 'string'},
>                   {'name': 'rtc-time', 'type': 'struct tm'},
>                   {'name': 'unattached', 'type': 'child<container>'},
>                   {'name': 'rtc', 'type': 'child<spapr-rtc>'},
>                   {'name': 'resize-hpt', 'type': 'string'}]}
>=20
>=20
> but still requires a running qemu, yes.
>=20
> >=20
> >> And libvirt
> >> can't afford to spawn a QEMU process for each machine type
> >> implemented by each QEMU binary installed on the system just to
> >> figure out what properties they support; in fact, we've been
> >> pushing away from that approach - which was used initially - for
> >> years and we're now at the point where we only fall back to it
> >> for positively ancient QEMU versions. So the information needs
> >> to be available through QMP for libvirt to consume it.
> >=20
> > Right, I'm not arguing with that.  It's just that I thought that
> > standard QOM properties on QOM objects (the machine in this case) met
> > the criteria.
> >=20
>=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vvRocJ6whMXXNc9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpeiyIACgkQbDjKyiDZ
s5JGFg/9GP+io3FlUe2bEvgeIKlHyMxzQOamgzBg8LwXp6uLfidCkmcjODDFR37/
LsKQSELb1j8343fO8ZVF8b9jKNLQwoxsZopeMhHqFtgeEA09HyFtl2zzijN2MdjH
S7gCETZwhRzE0T+xDp3rqjh6JDLZ/UMH02xkwdAM9hu0/pBNd69Wd6jXPaad2VOO
xRLAMvnZmyKQh83n4Isw3eVHpxzextgXL3lkp2OL3zr2Refe2encBf0VCJD7+8IV
bIPJS7ejFTRmLonyv7ViJoS50wI4f/qOF/MCAEOp/m0De+rzYOn7q9onXNDOMSlG
XxQqHUVNYxqrCPlU5MHBMfFySnOUvmAgr9bu9aa50eYsPswoLF1e8ue8TDqNEVqT
nJpfzUpzdpmJrzTIv5KAGEaQiYsT1Fn+AdqjcpGogshToNnVPC1EAYbx474z8S/v
5A3uql8MU5Uhq7E93LJiEQsKwiZ1eyELO0Zy/b3yZHd7Dmb4V/OCx6Q3igZV2FR3
lYf8+I4zMRH3mb8u58C7e8I+k0RUkTgMhPCYXsHQfyVQ3rnrxswe3gZjRS9pWmjo
l6jGEmPbSdqgAvxWFqfcg3fM+Z5Kl5Ct1b82xZnxsd0tQ+6SYU3NxaTOrFpVENR4
s7wQX9eyD0+/4kB6primAYI40Ixdu4PYEzN5WkWPpsC+Uxq9V5I=
=6P+f
-----END PGP SIGNATURE-----

--vvRocJ6whMXXNc9q--
