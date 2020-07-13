Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21B7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9352B2075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anpuXNVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9352B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2bW-0004or-R9
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 13:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv2aj-0003xm-Hz; Mon, 13 Jul 2020 13:50:13 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv2ah-00071l-Lf; Mon, 13 Jul 2020 13:50:13 -0400
Received: by mail-ej1-x644.google.com with SMTP id w6so18246416ejq.6;
 Mon, 13 Jul 2020 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w9ccvdUWDcNVWONo+PyLnO9BNyxcXjYmLZoFSnV+chE=;
 b=anpuXNVoQpGcH/XOkY+aPAX1aQyNL5B24WPNQb2SGHVr52SnNABB6zhwM75ply4Gzg
 dekhTgXVk6ZKA1/MMAY9217DdATG8oSWRF/emmZWGbejrmIVR2OC4RZ9vxAIGQh63nsc
 hYhhOAat98RuaQF0xcBtvt9hRhEUPdQDFxEUDimCcbFdoUX5+u4O4KDwvke3XTZcen4L
 WcCG4Aq1juZJx/ke7HZywCHk2BAtAtn5Oohp9Gh3WX3PpcrnDLrP3uYrIk4oo5o8Rq3J
 pHKOA3Cwyo39xogoa4/HRYnfzvQp00u/CDr1alU5lamJyEyiqdGez2an6PtOMfYGgQyw
 biaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w9ccvdUWDcNVWONo+PyLnO9BNyxcXjYmLZoFSnV+chE=;
 b=O/l8L1k+f4+0K+1Iut6FnIt4R2w49YFzrQhGEfUqqsgTFixr2joWFp/i1oDtOmud/I
 bm7xLEuIHLHcW9S28kTSr5+EeHspHw7GaEZS3qUGSgUGlzEQPgYuHbrP0gDYUKo1JyvQ
 lzDeKXCoSX1QFFEPXLCnnNoEYCaoOW/IrwvqIOTT00p+h+2RE/DxK5EwJE+TCpPqRAhi
 09Ma2+TsNvg9XO2lvYGeJtVwtMEZC7CYFFziiviQpyZBfoMbtO0PvDSbgiS+SbnHJWuy
 I8qhJU2PVlQB8tFNzZUAV07CBN7Y12M53YByFVLcsVb1eYqmB/itx7DWFISAMBOF5E+l
 kcrQ==
X-Gm-Message-State: AOAM530mcMJmcj5nd7PqmOAjYYZ/I/H4AKzk0i/79WMkizBPwN8V4O7v
 5Knr3vgrLx9ZXLehbUE9J7ltjaIFydI=
X-Google-Smtp-Source: ABdhPJxQwqz2hDAIDfYCtM6vKbAda/vWic8rWMnWj4n6AWbbUqMEH74Thxgzyg1wZgxEXJuom5iW5w==
X-Received: by 2002:a17:906:5f98:: with SMTP id
 a24mr790290eju.241.1594662609843; 
 Mon, 13 Jul 2020 10:50:09 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id x16sm12040058edr.52.2020.07.13.10.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 10:50:09 -0700 (PDT)
Subject: Re: [PATCH v5 06/11] hw/arm: Load -bios image as a boot ROM for
 npcm7xx
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-7-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f88fae50-cb96-f5db-4820-24667bd8dacc@amsat.org>
Date: Mon, 13 Jul 2020 19:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709003608.3834629-7-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
> If a -bios option is specified on the command line, load the image into
> the internal ROM memory region, which contains the first instructions
> run by the CPU after reset.
> 
> A minimal Apache-2.0-licensed boot ROM can be found at
> 
> https://github.com/google/vbootrom
> 
> It is by no means feature complete, but it is enough to launch the
> Nuvoton bootblock[1] from offset 0 in the flash, which in turn will
> launch u-boot and finally the Linux kernel.

Peter, should we include it as submodule with the compiled blob in
pc-bios/?

> 
> [1] https://github.com/Nuvoton-Israel/bootblock
> 
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  hw/arm/npcm7xx_boards.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
> index d78d9f991b..80cf1535f1 100644
> --- a/hw/arm/npcm7xx_boards.c
> +++ b/hw/arm/npcm7xx_boards.c
> @@ -19,8 +19,11 @@
>  #include "hw/arm/boot.h"
>  #include "hw/arm/npcm7xx.h"
>  #include "hw/core/cpu.h"
> +#include "hw/loader.h"
>  #include "qapi/error.h"
> +#include "qemu-common.h"
>  #include "qemu/units.h"
> +#include "sysemu/sysemu.h"
>  
>  #define NPCM750_EVB_POWER_ON_STRAPS 0x00001ff7
>  #define QUANTA_GSJ_POWER_ON_STRAPS 0x00001fff
> @@ -34,6 +37,25 @@ static struct arm_boot_info npcm7xx_binfo = {
>      .board_id           = -1,
>  };
>  
> +static void npcm7xx_load_bootrom(NPCM7xxState *soc)
> +{
> +    if (bios_name) {
> +        g_autofree char *filename = NULL;
> +        int ret;
> +
> +        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +        if (!filename) {
> +            error_report("Could not find ROM image '%s'", bios_name);
> +            exit(1);
> +        }
> +        ret = load_image_mr(filename, &soc->irom);
> +        if (ret < 0) {
> +            error_report("Failed to load ROM image '%s'", filename);
> +            exit(1);
> +        }
> +    }
> +}
> +
>  static void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
>  {
>      NPCM7xxClass *sc = NPCM7XX_GET_CLASS(soc);
> @@ -73,6 +95,7 @@ static void npcm750_evb_init(MachineState *machine)
>      npcm7xx_connect_dram(soc, machine->ram);
>      qdev_realize(DEVICE(soc), NULL, &error_abort);
>  
> +    npcm7xx_load_bootrom(soc);
>      npcm7xx_load_kernel(machine, soc);
>  }
>  
> @@ -84,6 +107,7 @@ static void quanta_gsj_init(MachineState *machine)
>      npcm7xx_connect_dram(soc, machine->ram);
>      qdev_realize(DEVICE(soc), NULL, &error_abort);
>  
> +    npcm7xx_load_bootrom(soc);
>      npcm7xx_load_kernel(machine, soc);
>  }
>  
> 

