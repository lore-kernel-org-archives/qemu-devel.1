Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C0CC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6072054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6072054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1zV-00046I-LD
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD1j2-0005v0-BA
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD1j0-0001Jq-KS
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:28:35 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:59635)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD1j0-0001JK-Dd
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:28:34 -0400
Received: from player699.ha.ovh.net (unknown [10.108.35.13])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 1ECEC1437A7
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:28:31 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 2A5E0A30640D;
 Wed, 25 Sep 2019 07:28:21 +0000 (UTC)
Subject: Re: [PATCH 19/20] spapr: Use less cryptic representation of which irq
 backends are supported
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-20-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a47713e7-eff1-3cf3-230c-b32d8a700b7a@kaod.org>
Date: Wed, 25 Sep 2019 09:28:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-20-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1666050389663255512
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.36.149
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/2019 08:45, David Gibson wrote:
> SpaprIrq::ov5 stores the value for a particular byte in PAPR option vec=
tor
> 5 which indicates whether XICS, XIVE or both interrupt controllers are
> available.  As usual for PAPR, the encoding is kind of overly complicat=
ed
> and confusing (though to be fair there are some backwards compat things=
 it
> has to handle).
>=20
> But to make our internal code clearer, have SpaprIrq encode more direct=
ly
> which backends are available as two booleans, and derive the OV5 value =
from
> that at the point we need it.

OK. It looks nice.
=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


> ---
>  hw/ppc/spapr.c             | 15 ++++++++++++---
>  hw/ppc/spapr_hcall.c       |  6 +++---
>  hw/ppc/spapr_irq.c         | 12 ++++++++----
>  include/hw/ppc/spapr_irq.h |  3 ++-
>  4 files changed, 25 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3742a8cf06..795f6ab505 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1136,19 +1136,28 @@ static void spapr_dt_ov5_platform_support(Spapr=
MachineState *spapr, void *fdt,
>      PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> =20
>      char val[2 * 4] =3D {
> -        23, spapr->irq->ov5, /* Xive mode. */
> +        23, 0x00, /* XICS / XIVE mode */
>          24, 0x00, /* Hash/Radix, filled in below. */
>          25, 0x00, /* Hash options: Segment Tables =3D=3D no, GTSE =3D=3D=
 no. */
>          26, 0x40, /* Radix options: GTSE =3D=3D yes. */
>      };
> =20
> +    if (spapr->irq->xics && spapr->irq->xive) {
> +        val[1] =3D SPAPR_OV5_XIVE_BOTH;
> +    } else if (spapr->irq->xive) {
> +        val[1] =3D SPAPR_OV5_XIVE_EXPLOIT;
> +    } else {
> +        assert(spapr->irq->xics);
> +        val[1] =3D SPAPR_OV5_XIVE_LEGACY;
> +    }
> +
>      if (!ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
>                            first_ppc_cpu->compat_pvr)) {
>          /*
>           * If we're in a pre POWER9 compat mode then the guest should
>           * do hash and use the legacy interrupt mode
>           */
> -        val[1] =3D 0x00; /* XICS */
> +        val[1] =3D SPAPR_OV5_XIVE_LEGACY; /* XICS */
>          val[3] =3D 0x00; /* Hash */
>      } else if (kvm_enabled()) {
>          if (kvmppc_has_cap_mmu_radix() && kvmppc_has_cap_mmu_hash_v3()=
) {
> @@ -2837,7 +2846,7 @@ static void spapr_machine_init(MachineState *mach=
ine)
>      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
> =20
>      /* advertise XIVE on POWER9 machines */
> -    if (spapr->irq->ov5 & (SPAPR_OV5_XIVE_EXPLOIT | SPAPR_OV5_XIVE_BOT=
H)) {
> +    if (spapr->irq->xive) {
>          spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
>      }
> =20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 3d3a67149a..140f05c1c6 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1784,13 +1784,13 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
>       * terminate the boot.
>       */
>      if (guest_xive) {
> -        if (spapr->irq->ov5 =3D=3D SPAPR_OV5_XIVE_LEGACY) {
> +        if (!spapr->irq->xive) {
>              error_report(
>  "Guest requested unavailable interrupt mode (XIVE), try the ic-mode=3D=
xive or ic-mode=3Ddual machine property");
>              exit(EXIT_FAILURE);
>          }
>      } else {
> -        if (spapr->irq->ov5 =3D=3D SPAPR_OV5_XIVE_EXPLOIT) {
> +        if (!spapr->irq->xics) {
>              error_report(
>  "Guest requested unavailable interrupt mode (XICS), either don't set t=
he ic-mode machine property or try ic-mode=3Dxics or ic-mode=3Ddual");
>              exit(EXIT_FAILURE);
> @@ -1804,7 +1804,7 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
>       */
>      if (!spapr->cas_reboot) {
>          spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EX=
PLOIT)
> -            && spapr->irq->ov5 & SPAPR_OV5_XIVE_BOTH;
> +            && spapr->irq->xics && spapr->irq->xive;
>      }
> =20
>      spapr_ovec_cleanup(ov5_updates);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index f53544e45e..073f375ba2 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -209,7 +209,8 @@ static void spapr_irq_init_kvm_xics(SpaprMachineSta=
te *spapr, Error **errp)
>  SpaprIrq spapr_irq_xics =3D {
>      .nr_xirqs    =3D SPAPR_NR_XIRQS,
>      .nr_msis     =3D SPAPR_NR_MSIS,
> -    .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
> +    .xics        =3D true,
> +    .xive        =3D false,
> =20
>      .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,
> @@ -357,7 +358,8 @@ static void spapr_irq_init_kvm_xive(SpaprMachineSta=
te *spapr, Error **errp)
>  SpaprIrq spapr_irq_xive =3D {
>      .nr_xirqs    =3D SPAPR_NR_XIRQS,
>      .nr_msis     =3D SPAPR_NR_MSIS,
> -    .ov5         =3D SPAPR_OV5_XIVE_EXPLOIT,
> +    .xics        =3D false,
> +    .xive        =3D true,
> =20
>      .init        =3D spapr_irq_init_xive,
>      .claim       =3D spapr_irq_claim_xive,
> @@ -515,7 +517,8 @@ static void spapr_irq_set_irq_dual(void *opaque, in=
t irq, int val)
>  SpaprIrq spapr_irq_dual =3D {
>      .nr_xirqs    =3D SPAPR_NR_XIRQS,
>      .nr_msis     =3D SPAPR_NR_MSIS,
> -    .ov5         =3D SPAPR_OV5_XIVE_BOTH,
> +    .xics        =3D true,
> +    .xive        =3D true,
> =20
>      .init        =3D spapr_irq_init_dual,
>      .claim       =3D spapr_irq_claim_dual,
> @@ -751,7 +754,8 @@ int spapr_irq_find(SpaprMachineState *spapr, int nu=
m, bool align, Error **errp)
>  SpaprIrq spapr_irq_xics_legacy =3D {
>      .nr_xirqs    =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
>      .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
> -    .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
> +    .xics        =3D true,
> +    .xive        =3D false,
> =20
>      .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 75279ca137..6816cb0500 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -39,7 +39,8 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, int=
 irq, uint32_t num);
>  typedef struct SpaprIrq {
>      uint32_t    nr_xirqs;
>      uint32_t    nr_msis;
> -    uint8_t     ov5;
> +    bool        xics;
> +    bool        xive;
> =20
>      void (*init)(SpaprMachineState *spapr, Error **errp);
>      void (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp);
>=20


