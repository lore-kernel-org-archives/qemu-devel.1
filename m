Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21440C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC0B2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC0B2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1wK-0001Dq-9D
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD1e1-0000i2-Hd
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD1e0-0008B7-0D
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:23:25 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:44359)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD1dz-0008AB-Q1
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:23:23 -0400
Received: from player738.ha.ovh.net (unknown [10.109.146.86])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id EEF8420882F
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:23:21 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 22ACBA516AF0;
 Wed, 25 Sep 2019 07:23:12 +0000 (UTC)
Subject: Re: [PATCH 17/20] spapr: Remove unused return value in claim path
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-18-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2f2f5437-d0c4-8c05-cb1f-584a35fd95db@kaod.org>
Date: Wed, 25 Sep 2019 09:23:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-18-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1578793145168071640
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.121.62.11
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
> spapr_irq_claim() and the hooks it is based on return an integer error =
code
> as well as taking an Error ** parameter.  But none of the callers check=
 the
> integer, so we can remove it and just use the richer Error **.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_irq.c         | 32 +++++++++++++-------------------
>  include/hw/ppc/spapr_irq.h |  4 ++--
>  2 files changed, 15 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 261d66ba17..2673a90604 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -112,8 +112,8 @@ static void spapr_irq_init_xics(SpaprMachineState *=
spapr, Error **errp)
>      spapr->ics =3D ICS_SPAPR(obj);
>  }
> =20
> -static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, boo=
l lsi,
> -                                Error **errp)
> +static void spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> +                                 Error **errp)
>  {
>      ICSState *ics =3D spapr->ics;
> =20
> @@ -122,11 +122,10 @@ static int spapr_irq_claim_xics(SpaprMachineState=
 *spapr, int irq, bool lsi,
> =20
>      if (!ics_irq_free(ics, irq - ics->offset)) {
>          error_setg(errp, "IRQ %d is not free", irq);
> -        return -1;
> +        return;
>      }
> =20
>      ics_set_irq_type(ics, irq - ics->offset, lsi);
> -    return 0;
>  }
> =20
>  static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq)
> @@ -252,14 +251,12 @@ static void spapr_irq_init_xive(SpaprMachineState=
 *spapr, Error **errp)
>      spapr_xive_hcall_init(spapr);
>  }
> =20
> -static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, boo=
l lsi,
> -                                Error **errp)
> +static void spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> +                                 Error **errp)
>  {
>      if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
>          error_setg(errp, "IRQ %d is invalid", irq);
> -        return -1;
>      }
> -    return 0;
>  }
> =20
>  static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
> @@ -406,25 +403,22 @@ static void spapr_irq_init_dual(SpaprMachineState=
 *spapr, Error **errp)
>      }
>  }
> =20
> -static int spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, boo=
l lsi,
> -                                Error **errp)
> +static void spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> +                                 Error **errp)
>  {
>      Error *local_err =3D NULL;
> -    int ret;
> =20
> -    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
> +    spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        return ret;
> +        return;
>      }
> =20
> -    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
> +    spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        return ret;
> +        return;
>      }
> -
> -    return ret;
>  }
> =20
>  static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq)
> @@ -622,12 +616,12 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
>                                        spapr->irq->nr_xirqs + SPAPR_XIR=
Q_BASE);
>  }
> =20
> -int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
> +void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Erro=
r **errp)
>  {
>      assert(irq >=3D SPAPR_XIRQ_BASE);
>      assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> =20
> -    return spapr->irq->claim(spapr, irq, lsi, errp);
> +    spapr->irq->claim(spapr, irq, lsi, errp);
>  }
> =20
>  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index ed88b4599a..75279ca137 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -42,7 +42,7 @@ typedef struct SpaprIrq {
>      uint8_t     ov5;
> =20
>      void (*init)(SpaprMachineState *spapr, Error **errp);
> -    int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **=
errp);
> +    void (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp);
>      void (*free)(SpaprMachineState *spapr, int irq);
>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
> @@ -61,7 +61,7 @@ extern SpaprIrq spapr_irq_xive;
>  extern SpaprIrq spapr_irq_dual;
> =20
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp);
> -int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp);
> +void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Erro=
r **errp);
>  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num);
>  qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq);
>  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id);
>=20


