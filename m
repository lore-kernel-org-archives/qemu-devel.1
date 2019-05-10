Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138D9C04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30FD2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fra+etp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30FD2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzPd-0005QQ-2m
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 02:53:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOzNx-0004GJ-Er
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOzNv-0005aQ-Gv
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:52:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45271 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOzNu-0005Za-5U; Fri, 10 May 2019 02:51:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450gqY54zhz9sCJ; Fri, 10 May 2019 16:51:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557471113;
	bh=0GC2vqeQkrMr2Z/PD6KxqX31WOpLnwav2MmSODPeN/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fra+etp4G/3TcEkeUaYA7kSZZNk6IN2I7RtiKQygO8kXYllyyemzuMSkVtXI/LvxP
	JCKatEtnNtJFkKmlYjtCbsrPewQOJPmtbloFPUWZg6UXjCHChMVSFcyM/xJZFiRIzA
	owMHy2CjP3nllZew+nDHsLTEEX9tN5jf9Lc3+2d0=
Date: Fri, 10 May 2019 16:42:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190510064213.GK20559@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591660602.20338.9804738040071843715.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aqWxf8ydqYKP8htK"
Content-Disposition: inline
In-Reply-To: <155591660602.20338.9804738040071843715.stgit@aravinda>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v8 4/6] target/ppc: Build rtas error log
 upon an MCE
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, aik@au1.ibm.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--aqWxf8ydqYKP8htK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 12:33:26PM +0530, Aravinda Prasad wrote:
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
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         |    4 +
>  hw/ppc/spapr_events.c  |  245 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |    4 +
>  3 files changed, 253 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2779efe..ffd1715 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2918,6 +2918,10 @@ static void spapr_machine_init(MachineState *machi=
ne)
>          error_report("Could not get size of LPAR rtas '%s'", filename);
>          exit(1);
>      }
> +
> +    /* Resize blob to accommodate error log. */
> +    spapr->rtas_size =3D spapr_get_rtas_size(spapr->rtas_size);
> +
>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
>      if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size) < =
0) {
>          error_report("Could not load LPAR rtas '%s'", filename);
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 9922a23..4032db0 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -212,6 +212,106 @@ struct hp_extended_log {
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
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> +{ 0, 0, 0, 0, 0, 0 } };
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
> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> +{ 0, false, 0, 0, 0, 0 } };
> +
> +#define SRR1_MC_LOADSTORE(srr1) ((srr1) & PPC_BIT(42))
> +
>  typedef enum EventClass {
>      EVENT_CLASS_INTERNAL_ERRORS     =3D 0,
>      EVENT_CLASS_EPOW                =3D 1,
> @@ -620,6 +720,147 @@ void spapr_hotplug_req_remove_by_count_indexed(Spap=
rDrcType drc_type,
>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc=
_id);
>  }
> =20
> +ssize_t spapr_get_rtas_size(ssize_t old_rtas_size)
> +{
> +    g_assert(old_rtas_size < RTAS_ERRLOG_OFFSET);
> +    return RTAS_ERROR_LOG_MAX;
> +}
> +
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
> +        for (i =3D 0; mc_derror_table[i].dsisr_value; i++) {
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
> +        for (i =3D 0; mc_ierror_table[i].srr1_mask; i++) {
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
> +    target_ulong r3, msr =3D 0;
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
> +    if (env->msr && (1ULL << MSR_SF)) {
> +        msr |=3D (1ULL << MSR_SF);
> +    }
> +
> +    msr |=3D (1ULL << MSR_ME);
> +
> +    if (spapr->guest_machine_check_addr =3D=3D -1) {
> +        /*
> +         * This implies that we have hit a machine check between system
> +         * reset and "ibm,nmi-register". Fall back to the old machine
> +         * check behavior in such cases.
> +         */
> +        env->spr[SPR_SRR0] =3D env->nip;
> +        env->spr[SPR_SRR1] =3D env->msr;
> +        env->msr =3D msr;
> +        env->nip =3D 0x200;
> +        return;
> +    }
> +
> +    ext_elog =3D g_malloc0(sizeof(struct mc_extended_log));
> +    summary =3D spapr_mce_get_elog_type(cpu, recovered, ext_elog);
> +
> +    log.summary =3D cpu_to_be32(summary);
> +    log.extended_length =3D cpu_to_be32(sizeof(struct mc_extended_log));
> +
> +    /* r3 should be in BE always */
> +    r3 =3D cpu_to_be64(env->gpr[3]);
> +    env->msr =3D msr;
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
> +    }
> +
> +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET, &r3, sizeo=
f(r3));
> +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET + sizeof(r3=
),
> +                              &log, sizeof(log));
> +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET + sizeof(r3=
) +
> +                              sizeof(log), ext_elog,
> +                              sizeof(struct mc_extended_log));
> +
> +    /* Save gpr[3] in the guest endian mode */
> +    if ((*pcc->interrupts_big_endian)(cpu)) {
> +        env->gpr[3] =3D cpu_to_be64(rtas_addr + RTAS_ERRLOG_OFFSET);

I don't think this is right.  AIUI env->gpr[] are all stored in *host*
endianness (for ease of doing arithmetic).

> +    } else {
> +        env->gpr[3] =3D cpu_to_le64(rtas_addr + RTAS_ERRLOG_OFFSET);
> +    }
> +
> +    env->nip =3D spapr->guest_machine_check_addr;
> +}
> +
>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> @@ -640,6 +881,10 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recov=
ered)
>          }
>      }
>      spapr->mc_status =3D cpu->vcpu_id;
> +
> +    spapr_mce_dispatch_elog(cpu, recovered);
> +
> +    return;
>  }
> =20
>  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f7204d0..03f34bf 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -661,6 +661,9 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_=
ulong opcode,
>  #define DIAGNOSTICS_RUN_MODE_IMMEDIATE 2
>  #define DIAGNOSTICS_RUN_MODE_PERIODIC  3
> =20
> +/* Offset from rtas-base where error log is placed */
> +#define RTAS_ERRLOG_OFFSET       0x25

