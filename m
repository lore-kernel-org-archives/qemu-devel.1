Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382D1C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FC720874
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZPdttV6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FC720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCwJo-0007NF-L3
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 21:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iCwHb-0005TY-MO
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iCwHZ-0003I3-Sf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:39:55 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34579 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iCwHY-0003HC-Vk; Tue, 24 Sep 2019 21:39:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dLMm5V4Fz9sP3; Wed, 25 Sep 2019 11:39:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569375588;
 bh=vLIdMJoa28jg7ayQKBwl2iYEf8kLES4gg4S0wfVpObo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZPdttV6ziF0GISKp7Rt9d7d2mpl92F5757A3IWb+2Oy3YPmcd5n/XSs2qu4ST9BD7
 pkf/4/lqTGEmRg6UQuYxJVVX8xUw3J6IF/jK9zRr+pruZN13EHwWPh58HQoNplJrqk
 T+/1Ge9ip4MmhGs3tfSJQUSU3maz7eVTb0t3oBuw=
Date: Wed, 25 Sep 2019 11:12:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Subject: Re: [PATCH v14 2/7] ppc: spapr: Introduce FWNMI capability
Message-ID: <20190925011200.GF17405@umbus>
References: <156879398718.18368.17640174821710157715.stgit@aravinda>
 <156879433743.18368.1281417894007921022.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline
In-Reply-To: <156879433743.18368.1281417894007921022.stgit@aravinda>
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 01:42:17PM +0530, Aravinda Prasad wrote:
> Introduce the KVM capability KVM_CAP_PPC_FWNMI so that
> the KVM causes guest exit with NMI as exit reason
> when it encounters a machine check exception on the
> address belonging to a guest. Without this capability
> enabled, KVM redirects machine check exceptions to
> guest's 0x200 vector.
>=20
> This patch also introduces fwnmi-mce capability to
> deal with the case when a guest with the
> KVM_CAP_PPC_FWNMI capability enabled is attempted
> to migrate to a host that does not support this
> capability.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

Mostly ok, but there's one ugly problem.

> ---
>  hw/ppc/spapr.c         |    1 +
>  hw/ppc/spapr_caps.c    |   29 +++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |    4 +++-
>  target/ppc/kvm.c       |   26 ++++++++++++++++++++++++++
>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
>  5 files changed, 71 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ea56499..8288e8b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4487,6 +4487,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 481dfd2..c11ff87 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -496,6 +496,25 @@ static void cap_ccf_assist_apply(SpaprMachineState *=
spapr, uint8_t val,
>      }
>  }
> =20
> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
> +                                Error **errp)
> +{
> +    if (!val) {
> +        return; /* Disabled by default */
> +    }
> +
> +    if (tcg_enabled()) {
> +        /*
> +         * TCG support may not be correct in some conditions (e.g., in c=
ase
> +         * of software injected faults like duplicate SLBs).
> +         */
> +        warn_report("Firmware Assisted Non-Maskable Interrupts not suppo=
rted in TCG");
> +    } else if (kvm_enabled() && !kvmppc_has_cap_ppc_fwnmi()) {
> +        error_setg(errp,
> +"Firmware Assisted Non-Maskable Interrupts not supported by KVM, try cap=
-fwnmi-mce=3Doff");
> +    }
> +}
> +
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
> @@ -595,6 +614,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "bool",
>          .apply =3D cap_ccf_assist_apply,
>      },
> +    [SPAPR_CAP_FWNMI_MCE] =3D {
> +        .name =3D "fwnmi-mce",
> +        .description =3D "Handle fwnmi machine check exceptions",
> +        .index =3D SPAPR_CAP_FWNMI_MCE,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
> +        .apply =3D cap_fwnmi_mce_apply,
> +    },
>  };
> =20
>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
> @@ -734,6 +762,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MA=
XPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
> =20
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 03111fd..66049ac 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -79,8 +79,10 @@ typedef enum {
>  #define SPAPR_CAP_LARGE_DECREMENTER     0x08
>  /* Count Cache Flush Assist HW Instruction */
>  #define SPAPR_CAP_CCF_ASSIST            0x09
> +/* FWNMI machine check handling */
> +#define SPAPR_CAP_FWNMI_MCE             0x0A
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI_MCE + 1)
> =20
>  /*
>   * Capability Values
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8c5b1f2..8b1ab78 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -85,6 +85,7 @@ static int cap_ppc_safe_indirect_branch;
>  static int cap_ppc_count_cache_flush_assist;
>  static int cap_ppc_nested_kvm_hv;
>  static int cap_large_decr;
> +static int cap_ppc_fwnmi;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -2055,6 +2056,26 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mp=
ic_proxy)
>      }
>  }
> =20
> +int kvmppc_set_fwnmi(void)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +    CPUState *cs =3D CPU(cpu);
> +    int ret;
> +
> +    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
> +    if (ret) {
> +        error_report("This KVM version does not support FWNMI");
> +        return ret;
> +    }
> +
> +    /*
> +     * cap_ppc_fwnmi is set when FWNMI is available and enabled in KVM
> +     * and not just when FWNMI is available in KVM
> +     */
> +    cap_ppc_fwnmi =3D 1;

