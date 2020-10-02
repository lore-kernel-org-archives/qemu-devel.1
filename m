Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0120C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407B7206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZqg87mA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407B7206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMkF-0005nN-9Z
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOMTH-0008QU-EL; Fri, 02 Oct 2020 10:55:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOMTE-0005sU-J6; Fri, 02 Oct 2020 10:55:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id v12so2064872wmh.3;
 Fri, 02 Oct 2020 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HIUbFBaGFs+zDNCwEeYpcXbfIO6Aj85k50HldrkBzn4=;
 b=PZqg87mA95FnXhbT77ae5gMalhe5hf5gjBxYNf8cFA1xyTnpHN3yKjO591cPyLT38M
 4Pdf1QraWbVqtQ6rmBWB0QS/C+xqnO1rer+v+1lTuzkOMXzmoOcRkx569oFBrQZ30LBw
 n7fezWASlK6OavcXrAh8YjYqGU81nCeous9SHtUOIaMCiSGXDAucOV+PKzxqvwVv5L4y
 4A/EU0T6f9SGhyR8G6ptDBe+y8LhY8ZQXLDFfCb3QdJLZIP7DgDjSaD2tWDfE3+W1iBE
 APd44aO3AObDwYcHT0/ud+InVpSyq811wpCQ4ZQfP20a02ilIQF/LBcyG1ImoTNFt7JL
 Xc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HIUbFBaGFs+zDNCwEeYpcXbfIO6Aj85k50HldrkBzn4=;
 b=DoGd973mRjcjyCBWtrIitUL4hPjQRYHkdVK+8VOuqLWP+5wRh6fI2LaRUzsCVKa6wD
 7s/Y8FryXaKg5jBrjMpy+53qdPk5jzckEIN+5CXfcGazx3lZYH36rJWsIvPkE4ar9Sdf
 Rp4oJBEEggAfStgowLeh2VznZnMo1iCbM5K0rUAZFw/7L1zxj83uQ5/XLIjoUUI6Rz7v
 CrAQ6miTlPGJT18S3R0m/zRM9nN83SPgMm+fbRZ4bWnVe9OPM5slJKZGNzi5cm4X3L/q
 ivN3UDpsKXT0a8Ihgv3La4LImjrY/KbhY92dhgIsEQ6SOCUB9VOMmAwDGzxEDaGRfXRk
 9T/w==
X-Gm-Message-State: AOAM533PR7XoQr4yrN+r1geHWGMDqYZ9lNtjpaxSaIUAK7dGiFEFKrpD
 RL2bFSa4QC07121sa3WF9Qk=
X-Google-Smtp-Source: ABdhPJzYWtUf05PtItNzJdRXiT0dGRQYPBke6bwkUMpg5cAyAymdCrGReecLjN+vwOLunQu0Nf9W0Q==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr3302101wmt.22.1601650537845; 
 Fri, 02 Oct 2020 07:55:37 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id q13sm2056241wra.93.2020.10.02.07.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 07:55:37 -0700 (PDT)
