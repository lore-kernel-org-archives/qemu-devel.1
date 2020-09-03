Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CF6C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FEA20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcuuxvYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FEA20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDqsC-0001de-V4
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDqrc-00015X-JA; Thu, 03 Sep 2020 11:09:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDqra-0005s6-Go; Thu, 03 Sep 2020 11:09:24 -0400
Received: by mail-wr1-x444.google.com with SMTP id z4so3633357wrr.4;
 Thu, 03 Sep 2020 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QYVMZP0kVY/dZBKDkRbLlh1xGkA7ejXlgqZ7EU1UngM=;
 b=EcuuxvYqMyBeSOhFer7DpqZ7YgGhKFpQPMOojAyim10fb5rYRi1jlE4ArYcEL8Ur99
 M1qKX0g5TWmGxKOUnkGeXewmCetZiiKKwX86ykABrw6S3gnHHRSDXoISsdI8nMgR3Kj5
 cncKftgwm+JVyKh61fQF8pHp72BAVpltjee94zLR9046PML3HNeA19oiww0nIV44prxT
 dhT2LzBMYHTgOWuU6O9qnRtg8+nCfWL5skYxA0EQVoHBV3tLQjRRxfEu57arKM/w0UKo
 tSnndo+L7Ljtj/px7IzL2qRuzCf/G0LNaKtyhyAoki0eYGKJ1qkw8it9S1RPJKr/O6rE
 c2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QYVMZP0kVY/dZBKDkRbLlh1xGkA7ejXlgqZ7EU1UngM=;
 b=nqBo13dr8O6ajAPnheAN/WEcQNYt4CVu01+jTgg+dkGYrYQzBenDFJYIJU9/3llXht
 pvNkgyuzfJ1Ser4a/3O5Wxxf70SsDC1TS45GCue6oQUwIiL0fi75Z7XmraMPNwADoBXD
 bU1SbZpmoXxeuBUdSUg6mqAKbEwLivNZ9/aXZ+xIhTMT6o2fgZnAXLw6raVqsA/7TKiv
 bc4Pu4XqLMQ/7HdQWsNLPUg1iiDfDQvfZtpDBptwJ/RHMOpUdiuxCvSHumSuS2MZRmvH
 MnBJadH/esMjwxu9IlokPJHl16klx9BvfZ4cRVmLquvtS+HbTQmdtHb6oxSt0XPTV015
 /Wpg==
X-Gm-Message-State: AOAM531DbP13CC6fJOaMtI3MgjJGjVfsIj2c09fGa6IN6wyAy1c+6wn1
 H6bhg6IuywMyKtbp01MmOCw=
