Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E24EC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274E62087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274E62087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqSw-0003Zx-V7
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iopxW-0000dH-GA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iopxT-0002RJ-VD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:35:50 -0500
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:51729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iopxT-0002QA-PO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:35:47 -0500
Received: from player739.ha.ovh.net (unknown [10.108.35.223])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 32B41265C54
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 15:35:44 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player739.ha.ovh.net (Postfix) with ESMTPSA id A210A9ED3A9E;
 Tue,  7 Jan 2020 14:35:34 +0000 (UTC)
Subject: Re: [PATCH v2 05/10] spapr, ppc: Remove VPM0/RMLS hacks for POWER9
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 groug@kaod.org, philmd@redhat.com
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-6-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0e3fa283-fa6e-61bb-f94e-c5b9dc780bad@kaod.org>
Date: Tue, 7 Jan 2020 15:35:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107044827.471355-6-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10898711099699858214
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehgedgvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.96.204
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
> For the "pseries" machine, we use "virtual hypervisor" mode where we on=
ly
> model the CPU in non-hypervisor privileged mode.  This means that we ne=
ed
> guest physical addresses within the modelled within the cpu to be treat=
ed
> as absolute physical addresses.
>=20
> We used to do that by clearing LPCR[VPM0] and setting LPCR[RMLS] to a h=
igh
> limit so that the old offset based translation for guest mode applied,
> which does what we need.  However, POWER9 has removed support for that
> translation mode, which meant we had some ugly hacks to keep it working=
.
>=20
> We now explicitly handle this sort of translation for virtual hyperviso=
r
> mode, so the hacks aren't necessary.  We don't need to set VPM0 and RML=
S
> from the machine type code - they're now ignored in vhyp mode.  On the =
cpu
> side we don't need to allow LPCR[RMLS] to be set on POWER9 in vhyp mode=
 -
> that was only there to allow the hack on the machine side.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_cpu_core.c | 6 +-----
>  target/ppc/mmu-hash64.c | 8 --------
>  2 files changed, 1 insertion(+), 13 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 8339c4c0f8..daebcd9f38 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -58,14 +58,10 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>       * we don't get spurious wakups before an RTAS start-cpu call.
>       * For the same reason, set PSSCR_EC.
>       */
> -    lpcr &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpc=
r_pm);
> +    lpcr &=3D ~(LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpcr_pm);
>      lpcr |=3D LPCR_LPES0 | LPCR_LPES1;
>      env->spr[SPR_PSSCR] |=3D PSSCR_EC;
> =20
> -    /* Set RMLS to the max (ie, 16G) */
> -    lpcr &=3D ~LPCR_RMLS;
> -    lpcr |=3D 1ull << LPCR_RMLS_SHIFT;
> -
>      ppc_store_lpcr(cpu, lpcr);
> =20
>      /* Set a full AMOR so guest can use the AMR as it sees fit */
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index d878180df5..d7f9933e6d 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1124,14 +1124,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulon=
g val)
>                        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPC=
R_EEE |
>                        LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | L=
PCR_TC |
>                        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE=
);
> -        /*
> -         * If we have a virtual hypervisor, we need to bring back RMLS=
. It
> -         * doesn't exist on an actual P9 but that's all we know how to
> -         * configure with softmmu at the moment
> -         */
> -        if (cpu->vhyp) {
> -            lpcr |=3D (val & LPCR_RMLS);
> -        }
>          break;
>      default:
>          g_assert_not_reached();
>=20