Subject: Re: [PATCH 11/14] hw/misc/bcm2835_cprman: add the DSI0HSCK multiplexer
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-12-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ab123333-fd8b-9334-f70d-501bc2a4fbf0@amsat.org>
Date: Fri, 2 Oct 2020 16:55:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-12-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.256,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 12:17 PM, Luc Michel wrote:
> This simple mux sits between the PLL channels and the DSI0E and DSI0P
> clock muxes. This mux selects between PLLA-DSI0 and PLLD-DSI0 channel
> and outputs the selected signal to source number 4 of DSI0E/P clock
> muxes. It is controlled by the cm_dsi0hsck register.
> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  include/hw/misc/bcm2835_cprman.h           | 15 +++++
>  include/hw/misc/bcm2835_cprman_internals.h |  6 ++
>  hw/misc/bcm2835_cprman.c                   | 78 +++++++++++++++++++++-
>  3 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
> index c2a89e8e90..5555a299fc 100644
> --- a/include/hw/misc/bcm2835_cprman.h
> +++ b/include/hw/misc/bcm2835_cprman.h
> @@ -171,20 +171,35 @@ typedef struct CprmanClockMuxState {
>       * source number.
>       */
>      struct CprmanClockMuxState *backref[CPRMAN_NUM_CLOCK_MUX_SRC];
>  } CprmanClockMuxState;
>  
> +typedef struct CprmanDsi0HsckMuxState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    CprmanClockMux id;
> +
> +    uint32_t *reg_cm;
> +
> +    Clock *plla_in;
> +    Clock *plld_in;
> +    Clock *out;
> +} CprmanDsi0HsckMuxState;
> +
>  struct BCM2835CprmanState {
>      /*< private >*/
>      SysBusDevice parent_obj;
>  
>      /*< public >*/
>      MemoryRegion iomem;
>  
>      CprmanPLLState plls[CPRMAN_NUM_PLL];
>      CprmanPLLChannelState channels[CPRMAN_NUM_PLL_CHANNEL];
>      CprmanClockMuxState clock_muxes[CPRMAN_NUM_CLOCK_MUX];
> +    CprmanDsi0HsckMuxState dsi0hsck_mux;
>  
>      uint32_t regs[CPRMAN_NUM_REGS];
>      uint32_t xosc_freq;
>  
>      Clock *xosc;
> diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
> index a2b5a1aa50..ad07cf5276 100644
> --- a/include/hw/misc/bcm2835_cprman_internals.h
> +++ b/include/hw/misc/bcm2835_cprman_internals.h
> @@ -13,17 +13,20 @@
>  #include "hw/misc/bcm2835_cprman.h"
>  
>  #define TYPE_CPRMAN_PLL "bcm2835-cprman-pll"
>  #define TYPE_CPRMAN_PLL_CHANNEL "bcm2835-cprman-pll-channel"
>  #define TYPE_CPRMAN_CLOCK_MUX "bcm2835-cprman-clock-mux"
> +#define TYPE_CPRMAN_DSI0HSCK_MUX "bcm2835-cprman-dsi0hsck-mux"
>  
>  DECLARE_INSTANCE_CHECKER(CprmanPLLState, CPRMAN_PLL,
>                           TYPE_CPRMAN_PLL)
>  DECLARE_INSTANCE_CHECKER(CprmanPLLChannelState, CPRMAN_PLL_CHANNEL,
>                           TYPE_CPRMAN_PLL_CHANNEL)
>  DECLARE_INSTANCE_CHECKER(CprmanClockMuxState, CPRMAN_CLOCK_MUX,
>                           TYPE_CPRMAN_CLOCK_MUX)
> +DECLARE_INSTANCE_CHECKER(CprmanDsi0HsckMuxState, CPRMAN_DSI0HSCK_MUX,
> +                         TYPE_CPRMAN_DSI0HSCK_MUX)
>  
>  /* Register map */
>  
>  /* PLLs */
>  REG32(CM_PLLA, 0x104)
> @@ -221,10 +224,13 @@ REG32(CM_LOCK, 0x114)
>      FIELD(CM_LOCK, FLOCKD, 11, 1)
>      FIELD(CM_LOCK, FLOCKC, 10, 1)
>      FIELD(CM_LOCK, FLOCKB, 9, 1)
>      FIELD(CM_LOCK, FLOCKA, 8, 1)
>  
> +REG32(CM_DSI0HSCK, 0x120)
> +    FIELD(CM_DSI0HSCK, SELPLLD, 0, 1)
> +
>  /*
>   * This field is common to all registers. Each register write value must match
>   * the CPRMAN_PASSWORD magic value in its 8 MSB.
>   */
>  FIELD(CPRMAN, PASSWORD, 24, 8)
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index 75bc11939b..e576ab2642 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -327,10 +327,62 @@ static const TypeInfo cprman_clock_mux_info = {
>      .class_init = clock_mux_class_init,
>      .instance_init = clock_mux_init,
>  };
>  
>  
> +/* DSI0HSCK mux */
> +
> +static void dsi0hsck_mux_update(CprmanDsi0HsckMuxState *s)
> +{
> +    bool src_is_plld = FIELD_EX32(*s->reg_cm, CM_DSI0HSCK, SELPLLD);
> +    Clock *src = src_is_plld ? s->plld_in : s->plla_in;
> +
> +    clock_update(s->out, clock_get(src));
> +}
> +
> +static void dsi0hsck_mux_in_update(void *opaque)
> +{
> +    dsi0hsck_mux_update(CPRMAN_DSI0HSCK_MUX(opaque));
> +}
> +
> +static void dsi0hsck_mux_init(Object *obj)
> +{
> +    CprmanDsi0HsckMuxState *s = CPRMAN_DSI0HSCK_MUX(obj);
> +    DeviceState *dev = DEVICE(obj);
> +
> +    s->plla_in = qdev_init_clock_in(dev, "plla-in", dsi0hsck_mux_in_update, s);
> +    s->plld_in = qdev_init_clock_in(dev, "plld-in", dsi0hsck_mux_in_update, s);
> +    s->out = qdev_init_clock_out(DEVICE(s), "out");
> +}
> +
> +static const VMStateDescription dsi0hsck_mux_vmstate = {
> +    .name = TYPE_CPRMAN_DSI0HSCK_MUX,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_CLOCK(plla_in, CprmanDsi0HsckMuxState),
> +        VMSTATE_CLOCK(plld_in, CprmanDsi0HsckMuxState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void dsi0hsck_mux_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->vmsd = &dsi0hsck_mux_vmstate;
> +}
> +
> +static const TypeInfo cprman_dsi0hsck_mux_info = {
> +    .name = TYPE_CPRMAN_DSI0HSCK_MUX,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(CprmanDsi0HsckMuxState),
> +    .class_init = dsi0hsck_mux_class_init,
> +    .instance_init = dsi0hsck_mux_init,
> +};
> +
> +
>  /* CPRMAN "top level" model */
>  
>  static uint32_t get_cm_lock(const BCM2835CprmanState *s)
>  {
>      static const int CM_LOCK_MAPPING[] = {
> @@ -488,10 +540,14 @@ static void cprman_write(void *opaque, hwaddr offset,
>      case R_CM_SDCCTL ... R_CM_ARMCTL:
>      case R_CM_AVEOCTL ... R_CM_EMMCDIV:
>      case R_CM_EMMC2CTL ... R_CM_EMMC2DIV:
>          update_mux_from_cm(s, idx);
>          break;
> +
> +    case R_CM_DSI0HSCK:
> +        dsi0hsck_mux_update(&s->dsi0hsck_mux);
> +        break;
>      }
>  }
>  
>  #undef CASE_PLL_A2W_REGS
>  
> @@ -519,10 +575,12 @@ static void cprman_reset(DeviceState *dev)
>  
>      for (i = 0; i < CPRMAN_NUM_PLL_CHANNEL; i++) {
>          device_cold_reset(DEVICE(&s->channels[i]));
>      }
>  
> +    device_cold_reset(DEVICE(&s->dsi0hsck_mux));
> +
>      for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
>          device_cold_reset(DEVICE(&s->clock_muxes[i]));
>      }
>  
>      clock_update_hz(s->xosc, s->xosc_freq);
> @@ -560,10 +618,14 @@ static void cprman_init(Object *obj)
>                                  &s->channels[i],
>                                  TYPE_CPRMAN_PLL_CHANNEL);
>          set_pll_channel_init_info(s, &s->channels[i], i);
>      }
>  
> +    object_initialize_child(obj, "dsi0hsck-mux",
> +                            &s->dsi0hsck_mux, TYPE_CPRMAN_DSI0HSCK_MUX);
> +    s->dsi0hsck_mux.reg_cm = &s->regs[R_CM_DSI0HSCK];
> +
>      for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
>          char *alias;
>  
>          object_initialize_child(obj, CLOCK_MUX_INIT_INFO[i].name,
>                                  &s->clock_muxes[i],
> @@ -608,11 +670,11 @@ static void connect_mux_sources(BCM2835CprmanState *s,
>          Clock *src;
>  
>          if (mapping == CPRMAN_CLOCK_SRC_FORCE_GROUND) {
>              src = s->gnd;
>          } else if (mapping == CPRMAN_CLOCK_SRC_DSI0HSCK) {
> -            src = s->gnd; /* TODO */
> +            src = s->dsi0hsck_mux.out;
>          } else if (i < CPRMAN_CLOCK_SRC_PLLA) {
>              src = CLK_SRC_MAPPING[i];
>          } else {
>              src = s->channels[mapping].out;
>          }
> @@ -646,10 +708,23 @@ static void cprman_realize(DeviceState *dev, Error **errp)
>          if (!qdev_realize(DEVICE(channel), NULL, errp)) {
>              return;
>          }
>      }
>  
> +    {
> +        CprmanDsi0HsckMuxState *dsi0hsck_mux = &s->dsi0hsck_mux;

Why use a new block?

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
> +        clock_set_source(dsi0hsck_mux->plla_in,
> +                         s->channels[CPRMAN_PLLA_CHANNEL_DSI0].out);
> +        clock_set_source(dsi0hsck_mux->plld_in,
> +                         s->channels[CPRMAN_PLLD_CHANNEL_DSI0].out);
> +
> +        if (!qdev_realize(DEVICE(dsi0hsck_mux), NULL, errp)) {
> +            return;
> +        }
> +    }
> +
>      for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
>          CprmanClockMuxState *clock_mux = &s->clock_muxes[i];
>  
>          connect_mux_sources(s, clock_mux, CLOCK_MUX_INIT_INFO[i].src_mapping);
>  
> @@ -696,8 +771,9 @@ static void cprman_register_types(void)
>  {
>      type_register_static(&cprman_info);
>      type_register_static(&cprman_pll_info);
>      type_register_static(&cprman_pll_channel_info);
>      type_register_static(&cprman_clock_mux_info);
> +    type_register_static(&cprman_dsi0hsck_mux_info);
>  }
>  
>  type_init(cprman_register_types);
> 

