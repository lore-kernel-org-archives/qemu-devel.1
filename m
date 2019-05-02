Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D502C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 05:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03992081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 05:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnGZ8bk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03992081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45240 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM3wj-00028m-2d
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 01:07:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hM3vu-0001mp-Sa
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hM3vY-0005Wg-2Z
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:06:46 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hM3vB-0003YN-5Q
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:06:20 -0400
Received: by mail-lf1-x142.google.com with SMTP id h126so886851lfh.4
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 22:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=o1b+N14VGmhTqh/MIOYAI+kKqLKzITmCrwbSNbjkXew=;
	b=EnGZ8bk+m/hKmuLbLVk4h6lkfS2Y1GTU0hhIKbepTFnDmo4Wzvz0CF6QzNlbN5JAF1
	9Ad19oJmj4ii8EQK6zvVEGJ1phV4pUi81xZBdcR5o35v6aARhqwFqgycp8RGdGWYFqne
	eb0YxKWPoS6CXt2ngi0Y7r7yASQsf0jBZxkEtFoumcfIL20Wv7UZTW2Y+O+9Pde2Kq7N
	IUaMwDoKaWjnqboakcShn1SO80nnI6gGt2gZEdCG2xhqEVbuoR1zG3a0NOiU2ST9x4yo
	bSIg8+v6ymUskudjwDuvlC6VVT2kL0kfNOuSQzVLiJrjIErkObQ6ZtGQguUk3nmzWqb1
	xqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=o1b+N14VGmhTqh/MIOYAI+kKqLKzITmCrwbSNbjkXew=;
	b=e3+OlUv/yLaWSBvvyiiw/LBelajni7/ZVtS4JTYaOaPuztjblE94nVCvl5l9IMW9Vt
	KeuvT/WhJB2G847zK3gc+xBw+SQhFfzfMeqIncAdrIxBuu/wGRIS4cn1SCfSIJEuKupP
	zJGSUElJT74aajwa9UoMopnLCF5z2GM6Qz7N0IM+KXb1cLZYk2w0M2ieCLu0WrXXPrhE
	VP+hSlKXGglOyw/JMUupRPG2lbFd9Z9BqmfU9fw/hafyhfpHpxKmGIuriWCVuKNvWh2t
	AuGCSQzgf+O57/bx86nav319pNmKfbR/AG7OV6mA7pxH3XGyozXEJYBQNdOhk36BPNgW
	sjqw==
X-Gm-Message-State: APjAAAWsnStfFF3MCkDLlTi765AU97iz+dHMoIk98a3JujgbZh3eIB+s
	sr1deagBfNjRL4Ak8SCtRTHFU0Y++MtlxXorQYw=
X-Google-Smtp-Source: APXvYqyXguzWqbstrksXWaeewHtepY2BrIdl8Ttz1/O+znl7BvpVyyqqEHuPf/n+sYB7AuI5jhzPci1uvM5dz1d6+ME=
X-Received: by 2002:ac2:4205:: with SMTP id y5mr776824lfh.15.1556773472858;
	Wed, 01 May 2019 22:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB027793B449E7DAAB995E0F33DD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<CAFEAcA_rzfL_-zZPpMhqvyGLe7wS-HFh0znd8n2ysnfhg4kHLA@mail.gmail.com>
In-Reply-To: <CAFEAcA_rzfL_-zZPpMhqvyGLe7wS-HFh0znd8n2ysnfhg4kHLA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 May 2019 22:04:01 -0700
Message-ID:
 <CAKmqyKN_JUjEguT5oHcgGEVQ7-viWq1gBKhdQ6hdp_RFA546Dw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v1 4/5] hw/arm: Add the STM32F4xx SoC
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alistair Francis <alistair@alistair23.me>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502050401.x5qk5pPWhL9wpYHvYkqCJlAdyVgIlzDtY6KVzzmHOTY@z>

