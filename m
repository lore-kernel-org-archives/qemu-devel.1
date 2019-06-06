Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1FAC28D18
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 02:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4A220866
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 02:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="e7M2tYrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4A220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYhzu-0005Uo-U7
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 22:19:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYhy9-0004SX-VU
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 22:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYhy8-00074n-Fm
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 22:17:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38763 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hYhy7-00072O-9g; Wed, 05 Jun 2019 22:17:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45K8SN1QFqz9s4Y; Thu,  6 Jun 2019 12:17:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559787444;
	bh=AMYmGRKOdVX28Yq7T9w3HRH+FsrMD64KbvAN2kvkKe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7M2tYrhWEckpWer5kz1UQrbhCCIbTpxHReLUoaHjVGeqf8tsyRsORnCwSVuNDVOh
	87wLIVNbEGqCQvP7a/4A8r3cVaT0P5tGQgSxHC/bcKHl5VmeQdIOPVMsp592EfBICu
	Jy0H4qm1zAoSD3J9O0YJfvU1E9eVRhZUFnX7cFDg=
Date: Thu, 6 Jun 2019 11:43:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190606014306.GF10319@umbus.fritz.box>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
	<155910843201.13149.14968680567084380259.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <155910843201.13149.14968680567084380259.stgit@aravinda>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v9 3/6] target/ppc: Handle NMI guest exit
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2019 at 11:10:32AM +0530, Aravinda Prasad wrote:
> Memory error such as bit flips that cannot be corrected
> by hardware are passed on to the kernel for handling.
> If the memory address in error belongs to guest then
> the guest kernel is responsible for taking suitable action.
> Patch [1] enhances KVM to exit guest with exit reason
> set to KVM_EXIT_NMI in such cases. This patch handles
> KVM_EXIT_NMI exit.
>=20
> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
>     (e20bbd3d and related commits)
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c          |    1 +
>  hw/ppc/spapr_events.c   |   23 +++++++++++++++++++++++
>  hw/ppc/spapr_rtas.c     |    5 +++++
>  include/hw/ppc/spapr.h  |    6 ++++++
>  target/ppc/kvm.c        |   16 ++++++++++++++++
>  target/ppc/kvm_ppc.h    |    2 ++
>  target/ppc/trace-events |    1 +
>  7 files changed, 54 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index fae28a9..6b6c962 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1809,6 +1809,7 @@ static void spapr_machine_reset(void)
> =20
>      spapr->cas_reboot =3D false;
> =20
> +    spapr->mc_status =3D -1;
>      spapr->guest_machine_check_addr =3D -1;
> =20
>      /* Signal all vCPUs waiting on this condition */
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index ae0f093..a18446b 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -620,6 +620,29 @@ void spapr_hotplug_req_remove_by_count_indexed(Spapr=
DrcType drc_type,
>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc=
_id);
>  }
> =20
> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());

You ignore the 'recovered' parameter, is that right?