Is this offset PAPR defined, or chosen here?  Using an entirely
unaliged (odd) address seems a very strange choice.

> +
>  static inline uint64_t ppc64_phys_to_real(uint64_t addr)
>  {
>      return addr & ~0xF000000000000000ULL;
> @@ -798,6 +801,7 @@ int spapr_max_server_number(SpaprMachineState *spapr);
>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>                        uint64_t pte0, uint64_t pte1);
>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
> +ssize_t spapr_get_rtas_size(ssize_t old_rtas_sizea);
> =20
>  /* DRC callbacks. */
>  void spapr_core_release(DeviceState *dev);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aqWxf8ydqYKP8htK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzVHUUACgkQbDjKyiDZ
s5J2xA//Q8HShl44le6pbYqsufYy7LqkmqDoGPcHnG9A0FjN8QvgvJiMX1l5QYpH
zNoy+UNNJj1qcFyCIOzBOMFG5yo1HqRvg6l3AtvALIKSD9qiHdHdbMTqIKlnddfZ
L3Y2Rz92nGOQsW4U1NSMnYmAioRnFr88djrKwjnTCaK9TLwI2+oo+Rq0gMzF9yc6
iCvnnnTTqZewOZCNtH01vvvQvwdDN1b5Axf1+BGjbnl9SQx/JxkvR4sgnpomQTi5
TKCmgvpsaPCBe17hNh7BhZF85LkCtbmbJr0ga1JF5701LuAk8GxQaVeKTdEAyzY0
w7wNmlgiAiwAv9YQmf2c6h29cBBpuLn2yIfOon8b/QnPFsHJaho29+BjPiPjcaWK
sllcFJshjMzanax8KG+1XejVaoNzf09vMrZzOnlaEkZ1hh9CvcHxhXUkbzTo+mXb
XdvaRBR27xauImkKgYw+5n72Mg7KOHHo0aLNWSuL1nohJyOHr/viXfGzoen3HXX+
T2Dyl+II0cvmGDOeG6jrUZoSwd387JVC8ABOILRN4IKNbDpoHI6y5EQ4ch7xzJvw
4EVRhwVCwUlhPLscCHn89F9fajICC+H9dhwcSGpyJEM07HgSzTPNg6u0eOncv3TX
1Cg3PUwoUteAKoh74BeDXtOQWJMPMUZlh5ubo4Rm9kqUbx9VAdY=
=L/65
-----END PGP SIGNATURE-----

--aqWxf8ydqYKP8htK--

