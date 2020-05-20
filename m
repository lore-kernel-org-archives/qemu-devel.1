Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81810C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6642053B
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZIVSQ/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6642053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbHpq-0004HT-AK
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 02:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jbHp0-0003gI-7t; Wed, 20 May 2020 02:03:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jbHoy-0001xv-T1; Wed, 20 May 2020 02:03:17 -0400
Received: by mail-wm1-x341.google.com with SMTP id h4so1392193wmb.4;
 Tue, 19 May 2020 23:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HyOt4PhZvXd4Q5bYxIrSo3XkYLjcB1+iP2V6k0j/7Ss=;
 b=PZIVSQ/i7K9kJVZk/BFJjQQuTdrbc0u42/fE2FKSdwN0ICbn4dRuihXSUxMG7LimsQ
 7Ef0w4A7/h9V3RyR8pV6XwIlLgWBvayYdH/Z6Px/W+YxYROocLylDQOsfnl80Q3NiQ5R
 SctUf55wfwlGIVDZ0wJT298d0wQgxxUUqhFCQA0gk1bKr1fM4INDHzAyZdzFnXXaKsO8
 SuZlQvQDiug/nojDsGubqVgS+f6k8DiasaWQNn3X0HhBhpgnqZ0WOzasyRI5LU+sxftu
 yD7e8VhkRukGDZA4HIGo43JQbL6zJ9/zaawTl+BEQpUUWGCkh8l1fut1Og0y0A/MdMkS
 tTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HyOt4PhZvXd4Q5bYxIrSo3XkYLjcB1+iP2V6k0j/7Ss=;
 b=s1xtxZtZyTMKd9XmMnNh2a0H1irlNmRedn+CkKZ1ivJYZaIW25aulEqBS9v+2/0yPc
 834y20a5mLOL/v0QPP+lnLk6vcyJbUkVznK4skgdfKAg2usomQQ/nNdpjA7Uui8R/xAs
 T+Amb4ccdVTnAAbN5h1Zhxq1iRWOfTsNREX4AiR3i2Qe+7/9CuwLJTlye+8FU8XhXd88
 DFlTfxlj+RsbUiFF/zgALA3i86+WFOlK2+C9+p6omguLE84V0gnPTyUH1WLd5ShEMW0Y
 /FhzZqh6ctVSL9nMI3iZwLNJ7xuc7PMY8vkOEUHOvseRQXktUovpx7NrlJpiBQrF5AaJ
 taDQ==
X-Gm-Message-State: AOAM530tsOD4RROfQK6GYkH1gUo6zSaW5Ga327+uPGQsitAz3xazgrrz
 vcTx+JmqoQ3yfVWLt71zjeo=
X-Google-Smtp-Source: ABdhPJxcUdf06pWBgEUN4mov+Y3hRDm3INsxsMr+AcLkwcVr4wJImCqg0R4q8J/pl0Ku7Ixjb2XlHA==
X-Received: by 2002:a05:600c:1403:: with SMTP id
 g3mr3140887wmi.51.1589954595044; 
 Tue, 19 May 2020 23:03:15 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id l1sm1771697wrc.24.2020.05.19.23.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 23:03:14 -0700 (PDT)
Subject: Re: [PATCH v3 7/9] riscv/opentitan: Connect the PLIC device
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1589923785.git.alistair.francis@wdc.com>
 <9151811027d175a261f68f17a1cd13963d47abcd.1589923785.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <16c378ff-4e36-4c5c-5298-7aad84a6f3d1@amsat.org>
Date: Wed, 20 May 2020 08:03:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9151811027d175a261f68f17a1cd13963d47abcd.1589923785.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 11:31 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Bin Meng <bin.meng@windriver.com>
> ---
>   include/hw/riscv/opentitan.h |  3 +++
>   hw/riscv/opentitan.c         | 19 +++++++++++++++++--
>   2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
> index 15a3d87ed0..8d6a09b696 100644
> --- a/include/hw/riscv/opentitan.h
> +++ b/include/hw/riscv/opentitan.h
> @@ -20,6 +20,7 @@
>   #define HW_OPENTITAN_H
>   
>   #include "hw/riscv/riscv_hart.h"
> +#include "hw/intc/ibex_plic.h"
>   
>   #define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
>   #define RISCV_IBEX_SOC(obj) \
> @@ -31,6 +32,8 @@ typedef struct LowRISCIbexSoCState {
>   
>       /*< public >*/
>       RISCVHartArrayState cpus;
> +    IbexPlicState plic;
> +
>       MemoryRegion flash_mem;
>       MemoryRegion rom;
>   } LowRISCIbexSoCState;
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index c00f0720ab..3926321d8c 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -25,6 +25,7 @@
>   #include "hw/misc/unimp.h"
>   #include "hw/riscv/boot.h"
>   #include "exec/address-spaces.h"
> +#include "sysemu/sysemu.h"
>   
>   static const struct MemmapEntry {
>       hwaddr base;
> @@ -92,6 +93,9 @@ static void riscv_lowrisc_ibex_soc_init(Object *obj)
>       object_initialize_child(obj, "cpus", &s->cpus,
>                               sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
>                               &error_abort, NULL);
> +
> +    sysbus_init_child_obj(obj, "plic", &s->plic,
> +                          sizeof(s->plic), TYPE_IBEX_PLIC);
>   }
>   
>   static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
> @@ -100,6 +104,9 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
>       MachineState *ms = MACHINE(qdev_get_machine());
>       LowRISCIbexSoCState *s = RISCV_IBEX_SOC(dev_soc);
>       MemoryRegion *sys_mem = get_system_memory();
> +    DeviceState *dev;
> +    SysBusDevice *busdev;
> +    Error *err = NULL;
>   
>       object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
>                               &error_abort);
> @@ -120,6 +127,16 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
>       memory_region_add_subregion(sys_mem, memmap[IBEX_FLASH].base,
>                                   &s->flash_mem);
>   
> +    /* PLIC */
> +    dev = DEVICE(&s->plic);
> +    object_property_set_bool(OBJECT(&s->plic), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    busdev = SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, memmap[IBEX_PLIC].base);
> +
>       create_unimplemented_device("riscv.lowrisc.ibex.uart",
>           memmap[IBEX_UART].base, memmap[IBEX_UART].size);
>       create_unimplemented_device("riscv.lowrisc.ibex.gpio",
> @@ -134,8 +151,6 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
>           memmap[IBEX_AES].base, memmap[IBEX_AES].size);
>       create_unimplemented_device("riscv.lowrisc.ibex.hmac",
>           memmap[IBEX_HMAC].base, memmap[IBEX_HMAC].size);
> -    create_unimplemented_device("riscv.lowrisc.ibex.plic",
> -        memmap[IBEX_PLIC].base, memmap[IBEX_PLIC].size);
>       create_unimplemented_device("riscv.lowrisc.ibex.pinmux",
>           memmap[IBEX_PINMUX].base, memmap[IBEX_PINMUX].size);
>       create_unimplemented_device("riscv.lowrisc.ibex.alert_handler",
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

