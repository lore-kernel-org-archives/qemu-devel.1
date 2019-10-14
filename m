Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DCDC47404
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 05:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C181206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 05:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Adp+E2Cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C181206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJsuP-0002w0-L5
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 01:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iJstE-0002Lw-JG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 01:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iJstB-0004gk-I1
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 01:27:28 -0400
Received: from ozlabs.org ([203.11.71.1]:47893)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iJstA-0004fT-Iq; Mon, 14 Oct 2019 01:27:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46s6WV6gcXz9sPj; Mon, 14 Oct 2019 16:27:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571030838;
 bh=XbUzoF2pCmQP+TnRyVcf7qaPkAzS0GFvLbd/5AtQMJM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Adp+E2CvI0nuMSVdLAhQ8sqsCgxZfspWlQ696cM57PLxqD/IeORhE3rEKo8T9thOS
 dtDPA3QOjAu0jriCwcNooa7ksdIsEvPh0fCICxdeDUzbJMhN9HczU3flef2G2b6xde
 UJ7kk1pOw4NF5V9Df6vNWJIsKjv++uGJf9i5bdgQ=
Date: Mon, 14 Oct 2019 16:27:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v16 2/7] ppc: spapr: Introduce FWNMI capability
Message-ID: <20191014052713.GR4080@umbus.fritz.box>
References: <20191010065950.23169-1-ganeshgr@linux.ibm.com>
 <20191010065950.23169-3-ganeshgr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Uw+RRa3pmtkgiNaD"
Content-Disposition: inline
In-Reply-To: <20191010065950.23169-3-ganeshgr@linux.ibm.com>
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


--Uw+RRa3pmtkgiNaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2019 at 12:29:45PM +0530, Ganesh Goudar wrote:
> From: Aravinda Prasad <arawinda.p@gmail.com>
>=20
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

I think the commit message needs some updating.  This doesn't really
introduce the KVM cap.  It introduces the spapr capability, and
validates it against the kernel's exising capability.

>=20
> [eliminate cap_ppc_fwnmi]
> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> ---
>  hw/ppc/spapr.c         |  1 +
>  hw/ppc/spapr_caps.c    | 29 +++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  4 +++-
>  target/ppc/kvm.c       |  8 ++++++++
>  target/ppc/kvm_ppc.h   |  6 ++++++
>  5 files changed, 47 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 514a17ae74..7e6a15c9b4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4441,6 +4441,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;

To have migration work correctly, you also need to add
&vmstate_spapr_cap_fwnmi_mce  to the list in vmstate_spapr.  (Yes,
that makes three places you have to put things to get migration
right, which is really easy to mess up - I've done it more than once
myself - unfortunately, I haven't come up with a better way yet).

> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 481dfd2a27..778bf32181 100644
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
> +    } else if (kvm_enabled() && kvmppc_set_fwnmi()) {

When checking integer error code return values (like
kvmppc_set_fwnmi()) please include an explicit !=3D 0, to make it
clearer that's what's happening, rather than a function returning a bool.

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
> index cbd1a4c9f3..dcd2e7d0cc 100644
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
> index 820724cc7d..d56f11a883 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2060,6 +2060,14 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mp=
ic_proxy)
>      }
>  }
> =20
> +int kvmppc_set_fwnmi(void)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +    CPUState *cs =3D CPU(cpu);
> +
> +    return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
> +}
> +
>  int kvmppc_smt_threads(void)
>  {
>      return cap_ppc_smt ? cap_ppc_smt : 1;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 98bd7d5da6..5727a5025f 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -27,6 +27,7 @@ void kvmppc_enable_h_page_init(void);
>  void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> +int kvmppc_set_fwnmi(void);
>  int kvmppc_smt_threads(void);
>  void kvmppc_hint_smt_possible(Error **errp);
>  int kvmppc_set_smt_threads(int smt);
> @@ -159,6 +160,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU =
*cpu, int mpic_proxy)
>  {
>  }
> =20
> +static inline int kvmppc_set_fwnmi(void)
> +{
> +    return -1;
> +}
> +
>  static inline int kvmppc_smt_threads(void)
>  {
>      return 1;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Uw+RRa3pmtkgiNaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2kBzEACgkQbDjKyiDZ
s5I4Hw/+OTpzjoduUkzHXn0khwiNAsjVAa2DMQQUTpnKknzPUNLb5wgxLHwZYsah
whTgjvCq2BW/4KhPeBhGvHA3aSKgKgsYOKZO8AH4u8HDLpRRBGbSrdwyOPayd4v/
hSwO/SK0IETZGVApg1xUr9jsrshK2Gb7PtIePnrFVLJjDY13WnWkNEedy8mo/iLp
EUdrWYUzlQP5h2yHnFCI5pYwkEMKJI0JHv3laZF/9kGq2cXRY+VKBX3iV4avWC71
Ep8qkGzUkwwalHnzR7VHGxu1xRyGqTqByxXUYzwbJxGUBjFUv4kp9Ha1z+ZTBfip
hh8vHrGkCkAx3cDu6M5zVjEvMzdJleXCjsl0xOBNRQThk4MuAdKh/iHA0hRMSEd3
XUmYU9i1mAqDXtAl7oPvwhKOaXmAfm6xy0u3oxwBSqJHuyMPvYeavR8J0EDTkXdA
RkrPiokUEBgMTwKZKfeLBa60dhc+faz06gtw8CiMRO4LNmGhDxRxYDrZnlSLRu4u
K9x5SEr/osu9YCIOFVAaLGTjaf9n+dV11J4b5YQp0+bMgZ10syThHyR1uymATmbr
LAIfgR3DukJri/ZgGGsogjx0m3ExmQnsiiytmIyFmc78+u025xQ0b5nWe5BqVDhY
YqWaRVOsLzuDKUP5fe2APIJtXIiBtWLP6hm3Br7IDX4xSlAoGBc=
=ZbZ8
-----END PGP SIGNATURE-----

--Uw+RRa3pmtkgiNaD--

