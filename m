Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B150C33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7E1206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TvgyifWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7E1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itLHQ-0001Q3-Ns
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 19:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1itLFW-0007wi-6t
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1itLFU-00035y-29
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:49:01 -0500
Received: from ozlabs.org ([203.11.71.1]:52947)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1itLFT-00031L-4o; Sun, 19 Jan 2020 19:49:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 481Cj23mD0z9sR4; Mon, 20 Jan 2020 11:48:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579481334;
 bh=4ulg0QK5wFP/y6oWL76AMYxcj91vafXqEWB0FxxHTbw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TvgyifWiKFELHlCQeGhBn5Wp7IWWqxiNBMnOHUGyoPfBI6nx7is9M4NkXIEEif07S
 jcvQYcgHcbl059d3+mCAqKFDm9lKEXXxrO9Q6/ZCFAm9JWWSXENDe/Wh2uMIxFXlnB
 aX81SuLZI2jcTDrzcvbw43jbCJFeWx7WplB+Yj50=
Date: Mon, 20 Jan 2020 11:40:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v20 2/7] ppc: spapr: Introduce FWNMI capability
Message-ID: <20200120004007.GH54439@umbus>
References: <20200117093855.19074-1-ganeshgr@linux.ibm.com>
 <20200117093855.19074-3-ganeshgr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SR0DFWOzPg+ymaCV"
Content-Disposition: inline
In-Reply-To: <20200117093855.19074-3-ganeshgr@linux.ibm.com>
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SR0DFWOzPg+ymaCV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2020 at 03:08:50PM +0530, Ganesh Goudar wrote:
> From: Aravinda Prasad <arawinda.p@gmail.com>
>=20
> Introduce fwnmi an spapr capability and add a helper function
> which tries to enable it, which would be used by following patch
> of the series. This patch by itself does not change the existing
> behavior.
>=20
> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> [eliminate cap_ppc_fwnmi, add fwnmi cap to migration state
>  and reprhase the commit message]
> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_caps.c    | 18 ++++++++++++++++++
>  include/hw/ppc/spapr.h |  5 ++++-
>  target/ppc/kvm.c       |  8 ++++++++
>  target/ppc/kvm_ppc.h   |  6 ++++++
>  5 files changed, 38 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 30a5fbd3be..f5c036d3d9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1992,6 +1992,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_dtb,
>          &vmstate_spapr_cap_large_decr,
>          &vmstate_spapr_cap_ccf_assist,
> +        &vmstate_spapr_cap_fwnmi,
>          NULL
>      }
>  };
> @@ -4398,6 +4399,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 481dfd2a27..3001098601 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -496,6 +496,14 @@ static void cap_ccf_assist_apply(SpaprMachineState *=
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
> +}
> +
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
> @@ -595,6 +603,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
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
> @@ -734,6 +751,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MA=
XPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
> =20
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 61f005c6f6..7bc5fc3a9e 100644
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
> @@ -869,6 +871,7 @@ extern const VMStateDescription vmstate_spapr_cap_hpt=
_maxpagesize;
>  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
> +extern const VMStateDescription vmstate_spapr_cap_fwnmi;
> =20
>  static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
>  {
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index b5799e62b4..9161eea865 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2054,6 +2054,14 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mp=
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
> index b713097bfb..2c60dedd0d 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -27,6 +27,7 @@ void kvmppc_enable_h_page_init(void);
>  void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> +int kvmppc_set_fwnmi(void);
>  int kvmppc_smt_threads(void);
>  void kvmppc_error_append_smt_possible_hint(Error *const *errp);
>  int kvmppc_set_smt_threads(int smt);
> @@ -160,6 +161,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU =
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

--SR0DFWOzPg+ymaCV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4k9uUACgkQbDjKyiDZ
s5LXkg//RudZibNV1ERgzwrrsB9oMhS+pw9oyV99mJx5wt+llxA2DM1nUlrS/fNT
clu/1KpCpXqTHmrwgqnl7yAHSf028Amp/vqOUyZfJ/8xQrgSUERice6rycY/j4yu
k4qYDNGI3J1+kc6XDF0xv62mLjzmDsFoWtu9C6gnSnrpcGr2gmXEDO2UyU/0JkL3
8D39nL9Pyj691kEBtV9iOjiF5yCGAcUU0lZiosfE7rcqe7pf5M/N/hY80TFMZPAc
IRcN0QP3v8yqsXEGOlZ0C8gEFbGyVQJUuPgymPua+9yh+MRkBOBeP+UEAhxHmwQw
zEaq2G1Y6r1YnVi0QfI0a/lrpb6J5HgV2fEkgfMxjv9fMyMDZG12NCg9jOqrFsZ+
wkoQ4t0ub3rEQR2JupdNrzdl8eMN5vEAwLgL/74sGv8SikfmRELKwpzaySQhDgNS
Jv87itDeTzKLzZ7xs9SYvnDr8vSjCNCt4QQxCl0TZcsLHpf7Hrnv2ofcgKKVvaib
5VeA0ayI/6UpTlnLgu3wndQaE303+WlxND1HISRYbbBhq06ad4AER9zgYABEZs9W
3BzQW87Uder3v1gy0/LTf+3sk4LKxFr9/Hcz7xf+Hna2JGoH837PymPAbQt9IzR/
BVnCl3kf2N4fG2BZgIoG1sZw/IcP57GF2UZXlj+xUx5EGxjAL8Q=
=RnrZ
-----END PGP SIGNATURE-----

--SR0DFWOzPg+ymaCV--

