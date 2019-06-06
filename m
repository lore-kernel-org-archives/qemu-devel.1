Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B52FC28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7AC2070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HqqdQdDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7AC2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53577 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYinO-0004La-VU
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 23:10:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYijx-0002Cc-W6
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYijk-0006Uv-HE
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:06:49 -0400
Received: from ozlabs.org ([203.11.71.1]:49475)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hYijd-0006FN-Bv; Wed, 05 Jun 2019 23:06:39 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45K9Xs22rBz9sNT; Thu,  6 Jun 2019 13:06:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559790381;
	bh=HGucfr/zZW443nbFjNKek7oACaGAIsf3E5EZRg+EbrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HqqdQdDbQTsmxEDU1bjACP2oyLw6cEE+qcR7sjrhJNhIsYUMr7TIlXI/dtCmPpZMp
	bS5XXnXRdGDidPxTTFTK3ayJlEi/mLGT3ZyLCcT3Q5A5P708FydEz2uoK+6QY0nJlh
	cOvsRQ3rZDe2jwcDN7+stLF2uyNOtzyYqUvUFufQ=
Date: Thu, 6 Jun 2019 12:58:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190606025827.GH10319@umbus.fritz.box>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
	<155910844057.13149.1476616524987244293.stgit@aravinda>
	<20190603160030.03e3c691@bahia.lab.toulouse-stg.fr.ibm.com>
	<e7c7ea6a-e377-aa24-dc4b-e56a9973093c@linux.vnet.ibm.com>
	<20190604110119.7bbb4716@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
Content-Disposition: inline
In-Reply-To: <20190604110119.7bbb4716@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v9 4/6] target/ppc: Build rtas error log
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org, Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 11:01:19AM +0200, Greg Kurz wrote:
> On Tue, 4 Jun 2019 11:59:13 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
>=20
> > On Monday 03 June 2019 07:30 PM, Greg Kurz wrote:
> > > On Wed, 29 May 2019 11:10:40 +0530
> > > Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> > >  =20
> > >> Upon a machine check exception (MCE) in a guest address space,
> > >> KVM causes a guest exit to enable QEMU to build and pass the
> > >> error to the guest in the PAPR defined rtas error log format.
> > >>
> > >> This patch builds the rtas error log, copies it to the rtas_addr
> > >> and then invokes the guest registered machine check handler. The
> > >> handler in the guest takes suitable action(s) depending on the type
> > >> and criticality of the error. For example, if an error is
> > >> unrecoverable memory corruption in an application inside the
> > >> guest, then the guest kernel sends a SIGBUS to the application.
> > >> For recoverable errors, the guest performs recovery actions and
> > >> logs the error.
> > >>
> > >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> > >> ---
> > >>  hw/ppc/spapr.c         |    5 +
> > >>  hw/ppc/spapr_events.c  |  236 +++++++++++++++++++++++++++++++++++++=
+++++++++++
> > >>  include/hw/ppc/spapr.h |    4 +
> > >>  3 files changed, 245 insertions(+)
> > >>
> > >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > >> index 6b6c962..c97f6a6 100644
> > >> --- a/hw/ppc/spapr.c
> > >> +++ b/hw/ppc/spapr.c
> > >> @@ -2910,6 +2910,11 @@ static void spapr_machine_init(MachineState *=
machine)
> > >>          error_report("Could not get size of LPAR rtas '%s'", filena=
me);
> > >>          exit(1);
> > >>      }
> > >> +
> > >> +    /* Resize blob to accommodate error log. */
> > >> +    g_assert(spapr->rtas_size < RTAS_ERROR_LOG_OFFSET); =20
> > >=20
> > > I don't see the point of this assertion... especially with the assign=
ment
> > > below. =20
> >=20
> > It is required because we want to ensure that the rtas image size is
> > less than RTAS_ERROR_LOG_OFFSET, or else we will overwrite the rtas
> > image with rtas error when we hit machine check exception. But I think a
> > comment in the code will help. Will add it.
>=20
> I'd rather exit QEMU properly instead of aborting then. Also this is only
> needed if the guest has a chance to use FWNMI, ie. the spapr cap is
> set.

I think assert() is appropriate in this case.  If it fails it means
something is wrong in the code, not with configuration.

