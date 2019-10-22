Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ADDCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79F620663
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dh+rqrcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79F620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqAh-0004ua-S7
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMq9G-0003kT-O0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMq9D-0004zf-SW
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:08:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28299
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMq9D-0004yy-FA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571735290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Qmr0cakZzBarEdXDZsybZJcNJAGJ0COby9J9kh15SI=;
 b=dh+rqrcjCtyub/UA4nU9Lowzs2pQOPkpJ13Eez+KanL+W9SC6oR4wxwBGBUjAldYq2S9sW
 ZxRf9u7KpS9zh/DU8kedXJ2bW0eNBW1LW2vkxCnHsAJJGEE6wVxvSajC9dx/++WsgVu8f1
 /rqAuYLXOUOxOHG4eJBFyrMg1+0Sna8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-k9OfEV6GOtqAcIZeE7RyYA-1; Tue, 22 Oct 2019 05:08:08 -0400
Received: by mail-wr1-f69.google.com with SMTP id i10so723903wrp.7
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hu1g2MQgs/v19frqdJmck9Wv0qplrG+z/eF0qIu/NfI=;
 b=SBjbOUidJzKmohhl6XJ/pWHj1Tm2Gy7R2Mw2DUFtVGQIF7OB7OlnZl4f/8W+hoSSyF
 l5gQRudnsivHGUGybQAVJD3hyTGHbA+34HPxOxt1EaB5l1A0QriPt9vRsqnkB0v7M7+v
 ZfG0Cq/xT9jsTdSPAcxpZep4KR2RFtg4DxEnZJiarOR+6Wr8K+vqF6LMfr9f5XyIoh9R
 DxFniMXQvA4BUgvTReIPAlAUY4Xsom3ZgLmm+wstGB9NYP0xzOYNHrNkGKF+/G1dMfJ6
 Wh3CbL0NVZVbcj+jzIxrE24pRkALVlM4TY64tp4pcBUY4edWmRIEyUU0OPGJ58rwL3lo
 wSvg==
X-Gm-Message-State: APjAAAVU6gGWYDgmGdUpj57KHmIwQNQh3IAMZ6jXiyoX9p3Fi9acV4E5
 zHRuINsxgC4wmQ1FDdCtqCJfC6imUdGa2+7i7HWvs5ZueYoKvtgUT1kPU+rR5k8lTkQbDcD5QCn
 XzyTvQAq3PKyWDQA=
X-Received: by 2002:adf:9bdc:: with SMTP id e28mr2339524wrc.309.1571735287373; 
 Tue, 22 Oct 2019 02:08:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMk40sAkxrr11XLXrxAHbxDQ7hRgfEaQxG9rtOhYr7NKMj8kYGg1ACjyi+vNilI6i+u3wMHw==
X-Received: by 2002:adf:9bdc:: with SMTP id e28mr2339491wrc.309.1571735286927; 
 Tue, 22 Oct 2019 02:08:06 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id b1sm10087640wru.83.2019.10.22.02.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 02:08:06 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] ppc: reset the interrupt presenter from the CPU
 reset handler
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20191022072246.9200-1-clg@kaod.org>
 <20191022072246.9200-4-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <acd04341-45dc-aa67-2412-f428f9f06054@redhat.com>
Date: Tue, 22 Oct 2019 11:08:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022072246.9200-4-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: k9OfEV6GOtqAcIZeE7RyYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi C=C3=A9dric,

On 10/22/19 9:22 AM, C=C3=A9dric Le Goater wrote:
> On the sPAPR machine and PowerNV machine, the interrupt presenters are
> created by a machine handler at the core level and are reseted

Typo "reset"

> independently. This is not consistent and it raises issues when it
> comes to handle hot-plugged CPUs. In that case, the presenters are not
> reseted. This is less of an issue in XICS, although a zero MFFR could

Same typo.

