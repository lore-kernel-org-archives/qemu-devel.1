Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7067C28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F902070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SfGymQja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F902070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53533 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYilR-0002y9-Ah
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 23:08:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYijz-0002Cg-Oa
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYijm-0006Vi-Ls
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:06:51 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:37007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hYijd-0006FR-Bk; Wed, 05 Jun 2019 23:06:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45K9Xs1RlTz9s4Y; Thu,  6 Jun 2019 13:06:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559790381;
	bh=h4I9wcYclBc8LByOm+TVM4ZWlscW3Y6FCnDx2Vj/WUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfGymQja6UGYjWX9WoIsCrekaEe8kIxQEdHa/DZY9/E5TFUqADsYRwF7lH7lasuc1
	toqfAPv4KXsqsBYkBCtPrnRVJYTQhQEy0xmanbtD5CMhRq0zni+D77/C5gwasdw664
	6sEiuuvJS1+urYOa+r8mNM3QK1JqWv3bSSzVzcH4=
Date: Thu, 6 Jun 2019 13:00:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190606030032.GI10319@umbus.fritz.box>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
	<155910844950.13149.6460514692958589700.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Uu2n37VG4rOBDVuR"
Content-Disposition: inline
In-Reply-To: <155910844950.13149.6460514692958589700.stgit@aravinda>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v9 5/6] ppc: spapr: Enable FWNMI capability
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Uu2n37VG4rOBDVuR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2019 at 11:10:49AM +0530, Aravinda Prasad wrote:
> Enable the KVM capability KVM_CAP_PPC_FWNMI so that
> the KVM causes guest exit with NMI as exit reason
> when it encounters a machine check exception on the
> address belonging to a guest. Without this capability
> enabled, KVM redirects machine check exceptions to
> guest's 0x200 vector.
>=20
> This patch also deals with the case when a guest with
> the KVM_CAP_PPC_FWNMI capability enabled is attempted
> to migrate to a host that does not support this
> capability.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         |    1 +
>  hw/ppc/spapr_caps.c    |   24 ++++++++++++++++++++++++
>  hw/ppc/spapr_rtas.c    |   18 ++++++++++++++++++
>  include/hw/ppc/spapr.h |    4 +++-
>  target/ppc/kvm.c       |   19 +++++++++++++++++++
>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
>  6 files changed, 77 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c97f6a6..e8a77636 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4364,6 +4364,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_ON;

You need to turn this back off by default for the older machine types.

>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 31b4661..ef9e612 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -479,6 +479,20 @@ static void cap_ccf_assist_apply(SpaprMachineState *=
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
> +            error_setg(errp, "No fwnmi support in TCG, try cap-fwnmi-mce=
=3Doff");
> +    } else if (kvm_enabled() && !kvmppc_has_cap_ppc_fwnmi()) {
> +            error_setg(errp, "Requested fwnmi capability not support by =
KVM");
> +    }
> +}
> +
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
> @@ -578,6 +592,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
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
> @@ -717,6 +740,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MA=
XPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
> =20
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index e0bdfc8..91a7ab9 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -49,6 +49,7 @@
>  #include "hw/ppc/fdt.h"
>  #include "target/ppc/mmu-hash64.h"
>  #include "target/ppc/mmu-book3s-v3.h"
> +#include "kvm_ppc.h"
> =20
>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
>                                     uint32_t token, uint32_t nargs,
> @@ -358,6 +359,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>                                    target_ulong args,
>                                    uint32_t nret, target_ulong rets)
>  {
> +    int ret;
>      hwaddr rtas_addr =3D spapr_get_rtas_addr();
> =20
>      if (!rtas_addr) {
> @@ -365,6 +367,22 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>          return;
>      }
> =20
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D 0) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    ret =3D kvmppc_fwnmi_enable(cpu);
> +    if (ret =3D=3D 1) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    if (ret < 0) {
> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> +        return;
> +    }
> +
>      spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c717ab2..bd75d4b 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -78,8 +78,10 @@ typedef enum {
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
> index 39f1a73..368ec6e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -84,6 +84,7 @@ static int cap_ppc_safe_indirect_branch;
>  static int cap_ppc_count_cache_flush_assist;
>  static int cap_ppc_nested_kvm_hv;
>  static int cap_large_decr;
> +static int cap_ppc_fwnmi;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -152,6 +153,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      kvmppc_get_cpu_characteristics(s);
>      cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_NEST=
ED_HV);
>      cap_large_decr =3D kvmppc_get_dec_bits();
> +    cap_ppc_fwnmi =3D kvm_check_extension(s, KVM_CAP_PPC_FWNMI);
>      /*
>       * Note: setting it to false because there is not such capability
>       * in KVM at this moment.
> @@ -2119,6 +2121,18 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mp=
ic_proxy)
>      }
>  }
> =20
> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +
> +    if (!cap_ppc_fwnmi) {
> +        return 1;
> +    }
> +
> +    return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
> +}
> +
> +
>  int kvmppc_smt_threads(void)
>  {
>      return cap_ppc_smt ? cap_ppc_smt : 1;
> @@ -2419,6 +2433,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
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
> index 18693f1..3d9f0b4 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -27,6 +27,8 @@ void kvmppc_enable_h_page_init(void);
>  void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu);
> +bool kvmppc_has_cap_ppc_fwnmi(void);
>  int kvmppc_smt_threads(void);
>  void kvmppc_hint_smt_possible(Error **errp);
>  int kvmppc_set_smt_threads(int smt);
> @@ -160,6 +162,16 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU =
*cpu, int mpic_proxy)
>  {
>  }
> =20
> +static inline int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
> +{
> +    return 1;
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

--Uu2n37VG4rOBDVuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz4gdAACgkQbDjKyiDZ
s5ItXQ//bX67Bb5uXLpFbRalceIqkGrG0eB3/tUI+N1DMlfyIeFruTUwvElLEFLz
lNTJhet4gbYgcz64r20RdZdAYUhF7WYlCUavRJJlpbElQYxlnAzgp3FY9MegTu6C
/Tb70MVir4Ee+NSqVD/I7HvIark+u+DKmyZ9I/zRwkPRaLa8xBAxdtL9+lt1H+YL
4RopoQYdltIIu1ycHRn9Vmv74UvrwgVedT1ctvaEFDpKLqwGBu/+QLuFyVFfSYQJ
qrAFVLtrJ2lKc3gXtmeYaPhX1BNd2qMW4O+W7oQRa3b8pZsUB5W4vSE0091McObi
6Hi2uk4l2YsU176zADgY6nsUx0pyxmgJMHQEho7oMVckhOKm10MIjcm0GG3kOGZH
veuTDCCVQhE46+XSGtF8SMlZ7wl4tHWdgPP1j2mIR97durlrf9h15NJzxUgz3vJA
TqpSb8feGQrlP5gQFI8GOvVPZMoTmIUshmPqvdY+ku7mIl8cTlX2VFJfJjjf5N9O
njaDGuyD2bPhBvjvgv51NfmLx4wvJ0U8QdRgMcluk39ixZRLdGilTAjiiLh6KBpe
pc118uhQ5Zah30Q5o4xQPJp+o876821Lt5uNzSXwRFmpIQ+H8CbSaNs2Fze21BgB
35m50dodO0B3Kh20cC8u3kAoVHjZI1zMJ8DRyAZ5oRHkfaVzedk=
=x16o
-----END PGP SIGNATURE-----

--Uu2n37VG4rOBDVuR--

