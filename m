Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A395C54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6342A20724
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LC8ecdUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6342A20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGDfV-0002rF-FB
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 23:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGDeX-0001m3-DS
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGDeV-0005pz-SG
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:21:25 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41663 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGDeV-0005on-22; Sun, 22 Mar 2020 23:21:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48m05q1vjgz9sRY; Mon, 23 Mar 2020 14:21:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584933679;
 bh=I/B9GT09Rj28v/6mKrL2WlnBKhjO3hgOWprqq3sLOqw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LC8ecdUnuF5Zze8/8+WqffFVpqLA4ZHeOWH8OKGSaNC8XclR8m9bSzqwYMGkLeQ9B
 SelPrC7TsSZnKnLQsKnh8sAzYDjSMTTSyvV3bjTBYgjYhb2DSWqqJHL/T3+x5VHDW/
 z+FNiN8VzNFco1zKWv5xy+D4dr2U/1O7AMKuC0xE=
Date: Mon, 23 Mar 2020 14:21:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [RFC PATCH] target/ppc: Add capability for enabling secure guests
Message-ID: <20200323032109.GD2213@umbus.fritz.box>
References: <20200320232353.1022066-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <20200320232353.1022066-1-farosas@linux.ibm.com>
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
Cc: Paul Mackerras <paulus@ozlabs.org>, Ram Pai <linuxram@us.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 08:23:53PM -0300, Fabiano Rosas wrote:
> Making use of ppc's Protected Execution Facility (PEF) feature, a
> guest can become a secure guest (aka. secure VM - SVM) and have its
> memory protected from access by the host. This feature is mediated by
> a piece of firmware called the Ultravisor (UV).
>=20
> The transition from a regular to a secure VM is initiated by the guest
> kernel during prom_init via the use of an ultracall (enter secure mode
> - UV_ESM) and with cooperation from the hypervisor via an hcall
> (H_SVM_INIT_START).
>=20
> Currently QEMU has no knowledge of this process and no way to
> determine if a host supports the feature. A guest with PEF support
> enabled would always try to enter secure mode regardless of user
> intent or hardware support.
>=20
> To address the above, a new KVM capability (KVM_CAP_PPC_SECURE_GUEST
> [1]) is being introduced in the kernel without which KVM will block
> the secure transition.
>=20
> This patch adds support for checking/enabling this KVM capability via
> a new spapr capability (SPAPR_CAP_SECURE_GUEST) and the equivalent
> command line switch (-machine pseries,cap-svm). The capability
> defaults to off.
>=20
> 1- https://lore.kernel.org/kvm/20200319043301.GA13052@blackberry
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>=20
> I have implemented this to be able to test Paul's patch. I'm sending
> it as RFC in case it helps anyone else and if we decide to go in this
> direction I can develop it further.

LGTM

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

It will miss the qemu-5.0 cut-off, of course, but that should be ok.

