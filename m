Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D610C742D1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D662020665
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D662020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzLz-0001B1-0E
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37603)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlzLo-0000mP-52
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlzLm-0004SF-N3
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:28:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlzLm-0004Rg-FF
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:28:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so10734566wrf.11
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Iua3+7y3KjwQ//Ijl/1tDlJTjpt1E8gdBd/UZUqInQ=;
 b=sH4C71ljT/lxZrQVDdaPzJHa7nWYjg/ehIIcIwFAb0/7CmZawl8Up8jHSdueBxE1pJ
 CmnpW+CEYgV9/nnkXjbw1gfAK/DRdxxjGX1RaSSQKQtAdUDV2C2I9U5NAHdGs1n9P4U5
 RCsbNFpJ6gvrtf4+NMtAADCUfok/RuoQVVyi9FZPhzMY8ymHBKWKWgtrhBV6FLPHhEc5
 bUQDPJyK62G/hHiBl1tV4LZHPhDydIxSTnDLcpPWHJKLNtOGL3YTKFKf6dNceKqsn7Qp
 c4VTMCHNLRC7AWJbkWtYKxw6oHdomVwrUh4M9oJbLfOnAfIugTt3NEnoWmq+LdPPvb2x
 SmAw==
X-Gm-Message-State: APjAAAV+flqlXVBkF8JHFM4BfSuyQekLyrzPRVUOeD5AVh9yywBpE0YN
 xVw+NcnNolnlw4GzeQU0Gexvqw==
X-Google-Smtp-Source: APXvYqw2hQ0PDTc/kQkkJudU9fpbz42tmFT/KujGuKOrUsTJKD9kw9641+Ihx1xSotVYrwuUAkHXyA==
X-Received: by 2002:adf:fc8d:: with SMTP id g13mr6521798wrr.234.1562952529440; 
 Fri, 12 Jul 2019 10:28:49 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id h6sm8759697wre.82.2019.07.12.10.28.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:28:48 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190712115030.26895-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5e29549d-cc13-a44e-cd8b-ae63ced1f9a9@redhat.com>
Date: Fri, 12 Jul 2019 19:28:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712115030.26895-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-4.1?] hw/arm/fsl-imx6ul.c: Remove dead
 SMP-related code
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
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 1:50 PM, Peter Maydell wrote:
> The i.MX6UL always has a single Cortex-A7 CPU (we set FSL_IMX6UL_NUM_CPUS
> to 1 in line with this). This means that all the code in fsl-imx6ul.c to
> handle multiple CPUs is dead code, and Coverity is now complaining that
> it is unreachable (CID 1403008, 1403011).
> 
> Remove the unreachable code and the only-executes-once loops,
> and replace the single-entry cpu[] array in the FSLIMX6ULState
> with a simple cpu member.

The header says "Based on hw/arm/fsl-imx7.c" which has
FSL_IMX7_NUM_CPUS=2, makes sense.

Looking at the i.MX 6:

include/hw/arm/fsl-imx6.h:38:#define FSL_IMX6_NUM_CPUS 4

Ok, we can have 1/2/4 cpus in the family.

The UltraLite series is part of the i.MX 6 family, I wonder why we
needed a different FslIMX6ULState than FslIMX6State.

Anyway, not related to this cleanup patch, so meanwhile:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The only real reason to put this into 4.1 is because it fixes
> some Coverity issues, and it would be nice to be able to get
> down to no Coverity issues for the release. I think that pre-rc1
> that's a reasonable reason to put this in.

Agreed.

