Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5088DC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25827205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25827205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnjOb-0007Xa-BQ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 08:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hnjOP-0006zt-9u
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hnjOL-0002pV-Mw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:50:44 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:39129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hnjOL-0002ny-CB
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:50:41 -0400
Received: from player159.ha.ovh.net (unknown [10.108.35.215])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2D0AA1FDA57
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 14:50:37 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 504DB7EFCD93;
 Wed, 17 Jul 2019 12:50:31 +0000 (UTC)
To: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20190717053952.13729-1-npiggin@gmail.com>
 <20190717053952.13729-2-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f5beaba9-03cf-cfc3-df42-4d9c6d213c07@kaod.org>
Date: Wed, 17 Jul 2019 14:50:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717053952.13729-2-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1845631426053901209
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieefgdefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.112
Subject: Re: [Qemu-devel] [PATCH v5 1/4] spapr: Implement VPA dispatch
 counter and prod bit on tcg
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/2019 07:39, Nicholas Piggin wrote:
> Implement cpu_exec_enter/exit on ppc which calls into new methods of
> the same name in PPCVirtualHypervisorClass. These are used by spapr
> to implement these splpar elements, used in subsequent changes.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

This is nice. I am thinking of using these handlers to push/pull=20
the XIVE OS CAM line and escalate to QEMU when a vCPU being notified=20
is not dispatched.

Some minor comments below.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


Thanks,

C.

> ---
> Changes since v4:
> - Store to VPA on the way out as well.
> - Increment the dispatch counter directly in the VPA, which means it wi=
ll
>   migrate with guest memory the same as KVM.
> - Prod need not be migrated, add a comment.
>=20
>  hw/ppc/spapr.c                  | 41 +++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_cpu_core.c         |  4 +++-
>  hw/ppc/spapr_hcall.c            |  5 ----
>  include/hw/ppc/spapr.h          |  7 ++++++
>  include/hw/ppc/spapr_cpu_core.h |  1 +
>  target/ppc/cpu.h                |  2 ++
>  target/ppc/translate_init.inc.c | 25 ++++++++++++++++++++
>  7 files changed, 79 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 821f0d4a49..13c423347e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4302,6 +4302,45 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
>      return NULL;
>  }
> =20
> +static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCP=
U *cpu)
> +{
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +
> +    /* These are only called by TCG, KVM maintains dispatch state */
> +
> +    spapr_cpu->prod =3D false;

I would have kept this prod bool for the next patch as we don't use it he=
re.

> +    if (spapr_cpu->vpa_addr) {
> +        CPUState *cs =3D CPU(cpu);
> +        unsigned int dispatch;
> +
> +        dispatch =3D ldl_be_phys(cs->as,
> +                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUN=
TER);
> +        dispatch++;
> +        if ((dispatch & 1) !=3D 0) /* guest set the "wrong" value */
> +            dispatch++;


You might want to add :

  qemu_log_mask(LOG_GUEST_ERROR, ...); =20

when the yield value is wrong.

> +        stl_be_phys(cs->as,
> +                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispat=
ch);
> +    }
> +}
> +
> +static void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU=
 *cpu)
> +{
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +
> +    if (spapr_cpu->vpa_addr) {
> +        CPUState *cs =3D CPU(cpu);
> +        unsigned int dispatch;
> +
> +        dispatch =3D ldl_be_phys(cs->as,
> +                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUN=
TER);
> +        dispatch++;
> +        if ((dispatch & 1) !=3D 1) /* guest set the "wrong" value */
> +            dispatch++;
> +        stl_be_phys(cs->as,
> +                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispat=
ch);
> +    }
> +}
> +
>  static void spapr_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -4358,6 +4397,8 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
>      vhc->hpte_set_r =3D spapr_hpte_set_r;
>      vhc->get_pate =3D spapr_get_pate;
>      vhc->encode_hpt_for_kvm_pr =3D spapr_encode_hpt_for_kvm_pr;
> +    vhc->cpu_exec_enter =3D spapr_cpu_exec_enter;
> +    vhc->cpu_exec_exit =3D spapr_cpu_exec_exit;
>      xic->ics_get =3D spapr_ics_get;
>      xic->ics_resend =3D spapr_ics_resend;
>      xic->icp_get =3D spapr_icp_get;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 5621fb9a3d..54abf5308c 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -261,6 +261,7 @@ error:
>  static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **=
errp)
>  {
>      SpaprCpuCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(sc);
> +    SpaprCpuState *spapr_cpu;
>      CPUCore *cc =3D CPU_CORE(sc);
>      Object *obj;
>      char *id;
> @@ -287,7 +288,8 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *=
sc, int i, Error **errp)
>          goto err;
>      }
> =20
> -    cpu->machine_data =3D g_new0(SpaprCpuState, 1);
> +    spapr_cpu =3D g_new0(SpaprCpuState, 1);
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
> @@ -525,6 +525,13 @@ void spapr_register_hypercall(target_ulong opcode,=
 spapr_hcall_fn fn);
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
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu=
_core.h
> index f9645a7290..a40cd08ea0 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -46,6 +46,7 @@ typedef struct SpaprCpuState {
>      uint64_t vpa_addr;
>      uint64_t slb_shadow_addr, slb_shadow_size;
>      uint64_t dtl_addr, dtl_size;
> +    bool prod; /* not migrated, only used to improve dispatch latencie=
s */
>      struct ICPState *icp;
>      struct XiveTCTX *tctx;
>  } SpaprCpuState;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c9beba2a5c..78d6504acb 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1224,6 +1224,8 @@ struct PPCVirtualHypervisorClass {
>      void (*hpte_set_r)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64=
_t pte1);
>      void (*get_pate)(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *entry)=
;
>      target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
> +    void (*cpu_exec_enter)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu=
);
> +    void (*cpu_exec_exit)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)=
;
>  };
> =20
>  #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_ini=
t.inc.c
> index 86fc8f2e31..58d4a93b23 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10473,6 +10473,28 @@ static bool ppc_cpu_is_big_endian(CPUState *cs=
)
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
> @@ -10624,6 +10646,9 @@ static void ppc_cpu_class_init(ObjectClass *oc,=
 void *data)
>      cc->tcg_initialize =3D ppc_translate_init;
>      cc->tlb_fill =3D ppc_cpu_tlb_fill;
>  #endif
> +    cc->cpu_exec_enter =3D ppc_cpu_exec_enter;
> +    cc->cpu_exec_exit =3D ppc_cpu_exec_exit;
> +
>      cc->disas_set_info =3D ppc_disas_set_info;
> =20
>      dc->fw_name =3D "PowerPC,UNKNOWN";
>=20