>=20
> PS: TCG currently gets in a loop of 0x700 due to the lack of 'sc 2'
> emulation - and all the rest of PEF, of course =3D).
>=20
> ---
>  hw/ppc/spapr.c         |  1 +
>  hw/ppc/spapr_caps.c    | 30 ++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  3 ++-
>  target/ppc/kvm.c       | 12 ++++++++++++
>  target/ppc/kvm_ppc.h   | 12 ++++++++++++
>  5 files changed, 57 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9a2bd501aa..a881ac4e29 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4542,6 +4542,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_FWNMI] =3D SPAPR_CAP_ON;
> +    smc->default_caps.caps[SPAPR_CAP_SECURE_GUEST] =3D SPAPR_CAP_OFF;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 679ae7959f..375b7e0b30 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -524,6 +524,27 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr=
, uint8_t val,
>      }
>  }
>=20
> +static void cap_secure_guest_apply(SpaprMachineState *spapr,
> +                                   uint8_t val, Error **errp)
> +{
> +    if (!val) {
> +        /* capability disabled by default */
> +        return;
> +    }
> +
> +    if (!kvm_enabled()) {
> +        error_setg(errp, "No PEF support in tcg, try cap-svm=3Doff");
> +        return;
> +    }
> +
> +    if (!kvmppc_has_cap_secure_guest()) {
> +        error_setg(errp, "KVM implementation does not support secure gue=
sts, "
> +                   "try cap-svm=3Doff");
> +    } else if (kvmppc_enable_cap_secure_guest() < 0) {
> +        error_setg(errp, "Error enabling cap-svm, try cap-svm=3Doff");
> +    }
> +}
> +
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
> @@ -632,6 +653,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "bool",
>          .apply =3D cap_fwnmi_apply,
>      },
> +    [SPAPR_CAP_SECURE_GUEST] =3D {
> +        .name =3D "svm",
> +        .description =3D "Allow the guest to become a Secure Guest",
> +        .index =3D SPAPR_CAP_SECURE_GUEST,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
> +        .apply =3D cap_secure_guest_apply,
> +    },
>  };
>=20
>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 42d64a0368..7f5289782d 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -81,8 +81,9 @@ typedef enum {
>  #define SPAPR_CAP_CCF_ASSIST            0x09
>  /* Implements PAPR FWNMI option */
>  #define SPAPR_CAP_FWNMI                 0x0A
> +#define SPAPR_CAP_SECURE_GUEST          0x0B
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_SECURE_GUEST + 1)
>=20
>  /*
>   * Capability Values
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 597f72be1b..9254749cd7 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -88,6 +88,7 @@ static int cap_ppc_safe_indirect_branch;
>  static int cap_ppc_count_cache_flush_assist;
>  static int cap_ppc_nested_kvm_hv;
>  static int cap_large_decr;
> +static int cap_ppc_secure_guest;
>=20
>  static uint32_t debug_inst_opcode;
>=20
> @@ -135,6 +136,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HP=
T);
>      kvmppc_get_cpu_characteristics(s);
>      cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_NEST=
ED_HV);
> +    cap_ppc_secure_guest =3D kvm_vm_check_extension(s, KVM_CAP_PPC_SECUR=
E_GUEST);
>      cap_large_decr =3D kvmppc_get_dec_bits();
>      /*
>       * Note: setting it to false because there is not such capability
> @@ -2532,6 +2534,16 @@ int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, =
int enable)
>      return 0;
>  }
>=20
> +bool kvmppc_has_cap_secure_guest(void)
> +{
> +    return !!cap_ppc_secure_guest;
> +}
> +
> +int kvmppc_enable_cap_secure_guest(void)
> +{
> +    return kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_SECURE_GUEST, 0, 1);
> +}
> +
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>  {
>      uint32_t host_pvr =3D mfpvr();
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 332fa0aa1c..a9a3aa67c6 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -72,6 +72,8 @@ int kvmppc_set_cap_nested_kvm_hv(int enable);
>  int kvmppc_get_cap_large_decr(void);
>  int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable);
>  int kvmppc_enable_hwrng(void);
> +bool kvmppc_has_cap_secure_guest(void);
> +int kvmppc_enable_cap_secure_guest(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
>  void kvmppc_check_papr_resize_hpt(Error **errp);
> @@ -380,6 +382,16 @@ static inline int kvmppc_enable_cap_large_decr(Power=
PCCPU *cpu, int enable)
>      return -1;
>  }
>=20
> +static inline bool kvmppc_has_cap_secure_guest(void)
> +{
> +    return false;
> +}
> +
> +static inline int kvmppc_enable_cap_secure_guest(void)
> +{
> +    return -1;
> +}
> +
>  static inline int kvmppc_enable_hwrng(void)
>  {
>      return -1;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl54KyUACgkQbDjKyiDZ
s5I+oA/+MKD4oq/miQND5dm9uAAZOIxHQssqDj4N8BLugV0yxyftPxrOJbkkE3Wo
7EsRugDe4ZRjljb1AS256XyixJrawuUlSgB96LYAa68Mjgh4VBxG6nRmr/21Gg6r
ghBY9nUK1uy5gdxxxyXDTwM2YNtvgyWNyH26z8HNC+t6kkKcWM1TTQ3/3xJbFyzM
xhbGMZw/n+RwlsmIJ8djPbsGyYiPwGgtejSlY3/snBJAXf1+O2D5mpuGhnMS0ugp
bP5mTEYCy7M2w60VZQeSlkSh+sewTllEBoJnlvW6pEE8gkvCaEzLPw8CkCH3eEU6
IgUasHNPG2DeVw3/fTlJS1+Z6bA1ighA7MuTRM91+i/vJo2Vfr35XDUXEcJmQMBz
U5lKW/ds6A+bPQ1o2Nnazj1hYKIGtN2o7wGEmOym4mDnByUpXq+ePhhQCMWxY8BZ
xoSZA3+pdaKZ3cGAJ5+g1uL2hG80NXLFhrQ8s/YBTJ1hwDd8AEOYGsuucpiQcDns
C2DI2z6OaE4gM/k55ChAR8oUrUcenLCT17yfrU0to4jlwSFzyeIRA2RCpqSPpR/b
jExv43iIHkWrNsXLxJzCY6b5NO4laOHJr5W2mjSTPDTQBLZNsRUZuiaPqzkLHkFu
OMAaVTV1LkMhEZ0nCg5GKu/aw2RXjiYn88L6FXoqZLQAfetwoF8=
=yrZt
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--

