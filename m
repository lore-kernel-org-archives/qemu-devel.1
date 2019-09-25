Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D95C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C902F20665
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C902F20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1hM-0003IM-Sr
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD1bT-0006Oo-T1
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD1bR-0007Hu-Og
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:20:47 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:53089)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD1bR-0007HI-JT
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:20:45 -0400
Received: from player737.ha.ovh.net (unknown [10.109.143.225])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8E9A0793CC
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:20:43 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 400E1C2C36E;
 Wed, 25 Sep 2019 07:20:33 +0000 (UTC)
Subject: Re: [PATCH 14/20] spapr: Remove unhelpful tracepoints from
 spapr_irq_free_xics()
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-15-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <09fac6dc-e05a-3425-5fd2-e1768fe2ff8e@kaod.org>
Date: Wed, 25 Sep 2019 09:20:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-15-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1534320099312438232
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.74.227
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
> These traces contain some useless information (the always-0 source#) an=
d
> have no equivalents for XIVE mode.  For now just remove them, and we ca=
n
> put back something more sensible if and when we need it.

yes. they were always in the way of other changes. =20

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_irq.c  | 4 ----
>  hw/ppc/trace-events | 4 ----
>  2 files changed, 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 79167ccc68..db6755f3ab 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -140,11 +140,7 @@ static void spapr_irq_free_xics(SpaprMachineState =
*spapr, int irq, int num)
>      int i;
> =20
>      if (ics_valid_irq(ics, irq)) {
> -        trace_spapr_irq_free(0, irq, num);
>          for (i =3D srcno; i < srcno + num; ++i) {
> -            if (ics_irq_free(ics, i)) {
> -                trace_spapr_irq_free_warn(0, i);
> -            }
>              memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
>          }
>      }
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 96dad767a1..9ea620f23c 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -13,10 +13,6 @@ spapr_pci_msi_retry(unsigned config_addr, unsigned r=
eq_num, unsigned max_irqs) "
>  spapr_cas_failed(unsigned long n) "DT diff buffer is too small: %ld by=
tes"
>  spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld by=
tes"
> =20
> -# spapr_irq.c
> -spapr_irq_free(int src, int irq, int num) "Source#%d, first irq %d, %d=
 irqs"
> -spapr_irq_free_warn(int src, int irq) "Source#%d, irq %d is already fr=
ee"
> -
>  # spapr_hcall.c
>  spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr)=
 "current=3D0x%x, explicit_match=3D%u, new=3D0x%x"
>  spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=3D0x=
%"PRIx64", shift=3D%"PRIu64
>=20


