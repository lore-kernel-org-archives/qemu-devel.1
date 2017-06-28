Received: from eggs.gnu.org ([2001:4830:134:3::10]:57772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQBcy-0003I3-O2
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQBcv-0007Kr-Le
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:59:24 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:51400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQBcv-0007K9-Cn
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:59:21 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B67C210DE4C
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 13:59:19 +0200 (CEST)
Date: Wed, 28 Jun 2017 13:59:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170628135908.4501f0a0@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <baf1e0b1-178b-28ae-f2a2-caadaaf9d213@kaod.org>
References: <20170622112648.24815-1-lvivier@redhat.com>
	<caa25331-5005-78e8-fba2-19bf67116d92@redhat.com>
	<20170623092124.GG12089@umbus>
	<c0a0667e-8c60-a8e7-a041-caddac8c8b88@redhat.com>
	<20170628014231.GA791@pacoca>
	<a34435df-8944-ddac-e881-0a2338e4aad4@redhat.com>
	<20170628081850.GJ12089@umbus>
	<668938c1-f93e-86d1-4e4e-5715d5074587@kaod.org>
	<e0f76eb1-2388-e512-3763-26e7232b1129@redhat.com>
	<baf1e0b1-178b-28ae-f2a2-caadaaf9d213@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/RbY9uhFymc_HoNgc7MWrxbF";
	protocol="application/pgp-signature"
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
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, sursingh@redhat.com, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, sbobroff@redhat.com

--Sig_/RbY9uhFymc_HoNgc7MWrxbF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Jun 2017 12:23:06 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 06/28/2017 11:18 AM, Laurent Vivier wrote:
> > On 28/06/2017 11:11, C=C3=A9dric Le Goater wrote: =20
> >> On 06/28/2017 10:18 AM, David Gibson wrote: =20
> >>> On Wed, Jun 28, 2017 at 09:09:24AM +0200, Thomas Huth wrote: =20
> >>>> On 28.06.2017 03:42, joserz@linux.vnet.ibm.com wrote: =20
> >>>>> On Fri, Jun 23, 2017 at 04:10:55PM +0200, Laurent Vivier wrote: =20
> >>>>>> On 23/06/2017 11:21, David Gibson wrote: =20
> >>>>>>> On Thu, Jun 22, 2017 at 01:31:24PM +0200, Thomas Huth wrote: =20
> >>>>>>>> On 22.06.2017 13:26, Laurent Vivier wrote: =20
> >>>>>>>>> CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9 v1.=
0.
> >>>>>>>>>
> >>>>>>>>> When we run qemu on a POWER9 DD1 host, we must use either
> >>>>>>>>> "-cpu host" or "-cpu POWER9", but in the latter case it fails w=
ith
> >>>>>>>>>
> >>>>>>>>>     Unable to find sPAPR CPU Core definition
> >>>>>>>>>
> >>>>>>>>> because POWER9 DD1 doesn't appear in the list of known CPUs.
> >>>>>>>>>
> >>>>>>>>> This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
> >>>>>>>>> PVR instead of CPU_POWERPC_POWER9_BASE.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >>>>>>>>> ---
> >>>>>>>>>  target/ppc/cpu-models.c | 2 +-
> >>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> >>>>>>>>> index 4d3e635..a22363c 100644
> >>>>>>>>> --- a/target/ppc/cpu-models.c
> >>>>>>>>> +++ b/target/ppc/cpu-models.c
> >>>>>>>>> @@ -1144,7 +1144,7 @@
> >>>>>>>>>      POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,         =
       970,
> >>>>>>>>>                  "PowerPC 970 v2.2")
> >>>>>>>>> =20
> >>>>>>>>> -    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_BASE,     =
       POWER9,
> >>>>>>>>> +    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_DD1,      =
       POWER9,
> >>>>>>>>>                  "POWER9 v1.0")
> >>>>>>>>> =20
> >>>>>>>>>      POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,       =
       970,
> >>>>>>>>> =20
> >>>>>>>>
> >>>>>>>> I think this also makes sense for running in TCG mode to get a v=
alid
> >>>>>>>> real PVR there. =20
> >>>>>>>
> >>>>>>> I'm not so convinced.
> >>>>>>>
> >>>>>>> IIUC, this will make TCG default (for now) to a DD1 POWER9.  That=
's a)
> >>>>>>> probably not what anyone wants - who'd select a buggy prototype a=
nd b)
> >>>>>>> not accurate - TCG does not implement DD1's bugs. =20
> >>>>>>
> >>>>>> According to the POWER8 user manual (I didn't fine the POWER9 one):
> >>>>>>
> >>>>>> "3.6.3.1 Processor Version Register (PVR)
> >>>>>>
> >>>>>> The processor revision level (PVR[16:31]) starts at x=E2=80=980100=
=E2=80=99, indicating
> >>>>>> revision =E2=80=981.0=E2=80=99. As revisions are made, bits [29:31=
] will indicate minor
> >>>>>> revisions. Similarly, bits [20:23] indicate major changes."
> >>>>>>
> >>>>>> POWER9 DD1 PVR is 0x004E0100, so this is really version 1.0 of the=
 POWER9.
> >>>>>>
> >>>>>> Perhaps we can define POWER9_v1.0 as CPU_POWERPC_POWER9_DD1, and
> >>>>>> introduce a POWER9_v0.0 set to CPU_POWERPC_POWER9_BASE and define =
it as
> >>>>>> the default one? =20
> >>>>>
> >>>>> I like the suggestion to set a v0.0 to CPU_POWERPC_POWER9_BASE. But=
, I
> >>>>> think we could have only that option, removing the
> >>>>> CPU_POWERPC_POWER9_DD1 entry. =20
> >>>> I really dislike the idea of having a CPU called "v0.0" ... we do not
> >>>> have this for any other CPU generation, and it sounds like it could =
be
> >>>> very confusing for the users (you'd need to document somewhere what =
the
> >>>> v0.0 exactly means). If we really want to go this way, I think we sh=
ould
> >>>> name it "POWER9-generic" or "PowerISA-3.0" or something similar inst=
ead.
> >>>>
> >>>> Or does somebody already know the exact PVR for DD2? If so, we could
> >>>> simply add a POWER9_v2.0 CPU already and let the POWER9 alias point =
to
> >>>> that version instead. =20
> >>>
> >>> Yes, I think that's a better idea.  I don't know the DD2 PVR, but I'm
> >>> pretty sure we should be able to find out from someone at IBM.
> >>>
> >>> I've CCed Sam & Suraj - can you ask Mikey or someone what the PVR
> >>> value for DD2.0 will be? =20
> >>
> >> I would expect something like :
> >>
> >>  0x200D104980000000UL; /* P9 Nimbus DD2.0 */ =20
> >=20
> >=20
> > I would expect something like 0x004Exxxx. =20
>=20
> ah yes, I am mistaking the PVR and the CFAM ID.=20
>=20
> C.=20
> =20

According to https://patchwork.ozlabs.org/patch/776052/

POWER9 DD2's PVR is expected to be 0x004e1200

Cheers,

--
Greg

--Sig_/RbY9uhFymc_HoNgc7MWrxbF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllTmgwACgkQAvw66wEB28J0nwCdHEMFqo+C/FgpwUZzEjLQBxpl
g84An0DCT6LU9bgUAJYPd7qUK7bppa+O
=izzg
-----END PGP SIGNATURE-----

--Sig_/RbY9uhFymc_HoNgc7MWrxbF--
