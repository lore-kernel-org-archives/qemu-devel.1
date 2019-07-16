Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22DBC76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7AA2145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OFfpC9T9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7AA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIab-00082a-93
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnIZz-0005um-P1
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnIZy-0004B9-4E
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:12:55 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33811 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnIZw-00047B-Iq; Tue, 16 Jul 2019 04:12:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45ntRz2ty2z9sNj; Tue, 16 Jul 2019 18:12:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563264767;
 bh=WAcesPNcLg3s1VAJIBXZ3kzFruqoHz/iHgoad/rtsZU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OFfpC9T9UDlQ/kE/EoC5SVLCzMpTjIVDdgr29iAgGeZItymRP40VQaL6KJ1k8dybt
 B6MidwSSgN1n9Bh+czyLQWvFjMC8Rxv4h6k3/RC3d+xG4KLbfTv5qSLhIHBbPd/aV/
 mmVBB1qmz+AjXhZiyUQstlHCz6B13c3XKiOnEGDg=
Date: Tue, 16 Jul 2019 17:34:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190716073433.GC7525@umbus.fritz.box>
References: <20190716024726.17864-1-npiggin@gmail.com>
 <20190716024726.17864-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20190716024726.17864-2-npiggin@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v4 1/5] spapr: Implement dispatch counter
 and prod bit on tcg
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


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 12:47:22PM +1000, Nicholas Piggin wrote:
> Implement cpu_exec_enter/exit on ppc which calls into new methods of
> the same name in PPCVirtualHypervisorClass. These are used by spapr
> to implement these splpar elements, used in subsequent changes.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr.c                  | 25 +++++++++++++++++++++++++
>  hw/ppc/spapr_cpu_core.c         |  5 ++++-
>  hw/ppc/spapr_hcall.c            |  5 -----
>  include/hw/ppc/spapr.h          |  7 +++++++
>  include/hw/ppc/spapr_cpu_core.h |  2 ++
>  target/ppc/cpu.h                |  2 ++
>  target/ppc/translate_init.inc.c | 25 +++++++++++++++++++++++++
>  7 files changed, 65 insertions(+), 6 deletions(-)

Mostly LGTM.  Please do address the style issues that the bot
reported.

In addition, do the dispatch_counter and prod values need to be
migrated?

>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 821f0d4a49..87b11e2484 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4302,6 +4302,29 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
>      return NULL;
>  }
> =20
> +static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU =
*cpu)
> +{
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +
> +    /* These are only called by TCG, KVM maintains dispatch state */
> +
> +    spapr_cpu->prod =3D false;
> +    spapr_cpu->dispatch_counter++;
> +    assert((spapr_cpu->dispatch_counter & 1) =3D=3D 0);
> +    if (spapr_cpu->vpa_addr) {
> +        CPUState *cs =3D CPU(cpu);
> +        stl_be_phys(cs->as, spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, =
spapr_cpu->dispatch_counter);
> +    }
> +}
> +
> +static void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU *=
cpu)
> +{
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +
> +    spapr_cpu->dispatch_counter++;
> +    assert((spapr_cpu->dispatch_counter & 1) =3D=3D 1);
> +}
> +
>  static void spapr_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -4358,6 +4381,8 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      vhc->hpte_set_r =3D spapr_hpte_set_r;
>      vhc->get_pate =3D spapr_get_pate;
>      vhc->encode_hpt_for_kvm_pr =3D spapr_encode_hpt_for_kvm_pr;
> +    vhc->cpu_exec_enter =3D spapr_cpu_exec_enter;
> +    vhc->cpu_exec_exit =3D spapr_cpu_exec_exit;
>      xic->ics_get =3D spapr_ics_get;
>      xic->ics_resend =3D spapr_ics_resend;
>      xic->icp_get =3D spapr_icp_get;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 5621fb9a3d..fb2ed9e95d 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -261,6 +261,7 @@ error:
>  static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **er=
rp)
>  {
>      SpaprCpuCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(sc);
> +    SpaprCpuState *spapr_cpu;
>      CPUCore *cc =3D CPU_CORE(sc);
>      Object *obj;
>      char *id;
> @@ -287,7 +288,9 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc=
, int i, Error **errp)
>          goto err;
>      }
> =20
> -    cpu->machine_data =3D g_new0(SpaprCpuState, 1);
> +    spapr_cpu =3D g_new0(SpaprCpuState, 1);
> +    spapr_cpu->dispatch_counter =3D 1;
> +    cpu->machine_data =3D spapr_cpu;
> =20
>      object_unref(obj);
>      return cpu;
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 6808d4cda8..e615881ac4 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -874,11 +874,6 @@ unmap_out:
>  #define FLAGS_DEREGISTER_DTL       0x0000c00000000000ULL
>  #define FLAGS_DEREGISTER_SLBSHADOW 0x0000e00000000000ULL
> =20
> -#define VPA_MIN_SIZE           640
> -#define VPA_SIZE_OFFSET        0x4
> -#define VPA_SHARED_PROC_OFFSET 0x9
> -#define VPA_SHARED_PROC_VAL    0x2
> -
>  static target_ulong register_vpa(PowerPCCPU *cpu, target_ulong vpa)
>  {
>      CPUState *cs =3D CPU(cpu);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 60553d32c4..5d36eec9d0 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -525,6 +525,13 @@ void spapr_register_hypercall(target_ulong opcode, s=
papr_hcall_fn fn);
>  target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>                               target_ulong *args);
> =20
> +/* Virtual Processor Area structure constants */
> +#define VPA_MIN_SIZE           640
> +#define VPA_SIZE_OFFSET        0x4
> +#define VPA_SHARED_PROC_OFFSET 0x9
> +#define VPA_SHARED_PROC_VAL    0x2
> +#define VPA_DISPATCH_COUNTER   0x100
> +
>  /* ibm,set-eeh-option */
>  #define RTAS_EEH_DISABLE                 0
>  #define RTAS_EEH_ENABLE                  1
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index f9645a7290..3032dfa7ee 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -46,6 +46,8 @@ typedef struct SpaprCpuState {
>      uint64_t vpa_addr;
>      uint64_t slb_shadow_addr, slb_shadow_size;
>      uint64_t dtl_addr, dtl_size;
> +    uint32_t dispatch_counter;
> +    bool prod;
>      struct ICPState *icp;
>      struct XiveTCTX *tctx;
>  } SpaprCpuState;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c9beba2a5c..78d6504acb 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1224,6 +1224,8 @@ struct PPCVirtualHypervisorClass {
>      void (*hpte_set_r)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64_t=
 pte1);
