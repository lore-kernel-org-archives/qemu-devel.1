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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252AEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE05320772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWl2GiIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE05320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr42C-0003X1-6N
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jr41Q-0002wI-Nm; Thu, 02 Jul 2020 14:33:20 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:44494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jr41O-00034Y-My; Thu, 02 Jul 2020 14:33:20 -0400
Received: by mail-il1-x144.google.com with SMTP id h16so1772864ilj.11;
 Thu, 02 Jul 2020 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5PbbYiGUx96C2AMbgbMNNHkDvfL6IWZj4OuocjIjTN8=;
 b=XWl2GiIkSSnCyTfIts6sAuVeeGlCgW5Cublcv3Rjlo6/I2cnz/BmEH+TwmBzVBmrgs
 3VsXI63s8V1xviq05w5sCdTCYW24zNbl/ubvWnTE2fuG8S2dGEL3a1RYhP4KGZHK5YfX
 OeOAJYKkumsGjTot1o0JQGbDqrTmcwv+DZfh2qVWcD1fUFts4j3Pbtnd+rTLsiLSY+ow
 luuhG6aDJW5pEAxGu+S5nUqj4QpoGrMuySL9jJORkx+7cr36Jx5BlpRE/I6xoCDOzRSg
 zPHroKnzgGswmcDaXvnCFoyTcjBwexFVz/8K5bXEqlRC8uJMuF9a1VVdfRUuD1oPfcwl
 3x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5PbbYiGUx96C2AMbgbMNNHkDvfL6IWZj4OuocjIjTN8=;
 b=HxAM+qH7AlEeWdA3gHWlqtfEw2O/0aKsvzzWpGMNdn5A3sPuyZlRH5QhfLO6fPbeY8
 7LAVwGWH2ldE3xDJ5I6Xen9nGO+Kp6vUx7fBshwA0JRPHj1AK7Aqz4uqTuepsycxTG0I
 Vt7BxhKgFKhsbJmhAXljyD4KeRi1cmaEO84ZtgSTPa8EZL98FvSC7FGPqLzC9xkCOpAc
 lGX5QbaTpsp18uobO+cserPwnWr/16wQhR/Y4T/hZ7/Jd5jIrkF2cvX3HW20w46DzYkc
 daU9NJboC2SPC4xBknYhSedJWNJ//hLCNw7CXPPx3/NrTcxu5xAUd2PNLldq4NZU8ecg
 bSNA==
X-Gm-Message-State: AOAM533Xi7prcCn01KWhxUE5dJPEMt4RscJQfqfKD1U9AdIFz4zwWlOn
 c9bJffWDfyducvdlSMIgoWrPjPg3e24RG+9M6CI=
X-Google-Smtp-Source: ABdhPJwLcBDIfqkdYPOmXi3lDhRwjCaxcmcicDjvIZmBVdvfcCmejrs4+YAmazcw4eQ4E/x87WC7u2ZdaMt+JLOGar8=
X-Received: by 2002:a92:d186:: with SMTP id z6mr14929667ilz.227.1593714796758; 
 Thu, 02 Jul 2020 11:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-18-peter.maydell@linaro.org>
In-Reply-To: <20200628142429.17111-18-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Jul 2020 11:23:29 -0700
Message-ID: <CAKmqyKMSSYZCLT95xur5V3eyz25oX_hMFynifzQrurqTPMUniQ@mail.gmail.com>
Subject: Re: [PATCH 17/17] Replace uses of FROM_SSI_SLAVE() macro with QOM
 casts
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
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