Using these cap globals is only slighly ugly when they can be
initialized very early and thereafter remain constant.  However, since
you're only setting this later (in fact *never* until several patches
down the series, since kvmppc_set_fwnmi() isn't called), this makes it
very ugly with this global set at an indeterminite time having effects
on things the relative order of which is not at all obvious.

I think it would make much more sense to eliminate the cap_ppc_fwnmi
global, and instead attempt the enable_cap in cap_fwnmi_mce_apply,
failing the apply if the enable_cap fails.

> +    return ret;
> +}
> +
>  int kvmppc_smt_threads(void)
>  {
>      return cap_ppc_smt ? cap_ppc_smt : 1;
> @@ -2355,6 +2376,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>      return cap_mmu_hash_v3;
>  }
> =20
> +bool kvmppc_has_cap_ppc_fwnmi(void)
> +{
> +    return cap_ppc_fwnmi;
> +}
> +
>  static bool kvmppc_power8_host(void)
>  {
>      bool ret =3D false;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 98bd7d5..ce5c1f9 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -27,6 +27,8 @@ void kvmppc_enable_h_page_init(void);
>  void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> +int kvmppc_set_fwnmi(void);
> +bool kvmppc_has_cap_ppc_fwnmi(void);
>  int kvmppc_smt_threads(void);
>  void kvmppc_hint_smt_possible(Error **errp);
>  int kvmppc_set_smt_threads(int smt);
> @@ -159,6 +161,16 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU =
*cpu, int mpic_proxy)
>  {
>  }
> =20
> +static inline int kvmppc_set_fwnmi(void)
> +{
> +    return -1;
> +}
> +
> +static inline bool kvmppc_has_cap_ppc_fwnmi(void)
> +{
> +    return false;
> +}
> +
>  static inline int kvmppc_smt_threads(void)
>  {
>      return 1;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2Kvt0ACgkQbDjKyiDZ
s5Kb4Q//fctXuP2iNc7Pv//bzlEP1P8cTkblugna8DOF+cnLH9T1ovxFZz6jO9P7
FjMbh7DxvFJKQlYE6VU97t54V+jC1vgtz4JRkCbBxKXeCivIheTUDYnbLyfOp6Ru
pgYA/XD/jixzNY3g+nZ6LGcuyS8KRv2S6Jt0UHKeYXSc5NI2xMiWzUYe9hWJOCAx
LLmZtwl6DVQJR6GjbcO7hWV9unuFJc1xjqqyMq5SW8/zt6JH1+5zjaqapuQk1D4s
OWet5O7gy7APPJi75gwGKrguSBQ8SHGGkbX23jrbMbZ6BHVbkY11buKJtRSrxWYd
yal9LUznQ9V/Y1Q2CNTchXD3TbY8kOOz8pl28w1v/8jbAYYTXfYwYLyZJUPMrfVq
dcOB5Z14aKrZzXGkUUYi2m6SCtRqPjNj9dx4lMLSOy2HCZnPCfvAbqRjua0jTzpq
I/56C6Sp0IEMWPhqGCXHOijwpOb+7GACE4rc7tbXe5BLzwQTFtC/kv53XrulzOpS
Kdi1IRrXZgcLzLB1VRymGqA2/e9O6MA0aqIdguFlAShkN7CJr1Ps1ljOopm9l1cu
Vh1Nw77+KizPoNQKEeAbF6S/WEF96ZOWd1RrinXoNhfLtmkOhGIRvhL92e60DppD
Qu+AO3R/iLUclv8seim+1fOAlIxdoE4Gg/GI5nXlHPWkps/ClnM=
=IFBW
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--