> Disclaimer: tested with "make check" as I have no test image for
> this board.
> 
>  include/hw/arm/fsl-imx6ul.h |  2 +-
>  hw/arm/fsl-imx6ul.c         | 62 +++++++++++--------------------------
>  hw/arm/mcimx6ul-evk.c       |  2 +-
>  3 files changed, 20 insertions(+), 46 deletions(-)
> 
> diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
> index 9e94e98f8ee..eda389aec7d 100644
> --- a/include/hw/arm/fsl-imx6ul.h
> +++ b/include/hw/arm/fsl-imx6ul.h
> @@ -61,7 +61,7 @@ typedef struct FslIMX6ULState {
>      DeviceState    parent_obj;
>  
>      /*< public >*/
> -    ARMCPU             cpu[FSL_IMX6UL_NUM_CPUS];
> +    ARMCPU             cpu;
>      A15MPPrivState     a7mpcore;
>      IMXGPTState        gpt[FSL_IMX6UL_NUM_GPTS];
>      IMXEPITState       epit[FSL_IMX6UL_NUM_EPITS];
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index f8601654388..b074177a71d 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -29,16 +29,12 @@
>  
>  static void fsl_imx6ul_init(Object *obj)
>  {
> -    MachineState *ms = MACHINE(qdev_get_machine());
>      FslIMX6ULState *s = FSL_IMX6UL(obj);
>      char name[NAME_SIZE];
>      int i;
>  
> -    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX6UL_NUM_CPUS); i++) {
> -        snprintf(name, NAME_SIZE, "cpu%d", i);
> -        object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
> -                                "cortex-a7-" TYPE_ARM_CPU, &error_abort, NULL);
> -    }
> +    object_initialize_child(obj, "cpu0", &s->cpu, sizeof(s->cpu),
> +                            "cortex-a7-" TYPE_ARM_CPU, &error_abort, NULL);
>  
>      /*
>       * A7MPCORE
> @@ -161,42 +157,25 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>      MachineState *ms = MACHINE(qdev_get_machine());
>      FslIMX6ULState *s = FSL_IMX6UL(dev);
>      int i;
> -    qemu_irq irq;
>      char name[NAME_SIZE];
> -    unsigned int smp_cpus = ms->smp.cpus;
> +    SysBusDevice *sbd;
> +    DeviceState *d;
>  
> -    if (smp_cpus > FSL_IMX6UL_NUM_CPUS) {
> -        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
> -                   TYPE_FSL_IMX6UL, FSL_IMX6UL_NUM_CPUS, smp_cpus);
> +    if (ms->smp.cpus > 1) {
> +        error_setg(errp, "%s: Only a single CPU is supported (%d requested)",
> +                   TYPE_FSL_IMX6UL, ms->smp.cpus);
>          return;
>      }
>  
> -    for (i = 0; i < smp_cpus; i++) {
> -        Object *o = OBJECT(&s->cpu[i]);
> -
> -        object_property_set_int(o, QEMU_PSCI_CONDUIT_SMC,
> -                                "psci-conduit", &error_abort);
> -
> -        /* On uniprocessor, the CBAR is set to 0 */
> -        if (smp_cpus > 1) {
> -            object_property_set_int(o, FSL_IMX6UL_A7MPCORE_ADDR,
> -                                    "reset-cbar", &error_abort);
> -        }
> -
> -        if (i) {
> -            /* Secondary CPUs start in PSCI powered-down state */
> -            object_property_set_bool(o, true,
> -                                     "start-powered-off", &error_abort);
> -        }
> -
> -        object_property_set_bool(o, true, "realized", &error_abort);
> -    }
> +    object_property_set_int(OBJECT(&s->cpu), QEMU_PSCI_CONDUIT_SMC,
> +                            "psci-conduit", &error_abort);
> +    object_property_set_bool(OBJECT(&s->cpu), true,
> +                             "realized", &error_abort);
>  
>      /*
>       * A7MPCORE
>       */
> -    object_property_set_int(OBJECT(&s->a7mpcore), smp_cpus, "num-cpu",
> -                            &error_abort);
> +    object_property_set_int(OBJECT(&s->a7mpcore), 1, "num-cpu", &error_abort);
>      object_property_set_int(OBJECT(&s->a7mpcore),
>                              FSL_IMX6UL_MAX_IRQ + GIC_INTERNAL,
>                              "num-irq", &error_abort);
> @@ -204,18 +183,13 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>                               &error_abort);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX6UL_A7MPCORE_ADDR);
>  
> -    for (i = 0; i < smp_cpus; i++) {
> -        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->a7mpcore);
> -        DeviceState  *d   = DEVICE(qemu_get_cpu(i));
> +    sbd = SYS_BUS_DEVICE(&s->a7mpcore);
> +    d = DEVICE(&s->cpu);
>  
> -        irq = qdev_get_gpio_in(d, ARM_CPU_IRQ);
> -        sysbus_connect_irq(sbd, i, irq);
> -        sysbus_connect_irq(sbd, i + smp_cpus, qdev_get_gpio_in(d, ARM_CPU_FIQ));
> -        sysbus_connect_irq(sbd, i + 2 * smp_cpus,
> -                           qdev_get_gpio_in(d, ARM_CPU_VIRQ));
> -        sysbus_connect_irq(sbd, i + 3 * smp_cpus,
> -                           qdev_get_gpio_in(d, ARM_CPU_VFIQ));
> -    }
> +    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(d, ARM_CPU_IRQ));
> +    sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(d, ARM_CPU_FIQ));
> +    sysbus_connect_irq(sbd, 2, qdev_get_gpio_in(d, ARM_CPU_VIRQ));
> +    sysbus_connect_irq(sbd, 3, qdev_get_gpio_in(d, ARM_CPU_VFIQ));
>  
>      /*
>       * A7MPCORE DAP
> diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
> index bbffb11c2a8..1f6f4aed97c 100644
> --- a/hw/arm/mcimx6ul-evk.c
> +++ b/hw/arm/mcimx6ul-evk.c
> @@ -71,7 +71,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
>      }
>  
>      if (!qtest_enabled()) {
> -        arm_load_kernel(&s->soc.cpu[0], &boot_info);
> +        arm_load_kernel(&s->soc.cpu, &boot_info);
>      }
>  }
>  
> 