> +    while (spapr->mc_status !=3D -1) {
> +        /*
> +         * Check whether the same CPU got machine check error
> +         * while still handling the mc error (i.e., before
> +         * that CPU called "ibm,nmi-interlock")
> +         */
> +        if (spapr->mc_status =3D=3D cpu->vcpu_id) {
> +            qemu_system_guest_panicked(NULL);
> +            return;
> +        }
> +        qemu_cond_wait_iothread(&spapr->mc_delivery_cond);
> +        /* Meanwhile if the system is reset, then just return */
> +        if (spapr->guest_machine_check_addr =3D=3D -1) {
> +            return;
> +        }
> +    }
> +    spapr->mc_status =3D cpu->vcpu_id;
> +}
> +
>  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                              uint32_t token, uint32_t nargs,
>                              target_ulong args,
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index e7509cf..e0bdfc8 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -379,6 +379,11 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>          /* NMI register not called */
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>      } else {
> +        /*
> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> +         * hence unset mc_status.
> +         */
> +        spapr->mc_status =3D -1;
>          qemu_cond_signal(&spapr->mc_delivery_cond);
>          rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>      }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9dc5e30..fc3a776 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -190,6 +190,11 @@ struct SpaprMachineState {
> =20
>      /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls=
 */
>      target_ulong guest_machine_check_addr;
> +    /*
> +     * mc_status is set to -1 if mc is not in progress, else is set to t=
he CPU
> +     * handling the mc.
> +     */
> +    int mc_status;
>      QemuCond mc_delivery_cond;
> =20
>      /*< public >*/
> @@ -793,6 +798,7 @@ void spapr_clear_pending_events(SpaprMachineState *sp=
apr);
>  int spapr_max_server_number(SpaprMachineState *spapr);
>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>                        uint64_t pte0, uint64_t pte1);
> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
> =20
>  /* DRC callbacks. */
>  void spapr_core_release(DeviceState *dev);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 3bf0a46..39f1a73 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1761,6 +1761,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_=
run *run)
>          ret =3D 0;
>          break;
> =20
> +    case KVM_EXIT_NMI:
> +        trace_kvm_handle_nmi_exception();
> +        ret =3D kvm_handle_nmi(cpu, run);
> +        break;
> +
>      default:
>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reaso=
n);
>          ret =3D -1;
> @@ -2844,6 +2849,17 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>      return data & 0xffff;
>  }
> =20
> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
> +{
> +    bool recovered =3D run->flags & KVM_RUN_PPC_NMI_DISP_FULLY_RECOV;
> +
> +    cpu_synchronize_state(CPU(cpu));
> +
> +    spapr_mce_req_event(cpu, recovered);

Urgh.. KVM calling directly into spapr code isn't conceptually
correct, although it's usually kind of ok in practice.  I guess we
already do it for hypercalls, so this is no worse.  If we ever have
NMI events for KVM PR or BookE KVM which could happen for non-PAPR
guests, I guess we'll need to re-examine this.

> +    return 0;
> +}
> +
>  int kvmppc_enable_hwrng(void)
>  {
>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_PPC_HW=
RNG)) {
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 45776ca..18693f1 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -81,6 +81,8 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void);
>  void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
>  void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
> =20
> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
> +
>  #else
> =20
>  static inline uint32_t kvmppc_get_tbfreq(void)
> diff --git a/target/ppc/trace-events b/target/ppc/trace-events
> index 3dc6740..6d15aa9 100644
> --- a/target/ppc/trace-events
> +++ b/target/ppc/trace-events
> @@ -28,3 +28,4 @@ kvm_handle_papr_hcall(void) "handle PAPR hypercall"
>  kvm_handle_epr(void) "handle epr"
>  kvm_handle_watchdog_expiry(void) "handle watchdog expiry"
>  kvm_handle_debug_exception(void) "handle debug exception"
> +kvm_handle_nmi_exception(void) "handle NMI exception"
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz4b6oACgkQbDjKyiDZ
s5JKRBAAvbQRw9N/5CDjYT/MtMoyVfvEXvjhTWKOblbdadWKYNR+quZwPPJUVZh4
4UX7+/kuH9cA4ZeHHs7HIceDlbwLNkh1dkvfKDf5MW02x6q0dh2RrlPJwucPfBz7
nBmIKenGoY1MXV6PPUtH5zzNg94HyS7k7FEG7tycMtgfWmSIa2gsGl2rPqZ3PsW0
WnQo7UVTB5RoY4KT8+TNVUTnJ3SJAbQX1DZmmvAVjcT20qrk7Ua2vqTZtaogxCau
tuIAfeUTl7Ux/zNpMyHrQRBv9+ge4hNE+wB838QBsEDgQjFlnFxnxwx8TY7H1bxs
WV2HD1Re5kdMNvoIYkOcRHCbXENVfXDofYUKnG9lR3Kd5JTfBGq62r2e9z6H3uBz
iOnxdzRMGQwXiCHQ/j5H65c8cgkbCZy0lafYeRYM3IF+DtK1wNbimUk807j0C2z9
4bKbmRiNF18wnmNF4F9PvEPiyHaUwbiTqjblfIo8pU0HVMHNAQDpUkwM0txMff3w
TV8WZgJPitt3eyixC7YyOHxxr6iHxuwdhHaSOGKFNI0TEHDtx32N1WJM5ejKN9BI
F8DP5tYiRwn/0J230tdwD9erdmcf39sqjMmapJt9o8DYwZOL9SmdGV4nl5yIfYZ+
mFAIDGozVrhBA0VPKx4LIdpjdD+tQZgiC9R4ILLE/vv+4UuSC3Y=
=juX6
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--

