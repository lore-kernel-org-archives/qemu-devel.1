Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A94DC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF20208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF20208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCY8-0003oO-Mm
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53478)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hZBVa-0007Er-39
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hZBVY-0004aD-0Q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:50:01 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:53243)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hZBVX-0004T1-Qx
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:49:59 -0400
Received: from player715.ha.ovh.net (unknown [10.109.159.159])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 4D3C810D095
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 11:49:56 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id 0127F68B750D;
 Fri,  7 Jun 2019 09:49:51 +0000 (UTC)
Date: Fri, 7 Jun 2019 11:49:50 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Message-ID: <20190607114950.3247af33@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <2d02c8d1-d9f4-efd0-5059-6ca24e622107@kaod.org>
References: <155984093894.2803172.8618224129384655510.stgit@bahia.lan>
 <20190607001901.GC3760@umbus.fritz.box>
 <2d02c8d1-d9f4-efd0-5059-6ca24e622107@kaod.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 3693796122297735563
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudegiedgudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.49
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 10:17:58 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 07/06/2019 02:19, David Gibson wrote:
> > On Thu, Jun 06, 2019 at 07:08:59PM +0200, Greg Kurz wrote: =20
> >> If KVM is too old to support XIVE native exploitation mode, we might e=
nd
> >> up using the emulated XIVE after CAS. This is sub-optimal if KVM in-ke=
rnel
> >> XICS is available, which is the case most of the time. =20
> >=20
> > This is intentional.  A predictable guest environment trumps performanc=
e. =20
>=20
> I don't agree.=20
>=20
> If the user does not specify any specific interrupt mode, we should favor=
=20
> the faster one.=20
>=20

This all boils down to the semantics of "dual"... "XICS AND XIVE" or "any
of XICS or XIVE" ?

We already have a precedent when using pre-power9 compat mode. If the
user passes ic-mode=3Ddual,max-compat-cpu=3Dpower8, we internally convert
"dual" to act as "xics". The rationale is that a guest running in
power8 architected mode isn't supposed to know about XIVE at all.

Should we forbid this config and exit QEMU instead ?

> Here is the current matrix (with this patch) for guests running on an=20
> old KVM, that is without KVM XIVE support. Let's discuss on what we
> want.=20
>=20
>                         kernel_irqchip
>=20
>            (default)=20
> ic-mode     allowed           off            on=20
>=20
> dual        XICS KVM       XICS emul.(3)   XICS KVM         (default mode)
> xics        XICS KVM       XICS emul.      XICS KVM   =20
> xive        XIVE emul.(1)  XIVE emul.     QEMU failure (2)
>=20
>=20
> (1) QEMU warns with "warning: kernel_irqchip requested but unavailable:=20
>     IRQ_XIVE capability must be present for KVM"=20
> (2) QEMU fails with "kernel_irqchip requested but unavailable:=20
>     IRQ_XIVE capability must be present for KVM"=20
> (3) That is wrong I think, we should get XIVE emulated.
>=20

This is the logical consequence of turning "dual" into "xics".

>=20
> what you would want is XIVE emulation when ic-mode=3Ddual and=20
> kernel_irqchip=3Dallowed, which is the behavior with this patch (but there

I guess you mean s/with/without=20

> are reboot bugs)
>=20

Yeah. If the semantics of "dual" is to always advertise XICS AND XIVE, and =
we
keep the current fallback behavior, then we need each implementation to have
proper init/teardown support as well as proper rollback on error paths.

This is definitely not the case: rollback is missing in both in-kernel=20
XICS and XIVE code and the emulated XICS and XIVE don't have teardown.

This can generate a variety of bugs, including QEMU crashes... the old KVM =
case
is just one of them, but there might be others.

> =20
> >> Also, an old KVM may not allow to destroy and re-create the KVM XICS, =
which
> >> is precisely what "dual" does during machine reset. This causes QEMU t=
o try
> >> to switch to emulated XICS and to crash because RTAS call de-registrat=
ion
> >> isn't handled correctly. We could possibly fix that, but again we would
> >> still end up with an emulated XICS or XIVE. =20
> >=20
> > Ugh, that's a problem. =20
>=20
> Yes. It's another problem around the way we cleanup the allocated resourc=
es.
> It should be another patch.
>=20

Yeah, probably many other patches...

> >  =20
> >> "dual" is definitely not a good choice with older KVMs. Internally for=
ce
> >> XICS when we detect this. =20
> >=20
> > But this is not an acceptable solution.  Silently changing the guest
> > visible environment based on host capabilities is never ok.  =20
>=20
> If the host (KVM) doesn't have a capability, what is the point of trying=
=20
> to use it if we can do better. I know you are considering KVM/QEMU as a
> whole but who would run with kernel_irqchip=3Doff ?
>=20

The real problem is when you don't pass kernel_irqchip at all. Combined
with "dual", this gives a fair number of cases. Do we want to support
all possible transitions ?

> > We must
> > either give the guest environment that the user has requested, or fail
> > outright. =20
>=20
> 'dual' mode means both and the user is not requesting XIVE. We are changi=
ng=20
> the priority of choices from :
>=20
>  1. KVM XIVE
>  2. QEMU XIVE
>  3. KVM XICS
>  4. QEMU XICS
>=20
> to:
>=20
>  1. KVM XIVE
>  2. KVM XICS
>  3. QEMU XIVE
>  4. QEMU XICS
>=20
> which is better I think.
>=20

Using KVM XICS is indeed better than QEMU XIVE... but IIUC what David
is saying, kernel-irqchip semantics are:

- on: user favors performance, at the expense of a reduced spectrum
      of usable hosts

- absent: user favors being able to start the VM on a wider spectrum
          of hosts, at the possible expense of performance

- off: user wants the VM to start on any host, doesn't care for
       performance at all

So the only way to have 1. KVM XIVE 2.KVM XICS would be to pass "on".

> C.
>=20
>=20
> >  =20
> >>
> >> Signed-off-by: Greg Kurz <groug@kaod.org>
> >> ---
> >>  hw/ppc/spapr_irq.c |   10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> >> index 3156daf09381..d788bd662a7a 100644
> >> --- a/hw/ppc/spapr_irq.c
> >> +++ b/hw/ppc/spapr_irq.c
> >> @@ -18,6 +18,7 @@
> >>  #include "hw/ppc/xics_spapr.h"
> >>  #include "cpu-models.h"
> >>  #include "sysemu/kvm.h"
> >> +#include "kvm_ppc.h"
> >> =20
> >>  #include "trace.h"
> >> =20
> >> @@ -668,6 +669,15 @@ static void spapr_irq_check(SpaprMachineState *sp=
apr, Error **errp)
> >>              return;
> >>          }
> >>      }
> >> +
> >> +    /*
> >> +     * KVM may be too old to support XIVE, in which case we'd rather =
try
> >> +     * to use the in-kernel XICS instead of the emulated XIVE.
> >> +     */
> >> +    if (kvm_enabled() && !kvmppc_has_cap_xive() &&
> >> +        spapr->irq =3D=3D &spapr_irq_dual) {
> >> +        spapr->irq =3D &spapr_irq_xics;
> >> +    }
> >>  }
> >> =20
> >>  /*
> >> =20
> >  =20
>=20