> be a concern, but in XIVE, the OS CAM line is not set and this breaks
> the presenting algorithm. The current code has workarounds which need
> a global cleanup.
>=20
> Extend the sPAPR IRQ backend and the PowerNV Chip class with a new
> cpu_intc_reset() handler called by the CPU reset handler and remove
> the XiveTCTX reset handler which is now redundant.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   include/hw/ppc/pnv.h       |  1 +
>   include/hw/ppc/spapr_irq.h |  2 ++
>   include/hw/ppc/xics.h      |  1 +
>   include/hw/ppc/xive.h      |  1 +
>   hw/intc/spapr_xive.c       |  9 +++++++++
>   hw/intc/xics.c             |  8 ++------
>   hw/intc/xics_spapr.c       |  7 +++++++
>   hw/intc/xive.c             | 12 +-----------
>   hw/ppc/pnv.c               | 18 ++++++++++++++++++
>   hw/ppc/pnv_core.c          |  8 ++++++++
>   hw/ppc/spapr_cpu_core.c    |  5 ++++-
>   hw/ppc/spapr_irq.c         | 14 ++++++++++++++
>   12 files changed, 68 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 1cdbe55bf86c..2a780e633f23 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -111,6 +111,7 @@ typedef struct PnvChipClass {
>  =20
>       uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
>       void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
> +    void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
>       ISABus *(*isa_create)(PnvChip *chip, Error **errp);
>       void (*dt_populate)(PnvChip *chip, void *fdt);
>       void (*pic_print_info)(PnvChip *chip, Monitor *mon);
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 5e150a667902..09232999b07e 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -52,6 +52,7 @@ typedef struct SpaprInterruptControllerClass {
>        */
>       int (*cpu_intc_create)(SpaprInterruptController *intc,
>                               PowerPCCPU *cpu, Error **errp);
> +    void (*cpu_intc_reset)(SpaprInterruptController *intc, PowerPCCPU *c=
pu);
>       int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi,
>                        Error **errp);
>       void (*free_irq)(SpaprInterruptController *intc, int irq);
> @@ -68,6 +69,7 @@ void spapr_irq_update_active_intc(SpaprMachineState *sp=
apr);
>  =20
>   int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>                                 PowerPCCPU *cpu, Error **errp);
> +void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *cpu)=
;
>   void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
>   void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
>                     void *fdt, uint32_t phandle);
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 1e6a9300eb2b..602173c12250 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -161,6 +161,7 @@ void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
>   uint32_t icp_accept(ICPState *ss);
>   uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr);
>   void icp_eoi(ICPState *icp, uint32_t xirr);
> +void icp_reset(ICPState *icp);
>  =20
>   void ics_write_xive(ICSState *ics, int nr, int server,
>                       uint8_t priority, uint8_t saved_priority);
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index fd3319bd3202..99381639f50c 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -415,6 +415,7 @@ uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr off=
set, unsigned size);
>  =20
>   void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
>   Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
> +void xive_tctx_reset(XiveTCTX *tctx);
>  =20
>   static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_=
idx)
>   {
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index ba32d2cc5b0f..20a8d8285f64 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -553,6 +553,14 @@ static int spapr_xive_cpu_intc_create(SpaprInterrupt=
Controller *intc,
>       return 0;
>   }
>  =20
> +static void spapr_xive_cpu_intc_reset(SpaprInterruptController *intc,
> +                                     PowerPCCPU *cpu)
> +{
> +    XiveTCTX *tctx =3D spapr_cpu_state(cpu)->tctx;
> +
> +    xive_tctx_reset(tctx);
> +}
> +
>   static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq,=
 int val)
