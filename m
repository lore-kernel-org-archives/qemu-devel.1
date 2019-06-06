Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52729C28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100D42070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Bj2REvQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100D42070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53535 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYilW-00032L-9P
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 23:08:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYijz-0002Cf-OS
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYijm-0006Vp-Lq
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:06:51 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hYijd-0006FA-Bv; Wed, 05 Jun 2019 23:06:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45K9Xs2hyvz9sND; Thu,  6 Jun 2019 13:06:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559790381;
	bh=jpy6jSu/OIJbLKtjSFWJ+9gGW+a/6YEcQvFoeduAWko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bj2REvQ7ZNAu9S6h8cZIi7ZxXHHW996e2VST9RP9pBgKd9eAakO4UIxe6DKL36k0t
	GR9VvnAEIc8Q7o+TKkyyxl3NNDQOtU7LNUcMkD87CCjGWZYsr0HBdwA3ti7J4NnvRh
	wiz/oGzwOP/+08DZFGMcGrIDzN7uBh968PWD72kQ=
Date: Thu, 6 Jun 2019 13:02:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190606030207.GJ10319@umbus.fritz.box>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
	<155910844950.13149.6460514692958589700.stgit@aravinda>
	<20190603172544.277d0183@bahia.lab.toulouse-stg.fr.ibm.com>
	<0ddfc208-b23a-917c-a155-d2e9666eedde@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/GPgYEyhnw15BExa"
Content-Disposition: inline
In-Reply-To: <0ddfc208-b23a-917c-a155-d2e9666eedde@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v9 5/6] ppc: spapr: Enable FWNMI
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
Cc: aik@au1.ibm.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/GPgYEyhnw15BExa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 12:15:26PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Monday 03 June 2019 08:55 PM, Greg Kurz wrote:
> > On Wed, 29 May 2019 11:10:49 +0530
> > Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> >=20
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
> >=20
> > As suggested in another mail, it may be worth introducing the sPAPR cap
> > in its own patch, earlier in the series.
>=20
> Sure, also as a workaround mentioned in the reply to that mail, I am
> thinking of returning RTAS_OUT_NOT_SUPPORTED to rtas nmi register call
> until the entire functionality is implemented. This will help solve
> spapr cap issue as well.

Not registering the RTAS call at all is the correct way to handle that
case.

