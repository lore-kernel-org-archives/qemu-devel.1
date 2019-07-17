Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B45C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CA8217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="b5aJHJKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CA8217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZGt-0002zh-CS
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44964)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnZG8-00011N-2W
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnZG6-0008CJ-Er
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:01:32 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40061)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnZG5-00087I-90; Tue, 16 Jul 2019 22:01:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45pL904B2dz9sNT; Wed, 17 Jul 2019 12:01:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563328884;
 bh=jvLVswi7c2/MltPFD8LtQpZkiFp5usMNH5XC87fnFIw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b5aJHJKWgcM/uWMapYmq4g1fwdjbLDY/zgB6jtMbSCmyJL70xZ4vQbzCy7tIbowP7
 ZpFAPuxPZitOwbwr55g1cflf7ioTH2cSz20ypJOtgXv88MOL9LIr/MtYqxRgf1HT7f
 eHouyytGA5gZtLrT+RPWY6lALofY8vKy18yFUwIs=
Date: Wed, 17 Jul 2019 11:54:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190717015402.GC9123@umbus.fritz.box>
References: <20190716024726.17864-1-npiggin@gmail.com>
 <20190716024726.17864-6-npiggin@gmail.com>
 <20190716083047.GG7525@umbus.fritz.box>
 <1563272743.gip4xrq099.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <1563272743.gip4xrq099.astroid@bobo.none>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v4 5/5] spapr: Implement ibm,suspend-me
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 09:15:23PM +1000, Nicholas Piggin wrote:
65;5603;1c> David Gibson's on July 16, 2019 6:30 pm:
> > On Tue, Jul 16, 2019 at 12:47:26PM +1000, Nicholas Piggin wrote:
> >> This has been useful to modify and test the Linux pseries suspend
> >> code but it requires modification to the guest to call it (due to
> >> being gated by other unimplemented features). It is not otherwise
> >> used by Linux yet, but work is slowly progressing there.
> >>=20
> >> This allows a (lightly modified) guest kernel to suspend with
> >> `echo mem > /sys/power/state` and be resumed with system_wakeup
> >> monitor command.
> >>=20
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>  hw/ppc/spapr.c         | 26 ++++++++++++++++++++++++++
> >>  hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
> >>  include/hw/ppc/spapr.h |  7 ++++++-
> >>  3 files changed, 64 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 5c54e1cb9a..b85d41bb1e 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1710,6 +1710,11 @@ static void spapr_machine_reset(MachineState *m=
achine)
> >>      void *fdt;
> >>      int rc;
> >> =20
> >> +    if (spapr->suspend_reset) {
> >> +        spapr->suspend_reset =3D false;
> >=20
> > Do we need to migrate this value?
>=20
> I suppose we do if we can migrate a suspended machine?

I don't see why we couldn't.  And it might not happen because of
explicit user choice in a managed environment like RHV or openstack.

> >> +        return;
> >> +    }
> >> +
> >>      spapr_caps_apply(spapr);
> >> =20
> >>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> >> @@ -2721,6 +2726,23 @@ static PCIHostState *spapr_create_default_phb(v=
oid)
> >>      return PCI_HOST_BRIDGE(dev);
> >>  }
> >> =20
> >> +static Notifier wakeup;
> >=20
> > I think this should be in sPAPRMachineState rather than global.
>=20
> Sure.
>=20
> >=20
> >> +static void spapr_notify_wakeup(Notifier *notifier, void *data)
> >> +{
> >> +    WakeupReason *reason =3D data;
> >> +
> >> +    switch (*reason) {
> >> +    case QEMU_WAKEUP_REASON_RTC:
> >> +        break;
> >> +    case QEMU_WAKEUP_REASON_PMTIMER:
> >> +        break;
> >> +    case QEMU_WAKEUP_REASON_OTHER:
> >> +        break;
> >> +    default:
> >> +        break;
> >> +    }
> >=20
> > So.. you have a bunch of switch cases, all of which ignore the input..
>=20
> Yeah I kind of just copy and pasted I think. This part of the patch
> may not have been quite as cooked as I remembered :\

Heh :).

