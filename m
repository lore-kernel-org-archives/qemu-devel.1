Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EACECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C062089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C062089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL1fA-0004s3-5g
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 05:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iL1e5-0004GQ-8F
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iL1e3-0004l1-Ff
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:00:32 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:59762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iL1e3-0004h6-94
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:00:31 -0400
Received: from player771.ha.ovh.net (unknown [10.108.57.245])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id E267C1472FB
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:00:28 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id 6F80BB13AF12;
 Thu, 17 Oct 2019 09:00:22 +0000 (UTC)
Date: Thu, 17 Oct 2019 11:00:19 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [RFC 5/5] spapr: Work around spurious warnings from vfio INTx
 initialization
Message-ID: <20191017110019.3c900fbc@bahia.lan>
In-Reply-To: <3cded480-ce51-eef7-dc75-686022a18726@kaod.org>
References: <20191017054218.8876-1-david@gibson.dropbear.id.au>
 <20191017054218.8876-6-david@gibson.dropbear.id.au>
 <3cded480-ce51-eef7-dc75-686022a18726@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 3291005431517714827
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeejgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.52.162
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
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 10:43:11 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 17/10/2019 07:42, David Gibson wrote:
> > Traditional PCI INTx for vfio devices can only perform well if using
> > an in-kernel irqchip.  Therefore, vfio_intx_update() issues a warning
> > if an in kernel irqchip is not available.
> >=20
> > We usually do have an in-kernel irqchip available for pseries machines
> > on POWER hosts.  However, because the platform allows feature
> > negotiation of what interrupt controller model to use, we don't
> > currently initialize it until machine reset.  vfio_intx_update() is
> > called (first) from vfio_realize() before that, so it can issue a
> > spurious warning, even if we will have an in kernel irqchip by the
> > time we need it.
> >=20
> > To workaround this, make a call to spapr_irq_update_active_intc() from
> > spapr_irq_init() which is called at machine realize time, before the
> > vfio realize.  This call will be pretty much obsoleted by the later
> > call at reset time, but it serves to suppress the spurious warning
> > from VFIO.
> >=20
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_irq.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 45544b8976..bb91c61fa0 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -345,6 +345,14 @@ void spapr_irq_init(SpaprMachineState *spapr, Erro=
r **errp)
> > =20
> >      spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
> >                                        smc->nr_xirqs + SPAPR_XIRQ_BASE);
> > +
> > +    /*
> > +     * Mostly we don't actually need this until reset, except that not
> > +     * having this set up can cause VFIO devices to issue a
> > +     * false-positive warning during realize(), because they don't yet
> > +     * have an in-kernel irq chip.
> > +     */
> > +    spapr_irq_update_active_intc(spapr);
>=20
> This will call the de/activate hooks of the irq chip very early=20
> before reset and CAS, and won't call them at reset if the intc
> pointers are the same (xive only for instance). It breaks very=20
> obviously the emulated XIVE device which won't reset the OS CAM=20
> line with the CPU id values and CPU notification will be broken.
>=20

Yes. The problem is that we now have a new path:

spapr_irq_init()
 spapr_irq_update_active_intc()
  set_active_intc()
   spapr_xive_activate()

and we go there before the CPUs are realized:

(gdb) p cpus
$6 =3D {tqh_first =3D 0x0, tqh_circ =3D {tql_next =3D 0x0,=20
    tql_prev =3D 0x100f203a8 <cpus>}}

spapr_xive_activate() thus doesn't reset the OS CAM line.

When the initial machine reset happens later, CPUs are
present but we don't go down the activate path since XIVE
is already active.

Commenting away the following check in set_active_intc() is enough
to fix:

    if (new_intc =3D=3D spapr->active_intc) {
        /* Nothing to do */
        return;
    }

but this also reveals that handling the OS CAM line reset in
spapr_xive_activate() only may be a bit fragile since it obviously
requires CPUs to be present... Maybe this should also be done by
the CPUs on their realize path ?

> We have to find something else.
>=20
>=20
> >  }
> > =20
> >  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
> > @@ -500,7 +508,8 @@ void spapr_irq_update_active_intc(SpaprMachineState=
 *spapr)
> >           * this.
> >           */
> >          new_intc =3D SPAPR_INTC(spapr->xive);
> > -    } else if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> > +    } else if (spapr->ov5_cas
> > +               && spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
>=20
> This change can go in another patch.
>=20
> C.=20
>=20
> >          new_intc =3D SPAPR_INTC(spapr->xive);
> >      } else {
> >          new_intc =3D SPAPR_INTC(spapr->ics);
> >=20
>=20


