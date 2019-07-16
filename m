Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97862C76195
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E1E21721
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="A1ufJ/qG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E1E21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnJDb-0001rB-1J
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45104)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnJD1-00006g-IV
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnJD0-0007TR-3Q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:53:15 -0400
Received: from ozlabs.org ([203.11.71.1]:49053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnJCz-0007SH-1M; Tue, 16 Jul 2019 04:53:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45nvLY3dNFz9sNf; Tue, 16 Jul 2019 18:53:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563267189;
 bh=JP3aQ3UpVaaRvKWN607lBrrvkr6kDcLbQKudQ1bS/dc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A1ufJ/qGYia2QdZUH3Xoe9kxPFH294kp/G3PbOZHEIoqgMu2MgSCX7gnrJBUYnqQs
 E58be8hU7wGWzPwbH+A2k4gtuuk2ZvZWRp9ADAdpQm2Mi/ufjhVuPt0ABr1eIn9vYH
 MnNUXldgX+WfWwKPQjuSqq2yU7+lIYqlqkTVH1O8=
Date: Tue, 16 Jul 2019 18:30:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190716083047.GG7525@umbus.fritz.box>
References: <20190716024726.17864-1-npiggin@gmail.com>
 <20190716024726.17864-6-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline
In-Reply-To: <20190716024726.17864-6-npiggin@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 12:47:26PM +1000, Nicholas Piggin wrote:
> This has been useful to modify and test the Linux pseries suspend
> code but it requires modification to the guest to call it (due to
> being gated by other unimplemented features). It is not otherwise
> used by Linux yet, but work is slowly progressing there.
>=20
> This allows a (lightly modified) guest kernel to suspend with
> `echo mem > /sys/power/state` and be resumed with system_wakeup
> monitor command.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr.c         | 26 ++++++++++++++++++++++++++
>  hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  7 ++++++-
>  3 files changed, 64 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5c54e1cb9a..b85d41bb1e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1710,6 +1710,11 @@ static void spapr_machine_reset(MachineState *mach=
ine)
>      void *fdt;
>      int rc;
> =20
> +    if (spapr->suspend_reset) {
> +        spapr->suspend_reset =3D false;

Do we need to migrate this value?

> +        return;
> +    }
> +
>      spapr_caps_apply(spapr);
> =20
>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> @@ -2721,6 +2726,23 @@ static PCIHostState *spapr_create_default_phb(void)
>      return PCI_HOST_BRIDGE(dev);
>  }
> =20
> +static Notifier wakeup;

I think this should be in sPAPRMachineState rather than global.

