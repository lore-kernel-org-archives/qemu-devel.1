Received: from eggs.gnu.org ([2001:4830:134:3::10]:53221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQqVB-0002rs-OM
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQqVA-0005Pn-9N
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:38:05 -0400
Date: Fri, 30 Jun 2017 17:14:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170630071402.GF13989@umbus.fritz.box>
References: <20170623092124.GG12089@umbus>
	<c0a0667e-8c60-a8e7-a041-caddac8c8b88@redhat.com>
	<20170628014231.GA791@pacoca>
	<a34435df-8944-ddac-e881-0a2338e4aad4@redhat.com>
	<20170628081850.GJ12089@umbus>
	<668938c1-f93e-86d1-4e4e-5715d5074587@kaod.org>
	<e0f76eb1-2388-e512-3763-26e7232b1129@redhat.com>
	<baf1e0b1-178b-28ae-f2a2-caadaaf9d213@kaod.org>
	<20170628135908.4501f0a0@bahia.lab.toulouse-stg.fr.ibm.com>
	<78fa4c41-92db-8676-b6ef-db9de9717844@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <78fa4c41-92db-8676-b6ef-db9de9717844@redhat.com>
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
To: Laurent Vivier <lvivier@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, sursingh@redhat.com, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, sbobroff@redhat.com


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 06:18:06PM +0200, Laurent Vivier wrote:
> On 28/06/2017 13:59, Greg Kurz wrote:
> > On Wed, 28 Jun 2017 12:23:06 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> On 06/28/2017 11:18 AM, Laurent Vivier wrote:
> >>> On 28/06/2017 11:11, C=C3=A9dric Le Goater wrote: =20
> >>>> On 06/28/2017 10:18 AM, David Gibson wrote: =20
> >>>>> On Wed, Jun 28, 2017 at 09:09:24AM +0200, Thomas Huth wrote: =20
> >>>>>> On 28.06.2017 03:42, joserz@linux.vnet.ibm.com wrote: =20
> >>>>>>> On Fri, Jun 23, 2017 at 04:10:55PM +0200, Laurent Vivier wrote: =
=20
> >>>>>>>> On 23/06/2017 11:21, David Gibson wrote: =20
> >>>>>>>>> On Thu, Jun 22, 2017 at 01:31:24PM +0200, Thomas Huth wrote: =
=20
> >>>>>>>>>> On 22.06.2017 13:26, Laurent Vivier wrote: =20
> >>>>>>>>>>> CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9 v=
1.0.
> >>>>>>>>>>>
> >>>>>>>>>>> When we run qemu on a POWER9 DD1 host, we must use either
> >>>>>>>>>>> "-cpu host" or "-cpu POWER9", but in the latter case it fails=
 with
> >>>>>>>>>>>
> >>>>>>>>>>>     Unable to find sPAPR CPU Core definition
> >>>>>>>>>>>
> >>>>>>>>>>> because POWER9 DD1 doesn't appear in the list of known CPUs.
> >>>>>>>>>>>
> >>>>>>>>>>> This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
> >>>>>>>>>>> PVR instead of CPU_POWERPC_POWER9_BASE.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>  target/ppc/cpu-models.c | 2 +-
> >>>>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> >>>>>>>>>>> index 4d3e635..a22363c 100644
> >>>>>>>>>>> --- a/target/ppc/cpu-models.c
> >>>>>>>>>>> +++ b/target/ppc/cpu-models.c
> >>>>>>>>>>> @@ -1144,7 +1144,7 @@
> >>>>>>>>>>>      POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,       =
         970,
> >>>>>>>>>>>                  "PowerPC 970 v2.2")
> >>>>>>>>>>> =20
> >>>>>>>>>>> -    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_BASE,   =
         POWER9,
> >>>>>>>>>>> +    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_DD1,    =
         POWER9,
> >>>>>>>>>>>                  "POWER9 v1.0")
> >>>>>>>>>>> =20
> >>>>>>>>>>>      POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,     =
         970,
> >>>>>>>>>>> =20
> >>>>>>>>>>
> >>>>>>>>>> I think this also makes sense for running in TCG mode to get a=
 valid
> >>>>>>>>>> real PVR there. =20
> >>>>>>>>>
> >>>>>>>>> I'm not so convinced.
> >>>>>>>>>
> >>>>>>>>> IIUC, this will make TCG default (for now) to a DD1 POWER9.  Th=
at's a)
> >>>>>>>>> probably not what anyone wants - who'd select a buggy prototype=
 and b)
