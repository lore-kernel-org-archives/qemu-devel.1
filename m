Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6A1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 23:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41EAD2067B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 23:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzMpja2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EAD2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jinbh-00028N-HP
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 19:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jinas-0001QL-P3; Tue, 09 Jun 2020 19:23:46 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:44635)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jinar-0007G7-Qn; Tue, 09 Jun 2020 19:23:46 -0400
Received: by mail-il1-x143.google.com with SMTP id i1so124756ils.11;
 Tue, 09 Jun 2020 16:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2xozlEa/iOiEIAWB56dhJk4Va5WuvxQHsknEvWaQjQM=;
 b=VzMpja2BdCmd/sBjK4m2yoL7xOfCW3ER0pEHIFvQrknWtE3D0p1x5H6AV3Rwv87/qi
 nq1fZW+xpk1vlQLEbK7g8Dz5H2FLu1aiLK0NtcFjiyE2Uv1t1SslmWVwoSWqCBtfCiZe
 WEgoZ3Ab0/orOSwwmLzzcWABVzRFdzmi5HgWW4BQPBxHtevwgaqr8KVEzL/zjbymuh+t
 QUPdYlxakLpdK92gYOJEcVO7wuiYYygC1oODQfRemgqXE5VAD0XMXlcb1HKNJhkKC2/Y
 QOr4SOT9rB1SFtXUinO+hhMnsz4Mtn3un/SItF38ZnuM2IstLfYuu9KHOhyyfGi3cH8C
 r/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2xozlEa/iOiEIAWB56dhJk4Va5WuvxQHsknEvWaQjQM=;
 b=IOad0Y5r3P42+C4SvrWPBTPFNwXPkZNCDGBmA6FZnsvJhLxZisxL/pU7oatS0UZBDQ
 nEyYMoHnUruvopyRtpe5MiSvXHCMIPQ4f/+TxhefH/vHrfQQG9voOGtRbMSIatFZAveM
 53F3kEFD8vtSrSjDDNW8B16JIWfT2oaz33/uX/FKgWK4H0Ju8U/XVqBKSEunZ7tdKxAf
 J0ZqLEk9VM+bbRnfdZjLGZluO3DPveEm6i52F+yrq9ZrecMsEsPl91wlMMKhhWKFSQ2G
 +NRS5SstxcQwajsrVmM5WOutXab2EbYOwga4ORTZL6100tKrl1CWiJGelj7TbuRBUfd0
 IiFg==
X-Gm-Message-State: AOAM531ame+I3ftso+flYUKUn1gqm0k37JAOAAMPzF/kg3jRHebVdfdR
 VzWXVKiMzhHIndynC9n5bY8y3/kbZ0IuV0VX81U=
X-Google-Smtp-Source: ABdhPJwPEosiFGLCh1Om+iYYOIrm14s+jKGtC6pOIfj1UzMKhM2cbfSu1b3t5Ur8Oqq0A3qusW99WZHwLwnEWSFiFjI=
X-Received: by 2002:a92:c94b:: with SMTP id i11mr400044ilq.177.1591745013439; 
 Tue, 09 Jun 2020 16:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200609122339.937862-1-armbru@redhat.com>
 <20200609122339.937862-2-armbru@redhat.com>
In-Reply-To: <20200609122339.937862-2-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 9 Jun 2020 16:14:12 -0700
Message-ID: <CAKmqyKPGBxODrm6vRLAYd_oFbeNsH3U_3qpS4O+w7m-YdgxLuQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/24] arm/stm32f405: Fix realization of
 "stm32f2xx-adc" devices
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 9, 2020 at 5:24 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> stm32f405_soc_initfn() creates six such devices, but
> stm32f405_soc_realize() realizes only one.  Affects machine
> netduinoplus2.
>
> In theory, a device becomes real only on realize.  In practice, the
> transition from unreal to real is a fuzzy one.  The work to make a
> device real can be spread between realize methods (fine),
> instance_init methods (wrong), and board code wiring up the device
> (fine as long as it effectively happens on realize).  Depending on
> what exactly is done where, a device can work even when we neglect
> to realize it.
>
> The five unrealized devices appear to stay unreal: neither MMIO nor
> IRQ get wired up.
>
> Fix stm32f405_soc_realize() to realize and wire up all six.  Visible
> in "info qtree":
>
>      bus: main-system-bus
>        type System
>        dev: stm32f405-soc, id ""
>          cpu-type =3D "cortex-m4-arm-cpu"
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012000/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012100/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012200/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012300/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio 0000000040012000/00000000000000ff
>     +    mmio 0000000040012400/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012500/00000000000000ff
>        dev: armv7m, id ""
>
> Fixes: 529fc5fd3e18ace8f739afd02dc0953354f39442
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/stm32f405_soc.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
> index 4f10ce6176..c9a530eecf 100644
> --- a/hw/arm/stm32f405_soc.c
> +++ b/hw/arm/stm32f405_soc.c
> @@ -37,7 +37,8 @@ static const uint32_t usart_addr[] =3D { 0x40011000, 0x=
40004400, 0x40004800,
>  /* At the moment only Timer 2 to 5 are modelled */
>  static const uint32_t timer_addr[] =3D { 0x40000000, 0x40000400,
>                                         0x40000800, 0x40000C00 };
> -#define ADC_ADDR                       0x40012000
> +static const uint32_t adc_addr[] =3D { 0x40012000, 0x40012100, 0x4001220=
0,
> +                                     0x40012300, 0x40012400, 0x40012500 =
};
>  static const uint32_t spi_addr[] =3D   { 0x40013000, 0x40003800, 0x40003=
C00,
>                                         0x40013400, 0x40015000, 0x4001540=
0 };
>  #define EXTI_ADDR                      0x40013C00
> @@ -185,16 +186,18 @@ static void stm32f405_soc_realize(DeviceState *dev_=
soc, Error **errp)
>      qdev_connect_gpio_out(DEVICE(&s->adc_irqs), 0,
>                            qdev_get_gpio_in(armv7m, ADC_IRQ));
>
> -    dev =3D DEVICE(&(s->adc[i]));
> -    object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err)=
;
> -    if (err !=3D NULL) {
> -        error_propagate(errp, err);
> -        return;
> +    for (i =3D 0; i < STM_NUM_ADCS; i++) {
> +        dev =3D DEVICE(&(s->adc[i]));
> +        object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &=
err);
> +        if (err !=3D NULL) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        busdev =3D SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, adc_addr[i]);
> +        sysbus_connect_irq(busdev, 0,
> +                           qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
>      }
> -    busdev =3D SYS_BUS_DEVICE(dev);
> -    sysbus_mmio_map(busdev, 0, ADC_ADDR);
> -    sysbus_connect_irq(busdev, 0,
> -                       qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
>
>      /* SPI devices */
>      for (i =3D 0; i < STM_NUM_SPIS; i++) {
> --
> 2.26.2
>
>