On Sun, Jun 28, 2020 at 7:37 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The FROM_SSI_SLAVE() macro predates QOM and is used as a typesafe way
> to cast from an SSISlave* to the instance struct of a subtype of
> TYPE_SSI_SLAVE.  Switch to using the QOM cast macros instead, which
> have the same effect (by writing the QOM macros if the types were
> previously missing them.)
>
> (The FROM_SSI_SLAVE() macro allows the SSISlave member of the
> subtype's struct to be anywhere as long as it is named "ssidev",
> whereas a QOM cast macro insists that it is the first thing in the
> subtype's struct.  This is true for all the types we convert here.)
>
> This removes all the uses of FROM_SSI_SLAVE() so we can delete the
> definition.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/ssi/ssi.h |  2 --
>  hw/arm/z2.c          | 11 +++++++----
>  hw/display/ads7846.c |  9 ++++++---
>  hw/display/ssd0323.c | 10 +++++++---
>  hw/sd/ssi-sd.c       |  4 ++--
>  5 files changed, 22 insertions(+), 14 deletions(-)
>
> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
> index 5fd411f2e4e..eac168aa1db 100644
> --- a/include/hw/ssi/ssi.h
> +++ b/include/hw/ssi/ssi.h
> @@ -66,8 +66,6 @@ struct SSISlave {
>      bool cs;
>  };
>
> -#define FROM_SSI_SLAVE(type, dev) DO_UPCAST(type, ssidev, dev)
> -
>  extern const VMStateDescription vmstate_ssi_slave;
>
>  #define VMSTATE_SSI_SLAVE(_field, _state) {                          \
> diff --git a/hw/arm/z2.c b/hw/arm/z2.c
> index a0f40959904..e1f22f58681 100644
> --- a/hw/arm/z2.c
> +++ b/hw/arm/z2.c
> @@ -111,9 +111,12 @@ typedef struct {
>      int pos;
>  } ZipitLCD;
>
> +#define TYPE_ZIPIT_LCD "zipit-lcd"
> +#define ZIPIT_LCD(obj) OBJECT_CHECK(ZipitLCD, (obj), TYPE_ZIPIT_LCD)
> +
>  static uint32_t zipit_lcd_transfer(SSISlave *dev, uint32_t value)
>  {
> -    ZipitLCD *z = FROM_SSI_SLAVE(ZipitLCD, dev);
> +    ZipitLCD *z = ZIPIT_LCD(dev);
>      uint16_t val;
>      if (z->selected) {
>          z->buf[z->pos] = value & 0xff;
> @@ -153,7 +156,7 @@ static void z2_lcd_cs(void *opaque, int line, int level)
>
>  static void zipit_lcd_realize(SSISlave *dev, Error **errp)
>  {
> -    ZipitLCD *z = FROM_SSI_SLAVE(ZipitLCD, dev);
> +    ZipitLCD *z = ZIPIT_LCD(dev);
>      z->selected = 0;
>      z->enabled = 0;
>      z->pos = 0;
> @@ -185,7 +188,7 @@ static void zipit_lcd_class_init(ObjectClass *klass, void *data)
>  }
>
>  static const TypeInfo zipit_lcd_info = {
> -    .name          = "zipit-lcd",
> +    .name          = TYPE_ZIPIT_LCD,
>      .parent        = TYPE_SSI_SLAVE,
>      .instance_size = sizeof(ZipitLCD),
>      .class_init    = zipit_lcd_class_init,
> @@ -325,7 +328,7 @@ static void z2_init(MachineState *machine)
>
>      type_register_static(&zipit_lcd_info);
>      type_register_static(&aer915_info);
> -    z2_lcd = ssi_create_slave(mpu->ssp[1], "zipit-lcd");
> +    z2_lcd = ssi_create_slave(mpu->ssp[1], TYPE_ZIPIT_LCD);
>      bus = pxa2xx_i2c_bus(mpu->i2c[0]);
>      i2c_create_slave(bus, TYPE_AER915, 0x55);
>      wm = i2c_create_slave(bus, TYPE_WM8750, 0x1b);
> diff --git a/hw/display/ads7846.c b/hw/display/ads7846.c
> index 9228b40b1af..56bf82fe079 100644
> --- a/hw/display/ads7846.c
> +++ b/hw/display/ads7846.c
> @@ -29,6 +29,9 @@ typedef struct {
>      int output;
>  } ADS7846State;
>
> +#define TYPE_ADS7846 "ads7846"
> +#define ADS7846(obj) OBJECT_CHECK(ADS7846State, (obj), TYPE_ADS7846)
> +
>  /* Control-byte bitfields */
>  #define CB_PD0         (1 << 0)
>  #define CB_PD1         (1 << 1)
> @@ -61,7 +64,7 @@ static void ads7846_int_update(ADS7846State *s)
>
>  static uint32_t ads7846_transfer(SSISlave *dev, uint32_t value)
>  {
> -    ADS7846State *s = FROM_SSI_SLAVE(ADS7846State, dev);
> +    ADS7846State *s = ADS7846(dev);
>
>      switch (s->cycle ++) {
>      case 0:
> @@ -139,7 +142,7 @@ static const VMStateDescription vmstate_ads7846 = {
>  static void ads7846_realize(SSISlave *d, Error **errp)
>  {
>      DeviceState *dev = DEVICE(d);
> -    ADS7846State *s = FROM_SSI_SLAVE(ADS7846State, d);
> +    ADS7846State *s = ADS7846(d);
>
>      qdev_init_gpio_out(dev, &s->interrupt, 1);
>
> @@ -166,7 +169,7 @@ static void ads7846_class_init(ObjectClass *klass, void *data)
>  }
>
>  static const TypeInfo ads7846_info = {
> -    .name          = "ads7846",
> +    .name          = TYPE_ADS7846,
>      .parent        = TYPE_SSI_SLAVE,
>      .instance_size = sizeof(ADS7846State),
>      .class_init    = ads7846_class_init,
> diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
> index c3bdb18742c..32d27f008ae 100644
> --- a/hw/display/ssd0323.c
> +++ b/hw/display/ssd0323.c
> @@ -66,9 +66,13 @@ typedef struct {
>      uint8_t framebuffer[128 * 80 / 2];
>  } ssd0323_state;
>
> +#define TYPE_SSD0323 "ssd0323"
> +#define SSD0323(obj) OBJECT_CHECK(ssd0323_state, (obj), TYPE_SSD0323)
> +
> +
>  static uint32_t ssd0323_transfer(SSISlave *dev, uint32_t data)
>  {
> -    ssd0323_state *s = FROM_SSI_SLAVE(ssd0323_state, dev);
> +    ssd0323_state *s = SSD0323(dev);
>
>      switch (s->mode) {
>      case SSD0323_DATA:
> @@ -346,7 +350,7 @@ static const GraphicHwOps ssd0323_ops = {
>  static void ssd0323_realize(SSISlave *d, Error **errp)
>  {
>      DeviceState *dev = DEVICE(d);
> -    ssd0323_state *s = FROM_SSI_SLAVE(ssd0323_state, d);
> +    ssd0323_state *s = SSD0323(d);
>
>      s->col_end = 63;
>      s->row_end = 79;
> @@ -368,7 +372,7 @@ static void ssd0323_class_init(ObjectClass *klass, void *data)
>  }
>
>  static const TypeInfo ssd0323_info = {
> -    .name          = "ssd0323",
> +    .name          = TYPE_SSD0323,
>      .parent        = TYPE_SSI_SLAVE,
>      .instance_size = sizeof(ssd0323_state),
>      .class_init    = ssd0323_class_init,
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 25cec2ddeaa..25cdf4c966d 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -74,7 +74,7 @@ typedef struct {
>
>  static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
>  {
> -    ssi_sd_state *s = FROM_SSI_SLAVE(ssi_sd_state, dev);
> +    ssi_sd_state *s = SSI_SD(dev);
>
>      /* Special case: allow CMD12 (STOP TRANSMISSION) while reading data.  */
>      if (s->mode == SSI_SD_DATA_READ && val == 0x4d) {
> @@ -241,7 +241,7 @@ static const VMStateDescription vmstate_ssi_sd = {
>
>  static void ssi_sd_realize(SSISlave *d, Error **errp)
>  {
> -    ssi_sd_state *s = FROM_SSI_SLAVE(ssi_sd_state, d);
> +    ssi_sd_state *s = SSI_SD(d);
>      DeviceState *carddev;
>      DriveInfo *dinfo;
>      Error *err = NULL;
> --
> 2.20.1
>
>

