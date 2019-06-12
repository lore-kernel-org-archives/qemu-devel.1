Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419A2C31E44
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 02:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44BB2080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 02:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KwZT41AC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44BB2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56294 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hasfJ-0001nu-TO
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 22:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55342)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hasTN-0002GP-Q8
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hasTK-0006qr-S6
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:54:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46007 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hasTI-0006ok-0S; Tue, 11 Jun 2019 21:54:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NqgJ50SNz9s7h; Wed, 12 Jun 2019 11:54:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560304476;
 bh=cNoc1wiln3VeVnZfs/RXYWCJ4c+xFdJLw2WMZ2/HBQo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KwZT41ACqukimbk1iCbJpc6MdbcRobTr7626FGUkGMuZJEtgzZJ6jmQF4N6GDz2mz
 6Tnozp1LdzgpnbrONG2iLvrFL2pC9tttsHOM+jKN8+3lX2SSJ1iq9W7XFL5DSefS6v
 24WynqUdq5wdNvcwFp1nIJwN6P5t48b6LoGyTmSw=
Date: Wed, 12 Jun 2019 11:29:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190612012935.GF3998@umbus.fritz.box>
References: <155984093894.2803172.8618224129384655510.stgit@bahia.lan>
 <20190607001901.GC3760@umbus.fritz.box>
 <2d02c8d1-d9f4-efd0-5059-6ca24e622107@kaod.org>
 <20190607114950.3247af33@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Content-Disposition: inline
In-Reply-To: <20190607114950.3247af33@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] spapr: Don't use the "dual" interrupt
 controller mode with an old hypervisor
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2019 at 11:49:50AM +0200, Greg Kurz wrote:
65;5603;1c> On Fri, 7 Jun 2019 10:17:58 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 07/06/2019 02:19, David Gibson wrote:
> > > On Thu, Jun 06, 2019 at 07:08:59PM +0200, Greg Kurz wrote: =20
> > >> If KVM is too old to support XIVE native exploitation mode, we might=
 end
> > >> up using the emulated XIVE after CAS. This is sub-optimal if KVM in-=
kernel
> > >> XICS is available, which is the case most of the time. =20
> > >=20
> > > This is intentional.  A predictable guest environment trumps performa=
nce. =20
> >=20
> > I don't agree.=20
> >=20
> > If the user does not specify any specific interrupt mode, we should fav=
or=20
> > the faster one.=20
> >=20
>=20
> This all boils down to the semantics of "dual"... "XICS AND XIVE" or "any
> of XICS or XIVE" ?

It means xics and xive are available, guest gets to choose.

> We already have a precedent when using pre-power9 compat mode. If the
> user passes ic-mode=3Ddual,max-compat-cpu=3Dpower8, we internally convert
> "dual" to act as "xics". The rationale is that a guest running in
> power8 architected mode isn't supposed to know about XIVE at all.
>=20
> Should we forbid this config and exit QEMU instead ?

Uh.. yes, that would make sense, actually.  However
max-compat-cpu=3Dpower8 without an explicit ic-mode=3Dxive or ic-mode=3Ddual
should act as ic-mode=3Dxics.  The difference here is that it's an
explicitly user specified constraint, rather than a host implied
constraint.

> > Here is the current matrix (with this patch) for guests running on an=
=20
> > old KVM, that is without KVM XIVE support. Let's discuss on what we
> > want.=20
> >=20
> >                         kernel_irqchip
> >=20
> >            (default)=20
> > ic-mode     allowed           off            on=20
> >=20
> > dual        XICS KVM       XICS emul.(3)   XICS KVM         (default mo=
de)
> > xics        XICS KVM       XICS emul.      XICS KVM   =20
> > xive        XIVE emul.(1)  XIVE emul.     QEMU failure (2)
> >=20
> >=20
> > (1) QEMU warns with "warning: kernel_irqchip requested but unavailable:=
=20
> >     IRQ_XIVE capability must be present for KVM"=20
> > (2) QEMU fails with "kernel_irqchip requested but unavailable:=20
> >     IRQ_XIVE capability must be present for KVM"=20
> > (3) That is wrong I think, we should get XIVE emulated.
> >=20
>=20
> This is the logical consequence of turning "dual" into "xics".
>=20
> >=20
> > what you would want is XIVE emulation when ic-mode=3Ddual and=20
> > kernel_irqchip=3Dallowed, which is the behavior with this patch (but th=
ere
>=20
> I guess you mean s/with/without=20
>=20
> > are reboot bugs)
> >=20
>=20
> Yeah. If the semantics of "dual" is to always advertise XICS AND XIVE, an=
d we
> keep the current fallback behavior, then we need each implementation to h=
ave
> proper init/teardown support as well as proper rollback on error paths.
>=20
> This is definitely not the case: rollback is missing in both in-kernel=20
> XICS and XIVE code and the emulated XICS and XIVE don't have teardown.
>=20
> This can generate a variety of bugs, including QEMU crashes... the old KV=
M case
> is just one of them, but there might be others.
>=20
> > =20
> > >> Also, an old KVM may not allow to destroy and re-create the KVM XICS=
, which
> > >> is precisely what "dual" does during machine reset. This causes QEMU=
 to try
