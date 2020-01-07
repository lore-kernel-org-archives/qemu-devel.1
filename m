Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477EDC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D448820715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D448820715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioq75-0000ry-00
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ioor7-0003bM-Pc
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ioor6-0002Df-4j
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:25:09 -0500
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:56020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ioor5-0002Bu-U3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:25:08 -0500
Received: from player699.ha.ovh.net (unknown [10.108.35.211])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 473A7794A8
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 14:25:05 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 55F54DEA9ABA;
 Tue,  7 Jan 2020 13:24:53 +0000 (UTC)
Subject: Re: [PATCH v2 04/10] target/ppc: Introduce ppc_hash64_use_vrma()
 helper
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 groug@kaod.org, philmd@redhat.com
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-5-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c0e48f0d-e495-549e-0835-4107d00be3bc@kaod.org>
Date: Tue, 7 Jan 2020 14:24:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107044827.471355-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9705257199232977702
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehgedgtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.233
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
Cc: aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-ppc@nongnu.org, lvivier@redhat.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 5:48 AM, David Gibson wrote:
> When running guests under a hypervisor, the hypervisor obviously needs =
to
> be protected from guest accesses even if those are in what the guest
> considers real mode (translation off).  The POWER hardware provides two
> ways of doing that: The old way has guest real mode accesses simply off=
set
> and bounds checked into host addresses.  It works, but requires that a
> significant chunk of the guest's memory - the RMA - be physically
> contiguous in the host, which is pretty inconvenient.  The new way, kno=
wn
> as VRMA, has guest real mode accesses translated in roughly the normal =
way
> but with some special parameters.
>=20
> In POWER7 and POWER8 the LPCR[VPM0] bit selected between the two modes,=
 but
> in POWER9 only VRMA mode is supported and LPCR[VPM0] no longer exists. =
 We
> handle that difference in behaviour in ppc_hash64_set_isi().. but not i=
n
> other places that we blindly check LPCR[VPM0].
>=20
> Correct those instances with a new helper to tell if we should be in VR=
MA
> mode.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  target/ppc/mmu-hash64.c | 41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 5fabd93c92..d878180df5 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -668,6 +668,19 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCC=
PU *cpu,
>      return 0;
>  }
> =20
> +static bool ppc_hash64_use_vrma(CPUPPCState *env)
> +{
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        /* ISAv3.0 (POWER9) always uses VRMA, the VPM0 field and RMOR
> +         * register no longer exist */
> +        return true;
> +
> +    default:
> +        return !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> +    }
> +}
> +
>  static void ppc_hash64_set_isi(CPUState *cs, uint64_t error_code)
>  {
>      CPUPPCState *env =3D &POWERPC_CPU(cs)->env;
> @@ -676,15 +689,7 @@ static void ppc_hash64_set_isi(CPUState *cs, uint6=
4_t error_code)
>      if (msr_ir) {
>          vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
>      } else {
> -        switch (env->mmu_model) {
> -        case POWERPC_MMU_3_00:
> -            /* Field deprecated in ISAv3.00 - interrupts always go to =
hyperv */
> -            vpm =3D true;
> -            break;
> -        default:
> -            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> -            break;
> -        }
> +        vpm =3D ppc_hash64_use_vrma(env);
>      }
>      if (vpm && !msr_hv) {
>          cs->exception_index =3D POWERPC_EXCP_HISI;
> @@ -702,15 +707,7 @@ static void ppc_hash64_set_dsi(CPUState *cs, uint6=
4_t dar, uint64_t dsisr)
>      if (msr_dr) {
>          vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
>      } else {
> -        switch (env->mmu_model) {
> -        case POWERPC_MMU_3_00:
> -            /* Field deprecated in ISAv3.00 - interrupts always go to =
hyperv */
> -            vpm =3D true;
> -            break;
> -        default:
> -            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> -            break;
> -        }
> +        vpm =3D ppc_hash64_use_vrma(env);
>      }
>      if (vpm && !msr_hv) {
>          cs->exception_index =3D POWERPC_EXCP_HDSI;
> @@ -799,7 +796,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr,
>              if (!(eaddr >> 63)) {
>                  raddr |=3D env->spr[SPR_HRMOR];
>              }
> -        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +        } else if (ppc_hash64_use_vrma(env)) {
>              /* Emulated VRMA mode */
>              slb =3D &env->vrma_slb;
>              if (!slb->sps) {
> @@ -967,7 +964,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *c=
pu, target_ulong addr)
>          } else if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
>              /* In HV mode, add HRMOR if top EA bit is clear */
>              return raddr | env->spr[SPR_HRMOR];
> -        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +        } else if (ppc_hash64_use_vrma(env)) {
>              /* Emulated VRMA mode */
>              slb =3D &env->vrma_slb;
>              if (!slb->sps) {
> @@ -1056,8 +1053,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cp=
u)
>      slb->sps =3D NULL;
> =20
>      /* Is VRMA enabled ? */
> -    lpcr =3D env->spr[SPR_LPCR];
> -    if (!(lpcr & LPCR_VPM0)) {
> +    if (ppc_hash64_use_vrma(env)) {
>          return;
>      }
> =20
> @@ -1065,6 +1061,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cp=
u)
>       * Make one up. Mostly ignore the ESID which will not be needed
>       * for translation
>       */
> +    lpcr =3D env->spr[SPR_LPCR];
>      vsid =3D SLB_VSID_VRMA;
>      vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
>      vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);
>=20


