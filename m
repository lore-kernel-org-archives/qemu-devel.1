Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE26C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03F120672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03F120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXpRw-0004u6-Nh
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 11:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXpQS-0003ND-FD
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXpQQ-00045w-Tr
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:35:24 -0500
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:37137)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXpQQ-00043M-N4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:35:22 -0500
Received: from player694.ha.ovh.net (unknown [10.108.42.196])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 1D43B22C686
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 17:35:19 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id 79604C51FA12;
 Thu, 21 Nov 2019 16:35:04 +0000 (UTC)
Subject: Re: [PATCH 5/5] spapr: Work around spurious warnings from vfio INTx
 initialization
To: David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20191121005607.274347-1-david@gibson.dropbear.id.au>
 <20191121005607.274347-6-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0819835c-c066-af2f-79dd-a094d4d281ae@kaod.org>
Date: Thu, 21 Nov 2019 17:35:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121005607.274347-6-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 13602841201740909557
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehvddgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.43.173
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/11/2019 01:56, David Gibson wrote:
> Traditional PCI INTx for vfio devices can only perform well if using
> an in-kernel irqchip.  Therefore, vfio_intx_update() issues a warning
> if an in kernel irqchip is not available.
>=20
> We usually do have an in-kernel irqchip available for pseries machines
> on POWER hosts.  However, because the platform allows feature
> negotiation of what interrupt controller model to use, we don't
> currently initialize it until machine reset.  vfio_intx_update() is
> called (first) from vfio_realize() before that, so it can issue a
> spurious warning, even if we will have an in kernel irqchip by the
> time we need it.
>=20
> To workaround this, make a call to spapr_irq_update_active_intc() from
> spapr_irq_init() which is called at machine realize time, before the
> vfio realize.  This call will be pretty much obsoleted by the later
> call at reset time, but it serves to suppress the spurious warning
> from VFIO.
>=20
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_irq.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 1d27034962..d6bb7fd2d6 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -373,6 +373,14 @@ void spapr_irq_init(SpaprMachineState *spapr, Erro=
r **errp)
> =20
>      spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
>                                        smc->nr_xirqs + SPAPR_XIRQ_BASE)=
;
> +
> +    /*
> +     * Mostly we don't actually need this until reset, except that not
> +     * having this set up can cause VFIO devices to issue a
> +     * false-positive warning during realize(), because they don't yet
> +     * have an in-kernel irq chip.
> +     */
> +    spapr_irq_update_active_intc(spapr);
>  }
> =20
>  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
> @@ -528,7 +536,8 @@ void spapr_irq_update_active_intc(SpaprMachineState=
 *spapr)
>           * this.
>           */
>          new_intc =3D SPAPR_INTC(spapr->xive);
> -    } else if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +    } else if (spapr->ov5_cas
> +               && spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
>          new_intc =3D SPAPR_INTC(spapr->xive);
>      } else {
>          new_intc =3D SPAPR_INTC(spapr->ics);
>=20


