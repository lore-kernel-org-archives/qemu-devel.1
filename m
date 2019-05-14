Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3398BC04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 01:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B5C2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 01:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MIQcfU82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B5C2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37285 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQM2x-0005Yp-Ra
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 21:15:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQM1d-00056h-Vt
	for qemu-devel@nongnu.org; Mon, 13 May 2019 21:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQM15-0007lV-Cm
	for qemu-devel@nongnu.org; Mon, 13 May 2019 21:14:37 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45371 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hQM0y-0007TQ-Rk; Mon, 13 May 2019 21:14:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45307V0PKCz9s9N; Tue, 14 May 2019 11:13:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557796422;
	bh=ll5ut3qMoBCMe8ZoGqYyjEgCLBmjzZu294F/zP8VitY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIQcfU825N23CyrfYdo4dk1dHQNYD1h05Kp/mYPdJmnb2l4Wu3DnYaUEEhm5QqdYJ
	8z/NyV3GRahne9jKEwKOum0eTJA/f0uRliXl/Q0fxKPYaflTmtYNTaBVO+6NVPU2Ei
	AP8pOsZKE8RSK7p0pugsYk0rK61i4zN342OYFD1s=
Date: Tue, 14 May 2019 10:08:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190514000819.GA6441@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591660602.20338.9804738040071843715.stgit@aravinda>
	<20190513133053.4d900d4a@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20190513133053.4d900d4a@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 4/6] target/ppc: Build rtas
 error log upon an MCE
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org, Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 01:30:53PM +0200, Greg Kurz wrote:
> On Mon, 22 Apr 2019 12:33:26 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
>=20
> > Upon a machine check exception (MCE) in a guest address space,
> > KVM causes a guest exit to enable QEMU to build and pass the
> > error to the guest in the PAPR defined rtas error log format.
> >=20
> > This patch builds the rtas error log, copies it to the rtas_addr
> > and then invokes the guest registered machine check handler. The
> > handler in the guest takes suitable action(s) depending on the type
> > and criticality of the error. For example, if an error is
> > unrecoverable memory corruption in an application inside the
> > guest, then the guest kernel sends a SIGBUS to the application.
> > For recoverable errors, the guest performs recovery actions and
> > logs the error.
> >=20
> > Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> > ---
> >  hw/ppc/spapr.c         |    4 +
> >  hw/ppc/spapr_events.c  |  245 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/hw/ppc/spapr.h |    4 +
> >  3 files changed, 253 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 2779efe..ffd1715 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2918,6 +2918,10 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >          error_report("Could not get size of LPAR rtas '%s'", filename);
> >          exit(1);
> >      }
> > +
> > +    /* Resize blob to accommodate error log. */
> > +    spapr->rtas_size =3D spapr_get_rtas_size(spapr->rtas_size);
> > +
>=20
> This is the only user for spapr_get_rtas_size(), which is trivial.
> I suggest you simply open-code it here.

I agree.

> But also, spapr->rtas_size is a guest visible thing, "rtas-size" prop in =
the
> DT. Since existing machine types don't do that, I guess we should only use
> the new size if cap-fwnmi-mce=3Don for the sake of compatibility.

Yes, that's a good idea.  Changing this is very unlikely to break a
guest, but it's easy to be safe here so let's do it.

