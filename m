Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20539CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAE6222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ify2u26Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAE6222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLPco-00073x-41
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 06:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLPbw-0006Wg-5e
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLPbv-0000lJ-4M
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:35:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLPbs-0000gl-8o; Fri, 18 Oct 2019 06:35:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id z9so5667483wrl.11;
 Fri, 18 Oct 2019 03:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wsEsUuJ28LH5Z78/5meTkGA88IgGhlWbsaDxLQxOako=;
 b=ify2u26YuBai5tHIi1Y6u7qBVzMYMcvQ0D7vv5OqJ2D6Eek7CvjK5CAxC0aqrsBp4C
 Z4/6v39vSZWw7jT+WxtzmlUAGYl/jwtYrmSbg5IzacizCtq1sclWxEuV1Owry58yN/Rv
 2nhsgzFLeJZwjb8YppEHQ3XXJYT8ZlWtrwHYKmvdg+J10qyISSSkwffwRSjAm6lxq/Z0
 W/GjzhGiAyzcNzDxyEa1MxNzRgduniSIj48aQRWLruOtkvVR4kAbv42ODm3osIoGYITx
 nOKB2tQXHzAmfdY+ZtHJRqf04IudZ6abxMhubvaDZ+LAY4LT2cJeoXZZMtS3W2d+81P5
 F2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wsEsUuJ28LH5Z78/5meTkGA88IgGhlWbsaDxLQxOako=;
 b=j789XpNnSXIy263fzpm47Lj+BgY3Wbl6iEKF9Sgg+wzIc73c/Yj6V9qEB/ucni/Dg3
 ZCWcfu9bwT6ysQvDZ5XcAqJYioAZQIFxUfPjw+YZALkgMWM2nZYJbk3TiciSB05PVmEX
 GZMRmalAHwR+pNKhPWUzMRIst8EYT7/ULEAFyDZSNmiyn61naM3lqd/us0Ul22QAj+L1
 1lMYyVeJ3Ui/RTWeQ7rOjVu9OD/AktROGKBMPJP3gBJgNmBNcheF9tbT5pGUch8qcNc3
 6Pf+zhbd/tWsphdNvUdeEL+gYxr0huD4bCqy9JBHweBx3+UZQlsDlkAX/1Y9cqnr5r4P
 mmyQ==
X-Gm-Message-State: APjAAAWvni9cRDyXzYqDQq/GYrbekSM4cA9m7KeiFVVVzq0mwP7m1mfz
 T+29GtXjhuFG2FVbP5NSeQ8=
X-Google-Smtp-Source: APXvYqwwcVymHSS6k9r7FObKPo7N1BuU+NsIW9Mz73fBWC342yyhHdB9JPMZg/HdD6lfGF7Zaj7aJg==
X-Received: by 2002:a05:6000:11cd:: with SMTP id
 i13mr6923218wrx.197.1571394950544; 
 Fri, 18 Oct 2019 03:35:50 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id p85sm5245772wme.23.2019.10.18.03.35.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 03:35:49 -0700 (PDT)
Subject: Re: [PATCH v2 06/10] hw/arm/bcm2836: Create VideoCore address space
 in the SoC
To: qemu-devel@nongnu.org
References: <20191017225800.6946-1-f4bug@amsat.org>
 <20191017225800.6946-7-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8dfcc577-ebfb-53a1-5338-3f6166757540@amsat.org>
Date: Fri, 18 Oct 2019 12:35:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017225800.6946-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Pekka Enberg <penberg@iki.fi>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Pete Batard <pete@akeo.ie>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 12:57 AM, Philippe Mathieu-Daudé wrote:
> Currently the VideoCore is created in the Peripheral container
> as the 'GPU bus'. It is created there because the peripherals
> using DMA use physical addresses from the VideoCore bus.
> However the VideoCore is a GPU core placed at the same
> hierarchical level than the ARM cores.
> 
> To match the datasheet design, create the VideoCore container
> in the SoC, and link it to the peripheral container.
> 
> The VideoCore bus is 1GiB wide, accessible at 4 regions in
> different cache configurations. Add the full mapping.
[...]
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 019e67b906..d712f36052 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -9,6 +9,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/units.h"
>   #include "qapi/error.h"
>   #include "qemu/module.h"
>   #include "cpu.h"
> @@ -16,6 +17,9 @@
>   #include "hw/arm/raspi_platform.h"
>   #include "hw/sysbus.h"
>   
> +/* Peripheral base address on the VC (GPU) system bus */
> +#define BCM2835_VC_PERI_BASE    0x3e000000
> +
>   struct BCM283XInfo {
>       const char *name;
>       const char *cpu_type;
> @@ -50,6 +54,21 @@ static void bcm2836_init(Object *obj)
>       const BCM283XInfo *info = bc->info;
>       int n;
>   
> +    /* VideoCore memory region */
> +    memory_region_init(&s->videocore.mr[0], obj, "videocore-bus", 1 * GiB);
> +    object_property_add_child(obj, "videocore",
> +                              OBJECT(&s->videocore.mr[0]), NULL);
> +    for (n = 1; n < BCM283X_NCPUS; n++) {
> +        static const char *alias_name[] = {
> +            NULL, "cached-coherent", "cached", "uncached"
> +        };
> +        memory_region_init_alias(&s->videocore.mr[n], obj,
> +                                 alias_name[n], &s->videocore.mr[0],
> +                                 0, 1 * GiB);

Please disregard this patch, something is incorrect here and I'll respin.

> +        memory_region_add_subregion_overlap(&s->videocore.mr[0], n * GiB,
> +                                            &s->videocore.mr[n], 0);
> +    }
> +
>       for (n = 0; n < BCM283X_NCPUS; n++) {
>           object_initialize_child(obj, "cpu[*]", &s->cpus[n], sizeof(s->cpus[n]),
>                                   info->cpu_type, &error_abort, NULL);
> @@ -71,6 +90,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
>       BCM283XState *s = BCM283X(dev);
>       BCM283XClass *bc = BCM283X_GET_CLASS(dev);
>       const BCM283XInfo *info = bc->info;
> +    MemoryRegion *ram_mr, *peri_mr;
>       Object *obj;
>       Error *err = NULL;
>       int n;
> @@ -83,26 +103,45 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
>                      __func__, error_get_pretty(err));
>           return;
>       }
[...]