> +static void spapr_notify_wakeup(Notifier *notifier, void *data)
> +{
> +    WakeupReason *reason =3D data;
> +
> +    switch (*reason) {
> +    case QEMU_WAKEUP_REASON_RTC:
> +        break;
> +    case QEMU_WAKEUP_REASON_PMTIMER:
> +        break;
> +    case QEMU_WAKEUP_REASON_OTHER:
> +        break;
> +    default:
> +        break;
> +    }

So.. you have a bunch of switch cases, all of which ignore the input..

> +}
> +
>  /* pSeries LPAR / sPAPR hardware init */
>  static void spapr_machine_init(MachineState *machine)
>  {
> @@ -3078,6 +3100,10 @@ static void spapr_machine_init(MachineState *machi=
ne)
> =20
>      qemu_register_boot_set(spapr_boot_set, spapr);
> =20
> +    wakeup.notify =3D spapr_notify_wakeup;
> +    qemu_register_wakeup_notifier(&wakeup);
> +    qemu_register_wakeup_support();
> +
>      if (kvm_enabled()) {
>          /* to stop and start vmclock */
>          qemu_add_vm_change_state_handler(cpu_ppc_clock_vm_state_change,
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index a618a2ac0f..60a007ec38 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -216,6 +216,36 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
>      qemu_cpu_kick(cs);
>  }
> =20
> +static void rtas_ibm_suspend_me(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
> +                           uint32_t token, uint32_t nargs,
> +                           target_ulong args,
> +                           uint32_t nret, target_ulong rets)
> +{
> +    CPUState *cs;
> +
> +    if (nargs !=3D 0 || nret !=3D 1) {
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *c =3D POWERPC_CPU(cs);
> +        CPUPPCState *e =3D &c->env;
> +        if (c =3D=3D cpu)
> +            continue;
> +
> +	/* See h_join */
> +        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
> +            rtas_st(rets, 0, H_MULTI_THREADS_ACTIVE);
> +            return;
> +        }
> +    }
> +
> +    spapr->suspend_reset =3D true;
> +    qemu_system_suspend_request();
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +}
> +
>  static inline int sysparm_st(target_ulong addr, target_ulong len,
>                               const void *val, uint16_t vallen)
>  {
> @@ -483,6 +513,8 @@ static void core_rtas_register_types(void)
>                          rtas_query_cpu_stopped_state);
>      spapr_rtas_register(RTAS_START_CPU, "start-cpu", rtas_start_cpu);
>      spapr_rtas_register(RTAS_STOP_SELF, "stop-self", rtas_stop_self);
> +    spapr_rtas_register(RTAS_IBM_SUSPEND_ME, "ibm,suspend-me",
> +                        rtas_ibm_suspend_me);
>      spapr_rtas_register(RTAS_IBM_GET_SYSTEM_PARAMETER,
>                          "ibm,get-system-parameter",
>                          rtas_ibm_get_system_parameter);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5d36eec9d0..df0b0c15da 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -171,6 +171,10 @@ struct SpaprMachineState {
>      bool use_hotplug_event_source;
>      SpaprEventSource *event_sources;
> =20
> +    /* Machine has been suspended, so the next machine_reset should not
> +     * reset state, but just return and allow execution to resume. */
> +    bool suspend_reset;

Hrm, this seems odd, but maybe it's part of the existing suspend
design.  Why would system_reset resume a suspend, rather than having a
specific operation for that.

> +
>      /* ibm,client-architecture-support option negotiation */
>      bool cas_reboot;
>      bool cas_legacy_guest_workaround;
> @@ -631,8 +635,9 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_=
ulong opcode,
>  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
> +#define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
> =20
> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2B)
> =20
>  /* RTAS ibm,get-system-parameter token values */
>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0tizcACgkQbDjKyiDZ
s5KNvQ/+K32uYHc43V0RovZPavtxaS35GwlXbXSQomjyWEtmb11gDkMI+qO5v0qF
4SFOO4bSTu3yzD1jjR0x6HQI6yLiZfU23Ey072HMRz6ocCRYKWRfvQy06oKzvZKm
DYv0HpuI85lpPKv2BNY3FJpwB4L42qBE2mpKCUQyoIEyxFibJ7QPcKbqZymwxHrG
ZK0Jtp85i3v2gMDJ6VkgHg48auY5em3wTRMSOIAC78US4fxn/mkfnQ81jGLiAjo9
lPg7Amj40ond/0A4eOhIjPX3ciTmLTIuhcfcuCdfJetAfKKDCEJDUAMaWri5d2g6
W3kRvqH/3at/zS8jbcrsKdvT5c1uDYkoJ+9cLfz5wBxxWOdppFb9Q9N4OPiJAhc4
U/JX8nftnGYJXueV9Gp3KIRFcvp0Ir3F6FEp5OthHxPzw16qL4VLvVZ2gYk1DFlw
TQL7g9vh3UhHzE3iBTt0WmaqQR/KLcU6nkLoWJCHyS06+C5+/z/HyY91KrN0VgPX
evjT/PWs4s3cu6o+Wo81aUwtedOrTqSlKOqUhxD494mmxjj4S3dhUSxfZ6T7Xknp
tSduuzk5J0ucW6hcGFORy2yaTyBidIfhom+EXnWxlzN25HmDfWA8AHGhBvKG8J/I
Rkt+mpS8UFzmJvF3ZW0hJPAqUgMt4N/wcSkgxJJYz5KzS67O8Kc=
=IMNe
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--

