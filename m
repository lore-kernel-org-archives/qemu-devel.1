Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4441DC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 14:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70BA2086A
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 14:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEWZSuuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70BA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEaNH-0008FD-H1
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 10:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iEaMC-0007Th-DN
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 10:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iEaMB-0006GR-4h
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 10:39:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iEaMA-0006Do-UO; Sun, 29 Sep 2019 10:39:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id r5so8104979wrm.12;
 Sun, 29 Sep 2019 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=3Z/R1kHsTRJ7swG7MknTo7vDjiNZ5Rpu/Zr7b0aDuac=;
 b=HEWZSuuoa8jz+TIXBO0qM/EjX+oR9AiWfUhlFtI5OQqPoZtX8LmLwqYdkVMUWObsj6
 EX9IQE+dRsxOLfGFZKzRT6rRaTQYq5OMoUnL+/xqHbNbXmArd4nbntFGcVflqV8jbyuc
 AwBbGEQBgTDWQdmY9pDNBS6d/yAtWWCOmSB7jOXe8Ep2o60PGZaXV8A3oAOV5UfL5YSS
 J4wzNefzRoQJKM06L+q/3ITzj/vy0HFQOdalBK45NrlZfmxRR+oI0ULVOVxXI3Cy+kII
 TlpvEusbRHRKyPLwX0O7oWbVoCi6ILKBSMM0iJ2e3/dbDzTkk6ggKAs4qaMQ75GzkYON
 ouzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=3Z/R1kHsTRJ7swG7MknTo7vDjiNZ5Rpu/Zr7b0aDuac=;
 b=VLsq0aSFN3YoUcabYO/pCWr/H4EyZH4icdT3x+488eSFQvvpOH4WzaxHoaVSZeJmx3
 lJUgCmYnGgK5rtF6ErRbJi1apIUGB1SQNB4sq0X5XBjDOED6qhH+qAu0jOOucZdiEMYY
 QyRRm5W0VWNLCDsA3N+mOmc33aU8Na3hZhFLoSzlORwYmJR8rE1kFDgYCbJ181c9LW1D
 bTDktX+T16M777omAfM4Z/1o0Ng/atl/k/K7R80e2lPDh/sijQYFKzCHlr061UplEwTk
 1OaHumlubP7eR3lh9bLL9BVZHTsjiAKPycG+H0mVQUBAG3+DBo26o1dKtIuHzBh/BPxd
 6Ifg==
X-Gm-Message-State: APjAAAU0DQUXKTkCMGeX4J+PonJCLaMm970Z8XYv464HkCDGzNaIS/qV
 j5Ce3IJ/HCLWJNJ6F665Z75w8xpGq2MzrMTX
X-Google-Smtp-Source: APXvYqxTMU4U1H5iCs37W2DS8luOwMplm9bKZieBhC26gjcwhNIGfXxHS5LqYaaBsl2XKE8H9KzzzA==
X-Received: by 2002:a5d:650d:: with SMTP id x13mr9741949wru.37.1569767965283; 
 Sun, 29 Sep 2019 07:39:25 -0700 (PDT)
Received: from ?IPv6:2a01:c22:b04f:b200:7a70:bbc8:8101:45be?
 ([2a01:c22:b04f:b200:7a70:bbc8:8101:45be])
 by smtp.gmail.com with ESMTPSA id 79sm15159984wmb.7.2019.09.29.07.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2019 07:39:24 -0700 (PDT)
Message-ID: <c603fa19d006cbd7bdab476a677d7bf5da8b0451.camel@gmail.com>
Subject: Re: [PATCH 08/14] hw/arm/bcm2836: Make the SoC code modular
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Baumann
 <Andrew.Baumann@microsoft.com>,  qemu-devel@nongnu.org, Pekka Enberg
 <penberg@iki.fi>,  =?ISO-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>
Date: Sun, 29 Sep 2019 16:39:14 +0200
In-Reply-To: <20190904171315.8354-9-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-9-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El mié, 04-09-2019 a las 19:13 +0200, Philippe Mathieu-Daudé escribió:
> This file creates the BCM2836/BCM2837 blocks.
> The biggest differences with the BCM2838 we are going to add, are
> the base addresses of the interrupt controller and the peripherals.
> Add these addresses in the BCM283XInfo structure to make this
> block more modular. Remove the MCORE_OFFSET offset as it is
> not useful and rather confusing.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/bcm2836.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 493a913f89..019e67b906 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -16,15 +16,11 @@
>  #include "hw/arm/raspi_platform.h"
>  #include "hw/sysbus.h"
>  
> -/* Peripheral base address seen by the CPU */
> -#define BCM2836_PERI_BASE       0x3F000000
> -
> -/* "QA7" (Pi2) interrupt controller and mailboxes etc. */
> -#define BCM2836_CONTROL_BASE    0x40000000
> -
>  struct BCM283XInfo {
>      const char *name;
>      const char *cpu_type;
> +    hwaddr peri_base; /* Peripheral base address seen by the CPU */
> +    hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
>      int clusterid;
>  };
>  
> @@ -32,12 +28,16 @@ static const BCM283XInfo bcm283x_socs[] = {
>      {
>          .name = TYPE_BCM2836,
>          .cpu_type = ARM_CPU_TYPE_NAME("cortex-a7"),
> +        .peri_base = 0x3f000000,
> +        .ctrl_base = 0x40000000,
>          .clusterid = 0xf,
>      },
>  #ifdef TARGET_AARCH64
>      {
>          .name = TYPE_BCM2837,
>          .cpu_type = ARM_CPU_TYPE_NAME("cortex-a53"),
> +        .peri_base = 0x3f000000,
> +        .ctrl_base = 0x40000000,
>          .clusterid = 0x0,
>      },
>  #endif
> @@ -104,7 +104,7 @@ static void bcm2836_realize(DeviceState *dev,
> Error **errp)
>      }
>  
>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
> -                            BCM2836_PERI_BASE, 1);
> +                            info->peri_base, 1);
>  
>      /* bcm2836 interrupt controller (and mailboxes, etc.) */
>      object_property_set_bool(OBJECT(&s->control), true, "realized",
> &err);
> @@ -113,7 +113,7 @@ static void bcm2836_realize(DeviceState *dev,
> Error **errp)
>          return;
>      }
>  
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0,
> BCM2836_CONTROL_BASE);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info-
> >ctrl_base);
>  
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
>          qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
> @@ -126,7 +126,7 @@ static void bcm2836_realize(DeviceState *dev,
> Error **errp)
>  
>          /* set periphbase/CBAR value for CPU-local registers */
>          object_property_set_int(OBJECT(&s->cpus[n]),
> -                                BCM2836_PERI_BASE + MCORE_OFFSET,
> +                                info->peri_base,
>                                  "reset-cbar", &err);
>          if (err) {
>              error_propagate(errp, err);
Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>