>      void (*get_pate)(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *entry);
>      target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
> +    void (*cpu_exec_enter)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
> +    void (*cpu_exec_exit)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
>  };
> =20
>  #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 86fc8f2e31..58d4a93b23 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10473,6 +10473,28 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
>  }
>  #endif
> =20
> +static void ppc_cpu_exec_enter(CPUState *cs)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +    if (cpu->vhyp) {
> +        PPCVirtualHypervisorClass *vhc =3D
> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +        vhc->cpu_exec_enter(cpu->vhyp, cpu);
> +    }
> +}
> +
> +static void ppc_cpu_exec_exit(CPUState *cs)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +    if (cpu->vhyp) {
> +        PPCVirtualHypervisorClass *vhc =3D
> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +        vhc->cpu_exec_exit(cpu->vhyp, cpu);
> +    }
> +}
> +
>  static void ppc_cpu_instance_init(Object *obj)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(obj);
> @@ -10624,6 +10646,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, v=
oid *data)
>      cc->tcg_initialize =3D ppc_translate_init;
>      cc->tlb_fill =3D ppc_cpu_tlb_fill;
>  #endif
> +    cc->cpu_exec_enter =3D ppc_cpu_exec_enter;
> +    cc->cpu_exec_exit =3D ppc_cpu_exec_exit;
> +
>      cc->disas_set_info =3D ppc_disas_set_info;
> =20
>      dc->fw_name =3D "PowerPC,UNKNOWN";

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0tfgYACgkQbDjKyiDZ
s5LgkBAAw6lG7RkDDJZKZQ+iLpTWv7QnsbzCi3DduqY0ihvqXDkLsM84b5mbd9vO
DArVXu1PM7iK6oDKqmIDVfmh6nwEOaKkR6Ws30pVJUzWARzN6cS/USbSMY04kQk3
AZWTJdZJMyDSKyKoBEjBLRVVO+HtcBPZWW919r7WCZlhN9gvpmd93qhakPDKsxnP
dUGPNZqA11TvmUpRGST4AM3lKY4pxKye6OH2L9wAn88/+ghG4mmDqWbn+1iryr6j
nbtVPjcIazX0eAMF4nIggjCQzgJ7P3vbWzup8elazhcLnmdNFx89WLE5DYio7aYb
6uU7JEjGVan4c5iwSl8AKsOB3p585YYJjGUx1A0PhvEDWjYXKEPAIrBngC1ZvI/7
asegKK0m8HAgQRsq9/WMU4Ou5QcBULsbOBDFNn8PjfUqEcCqUlW5AvRz/78D37cU
EM3ea3HeEgDPEg6OVwVT178sqLSwmBmcQnAPxMdEy4GwzzMbzr4otSMqmvRIq/Ur
R1ag/kFpOsl/2vfhTMGsiylP5gFiH7g1M5DKlpHLooyYH1xObSCd3EJig5fdadi4
Ilh83plrAO8Ovhj4tDHYE21Y43I0/hDV4nKHWqygXmv7xuNiQEdf4PcTV4//kIEn
glidSFbdE047xhrKk+0AnasemeRF5OzgETYR04FTtkrrrdPnyGE=
=xw8e
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--

