Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493D0C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 17:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E20523407
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 17:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E20523407
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3kS5-0007GJ-2Y
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 13:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i3kO3-000620-K9
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 13:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i3kNz-0003qm-PU
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 13:08:33 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:40153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i3kNz-0003iM-HX
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 13:08:31 -0400
Received: from player738.ha.ovh.net (unknown [10.109.159.68])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id D168913C8F8
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 19:08:28 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 37F1B9676E4B;
 Fri, 30 Aug 2019 17:08:20 +0000 (UTC)
Date: Fri, 30 Aug 2019 19:08:18 +0200
From: Greg Kurz <groug@kaod.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190830190818.1f46f7b4@bahia.lan>
In-Reply-To: <156715644777.27761.16844420952499810544.stgit@aravinda>
References: <156715632966.27761.8190459106519248668.stgit@aravinda>
 <156715644777.27761.16844420952499810544.stgit@aravinda>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 6344445976088779156
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeigedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.79.203
Subject: Re: [Qemu-devel] [PATCH v12 5/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Aug 2019 14:44:07 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> This patch adds support in QEMU to handle "ibm,nmi-register"
> and "ibm,nmi-interlock" RTAS calls and sets the default
> value of SPAPR_CAP_FWNMI_MCE to SPAPR_CAP_ON for machine
> type 4.2.
>=20
> The machine check notification address is saved when the
> OS issues "ibm,nmi-register" RTAS call.
>=20
> This patch also handles the case when multiple processors
> experience machine check at or about the same time by
> handling "ibm,nmi-interlock" call. In such cases, as per
> PAPR, subsequent processors serialize waiting for the first
> processor to issue the "ibm,nmi-interlock" call. The second
> processor that also received a machine check error waits
> till the first processor is done reading the error log.
> The first processor issues "ibm,nmi-interlock" call
> when the error log is consumed.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         |   12 +++++++++++-
>  hw/ppc/spapr_rtas.c    |   50 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |    5 ++++-
>  3 files changed, 65 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9f2e5d2..1c0908e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2941,6 +2941,15 @@ static void spapr_machine_init(MachineState *machi=
ne)
> =20
>          /* Resize rtas blob to accommodate error log */
>          spapr->rtas_size =3D RTAS_ERROR_LOG_MAX;
> +
> +        /* Set fwnmi capability in KVM */
> +        if (kvmppc_set_fwnmi() < 0) {
> +            error_report("Could not enable FWNMI capability");
> +            exit(1);
> +        }

Hmm... shouldn't this be performed only when the guest
calls "ibm,nmi-register" ?

> +
> +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
> +        spapr_fwnmi_register();
>      }
> =20
>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
> @@ -4508,7 +4517,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_ON;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
> @@ -4582,6 +4591,7 @@ static void spapr_machine_4_1_class_options(Machine=
Class *mc)
>      smc->linux_pci_probe =3D false;
>      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(4_1, "4.1", false);
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index d8fb8a8..d892583 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -400,6 +400,48 @@ static void rtas_get_power_level(PowerPCCPU *cpu, Sp=
aprMachineState *spapr,
>      rtas_st(rets, 1, 100);
>  }
> =20
> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> +                                  SpaprMachineState *spapr,
> +                                  uint32_t token, uint32_t nargs,
> +                                  target_ulong args,
> +                                  uint32_t nret, target_ulong rets)
> +{
> +    hwaddr rtas_addr =3D spapr_get_rtas_addr();
> +
> +    if (!rtas_addr) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_OFF) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    spapr->guest_machine_check_addr =3D rtas_ld(args, 1);

Doesn't this need some sanity checks ? At least error out on -1
which has a special meaning in the code and cannot really be used
as a valid instruction address.

Also PAPR+ says:

R1=E2=80=937.3.14=E2=80=936. For the FWNMI option: The Real/Logical address=
 of the
registered OS Machine Check and System Reset routines must be in the
 first 32 MB of the OS=E2=80=99s memory address space.


And only at this point you may enable the cap in KVM since the
guest has decided to use FWNMI.

My concern is: what happens when the guest reboots ? We set
guest_machine_check_addr back to -1 during machine reset but
KVM still assumes the guest has enabled FWNMI... I see that
enabling FWNMI boils down to setting a kvm->arch.fwnmi_enabled
to true... what about providing a way to disable FWNMI ?

> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +}
> +
> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> +                                   SpaprMachineState *spapr,
> +                                   uint32_t token, uint32_t nargs,
> +                                   target_ulong args,
> +                                   uint32_t nret, target_ulong rets)
> +{
> +    if (spapr->guest_machine_check_addr =3D=3D -1) {
> +        /* NMI register not called */
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +    } else {
> +        /*
> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> +         * hence unset mc_status.
> +         */
> +        spapr->mc_status =3D -1;
> +        qemu_cond_signal(&spapr->mc_delivery_cond);
> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +    }
> +}
> +
>  static struct rtas_call {
>      const char *name;
>      spapr_rtas_fn fn;
> @@ -544,6 +586,14 @@ hwaddr spapr_get_rtas_addr(void)
>      return (hwaddr)fdt32_to_cpu(*rtas_data);
>  }
> =20
> +void spapr_fwnmi_register(void)
> +{
> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
> +                        rtas_ibm_nmi_register);
> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
> +                        rtas_ibm_nmi_interlock);
> +}
> +
>  static void core_rtas_register_types(void)
>  {
>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index ffefde7..dada821 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -655,8 +655,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target=
_ulong opcode,
>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
>  #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
> =20
> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2B)
> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
> =20
>  /* RTAS ibm,get-system-parameter token values */
>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
> @@ -908,4 +910,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, h=
waddr pagesize,
> =20
>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>  hwaddr spapr_get_rtas_addr(void);
> +void spapr_fwnmi_register(void);
>  #endif /* HW_SPAPR_H */
>=20


