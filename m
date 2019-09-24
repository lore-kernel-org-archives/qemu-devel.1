Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB83EC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6062064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6062064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCdKG-0004ut-Pz
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 01:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iCdJ2-00041x-DW
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iCdJ0-00065i-Uv
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:24:08 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:55910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iCdIx-00063E-Hv
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:24:04 -0400
Received: from player688.ha.ovh.net (unknown [10.108.54.94])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 20626208272
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 07:23:59 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 27A64A10E125;
 Tue, 24 Sep 2019 05:23:56 +0000 (UTC)
Subject: Re: [PATCH 1/4] xics: Eliminate 'reject', 'resend' and 'eoi' class
 hooks
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <20190924045952.11412-2-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a90952f0-3647-9b1f-cbbe-2744a24091a5@kaod.org>
Date: Tue, 24 Sep 2019 07:23:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924045952.11412-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 12136919524700621576
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdelgdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.176
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
Cc: gkurz@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/2019 06:59, David Gibson wrote:
> Currently ics_reject(), ics_resend() and ics_eoi() indirect through
> class methods.  But there's only one implementation of each method,
> the one in TYPE_ICS_SIMPLE.  TYPE_ICS_BASE has no implementation, but
> it's never instantiated, and has no other subtypes.
>=20
> So clean up by eliminating the method and just having ics_reject(),
> ics_resend() and ics_eoi() contain the logic directly.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.