> > >> to switch to emulated XICS and to crash because RTAS call de-registr=
ation
> > >> isn't handled correctly. We could possibly fix that, but again we wo=
uld
> > >> still end up with an emulated XICS or XIVE. =20
> > >=20
> > > Ugh, that's a problem. =20
> >=20
> > Yes. It's another problem around the way we cleanup the allocated resou=
rces.
> > It should be another patch.
> >=20
>=20
> Yeah, probably many other patches...
>=20
> > >  =20
> > >> "dual" is definitely not a good choice with older KVMs. Internally f=
orce
> > >> XICS when we detect this. =20
> > >=20
> > > But this is not an acceptable solution.  Silently changing the guest
> > > visible environment based on host capabilities is never ok.  =20
> >=20
> > If the host (KVM) doesn't have a capability, what is the point of tryin=
g=20
> > to use it if we can do better. I know you are considering KVM/QEMU as a
> > whole but who would run with kernel_irqchip=3Doff ?
> >=20
>=20
> The real problem is when you don't pass kernel_irqchip at all. Combined
> with "dual", this gives a fair number of cases. Do we want to support
> all possible transitions ?
>=20
> > > We must
> > > either give the guest environment that the user has requested, or fail
> > > outright. =20
> >=20
> > 'dual' mode means both and the user is not requesting XIVE. We are chan=
ging=20
> > the priority of choices from :
> >=20
> >  1. KVM XIVE
> >  2. QEMU XIVE
> >  3. KVM XICS
> >  4. QEMU XICS
> >=20
> > to:
> >=20
> >  1. KVM XIVE
> >  2. KVM XICS
> >  3. QEMU XIVE
> >  4. QEMU XICS
> >=20
> > which is better I think.
> >=20
>=20
> Using KVM XICS is indeed better than QEMU XIVE... but IIUC what David
> is saying, kernel-irqchip semantics are:
>=20
> - on: user favors performance, at the expense of a reduced spectrum
>       of usable hosts
>=20
> - absent: user favors being able to start the VM on a wider spectrum
>           of hosts, at the possible expense of performance

Correct.

> - off: user wants the VM to start on any host, doesn't care for
>        performance at all

Well, TBH, the main use of kernel-irqchip=3Doff is for debugging and testin=
g.

>=20
> So the only way to have 1. KVM XIVE 2.KVM XICS would be to pass "on".
>=20
> > C.
> >=20
> >=20
> > >  =20
> > >>
> > >> Signed-off-by: Greg Kurz <groug@kaod.org>
> > >> ---
> > >>  hw/ppc/spapr_irq.c |   10 ++++++++++
> > >>  1 file changed, 10 insertions(+)
> > >>
> > >> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > >> index 3156daf09381..d788bd662a7a 100644
> > >> --- a/hw/ppc/spapr_irq.c
> > >> +++ b/hw/ppc/spapr_irq.c
> > >> @@ -18,6 +18,7 @@
> > >>  #include "hw/ppc/xics_spapr.h"
> > >>  #include "cpu-models.h"
> > >>  #include "sysemu/kvm.h"
> > >> +#include "kvm_ppc.h"
> > >> =20
> > >>  #include "trace.h"
> > >> =20
> > >> @@ -668,6 +669,15 @@ static void spapr_irq_check(SpaprMachineState *=
spapr, Error **errp)
> > >>              return;
> > >>          }
> > >>      }
> > >> +
> > >> +    /*
> > >> +     * KVM may be too old to support XIVE, in which case we'd rathe=
r try
> > >> +     * to use the in-kernel XICS instead of the emulated XIVE.
> > >> +     */
> > >> +    if (kvm_enabled() && !kvmppc_has_cap_xive() &&
> > >> +        spapr->irq =3D=3D &spapr_irq_dual) {
> > >> +        spapr->irq =3D &spapr_irq_xics;
> > >> +    }
> > >>  }
> > >> =20
> > >>  /*
> > >> =20
> > >  =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0AVX0ACgkQbDjKyiDZ
s5IdsBAAqif/0RzYmNlTcv6pyGNOVTgi8zwbu4NEc8m63ccT5MGiZxSKO3YgIk0D
zlGEdC4ovVMmBPbb0ZsYv6t64lGPgVFtIyiSmpvUWFGuTvqYB60xgf6yU8fVyLHo
H+vtVZSC1YOM+r29Env/fljK6UXvYw7jVMqaPPCPHcHzRQR+oBI0nC8m3vguwyuc
LHhDn9Soj8A+LWJ3dtjbKhw5ZHdlIHoURVvrbmYeof7y5jrzs9YbLcrpbmULCwmC
kr3+4CZqRKyiO93x3vlVOyyjN/GC6F2SUOnncKNaOev7mrOtiZdo+dZSVZe6+nCr
2gEpAf6iMsNP3zvNn/rVgjAhaqMa55SGfwTs+zLi1DbB1ojiXhnvdhPWLn9mwxFA
dLRSngxcX0guTtuOdac8ZUfiXgaeu8fSw8zzc66yr7g5mLpK+v8mArXWC3q+BGnc
9zBQ6/yDsx24ozqFj8+qENC3dit86eScIGPx/0c6QpgSiDckEUVA0zonPGx6kKCb
0an1NJHK0/wHJgcVmBLGPqvg/bYmyGW2P3L2tV6TKHJpxlNcKlSbb1Tnwkekct/W
/YnrgbeTuyzRc5MWcko4KTF4BEk2m0pG74vANTNUzA4Tk6hpGUKucq1jnkUhUS66
w7cSg3/VcXZpy8sXkMq3+AhKLACA4b+1BO0xdLLVnpxFY7tDfNk=
=Jw7L
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--

