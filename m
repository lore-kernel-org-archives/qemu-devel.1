Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96198C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 01:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527D422310
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 01:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Cu4mSKpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527D422310
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWseV-0008TE-CT
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 20:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iWsdi-0007wY-2E
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 20:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iWsdd-0004t1-VQ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 20:49:09 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:38085 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iWsdc-0004r6-Kc; Mon, 18 Nov 2019 20:49:05 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47H7z01jVYz9sPZ; Tue, 19 Nov 2019 12:49:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574128140;
 bh=LfsWnn6zwutVIgu0ui6ovtiiuqrBtEZwXBxn5fKxFBk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cu4mSKpoPN8CGR6eSvm3fcqY86JmzxOQ8knoo+A3tRc74AZTCoj/QIdyS6DiqQEMX
 CEfxw4VYLk81Fl8YaIiUPa8qK8tB+K4JaRZTZ18JBc/TKP2Z3jUq0drswZ2il0l8Ul
 rNj/fCnz6mETfTdKvlmvb1xnpF1DvV/5LLANqn3o=
Date: Tue, 19 Nov 2019 12:18:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v17 4/7] target/ppc: Build rtas error log upon an MCE
Message-ID: <20191119011840.GK5582@umbus.fritz.box>
References: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
 <20191024074307.22821-5-ganeshgr@linux.ibm.com>
 <20191104161054.GH3552@umbus.metropole.lan>
 <e095aac0-949e-6f5e-ecac-bcc25802a8c5@linux.ibm.com>
 <4a66ff89-6078-f0ed-9c3a-cd597f9382ee@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="apbmkPN6Hu/1dI3g"
Content-Disposition: inline
In-Reply-To: <4a66ff89-6078-f0ed-9c3a-cd597f9382ee@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--apbmkPN6Hu/1dI3g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 04:39:16PM +0530, Ganesh wrote:
>=20
> On 11/6/19 4:37 PM, Ganesh wrote:
> >=20
> > On 11/4/19 9:40 PM, David Gibson wrote:
> > > On Thu, Oct 24, 2019 at 01:13:04PM +0530, Ganesh Goudar wrote:
> > > > From: Aravinda Prasad <arawinda.p@gmail.com>
> > > >=20
> > > > Upon a machine check exception (MCE) in a guest address space,
> > > > KVM causes a guest exit to enable QEMU to build and pass the
> > > > error to the guest in the PAPR defined rtas error log format.
> > > >=20
> > > > This patch builds the rtas error log, copies it to the rtas_addr
> > > > and then invokes the guest registered machine check handler. The
> > > > handler in the guest takes suitable action(s) depending on the type
> > > > and criticality of the error. For example, if an error is
> > > > unrecoverable memory corruption in an application inside the
> > > > guest, then the guest kernel sends a SIGBUS to the application.
> > > > For recoverable errors, the guest performs recovery actions and
> > > > logs the error.
> > > >=20
> > > > [Assume SLOF has allocated enough room for rtas error log]
> > > Is that correct with the SLOF image currently included in qemu?
> > Yes
> > >=20
> > > Apart from that detail,
> > >=20
> > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Hi David, Please see if this patch series can be merged to 4.2.

Sorry, we're much too late for 4.2 now.  I am hoping to merge it for
5.0, the next release.

