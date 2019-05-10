Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1D8C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57473217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gSjTjhTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57473217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43421 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5fP-0005EP-IM
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:34:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hP5dP-00046P-V4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hP5dO-0001Z6-8y
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:32:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40097 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hP5dN-0001XQ-5y; Fri, 10 May 2019 09:32:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450rjX5TnYz9sBr; Fri, 10 May 2019 23:32:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557495136;
	bh=C51wn5AT7X10cFwBUwuzjoeQqweqFl7d/ueqaqsTNd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSjTjhTFopdqYNL0xPBncAvArb7IDfvkqWLlVzU/vb8XKj4QauW1D5aHUBi4I2GZw
	8CNK0tDdWnOe/Nh9VkbLTVEQBjzxZDEEdA3b2hB3+uK260GQs4ec6vD3BrY028I/8c
	m59H5LL9x5HlBCiRf9KlFwL6F1CjSXE60HKHteKk=
Date: Fri, 10 May 2019 19:53:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190510095321.GB5030@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591661564.20338.10693276428550708820.stgit@aravinda>
	<20190510064620.GL20559@umbus.fritz.box>
	<fa3f0f81-17bc-ce71-7fa0-e0bc706b3c17@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <fa3f0f81-17bc-ce71-7fa0-e0bc706b3c17@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 5/6] ppc: spapr: Enable FWNMI
 capability
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
Cc: paulus@ozlabs.org, aik@au1.ibm.com, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 12:45:29PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Friday 10 May 2019 12:16 PM, David Gibson wrote:
> > On Mon, Apr 22, 2019 at 12:33:35PM +0530, Aravinda Prasad wrote:
> >> Enable the KVM capability KVM_CAP_PPC_FWNMI so that
> >> the KVM causes guest exit with NMI as exit reason
> >> when it encounters a machine check exception on the
> >> address belonging to a guest. Without this capability
> >> enabled, KVM redirects machine check exceptions to
> >> guest's 0x200 vector.
> >>
> >> This patch also deals with the case when a guest with
> >> the KVM_CAP_PPC_FWNMI capability enabled is attempted
> >> to migrate to a host that does not support this
> >> capability.
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> ---
> >>  hw/ppc/spapr.c         |    1 +
> >>  hw/ppc/spapr_caps.c    |   26 ++++++++++++++++++++++++++
> >>  hw/ppc/spapr_rtas.c    |   14 ++++++++++++++
> >>  include/hw/ppc/spapr.h |    4 +++-
> >>  target/ppc/kvm.c       |   14 ++++++++++++++
> >>  target/ppc/kvm_ppc.h   |    6 ++++++
> >>  6 files changed, 64 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index ffd1715..44e09bb 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -4372,6 +4372,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
> >>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> >>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP=
_ON;
> >>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> >> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> >>      spapr_caps_add_properties(smc, &error_abort);
> >>      smc->irq =3D &spapr_irq_xics;
> >>      smc->dr_phb_enabled =3D true;
> >> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >> index edc5ed0..5b3af04 100644
> >> --- a/hw/ppc/spapr_caps.c
> >> +++ b/hw/ppc/spapr_caps.c
> >> @@ -473,6 +473,22 @@ static void cap_ccf_assist_apply(SpaprMachineStat=
e *spapr, uint8_t val,
> >>      }
> >>  }
> >> =20
> >> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
> >> +                                Error **errp)
> >> +{
> >> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> >> +
> >> +    if (!val) {
> >> +        return; /* Disabled by default */
> >> +    }
> >> +
> >> +    if (kvm_enabled()) {
> >> +        if (kvmppc_fwnmi_enable(cpu)) {
> >> +            error_setg(errp, "Requested fwnmi capability not support =
by KVM");
> >> +        }
> >> +    }
> >> +}
> >> +
> >>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> >>      [SPAPR_CAP_HTM] =3D {
> >>          .name =3D "htm",
> >> @@ -571,6 +587,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NU=
M] =3D {
> >>          .type =3D "bool",
> >>          .apply =3D cap_ccf_assist_apply,
> >>      },
> >> +    [SPAPR_CAP_FWNMI_MCE] =3D {
> >> +        .name =3D "fwnmi-mce",
> >> +        .description =3D "Handle fwnmi machine check exceptions",
> >> +        .index =3D SPAPR_CAP_FWNMI_MCE,
> >> +        .get =3D spapr_cap_get_bool,
> >> +        .set =3D spapr_cap_set_bool,
> >> +        .type =3D "bool",
> >> +        .apply =3D cap_fwnmi_mce_apply,
> >> +    },
> >>  };
> >> =20
> >>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spa=
pr,
> >> @@ -706,6 +731,7 @@ SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
> >>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> >>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
> >>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> >> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
> >> =20
> >>  void spapr_caps_init(SpaprMachineState *spapr)
> >>  {
> >> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >> index d3499f9..997cf19 100644
> >> --- a/hw/ppc/spapr_rtas.c
> >> +++ b/hw/ppc/spapr_rtas.c
> >> @@ -49,6 +49,7 @@
> >>  #include "hw/ppc/fdt.h"
> >>  #include "target/ppc/mmu-hash64.h"
> >>  #include "target/ppc/mmu-book3s-v3.h"
> >> +#include "kvm_ppc.h"
> >> =20
> >>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState=
 *spapr,
> >>                                     uint32_t token, uint32_t nargs,
> >> @@ -354,6 +355,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> >>                                    target_ulong args,
> >>                                    uint32_t nret, target_ulong rets)
> >>  {
> >> +    int ret;
> >>      uint64_t rtas_addr =3D spapr_get_rtas_addr();
> >> =20
> >>      if (!rtas_addr) {
> >> @@ -361,6 +363,18 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> >>          return;
> >>      }
> >> =20
> >> +    ret =3D kvmppc_fwnmi_enable(cpu);
> >=20
> > You shouldn't need this here as well as in cap_fwnmi_mce_apply().
> >=20
> > Instead, you should unconditionally fail the nmi-register if the
> > capability is not enabled.
>=20
> cap_fwnmi is not enabled by default, because if it is enabled by default
> them KVM will start routing machine check exceptions via guest exit
> instead of routing it to guest's 0x200.
>=20
> During early boot since guest has not yet issued nmi-register, KVM is
> expected to route exceptions to 0x200. Therefore we enable cap_fwnmi
> only when a guest issues nmi-register.

Except that's not true - you enable it in cap_fwnmi_mce_apply() which
will be executed whenever the machine capability is enabled.

> Or we should take the approach of enabling this capability by default
> and then from QEMU route the error to 0x200 if guest has not issued
> nmi-register.
>=20
> >=20
> >> +    if (ret =3D=3D 1) {
> >> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> >> +        return;
> >> +    }
> >> +
> >> +    if (ret < 0) {
> >> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> >> +        return;
> >> +    }
> >> +
> >>      spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
> >>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >>  }
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 03f34bf..9d16ad1 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -78,8 +78,10 @@ typedef enum {
> >>  #define SPAPR_CAP_LARGE_DECREMENTER     0x08
> >>  /* Count Cache Flush Assist HW Instruction */
> >>  #define SPAPR_CAP_CCF_ASSIST            0x09
> >> +/* FWNMI machine check handling */
> >> +#define SPAPR_CAP_FWNMI_MCE             0x0A
> >>  /* Num Caps */
> >> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
> >> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI_MCE + 1)
> >> =20
> >>  /*
> >>   * Capability Values
> >> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >> index 5eedce8..9c7b71d 100644
> >> --- a/target/ppc/kvm.c
> >> +++ b/target/ppc/kvm.c
> >> @@ -83,6 +83,7 @@ static int cap_ppc_safe_indirect_branch;
> >>  static int cap_ppc_count_cache_flush_assist;
> >>  static int cap_ppc_nested_kvm_hv;
> >>  static int cap_large_decr;
> >> +static int cap_ppc_fwnmi;
> >> =20
> >>  static uint32_t debug_inst_opcode;
> >> =20
> >> @@ -150,6 +151,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >>      kvmppc_get_cpu_characteristics(s);
> >>      cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_N=
ESTED_HV);
> >>      cap_large_decr =3D kvmppc_get_dec_bits();
> >> +    cap_ppc_fwnmi =3D kvm_check_extension(s, KVM_CAP_PPC_FWNMI);
> >>      /*
> >>       * Note: setting it to false because there is not such capability
> >>       * in KVM at this moment.
> >> @@ -2117,6 +2119,18 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int=
 mpic_proxy)
> >>      }
> >>  }
> >> =20
> >> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
> >> +{
> >> +    CPUState *cs =3D CPU(cpu);
> >> +
> >> +    if (!cap_ppc_fwnmi) {
> >> +        return 1;
> >> +    }
> >> +
> >> +    return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
> >> +}
> >> +
> >> +
> >>  int kvmppc_smt_threads(void)
> >>  {
> >>      return cap_ppc_smt ? cap_ppc_smt : 1;
> >> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> >> index 6edc42f..28919d3 100644
> >> --- a/target/ppc/kvm_ppc.h
> >> +++ b/target/ppc/kvm_ppc.h
> >> @@ -27,6 +27,7 @@ void kvmppc_enable_h_page_init(void);
> >>  void kvmppc_set_papr(PowerPCCPU *cpu);
> >>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
> >>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> >> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu);
> >>  int kvmppc_smt_threads(void);
> >>  void kvmppc_hint_smt_possible(Error **errp);
> >>  int kvmppc_set_smt_threads(int smt);
> >> @@ -159,6 +160,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCC=
PU *cpu, int mpic_proxy)
> >>  {
> >>  }
> >> =20
> >> +static inline int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
> >> +{
> >> +    return 1;
> >> +}
> >> +
> >>  static inline int kvmppc_smt_threads(void)
> >>  {
> >>      return 1;
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzVShEACgkQbDjKyiDZ
s5J9tQ/9H8BowS+J6FZtqjQGq0LENenuKnHIgINi121SvbnE+qubWysnjwjWTUQZ
CEz+4ldFF63OOyCxq3gWOCNWeCK2sXxv7QIN95kIo+Fxysz/KNvB8Lyn3FxjKnVJ
OY2O4vL3WRhRV68kYvpeCZch10A750T5AaHxAPD/JLW5IJ1aj7boM2jYRjyYwdYU
jELU8yqemelxJBkEYGU2d2zOHJCYjYDG8yjfnSEerE5c2pbqHsNfIanZWTotvXIf
pRm7T5H5TE1nMHstBtbLUn5Xi/8PMSgUDwx6SA+pmrjQ/eEACeuLPFJHvohjuysA
soUHJQ3zeQNhjqu4u+bipgYVLLEMiQnfsDvTsoqcY55ytv5fjhaG67W9NmgU7AzO
m/Zol93BFcju8VU0XpqVm/PGWNSv//IfODGi4zojx7t18IrhE9xHKIVJPYEIbgJy
S4w6QOSsSHtVupS1agf5FEBzWrWblc8V2GsiJoSYSQtyXqYB9Y2lLz7PvIQE5gjJ
jC3FdllO8pzdlNLSIU9NSwp0Io4EbMmnUDT2r41y4qldpsasfcUxNgzwOtuO1qu9
3VTmck5LMz4Jdi4zNpuCslrZTkC8N17iA8JV0qXRyjL3KkuCYas8tPT/yvZSr7qI
toCbbBPrtojtGMTRKxwqZUg18wqFuXm09oiSLh8abHRBjTHDkFc=
=uz1v
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--

