Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1830EC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0AF216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fYp6L4FL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0AF216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiAWq-0005Vl-7i
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41692)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiAAC-0008Dl-Bz
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiAA8-0005LI-OD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:13:02 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54893 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiAA6-0005G8-Db; Tue, 02 Jul 2019 00:13:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45d9nX3gmFz9s00; Tue,  2 Jul 2019 14:12:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562040768;
 bh=nrGDtyTpRSEsFlIAVVjV7k3k2A1TjuR6JTDGKcHe9TA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fYp6L4FLLnK0hwC61YHFf/eup/sKi5/i4IzEYkAMReIvL17aU01JYIA01tidIFEpt
 5xNj+uHx/BmoDbKu7THh5+FrrNS08w8qeyc6q7WzAyMnM3tVecwIz1f7RvDru6uFpA
 Ahp6wqGECuGFHR/9xJfsv16drskFzWtbPuliEyws=
Date: Tue, 2 Jul 2019 13:52:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190702035233.GH6779@umbus.fritz.box>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033127298.26635.17253629451311229799.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="svZFHVx8/dhPCe52"
Content-Disposition: inline
In-Reply-To: <156033127298.26635.17253629451311229799.stgit@aravinda>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v10 3/6] target/ppc: Handle NMI guest exit
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--svZFHVx8/dhPCe52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 02:51:13PM +0530, Aravinda Prasad wrote:
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c          |    8 ++++++++
>  hw/ppc/spapr_events.c   |   23 +++++++++++++++++++++++
>  include/hw/ppc/spapr.h  |   10 ++++++++++
>  target/ppc/kvm.c        |   14 ++++++++++++++
>  target/ppc/kvm_ppc.h    |    2 ++
>  target/ppc/trace-events |    1 +
>  6 files changed, 58 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2ef86aa..6cc2c3b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1806,6 +1806,12 @@ static void spapr_machine_reset(void)
>      first_ppc_cpu->env.gpr[5] =3D 0;
> =20
>      spapr->cas_reboot =3D false;
> +
> +    spapr->mc_status =3D -1;
> +    spapr->guest_machine_check_addr =3D -1;
> +
> +    /* Signal all vCPUs waiting on this condition */
> +    qemu_cond_broadcast(&spapr->mc_delivery_cond);
>  }
> =20
>  static void spapr_create_nvram(SpaprMachineState *spapr)
> @@ -3070,6 +3076,8 @@ static void spapr_machine_init(MachineState *machin=
e)
> =20
>          kvmppc_spapr_enable_inkernel_multitce();
>      }
> +
> +    qemu_cond_init(&spapr->mc_delivery_cond);
>  }
> =20
>  static int spapr_kvm_type(MachineState *machine, const char *vm_type)
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index ae0f093..a0c66d7 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -620,6 +620,29 @@ void spapr_hotplug_req_remove_by_count_indexed(Spapr=
DrcType drc_type,
>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc=
_id);
>  }
> =20
> +void spapr_mce_req_event(PowerPCCPU *cpu)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +
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
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f891f8f..f34c79f 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -190,6 +190,15 @@ struct SpaprMachineState {
>       * occurs during the unplug process. */
>      QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
> =20
> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls=
 */
> +    target_ulong guest_machine_check_addr;
> +    /*
> +     * mc_status is set to -1 if mc is not in progress, else is set to t=
he CPU
> +     * handling the mc.
> +     */
> +    int mc_status;
> +    QemuCond mc_delivery_cond;
> +
>      /*< public >*/
>      char *kvm_type;
>      char *host_model;
> @@ -789,6 +798,7 @@ void spapr_clear_pending_events(SpaprMachineState *sp=
apr);
>  int spapr_max_server_number(SpaprMachineState *spapr);
>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>                        uint64_t pte0, uint64_t pte1);
> +void spapr_mce_req_event(PowerPCCPU *cpu);
> =20
>  /* DRC callbacks. */
>  void spapr_core_release(DeviceState *dev);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index afef4cd..99f33fe 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1763,6 +1763,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_=
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
> @@ -2863,6 +2868,15 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>      return data & 0xffff;
>  }
> =20
> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
> +{
> +    cpu_synchronize_state(CPU(cpu));
> +
> +    spapr_mce_req_event(cpu);
> +
> +    return 0;
> +}
> +
>  int kvmppc_enable_hwrng(void)
>  {
>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_PPC_HW=
RNG)) {
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 880cee9..3d9f0b4 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -83,6 +83,8 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void);
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

--svZFHVx8/dhPCe52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0a1QAACgkQbDjKyiDZ
s5Ko2hAAvGM+NO+AwQ1dQ4WxjQz4IWCGpGulk54daV/APnrqNuHAnija7wVlCH2N
xQInHerZuMfjg+Nr7SB5lHeQzPIiCu1qz8SUCutab1wh/LtW+aabQ/YpmGJNrcEW
n9pmdvVWj3jshVuOW75TXMP8BUZNqNGntsRO/MaGnSlg9NzXTUiynPQCkfAgOwZ6
RFVBvEZckZPMNd5c+f93ADeGPw6xAdcQlT83P5xmN4UboIvHfwnQSpNs4hZBucg3
AXUJLCO8b6VMwiAP2ynq3mZsi0CRiWX/+T2LouWevMvf2DKkxGNgau9cARxaejqJ
67rVax1CmUbpF/z7vBbCViXlngFYDg5FQpllK2nE0jdMuidZ+UP8Vy7hxSAxRMox
NDfOWhM4MnwX0En/u+CqFZAPUodCYQWEANUZN9fXtP1lFr3GiQJBhQCcAQGQ1R3Z
MafMYIHi1oEzibWNBhJAqCnbWaMNwDc3e+Xj9XWMG9RwgJoQQD2WQanT8BWqzdHq
UknK6Ag7iCzTRWEsMCJuD3P1X8x2hkomCE8OaSBL8S+OdoDslVlCDuAb3sxyMxzs
coC67pQEP8p3HvYIMdHjC1ywxyVh1U5EkHcza/24zIgXW2frozoo77vD9FudYr3D
BFdwvtwZT2V5eoK6RhlnBv4GcRsybJaqQHLXwsfrXkAkxVqR1Lk=
=9hEc
-----END PGP SIGNATURE-----

--svZFHVx8/dhPCe52--