> > >=20
> > > > Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> > > > Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> > >=20
> > >=20
> > > > ---
> > > > =A0 hw/ppc/spapr_events.c=A0 | 220
> > > > ++++++++++++++++++++++++++++++++++++++++-
> > > > =A0 hw/ppc/spapr_rtas.c=A0=A0=A0 |=A0 26 +++++
> > > > =A0 include/hw/ppc/spapr.h |=A0=A0 6 +-
> > > > =A0 target/ppc/kvm.c=A0=A0=A0=A0=A0=A0 |=A0=A0 4 +-
> > > > =A0 4 files changed, 253 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> > > > index 0ce96b86be..db44e09154 100644
> > > > --- a/hw/ppc/spapr_events.c
> > > > +++ b/hw/ppc/spapr_events.c
> > > > @@ -214,6 +214,104 @@ struct hp_extended_log {
> > > > =A0=A0=A0=A0=A0 struct rtas_event_log_v6_hp hp;
> > > > =A0 } QEMU_PACKED;
> > > > =A0 +struct rtas_event_log_v6_mc {
> > > > +#define RTAS_LOG_V6_SECTION_ID_MC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0x4D43 /* MC */
> > > > +=A0=A0=A0 struct rtas_event_log_v6_section_header hdr;
> > > > +=A0=A0=A0 uint32_t fru_id;
> > > > +=A0=A0=A0 uint32_t proc_id;
> > > > +=A0=A0=A0 uint8_t error_type;
> > > > +#define RTAS_LOG_V6_MC_TYPE_UE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
> > > > +#define RTAS_LOG_V6_MC_TYPE_SLB=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
> > > > +#define RTAS_LOG_V6_MC_TYPE_ERAT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
> > > > +#define RTAS_LOG_V6_MC_TYPE_TLB=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4
> > > > +#define RTAS_LOG_V6_MC_TYPE_D_CACHE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5
> > > > +#define RTAS_LOG_V6_MC_TYPE_I_CACHE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 7
> > > > +=A0=A0=A0 uint8_t sub_err_type;
> > > > +#define RTAS_LOG_V6_MC_UE_INDETERMINATE=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0
> > > > +#define RTAS_LOG_V6_MC_UE_IFETCH=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
> > > > +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH=A0=A0=A0=A0=A0=A0=
=A0=A0 2
> > > > +#define RTAS_LOG_V6_MC_UE_LOAD_STORE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3
> > > > +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE=A0=A0=A0=A0 4
> > > > +#define RTAS_LOG_V6_MC_SLB_PARITY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
> > > > +#define RTAS_LOG_V6_MC_SLB_MULTIHIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
> > > > +#define RTAS_LOG_V6_MC_SLB_INDETERMINATE=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 2
> > > > +#define RTAS_LOG_V6_MC_ERAT_PARITY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
> > > > +#define RTAS_LOG_V6_MC_ERAT_MULTIHIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
> > > > +#define RTAS_LOG_V6_MC_ERAT_INDETERMINATE=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 3
> > > > +#define RTAS_LOG_V6_MC_TLB_PARITY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1
> > > > +#define RTAS_LOG_V6_MC_TLB_MULTIHIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
> > > > +#define RTAS_LOG_V6_MC_TLB_INDETERMINATE=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 3
> > > > +=A0=A0=A0 uint8_t reserved_1[6];
> > > > +=A0=A0=A0 uint64_t effective_address;
> > > > +=A0=A0=A0 uint64_t logical_address;
> > > > +} QEMU_PACKED;
> > > > +
> > > > +struct mc_extended_log {
> > > > +=A0=A0=A0 struct rtas_event_log_v6 v6hdr;
> > > > +=A0=A0=A0 struct rtas_event_log_v6_mc mc;
> > > > +} QEMU_PACKED;
> > > > +
> > > > +struct MC_ierror_table {
> > > > +=A0=A0=A0 unsigned long srr1_mask;
> > > > +=A0=A0=A0 unsigned long srr1_value;
> > > > +=A0=A0=A0 bool nip_valid; /* nip is a valid indicator of faulting =
address */
> > > > +=A0=A0=A0 uint8_t error_type;
> > > > +=A0=A0=A0 uint8_t error_subtype;
> > > > +=A0=A0=A0 unsigned int initiator;
> > > > +=A0=A0=A0 unsigned int severity;
> > > > +};
> > > > +
> > > > +static const struct MC_ierror_table mc_ierror_table[] =3D {
> > > > +{ 0x00000000081c0000, 0x0000000000040000, true,
> > > > +=A0 RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_IFETCH,
> > > > +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > > > +{ 0x00000000081c0000, 0x0000000000080000, true,
> > > > +=A0 RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
> > > > +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > > > +{ 0x00000000081c0000, 0x00000000000c0000, true,
> > > > +=A0 RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,
> > > > +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > > > +{ 0x00000000081c0000, 0x0000000000100000, true,
> > > > +=A0 RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
> > > > +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > > > +{ 0x00000000081c0000, 0x0000000000140000, true,
> > > > +=A0 RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
> > > > +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > > > +{ 0x00000000081c0000, 0x0000000000180000, true,
> > > > +=A0 RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFET=
CH,
> > > > +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, } };
> > > > +
> > > > +struct MC_derror_table {
> > > > +=A0=A0=A0 unsigned long dsisr_value;
> > > > +=A0=A0=A0 bool dar_valid; /* dar is a valid indicator of faulting =
address */
> > > > +=A0=A0=A0 uint8_t error_type;
> > > > +=A0=A0=A0 uint8_t error_subtype;
> > > > +=A0=A0=A0 unsigned int initiator;
> > > > +=A0=A0=A0 unsigned int severity;
> > > > +};
> > > > +
> > > > +static const struct MC_derror_table mc_derror_table[] =3D {
> > > > +{ 0x00008000, false,
> > > > +=A0 RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_LOAD_STORE,
> > > > +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > > > +{ 0x00004000, true,
> > > > +=A0 RTAS_LOG_V6_MC_TYPE_UE,
> > > > RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE,
> > > > +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > > > +{ 0x00000800, true,
> > > > +=A0 RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
> > > > +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > > > +{ 0x00000400, true,
> > > > +=A0 RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
> > > > +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > > > +{ 0x00000080, true,
> > > > +=A0 RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,=A0 /*
> > > > Before PARITY */
> > > > +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
> > > > +{ 0x00000100, true,
> > > > +=A0 RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
> > > > +=A0 RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, } };
> > > > +
> > > > +#define SRR1_MC_LOADSTORE(srr1) ((srr1) & PPC_BIT(42))
> > > > +
> > > > =A0 typedef enum EventClass {
> > > > =A0=A0=A0=A0=A0 EVENT_CLASS_INTERNAL_ERRORS=A0=A0=A0=A0 =3D 0,
> > > > =A0=A0=A0=A0=A0 EVENT_CLASS_EPOW=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D 1,
> > > > @@ -622,7 +720,125 @@ void
> > > > spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 RTAS_LOG_V6_HP_ACTION_REMOVE,
> > > > drc_type, &drc_id);
> > > > =A0 }
> > > > =A0 -void spapr_mce_req_event(PowerPCCPU *cpu)
> > > > +static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool
> > > > recovered,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct mc_extended_log
> > > > *ext_elog)
> > > > +{
> > > > +=A0=A0=A0 int i;
> > > > +=A0=A0=A0 CPUPPCState *env =3D &cpu->env;
> > > > +=A0=A0=A0 uint32_t summary;
> > > > +=A0=A0=A0 uint64_t dsisr =3D env->spr[SPR_DSISR];
> > > > +
> > > > +=A0=A0=A0 summary =3D RTAS_LOG_VERSION_6 | RTAS_LOG_OPTIONAL_PART_=
PRESENT;
> > > > +=A0=A0=A0 if (recovered) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 summary |=3D RTAS_LOG_DISPOSITION_FULLY_RECO=
VERED;
> > > > +=A0=A0=A0 } else {
> > > > +=A0=A0=A0=A0=A0=A0=A0 summary |=3D RTAS_LOG_DISPOSITION_NOT_RECOVE=
RED;
> > > > +=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0 if (SRR1_MC_LOADSTORE(env->spr[SPR_SRR1])) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < ARRAY_SIZE(mc_derror_table=
); i++) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!(dsisr & mc_derror_table[i]=
=2Edsisr_value)) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ext_elog->mc.error_type =3D mc_d=
error_table[i].error_type;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ext_elog->mc.sub_err_type =3D
> > > > mc_derror_table[i].error_subtype;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (mc_derror_table[i].dar_valid=
) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ext_elog->mc.effecti=
ve_address =3D
> > > > cpu_to_be64(env->spr[SPR_DAR]);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 summary |=3D mc_derror_table[i].=
initiator
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | mc_derror_table[i].severity;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return summary;
> > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > +=A0=A0=A0 } else {
> > > > +=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < ARRAY_SIZE(mc_ierror_table=
); i++) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((env->spr[SPR_SRR1] & mc_ier=
ror_table[i].srr1_mask) !=3D
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mc_ierro=
r_table[i].srr1_value) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ext_elog->mc.error_type =3D mc_i=
error_table[i].error_type;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ext_elog->mc.sub_err_type =3D
> > > > mc_ierror_table[i].error_subtype;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (mc_ierror_table[i].nip_valid=
) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ext_elog->mc.effecti=
ve_address =3D
> > > > cpu_to_be64(env->nip);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 summary |=3D mc_ierror_table[i].=
initiator
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | mc_ierror_table[i].severity;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return summary;
> > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > +=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0 summary |=3D RTAS_LOG_INITIATOR_CPU;
> > > > +=A0=A0=A0 return summary;
> > > > +}
> > > > +
> > > > +static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovere=
d)
> > > > +{
> > > > +=A0=A0=A0 SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_mach=
ine());
> > > > +=A0=A0=A0 CPUState *cs =3D CPU(cpu);
> > > > +=A0=A0=A0 uint64_t rtas_addr;
> > > > +=A0=A0=A0 CPUPPCState *env =3D &cpu->env;
> > > > +=A0=A0=A0 PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > > > +=A0=A0=A0 target_ulong msr =3D 0;
> > > > +=A0=A0=A0 struct rtas_error_log log;
> > > > +=A0=A0=A0 struct mc_extended_log *ext_elog;
> > > > +=A0=A0=A0 uint32_t summary;
> > > > +
> > > > +=A0=A0=A0 /*
> > > > +=A0=A0=A0=A0 * Properly set bits in MSR before we invoke the handl=
er.
> > > > +=A0=A0=A0=A0 * SRR0/1, DAR and DSISR are properly set by KVM
> > > > +=A0=A0=A0=A0 */
> > > > +=A0=A0=A0 if (!(*pcc->interrupts_big_endian)(cpu)) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 msr |=3D (1ULL << MSR_LE);
> > > > +=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0 if (env->msr & (1ULL << MSR_SF)) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 msr |=3D (1ULL << MSR_SF);
> > > > +=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0 msr |=3D (1ULL << MSR_ME);
> > > > +
> > > > +=A0=A0=A0 ext_elog =3D g_malloc0(sizeof(*ext_elog));
> > > > +=A0=A0=A0 summary =3D spapr_mce_get_elog_type(cpu, recovered, ext_=
elog);
> > > > +
> > > > +=A0=A0=A0 log.summary =3D cpu_to_be32(summary);
> > > > +=A0=A0=A0 log.extended_length =3D cpu_to_be32(sizeof(*ext_elog));
> > > > +
> > > > +=A0=A0=A0 spapr_init_v6hdr(&ext_elog->v6hdr);
> > > > +=A0=A0=A0 ext_elog->mc.hdr.section_id =3D
> > > > cpu_to_be16(RTAS_LOG_V6_SECTION_ID_MC);
> > > > +=A0=A0=A0 ext_elog->mc.hdr.section_length =3D
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_to_b=
e16(sizeof(struct rtas_event_log_v6_mc));
> > > > +=A0=A0=A0 ext_elog->mc.hdr.section_version =3D 1;
> > > > +
> > > > +=A0=A0=A0 /* get rtas addr from fdt */
> > > > +=A0=A0=A0 rtas_addr =3D spapr_get_rtas_addr();
> > > > +=A0=A0=A0 if (!rtas_addr) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 /* Unable to fetch rtas_addr. Hence reset th=
e guest */
> > > > +=A0=A0=A0=A0=A0=A0=A0 ppc_cpu_do_system_reset(cs);
> > > > +=A0=A0=A0=A0=A0=A0=A0 g_free(ext_elog);
> > > > +=A0=A0=A0=A0=A0=A0=A0 return;
> > > > +=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0 stq_be_phys(&address_space_memory, rtas_addr +
> > > > RTAS_ERROR_LOG_OFFSET,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 env->gpr[3]);
> > > > +=A0=A0=A0 cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFF=
SET +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 sizeof(env->gpr[3]), &log, sizeof(log));
> > > > +=A0=A0=A0 cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFF=
SET +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 sizeof(env->gpr[3]) +
> > > > sizeof(log), ext_elog,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 sizeof(*ext_elog));
> > > > +
> > > > +=A0=A0=A0 env->gpr[3] =3D rtas_addr + RTAS_ERROR_LOG_OFFSET;
> > > > +=A0=A0=A0 env->msr =3D msr;
> > > > +=A0=A0=A0 env->nip =3D spapr->guest_machine_check_addr;
> > > > +
> > > > +=A0=A0=A0 g_free(ext_elog);
> > > > +}
> > > > +
> > > > +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
> > > > =A0 {
> > > > =A0=A0=A0=A0=A0 SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get=
_machine());
> > > > =A0=A0=A0=A0=A0 CPUState *cs =3D CPU(cpu);
> > > > @@ -656,6 +872,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > =A0=A0=A0=A0=A0 }
> > > > =A0=A0=A0=A0=A0 spapr->mc_status =3D cpu->vcpu_id;
> > > > +
> > > > +=A0=A0=A0 spapr_mce_dispatch_elog(cpu, recovered);
> > > > =A0 }
> > > > =A0 =A0 static void check_exception(PowerPCCPU *cpu,
> > > > SpaprMachineState *spapr,
> > > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > > index 8d8d8cdfcb..2c066a372d 100644
> > > > --- a/hw/ppc/spapr_rtas.c
> > > > +++ b/hw/ppc/spapr_rtas.c
> > > > @@ -477,6 +477,32 @@ void spapr_dt_rtas_tokens(void *fdt, int rtas)
> > > > =A0=A0=A0=A0=A0 }
> > > > =A0 }
> > > > =A0 +hwaddr spapr_get_rtas_addr(void)
> > > > +{
> > > > +=A0=A0=A0 SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_mach=
ine());
> > > > +=A0=A0=A0 int rtas_node;
> > > > +=A0=A0=A0 const fdt32_t *rtas_data;
> > > > +=A0=A0=A0 void *fdt =3D spapr->fdt_blob;
> > > > +
> > > > +=A0=A0=A0 /* fetch rtas addr from fdt */
> > > > +=A0=A0=A0 rtas_node =3D fdt_path_offset(fdt, "/rtas");
> > > > +=A0=A0=A0 if (rtas_node < 0) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > +=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0 rtas_data =3D fdt_getprop(fdt, rtas_node, "linux,rtas-ba=
se", NULL);
> > > > +=A0=A0=A0 if (!rtas_data) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > +=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0 /*
> > > > +=A0=A0=A0=A0 * We assume that the OS called RTAS instantiate-rtas,=
 but
> > > > some other
> > > > +=A0=A0=A0=A0 * OS might call RTAS instantiate-rtas-64 instead. This
> > > > fine as of now
> > > > +=A0=A0=A0=A0 * as SLOF only supports 32-bit variant.
> > > > +=A0=A0=A0=A0 */
> > > > +=A0=A0=A0 return (hwaddr)fdt32_to_cpu(*rtas_data);
> > > > +}
> > > > +
> > > > =A0 static void core_rtas_register_types(void)
> > > > =A0 {
> > > > =A0=A0=A0=A0=A0 spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "displa=
y-character",
> > > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > > index 1f5eb8c856..4afa8d4d09 100644
> > > > --- a/include/hw/ppc/spapr.h
> > > > +++ b/include/hw/ppc/spapr.h
> > > > @@ -724,6 +724,9 @@ void spapr_load_rtas(SpaprMachineState
> > > > *spapr, void *fdt, hwaddr addr);
> > > > =A0 =A0 #define RTAS_ERROR_LOG_MAX=A0=A0=A0=A0=A0 2048
> > > > =A0 +/* Offset from rtas-base where error log is placed */
> > > > +#define RTAS_ERROR_LOG_OFFSET=A0=A0=A0=A0=A0=A0 0x30
> > > > +
> > > > =A0 #define RTAS_EVENT_SCAN_RATE=A0=A0=A0 1
> > > > =A0 =A0 /* This helper should be used to encode interrupt specifiers
> > > > when the related
> > > > @@ -812,7 +815,7 @@ void
> > > > spapr_clear_pending_events(SpaprMachineState *spapr);
> > > > =A0 int spapr_max_server_number(SpaprMachineState *spapr);
> > > > =A0 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 uint64_t pte0, uint64_t pte1);
> > > > -void spapr_mce_req_event(PowerPCCPU *cpu);
> > > > +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
> > > > =A0 =A0 /* DRC callbacks. */
> > > > =A0 void spapr_core_release(DeviceState *dev);
> > > > @@ -903,4 +906,5 @@ void spapr_check_pagesize(SpaprMachineState
> > > > *spapr, hwaddr pagesize,
> > > > =A0 #define SPAPR_OV5_XIVE_BOTH=A0=A0=A0=A0 0x80 /* Only to adverti=
se on
> > > > the platform */
> > > > =A0 =A0 void spapr_set_all_lpcrs(target_ulong value, target_ulong m=
ask);
> > > > +hwaddr spapr_get_rtas_addr(void);
> > > > =A0 #endif /* HW_SPAPR_H */
> > > > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > > > index 2d8db6d832..9a902c1064 100644
> > > > --- a/target/ppc/kvm.c
> > > > +++ b/target/ppc/kvm.c
> > > > @@ -2805,9 +2805,11 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
> > > > =A0 =A0 int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
> > > > =A0 {
> > > > +=A0=A0=A0 bool recovered =3D run->flags & KVM_RUN_PPC_NMI_DISP_FUL=
LY_RECOV;
> > > > +
> > > > =A0=A0=A0=A0=A0 cpu_synchronize_state(CPU(cpu));
> > > > =A0 -=A0=A0=A0 spapr_mce_req_event(cpu);
> > > > +=A0=A0=A0 spapr_mce_req_event(cpu, recovered);
> > > > =A0 =A0=A0=A0=A0=A0 return 0;
> > > > =A0 }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--apbmkPN6Hu/1dI3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3TQvAACgkQbDjKyiDZ
s5IArBAAu3GDcgNywHBDqMm2/OBRNCLmTinvx2Aocxur2ZPGuAatdmhJjScUf9Qn
JR4al70iWhFhSqDJxzbh3+VkkEXs+go0Droar6jptdcPjibxpnBeknpQHcLkWA1J
j+pFMZ9B73XQ2T4AbSRYu2vYvGTJxJsmktuMRilkGDbB8strwHYJvnuqkrQar1dR
U66D66RJAygE++EndZ/vaHMpoXTTtTvNsqJzGQcpGMWyH9m7lU54to7gH5xfj7ij
KCtkQ+8zD2KHk84fxLHN8/NaeoSS3ojqRW81sXgy07TlahsD/TQdg/A76wXthDFW
/VR4b5eanazMULPWgp9jiasf8pIw8uO12frjZfTkatrSlO8P6wHzd8Fhvr5EHmQf
PBTiHDoU7K6SUvUJHu0PpV6+pMkVWIhV4uwC2x7szuV41I+iFYPY4Y680sxlMxBN
uYkrptbhDToYSyJ8D+mAIbR02ZwMBQ2eFxXRJD7URcDM2INhVQK9fn0IEzv28tyy
kk6EPUUyQb3NZpQtLFjeXYn0tIoeg/xO6ZmfocPEgBf2igNqc8T59k2Xr6QHyIFP
9iLUS+3/F+jMviy1/NWq3293ngKxnuDkcm3mUaiW6i6sN/ysK617DNsQeMhRGD0G
AlN15REYEV+ryDaMhmQvy9yx1wMjbOiTj6UV3RSwAkghut7fcW0=
=ABq3
-----END PGP SIGNATURE-----

--apbmkPN6Hu/1dI3g--

