Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CAEC04AB2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239FE2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MLbzfkcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239FE2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43423 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5fP-0005Ex-7x
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:34:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hP5dQ-00046S-D7
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hP5dO-0001ZE-Cc
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:32:24 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49605)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hP5dN-0001XP-2v; Fri, 10 May 2019 09:32:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450rjX4Xp6z9sCJ; Fri, 10 May 2019 23:32:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557495136;
	bh=PWmcr2C3rkhsKaXPNIHmwkpIQWgposvdRBxJ//OOoUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLbzfkcf7WitBClrZF9vUxMvADKB9yBq0FLa+DgH8KQzObtxoO8PLT4soBHNEnnVR
	4P5M9xIhVuoBzEbICzYL7mBAv0Ac2UHmcQTfgUTKZpLFoIFzeXGCRUB9KS5KWcjQpj
	zz5WW8GFhajrTbIZkgIT4koldIv1Cq+/lFky/aKs=
Date: Fri, 10 May 2019 19:52:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190510095201.GA5030@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591660602.20338.9804738040071843715.stgit@aravinda>
	<20190510064213.GK20559@umbus.fritz.box>
	<2cf9df3f-c3ea-5a36-e5fc-1a40386d1586@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <2cf9df3f-c3ea-5a36-e5fc-1a40386d1586@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
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


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 12:35:13PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Friday 10 May 2019 12:12 PM, David Gibson wrote:
> > On Mon, Apr 22, 2019 at 12:33:26PM +0530, Aravinda Prasad wrote:
> >> Upon a machine check exception (MCE) in a guest address space,
> >> KVM causes a guest exit to enable QEMU to build and pass the
> >> error to the guest in the PAPR defined rtas error log format.
> >>
> >> This patch builds the rtas error log, copies it to the rtas_addr
> >> and then invokes the guest registered machine check handler. The
> >> handler in the guest takes suitable action(s) depending on the type
> >> and criticality of the error. For example, if an error is
> >> unrecoverable memory corruption in an application inside the
> >> guest, then the guest kernel sends a SIGBUS to the application.
> >> For recoverable errors, the guest performs recovery actions and
> >> logs the error.
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> ---
> >>  hw/ppc/spapr.c         |    4 +
> >>  hw/ppc/spapr_events.c  |  245 +++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  include/hw/ppc/spapr.h |    4 +
> >>  3 files changed, 253 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 2779efe..ffd1715 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2918,6 +2918,10 @@ static void spapr_machine_init(MachineState *ma=
chine)
> >>          error_report("Could not get size of LPAR rtas '%s'", filename=
);
> >>          exit(1);
> >>      }
> >> +
> >> +    /* Resize blob to accommodate error log. */
> >> +    spapr->rtas_size =3D spapr_get_rtas_size(spapr->rtas_size);
> >> +
> >>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
> >>      if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size)=
 < 0) {
> >>          error_report("Could not load LPAR rtas '%s'", filename);
> >> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> >> index 9922a23..4032db0 100644
> >> --- a/hw/ppc/spapr_events.c
> >> +++ b/hw/ppc/spapr_events.c
> >> @@ -212,6 +212,106 @@ struct hp_extended_log {
> >>      struct rtas_event_log_v6_hp hp;
> >>  } QEMU_PACKED;
> >> =20
> >> +struct rtas_event_log_v6_mc {
> >> +#define RTAS_LOG_V6_SECTION_ID_MC                   0x4D43 /* MC */
> >> +    struct rtas_event_log_v6_section_header hdr;
> >> +    uint32_t fru_id;
> >> +    uint32_t proc_id;
> >> +    uint8_t error_type;
> >> +#define RTAS_LOG_V6_MC_TYPE_UE                           0
> >> +#define RTAS_LOG_V6_MC_TYPE_SLB                          1
> >> +#define RTAS_LOG_V6_MC_TYPE_ERAT                         2
> >> +#define RTAS_LOG_V6_MC_TYPE_TLB                          4
> >> +#define RTAS_LOG_V6_MC_TYPE_D_CACHE                      5
> >> +#define RTAS_LOG_V6_MC_TYPE_I_CACHE                      7
> >> +    uint8_t sub_err_type;
> >> +#define RTAS_LOG_V6_MC_UE_INDETERMINATE                  0
> >> +#define RTAS_LOG_V6_MC_UE_IFETCH                         1
> >> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH         2
> >> +#define RTAS_LOG_V6_MC_UE_LOAD_STORE                     3
> >> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE     4
> >> +#define RTAS_LOG_V6_MC_SLB_PARITY                        0
> >> +#define RTAS_LOG_V6_MC_SLB_MULTIHIT                      1
> >> +#define RTAS_LOG_V6_MC_SLB_INDETERMINATE                 2
> >> +#define RTAS_LOG_V6_MC_ERAT_PARITY                       1
> >> +#define RTAS_LOG_V6_MC_ERAT_MULTIHIT                     2
> >> +#define RTAS_LOG_V6_MC_ERAT_INDETERMINATE                3
> >> +#define RTAS_LOG_V6_MC_TLB_PARITY                        1
> >> +#define RTAS_LOG_V6_MC_TLB_MULTIHIT                      2
> >> +#define RTAS_LOG_V6_MC_TLB_INDETERMINATE                 3
> >> +    uint8_t reserved_1[6];
> >> +    uint64_t effective_address;
> >> +    uint64_t logical_address;
> >> +} QEMU_PACKED;
> >> +
> >> +struct mc_extended_log {
> >> +    struct rtas_event_log_v6 v6hdr;
> >> +    struct rtas_event_log_v6_mc mc;
> >> +} QEMU_PACKED;
> >> +
> >> +struct MC_ierror_table {
> >> +    unsigned long srr1_mask;
> >> +    unsigned long srr1_value;
> >> +    bool nip_valid; /* nip is a valid indicator of faulting address */
> >> +    uint8_t error_type;
> >> +    uint8_t error_subtype;
> >> +    unsigned int initiator;
> >> +    unsigned int severity;
> >> +};
> >> +
> >> +static const struct MC_ierror_table mc_ierror_table[] =3D {
> >> +{ 0x00000000081c0000, 0x0000000000040000, true,
> >> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_IFETCH,
> >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> >> +{ 0x00000000081c0000, 0x0000000000080000, true,
> >> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
> >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> >> +{ 0x00000000081c0000, 0x00000000000c0000, true,
> >> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,
> >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> >> +{ 0x00000000081c0000, 0x0000000000100000, true,
> >> +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
> >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> >> +{ 0x00000000081c0000, 0x0000000000140000, true,
> >> +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
> >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> >> +{ 0x00000000081c0000, 0x0000000000180000, true,
> >> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH,
> >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> >> +{ 0, 0, 0, 0, 0, 0 } };
> >> +
> >> +struct MC_derror_table {
> >> +    unsigned long dsisr_value;
> >> +    bool dar_valid; /* dar is a valid indicator of faulting address */
> >> +    uint8_t error_type;
> >> +    uint8_t error_subtype;
> >> +    unsigned int initiator;
> >> +    unsigned int severity;
> >> +};
> >> +
> >> +static const struct MC_derror_table mc_derror_table[] =3D {
> >> +{ 0x00008000, false,
> >> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_LOAD_STORE,
> >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> >> +{ 0x00004000, true,
> >> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STOR=
E,
> >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> >> +{ 0x00000800, true,
> >> +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
> >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> >> +{ 0x00000400, true,
> >> +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
> >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> >> +{ 0x00000080, true,
> >> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,  /* Before PA=
RITY */
> >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> >> +{ 0x00000100, true,
> >> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
> >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> >> +{ 0, false, 0, 0, 0, 0 } };
> >> +
> >> +#define SRR1_MC_LOADSTORE(srr1) ((srr1) & PPC_BIT(42))
> >> +
> >>  typedef enum EventClass {
> >>      EVENT_CLASS_INTERNAL_ERRORS     =3D 0,
> >>      EVENT_CLASS_EPOW                =3D 1,
> >> @@ -620,6 +720,147 @@ void spapr_hotplug_req_remove_by_count_indexed(S=
paprDrcType drc_type,
> >>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &=
drc_id);
> >>  }
> >> =20
> >> +ssize_t spapr_get_rtas_size(ssize_t old_rtas_size)
> >> +{
> >> +    g_assert(old_rtas_size < RTAS_ERRLOG_OFFSET);
> >> +    return RTAS_ERROR_LOG_MAX;
> >> +}
> >> +
> >> +static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recover=
ed,
> >> +                                        struct mc_extended_log *ext_e=
log)
> >> +{
> >> +    int i;
> >> +    CPUPPCState *env =3D &cpu->env;
> >> +    uint32_t summary;
> >> +    uint64_t dsisr =3D env->spr[SPR_DSISR];
> >> +
> >> +    summary =3D RTAS_LOG_VERSION_6 | RTAS_LOG_OPTIONAL_PART_PRESENT;
> >> +    if (recovered) {
> >> +        summary |=3D RTAS_LOG_DISPOSITION_FULLY_RECOVERED;
> >> +    } else {
> >> +        summary |=3D RTAS_LOG_DISPOSITION_NOT_RECOVERED;
> >> +    }
> >> +
> >> +    if (SRR1_MC_LOADSTORE(env->spr[SPR_SRR1])) {
> >> +        for (i =3D 0; mc_derror_table[i].dsisr_value; i++) {
> >> +            if (!(dsisr & mc_derror_table[i].dsisr_value)) {
> >> +                continue;
> >> +            }
> >> +
> >> +            ext_elog->mc.error_type =3D mc_derror_table[i].error_type;
> >> +            ext_elog->mc.sub_err_type =3D mc_derror_table[i].error_su=
btype;
> >> +            if (mc_derror_table[i].dar_valid) {
> >> +                ext_elog->mc.effective_address =3D cpu_to_be64(env->s=
pr[SPR_DAR]);
> >> +            }
> >> +
> >> +            summary |=3D mc_derror_table[i].initiator
> >> +                        | mc_derror_table[i].severity;
> >> +
> >> +            return summary;
> >> +        }
> >> +    } else {
> >> +        for (i =3D 0; mc_ierror_table[i].srr1_mask; i++) {
> >> +            if ((env->spr[SPR_SRR1] & mc_ierror_table[i].srr1_mask) !=
=3D
> >> +                    mc_ierror_table[i].srr1_value) {
> >> +                continue;
> >> +            }
> >> +
> >> +            ext_elog->mc.error_type =3D mc_ierror_table[i].error_type;
> >> +            ext_elog->mc.sub_err_type =3D mc_ierror_table[i].error_su=
btype;
> >> +            if (mc_ierror_table[i].nip_valid) {
> >> +                ext_elog->mc.effective_address =3D cpu_to_be64(env->n=
ip);
> >> +            }
> >> +
> >> +            summary |=3D mc_ierror_table[i].initiator
> >> +                        | mc_ierror_table[i].severity;
> >> +
> >> +            return summary;
> >> +        }
> >> +    }
> >> +
> >> +    summary |=3D RTAS_LOG_INITIATOR_CPU;
> >> +    return summary;
> >> +}
> >> +
> >> +static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
> >> +{
> >> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >> +    CPUState *cs =3D CPU(cpu);
> >> +    uint64_t rtas_addr;
> >> +    CPUPPCState *env =3D &cpu->env;
> >> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> >> +    target_ulong r3, msr =3D 0;
> >> +    struct rtas_error_log log;
> >> +    struct mc_extended_log *ext_elog;
> >> +    uint32_t summary;
> >> +
> >> +    /*
> >> +     * Properly set bits in MSR before we invoke the handler.
> >> +     * SRR0/1, DAR and DSISR are properly set by KVM
> >> +     */
> >> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
> >> +        msr |=3D (1ULL << MSR_LE);
> >> +    }
> >> +
> >> +    if (env->msr && (1ULL << MSR_SF)) {
> >> +        msr |=3D (1ULL << MSR_SF);
> >> +    }
> >> +
> >> +    msr |=3D (1ULL << MSR_ME);
> >> +
> >> +    if (spapr->guest_machine_check_addr =3D=3D -1) {
> >> +        /*
> >> +         * This implies that we have hit a machine check between syst=
em
> >> +         * reset and "ibm,nmi-register". Fall back to the old machine
> >> +         * check behavior in such cases.
> >> +         */
> >> +        env->spr[SPR_SRR0] =3D env->nip;
> >> +        env->spr[SPR_SRR1] =3D env->msr;
> >> +        env->msr =3D msr;
> >> +        env->nip =3D 0x200;
> >> +        return;
> >> +    }
> >> +
> >> +    ext_elog =3D g_malloc0(sizeof(struct mc_extended_log));
> >> +    summary =3D spapr_mce_get_elog_type(cpu, recovered, ext_elog);
> >> +
> >> +    log.summary =3D cpu_to_be32(summary);
> >> +    log.extended_length =3D cpu_to_be32(sizeof(struct mc_extended_log=
));
> >> +
> >> +    /* r3 should be in BE always */
> >> +    r3 =3D cpu_to_be64(env->gpr[3]);
> >> +    env->msr =3D msr;
> >> +
> >> +    spapr_init_v6hdr(&ext_elog->v6hdr);
> >> +    ext_elog->mc.hdr.section_id =3D cpu_to_be16(RTAS_LOG_V6_SECTION_I=
D_MC);
> >> +    ext_elog->mc.hdr.section_length =3D
> >> +                    cpu_to_be16(sizeof(struct rtas_event_log_v6_mc));
> >> +    ext_elog->mc.hdr.section_version =3D 1;
> >> +
> >> +    /* get rtas addr from fdt */
> >> +    rtas_addr =3D spapr_get_rtas_addr();
> >> +    if (!rtas_addr) {
> >> +        /* Unable to fetch rtas_addr. Hence reset the guest */
> >> +        ppc_cpu_do_system_reset(cs);
> >> +    }
> >> +
> >> +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET, &r3, si=
zeof(r3));
> >> +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET + sizeof=
(r3),
> >> +                              &log, sizeof(log));
> >> +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET + sizeof=
(r3) +
> >> +                              sizeof(log), ext_elog,
> >> +                              sizeof(struct mc_extended_log));
> >> +
> >> +    /* Save gpr[3] in the guest endian mode */
> >> +    if ((*pcc->interrupts_big_endian)(cpu)) {
> >> +        env->gpr[3] =3D cpu_to_be64(rtas_addr + RTAS_ERRLOG_OFFSET);
> >=20
> > I don't think this is right.  AIUI env->gpr[] are all stored in *host*
> > endianness (for ease of doing arithmetic).
>=20
> env-gpr[3] is later used by guest to fetch the RTAS log. My guess is
> that we will not do an endianness change of all the gprs during a switch
> from host to guest (that will be costly).

There's no need to "change endianness".  In TCG the host needs to do
arithmetic on the values and so they are in host endian.  With KVM the
env values are only synchronized when we enter/exit KVM and they're
going to registers, not memory and so have no endianness.

> But let me cross check.
>=20
> >=20
> >> +    } else {
> >> +        env->gpr[3] =3D cpu_to_le64(rtas_addr + RTAS_ERRLOG_OFFSET);
> >> +    }
> >> +
> >> +    env->nip =3D spapr->guest_machine_check_addr;
> >> +}
> >> +
> >>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
> >>  {
> >>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >> @@ -640,6 +881,10 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool re=
covered)
> >>          }
> >>      }
> >>      spapr->mc_status =3D cpu->vcpu_id;
> >> +
> >> +    spapr_mce_dispatch_elog(cpu, recovered);
> >> +
> >> +    return;
> >>  }
> >> =20
> >>  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index f7204d0..03f34bf 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -661,6 +661,9 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, targ=
et_ulong opcode,
> >>  #define DIAGNOSTICS_RUN_MODE_IMMEDIATE 2
> >>  #define DIAGNOSTICS_RUN_MODE_PERIODIC  3
> >> =20
> >> +/* Offset from rtas-base where error log is placed */
> >> +#define RTAS_ERRLOG_OFFSET       0x25
> >=20
> > Is this offset PAPR defined, or chosen here?  Using an entirely
> > unaliged (odd) address seems a very strange choice.
>=20
> This is not PAPR defined. I will make it 0x30. Or do you prefer any
> other offset?

0x30 should be fine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzVSb4ACgkQbDjKyiDZ
s5IJ5A/7BJ2p/JucMkKrGfqyu9ydD5zkrxaYnWOKgt6SPEyG4AdcuvoVyOavz93+
790LjLWYP+OfY3IKvXHl1XF8WJkOdyq17ayEYEGOXqq9bjja7OpIJ6+1kUjTfdMo
yKBWuFCoBkrxdOPTmYegijZSCS4A9QkUC9P1ORkzgk/c3XXLq/hZrfOaebA/p0Rq
0J41jEH6ZG6fKUCMHMj+eZrr2tqKuCRJQ/ce1P7DxM6bBz2Ush5j/mOoNrhc7EfS
M4cxaj9XSTbBfoHhCTPZV74c11XFKrYs8XqnV81nLSdonY4PfXhqkdVwZhO8JL5p
YxYINQcF1rn/amX8+x7Pk08gG2Is3QfT8etwdv+OJwBLzndNWjph8GcF10MDQ83S
eiJ+dv7uI7BwVELwrjC5FwXzeh4UMK/d2nAdK2ruY4yGw9YYOviKSxzLlYjtaW47
ooYzqW9uqtsxptul9k8JGgrckEqkr7RzkSCIiO38FNcsGeUlH679KnWGC+xay8m4
bDet7PqrDmbMvb5Yk9LgFZmCs/u44GcY3HYKZIuGBzIEvUn/gDbPoI7AOpUjV461
QAsfX0KFEW1XBdphohAAX5I4SpYIodJoe+JQefaORhEW48X6N4uVf6Ub9AW7fDFZ
Y0I/wGHky/WGlQ2CyYE5LYwGA1sI+XqQ23mWhrzzpoamPi/xmrg=
=nl5H
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

