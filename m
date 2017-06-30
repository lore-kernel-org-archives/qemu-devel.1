Received: from eggs.gnu.org ([2001:4830:134:3::10]:53223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQqVB-0002rv-PO
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQqVA-0005Pi-99
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:38:05 -0400
Date: Fri, 30 Jun 2017 17:12:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170630071218.GE13989@umbus.fritz.box>
References: <a34435df-8944-ddac-e881-0a2338e4aad4@redhat.com>
	<20170628081850.GJ12089@umbus>
	<668938c1-f93e-86d1-4e4e-5715d5074587@kaod.org>
	<e0f76eb1-2388-e512-3763-26e7232b1129@redhat.com>
	<baf1e0b1-178b-28ae-f2a2-caadaaf9d213@kaod.org>
	<20170628135908.4501f0a0@bahia.lab.toulouse-stg.fr.ibm.com>
	<78fa4c41-92db-8676-b6ef-db9de9717844@redhat.com>
	<20170628184137.699a4f9f@bahia.lab.toulouse-stg.fr.ibm.com>
	<1498714660.30519.1.camel@gmail.com>
	<1498714923.30519.3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <1498714923.30519.3.camel@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, sursingh@redhat.com, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, sbobroff@redhat.com


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 03:42:03PM +1000, Suraj Jitindar Singh wrote:
> On Thu, 2017-06-29 at 15:37 +1000, Suraj Jitindar Singh wrote:
> > On Wed, 2017-06-28 at 18:41 +0200, Greg Kurz wrote:
> > > On Wed, 28 Jun 2017 18:18:06 +0200
> > > Laurent Vivier <lvivier@redhat.com> wrote:
> > >=20
> > > > On 28/06/2017 13:59, Greg Kurz wrote:
> > > > > On Wed, 28 Jun 2017 12:23:06 +0200
> > > > > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> > > > > =C2=A0=C2=A0
> > > > > > On 06/28/2017 11:18 AM, Laurent Vivier wrote:=C2=A0=C2=A0
> > > > > > > On 28/06/2017 11:11, C=C3=A9dric Le Goater wrote:=C2=A0=C2=A0=
=C2=A0=C2=A0
> > > > > > > > On 06/28/2017 10:18 AM, David Gibson wrote:=C2=A0=C2=A0=C2=
=A0=C2=A0
> > > > > > > > > On Wed, Jun 28, 2017 at 09:09:24AM +0200, Thomas Huth
> > > > > > > > > wrote:=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > On 28.06.2017 03:42, joserz@linux.vnet.ibm.com
> > > > > > > > > > wrote:=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > On Fri, Jun 23, 2017 at 04:10:55PM +0200, Laurent
> > > > > > > > > > > Vivier wrote:=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > > On 23/06/2017 11:21, David Gibson wrote:=C2=A0=C2=
=A0=C2=A0=C2=A0
> > > > > > > > > > > > > On Thu, Jun 22, 2017 at 01:31:24PM +0200,
> > > > > > > > > > > > > Thomas
> > > > > > > > > > > > > Huth wrote:=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > > > > On 22.06.2017 13:26, Laurent Vivier
> > > > > > > > > > > > > > wrote:=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > > > > > CPU_POWERPC_POWER9_DD1 is 0x004E0100, so
> > > > > > > > > > > > > > > this
> > > > > > > > > > > > > > > is the POWER9 v1.0.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > When we run qemu on a POWER9 DD1 host, we
> > > > > > > > > > > > > > > must use either
> > > > > > > > > > > > > > > "-cpu host" or "-cpu POWER9", but in the
> > > > > > > > > > > > > > > latter case it fails with
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0Unable to find sPAPR =
CPU Core
> > > > > > > > > > > > > > > definition
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > because POWER9 DD1 doesn't appear in the
> > > > > > > > > > > > > > > list
> > > > > > > > > > > > > > > of known CPUs.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > This patch fixes this by defining
> > > > > > > > > > > > > > > POWER9_v1.0
> > > > > > > > > > > > > > > with POWER9 DD1
> > > > > > > > > > > > > > > PVR instead of CPU_POWERPC_POWER9_BASE.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Signed-off-by: Laurent Vivier <lvivier@redh
> > > > > > > > > > > > > > > at
> > > > > > > > > > > > > > > .com>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > =C2=A0target/ppc/cpu-models.c | 2 +-
> > > > > > > > > > > > > > > =C2=A01 file changed, 1 insertion(+), 1
> > > > > > > > > > > > > > > deletion(-
> > > > > > > > > > > > > > > )
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > diff --git a/target/ppc/cpu-models.c
> > > > > > > > > > > > > > > b/target/ppc/cpu-models.c
> > > > > > > > > > > > > > > index 4d3e635..a22363c 100644
> > > > > > > > > > > > > > > --- a/target/ppc/cpu-models.c
> > > > > > > > > > > > > > > +++ b/target/ppc/cpu-models.c
> > > > > > > > > > > > > > > @@ -1144,7 +1144,7 @@
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWERPC_DEF("97=
0_v2.2",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU_POWER
> > > > > > > > > > > > > > > PC
> > > > > > > > > > > > > > > _970_v22,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0970,
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"PowerPC 970 v2.2")
> > > > > > > > > > > > > > > =C2=A0
> > > > > > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0POWERPC_DEF("POWER9_=
v1.0",=C2=A0=C2=A0=C2=A0CPU_POWER
> > > > > > > > > > > > > > > PC
> > > > > > > > > > > > > > > _POWER9_BASE,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER9,
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0POWERPC_DEF("POWER9_=
v1.0",=C2=A0=C2=A0=C2=A0CPU_POWER
> > > > > > > > > > > > > > > PC
> > > > > > > > > > > > > > > _POWER9_DD1,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER9,
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"POWER9 v1.0")
> > > > > > > > > > > > > > > =C2=A0
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWERPC_DEF("97=
0fx_v1.0",=C2=A0=C2=A0=C2=A0=C2=A0CPU_POWER
> > > > > > > > > > > > > > > PC
> > > > > > > > > > > > > > > _970FX_v10,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0970,
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > I think this also makes sense for running in
> > > > > > > > > > > > > > TCG mode to get a valid
> > > > > > > > > > > > > > real PVR there.=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > I'm not so convinced.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > IIUC, this will make TCG default (for now) to a
> > > > > > > > > > > > > DD1 POWER9.=C2=A0=C2=A0That's a)
> > > > > > > > > > > > > probably not what anyone wants - who'd select a
> > > > > > > > > > > > > buggy prototype and b)
> > > > > > > > > > > > > not accurate - TCG does not implement DD1's
> > > > > > > > > > > > > bugs.=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > >=20
> > > > > > > > > > > > According to the POWER8 user manual (I didn't
> > > > > > > > > > > > fine
> > > > > > > > > > > > the POWER9 one):
> > > > > > > > > > > >=20
> > > > > > > > > > > > "3.6.3.1 Processor Version Register (PVR)
> > > > > > > > > > > >=20
> > > > > > > > > > > > The processor revision level (PVR[16:31]) starts
> > > > > > > > > > > > at
> > > > > > > > > > > > x=E2=80=980100=E2=80=99, indicating
> > > > > > > > > > > > revision =E2=80=981.0=E2=80=99. As revisions are ma=
de, bits
> > > > > > > > > > > > [29:31]
> > > > > > > > > > > > will indicate minor
> > > > > > > > > > > > revisions. Similarly, bits [20:23] indicate major
> > > > > > > > > > > > changes."
> > > > > > > > > > > >=20
> > > > > > > > > > > > POWER9 DD1 PVR is 0x004E0100, so this is really
> > > > > > > > > > > > version 1.0 of the POWER9.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Perhaps we can define POWER9_v1.0 as
> > > > > > > > > > > > CPU_POWERPC_POWER9_DD1, and
> > > > > > > > > > > > introduce a POWER9_v0.0 set to
> > > > > > > > > > > > CPU_POWERPC_POWER9_BASE and define it as
> > > > > > > > > > > > the default one?=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > >=20
> > > > > > > > > > > I like the suggestion to set a v0.0 to
> > > > > > > > > > > CPU_POWERPC_POWER9_BASE. But, I
> > > > > > > > > > > think we could have only that option, removing the
> > > > > > > > > > > CPU_POWERPC_POWER9_DD1 entry.=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > >=20
> > > > > > > > > > I really dislike the idea of having a CPU called
> > > > > > > > > > "v0.0"
> > > > > > > > > > ... we do not
> > > > > > > > > > have this for any other CPU generation, and it sounds
> > > > > > > > > > like it could be
> > > > > > > > > > very confusing for the users (you'd need to document
> > > > > > > > > > somewhere what the
> > > > > > > > > > v0.0 exactly means). If we really want to go this
> > > > > > > > > > way,
> > > > > > > > > > I think we should
> > > > > > > > > > name it "POWER9-generic" or "PowerISA-3.0" or
> > > > > > > > > > something
> > > > > > > > > > similar instead.
> > > > > > > > > >=20
> > > > > > > > > > Or does somebody already know the exact PVR for DD2?
> > > > > > > > > > If
> > > > > > > > > > so, we could
> > > > > > > > > > simply add a POWER9_v2.0 CPU already and let the
> > > > > > > > > > POWER9
> > > > > > > > > > alias point to
> > > > > > > > > > that version instead.=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > >=20
> > > > > > > > > Yes, I think that's a better idea.=C2=A0=C2=A0I don't kno=
w the
> > > > > > > > > DD2
> > > > > > > > > PVR, but I'm
> > > > > > > > > pretty sure we should be able to find out from someone
> > > > > > > > > at
> > > > > > > > > IBM.
> > > > > > > > >=20
> > > > > > > > > I've CCed Sam & Suraj - can you ask Mikey or someone
> > > > > > > > > what
> > > > > > > > > the PVR
> > > > > > > > > value for DD2.0 will be?=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > >=20
> > > > > > > > I would expect something like :
> > > > > > > >=20
> > > > > > > > =C2=A00x200D104980000000UL; /* P9 Nimbus DD2.0 */=C2=A0=C2=
=A0=C2=A0=C2=A0
> > > > > > >=20
> > > > > > >=20
> > > > > > > I would expect something like 0x004Exxxx.=C2=A0=C2=A0=C2=A0=
=C2=A0
> > > > > >=20
> > > > > > ah yes, I am mistaking the PVR and the CFAM ID.=C2=A0
> > > > > >=20
> > > > > > C.=C2=A0
> > > > > > =C2=A0=C2=A0=C2=A0
> > > > >=20
> > > > > According to https://patchwork.ozlabs.org/patch/776052/
> > > > >=20
> > > > > POWER9 DD2's PVR is expected to be 0x004e1200
> > > > > =C2=A0
> > > >=20
> > > > So, perhaps I can send a v2 of the patch with POWER9_v1.0 set to
> > > > DD1
> > > > PVR, and POWER9_v2.0 set to DD2 PVR?
> > > >=20
> > >=20
> > > FWIW Thomas suggested to do just that and David agreed it was "a
> > > better idea".
> >=20
> > I assume we would have just -cpu POWER9 alias to DD2?
> >=20
> > We probably need to have a nice abort if someone tries to run TCG
> > with
> > DD1, I'm not sure where it will break but I'm fairly sure it won't
> > boot.
> >=20
> > That makes the assumption that DD2 doesn't require any work arounds
> > which TCG can't handle.
>=20
> Actually TCG is really a non-issue since we'll just go into the POWER9
> architected mode.
>=20
> Can't we just have -cpu POWER9 alias to DD1 for now and add DD2 when we
> know the pvr?

No, because calling what qemu does DD1 is simply not accurate, in
important and guest-visible ways.

What we should do is add in DD2.0 - we know the PVR, even if the
chip's not out yet.  Then alias POWER9 to that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZVfnQAAoJEGw4ysog2bOSxQkP/0QZpRZH3V2/ekS+Oc6YJpIw
/PAsORxtpVrdHc6S/RBWdOIcAXXg4BlMHO/S2nbloycYxzTxM25s9tIO1padQVYI
nFMf05DkIxEkay1I6Cwu1FaDBmXNNOdOfY1jJgETqQCV+y+iATM43YxA1F42DG31
RmNdISQ0o+6xT8epvI/5oljFr7vvHm9MLexzvSOoWp8Qs4vl60QiWN6xx3G7wzI4
ajVnyujBe6NPKEZzqfmP2HzIpvsKz5RQCurwR2BwwswyZAOdJKATlbQiiM7YuTRL
RVb+seKJcpUYCiVoIKK4hoi2GZweUa89XgDHsdbiTvHqDOlsY34dr5Xn3wCb+oUb
Xuk6wz93YAVcupnVIByDsbYlr8UYSEgiLluErJhTI8ulasJ4CashS0v6YGDJWocd
ffiG+Pf7vDuMmhPiWTJ+SPnJbs/ndlOlmll3R/tiOR3KaE71KHEDsdfqM47hjrCB
UCNwgf+FErMIKXXS2kLcZOBUjjhXr24Sd7nrFo+BqXtD/Y1JPvbDqr2AlD5gGDWU
VZB7hVZOSH9HDlwVbtKbdE674SoXsWcBbjTVElzshv+MkZZm5HtrXuzu5tY+Atdr
jy8c8wa6qDzdfZWKk8KmpobQdl1ifzC/zjt7fQlQNugFgcS6UfEC+Xf69dUcHjW/
+bhRwEHSzvzkRXa1rTRR
=sf4Q
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--