>   {
>       SpaprXive *xive =3D SPAPR_XIVE(intc);
> @@ -697,6 +705,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
>       sicc->activate =3D spapr_xive_activate;
>       sicc->deactivate =3D spapr_xive_deactivate;
>       sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
> +    sicc->cpu_intc_reset =3D spapr_xive_cpu_intc_reset;
>       sicc->claim_irq =3D spapr_xive_claim_irq;
>       sicc->free_irq =3D spapr_xive_free_irq;
>       sicc->set_irq =3D spapr_xive_set_irq;
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index b5ac408f7b74..6da05763f9db 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -274,10 +274,8 @@ static const VMStateDescription vmstate_icp_server =
=3D {
>       },
>   };
>  =20
> -static void icp_reset_handler(void *dev)
> +void icp_reset(ICPState *icp)
>   {
> -    ICPState *icp =3D ICP(dev);
> -
>       icp->xirr =3D 0;
>       icp->pending_priority =3D 0xff;
>       icp->mfrr =3D 0xff;
> @@ -288,7 +286,7 @@ static void icp_reset_handler(void *dev)
>       if (kvm_irqchip_in_kernel()) {
>           Error *local_err =3D NULL;
>  =20
> -        icp_set_kvm_state(ICP(dev), &local_err);
> +        icp_set_kvm_state(icp, &local_err);
>           if (local_err) {
>               error_report_err(local_err);
>           }
> @@ -351,7 +349,6 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
>           }
>       }
>  =20
> -    qemu_register_reset(icp_reset_handler, dev);
>       vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp=
);
>   }
>  =20
> @@ -360,7 +357,6 @@ static void icp_unrealize(DeviceState *dev, Error **e=
rrp)
>       ICPState *icp =3D ICP(dev);
>  =20
>       vmstate_unregister(NULL, &vmstate_icp_server, icp);
> -    qemu_unregister_reset(icp_reset_handler, dev);
>   }
>  =20
>   static void icp_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 4f64b9a9fc66..7418fb9f370c 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -346,6 +346,12 @@ static int xics_spapr_cpu_intc_create(SpaprInterrupt=
Controller *intc,
>       return 0;
>   }
>  =20
> +static void xics_spapr_cpu_intc_reset(SpaprInterruptController *intc,
> +                                     PowerPCCPU *cpu)
> +{
> +    icp_reset(spapr_cpu_state(cpu)->icp);
> +}
> +
>   static int xics_spapr_claim_irq(SpaprInterruptController *intc, int irq=
,
>                                   bool lsi, Error **errp)
>   {
> @@ -433,6 +439,7 @@ static void ics_spapr_class_init(ObjectClass *klass, =
void *data)
>       sicc->activate =3D xics_spapr_activate;
>       sicc->deactivate =3D xics_spapr_deactivate;
>       sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
> +    sicc->cpu_intc_reset =3D xics_spapr_cpu_intc_reset;
>       sicc->claim_irq =3D xics_spapr_claim_irq;
>       sicc->free_irq =3D xics_spapr_free_irq;
>       sicc->set_irq =3D xics_spapr_set_irq;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index d420c6571e14..f066be5eb5e3 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -547,10 +547,8 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monito=
r *mon)
>       }
>   }
>  =20
> -static void xive_tctx_reset(void *dev)
> +void xive_tctx_reset(XiveTCTX *tctx)
>   {
> -    XiveTCTX *tctx =3D XIVE_TCTX(dev);
> -
>       memset(tctx->regs, 0, sizeof(tctx->regs));
>  =20
>       /* Set some defaults */
> @@ -607,13 +605,6 @@ static void xive_tctx_realize(DeviceState *dev, Erro=
r **errp)
>               return;
>           }
>       }
> -
> -    qemu_register_reset(xive_tctx_reset, dev);
> -}
> -
> -static void xive_tctx_unrealize(DeviceState *dev, Error **errp)
> -{
> -    qemu_unregister_reset(xive_tctx_reset, dev);
>   }
>  =20
>   static int vmstate_xive_tctx_pre_save(void *opaque)
> @@ -668,7 +659,6 @@ static void xive_tctx_class_init(ObjectClass *klass, =
void *data)
>  =20
>       dc->desc =3D "XIVE Interrupt Thread Context";
>       dc->realize =3D xive_tctx_realize;
> -    dc->unrealize =3D xive_tctx_unrealize;
>       dc->vmsd =3D &vmstate_xive_tctx;
>       /*
>        * Reason: part of XIVE interrupt controller, needs to be wired up
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 7cf64b6d2533..4a51fb65a834 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -778,6 +778,13 @@ static void pnv_chip_power8_intc_create(PnvChip *chi=
p, PowerPCCPU *cpu,
>       pnv_cpu->intc =3D obj;
>   }
>  =20
> +static void pnv_chip_power8_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
> +{
> +    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> +
> +    icp_reset(ICP(pnv_cpu->intc));
> +}
> +
>   /*
>    *    0:48  Reserved - Read as zeroes
>    *   49:52  Node ID
> @@ -815,6 +822,13 @@ static void pnv_chip_power9_intc_create(PnvChip *chi=
p, PowerPCCPU *cpu,
>       pnv_cpu->intc =3D obj;
>   }
>  =20
> +static void pnv_chip_power9_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
> +{
> +    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> +
> +    xive_tctx_reset(XIVE_TCTX(pnv_cpu->intc));
> +}
> +
>   /*
>    * Allowed core identifiers on a POWER8 Processor Chip :
>    *
> @@ -984,6 +998,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
>       k->cores_mask =3D POWER8E_CORE_MASK;
>       k->core_pir =3D pnv_chip_core_pir_p8;
>       k->intc_create =3D pnv_chip_power8_intc_create;
> +    k->intc_reset =3D pnv_chip_power8_intc_reset;
>       k->isa_create =3D pnv_chip_power8_isa_create;
>       k->dt_populate =3D pnv_chip_power8_dt_populate;
>       k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> @@ -1003,6 +1018,7 @@ static void pnv_chip_power8_class_init(ObjectClass =
*klass, void *data)
>       k->cores_mask =3D POWER8_CORE_MASK;
>       k->core_pir =3D pnv_chip_core_pir_p8;
>       k->intc_create =3D pnv_chip_power8_intc_create;
> +    k->intc_reset =3D pnv_chip_power8_intc_reset;
>       k->isa_create =3D pnv_chip_power8_isa_create;
>       k->dt_populate =3D pnv_chip_power8_dt_populate;
>       k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> @@ -1022,6 +1038,7 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
>       k->cores_mask =3D POWER8_CORE_MASK;
>       k->core_pir =3D pnv_chip_core_pir_p8;
>       k->intc_create =3D pnv_chip_power8_intc_create;
> +    k->intc_reset =3D pnv_chip_power8_intc_reset;
>       k->isa_create =3D pnv_chip_power8nvl_isa_create;
>       k->dt_populate =3D pnv_chip_power8_dt_populate;
>       k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> @@ -1191,6 +1208,7 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
>       k->cores_mask =3D POWER9_CORE_MASK;
>       k->core_pir =3D pnv_chip_core_pir_p9;
>       k->intc_create =3D pnv_chip_power9_intc_create;
> +    k->intc_reset =3D pnv_chip_power9_intc_reset;
>       k->isa_create =3D pnv_chip_power9_isa_create;
>       k->dt_populate =3D pnv_chip_power9_dt_populate;
>       k->pic_print_info =3D pnv_chip_power9_pic_print_info;
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index b1a7489e7abf..f36cb39dbf77 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -45,6 +45,8 @@ static void pnv_cpu_reset(void *opaque)
>       PowerPCCPU *cpu =3D opaque;
>       CPUState *cs =3D CPU(cpu);
>       CPUPPCState *env =3D &cpu->env;
> +    PnvChipClass *pcc;
> +    Object *chip;
>  =20
>       cpu_reset(cs);
>  =20
> @@ -55,6 +57,10 @@ static void pnv_cpu_reset(void *opaque)
>       env->gpr[3] =3D PNV_FDT_ADDR;
>       env->nip =3D 0x10;
>       env->msr |=3D MSR_HVB; /* Hypervisor mode */
> +
> +    chip =3D object_property_get_link(OBJECT(cpu), "chip", &error_fatal)=
;

