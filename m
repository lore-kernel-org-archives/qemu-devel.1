Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6418BCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 16:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D07D20869
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 16:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ca36G50w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D07D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRfQu-00024G-9h
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 11:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iRfPi-0000zS-LO
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 11:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iRfPg-00071N-FT
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 11:41:10 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:38705)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iRfPe-0006zB-GG; Mon, 04 Nov 2019 11:41:07 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 476JT80VYCz9sCJ; Tue,  5 Nov 2019 03:40:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572885660;
 bh=RlCYfuAoih8yfcVtkwcNtSpTQh33ZQqXkKFkL++pFVQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ca36G50w6iAPSgz0U3Vcf4VUSEbqofF9zOw7BIZm9RA0GhUJnYAN4JORzrRlU5yxA
 V0fi+s+cLeBTr1/injGRizIj0PQY0CLTo9dv+k+P0Y8gJOo5NW2R6fpuRRMj0mKpkm
 9xj7yw5JU1A79s8W+gqQlsOTO1EPnzqxzvYthOoE=
Date: Mon, 4 Nov 2019 17:10:54 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v17 4/7] target/ppc: Build rtas error log upon an MCE
Message-ID: <20191104161054.GH3552@umbus.metropole.lan>
References: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
 <20191024074307.22821-5-ganeshgr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="etg/Ry6vb8quy2uR"
Content-Disposition: inline
In-Reply-To: <20191024074307.22821-5-ganeshgr@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: arawinda.p@gmail.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--etg/Ry6vb8quy2uR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 01:13:04PM +0530, Ganesh Goudar wrote:
> From: Aravinda Prasad <arawinda.p@gmail.com>
>=20
> Upon a machine check exception (MCE) in a guest address space,
> KVM causes a guest exit to enable QEMU to build and pass the
> error to the guest in the PAPR defined rtas error log format.
>=20
> This patch builds the rtas error log, copies it to the rtas_addr
> and then invokes the guest registered machine check handler. The
> handler in the guest takes suitable action(s) depending on the type
> and criticality of the error. For example, if an error is
> unrecoverable memory corruption in an application inside the
> guest, then the guest kernel sends a SIGBUS to the application.
> For recoverable errors, the guest performs recovery actions and
> logs the error.
>=20
> [Assume SLOF has allocated enough room for rtas error log]

Is that correct with the SLOF image currently included in qemu?

Apart from that detail,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>