> ---
>  hw/intc/trace-events  |  4 ++--
>  hw/intc/xics.c        | 54 +++++++++++--------------------------------
>  include/hw/ppc/xics.h |  4 ----
>  3 files changed, 15 insertions(+), 47 deletions(-)
>=20
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 719f46b516..fdc716c2cc 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -70,8 +70,8 @@ xics_ics_simple_set_irq_msi(int srcno, int nr) "set_i=
rq_msi: srcno %d [irq 0x%x]
>  xics_masked_pending(void) "set_irq_msi: masked pending"
>  xics_ics_simple_set_irq_lsi(int srcno, int nr) "set_irq_lsi: srcno %d =
[irq 0x%x]"
>  xics_ics_simple_write_xive(int nr, int srcno, int server, uint8_t prio=
rity) "ics_write_xive: irq 0x%x [src %d] server 0x%x prio 0x%x"
> -xics_ics_simple_reject(int nr, int srcno) "reject irq 0x%x [src %d]"
> -xics_ics_simple_eoi(int nr) "ics_eoi: irq 0x%x"
> +xics_ics_reject(int nr, int srcno) "reject irq 0x%x [src %d]"
> +xics_ics_eoi(int nr) "ics_eoi: irq 0x%x"
> =20
>  # s390_flic_kvm.c
>  flic_create_device(int err) "flic: create device failed %d"
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index b2fca2975c..93139b0189 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -98,32 +98,8 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
>  #define XISR(icp)   (((icp)->xirr) & XISR_MASK)
>  #define CPPR(icp)   (((icp)->xirr) >> 24)
> =20
> -static void ics_reject(ICSState *ics, uint32_t nr)
> -{
> -    ICSStateClass *k =3D ICS_BASE_GET_CLASS(ics);
> -
> -    if (k->reject) {
> -        k->reject(ics, nr);
> -    }
> -}
> -
> -void ics_resend(ICSState *ics)
> -{
> -    ICSStateClass *k =3D ICS_BASE_GET_CLASS(ics);
> -
> -    if (k->resend) {
> -        k->resend(ics);
> -    }
> -}
> -
> -static void ics_eoi(ICSState *ics, int nr)
> -{
> -    ICSStateClass *k =3D ICS_BASE_GET_CLASS(ics);
> -
> -    if (k->eoi) {
> -        k->eoi(ics, nr);
> -    }
> -}
> +static void ics_reject(ICSState *ics, uint32_t nr);
> +static void ics_eoi(ICSState *ics, uint32_t nr);
> =20
>  static void icp_check_ipi(ICPState *icp)
>  {
> @@ -427,7 +403,7 @@ Object *icp_create(Object *cpu, const char *type, X=
ICSFabric *xi, Error **errp)
>  /*
>   * ICS: Source layer
>   */
> -static void ics_simple_resend_msi(ICSState *ics, int srcno)
> +static void ics_resend_msi(ICSState *ics, int srcno)
>  {
>      ICSIRQState *irq =3D ics->irqs + srcno;
> =20
> @@ -440,7 +416,7 @@ static void ics_simple_resend_msi(ICSState *ics, in=
t srcno)
>      }
>  }
> =20
> -static void ics_simple_resend_lsi(ICSState *ics, int srcno)
> +static void ics_resend_lsi(ICSState *ics, int srcno)
>  {
>      ICSIRQState *irq =3D ics->irqs + srcno;
> =20
> @@ -478,7 +454,7 @@ static void ics_simple_set_irq_lsi(ICSState *ics, i=
nt srcno, int val)
>      } else {
>          irq->status &=3D ~XICS_STATUS_ASSERTED;
>      }
> -    ics_simple_resend_lsi(ics, srcno);
> +    ics_resend_lsi(ics, srcno);
>  }
> =20
>  void ics_simple_set_irq(void *opaque, int srcno, int val)
> @@ -512,7 +488,7 @@ static void ics_simple_write_xive_msi(ICSState *ics=
, int srcno)
> =20
>  static void ics_simple_write_xive_lsi(ICSState *ics, int srcno)
>  {
> -    ics_simple_resend_lsi(ics, srcno);
> +    ics_resend_lsi(ics, srcno);
>  }
> =20
>  void ics_simple_write_xive(ICSState *ics, int srcno, int server,
> @@ -534,11 +510,11 @@ void ics_simple_write_xive(ICSState *ics, int src=
no, int server,
>      }
>  }
> =20
> -static void ics_simple_reject(ICSState *ics, uint32_t nr)
> +static void ics_reject(ICSState *ics, uint32_t nr)
>  {
>      ICSIRQState *irq =3D ics->irqs + nr - ics->offset;
> =20
> -    trace_xics_ics_simple_reject(nr, nr - ics->offset);
> +    trace_xics_ics_reject(nr, nr - ics->offset);
>      if (irq->flags & XICS_FLAGS_IRQ_MSI) {
>          irq->status |=3D XICS_STATUS_REJECTED;
>      } else if (irq->flags & XICS_FLAGS_IRQ_LSI) {
> @@ -546,26 +522,26 @@ static void ics_simple_reject(ICSState *ics, uint=
32_t nr)
>      }
>  }
> =20
> -static void ics_simple_resend(ICSState *ics)
> +void ics_resend(ICSState *ics)
>  {
>      int i;
> =20
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          /* FIXME: filter by server#? */
>          if (ics->irqs[i].flags & XICS_FLAGS_IRQ_LSI) {
> -            ics_simple_resend_lsi(ics, i);
> +            ics_resend_lsi(ics, i);
>          } else {
> -            ics_simple_resend_msi(ics, i);
> +            ics_resend_msi(ics, i);
>          }
>      }
>  }
> =20
> -static void ics_simple_eoi(ICSState *ics, uint32_t nr)
> +static void ics_eoi(ICSState *ics, uint32_t nr)
>  {
>      int srcno =3D nr - ics->offset;
>      ICSIRQState *irq =3D ics->irqs + srcno;
> =20
> -    trace_xics_ics_simple_eoi(nr);
> +    trace_xics_ics_eoi(nr);
> =20
>      if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
>          irq->status &=3D ~XICS_STATUS_SENT;
> @@ -617,10 +593,6 @@ static void ics_simple_class_init(ObjectClass *kla=
ss, void *data)
>                                      &isc->parent_realize);
>      device_class_set_parent_reset(dc, ics_simple_reset,
>                                    &isc->parent_reset);
> -
> -    isc->reject =3D ics_simple_reject;
> -    isc->resend =3D ics_simple_resend;
> -    isc->eoi =3D ics_simple_eoi;
>  }
> =20
>  static const TypeInfo ics_simple_info =3D {
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 64a2c8862a..34d7985b7c 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -106,10 +106,6 @@ struct ICSStateClass {
> =20
>      DeviceRealize parent_realize;
>      DeviceReset parent_reset;
> -
> -    void (*reject)(ICSState *s, uint32_t irq);
> -    void (*resend)(ICSState *s);
> -    void (*eoi)(ICSState *s, uint32_t irq);
>  };
> =20
>  struct ICSState {
>=20


