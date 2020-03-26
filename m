Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC9BC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB0920737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ACsyx50v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB0920737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHGYS-0005WX-Hy
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 20:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXN-0003li-6j
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXL-0002KJ-LS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:21 -0400
Received: from ozlabs.org ([203.11.71.1]:36609)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHGXL-0002HM-7m; Wed, 25 Mar 2020 20:38:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48nmL81SNpz9sSQ; Thu, 26 Mar 2020 11:38:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585183088;
 bh=Nlj9B9z4H1KU2I/htJv8MyKFnHOFuoHZob5/fRyHVa0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ACsyx50vQRM/qatnZXfgxtSYGOezilmaUbhG0J4NaVjvTeQh8CRlqg+iyZ1P+FKph
 /ii6z5yflOlH++NubGZJ/EVaxiTJoQIdAOn+Ywmgx9kugyBBLx1xLsSnviPdeO1YVj
 dRgGO7gi6XEk1UaqOtNgyUM3gp8gyHdQAYjxHWSA=
Date: Thu, 26 Mar 2020 11:17:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/4] ppc/spapr: KVM FWNMI should not be enabled until
 guest requests it
Message-ID: <20200326001728.GM36889@umbus.fritz.box>
References: <20200325142906.221248-1-npiggin@gmail.com>
 <20200325142906.221248-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fDERRRNgB4on1jOB"
Content-Disposition: inline
In-Reply-To: <20200325142906.221248-2-npiggin@gmail.com>
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fDERRRNgB4on1jOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 12:29:03AM +1000, Nicholas Piggin wrote:
65;5803;1c> The KVM FWNMI capability should be enabled with the "ibm,nmi-re=
gister"
> rtas call. Although MCEs from KVM will be delivered as architected
> interrupts to the guest before "ibm,nmi-register" is called, KVM has
> different behaviour depending on whether the guest has enabled FWNMI
> (it attempts to do more recovery on behalf of a non-FWNMI guest).
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.0.

> ---
>  hw/ppc/spapr_caps.c  | 7 ++++---
>  hw/ppc/spapr_rtas.c  | 7 +++++++
>  target/ppc/kvm.c     | 7 +++++++
>  target/ppc/kvm_ppc.h | 6 ++++++
>  4 files changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 679ae7959f..eb54f94227 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -517,9 +517,10 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr=
, uint8_t val,
>      }
> =20
>      if (kvm_enabled()) {
> -        if (kvmppc_set_fwnmi() < 0) {
> -            error_setg(errp, "Firmware Assisted Non-Maskable Interrupts(=
FWNMI) "
> -                             "not supported by KVM");
> +        if (!kvmppc_get_fwnmi()) {
> +            error_setg(errp,
> +"Firmware Assisted Non-Maskable Interrupts(FWNMI) not supported by KVM."=
);
> +            error_append_hint(errp, "Try appending -machine cap-fwnmi=3D=
off\n");
>          }
>      }
>  }
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 9fb8c8632a..29abe66d01 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -437,6 +437,13 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>          return;
>      }
> =20
> +    if (kvm_enabled()) {
> +        if (kvmppc_set_fwnmi() < 0) {
> +            rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +            return;
> +        }
> +    }
> +
>      spapr->fwnmi_system_reset_addr =3D sreset_addr;
>      spapr->fwnmi_machine_check_addr =3D mce_addr;
> =20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 597f72be1b..03d0667e8f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -88,6 +88,7 @@ static int cap_ppc_safe_indirect_branch;
>  static int cap_ppc_count_cache_flush_assist;
>  static int cap_ppc_nested_kvm_hv;
>  static int cap_large_decr;
> +static int cap_fwnmi;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> @@ -136,6 +137,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      kvmppc_get_cpu_characteristics(s);
>      cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_NEST=
ED_HV);
>      cap_large_decr =3D kvmppc_get_dec_bits();
> +    cap_fwnmi =3D kvm_vm_check_extension(s, KVM_CAP_PPC_FWNMI);
>      /*
>       * Note: setting it to false because there is not such capability
>       * in KVM at this moment.
> @@ -2064,6 +2066,11 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mp=
ic_proxy)
>      }
>  }
> =20
> +bool kvmppc_get_fwnmi(void)
> +{
> +    return cap_fwnmi;
> +}
> +
>  int kvmppc_set_fwnmi(void)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 332fa0aa1c..fcaf745516 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -27,6 +27,7 @@ void kvmppc_enable_h_page_init(void);
>  void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> +bool kvmppc_get_fwnmi(void);
>  int kvmppc_set_fwnmi(void);
>  int kvmppc_smt_threads(void);
>  void kvmppc_error_append_smt_possible_hint(Error *const *errp);
> @@ -163,6 +164,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU =
*cpu, int mpic_proxy)
>  {
>  }
> =20
> +static inline bool kvmppc_get_fwnmi(void)
> +{
> +    return false;
> +}
> +
>  static inline int kvmppc_set_fwnmi(void)
>  {
>      return -1;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fDERRRNgB4on1jOB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl579JgACgkQbDjKyiDZ
s5I8LBAAyFoz2wEhJKBjEwijJphYrOmIHPogxAGzzueSEmv+x1yvWEW5OQTfXlgJ
/v/8i7V5bwlM21ExaJjQG+P2s2E2hejlAhnW/c9f0JjuimJm2yuPo3QXNDO8C/xb
W27uoxSf3DCs53Q4NCJ3g2zwJQxPRGWOMzBB9xgFreEdIecDuxhYMdvDRNSKjrO1
J/vvesjuVEkVpD/bl46x2YMuqAyAbfdKC2EDRDw4PZvYLNIxmoVaCqqt3vZB+P2g
xIFrL9HpahTqUD9CWpYQJ+cOPN7a4phHZtbiF3VCT8XVfZvRVDbYbVkwU+BrNDD6
x1F9cLO5tHSvJzlPFeCyoBmOknkASa69sykgOrLLBpDUCxj6KQhGKxWVdoL5q064
KVdY6fGFxjXTwLIafAflMtcmOxg9HKsiwuuLq6ykcPVmm/InmUScQVV+/leDEonB
u172GjUmLgNOYTbVstH7gI7dNQHo1nMS7KoRILph1DjVJFEbZ+yR/w1sniQjUeKC
NEAWYFO82AIfIjwTdWzEITiYkcWl8bA5FAeUcOBUvVBflu6cnl+/0W05iq+6Bjt5
8hEoPAd49oDSo+/piSJoxJVv7VnDM9gz0gaijT85eRxl7vkWXzTIoVBTzfZ7+a5J
oTlit61JoE4EGKxWyNCd4KsGCy4ez+llfpLS/5M/pCbXGpbcsj0=
=I387
-----END PGP SIGNATURE-----

--fDERRRNgB4on1jOB--

