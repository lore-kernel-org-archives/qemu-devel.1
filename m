Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D586C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D430A216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BqQzZ08V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D430A216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiAMs-0003zN-2o
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiAAE-0008Fo-GZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiAAC-0005QB-Cx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:13:06 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53167 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiAAA-0005G3-BP; Tue, 02 Jul 2019 00:13:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45d9nX2hbHz9s4V; Tue,  2 Jul 2019 14:12:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562040768;
 bh=nDsqoL0+0w9Vamw5GWCpGzs9pKYryYp7m5UDaAZskhQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BqQzZ08VWpvuYfjDTdf67I6KJMqdaqTp/ca1C9jJ0FDZk2m71w1lZ/7nD91Ai0qkg
 1RKEubcLSb9FtTw4QTmc+3rCFPi/hcTqx8reGhIkrWBsuJS0UCgPsbP8JsWhKNMWEA
 F2veX+NWFBvjfMbVZmEK3meP7feLLb12NYP42nT8=
Date: Tue, 2 Jul 2019 13:51:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190702035105.GG6779@umbus.fritz.box>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033126489.26635.3005245220857933178.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Content-Disposition: inline
In-Reply-To: <156033126489.26635.3005245220857933178.stgit@aravinda>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v10 2/6] ppc: spapr: Introduce FWNMI
 capability
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


--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 02:51:04PM +0530, Aravinda Prasad wrote:
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
> ---
>  hw/ppc/spapr.c         |    1 +
>  hw/ppc/spapr_caps.c    |   26 ++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |    4 +++-
>  target/ppc/kvm.c       |   19 +++++++++++++++++++
>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
>  5 files changed, 61 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6dd8aaa..2ef86aa 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4360,6 +4360,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 31b4661..2e92eb6 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -479,6 +479,22 @@ static void cap_ccf_assist_apply(SpaprMachineState *=
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
> +        error_setg(errp,
> +"No Firmware Assisted Non-Maskable Interrupts support in TCG, try cap-fw=
nmi-mce=3Doff");

Not allowing this for TCG creates an awkward incompatibility between
KVM and TCG guests.  I can't actually see any reason to ban it for TCG
- with the current code TCG won't ever generate NMIs, but I don't see
that anything will actually break.

In fact, we do have an nmi monitor command, currently wired to the
spapr_nmi() function which resets each cpu, but it probably makes
sense to wire it up to the fwnmi stuff when present.

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
> @@ -578,6 +594,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
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
> @@ -717,6 +742,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MA=
XPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
> =20
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 4f5becf..f891f8f 100644
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
> index 3bf0a46..afef4cd 100644
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
> @@ -2114,6 +2116,18 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mp=
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
> @@ -2414,6 +2428,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
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
> index 45776ca..880cee9 100644
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
> @@ -158,6 +160,16 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU =
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

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0a1KgACgkQbDjKyiDZ
s5LdPg//aFtZN+mTE7oJAZfs4YJENcFhPMc6+fx1adJQWkPSQ0bVh3fnsuow63sJ
qq3dfRbwYB2L/y35c4a21bO/5DbhV9BSYHum7u7uAW92emcudXipNZXdpbk7W/Gi
Lwj7KoC7qSty17k8PDck1bWTsu6zmI9g2hKBQ+RbUycSyljaHy+T3CStZgKeUcgc
+oNl8SfguiyW0egQBDTLCbZVNzacWO2qCOY9+h6u3E5I6D3CSl4TjQr6zBnWns0n
cVUOd1SFoZN/RT2LQbRu8e1TFvV17p10XvvVTvEx+m8BP84M9f7Wg9ZQEPPKBvCl
Mu0XylD9wVKMHR3HPLCGh075+mks/uByuhdxTQwcM4MrsqLF1DpUgAAdeg5ROxZ3
4NEDyfDVXv/IDS+AxriiLBKAqMoNW2j2dw/xuGuI8hrLmIN7c8QO4ZAo1GMVMA4v
luDotDd2rfJU9UPsjx/86WrLQU7ogDe0pRzqUfDSBEB3Ao/vZSHxNJm49XgK8pfb
tUrSjtKGLYjd3htyFcT2GvX2gXtDTEGSTnBpbGQ7HgfjwZ9CYO2/ER1RuFIvydyj
tT3YdEwBIjr7UOqmyj5pSUJd6eBPuc4NnH87WcuB5gSBMeh44i6jWZhoxxgF9cTd
NfuE4x5wN8UAAhK4NGNNhorR++9UKG/rwSTHJETSZYjHcHGXvdg=
=r2EL
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--