Why not add a PnvChip *chip field in PnvCore?
Then you only get it in realize() and it is available in reset().

Rest of your patch looks OK from a QOM PoV.

> +    pcc =3D PNV_CHIP_GET_CLASS(chip);
> +    pcc->intc_reset(PNV_CHIP(chip), cpu);
>   }
>  =20
>   /*
> @@ -169,6 +175,8 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChip=
 *chip, Error **errp)
>       Error *local_err =3D NULL;
>       PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>  =20
> +    object_property_add_const_link(OBJECT(cpu), "chip",
> +                                   OBJECT(chip), &error_fatal);
>       object_property_set_bool(OBJECT(cpu), true, "realized", &local_err)=
;
>       if (local_err) {
>           error_propagate(errp, local_err);
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 5947e39b36ad..d2903c2d0f22 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -32,6 +32,7 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>       PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>       SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
>       target_ulong lpcr;
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>  =20
>       cpu_reset(cs);
>  =20
> @@ -76,9 +77,11 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>       spapr_cpu->dtl_addr =3D 0;
>       spapr_cpu->dtl_size =3D 0;
>  =20
> -    spapr_caps_cpu_apply(SPAPR_MACHINE(qdev_get_machine()), cpu);
> +    spapr_caps_cpu_apply(spapr, cpu);
>  =20
>       kvm_check_mmu(cpu, &error_fatal);
> +
> +    spapr_irq_cpu_intc_reset(spapr, cpu);
>   }
>  =20
>   void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, targe=
t_ulong r3)
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 234d1073e518..b941608b69ba 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -220,6 +220,20 @@ int spapr_irq_cpu_intc_create(SpaprMachineState *spa=
pr,
>       return 0;
>   }
>  =20
> +void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *cpu)
> +{
> +    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
> +        SpaprInterruptController *intc =3D intcs[i];
> +        if (intc) {
> +            SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS=
(intc);
> +            sicc->cpu_intc_reset(intc, cpu);
> +        }
> +    }
> +}
> +
>   static void spapr_set_irq(void *opaque, int irq, int level)
>   {
>       SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);
>=20