>=20
> >      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
> >      if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size) =
< 0) {
> >          error_report("Could not load LPAR rtas '%s'", filename);
> > diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> > index 9922a23..4032db0 100644
> > --- a/hw/ppc/spapr_events.c
> > +++ b/hw/ppc/spapr_events.c
> > @@ -212,6 +212,106 @@ struct hp_extended_log {
> >      struct rtas_event_log_v6_hp hp;
> >  } QEMU_PACKED;
> > =20
> > +struct rtas_event_log_v6_mc {
>=20
> Even if the rest of the code in this file seems to ignore CODING_STYLE,
> maybe it's time to start using CamelCase.
>=20
> David ?

Out of scope here, I think.

> > +#define RTAS_LOG_V6_SECTION_ID_MC                   0x4D43 /* MC */
> > +    struct rtas_event_log_v6_section_header hdr;
> > +    uint32_t fru_id;
> > +    uint32_t proc_id;
> > +    uint8_t error_type;
> > +#define RTAS_LOG_V6_MC_TYPE_UE                           0
> > +#define RTAS_LOG_V6_MC_TYPE_SLB                          1
> > +#define RTAS_LOG_V6_MC_TYPE_ERAT                         2
> > +#define RTAS_LOG_V6_MC_TYPE_TLB                          4
> > +#define RTAS_LOG_V6_MC_TYPE_D_CACHE                      5
> > +#define RTAS_LOG_V6_MC_TYPE_I_CACHE                      7
> > +    uint8_t sub_err_type;
> > +#define RTAS_LOG_V6_MC_UE_INDETERMINATE                  0
> > +#define RTAS_LOG_V6_MC_UE_IFETCH                         1
> > +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH         2
> > +#define RTAS_LOG_V6_MC_UE_LOAD_STORE                     3
> > +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE     4
> > +#define RTAS_LOG_V6_MC_SLB_PARITY                        0
> > +#define RTAS_LOG_V6_MC_SLB_MULTIHIT                      1
> > +#define RTAS_LOG_V6_MC_SLB_INDETERMINATE                 2
> > +#define RTAS_LOG_V6_MC_ERAT_PARITY                       1
> > +#define RTAS_LOG_V6_MC_ERAT_MULTIHIT                     2
> > +#define RTAS_LOG_V6_MC_ERAT_INDETERMINATE                3
> > +#define RTAS_LOG_V6_MC_TLB_PARITY                        1
> > +#define RTAS_LOG_V6_MC_TLB_MULTIHIT                      2
> > +#define RTAS_LOG_V6_MC_TLB_INDETERMINATE                 3
> > +    uint8_t reserved_1[6];
> > +    uint64_t effective_address;
> > +    uint64_t logical_address;
> > +} QEMU_PACKED;
> > +
> > +struct mc_extended_log {
> > +    struct rtas_event_log_v6 v6hdr;
> > +    struct rtas_event_log_v6_mc mc;
> > +} QEMU_PACKED;
> > +
> > +struct MC_ierror_table {
> > +    unsigned long srr1_mask;
> > +    unsigned long srr1_value;
> > +    bool nip_valid; /* nip is a valid indicator of faulting address */
> > +    uint8_t error_type;
> > +    uint8_t error_subtype;
> > +    unsigned int initiator;
> > +    unsigned int severity;
> > +};
> > +
> > +static const struct MC_ierror_table mc_ierror_table[] =3D {
> > +{ 0x00000000081c0000, 0x0000000000040000, true,
> > +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_IFETCH,
> > +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > +{ 0x00000000081c0000, 0x0000000000080000, true,
> > +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
> > +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > +{ 0x00000000081c0000, 0x00000000000c0000, true,
> > +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,
> > +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > +{ 0x00000000081c0000, 0x0000000000100000, true,
> > +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
> > +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > +{ 0x00000000081c0000, 0x0000000000140000, true,
> > +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
> > +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > +{ 0x00000000081c0000, 0x0000000000180000, true,
> > +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH,
> > +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > +{ 0, 0, 0, 0, 0, 0 } };
> > +
> > +struct MC_derror_table {
> > +    unsigned long dsisr_value;
> > +    bool dar_valid; /* dar is a valid indicator of faulting address */
> > +    uint8_t error_type;
> > +    uint8_t error_subtype;
> > +    unsigned int initiator;
> > +    unsigned int severity;
> > +};
> > +
> > +static const struct MC_derror_table mc_derror_table[] =3D {
> > +{ 0x00008000, false,
> > +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_LOAD_STORE,
> > +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > +{ 0x00004000, true,
> > +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE,
> > +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > +{ 0x00000800, true,
> > +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
> > +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > +{ 0x00000400, true,
> > +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
> > +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > +{ 0x00000080, true,
> > +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,  /* Before PAR=
ITY */
> > +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > +{ 0x00000100, true,
> > +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
> > +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > +{ 0, false, 0, 0, 0, 0 } };
> > +
> > +#define SRR1_MC_LOADSTORE(srr1) ((srr1) & PPC_BIT(42))
> > +
> >  typedef enum EventClass {
> >      EVENT_CLASS_INTERNAL_ERRORS     =3D 0,
> >      EVENT_CLASS_EPOW                =3D 1,
> > @@ -620,6 +720,147 @@ void spapr_hotplug_req_remove_by_count_indexed(Sp=
aprDrcType drc_type,
> >                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &d=
rc_id);
> >  }
> > =20
> > +ssize_t spapr_get_rtas_size(ssize_t old_rtas_size)
> > +{
> > +    g_assert(old_rtas_size < RTAS_ERRLOG_OFFSET);
> > +    return RTAS_ERROR_LOG_MAX;
> > +}
> > +
> > +static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovere=
d,
> > +                                        struct mc_extended_log *ext_el=
og)
> > +{
> > +    int i;
> > +    CPUPPCState *env =3D &cpu->env;
> > +    uint32_t summary;
> > +    uint64_t dsisr =3D env->spr[SPR_DSISR];
> > +
> > +    summary =3D RTAS_LOG_VERSION_6 | RTAS_LOG_OPTIONAL_PART_PRESENT;
> > +    if (recovered) {
> > +        summary |=3D RTAS_LOG_DISPOSITION_FULLY_RECOVERED;
> > +    } else {
> > +        summary |=3D RTAS_LOG_DISPOSITION_NOT_RECOVERED;
> > +    }
> > +
> > +    if (SRR1_MC_LOADSTORE(env->spr[SPR_SRR1])) {
> > +        for (i =3D 0; mc_derror_table[i].dsisr_value; i++) {
> > +            if (!(dsisr & mc_derror_table[i].dsisr_value)) {
> > +                continue;
> > +            }
> > +
> > +            ext_elog->mc.error_type =3D mc_derror_table[i].error_type;
> > +            ext_elog->mc.sub_err_type =3D mc_derror_table[i].error_sub=
type;
> > +            if (mc_derror_table[i].dar_valid) {
> > +                ext_elog->mc.effective_address =3D cpu_to_be64(env->sp=
r[SPR_DAR]);
> > +            }
> > +
> > +            summary |=3D mc_derror_table[i].initiator
> > +                        | mc_derror_table[i].severity;
> > +
> > +            return summary;
> > +        }
> > +    } else {
> > +        for (i =3D 0; mc_ierror_table[i].srr1_mask; i++) {
> > +            if ((env->spr[SPR_SRR1] & mc_ierror_table[i].srr1_mask) !=
=3D
> > +                    mc_ierror_table[i].srr1_value) {
> > +                continue;
> > +            }
> > +
> > +            ext_elog->mc.error_type =3D mc_ierror_table[i].error_type;
> > +            ext_elog->mc.sub_err_type =3D mc_ierror_table[i].error_sub=
type;
> > +            if (mc_ierror_table[i].nip_valid) {
> > +                ext_elog->mc.effective_address =3D cpu_to_be64(env->ni=
p);
> > +            }
> > +
> > +            summary |=3D mc_ierror_table[i].initiator
> > +                        | mc_ierror_table[i].severity;
> > +
> > +            return summary;
> > +        }
> > +    }
> > +
> > +    summary |=3D RTAS_LOG_INITIATOR_CPU;
> > +    return summary;
> > +}
> > +
> > +static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
> > +{
> > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > +    CPUState *cs =3D CPU(cpu);
> > +    uint64_t rtas_addr;
> > +    CPUPPCState *env =3D &cpu->env;
> > +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > +    target_ulong r3, msr =3D 0;
> > +    struct rtas_error_log log;
> > +    struct mc_extended_log *ext_elog;
> > +    uint32_t summary;
> > +
> > +    /*
> > +     * Properly set bits in MSR before we invoke the handler.
> > +     * SRR0/1, DAR and DSISR are properly set by KVM
> > +     */
> > +    if (!(*pcc->interrupts_big_endian)(cpu)) {
> > +        msr |=3D (1ULL << MSR_LE);
> > +    }
> > +
> > +    if (env->msr && (1ULL << MSR_SF)) {
> > +        msr |=3D (1ULL << MSR_SF);
> > +    }
> > +
> > +    msr |=3D (1ULL << MSR_ME);
> > +
> > +    if (spapr->guest_machine_check_addr =3D=3D -1) {
>=20
> Should be (target_ulong) -1

I think the =3D=3D itself should perform the necessary coercion.

> > +        /*
> > +         * This implies that we have hit a machine check between system
> > +         * reset and "ibm,nmi-register". Fall back to the old machine
> > +         * check behavior in such cases.
> > +         */
> > +        env->spr[SPR_SRR0] =3D env->nip;
> > +        env->spr[SPR_SRR1] =3D env->msr;
> > +        env->msr =3D msr;
> > +        env->nip =3D 0x200;
> > +        return;
> > +    }
> > +
> > +    ext_elog =3D g_malloc0(sizeof(struct mc_extended_log));
>=20
> sizeof(*ext_elog) is preferable IMHO, same remark for the other sizeof si=
tes.

Agreed.

> Also, I can't find the corresponding call to g_free(), which should be
> somewhere in this function IIUC.

Yes, that needs fixing.

>=20
> > +    summary =3D spapr_mce_get_elog_type(cpu, recovered, ext_elog);
> > +
> > +    log.summary =3D cpu_to_be32(summary);
> > +    log.extended_length =3D cpu_to_be32(sizeof(struct mc_extended_log)=
);
> > +
> > +    /* r3 should be in BE always */
> > +    r3 =3D cpu_to_be64(env->gpr[3]);
> > +    env->msr =3D msr;
> > +
> > +    spapr_init_v6hdr(&ext_elog->v6hdr);
> > +    ext_elog->mc.hdr.section_id =3D cpu_to_be16(RTAS_LOG_V6_SECTION_ID=
_MC);
> > +    ext_elog->mc.hdr.section_length =3D
> > +                    cpu_to_be16(sizeof(struct rtas_event_log_v6_mc));
> > +    ext_elog->mc.hdr.section_version =3D 1;
> > +
> > +    /* get rtas addr from fdt */
> > +    rtas_addr =3D spapr_get_rtas_addr();
> > +    if (!rtas_addr) {
> > +        /* Unable to fetch rtas_addr. Hence reset the guest */
> > +        ppc_cpu_do_system_reset(cs);
> > +    }
> > +
> > +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET, &r3, siz=
eof(r3));
> > +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET + sizeof(=
r3),
> > +                              &log, sizeof(log));
> > +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET + sizeof(=
r3) +
> > +                              sizeof(log), ext_elog,
> > +                              sizeof(struct mc_extended_log));
> > +
> > +    /* Save gpr[3] in the guest endian mode */
> > +    if ((*pcc->interrupts_big_endian)(cpu)) {
> > +        env->gpr[3] =3D cpu_to_be64(rtas_addr + RTAS_ERRLOG_OFFSET);
> > +    } else {
> > +        env->gpr[3] =3D cpu_to_le64(rtas_addr + RTAS_ERRLOG_OFFSET);
> > +    }
> > +
> > +    env->nip =3D spapr->guest_machine_check_addr;
> > +}
> > +
> >  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
> >  {
> >      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > @@ -640,6 +881,10 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool rec=
overed)
> >          }
> >      }
> >      spapr->mc_status =3D cpu->vcpu_id;
> > +
> > +    spapr_mce_dispatch_elog(cpu, recovered);
> > +
> > +    return;
> >  }
> > =20
> >  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index f7204d0..03f34bf 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -661,6 +661,9 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, targe=
t_ulong opcode,
> >  #define DIAGNOSTICS_RUN_MODE_IMMEDIATE 2
> >  #define DIAGNOSTICS_RUN_MODE_PERIODIC  3
> > =20
> > +/* Offset from rtas-base where error log is placed */
> > +#define RTAS_ERRLOG_OFFSET       0x25
> > +
>=20
> We already have an RTAS_ERROR_LOG_MAX macro defined in this file.
> Maybe use the same "ERROR_LOG" wording for consistency.

Agreed.

> >  static inline uint64_t ppc64_phys_to_real(uint64_t addr)
> >  {
> >      return addr & ~0xF000000000000000ULL;
> > @@ -798,6 +801,7 @@ int spapr_max_server_number(SpaprMachineState *spap=
r);
> >  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> >                        uint64_t pte0, uint64_t pte1);
> >  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
> > +ssize_t spapr_get_rtas_size(ssize_t old_rtas_sizea);
> > =20
> >  /* DRC callbacks. */
> >  void spapr_core_release(DeviceState *dev);
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzaBvAACgkQbDjKyiDZ
s5IpoRAAyNMCKDtpzJHdr2U1Wm1MdG0RULhSSbKyXyAMNQ3nsaBYoqQ7SlDlp+FJ
vpsK8HB+Mios4Ttkp8YNs03Cx1mbot7lsoaD9vopSMzrgwYZWTIfa9s5AMX8uCrV
mzfukUj1+AZbXUy8yGaj1IPDk2YNxHT8eN8qK48dQarBEn8Z2V7B3zRq0ohszh7g
j+WEotRM45SLBXm2zVdYewnDnH65Bh16YRXyyvwfFtY9O2/dt1sJ1x5cw1KyllFY
NiP80fZPHwQHA4tu1qT0VexCJYvRDWISKD5v7XchOwrG5/1/vOTg/dynS1Wxk0Bb
PtFcMo3NT34OvGDcUk4qkVJCyS6A7Mc+SS4zM86Z3bMTBO8Rsm3MFpWlE2eiSxNr
wI9gOsLop/PPhPKCZPChvvtFqVW/tpnqH8xhPGVcrNreU2aCrc3BOFj0D8SOAzZ1
+wFsKS/Nfwyj7tUh37PWcToHOUkDkl2jCn3rNzW4H8Uk3T6txskWXJ/K9iOBWE+r
jk2Lqk/5q79rai8hKgGkzZn88MukkpePbnVzqTPgqiskKv1NzC2FiB4vdwt5Ik38
eTtZc4Pf7i0LEy7zfY402xo6rKOBnuIgdoccQJwDZzQvfm/lUFIH5U1DakdPTtua
sftAJHATKWRAO+EZegtrkSkQeEoBMogBPf5wWD2fxgNFmq0kZys=
=Lp3u
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

