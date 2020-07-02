Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD82C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676C120760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBzP1p01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676C120760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3XG-00075z-KK
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jr3W2-0005Ff-BG; Thu, 02 Jul 2020 14:00:54 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:45647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jr3Vz-0004bb-Me; Thu, 02 Jul 2020 14:00:53 -0400
Received: by mail-il1-x142.google.com with SMTP id o3so7625675ilo.12;
 Thu, 02 Jul 2020 11:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=87WrOvEx5pd5NM4gdmI4p9RF2+xCH4REdZ3M16qx6Pw=;
 b=aBzP1p014gIuxPp/7BqDGvOkOP/q5jWuyHcFW79WdBIAsPS0hGW7pV/BxWPBrvNLDY
 +HTYStVA1/QyWa3PkjE6bXIqs1oBX+KizGm57t8ihDYlujV98eb3oAR56Obg0gacPwkd
 gLxsBCgNV6I3TZ1JkMh1pKuO4RPO1gGm4ikQB79rP2l25fj2ZaeS5X3nvYa70Hlw67iL
 nQ+8+cRJpqNf2+K8Xuk4WK3XxEiq9g+8pe7nf0LN6eQx/nZN3OevQ0xGWE+86z9xo47u
 e2fdn9CXllCOl1PZYRaWfzrFWgCCxTBM0NV29E+WO0JxaP3WWO5f2psE26ibsh85vNJL
 AU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=87WrOvEx5pd5NM4gdmI4p9RF2+xCH4REdZ3M16qx6Pw=;
 b=sDR8ra9GgCkcWLbkaDuOJsze4S5gvdifvsYniFIXifpPxIObJ0ETxQ2tauphXqWfsy
 9R6BEbIz9RTZcEkWk7M7JxTguQr/taRFiWej9q5CWxZN8MYSgK9Rd9dIeI4BZOCt/Hx5
 olUnS0Zpw5bxaGAjwJZeSfSVZzl/Kv0KLzj0WLm0ZzXcHZDa2zq0yiyt+GIRuo1ezCP9
 gSQhBhH1Tg8Qpb1UEanMIHPG84JMV/j/Z//tVP/oTazNMBIcUuF6UEjlDzkojoy2vBAZ
 Dw9WYDvPGb6LPgciebrpaL21DfcIa3MTm9Uhmw1nJQrC2vZXM7BMVtFHyITDI77XT4t7
 RVbg==
X-Gm-Message-State: AOAM533rTtchrVpRcrv0bjqVxLreW+tBTwHV5eWYxTO4SU8/lcUnS9dZ
 lqGUFZqGflGdJO2QwabDxxd2aHxyUc0nyyTAjB8=
X-Google-Smtp-Source: ABdhPJygNRY1HK4IGpTJ5+dyJugujaTIML9x/X4XtWtrQZxufATLBvDqxuiPTncPAWuWR+WkQsT083uVrDjTj6Z81Jw=
X-Received: by 2002:a92:d186:: with SMTP id z6mr14784980ilz.227.1593712849883; 
 Thu, 02 Jul 2020 11:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-17-peter.maydell@linaro.org>
