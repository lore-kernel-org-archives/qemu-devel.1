Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C537EC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A26320726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A26320726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XVx-0007QM-Qg
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6XUb-0006St-3I
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6XUX-0008Nh-8j
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:31:09 -0500
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:33419)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6XUX-0008NM-2Q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:31:05 -0500
Received: from player730.ha.ovh.net (unknown [10.108.54.9])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 1DED480896
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 11:31:02 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id 3A893F966671;
 Tue, 25 Feb 2020 10:30:46 +0000 (UTC)
Date: Tue, 25 Feb 2020 11:30:44 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 05/18] target/ppc: Introduce ppc_hash64_use_vrma()
 helper
Message-ID: <20200225113044.06fb16b7@bahia.home>
In-Reply-To: <20200224233724.46415-6-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-6-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 17826936176359676390
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrledvgdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeftddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 10:37:11 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> When running guests under a hypervisor, the hypervisor obviously needs to
> be protected from guest accesses even if those are in what the guest
> considers real mode (translation off).  The POWER hardware provides two
> ways of doing that: The old way has guest real mode accesses simply offset
> and bounds checked into host addresses.  It works, but requires that a
> significant chunk of the guest's memory - the RMA - be physically
> contiguous in the host, which is pretty inconvenient.  The new way, known
> as VRMA, has guest real mode accesses translated in roughly the normal way
> but with some special parameters.
>=20
> In POWER7 and POWER8 the LPCR[VPM0] bit selected between the two modes, b=
ut
> in POWER9 only VRMA mode is supported and LPCR[VPM0] no longer exists.  We
> handle that difference in behaviour in ppc_hash64_set_isi().. but not in
> other places that we blindly check LPCR[VPM0].
>=20
> Correct those instances with a new helper to tell if we should be in VRMA
> mode.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/mmu-hash64.c | 43 ++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 392f90e0ae..e372c42add 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -668,6 +668,21 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU=
 *cpu,
>      return 0;
>  }
> =20
> +static bool ppc_hash64_use_vrma(CPUPPCState *env)
> +{
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        /*
> +         * ISAv3.0 (POWER9) always uses VRMA, the VPM0 field and RMOR
> +         * register no longer exist
> +         */
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
> @@ -676,15 +691,7 @@ static void ppc_hash64_set_isi(CPUState *cs, uint64_=
t error_code)
>      if (msr_ir) {
>          vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
>      } else {
> -        switch (env->mmu_model) {
> -        case POWERPC_MMU_3_00:
> -            /* Field deprecated in ISAv3.00 - interrupts always go to hy=
perv */
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
> @@ -702,15 +709,7 @@ static void ppc_hash64_set_dsi(CPUState *cs, uint64_=
t dar, uint64_t dsisr)
>      if (msr_dr) {
>          vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
>      } else {
> -        switch (env->mmu_model) {
> -        case POWERPC_MMU_3_00:
> -            /* Field deprecated in ISAv3.00 - interrupts always go to hy=
perv */
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
> @@ -799,7 +798,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
>              if (!(eaddr >> 63)) {
>                  raddr |=3D env->spr[SPR_HRMOR];
>              }
> -        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +        } else if (ppc_hash64_use_vrma(env)) {
>              /* Emulated VRMA mode */
>              slb =3D &env->vrma_slb;
>              if (!slb->sps) {
> @@ -967,7 +966,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu=
, target_ulong addr)
>          } else if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
>              /* In HV mode, add HRMOR if top EA bit is clear */
>              return raddr | env->spr[SPR_HRMOR];
> -        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +        } else if (ppc_hash64_use_vrma(env)) {
>              /* Emulated VRMA mode */
>              slb =3D &env->vrma_slb;
>              if (!slb->sps) {
> @@ -1056,8 +1055,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>      slb->sps =3D NULL;
> =20
>      /* Is VRMA enabled ? */
> -    lpcr =3D env->spr[SPR_LPCR];
> -    if (!(lpcr & LPCR_VPM0)) {
> +    if (!ppc_hash64_use_vrma(env)) {
>          return;
>      }
> =20
> @@ -1065,6 +1063,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>       * Make one up. Mostly ignore the ESID which will not be needed
>       * for translation
>       */
> +    lpcr =3D env->spr[SPR_LPCR];
>      vsid =3D SLB_VSID_VRMA;
>      vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
>      vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);


