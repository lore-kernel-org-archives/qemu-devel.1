Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577DEC38A2A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1350A2082E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CuDtRFTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1350A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXx67-00059K-9w
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXx55-0004Ew-Ra; Sun, 10 May 2020 21:18:07 -0400
Received: from ozlabs.org ([203.11.71.1]:60007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXx53-0000DZ-RG; Sun, 10 May 2020 21:18:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49L32n5cn2z9sSF; Mon, 11 May 2020 11:17:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589159873;
 bh=+IrjQfg3GKjaOpivn8ZKEZOB3swFULWWJ/xB7rXODPo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CuDtRFTySDYES1kYEEZAurGCWHf6U6SF0Z1y60IU0cp7kHVNB7uXRONBDFxJ0S8BF
 QdlPgXyxjMDMCc4u0ozIgXRJ5FBp0rteKVaLpVX+wc7jGhOUD1Y23ESGmJGAr50pNQ
 Eo/iWWn6O3RX43DOXV5MF4jJ9OeU3z7wa8PP473g=
Date: Mon, 11 May 2020 11:15:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 05/11] target/ppc: Restrict PPCVirtualHypervisorClass to
 system-mode
Message-ID: <20200511011527.GC2183@umbus.fritz.box>
References: <20200509130910.26335-1-f4bug@amsat.org>
 <20200509130910.26335-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <20200509130910.26335-6-f4bug@amsat.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 21:17:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 09, 2020 at 03:09:04PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The code related to PPC Virtual Hypervisor is pointless in user-mode.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/cpu.h                |  4 ++--
>  target/ppc/kvm_ppc.h            | 22 +++++++++++-----------
>  target/ppc/translate_init.inc.c |  4 ++++
>  3 files changed, 17 insertions(+), 13 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 6b6dd7e483..73920a9cac 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1176,6 +1176,7 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
>  PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
>  PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc);
> =20
> +#ifndef CONFIG_USER_ONLY
>  struct PPCVirtualHypervisorClass {
>      InterfaceClass parent;
>      void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
> @@ -1189,10 +1190,8 @@ struct PPCVirtualHypervisorClass {
>      void (*hpte_set_r)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64_t=
 pte1);
>      void (*get_pate)(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *entry);
>      target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
> -#ifndef CONFIG_USER_ONLY
>      void (*cpu_exec_enter)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
>      void (*cpu_exec_exit)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
> -#endif
>  };
> =20
>  #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
> @@ -1204,6 +1203,7 @@ struct PPCVirtualHypervisorClass {
>  #define PPC_VIRTUAL_HYPERVISOR_GET_CLASS(obj) \
>      OBJECT_GET_CLASS(PPCVirtualHypervisorClass, (obj), \
>                       TYPE_PPC_VIRTUAL_HYPERVISOR)
> +#endif /* CONFIG_USER_ONLY */
> =20
>  void ppc_cpu_do_interrupt(CPUState *cpu);
>  bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index fcaf745516..701c0c262b 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -280,6 +280,17 @@ static inline bool kvmppc_has_cap_spapr_vfio(void)
>      return false;
>  }
> =20
> +static inline void kvmppc_read_hptes(ppc_hash_pte64_t *hptes,
> +                                     hwaddr ptex, int n)
> +{
> +    abort();
> +}
> +
> +static inline void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_=
t pte1)
> +{
> +    abort();
> +}
> +
>  #endif /* !CONFIG_USER_ONLY */
> =20
>  static inline bool kvmppc_has_cap_epr(void)
> @@ -310,17 +321,6 @@ static inline int kvmppc_load_htab_chunk(QEMUFile *f=
, int fd, uint32_t index,
>      abort();
>  }
> =20
> -static inline void kvmppc_read_hptes(ppc_hash_pte64_t *hptes,
> -                                     hwaddr ptex, int n)
> -{
> -    abort();
> -}
> -
> -static inline void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_=
t pte1)
> -{
> -    abort();
> -}
> -
>  static inline bool kvmppc_has_cap_fixup_hcalls(void)
>  {
>      abort();
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 2b6e832c4c..4ea0cc501b 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10946,16 +10946,20 @@ static const TypeInfo ppc_cpu_type_info =3D {
>      .class_init =3D ppc_cpu_class_init,
>  };
> =20
> +#ifndef CONFIG_USER_ONLY
>  static const TypeInfo ppc_vhyp_type_info =3D {
>      .name =3D TYPE_PPC_VIRTUAL_HYPERVISOR,
>      .parent =3D TYPE_INTERFACE,
>      .class_size =3D sizeof(PPCVirtualHypervisorClass),
>  };
> +#endif
> =20
>  static void ppc_cpu_register_types(void)
>  {
>      type_register_static(&ppc_cpu_type_info);
> +#ifndef CONFIG_USER_ONLY
>      type_register_static(&ppc_vhyp_type_info);
> +#endif
>  }
> =20
>  type_init(ppc_cpu_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl64py8ACgkQbDjKyiDZ
s5KPpBAA5bxjqRBzOm3Urkc2h2bO+rwKrnVMha5YhWCCdA1YQEbRWTCrIEg/WRZF
w493kB3qwZ32Zx2kAA07QxMV7OXpklh1ORtIniK/uSwyrZpatOZ2LxaZEsS8eHwB
qLNnvIcOWz9v3HLeyWfM3tSI0I038PhTeJe0GKud4LyJXJt/Zhs+30WEfMUvt7Ep
Bjnpvnl/XPJ7O7VB0Cg3sOOK64mILGzIfFY09dr/1/mImORuU4Wn1eODcSEIKl5N
PPIhjGe0QJf0ei4hKTmYOVmd0lKWME1LTIUR/7xR0P16m96C3yQsW5dwgdZs5a+b
2uCzoZjzOk8UAYS8XNsFP2MGquBrmuSuRBqyDar1YdObjdvYIOvhApkNR7IUieyt
trj+dE0LO1y9Nl5O/EZ3+bBhNp0zfF/2c3j5GkSolvoyabmndBFHfzyDjtzfyXHd
JcAvwFSzCvZYV07IBFYqdCVmTMjBCXMI6n71Xu1vN8IahzlcEmhfoa4xJJ6JRHy1
7BKNZWwiiOVvrK80I9k9zv2pZLixP5EB4MWQ4HO/Ntgs8Uwf6qJ6ZEWU3MdqEiEF
qjOIHNZRfFLiboi/bFSrolBb5HsVj7V2/ng2BZOStktEtsjSYQqExVvs1+S10biZ
Owy8SXiV6S0Hc4ypwHIupsEH/ylN71ZFlZ6XzollvzBsUvLojrA=
=pbhG
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--