>=20
> >=20
> > Anyway, I have some comments below.
> >=20
> >>  hw/ppc/spapr.c         |    1 +
> >>  hw/ppc/spapr_caps.c    |   24 ++++++++++++++++++++++++
> >>  hw/ppc/spapr_rtas.c    |   18 ++++++++++++++++++
> >>  include/hw/ppc/spapr.h |    4 +++-
> >>  target/ppc/kvm.c       |   19 +++++++++++++++++++
> >>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
> >>  6 files changed, 77 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index c97f6a6..e8a77636 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -4364,6 +4364,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
> >>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> >>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP=
_ON;
> >>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> >> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_ON;
> >>      spapr_caps_add_properties(smc, &error_abort);
> >>      smc->irq =3D &spapr_irq_dual;
> >>      smc->dr_phb_enabled =3D true;
> >> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >> index 31b4661..ef9e612 100644
> >> --- a/hw/ppc/spapr_caps.c
> >> +++ b/hw/ppc/spapr_caps.c
> >> @@ -479,6 +479,20 @@ static void cap_ccf_assist_apply(SpaprMachineStat=
e *spapr, uint8_t val,
> >>      }
> >>  }
> >> =20
> >> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
> >> +                                Error **errp)
> >> +{
> >> +    if (!val) {
> >> +        return; /* Disabled by default */
> >> +    }
> >> +
> >> +    if (tcg_enabled()) {
> >> +            error_setg(errp, "No fwnmi support in TCG, try cap-fwnmi-=
mce=3Doff");
> >=20
> > Maybe expand "fwnmi" to "Firmware Assisted Non-Maskable Interrupts" ?
>=20
> sure..
>=20
> >=20
> >> +    } else if (kvm_enabled() && !kvmppc_has_cap_ppc_fwnmi()) {
> >> +            error_setg(errp, "Requested fwnmi capability not support =
by KVM");
> >=20
> > Maybe reword and add a hint:
> >=20
> > "KVM implementation does not support Firmware Assisted Non-Maskable Int=
errupts, try cap-fwnmi-mce=3Doff"
>=20
> sure..
>=20
> >=20
> >=20
> >> +    }
> >> +}
> >> +
> >>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> >>      [SPAPR_CAP_HTM] =3D {
> >>          .name =3D "htm",
> >> @@ -578,6 +592,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NU=
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
> >> @@ -717,6 +740,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT=
_MAXPAGESIZE);
> >>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> >>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
> >>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> >> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
> >> =20
> >>  void spapr_caps_init(SpaprMachineState *spapr)
> >>  {
> >> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >> index e0bdfc8..91a7ab9 100644
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
> >> @@ -358,6 +359,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> >>                                    target_ulong args,
> >>                                    uint32_t nret, target_ulong rets)
> >>  {
> >> +    int ret;
> >>      hwaddr rtas_addr =3D spapr_get_rtas_addr();
> >> =20
> >>      if (!rtas_addr) {
> >> @@ -365,6 +367,22 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> >>          return;
> >>      }
> >> =20
> >> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D 0) {
> >> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> >> +        return;
> >> +    }
> >> +
> >> +    ret =3D kvmppc_fwnmi_enable(cpu);
> >> +    if (ret =3D=3D 1) {
> >=20
> > I have the impression that this should really not happen,
> > otherwise something has gone terribly wrong in QEMU or
> > in KVM... this maybe deserves an error message as well ?
> > No big deal.
>=20
> I think so..  will add an error message.

Right, and because this is essentially a host side error,
RTAS_OUT_HW_ERROR would be more appropriate.

>=20
> Also I should check for non zero return value, not just ret =3D=3D 1, as
> kvmppc_fwnmi_enable() returns the error value from ioctl().
>=20
>=20
> >=20
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
> >> index c717ab2..bd75d4b 100644
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
> >> index 39f1a73..368ec6e 100644
> >> --- a/target/ppc/kvm.c
> >> +++ b/target/ppc/kvm.c
> >> @@ -84,6 +84,7 @@ static int cap_ppc_safe_indirect_branch;
> >>  static int cap_ppc_count_cache_flush_assist;
> >>  static int cap_ppc_nested_kvm_hv;
> >>  static int cap_large_decr;
> >> +static int cap_ppc_fwnmi;
> >> =20
> >>  static uint32_t debug_inst_opcode;
> >> =20
> >> @@ -152,6 +153,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >>      kvmppc_get_cpu_characteristics(s);
> >>      cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_N=
ESTED_HV);
> >>      cap_large_decr =3D kvmppc_get_dec_bits();
> >> +    cap_ppc_fwnmi =3D kvm_check_extension(s, KVM_CAP_PPC_FWNMI);
> >>      /*
> >>       * Note: setting it to false because there is not such capability
> >>       * in KVM at this moment.
> >> @@ -2119,6 +2121,18 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int=
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
> >> @@ -2419,6 +2433,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
> >>      return cap_mmu_hash_v3;
> >>  }
> >> =20
> >> +bool kvmppc_has_cap_ppc_fwnmi(void)
> >> +{
> >> +    return cap_ppc_fwnmi;
> >> +}
> >> +
> >>  static bool kvmppc_power8_host(void)
> >>  {
> >>      bool ret =3D false;
> >> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> >> index 18693f1..3d9f0b4 100644
> >> --- a/target/ppc/kvm_ppc.h
> >> +++ b/target/ppc/kvm_ppc.h
> >> @@ -27,6 +27,8 @@ void kvmppc_enable_h_page_init(void);
> >>  void kvmppc_set_papr(PowerPCCPU *cpu);
> >>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
> >>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> >> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu);
> >> +bool kvmppc_has_cap_ppc_fwnmi(void);
> >>  int kvmppc_smt_threads(void);
> >>  void kvmppc_hint_smt_possible(Error **errp);
> >>  int kvmppc_set_smt_threads(int smt);
> >> @@ -160,6 +162,16 @@ static inline void kvmppc_set_mpic_proxy(PowerPCC=
PU *cpu, int mpic_proxy)
> >>  {
> >>  }
> >> =20
> >> +static inline int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
> >> +{
> >> +    return 1;
> >> +}
> >> +
> >> +static inline bool kvmppc_has_cap_ppc_fwnmi(void)
> >> +{
> >> +    return false;
> >> +}
> >> +
> >>  static inline int kvmppc_smt_threads(void)
> >>  {
> >>      return 1;
> >>
> >>
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/GPgYEyhnw15BExa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz4gi8ACgkQbDjKyiDZ
s5Ja2hAAttPt236QKJgabDL60ZsNvzjDG1/4rxKhS2f/3jVrKABD7gXFJThGsOkg
9b4iEYu+vHoihwrX84XjUwMgGKFSrlb9jaegzZEyyJBr1Vs2bf7uBWtv4hFiN/yo
OTHIQcRyCKaqTMnmBMcpMVA+UUPePFGJRWszPsSI9rfWRZNDfnPlw0xpLYq4zO/Y
xaab59Rqq62if6SbnNxZDyfBOmOwStptrTfOYskreG4fi6BpFkcQmvb5JIZJJRx5
UAclStY9ZXSrbKocQ9W9ZlhttfeRYZyAboAEeq1x3l7ohRO9CqcbDYpMjTpNiFu/
cdJwTANyKqSCoWs+keR6cOiG2VpKgUpEzpsYpT+2fZuYviDj959K8ySuiIEAuLS5
PttPtknz0kHbF3ed6UbifvmKtCMUdHV4XY8rJYYyfbH7ge8EA8KmS15bXEyX1rNY
rPLmf1GGfbDjuNFoHKe0BwIgL+tsOlVeHdXxxzjvLIy4GkwMmcHJzePe7xKfe2/s
D9yxjQEg8gIflF+YNkidp0G4Ok88qYAlEcgXe5DOtEejc6cyRtn+pglL7pW/LFkR
ngdiMw618uoSjqw1b4/8WFA2REsSLnp/D2X2BK8oJdgYbfYcQdDNWQYFz+9WbivR
IqfVTl4BjQtZ7wpAxvPLsT2BckqC4XLuwg2jTyfN0WMrOpp4QH0=
=42/3
-----END PGP SIGNATURE-----

--/GPgYEyhnw15BExa--

