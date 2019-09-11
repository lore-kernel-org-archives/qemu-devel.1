Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC8EC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318F820863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318F820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51475 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83Md-0002dT-5s
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i83KU-0000iw-Qt
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i83KQ-0004B2-OL
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:10:42 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:56080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i83KQ-0004AB-86
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:10:38 -0400
Received: from player796.ha.ovh.net (unknown [10.109.160.5])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 1FDCC24DC92
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 16:10:35 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player796.ha.ovh.net (Postfix) with ESMTPSA id 76C32999E1BD;
 Wed, 11 Sep 2019 14:10:29 +0000 (UTC)
Date: Wed, 11 Sep 2019 16:09:07 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Message-ID: <20190911160907.7b81a2c8@bahia.lan>
In-Reply-To: <20190911133937.2716-2-clg@kaod.org>
References: <20190911133937.2716-1-clg@kaod.org>
 <20190911133937.2716-2-clg@kaod.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 25614224284424587
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdefgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.182.191
Subject: Re: [Qemu-devel] [PATCH v2 1/2] spapr/irq: Introduce an
 ics_irq_free() helper
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
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 15:39:36 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> It will help us to discard interrupt numbers which have not been
> claimed in the next patch.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/xics.h | 5 +++++
>  hw/ppc/spapr_irq.c    | 9 +++------
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index f2a8d6a4b4f9..64a2c8862a72 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -179,6 +179,11 @@ void ics_simple_write_xive(ICSState *ics, int nr, in=
t server,
>                             uint8_t priority, uint8_t saved_priority);
>  void ics_simple_set_irq(void *opaque, int srcno, int val);
> =20
> +static inline bool ics_irq_free(ICSState *ics, uint32_t srcno)
> +{
> +    return !(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK);
> +}
> +
>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
>  void icp_pic_print_info(ICPState *icp, Monitor *mon);
>  void ics_pic_print_info(ICSState *ics, Monitor *mon);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 06fe2432bae5..d8f46b6797f8 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -114,9 +114,6 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
>      xics_spapr_init(spapr);
>  }
> =20
> -#define ICS_IRQ_FREE(ics, srcno)   \
> -    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
> -
>  static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool =
lsi,
>                                  Error **errp)
>  {
> @@ -129,7 +126,7 @@ static int spapr_irq_claim_xics(SpaprMachineState *sp=
apr, int irq, bool lsi,
>          return -1;
>      }
> =20
> -    if (!ICS_IRQ_FREE(ics, irq - ics->offset)) {
> +    if (!ics_irq_free(ics, irq - ics->offset)) {
>          error_setg(errp, "IRQ %d is not free", irq);
>          return -1;
>      }
> @@ -147,7 +144,7 @@ static void spapr_irq_free_xics(SpaprMachineState *sp=
apr, int irq, int num)
>      if (ics_valid_irq(ics, irq)) {
>          trace_spapr_irq_free(0, irq, num);
>          for (i =3D srcno; i < srcno + num; ++i) {
> -            if (ICS_IRQ_FREE(ics, i)) {
> +            if (ics_irq_free(ics, i)) {
>                  trace_spapr_irq_free_warn(0, i);
>              }
>              memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
> @@ -767,7 +764,7 @@ static int ics_find_free_block(ICSState *ics, int num=
, int alignnum)
>              return -1;
>          }
>          for (i =3D first; i < first + num; ++i) {
> -            if (!ICS_IRQ_FREE(ics, i)) {
> +            if (!ics_irq_free(ics, i)) {
>                  break;
>              }
>          }


