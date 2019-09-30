Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EC6C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 05:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0E720815
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 05:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0E720815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEoBo-0005aG-92
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 01:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iEoAo-0004sd-23
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iEoAm-0006XC-Df
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:24:37 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:44823)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iEoAm-0006OE-70
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:24:36 -0400
Received: from player779.ha.ovh.net (unknown [10.109.160.217])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 6D9FD6985D
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 07:24:27 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id 43A9FA416B78;
 Mon, 30 Sep 2019 05:24:16 +0000 (UTC)
Subject: Re: [PATCH v2 20/33] spapr, xics, xive: Introduce
 SpaprInterruptController QOM interface
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-21-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f2257946-c83e-ec16-f31e-25da5c31eb03@kaod.org>
Date: Mon, 30 Sep 2019 07:24:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927055028.11493-21-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10487194684834417433
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgedugdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.73.241
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
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/09/2019 07:50, David Gibson wrote:
> The SpaprIrq structure is used to represent ths spapr machine's irq
> backend.  Except that it kind of conflates two concepts: one is the
> backend proper - a specific interrupt controller that we might or
> might not be using, the other is the irq configuration which covers
> the layout of irq space and which interrupt controllers are allowed.
>=20
> This leads to some pretty confusing code paths for the "dual"
> configuration where its hooks redirect to other SpaprIrq structures
> depending on the currently active irq controller.
>=20
> To clean this up, we start by introducing a new
> SpaprInterruptController QOM interface to represent strictly an
> interrupt controller backend, not counting anything configuration
> related.  We implement this interface in the XICs and XIVE interrupt
> controllers, and in future we'll move relevant methods from SpaprIrq
> into it.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/spapr_xive.c       |  4 ++++
>  hw/intc/xics_spapr.c       |  4 ++++
>  hw/ppc/spapr_irq.c         | 13 +++++++++++++
>  include/hw/ppc/spapr_irq.h | 14 ++++++++++++++
>  4 files changed, 35 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 04879abf2e..b67e9c3245 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -519,6 +519,10 @@ static const TypeInfo spapr_xive_info =3D {
>      .instance_init =3D spapr_xive_instance_init,
>      .instance_size =3D sizeof(SpaprXive),
>      .class_init =3D spapr_xive_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_SPAPR_INTC },
> +        { }
> +    },
>  };
> =20
>  static void spapr_xive_register_types(void)
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 6e5eb24b3c..4874e6be55 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -343,6 +343,10 @@ static const TypeInfo ics_spapr_info =3D {
>      .name =3D TYPE_ICS_SPAPR,
>      .parent =3D TYPE_ICS,
>      .class_init =3D ics_spapr_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_SPAPR_INTC },
> +        { }
> +    },
>  };
> =20
>  static void xics_spapr_register_types(void)
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 5e448b1fd4..0603c82fe8 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -23,6 +23,12 @@
> =20
>  #include "trace.h"
> =20
> +static const TypeInfo spapr_intc_info =3D {
> +    .name =3D TYPE_SPAPR_INTC,
> +    .parent =3D TYPE_INTERFACE,
> +    .class_size =3D sizeof(SpaprInterruptControllerClass),
> +};
> +
>  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis)
>  {
>      spapr->irq_map_nr =3D nr_msis;
> @@ -763,3 +769,10 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .set_irq     =3D spapr_irq_set_irq_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
>  };
> +
> +static void spapr_irq_register_types(void)
> +{
> +    type_register_static(&spapr_intc_info);
> +}
> +
> +type_init(spapr_irq_register_types)
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 69a37f608e..b9398e0be3 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -31,6 +31,20 @@
> =20
>  typedef struct SpaprMachineState SpaprMachineState;
> =20
> +typedef struct SpaprInterruptController SpaprInterruptController;
> +
> +#define TYPE_SPAPR_INTC "spapr-interrupt-controller"
> +#define SPAPR_INTC(obj)                                     \
> +    INTERFACE_CHECK(SpaprInterruptController, (obj), TYPE_SPAPR_INTC)
> +#define SPAPR_INTC_CLASS(klass)                                     \
> +    OBJECT_CLASS_CHECK(SpaprInterruptControllerClass, (klass), TYPE_SP=
APR_INTC)
> +#define SPAPR_INTC_GET_CLASS(obj)                                   \
> +    OBJECT_GET_CLASS(SpaprInterruptControllerClass, (obj), TYPE_SPAPR_=
INTC)
> +
> +typedef struct SpaprInterruptControllerClass {
> +    InterfaceClass parent;
> +} SpaprInterruptControllerClass;
> +
>  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
>  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool a=
lign,
>                          Error **errp);
>=20


