Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB973C06511
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 06:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B30621881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 06:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T1zyQB6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B30621881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiYXY-0005HJ-L2
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 02:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46402)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiYVy-0003YD-OL
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 02:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiYVw-000698-MY
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 02:13:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47777 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiYVs-0005v8-Rj; Wed, 03 Jul 2019 02:13:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45drPZ5PgGz9s4V; Wed,  3 Jul 2019 16:12:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562134370;
 bh=l1VhUVtueed7dIV/QfuuARljq3CAg0ec5S6AnIQphGo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T1zyQB6V2GUvbze0Noe8QG35k34xVIjuRnKURC7K5xfye34CQvJY+n9gkA91yRk1k
 DGeoPCtgFCx629CKuOZRTe0RM1FwT7IdHB+3FVX0IUFGom8wkSUsbnN67ZsBffyTx0
 kyl/m+pG9SWJyKIO/vUMg7oHvrN/jZbMBFTseZ2M=
Date: Wed, 3 Jul 2019 13:07:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190703030700.GH9442@umbus.fritz.box>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033128111.26635.16279854031001093005.stgit@aravinda>
 <20190702040307.GI6779@umbus.fritz.box>
 <80028d4d-88a7-4f90-f26d-52559857c66d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Yia77v5a8fyVHJSl"
Content-Disposition: inline
In-Reply-To: <80028d4d-88a7-4f90-f26d-52559857c66d@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v10 4/6] target/ppc: Build rtas error log
 upon an MCE
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


--Yia77v5a8fyVHJSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2019 at 03:19:24PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Tuesday 02 July 2019 09:33 AM, David Gibson wrote:
> > On Wed, Jun 12, 2019 at 02:51:21PM +0530, Aravinda Prasad wrote:
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
> >>  hw/ppc/spapr.c         |   13 +++
> >>  hw/ppc/spapr_events.c  |  238 +++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  hw/ppc/spapr_rtas.c    |   26 +++++
> >>  include/hw/ppc/spapr.h |    6 +
> >>  target/ppc/kvm.c       |    4 +
> >>  5 files changed, 284 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 6cc2c3b..d61905b 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2908,6 +2908,19 @@ static void spapr_machine_init(MachineState *ma=
chine)
> >>          error_report("Could not get size of LPAR rtas '%s'", filename=
);
> >>          exit(1);
> >>      }
> >> +
> >> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_ON=
) {
> >> +        /*
> >> +         * Ensure that the rtas image size is less than RTAS_ERROR_LO=
G_OFFSET
> >> +         * or else the rtas image will be overwritten with the rtas e=
rror log
> >> +         * when a machine check exception is encountered.
> >> +         */
> >> +        g_assert(spapr->rtas_size < RTAS_ERROR_LOG_OFFSET);
> >> +
> >> +        /* Resize rtas blob to accommodate error log */
> >> +        spapr->rtas_size =3D RTAS_ERROR_LOG_MAX;
> >> +    }
> >> +
> >>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
> >>      if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size)=
 < 0) {
> >>          error_report("Could not load LPAR rtas '%s'", filename);
> >> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> >> index a0c66d7..51c052e 100644
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
> >> @@ -620,7 +720,141 @@ void spapr_hotplug_req_remove_by_count_indexed(S=
paprDrcType drc_type,
> >>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &=
drc_id);
> >>  }
> >> =20
> >> -void spapr_mce_req_event(PowerPCCPU *cpu)
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
> >> +    if (env->msr & (1ULL << MSR_SF)) {
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
> >=20
> > Hm, does this differ from what ppc_cpu_do_system_reset() will do?
>=20
> Not much, but we branch to 0x200 instead of 0x100. But I think calling
>=20
> powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_MCHECK)
>=20
> should also work. Let me if you prefer using powerpc_excp().

Yes, I'd prefer to share code with existing exception paths where
possible.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Yia77v5a8fyVHJSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0cG9MACgkQbDjKyiDZ
s5JEtBAA2UUa4xV+xzdiu9Ntb/EnNioVWKzlOCDCgI8CrgLZlA7xldH0+GC0OEvC
tvnZ+OaDgJeIcNNpjbnAsLaYpEMWtrlb9lh2AeyAlauQplGinXIvquHLTNvi5EA7
EWMq4cL3gCqiJtMYfys1f/DsI0A6XORl3zxjUMNUmcEh4IqeWputwaIzqaZoEFZe
x59m7v7cVstubLnoeurKXatVw8hzXEPXz7sEYUIFB8tivoLvaC7nrC9PDBMSCvZ+
e56y2LAFW0CxpIqF+Vrgtf4sMV4k5eFYe3KabJz5mjLwuqVA0t30ZXWMDyTm156R
QfneFCKVmKXDW72VQIgY79Sk7uaE1n+hYZ9xEPku6lZe4mW4WOYrMymf0ZbEjL6M
zxsWagcwOxXTuc7cVBRmzjRR88NrQpSyB+bANdvgMLYa9nfzBxkKTTxdAB5N301/
nz89o00cqFf6uYyir+bRwm2c/1NS6m+LCGxLbpvkB7LEAInqQJAhZbBlgrSYVWKw
/vL9J6hUt+/2WU4BeKsrGRRRy0i0+ACpssrNVWgh7yNvQcjjNmfmVBz3vx8FLxi+
H0mOooxiHWrjtkXhlCLX+Hz3fW3U29aXJ2a6IuyKhTEEmOWluvWQczG2Lk/5pV7H
6xJAddUjuRVmzgR8/C/ypzZqkkDOSnwDvOF3yYmori+d7nQUc5I=
=XUUi
-----END PGP SIGNATURE-----

--Yia77v5a8fyVHJSl--