> >> +}
> >> +
> >>  /* pSeries LPAR / sPAPR hardware init */
> >>  static void spapr_machine_init(MachineState *machine)
> >>  {
> >> @@ -3078,6 +3100,10 @@ static void spapr_machine_init(MachineState *ma=
chine)
> >> =20
> >>      qemu_register_boot_set(spapr_boot_set, spapr);
> >> =20
> >> +    wakeup.notify =3D spapr_notify_wakeup;
> >> +    qemu_register_wakeup_notifier(&wakeup);
> >> +    qemu_register_wakeup_support();
> >> +
> >>      if (kvm_enabled()) {
> >>          /* to stop and start vmclock */
> >>          qemu_add_vm_change_state_handler(cpu_ppc_clock_vm_state_chang=
e,
> >> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >> index a618a2ac0f..60a007ec38 100644
> >> --- a/hw/ppc/spapr_rtas.c
> >> +++ b/hw/ppc/spapr_rtas.c
> >> @@ -216,6 +216,36 @@ static void rtas_stop_self(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
> >>      qemu_cpu_kick(cs);
> >>  }
> >> =20
> >> +static void rtas_ibm_suspend_me(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
> >> +                           uint32_t token, uint32_t nargs,
> >> +                           target_ulong args,
> >> +                           uint32_t nret, target_ulong rets)
> >> +{
> >> +    CPUState *cs;
> >> +
> >> +    if (nargs !=3D 0 || nret !=3D 1) {
> >> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> >> +        return;
> >> +    }
> >> +
> >> +    CPU_FOREACH(cs) {
> >> +        PowerPCCPU *c =3D POWERPC_CPU(cs);
> >> +        CPUPPCState *e =3D &c->env;
> >> +        if (c =3D=3D cpu)
> >> +            continue;
> >> +
> >> +	/* See h_join */
> >> +        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
> >> +            rtas_st(rets, 0, H_MULTI_THREADS_ACTIVE);
> >> +            return;
> >> +        }
> >> +    }
> >> +
> >> +    spapr->suspend_reset =3D true;
> >> +    qemu_system_suspend_request();
> >> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >> +}
> >> +
> >>  static inline int sysparm_st(target_ulong addr, target_ulong len,
> >>                               const void *val, uint16_t vallen)
> >>  {
> >> @@ -483,6 +513,8 @@ static void core_rtas_register_types(void)
> >>                          rtas_query_cpu_stopped_state);
> >>      spapr_rtas_register(RTAS_START_CPU, "start-cpu", rtas_start_cpu);
> >>      spapr_rtas_register(RTAS_STOP_SELF, "stop-self", rtas_stop_self);
> >> +    spapr_rtas_register(RTAS_IBM_SUSPEND_ME, "ibm,suspend-me",
> >> +                        rtas_ibm_suspend_me);
> >>      spapr_rtas_register(RTAS_IBM_GET_SYSTEM_PARAMETER,
> >>                          "ibm,get-system-parameter",
> >>                          rtas_ibm_get_system_parameter);
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 5d36eec9d0..df0b0c15da 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -171,6 +171,10 @@ struct SpaprMachineState {
> >>      bool use_hotplug_event_source;
> >>      SpaprEventSource *event_sources;
> >> =20
> >> +    /* Machine has been suspended, so the next machine_reset should n=
ot
> >> +     * reset state, but just return and allow execution to resume. */
> >> +    bool suspend_reset;
> >=20
> > Hrm, this seems odd, but maybe it's part of the existing suspend
> > design.  Why would system_reset resume a suspend, rather than having a
> > specific operation for that.
>=20
> It is where `system_wakeup` cmd pops out, via qemu_system_reset,
> main_loop_should_exit. I'm not sure if we have any existing state
> we can use. runstate_is_running() doesn't seem to work because of
> CAS I guess (maybe CAS is what makes spapr so much different from
> x86 in terms of resetting the world here?)

CAS certainly complicates things.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0uf7oACgkQbDjKyiDZ
s5JLBg//a+cpUe5NBYrNkDTGGq3Q3Yy5tTjZe2KQvoAYI/zvc51+cgzAdTnZmY1P
YcxVUdG1HT0mR+GgmMqLHFOpwEB2E5RYtdUPx/ANP+KZ8vqO/djpgiLmEiOVGoCr
2C0F5ZmsWsEbn/rNDbYehUEGmF2/KNVckjkXGpjn5qThrjO5L8Kw4ybpBLiHU3nR
UB9I+XlNfnHMEtcxqF5dpJydv7YfA4O62nB+rmLI1w9ges51oSv7jxuJcNlaPIvh
N3eozuKvJgPgqTlF+VKDNbbyM12PC7q/DJ1qq7hEuOgiFBVs5Q1gPtg1gLlic8MD
BTa3idVpd+ET4eWSigZ8/ndPKrfmf/41kJtXRLiFMrFTr1WPyqrhaD38AAINM0Mj
8kk5JCfxq8osxqy1ycIh6hVjUd/RgVISuhTmhgOO9B3CT1i8eh5hkrEDMmG+gfYe
o0Sb3WoPBKQMgJ99aY8PCR5kYoRwC9BLBiI25f7FI/+Lszpo3wyd2oQIk/mDmlFn
q0LDRgk6EgictCeN/UAfi8vnPun+x7u8dkvVWH2RQfAuuAmJjG4kgFoDP55XGgLv
PobdJaNvExKVv+gnSlvBP0uyotqHNUV9b6GBrW34EI8P6nBNxoYzjZ5KCAD0nUW9
ZHrSr9ZRedIOFVCiyriVRV3KCXX478B5BS4yB0osNBDWMxZRPMM=
=lM1z
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--

