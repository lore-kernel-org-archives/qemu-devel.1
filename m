Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7F6C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7859206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7859206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip6lp-0008DL-PX
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 03:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ip6ka-0006zW-Aw
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ip6kZ-0004B7-80
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:31:36 -0500
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:51050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ip6kZ-00047H-16
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:31:35 -0500
Received: from player762.ha.ovh.net (unknown [10.108.35.197])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 83F6F21CE3F
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 09:31:31 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player762.ha.ovh.net (Postfix) with ESMTPSA id E2FCBDF6C36F;
 Wed,  8 Jan 2020 08:31:21 +0000 (UTC)
Subject: Re: [PATCH v2 10/10] target/ppc: Only calculate RMLS derived RMA
 limit on demand
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 groug@kaod.org, philmd@redhat.com
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-11-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <01aa0955-570e-7e7b-c773-2d05611f62c1@kaod.org>
Date: Wed, 8 Jan 2020 09:31:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107044827.471355-11-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10620332348476459814
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehjedguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeivddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.33.112
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
> When the LPCR is written, we update the env->rmls field with the RMA li=
mit
> it implies.  Simplify things by just calculating the value directly fro=
m
> the LPCR value when we need it.
>=20
> It's possible this is a little slower, but it's unlikely to be signific=
ant,
> since this is only for real mode accesses in a translation configuratio=
n
> that's not used very often, and the whole thing is behind the qemu TLB
> anyway.  Therefore, keeping the number of state variables down and not
> having to worry about making sure it's always in sync seems the better
> option.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


> ---
>  target/ppc/cpu.h        | 1 -
>  target/ppc/mmu-hash64.c | 8 +++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 2de9e2fa2b..2a79b97bd8 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1075,7 +1075,6 @@ struct CPUPPCState {
>      uint64_t insns_flags2;
>  #if defined(TARGET_PPC64)
>      ppc_slb_t vrma_slb;
> -    target_ulong rmls;
>  #endif
> =20
>      int error_code;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index e6f24be93e..170a78bd2e 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -842,8 +842,10 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, v=
addr eaddr,
> =20
>              goto skip_slb_search;
>          } else {
> +            target_ulong limit =3D rmls_limit(cpu);
> +
>              /* Emulated old-style RMO mode, bounds check against RMLS =
*/
> -            if (raddr >=3D env->rmls) {
> +            if (raddr >=3D limit) {
>                  if (rwx =3D=3D 2) {
>                      ppc_hash64_set_isi(cs, SRR1_PROTFAULT);
>                  } else {
> @@ -1005,8 +1007,9 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU =
*cpu, target_ulong addr)
>                  return -1;
>              }
>          } else {
> +            target_ulong limit =3D rmls_limit(cpu);
>              /* Emulated old-style RMO mode, bounds check against RMLS =
*/
> -            if (raddr >=3D env->rmls) {
> +            if (raddr >=3D limit) {
>                  return -1;
>              }
>              return raddr | env->spr[SPR_RMOR];
> @@ -1096,7 +1099,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong=
 val)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
> -    env->rmls =3D rmls_limit(cpu);
>      ppc_hash64_update_vrma(cpu);
>  }
> =20
>=20