> ---
>  hw/ppc/spapr_events.c  | 220 ++++++++++++++++++++++++++++++++++++++++-
>  hw/ppc/spapr_rtas.c    |  26 +++++
>  include/hw/ppc/spapr.h |   6 +-
>  target/ppc/kvm.c       |   4 +-
>  4 files changed, 253 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 0ce96b86be..db44e09154 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -214,6 +214,104 @@ struct hp_extended_log {
>      struct rtas_event_log_v6_hp hp;
>  } QEMU_PACKED;
> =20
> +struct rtas_event_log_v6_mc {
> +#define RTAS_LOG_V6_SECTION_ID_MC                   0x4D43 /* MC */
> +    struct rtas_event_log_v6_section_header hdr;
> +    uint32_t fru_id;
> +    uint32_t proc_id;
> +    uint8_t error_type;
> +#define RTAS_LOG_V6_MC_TYPE_UE                           0
> +#define RTAS_LOG_V6_MC_TYPE_SLB                          1
> +#define RTAS_LOG_V6_MC_TYPE_ERAT                         2
> +#define RTAS_LOG_V6_MC_TYPE_TLB                          4
> +#define RTAS_LOG_V6_MC_TYPE_D_CACHE                      5
> +#define RTAS_LOG_V6_MC_TYPE_I_CACHE                      7
> +    uint8_t sub_err_type;
> +#define RTAS_LOG_V6_MC_UE_INDETERMINATE                  0
> +#define RTAS_LOG_V6_MC_UE_IFETCH                         1
> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH         2
> +#define RTAS_LOG_V6_MC_UE_LOAD_STORE                     3
> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE     4
> +#define RTAS_LOG_V6_MC_SLB_PARITY                        0
> +#define RTAS_LOG_V6_MC_SLB_MULTIHIT                      1
> +#define RTAS_LOG_V6_MC_SLB_INDETERMINATE                 2
> +#define RTAS_LOG_V6_MC_ERAT_PARITY                       1
> +#define RTAS_LOG_V6_MC_ERAT_MULTIHIT                     2
> +#define RTAS_LOG_V6_MC_ERAT_INDETERMINATE                3
> +#define RTAS_LOG_V6_MC_TLB_PARITY                        1
> +#define RTAS_LOG_V6_MC_TLB_MULTIHIT                      2
> +#define RTAS_LOG_V6_MC_TLB_INDETERMINATE                 3
> +    uint8_t reserved_1[6];
> +    uint64_t effective_address;
> +    uint64_t logical_address;
> +} QEMU_PACKED;
> +
> +struct mc_extended_log {
> +    struct rtas_event_log_v6 v6hdr;
> +    struct rtas_event_log_v6_mc mc;
> +} QEMU_PACKED;
> +
> +struct MC_ierror_table {
> +    unsigned long srr1_mask;
> +    unsigned long srr1_value;
> +    bool nip_valid; /* nip is a valid indicator of faulting address */
> +    uint8_t error_type;
> +    uint8_t error_subtype;
> +    unsigned int initiator;
> +    unsigned int severity;
> +};
> +
> +static const struct MC_ierror_table mc_ierror_table[] =3D {
> +{ 0x00000000081c0000, 0x0000000000040000, true,
> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_IFETCH,
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> +{ 0x00000000081c0000, 0x0000000000080000, true,
> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> +{ 0x00000000081c0000, 0x00000000000c0000, true,
> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> +{ 0x00000000081c0000, 0x0000000000100000, true,
> +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> +{ 0x00000000081c0000, 0x0000000000140000, true,
> +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> +{ 0x00000000081c0000, 0x0000000000180000, true,
> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH,
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, } };
> +
> +struct MC_derror_table {
> +    unsigned long dsisr_value;
> +    bool dar_valid; /* dar is a valid indicator of faulting address */
> +    uint8_t error_type;
> +    uint8_t error_subtype;
> +    unsigned int initiator;
> +    unsigned int severity;
> +};
> +
> +static const struct MC_derror_table mc_derror_table[] =3D {
> +{ 0x00008000, false,
> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_LOAD_STORE,
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> +{ 0x00004000, true,
> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE,
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> +{ 0x00000800, true,
> +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> +{ 0x00000400, true,
> +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> +{ 0x00000080, true,
> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,  /* Before PARIT=
Y */
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> +{ 0x00000100, true,
> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, } };
> +
> +#define SRR1_MC_LOADSTORE(srr1) ((srr1) & PPC_BIT(42))
> +
>  typedef enum EventClass {
>      EVENT_CLASS_INTERNAL_ERRORS     =3D 0,
>      EVENT_CLASS_EPOW                =3D 1,
> @@ -622,7 +720,125 @@ void spapr_hotplug_req_remove_by_count_indexed(Spap=
rDrcType drc_type,
>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc=
_id);
>  }
> =20
> -void spapr_mce_req_event(PowerPCCPU *cpu)
> +static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
> +                                        struct mc_extended_log *ext_elog)
> +{
> +    int i;
> +    CPUPPCState *env =3D &cpu->env;
> +    uint32_t summary;
> +    uint64_t dsisr =3D env->spr[SPR_DSISR];
> +
> +    summary =3D RTAS_LOG_VERSION_6 | RTAS_LOG_OPTIONAL_PART_PRESENT;
> +    if (recovered) {
> +        summary |=3D RTAS_LOG_DISPOSITION_FULLY_RECOVERED;
> +    } else {
> +        summary |=3D RTAS_LOG_DISPOSITION_NOT_RECOVERED;
> +    }
> +
> +    if (SRR1_MC_LOADSTORE(env->spr[SPR_SRR1])) {
> +        for (i =3D 0; i < ARRAY_SIZE(mc_derror_table); i++) {
> +            if (!(dsisr & mc_derror_table[i].dsisr_value)) {
> +                continue;
> +            }
> +
> +            ext_elog->mc.error_type =3D mc_derror_table[i].error_type;
> +            ext_elog->mc.sub_err_type =3D mc_derror_table[i].error_subty=
pe;
> +            if (mc_derror_table[i].dar_valid) {
> +                ext_elog->mc.effective_address =3D cpu_to_be64(env->spr[=
SPR_DAR]);
> +            }
> +
> +            summary |=3D mc_derror_table[i].initiator
> +                        | mc_derror_table[i].severity;
> +
> +            return summary;
> +        }
> +    } else {
> +        for (i =3D 0; i < ARRAY_SIZE(mc_ierror_table); i++) {
> +            if ((env->spr[SPR_SRR1] & mc_ierror_table[i].srr1_mask) !=3D
> +                    mc_ierror_table[i].srr1_value) {
> +                continue;
> +            }
> +
> +            ext_elog->mc.error_type =3D mc_ierror_table[i].error_type;
> +            ext_elog->mc.sub_err_type =3D mc_ierror_table[i].error_subty=
pe;
> +            if (mc_ierror_table[i].nip_valid) {
> +                ext_elog->mc.effective_address =3D cpu_to_be64(env->nip);
> +            }
> +
> +            summary |=3D mc_ierror_table[i].initiator
> +                        | mc_ierror_table[i].severity;
> +
> +            return summary;
> +        }
> +    }
> +
> +    summary |=3D RTAS_LOG_INITIATOR_CPU;
> +    return summary;
> +}
> +
> +static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    CPUState *cs =3D CPU(cpu);
> +    uint64_t rtas_addr;
> +    CPUPPCState *env =3D &cpu->env;
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +    target_ulong msr =3D 0;
> +    struct rtas_error_log log;
> +    struct mc_extended_log *ext_elog;
> +    uint32_t summary;
> +
> +    /*
> +     * Properly set bits in MSR before we invoke the handler.
> +     * SRR0/1, DAR and DSISR are properly set by KVM
> +     */
> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
> +        msr |=3D (1ULL << MSR_LE);
> +    }
> +
> +    if (env->msr & (1ULL << MSR_SF)) {
> +        msr |=3D (1ULL << MSR_SF);
> +    }
> +
> +    msr |=3D (1ULL << MSR_ME);
> +
> +    ext_elog =3D g_malloc0(sizeof(*ext_elog));
> +    summary =3D spapr_mce_get_elog_type(cpu, recovered, ext_elog);
> +
> +    log.summary =3D cpu_to_be32(summary);
> +    log.extended_length =3D cpu_to_be32(sizeof(*ext_elog));
> +
> +    spapr_init_v6hdr(&ext_elog->v6hdr);
> +    ext_elog->mc.hdr.section_id =3D cpu_to_be16(RTAS_LOG_V6_SECTION_ID_M=
C);
> +    ext_elog->mc.hdr.section_length =3D
> +                    cpu_to_be16(sizeof(struct rtas_event_log_v6_mc));
> +    ext_elog->mc.hdr.section_version =3D 1;
> +
> +    /* get rtas addr from fdt */
> +    rtas_addr =3D spapr_get_rtas_addr();
> +    if (!rtas_addr) {
> +        /* Unable to fetch rtas_addr. Hence reset the guest */
> +        ppc_cpu_do_system_reset(cs);
> +        g_free(ext_elog);
> +        return;
> +    }
> +
> +    stq_be_phys(&address_space_memory, rtas_addr + RTAS_ERROR_LOG_OFFSET,
> +                env->gpr[3]);
> +    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
> +                              sizeof(env->gpr[3]), &log, sizeof(log));
> +    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
> +                              sizeof(env->gpr[3]) + sizeof(log), ext_elo=
g,
> +                              sizeof(*ext_elog));
> +
> +    env->gpr[3] =3D rtas_addr + RTAS_ERROR_LOG_OFFSET;
> +    env->msr =3D msr;
> +    env->nip =3D spapr->guest_machine_check_addr;
> +
> +    g_free(ext_elog);
> +}
> +
> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      CPUState *cs =3D CPU(cpu);
> @@ -656,6 +872,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu)
>          }
>      }
>      spapr->mc_status =3D cpu->vcpu_id;
> +
> +    spapr_mce_dispatch_elog(cpu, recovered);
>  }
> =20
>  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 8d8d8cdfcb..2c066a372d 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -477,6 +477,32 @@ void spapr_dt_rtas_tokens(void *fdt, int rtas)
>      }
>  }
> =20
> +hwaddr spapr_get_rtas_addr(void)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    int rtas_node;
> +    const fdt32_t *rtas_data;
> +    void *fdt =3D spapr->fdt_blob;
> +
> +    /* fetch rtas addr from fdt */
> +    rtas_node =3D fdt_path_offset(fdt, "/rtas");
> +    if (rtas_node < 0) {
> +        return 0;
> +    }
> +
> +    rtas_data =3D fdt_getprop(fdt, rtas_node, "linux,rtas-base", NULL);
> +    if (!rtas_data) {
> +        return 0;
> +    }
> +
> +    /*
> +     * We assume that the OS called RTAS instantiate-rtas, but some other
> +     * OS might call RTAS instantiate-rtas-64 instead. This fine as of n=
ow
> +     * as SLOF only supports 32-bit variant.
> +     */
> +    return (hwaddr)fdt32_to_cpu(*rtas_data);
> +}
> +
>  static void core_rtas_register_types(void)
>  {
>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 1f5eb8c856..4afa8d4d09 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -724,6 +724,9 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *=
fdt, hwaddr addr);
> =20
>  #define RTAS_ERROR_LOG_MAX      2048
> =20
> +/* Offset from rtas-base where error log is placed */
> +#define RTAS_ERROR_LOG_OFFSET       0x30
> +
>  #define RTAS_EVENT_SCAN_RATE    1
> =20
>  /* This helper should be used to encode interrupt specifiers when the re=
lated
> @@ -812,7 +815,7 @@ void spapr_clear_pending_events(SpaprMachineState *sp=
apr);
>  int spapr_max_server_number(SpaprMachineState *spapr);
>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>                        uint64_t pte0, uint64_t pte1);
> -void spapr_mce_req_event(PowerPCCPU *cpu);
> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
> =20
>  /* DRC callbacks. */
>  void spapr_core_release(DeviceState *dev);
> @@ -903,4 +906,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, h=
waddr pagesize,
>  #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platfor=
m */
> =20
>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
> +hwaddr spapr_get_rtas_addr(void);
>  #endif /* HW_SPAPR_H */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 2d8db6d832..9a902c1064 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2805,9 +2805,11 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
> =20
>  int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
>  {
> +    bool recovered =3D run->flags & KVM_RUN_PPC_NMI_DISP_FULLY_RECOV;
> +
>      cpu_synchronize_state(CPU(cpu));
> =20
> -    spapr_mce_req_event(cpu);
> +    spapr_mce_req_event(cpu, recovered);
> =20
>      return 0;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--etg/Ry6vb8quy2uR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3ATY4ACgkQbDjKyiDZ
s5K0RQ/9GNZORXXbGdPemyydAF4AlC+69xx64gFrV/HS+MNoM0nIQm0ky40NbrUf
9IRwALFgzJrxxIa24sIk8SvID+Ggmsx08zQF1HHyagCE0/redsoPcVJoHn2V5fMh
5RUiilV4onMhj2uiRAr9BoebcNM0v5o7CwKWxUL+zW4VvQRfYdoqKO+DXIF6Q12s
xO0pNo7DHbrfwVH4dZsTrokzkKPdrT/3Nxoe+EoW8FP3Tpi5rNyI+V/iN9TcMqDe
NPf4GOoodaku66jVkqWrK+SzfBs6TQEmnahszWfoHzCSHs/lrWteRzCqxRELpGpg
WQq/CuhKv1gHFe+w8Ol46dCwPyyayT5vsRodp6huv2C0xFzuWrGp9MIVw1FWRbjc
jrUFQ5bRMkLRYUKEXKwkWkccwOr8NJp7qT5Led1gPMQOSuPeY9+zgIc7rE26O0EC
wJiKzvSzaM3R1GxSyLx7OEI5DbwjqTP7RHJG2rmNOLg6rTDdKO4bjjMXSefSSLXT
X5pim28LqiujbCnNj+9RIw8ZrmrnP+c63nKShHVb8H3HJHf+yvSQkj/pCMCaqUkI
81FZZqm1wlsqH5NR1MK7LTfXRppHm92vulrqQMPFmzZWLC+YdowXxtfwvIh/RrKR
ekh+tT7G7zwHNYX09QWhSUWGAGMUlcMbLTgbxSUE348ogN8ivfI=
=Je28
-----END PGP SIGNATURE-----

--etg/Ry6vb8quy2uR--