X-Google-Smtp-Source: ABdhPJyOy5DoIs+9uC1w3dG9iK+cpao86kZpXsSOOTq8Qkx74Xn7afwglAwmiUZoz01l5R2AESSLqA==
X-Received: by 2002:adf:d845:: with SMTP id k5mr2738980wrl.285.1599145760239; 
 Thu, 03 Sep 2020 08:09:20 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id h8sm4987731wrw.68.2020.09.03.08.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 08:09:19 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/mps2: New board model mps2-386
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200903144425.11060-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <10bbec10-5645-fddb-fd56-b2432b30438e@amsat.org>
Date: Thu, 3 Sep 2020 17:09:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903144425.11060-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
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
Cc: Kumar Gala <kumar.gala@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 4:44 PM, Peter Maydell wrote:
> Implement a model of the MPS2 with the AN386 firmware. This is
> essentially identical to the AN385 firmware, but it has a
> Cortex-M4 rather than a Cortex-M3.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/mps2.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> index 9f12934ca8f..559b297e788 100644
> --- a/hw/arm/mps2.c
> +++ b/hw/arm/mps2.c
> @@ -15,6 +15,7 @@
>   * as seen by the guest depend significantly on the FPGA image.
>   * We model the following FPGA images:
>   *  "mps2-an385" -- Cortex-M3 as documented in ARM Application Note AN385
> + *  "mps2-an386" -- Cortex-M4 as documented in ARM Application Note AN386
>   *  "mps2-an511" -- Cortex-M3 'DesignStart' as documented in AN511
>   *
>   * Links to the TRM for the board itself and to the various Application
> @@ -47,6 +48,7 @@
>  
>  typedef enum MPS2FPGAType {
>      FPGA_AN385,
> +    FPGA_AN386,
>      FPGA_AN511,
>  } MPS2FPGAType;
>  
> @@ -79,6 +81,7 @@ typedef struct {
>  
>  #define TYPE_MPS2_MACHINE "mps2"
>  #define TYPE_MPS2_AN385_MACHINE MACHINE_TYPE_NAME("mps2-an385")
> +#define TYPE_MPS2_AN386_MACHINE MACHINE_TYPE_NAME("mps2-an386")
>  #define TYPE_MPS2_AN511_MACHINE MACHINE_TYPE_NAME("mps2-an511")
>  
>  #define MPS2_MACHINE(obj)                                       \
> @@ -142,7 +145,7 @@ static void mps2_common_init(MachineState *machine)
>       *
>       * Common to both boards:
>       *  0x21000000..0x21ffffff : PSRAM (16MB)
> -     * AN385 only:
> +     * AN385/AN386 only:
>       *  0x00000000 .. 0x003fffff : ZBT SSRAM1
>       *  0x00400000 .. 0x007fffff : mirror of ZBT SSRAM1
>       *  0x20000000 .. 0x203fffff : ZBT SSRAM 2&3
> @@ -157,7 +160,7 @@ static void mps2_common_init(MachineState *machine)
>       *  0x20000000 .. 0x2001ffff : SRAM
>       *  0x20400000 .. 0x207fffff : ZBT SSRAM 2&3
>       *
> -     * The AN385 has a feature where the lowest 16K can be mapped
> +     * The AN385/AN386 has a feature where the lowest 16K can be mapped
>       * either to the bottom of the ZBT SSRAM1 or to the block RAM.
>       * This is of no use for QEMU so we don't implement it (as if
>       * zbt_boot_ctrl is always zero).
> @@ -166,6 +169,7 @@ static void mps2_common_init(MachineState *machine)
>  
>      switch (mmc->fpga_type) {
>      case FPGA_AN385:
> +    case FPGA_AN386:
>          make_ram(&mms->ssram1, "mps.ssram1", 0x0, 0x400000);
>          make_ram_alias(&mms->ssram1_m, "mps.ssram1_m", &mms->ssram1, 0x400000);
>          make_ram(&mms->ssram23, "mps.ssram23", 0x20000000, 0x400000);
> @@ -193,6 +197,7 @@ static void mps2_common_init(MachineState *machine)
>      armv7m = DEVICE(&mms->armv7m);
>      switch (mmc->fpga_type) {
>      case FPGA_AN385:
> +    case FPGA_AN386:
>          qdev_prop_set_uint32(armv7m, "num-irq", 32);
>          break;
>      case FPGA_AN511:
> @@ -229,6 +234,7 @@ static void mps2_common_init(MachineState *machine)
>  
>      switch (mmc->fpga_type) {
>      case FPGA_AN385:
> +    case FPGA_AN386:
>      {
>          /* The overflow IRQs for UARTs 0, 1 and 2 are ORed together.
>           * Overflow for UARTs 4 and 5 doesn't trigger any interrupt.
> @@ -380,7 +386,7 @@ static void mps2_common_init(MachineState *machine)
>       */
>      lan9118_init(&nd_table[0], 0x40200000,
>                   qdev_get_gpio_in(armv7m,
> -                                  mmc->fpga_type == FPGA_AN385 ? 13 : 47));
> +                                  mmc->fpga_type == FPGA_AN511 ? 47 : 13));

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>      system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
>  
> @@ -409,6 +415,17 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
>      mmc->scc_id = 0x41043850;
>  }
>  
> +static void mps2_an386_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    MPS2MachineClass *mmc = MPS2_MACHINE_CLASS(oc);
> +
> +    mc->desc = "ARM MPS2 with AN386 FPGA image for Cortex-M4";
> +    mmc->fpga_type = FPGA_AN386;
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
> +    mmc->scc_id = 0x41043860;
> +}
> +
>  static void mps2_an511_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -435,6 +452,12 @@ static const TypeInfo mps2_an385_info = {
>      .class_init = mps2_an385_class_init,
>  };
>  
> +static const TypeInfo mps2_an386_info = {
> +    .name = TYPE_MPS2_AN386_MACHINE,
> +    .parent = TYPE_MPS2_MACHINE,
> +    .class_init = mps2_an386_class_init,
> +};
> +
>  static const TypeInfo mps2_an511_info = {
>      .name = TYPE_MPS2_AN511_MACHINE,
>      .parent = TYPE_MPS2_MACHINE,
> @@ -445,6 +468,7 @@ static void mps2_machine_init(void)
>  {
>      type_register_static(&mps2_info);
>      type_register_static(&mps2_an385_info);
> +    type_register_static(&mps2_an386_info);
>      type_register_static(&mps2_an511_info);
>  }
>  
> 