On Tue, Apr 30, 2019 at 8:59 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 29 Apr 2019 at 06:38, Alistair Francis <alistair@alistair23.me> wrote:
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  MAINTAINERS                     |   8 +
> >  default-configs/arm-softmmu.mak |   1 +
> >  hw/arm/Kconfig                  |   3 +
> >  hw/arm/Makefile.objs            |   1 +
> >  hw/arm/stm32f405_soc.c          | 292 ++++++++++++++++++++++++++++++++
> >  include/hw/arm/stm32f405_soc.h  |  70 ++++++++
> >  6 files changed, 375 insertions(+)
> >  create mode 100644 hw/arm/stm32f405_soc.c
> >  create mode 100644 include/hw/arm/stm32f405_soc.h
>
> Looks good; a few minor things below.
>
> > +static void stm32f405_soc_initfn(Object *obj)
> > +{
> > +    STM32F405State *s = STM32F405_SOC(obj);
> > +    int i;
> > +
> > +    sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
> > +                          TYPE_ARMV7M);
> > +
> > +    sysbus_init_child_obj(obj, "syscfg", &s->syscfg, sizeof(s->syscfg),
> > +                          TYPE_STM32F4XX_SYSCFG);
> > +
> > +    for (i = 0; i < STM_NUM_USARTS; i++) {
> > +        sysbus_init_child_obj(obj, "usart[*]", &s->usart[i],
> > +                              sizeof(s->usart[i]), TYPE_STM32F2XX_USART);
> > +    }
> > +
> > +    for (i = 0; i < STM_NUM_TIMERS; i++) {
> > +        sysbus_init_child_obj(obj, "timer[*]", &s->timer[i],
> > +                              sizeof(s->timer[i]), TYPE_STM32F2XX_TIMER);
> > +    }
> > +
> > +    s->adc_irqs = OR_IRQ(object_new(TYPE_OR_IRQ));
>
> It would be more in keeping with the style of the rest of this
> device to have the device be inline in the STM32F405State
> struct and initialized with object_initialize_child() rather
> than allocated separately with object_new(). (hw/arm/armsse.c
> has an example of doing this with a TYPE_OR_IRQ object.)

I have addressed all your comments.

Alistair

>
> > +
> > +    for (i = 0; i < STM_NUM_ADCS; i++) {
> > +        sysbus_init_child_obj(obj, "adc[*]", &s->adc[i], sizeof(s->adc[i]),
> > +                              TYPE_STM32F2XX_ADC);
> > +    }
> > +
> > +    for (i = 0; i < STM_NUM_SPIS; i++) {
> > +        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
> > +                              TYPE_STM32F2XX_SPI);
> > +    }
> > +
> > +    sysbus_init_child_obj(obj, "exti", &s->exti, sizeof(s->exti),
> > +                          TYPE_STM32F4XX_EXTI);
> > +}
> > +
> > +static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
> > +{
> > +    STM32F405State *s = STM32F405_SOC(dev_soc);
> > +    DeviceState *dev, *armv7m;
> > +    SysBusDevice *busdev;
> > +    Error *err = NULL;
> > +    int i;
> > +
> > +    MemoryRegion *system_memory = get_system_memory();
> > +    MemoryRegion *sram = g_new(MemoryRegion, 1);
> > +    MemoryRegion *flash = g_new(MemoryRegion, 1);
> > +    MemoryRegion *flash_alias = g_new(MemoryRegion, 1);
>
> I would prefer to have these MemoryRegions be in the STM32F405State
> struct rather than separately allocated.
>
> > +
> > +    memory_region_init_ram(flash, NULL, "STM32F405.flash", FLASH_SIZE,
> > +                           &error_fatal);
>
> Better to pass the error back up via errp rather than use error_fatal
> in a realize function.
>
> > +    memory_region_init_alias(flash_alias, NULL, "STM32F405.flash.alias",
> > +                             flash, 0, FLASH_SIZE);
> > +
> > +    memory_region_set_readonly(flash, true);
> > +    memory_region_set_readonly(flash_alias, true);
> > +
> > +    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
> > +    memory_region_add_subregion(system_memory, 0, flash_alias);
> > +
> > +    memory_region_init_ram(sram, NULL, "STM32F405.sram", SRAM_SIZE,
> > +                           &error_fatal);
> > +    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
> > +
> > +    armv7m = DEVICE(&s->armv7m);
> > +    qdev_prop_set_uint32(armv7m, "num-irq", 96);
> > +    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
> > +    qdev_prop_set_bit(armv7m, "enable-bitband", true);
> > +    object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
>
> You could use OBJECT(system_memory) rather than calling
> get_system_memory() again.
>
> > +static Property stm32f405_soc_properties[] = {
> > +    DEFINE_PROP_STRING("cpu-type", STM32F405State, cpu_type),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void stm32f405_soc_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->realize = stm32f405_soc_realize;
> > +    dc->props = stm32f405_soc_properties;
>
> A comment here "No vmstate or reset required: device has no internal state"
> would help indicate that dc->vmsd and dc->reset have not merely
> been forgotten.
>
> (Eventually I might actually write a patch to let us express
> in code "dc->vmsd = device_has_no_state;"...)
>
> > +}
>
> thanks
> -- PMM