>=20
> >=20
> > >  =20
> > >> +    spapr->rtas_size =3D RTAS_ERROR_LOG_MAX; =20
> > >=20
> > > As requested by David, this should only be done when the spapr cap is=
 set,
> > > so that 4.0 machine types and older continue to use the current size.=
 =20
> >=20
> > Due to other issue of re-allocating the blob and as this is not that
> > much space, we agreed to keep the size to RTAS_ERROR_LOG_MAX always.
> >=20
> > Link to the discussion on this:
> > http://lists.nongnu.org/archive/html/qemu-ppc/2019-05/msg00275.html
> >=20
>=20
> Indeed, and in the next mail in that thread, David writes:
>=20
> > No, that's not right.  It's impractical to change the allocation
> > depending on whether fwnmi is currently active.  But you *can* (and
> > should) base the allocation on whether fwnmi is *possible* - that is,
> > the value of the spapr cap.
>=20
> ie, allocate RTAS_ERROR_LOG_MAX when the spapr cap is set, allocate
> the file size otherwise.
>=20
> > >  =20
> > >> +
> > >>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
> > >>      if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_siz=
e) < 0) {
> > >>          error_report("Could not load LPAR rtas '%s'", filename);
> > >> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> > >> index a18446b..573c0b7 100644
> > >> --- a/hw/ppc/spapr_events.c
> > >> +++ b/hw/ppc/spapr_events.c
> > >> @@ -212,6 +212,106 @@ struct hp_extended_log {
> > >>      struct rtas_event_log_v6_hp hp;
> > >>  } QEMU_PACKED;
> > >> =20
> > >> +struct rtas_event_log_v6_mc {
> > >> +#define RTAS_LOG_V6_SECTION_ID_MC                   0x4D43 /* MC */
> > >> +    struct rtas_event_log_v6_section_header hdr;
> > >> +    uint32_t fru_id;
> > >> +    uint32_t proc_id;
> > >> +    uint8_t error_type;
> > >> +#define RTAS_LOG_V6_MC_TYPE_UE                           0
> > >> +#define RTAS_LOG_V6_MC_TYPE_SLB                          1
> > >> +#define RTAS_LOG_V6_MC_TYPE_ERAT                         2
> > >> +#define RTAS_LOG_V6_MC_TYPE_TLB                          4
> > >> +#define RTAS_LOG_V6_MC_TYPE_D_CACHE                      5
> > >> +#define RTAS_LOG_V6_MC_TYPE_I_CACHE                      7
> > >> +    uint8_t sub_err_type;
> > >> +#define RTAS_LOG_V6_MC_UE_INDETERMINATE                  0
> > >> +#define RTAS_LOG_V6_MC_UE_IFETCH                         1
> > >> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH         2
> > >> +#define RTAS_LOG_V6_MC_UE_LOAD_STORE                     3
> > >> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE     4
> > >> +#define RTAS_LOG_V6_MC_SLB_PARITY                        0
> > >> +#define RTAS_LOG_V6_MC_SLB_MULTIHIT                      1
> > >> +#define RTAS_LOG_V6_MC_SLB_INDETERMINATE                 2
> > >> +#define RTAS_LOG_V6_MC_ERAT_PARITY                       1
> > >> +#define RTAS_LOG_V6_MC_ERAT_MULTIHIT                     2
> > >> +#define RTAS_LOG_V6_MC_ERAT_INDETERMINATE                3
> > >> +#define RTAS_LOG_V6_MC_TLB_PARITY                        1
> > >> +#define RTAS_LOG_V6_MC_TLB_MULTIHIT                      2
> > >> +#define RTAS_LOG_V6_MC_TLB_INDETERMINATE                 3
> > >> +    uint8_t reserved_1[6];
> > >> +    uint64_t effective_address;
> > >> +    uint64_t logical_address;
> > >> +} QEMU_PACKED;
> > >> +
> > >> +struct mc_extended_log {
> > >> +    struct rtas_event_log_v6 v6hdr;
> > >> +    struct rtas_event_log_v6_mc mc;
> > >> +} QEMU_PACKED;
> > >> +
> > >> +struct MC_ierror_table {
> > >> +    unsigned long srr1_mask;
> > >> +    unsigned long srr1_value;
> > >> +    bool nip_valid; /* nip is a valid indicator of faulting address=
 */
> > >> +    uint8_t error_type;
> > >> +    uint8_t error_subtype;
> > >> +    unsigned int initiator;
> > >> +    unsigned int severity;
> > >> +};
> > >> +
> > >> +static const struct MC_ierror_table mc_ierror_table[] =3D {
> > >> +{ 0x00000000081c0000, 0x0000000000040000, true,
> > >> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_IFETCH,
> > >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > >> +{ 0x00000000081c0000, 0x0000000000080000, true,
> > >> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
> > >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > >> +{ 0x00000000081c0000, 0x00000000000c0000, true,
> > >> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,
> > >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > >> +{ 0x00000000081c0000, 0x0000000000100000, true,
> > >> +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
> > >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > >> +{ 0x00000000081c0000, 0x0000000000140000, true,
> > >> +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
> > >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > >> +{ 0x00000000081c0000, 0x0000000000180000, true,
> > >> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH,
> > >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > >> +{ 0, 0, 0, 0, 0, 0 } };
> > >> +
> > >> +struct MC_derror_table {
> > >> +    unsigned long dsisr_value;
> > >> +    bool dar_valid; /* dar is a valid indicator of faulting address=
 */
> > >> +    uint8_t error_type;
> > >> +    uint8_t error_subtype;
> > >> +    unsigned int initiator;
> > >> +    unsigned int severity;
> > >> +};
> > >> +
> > >> +static const struct MC_derror_table mc_derror_table[] =3D {
> > >> +{ 0x00008000, false,
> > >> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_LOAD_STORE,
> > >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > >> +{ 0x00004000, true,
> > >> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_ST=
ORE,
> > >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > >> +{ 0x00000800, true,
> > >> +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
> > >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > >> +{ 0x00000400, true,
> > >> +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
> > >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > >> +{ 0x00000080, true,
> > >> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,  /* Before =
PARITY */
> > >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > >> +{ 0x00000100, true,
> > >> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
> > >> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > >> +{ 0, false, 0, 0, 0, 0 } };
> > >> +
> > >> +#define SRR1_MC_LOADSTORE(srr1) ((srr1) & PPC_BIT(42))
> > >> +
> > >>  typedef enum EventClass {
> > >>      EVENT_CLASS_INTERNAL_ERRORS     =3D 0,
> > >>      EVENT_CLASS_EPOW                =3D 1,
> > >> @@ -620,6 +720,138 @@ void spapr_hotplug_req_remove_by_count_indexed=
(SpaprDrcType drc_type,
> > >>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type,=
 &drc_id);
> > >>  }
> > >> =20
> > >> +static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recov=
ered,
> > >> +                                        struct mc_extended_log *ext=
_elog)
> > >> +{
> > >> +    int i;
> > >> +    CPUPPCState *env =3D &cpu->env;
> > >> +    uint32_t summary;
> > >> +    uint64_t dsisr =3D env->spr[SPR_DSISR];
> > >> +
> > >> +    summary =3D RTAS_LOG_VERSION_6 | RTAS_LOG_OPTIONAL_PART_PRESENT;
> > >> +    if (recovered) {
> > >> +        summary |=3D RTAS_LOG_DISPOSITION_FULLY_RECOVERED;
> > >> +    } else {
> > >> +        summary |=3D RTAS_LOG_DISPOSITION_NOT_RECOVERED;
> > >> +    }
> > >> +
> > >> +    if (SRR1_MC_LOADSTORE(env->spr[SPR_SRR1])) {
> > >> +        for (i =3D 0; mc_derror_table[i].dsisr_value; i++) {
> > >> +            if (!(dsisr & mc_derror_table[i].dsisr_value)) {
> > >> +                continue;
> > >> +            }
> > >> +
> > >> +            ext_elog->mc.error_type =3D mc_derror_table[i].error_ty=
pe;
> > >> +            ext_elog->mc.sub_err_type =3D mc_derror_table[i].error_=
subtype;
> > >> +            if (mc_derror_table[i].dar_valid) {
> > >> +                ext_elog->mc.effective_address =3D cpu_to_be64(env-=
>spr[SPR_DAR]);
> > >> +            }
> > >> +
> > >> +            summary |=3D mc_derror_table[i].initiator
> > >> +                        | mc_derror_table[i].severity;
> > >> +
> > >> +            return summary;
> > >> +        }
> > >> +    } else {
> > >> +        for (i =3D 0; mc_ierror_table[i].srr1_mask; i++) {
> > >> +            if ((env->spr[SPR_SRR1] & mc_ierror_table[i].srr1_mask)=
 !=3D
> > >> +                    mc_ierror_table[i].srr1_value) {
> > >> +                continue;
> > >> +            }
> > >> +
> > >> +            ext_elog->mc.error_type =3D mc_ierror_table[i].error_ty=
pe;
> > >> +            ext_elog->mc.sub_err_type =3D mc_ierror_table[i].error_=
subtype;
> > >> +            if (mc_ierror_table[i].nip_valid) {
> > >> +                ext_elog->mc.effective_address =3D cpu_to_be64(env-=
>nip);
> > >> +            }
> > >> +
> > >> +            summary |=3D mc_ierror_table[i].initiator
> > >> +                        | mc_ierror_table[i].severity;
> > >> +
> > >> +            return summary;
> > >> +        }
> > >> +    }
> > >> +
> > >> +    summary |=3D RTAS_LOG_INITIATOR_CPU;
> > >> +    return summary;
> > >> +}
> > >> +
> > >> +static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
> > >> +{
> > >> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > >> +    CPUState *cs =3D CPU(cpu);
> > >> +    uint64_t rtas_addr;
> > >> +    CPUPPCState *env =3D &cpu->env;
> > >> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > >> +    target_ulong r3, msr =3D 0;
> > >> +    struct rtas_error_log log;
> > >> +    struct mc_extended_log *ext_elog;
> > >> +    uint32_t summary;
> > >> +
> > >> +    /*
> > >> +     * Properly set bits in MSR before we invoke the handler.
> > >> +     * SRR0/1, DAR and DSISR are properly set by KVM
> > >> +     */
> > >> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
> > >> +        msr |=3D (1ULL << MSR_LE);
> > >> +    }
> > >> +
> > >> +    if (env->msr & (1ULL << MSR_SF)) {
> > >> +        msr |=3D (1ULL << MSR_SF);
> > >> +    }
> > >> +
> > >> +    msr |=3D (1ULL << MSR_ME);
> > >> +
> > >> +    if (spapr->guest_machine_check_addr =3D=3D -1) {
> > >> +        /*
> > >> +         * This implies that we have hit a machine check between sy=
stem
> > >> +         * reset and "ibm,nmi-register". Fall back to the old machi=
ne
> > >> +         * check behavior in such cases.
> > >> +         */
> > >> +        env->spr[SPR_SRR0] =3D env->nip;
> > >> +        env->spr[SPR_SRR1] =3D env->msr;
> > >> +        env->msr =3D msr;
> > >> +        env->nip =3D 0x200;
> > >> +        return;
> > >> +    }
> > >> +
> > >> +    ext_elog =3D g_malloc0(sizeof(*ext_elog));
> > >> +    summary =3D spapr_mce_get_elog_type(cpu, recovered, ext_elog);
> > >> +
> > >> +    log.summary =3D cpu_to_be32(summary);
> > >> +    log.extended_length =3D cpu_to_be32(sizeof(*ext_elog));
> > >> +
> > >> +    /* r3 should be in BE always */
> > >> +    r3 =3D cpu_to_be64(env->gpr[3]);
> > >> +    env->msr =3D msr;
> > >> +
> > >> +    spapr_init_v6hdr(&ext_elog->v6hdr);
> > >> +    ext_elog->mc.hdr.section_id =3D cpu_to_be16(RTAS_LOG_V6_SECTION=
_ID_MC);
> > >> +    ext_elog->mc.hdr.section_length =3D
> > >> +                    cpu_to_be16(sizeof(struct rtas_event_log_v6_mc)=
);
> > >> +    ext_elog->mc.hdr.section_version =3D 1;
> > >> +
> > >> +    /* get rtas addr from fdt */
> > >> +    rtas_addr =3D spapr_get_rtas_addr();
> > >> +    if (!rtas_addr) {
> > >> +        /* Unable to fetch rtas_addr. Hence reset the guest */
> > >> +        ppc_cpu_do_system_reset(cs);
> > >> +    }
> > >> +
> > >> +    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET, &r=
3,
> > >> +                              sizeof(r3));
> > >> +    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET + s=
izeof(r3),
> > >> +                              &log, sizeof(log));
> > >> +    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET + s=
izeof(r3) +
> > >> +                              sizeof(log), ext_elog,
> > >> +                              sizeof(*ext_elog));
> > >> +
> > >> +    env->gpr[3] =3D rtas_addr + RTAS_ERROR_LOG_OFFSET;
> > >> +    env->nip =3D spapr->guest_machine_check_addr;
> > >> +
> > >> +    g_free(ext_elog);
> > >> +}
> > >> +
> > >>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
> > >>  {
> > >>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > >> @@ -641,6 +873,10 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool =
recovered)
> > >>          }
> > >>      }
> > >>      spapr->mc_status =3D cpu->vcpu_id;
> > >> +
> > >> +    spapr_mce_dispatch_elog(cpu, recovered);
> > >> +
> > >> +    return; =20
> > >=20
> > > Drop the last two lines. =20
> >=20
> > ok.
> >=20
> > >  =20
> > >>  }
> > >> =20
> > >>  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spa=
pr,
> > >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > >> index fc3a776..c717ab2 100644
> > >> --- a/include/hw/ppc/spapr.h
> > >> +++ b/include/hw/ppc/spapr.h
> > >> @@ -710,6 +710,9 @@ void spapr_load_rtas(SpaprMachineState *spapr, v=
oid *fdt, hwaddr addr);
> > >> =20
> > >>  #define RTAS_ERROR_LOG_MAX      2048
> > >> =20
> > >> +/* Offset from rtas-base where error log is placed */
> > >> +#define RTAS_ERROR_LOG_OFFSET       0x30
> > >> +
> > >>  #define RTAS_EVENT_SCAN_RATE    1
> > >> =20
> > >>  /* This helper should be used to encode interrupt specifiers when t=
he related
> > >> @@ -799,6 +802,7 @@ int spapr_max_server_number(SpaprMachineState *s=
papr);
> > >>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> > >>                        uint64_t pte0, uint64_t pte1);
> > >>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
> > >> +ssize_t spapr_get_rtas_size(ssize_t old_rtas_sizea);
> > >>   =20
> > >=20
> > > Looks like a leftover. =20
> >=20
> > ah.. yes.
> >=20
> > >  =20
> > >>  /* DRC callbacks. */
> > >>  void spapr_core_release(DeviceState *dev);
> > >> =20
> > >  =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz4gVMACgkQbDjKyiDZ
s5Jsmw/+LM7thL79HCKIsEc2ZJgS2yGVwZFMq5OJzS5Wl7+YvhLAJcQQX3ukNLLR
/i8A6JJpUjtQNvfh5I62k3U1ITFqi1qi+9uh/FBZMgYD5ssqPiQsissCFZTnsrLk
kb1Ntno409T6FceYEgvvK1I6DRnjHICnRcDKr73juv05tymJl//uB3PhqibknaPh
6BZqL9ubm5/wApWqM+rxSq0duW8sYSRmDCe0y8uYtSuYBRJgOjlRlEXN6SiCv/W+
Ad/WHE6dB/FnJiGmDkBUSLQsIVQBJd6bqxChsfO0DSxMsQWVYYdNfEVUC23aToNA
frppqQZTMYvhc5BqwYmyxnOpCnmpXxfcahlrUsMFw79WhalHkURjOmE7H4neOMr5
p4O5nax/sh5MGDiWr0xhLYvzMQhaI6E0XfJjI1fJ4tywgJELWioRx6Ybe1LIBDvP
VWWKnEjqE1TIBr62ZhnJU5Xn5hKpvDQKjSzUG6Eg9PJbBoSdp8uAGDAr9sDovvSi
SlsfCiNkZHuf3JEfTeDQrWWMwN65GlBsZKfMJ0mkdXbN6jqiPQOhKYYT80p/NUyy
PcXEnyCwDHdMDyN6sHmZyDacv15haMp75DSk4BdhYoq4uWEm2vjILhFA1a3VBmvV
lgO51jSOf50B27xsYafwUTB/hv09zPJEWSf4PRCquj0HDuOf+H0=
=uK7D
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--