In-Reply-To: <20200628142429.17111-17-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Jul 2020 10:51:03 -0700
Message-ID: <CAKmqyKNa4ebaben_0eLBjR0C2f-LtCVXQk3LV4mPVPVm5+JQCg@mail.gmail.com>
Subject: Re: [PATCH 16/17] hw/arm/spitz: Provide usual QOM macros for
 corgi-ssp and spitz-lcdtg
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 28, 2020 at 7:35 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The QOM types "spitz-lcdtg" and "corgi-ssp" are missing the
> usual QOM TYPE and casting macros; provide and use them.
>
> In particular, we can safely use the QOM cast macros instead of
> FROM_SSI_SLAVE() because in both cases the 'ssidev' field of
> the instance state struct is the first field in it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/spitz.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index 49eae3fce4e..f020aff9747 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -579,6 +579,9 @@ static void spitz_keyboard_realize(DeviceState *dev, Error **errp)
>  #define LCDTG_PICTRL    0x06
>  #define LCDTG_POLCTRL   0x07
>
> +#define TYPE_SPITZ_LCDTG "spitz-lcdtg"
> +#define SPITZ_LCDTG(obj) OBJECT_CHECK(SpitzLCDTG, (obj), TYPE_SPITZ_LCDTG)
> +
>  typedef struct {
>      SSISlave ssidev;
>      uint32_t bl_intensity;
> @@ -616,7 +619,7 @@ static inline void spitz_bl_power(void *opaque, int line, int level)
>
>  static uint32_t spitz_lcdtg_transfer(SSISlave *dev, uint32_t value)
>  {
> -    SpitzLCDTG *s = FROM_SSI_SLAVE(SpitzLCDTG, dev);
> +    SpitzLCDTG *s = SPITZ_LCDTG(dev);
>      int addr;
>      addr = value >> 5;
>      value &= 0x1f;
> @@ -645,7 +648,7 @@ static uint32_t spitz_lcdtg_transfer(SSISlave *dev, uint32_t value)
>
>  static void spitz_lcdtg_realize(SSISlave *ssi, Error **errp)
>  {
> -    SpitzLCDTG *s = FROM_SSI_SLAVE(SpitzLCDTG, ssi);
> +    SpitzLCDTG *s = SPITZ_LCDTG(ssi);
>      DeviceState *dev = DEVICE(s);
>
>      s->bl_power = 0;
> @@ -664,6 +667,9 @@ static void spitz_lcdtg_realize(SSISlave *ssi, Error **errp)
>  #define SPITZ_GPIO_MAX1111_CS   20
>  #define SPITZ_GPIO_TP_INT       11
>
> +#define TYPE_CORGI_SSP "corgi-ssp"
> +#define CORGI_SSP(obj) OBJECT_CHECK(CorgiSSPState, (obj), TYPE_CORGI_SSP)
> +
>  /* "Demux" the signal based on current chipselect */
>  typedef struct {
>      SSISlave ssidev;
> @@ -673,7 +679,7 @@ typedef struct {
>
>  static uint32_t corgi_ssp_transfer(SSISlave *dev, uint32_t value)
>  {
> -    CorgiSSPState *s = FROM_SSI_SLAVE(CorgiSSPState, dev);
> +    CorgiSSPState *s = CORGI_SSP(dev);
>      int i;
>
>      for (i = 0; i < 3; i++) {
> @@ -702,7 +708,7 @@ static void corgi_ssp_gpio_cs(void *opaque, int line, int level)
>  static void corgi_ssp_realize(SSISlave *d, Error **errp)
>  {
>      DeviceState *dev = DEVICE(d);
> -    CorgiSSPState *s = FROM_SSI_SLAVE(CorgiSSPState, d);
> +    CorgiSSPState *s = CORGI_SSP(d);
>
>      qdev_init_gpio_in(dev, corgi_ssp_gpio_cs, 3);
>      s->bus[0] = ssi_create_bus(dev, "ssi0");
> @@ -714,10 +720,11 @@ static void spitz_ssp_attach(SpitzMachineState *sms)
>  {
>      void *bus;
>
> -    sms->mux = ssi_create_slave(sms->mpu->ssp[CORGI_SSP_PORT - 1], "corgi-ssp");
> +    sms->mux = ssi_create_slave(sms->mpu->ssp[CORGI_SSP_PORT - 1],
> +                                TYPE_CORGI_SSP);
>
>      bus = qdev_get_child_bus(sms->mux, "ssi0");
> -    sms->lcdtg = ssi_create_slave(bus, "spitz-lcdtg");
> +    sms->lcdtg = ssi_create_slave(bus, TYPE_SPITZ_LCDTG);
>
>      bus = qdev_get_child_bus(sms->mux, "ssi1");
>      sms->ads7846 = ssi_create_slave(bus, "ads7846");
> @@ -1220,7 +1227,7 @@ static void corgi_ssp_class_init(ObjectClass *klass, void *data)
>  }
>
>  static const TypeInfo corgi_ssp_info = {
> -    .name          = "corgi-ssp",
> +    .name          = TYPE_CORGI_SSP,
>      .parent        = TYPE_SSI_SLAVE,
>      .instance_size = sizeof(CorgiSSPState),
>      .class_init    = corgi_ssp_class_init,
> @@ -1249,7 +1256,7 @@ static void spitz_lcdtg_class_init(ObjectClass *klass, void *data)
>  }
>
>  static const TypeInfo spitz_lcdtg_info = {
> -    .name          = "spitz-lcdtg",
> +    .name          = TYPE_SPITZ_LCDTG,
>      .parent        = TYPE_SSI_SLAVE,
>      .instance_size = sizeof(SpitzLCDTG),
>      .class_init    = spitz_lcdtg_class_init,
> --
> 2.20.1
>
>