> >>>>>>>>> not accurate - TCG does not implement DD1's bugs. =20
> >>>>>>>>
> >>>>>>>> According to the POWER8 user manual (I didn't fine the POWER9 on=
e):
> >>>>>>>>
> >>>>>>>> "3.6.3.1 Processor Version Register (PVR)
> >>>>>>>>
> >>>>>>>> The processor revision level (PVR[16:31]) starts at x=E2=80=9801=
00=E2=80=99, indicating
> >>>>>>>> revision =E2=80=981.0=E2=80=99. As revisions are made, bits [29:=
31] will indicate minor
> >>>>>>>> revisions. Similarly, bits [20:23] indicate major changes."
> >>>>>>>>
> >>>>>>>> POWER9 DD1 PVR is 0x004E0100, so this is really version 1.0 of t=
he POWER9.
> >>>>>>>>
> >>>>>>>> Perhaps we can define POWER9_v1.0 as CPU_POWERPC_POWER9_DD1, and
> >>>>>>>> introduce a POWER9_v0.0 set to CPU_POWERPC_POWER9_BASE and defin=
e it as
> >>>>>>>> the default one? =20
> >>>>>>>
> >>>>>>> I like the suggestion to set a v0.0 to CPU_POWERPC_POWER9_BASE. B=
ut, I
> >>>>>>> think we could have only that option, removing the
> >>>>>>> CPU_POWERPC_POWER9_DD1 entry. =20
> >>>>>> I really dislike the idea of having a CPU called "v0.0" ... we do =
not
> >>>>>> have this for any other CPU generation, and it sounds like it coul=
d be
> >>>>>> very confusing for the users (you'd need to document somewhere wha=
t the
> >>>>>> v0.0 exactly means). If we really want to go this way, I think we =
should
> >>>>>> name it "POWER9-generic" or "PowerISA-3.0" or something similar in=
stead.
> >>>>>>
> >>>>>> Or does somebody already know the exact PVR for DD2? If so, we cou=
ld
> >>>>>> simply add a POWER9_v2.0 CPU already and let the POWER9 alias poin=
t to
> >>>>>> that version instead. =20
> >>>>>
> >>>>> Yes, I think that's a better idea.  I don't know the DD2 PVR, but I=
'm
> >>>>> pretty sure we should be able to find out from someone at IBM.
> >>>>>
> >>>>> I've CCed Sam & Suraj - can you ask Mikey or someone what the PVR
> >>>>> value for DD2.0 will be? =20
> >>>>
> >>>> I would expect something like :
> >>>>
> >>>>  0x200D104980000000UL; /* P9 Nimbus DD2.0 */ =20
> >>>
> >>>
> >>> I would expect something like 0x004Exxxx. =20
> >>
> >> ah yes, I am mistaking the PVR and the CFAM ID.=20
> >>
> >> C.=20
> >> =20
> >=20
> > According to https://patchwork.ozlabs.org/patch/776052/
> >=20
> > POWER9 DD2's PVR is expected to be 0x004e1200

Uh.. I spoke to Michael Ellerman, and he said he expected 0x004e0200.
Though he did mention there might be several variants.  Can we please
get a definitive answer on this from IBM.

> So, perhaps I can send a v2 of the patch with POWER9_v1.0 set to DD1
> PVR, and POWER9_v2.0 set to DD2 PVR?
>=20
> Thanks,
> Laurent
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZVfo6AAoJEGw4ysog2bOSbNUP/2ANCGkZKIJLVu0fxU1Ru3VQ
XwsJdibyvFxoeTa3qNw8n+cuIJg//pjXfShOZNrSFgQ8iNZuEoAkeUYYC0Wo8SB9
/VglKeE+Q9HEAvcrxPK2Gv34Aq/7SethRYjsnCBJyk40awxg8ymO8L23UOlfj04S
nObQnCMJQvaijsPkWJ0AgONEUBO0kSRvZNL4FYg6K/5RRDPUWIoAYburOqYhPQly
LkBRyFHTUbXr1J3SRA0K7z724QCN7xiZGulgYaV7Y70vYboPMsPAWw0qCXggcOg9
7Qa0rtqQHkLV45KHuLRmeJeQnOZFP4KWAG+sUq1tXbYkJ1N9y8AhYjsrgs5eGLf8
ZmNACq/couq2a/4P5VAdklXlrVUDxv4O+kpZVX0KQ6/TqgP3MCQXVm0SMwSA5yUs
wkOvVV2kh8eQPCK76gEjmPmL5EdGkmELcdffvBqzvX7jT1WvmoLYoJi6HL5stjYh
fMANswGtUJbHo7biQtTaXrmyi1UVnJ+pSDtq9DGk/PwoGaASu9J1fE5gqT0wv092
7DOcBRS9Fe6KM7Sv31CxrZEHX0uOgcM8iYNaLy72KPouI67nUbiKzq6IcJlzYYE2
RW6Vs7cy6lyE143ddqgZIw0vfdjDi/mFob7KYse7MOFuubAfIAYaYcYE2nNWKG8O
9idL2eMisixk4grXppZk
=hO+w
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
