Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB8C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD95620656
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD95620656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWhq9-0000VV-Hl
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 09:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1iWhoo-00083t-3q
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1iWhom-0006Gm-NK
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:15:54 -0500
Received: from mel.act-europe.fr ([194.98.77.210]:36636
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1iWhoj-0006Dw-Jp; Mon, 18 Nov 2019 09:15:49 -0500
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 2585F8137E;
 Mon, 18 Nov 2019 15:15:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7pGSlIZyjkEr; Mon, 18 Nov 2019 15:15:47 +0100 (CET)
Received: from localhost.localdomain (lfbn-tou-1-352-33.w86-206.abo.wanadoo.fr
 [86.206.184.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 0464A81368;
 Mon, 18 Nov 2019 15:15:43 +0100 (CET)
Subject: Re: [PATCH v3 24/33] leon3: use qemu_irq framework instead of
 callback as property
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-25-marcandre.lureau@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <ebcefe3d-6a3a-1c9e-3263-964db5033090@adacore.com>
Date: Mon, 18 Nov 2019 15:15:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191023173154.30051-25-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.98.77.210
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc-Andr=C3=A9,

Le 10/23/19 =C3=A0 7:31 PM, Marc-Andr=C3=A9 Lureau a =C3=A9crit=C2=A0:
> "set_pin_in" property is used to define a callback mechanism where the
> device says "call the callback function, passing it an opaque cookie
> and a 32-bit value". We already have a generic mechanism for doing
> that, which is the qemu_irq. So we should just use that.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/intc/grlib_irqmp.c | 35 ++++-------------------------------
>   hw/sparc/leon3.c      |  9 +++++----
>   target/sparc/cpu.h    |  1 +
>   3 files changed, 10 insertions(+), 35 deletions(-)
>=20
> diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
> index bc78e1a14f..794c643af2 100644
> --- a/hw/intc/grlib_irqmp.c
> +++ b/hw/intc/grlib_irqmp.c
> @@ -25,6 +25,7 @@
>    */
>  =20
>   #include "qemu/osdep.h"
> +#include "hw/irq.h"
>   #include "hw/sysbus.h"
>   #include "cpu.h"
>  =20
> @@ -58,10 +59,8 @@ typedef struct IRQMP {
>  =20
>       MemoryRegion iomem;
>  =20
> -    void *set_pil_in;
> -    void *set_pil_in_opaque;
> -
>       IRQMPState *state;
> +    qemu_irq irq;
>   } IRQMP;
>  =20
>   struct IRQMPState {
> @@ -82,7 +81,6 @@ static void grlib_irqmp_check_irqs(IRQMPState *state)
>       uint32_t      pend   =3D 0;
>       uint32_t      level0 =3D 0;
>       uint32_t      level1 =3D 0;
> -    set_pil_in_fn set_pil_in;
>  =20
>       assert(state !=3D NULL);
>       assert(state->parent !=3D NULL);
> @@ -97,14 +95,8 @@ static void grlib_irqmp_check_irqs(IRQMPState *state=
)
>       trace_grlib_irqmp_check_irqs(state->pending, state->force[0],
>                                    state->mask[0], level1, level0);
>  =20
> -    set_pil_in =3D (set_pil_in_fn)state->parent->set_pil_in;
> -
>       /* Trigger level1 interrupt first and level0 if there is no level=
1 */
> -    if (level1 !=3D 0) {
> -        set_pil_in(state->parent->set_pil_in_opaque, level1);
> -    } else {
> -        set_pil_in(state->parent->set_pil_in_opaque, level0);
> -    }
> +    qemu_set_irq(state->parent->irq, level1 ?: level0);
>   }
>  =20
>   static void grlib_irqmp_ack_mask(IRQMPState *state, uint32_t mask)
> @@ -335,6 +327,7 @@ static void grlib_irqmp_init(Object *obj)
>       IRQMP *irqmp =3D GRLIB_IRQMP(obj);
>       SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
>  =20
> +    qdev_init_gpio_out_named(DEVICE(obj), &irqmp->irq, "grlib-irq", 1)=
;
>       memory_region_init_io(&irqmp->iomem, obj, &grlib_irqmp_ops, irqmp=
,
>                             "irqmp", IRQMP_REG_SIZE);
>  =20
> @@ -343,31 +336,11 @@ static void grlib_irqmp_init(Object *obj)
>       sysbus_init_mmio(dev, &irqmp->iomem);
>   }
>  =20
> -static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
> -{
> -    IRQMP *irqmp =3D GRLIB_IRQMP(dev);
> -
> -        /* Check parameters */
> -    if (irqmp->set_pil_in =3D=3D NULL) {
> -        error_setg(errp, "set_pil_in cannot be NULL.");
> -    }
> -}
> -
> -static Property grlib_irqmp_properties[] =3D {
> -    DEFINE_PROP_PTR("set_pil_in", IRQMP, set_pil_in),
> -    DEFINE_PROP_PTR("set_pil_in_opaque", IRQMP, set_pil_in_opaque),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>   static void grlib_irqmp_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
>       dc->reset =3D grlib_irqmp_reset;
> -    dc->props =3D grlib_irqmp_properties;
> -    /* Reason: pointer properties "set_pil_in", "set_pil_in_opaque" */
> -    dc->user_creatable =3D false;

Was confused first, since we don't want this device to be user creatable.=
 But I
think that SysBusDevice has that set to "false" anyway so it's all right.

> -    dc->realize =3D grlib_irqmp_realize;
>   }
>  =20
>   static const TypeInfo grlib_irqmp_info =3D {
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index c5f1b1ee72..6db6ea9b5c 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -143,9 +143,10 @@ void leon3_irq_ack(void *irq_manager, int intno)
>       grlib_irqmp_ack((DeviceState *)irq_manager, intno);
>   }
>  =20
> -static void leon3_set_pil_in(void *opaque, uint32_t pil_in)
> +static void leon3_set_pil_in(void *opaque, int n, int level)
>   {
> -    CPUSPARCState *env =3D (CPUSPARCState *)opaque;
> +    CPUSPARCState *env =3D opaque;
> +    uint32_t pil_in =3D level;
>       CPUState *cs;
>  =20
>       assert(env !=3D NULL);
> @@ -225,8 +226,8 @@ static void leon3_generic_hw_init(MachineState *mac=
hine)
>  =20
>       /* Allocate IRQ manager */
>       dev =3D qdev_create(NULL, TYPE_GRLIB_IRQMP);
> -    qdev_prop_set_ptr(dev, "set_pil_in", leon3_set_pil_in);
> -    qdev_prop_set_ptr(dev, "set_pil_in_opaque", env);
> +    env->pil_irq =3D qemu_allocate_irq(leon3_set_pil_in, env, 0);
> +    qdev_connect_gpio_out_named(dev, "grlib-irq", 0, env->pil_irq);
>       qdev_init_nofail(dev);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_IRQMP_OFFSET);
>       env->irq_manager =3D dev;
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 778aa8e073..709215f8c1 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -508,6 +508,7 @@ struct CPUSPARCState {
>   #endif
>       sparc_def_t def;
>  =20
> +    qemu_irq pil_irq;
>       void *irq_manager;
>       void (*qemu_irq_ack)(CPUSPARCState *env, void *irq_manager, int i=
ntno);
>  =20
>=20

Seems ok to me.

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

Thanks,
Fred

