Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659BAC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96EF207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96EF207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJOK-0007oC-Fl
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1irJM6-00058v-Ii
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:23:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1irJM2-0007iu-B0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:23:25 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:48161)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1irJM2-0007co-1k
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:23:22 -0500
Received: from player692.ha.ovh.net (unknown [10.109.146.1])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 296DF1F7B1B
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 11:23:12 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 3E240E0EA69A;
 Tue, 14 Jan 2020 10:23:02 +0000 (UTC)
Subject: Re: [PATCH v2 03/10] target/ppc: Correct handling of real mode
 accesses with vhyp on hash MMU
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 groug@kaod.org, philmd@redhat.com
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-4-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6452c163-b2e4-ab9f-3117-4a19aad3e04e@kaod.org>
Date: Tue, 14 Jan 2020 11:22:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107044827.471355-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10849171504429828902
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdejvddgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.139.208
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
> On ppc we have the concept of virtual hypervisor ("vhyp") mode, where w=
e
> only model the non-hypervisor-privileged parts of the cpu.  Essentially=
 we
> model the hypervisor's behaviour from the point of view of a guest OS, =
but
> we don't model the hypervisor's execution.
>=20
> In particular, in this mode, qemu's notion of target physical address i=
s
> a guest physical address from the vcpu's point of view.  So accesses in
> guest real mode don't require translation.  If we were modelling the
> hypervisor mode, we'd need to translate the guest physical address into
> a host physical address.
>=20
> Currently, we handle this sloppily: we rely on setting up the virtual L=
PCR
> and RMOR registers so that GPAs are simply HPAs plus an offset, which w=
e
> set to zero.  This is already conceptually dubious, since the LPCR and =
RMOR
> registers don't exist in the non-hypervisor portion of the CPU.  It get=
s
> worse with POWER9, where RMOR and LPCR[VPM0] no longer exist at all.
>=20
> Clean this up by explicitly handling the vhyp case.  While we're there,
> remove some unnecessary nesting of if statements that made the logic to
> select the correct real mode behaviour a bit less clear than it could b=
e.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

I went through the changes and they look correct to me.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.

> ---
>  target/ppc/mmu-hash64.c | 60 ++++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index a881876647..5fabd93c92 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -789,27 +789,30 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, =
vaddr eaddr,
>           */
>          raddr =3D eaddr & 0x0FFFFFFFFFFFFFFFULL;
> =20
> -        /* In HV mode, add HRMOR if top EA bit is clear */
> -        if (msr_hv || !env->has_hv_mode) {
> +        if (cpu->vhyp) {
> +            /*
> +             * In virtual hypervisor mode, there's nothing to do:
> +             *   EA =3D=3D GPA =3D=3D qemu guest address
> +             */
> +        } else if (msr_hv || !env->has_hv_mode) {
> +            /* In HV mode, add HRMOR if top EA bit is clear */
>              if (!(eaddr >> 63)) {
>                  raddr |=3D env->spr[SPR_HRMOR];
>              }
> -        } else {
> -            /* Otherwise, check VPM for RMA vs VRMA */
> -            if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> -                slb =3D &env->vrma_slb;
> -                if (slb->sps) {
> -                    goto skip_slb_search;
> -                }
> -                /* Not much else to do here */
> +        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +            /* Emulated VRMA mode */
> +            slb =3D &env->vrma_slb;
> +            if (!slb->sps) {
> +                /* Invalid VRMA setup, machine check */
>                  cs->exception_index =3D POWERPC_EXCP_MCHECK;
>                  env->error_code =3D 0;
>                  return 1;
> -            } else if (raddr < env->rmls) {
> -                /* RMA. Check bounds in RMLS */
> -                raddr |=3D env->spr[SPR_RMOR];
> -            } else {
> -                /* The access failed, generate the approriate interrup=
t */
> +            }
> +
> +            goto skip_slb_search;
> +        } else {
> +            /* Emulated old-style RMO mode, bounds check against RMLS =
*/
> +            if (raddr >=3D env->rmls) {
>                  if (rwx =3D=3D 2) {
>                      ppc_hash64_set_isi(cs, SRR1_PROTFAULT);
>                  } else {
> @@ -821,6 +824,8 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr,
>                  }
>                  return 1;
>              }
> +
> +            raddr |=3D env->spr[SPR_RMOR];
>          }
>          tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE=
_MASK,
>                       PAGE_READ | PAGE_WRITE | PAGE_EXEC, mmu_idx,
> @@ -953,22 +958,27 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU =
*cpu, target_ulong addr)
>          /* In real mode the top 4 effective address bits are ignored *=
/
>          raddr =3D addr & 0x0FFFFFFFFFFFFFFFULL;
> =20
> -        /* In HV mode, add HRMOR if top EA bit is clear */
> -        if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
> +        if (cpu->vhyp) {
> +            /*
> +             * In virtual hypervisor mode, there's nothing to do:
> +             *   EA =3D=3D GPA =3D=3D qemu guest address
> +             */
> +            return raddr;
> +        } else if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
> +            /* In HV mode, add HRMOR if top EA bit is clear */
>              return raddr | env->spr[SPR_HRMOR];
> -        }
> -
> -        /* Otherwise, check VPM for RMA vs VRMA */
> -        if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +            /* Emulated VRMA mode */
>              slb =3D &env->vrma_slb;
>              if (!slb->sps) {
>                  return -1;
>              }
> -        } else if (raddr < env->rmls) {
> -            /* RMA. Check bounds in RMLS */
> -            return raddr | env->spr[SPR_RMOR];
>          } else {
> -            return -1;
> +            /* Emulated old-style RMO mode, bounds check against RMLS =
*/
> +            if (raddr >=3D env->rmls) {
> +                return -1;
> +            }
> +            return raddr | env->spr[SPR_RMOR];
>          }
>      } else {
>          slb =3D slb_lookup(cpu, addr);
>=20


