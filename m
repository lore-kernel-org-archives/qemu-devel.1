Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B00FC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D367720674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D367720674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuBL-0002v8-1W
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jDton-0002Cm-4v
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jDtol-0006ye-PK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:25 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:43964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jDtol-0006iG-HU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:23 -0400
Received: from player738.ha.ovh.net (unknown [10.108.35.240])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2239F94431
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 18:46:20 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 460141097E395;
 Mon, 16 Mar 2020 17:46:13 +0000 (UTC)
Subject: Re: [PATCH v2 3/8] ppc/spapr: Add FWNMI System Reset state
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-4-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f1685657-31b1-b6e8-6b4f-98de0a2b01ec@kaod.org>
Date: Mon, 16 Mar 2020 18:46:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316142613.121089-4-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 13505169382724570086
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeffedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.53
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
 David Gibson <david@gibson.dropbear.id.au>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 3:26 PM, Nicholas Piggin wrote:
> The FWNMI option must deliver system reset interrupts to their
> registered address, and there are a few constraints on the handler
> addresses specified in PAPR. Add the system reset address state and
> checks.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

This is in sync with the latest PAPR 2.9

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_rtas.c    | 14 +++++++++++++-
>  include/hw/ppc/spapr.h |  3 ++-
>  3 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b03b26370d..5f93c49706 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1704,6 +1704,7 @@ static void spapr_machine_reset(MachineState *mac=
hine)
> =20
>      spapr->cas_reboot =3D false;
> =20
> +    spapr->fwnmi_system_reset_addr =3D -1;
>      spapr->fwnmi_machine_check_addr =3D -1;
>      spapr->fwnmi_machine_check_interlock =3D -1;
> =20
> @@ -2023,6 +2024,7 @@ static const VMStateDescription vmstate_spapr_fwn=
mi =3D {
>      .needed =3D spapr_fwnmi_needed,
>      .pre_save =3D spapr_fwnmi_pre_save,
>      .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(fwnmi_system_reset_addr, SpaprMachineState),
>          VMSTATE_UINT64(fwnmi_machine_check_addr, SpaprMachineState),
>          VMSTATE_INT32(fwnmi_machine_check_interlock, SpaprMachineState=
),
>          VMSTATE_END_OF_LIST()
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 0b8c481593..521e6b0b72 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -414,6 +414,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>                                    uint32_t nret, target_ulong rets)
>  {
>      hwaddr rtas_addr;
> +    target_ulong sreset_addr, mce_addr;
> =20
>      if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) =3D=3D SPAPR_CAP_OFF) {
>          rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> @@ -426,7 +427,18 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>          return;
>      }
> =20
> -    spapr->fwnmi_machine_check_addr =3D rtas_ld(args, 1);
> +    sreset_addr =3D rtas_ld(args, 0);
> +    mce_addr =3D rtas_ld(args, 1);
> +
> +    /* PAPR requires these are in the first 32M of memory and within R=
MA */
> +    if (sreset_addr >=3D 32 * MiB || sreset_addr >=3D spapr->rma_size =
||
> +           mce_addr >=3D 32 * MiB ||    mce_addr >=3D spapr->rma_size)=
 {
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    spapr->fwnmi_system_reset_addr =3D sreset_addr;
> +    spapr->fwnmi_machine_check_addr =3D mce_addr;
> =20
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 64b83402cb..42d64a0368 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -194,9 +194,10 @@ struct SpaprMachineState {
> =20
>      /* State related to FWNMI option */
> =20
> -    /* Machine Check Notification Routine address
> +    /* System Reset and Machine Check Notification Routine addresses
>       * registered by "ibm,nmi-register" RTAS call.
>       */
> +    target_ulong fwnmi_system_reset_addr;
>      target_ulong fwnmi_machine_check_addr;
> =20
>      /* Machine Check FWNMI synchronization, fwnmi_machine_check_interl=
ock is
>=20


