Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8F2C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3104A2190D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3104A2190D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpZZA-0003pr-Dc
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 10:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40420)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hpZYx-0003N1-2J
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hpZYv-0001Ig-KR
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:45:15 -0400
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:60792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hpZYv-00018Q-CT
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:45:13 -0400
Received: from player798.ha.ovh.net (unknown [10.108.57.178])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 0242012AC54
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 16:45:03 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id B10A2846C58D;
 Mon, 22 Jul 2019 14:44:57 +0000 (UTC)
Date: Mon, 22 Jul 2019 16:44:55 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190722164455.57ce9913@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190722084424.GH25073@umbus.fritz.box>
References: <156352619712.50279.1247507600735238783.stgit@lep8c.aus.stglabs.ibm.com>
 <20190722084424.GH25073@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aZbHqv/hraMnw9VaQTqveQB"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 14694682637824137702
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrjeeggdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.120.239
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4] ppc: make idle_timer a
 per-cpu variable
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
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/aZbHqv/hraMnw9VaQTqveQB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2019 18:44:24 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Jul 19, 2019 at 03:51:26AM -0500, Shivaprasad G Bhat wrote:
> > The current code is broken for more than vcpu as
> > each thread would overwrite idle_timer and there were
> > memory leaks.
> >=20
> > Make it part of PowerPCCPU so that every thread has a
> > separate one. Avoid using the timer_new_ns which is
> > not the preferred way to create timers.
> >=20
> > Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> So, this looks correct, but..
>=20
> ..the whole idle_timer logic is used only in the case that we're
> running with a KVM that doesn't support KVM_CAP_PPC_IRQ_LEVEL.  That
> support appears to have been in since around v2.6.36 some 9 years
> ago.  We could probably just drop support for such old kernels in qemu
> instead.
>=20

Ha ! Yes, this is likely the best thing to do :)

> > ---
> >  v3: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04375.html
> >  Changes from v3:
> >     - Calling timer_del() before timer_deinit()
> >=20
> >  target/ppc/cpu.h |    1 +
> >  target/ppc/kvm.c |   32 +++++++++++++++++---------------
> >  2 files changed, 18 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index c9beba2a5c..521086d91a 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1190,6 +1190,7 @@ struct PowerPCCPU {
> >      void *machine_data;
> >      int32_t node_id; /* NUMA node this CPU belongs to */
> >      PPCHash64Options *hash64_opts;
> > +    QEMUTimer idle_timer;
> > =20
> >      /* Fields related to migration compatibility hacks */
> >      bool pre_2_8_migration;
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 8a06d3171e..52d3292f45 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -87,18 +87,6 @@ static int cap_large_decr;
> > =20
> >  static uint32_t debug_inst_opcode;
> > =20
> > -/*
> > - * XXX We have a race condition where we actually have a level trigger=
ed
> > - *     interrupt, but the infrastructure can't expose that yet, so the=
 guest
> > - *     takes but ignores it, goes to sleep and never gets notified tha=
t there's
> > - *     still an interrupt pending.
> > - *
> > - *     As a quick workaround, let's just wake up again 20 ms after we =
injected
> > - *     an interrupt. That way we can assure that we're always reinject=
ing
> > - *     interrupts in case the guest swallowed them.
> > - */
> > -static QEMUTimer *idle_timer;
> > -
> >  static void kvm_kick_cpu(void *opaque)
> >  {
> >      PowerPCCPU *cpu =3D opaque;
> > @@ -491,7 +479,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >          return ret;
> >      }
> > =20
> > -    idle_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
> > +    timer_init_ns(&cpu->idle_timer, QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, =
cpu);
> > =20
> >      switch (cenv->mmu_model) {
> >      case POWERPC_MMU_BOOKE206:
> > @@ -523,6 +511,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
> > =20
> >  int kvm_arch_destroy_vcpu(CPUState *cs)
> >  {
> > +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > +
> > +    timer_del(&cpu->idle_timer);
> > +    timer_deinit(&cpu->idle_timer);
> > +
> >      return 0;
> >  }
> > =20
> > @@ -1379,8 +1372,17 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_r=
un *run)
> >              printf("cpu %d fail inject %x\n", cs->cpu_index, irq);
> >          }
> > =20
> > -        /* Always wake up soon in case the interrupt was level based */
> > -        timer_mod(idle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> > +        /*
> > +         * XXX We have a race condition where we actually have a level
> > +         *     triggered interrupt, but the infrastructure can't expos=
e that
> > +         *     yet, so the guest takes but ignores it, goes to sleep a=
nd
> > +         *     never gets notified that there's still an interrupt pen=
ding.
> > +         *
> > +         *     As a quick workaround, let's just wake up again 20 ms a=
fter
> > +         *     we injected an interrupt. That way we can assure that w=
e're
> > +         *     always reinjecting interrupts in case the guest swallow=
ed them.
> > +         */
> > +        timer_mod(&cpu->idle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL) +
> >                         (NANOSECONDS_PER_SECOND / 50));
> >      }
> > =20
> >=20
>=20


--Sig_/aZbHqv/hraMnw9VaQTqveQB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl01y+cACgkQcdTV5YIv
c9Ykyw/+NJNe28T3J/f0+cpo+5rFnHDkZZUw/TwPuMJ3b31masRi8yOhhK+Qklmm
U5+TC2lCRZdTH19kjrv9gOKLh3xHciFg4cu/moH/2qlOmIIPzuXPL98csbti5iU6
2x6KCDf5qzr7MIb9G6MbhGYRW5eqpOViaNOiV0kdKWOsmQ6p1+HX+4267MAmTqUI
jLoJMHoGsqJLafwc/jhW3ITXzlKWVgvEjh1BH65WF0i7/hukRlV5BsEjyob7edQr
RP8b9E1Yh5aZz2uIPBJCFgn6dzFBpY2QBl4SCdkUEcAVTu0eOuUB92ckJyqqVEbL
/fcAlUOSHGs4HQEMr/YOz3CxEIMqCkXbJoPGY4ty2CaQLHSePHpSpiTb1zPtMEXv
stviyBQ3nYtuUuajNtn3jkBWvWWdPBRMVJrSfPBUvCEvts7Qb9Mmq0EsWmbwJ9gr
bp+QjlYyj5peKkc2s9Ab+b5saGO6QaF067kcNVIgzv6gJsa0pmExDj0PcDfmMpLp
XojVW3IaFnHJzA7VYy5utCjNEChrTRYt0JqYMOYFNfQpzNmeR9iHvE7JvPzVmGM8
hh8XXNmTfW8H9Bgzazxc4vZvM9UPjYF+0LrrCogaWDLyJGxIqWpRUwsN7/ry1zaj
XJhxWCWdWK/sVtY5E4cH4SE4QQJ1s6kCrS8uNU2Nbvw+i6MkYzs=
=NOID
-----END PGP SIGNATURE-----

--Sig_/aZbHqv/hraMnw9VaQTqveQB--

