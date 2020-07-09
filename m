Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B11C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 06:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16490206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 06:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gq2tzsB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16490206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtPlh-0004jE-A8
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 02:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtPkk-00040g-Nz; Thu, 09 Jul 2020 02:09:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtPki-0006Xa-EA; Thu, 09 Jul 2020 02:09:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id f2so991704wrp.7;
 Wed, 08 Jul 2020 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uJM/pU09YoUQQFr/KwGy8X71g6ER/Rccx4BTl22UyTA=;
 b=Gq2tzsB5C/GF/FINuUpIsXdmyeuWFoMsjb3fx46r7NrBHPU5+1X3SEewObweFrvrlM
 sDncgwdFsr3g3hDJ5Jj4Z3YOlr2PBIytdatptPS/JK2s8BeK55OMXzT8M7BXTS1hOEcN
 qRt5BGKrOHJp/TdmjpwSrFsKbAtK2dDJHp6V7bU1jM18mydnq5iLgdCgwv2DDsZT+vk8
 hhqmqfIccYwzg81Xjh86c52FuNZ+dqh7MPMcEk7ny/3FYMr/xtmdCL/SufEww4o54bF4
 H8C/yJd0id/FfdNii8Yxz4sBqAJi2udlZXyY8xt++kHVCiufS7s/68J/iUQmtecgnEE/
 3kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=uJM/pU09YoUQQFr/KwGy8X71g6ER/Rccx4BTl22UyTA=;
 b=oLy5XOWAZkezDa8ms/DEuqMM7pCjaH0qYXhsXIw7CsA43i9mnUislclMHpSN+/UOjk
 nXlMrmXH8QpncxPOkpInfN18oWW436DQlLV8GP2u/Ca3NznP7QoIagob2Ad+1HcBaJtV
 shbl0q9kjGAMYdq5w2vG6GiDAg3EwnNL5VSC5ODNhj2GzkWkcfPU7Bwaq6OLnw+AWqrY
 MC8qH3BKr3vGWChmL2nU0MGqPJxF5AxNPyf5tWt8+VI+0B5FSIQm7evG+Nt2h9l6pqRW
 B2wh2SrldOoOoGwl/t/gjJ22JDTIFbqrCIlrv0HgRvkMylbBaGCpnNyWeKldslT2SBsF
 JknA==
X-Gm-Message-State: AOAM532PdGrY1w6tFRC/vDoKgbPPdDUiUOn6pkWPkk0JVPf5bP0eZB37
 Pj4fFn45l3mM3loC8rO3aKw=
X-Google-Smtp-Source: ABdhPJwY770dLYIyLEnFWWA16Y7oJTqZfuM3yVWr/LzihUfIdkRJuUoPN0jGEZAZKU5WJooVjgrGmQ==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr59995446wru.8.1594274986480; 
 Wed, 08 Jul 2020 23:09:46 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id o29sm4164829wra.5.2020.07.08.23.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 23:09:45 -0700 (PDT)
Subject: Re: [PATCH v5 05/11] hw/arm: Add two NPCM7xx-based machines
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-6-hskinnemoen@google.com>
 <46869856-cc4f-e694-d56f-27d42dee5a08@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <c506f212-2119-32f3-5bfc-7dbb1e5fdf28@amsat.org>
Date: Thu, 9 Jul 2020 08:09:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <46869856-cc4f-e694-d56f-27d42dee5a08@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Avi.Fishman@nuvoton.com, qemu-devel@nongnu.org, kfting@nuvoton.com,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 7:57 AM, Philippe Mathieu-Daudé wrote:
> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
>> This adds two new machines, both supported by OpenBMC:
>>
>>   - npcm750-evb: Nuvoton NPCM750 Evaluation Board.
>>   - quanta-gsj: A board with a NPCM730 chip.
>>
>> They rely on the NPCM7xx SoC device to do the heavy lifting. They are
>> almost completely identical at the moment, apart from the SoC type,
>> which currently only changes the reset contents of one register
>> (GCR.MDLR), but they might grow apart a bit more as more functionality
>> is added.
>>
>> Both machines can boot the Linux kernel into /bin/sh.
>>
>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>> ---
>>  default-configs/arm-softmmu.mak |   1 +
>>  include/hw/arm/npcm7xx.h        |  19 ++++
>>  hw/arm/npcm7xx_boards.c         | 156 ++++++++++++++++++++++++++++++++
>>  hw/arm/Makefile.objs            |   2 +-
>>  4 files changed, 177 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/arm/npcm7xx_boards.c
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>> index 8fc09a4a51..9a94ebd0be 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -27,6 +27,7 @@ CONFIG_GUMSTIX=y
>>  CONFIG_SPITZ=y
>>  CONFIG_TOSA=y
>>  CONFIG_Z2=y
>> +CONFIG_NPCM7XX=y
>>  CONFIG_COLLIE=y
>>  CONFIG_ASPEED_SOC=y
>>  CONFIG_NETDUINO2=y
>> diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
>> index 95d9224f59..b8b76bc07b 100644
>> --- a/include/hw/arm/npcm7xx.h
>> +++ b/include/hw/arm/npcm7xx.h
>> @@ -35,6 +35,25 @@
>>  #define NPCM7XX_SMP_BOOTREG_ADDR        (0xf080013c)  /* GCR.SCRPAD */
>>  #define NPCM7XX_GIC_CPU_IF_ADDR         (0xf03fe100)  /* GIC within A9 */
>>  
>> +typedef struct NPCM7xxMachine {
>> +    MachineState        parent;
>> +} NPCM7xxMachine;
>> +
>> +#define TYPE_NPCM7XX_MACHINE MACHINE_TYPE_NAME("npcm7xx")
>> +#define NPCM7XX_MACHINE(obj)                                            \
>> +    OBJECT_CHECK(NPCM7xxMachine, (obj), TYPE_NPCM7XX_MACHINE)
>> +
>> +typedef struct NPCM7xxMachineClass {
>> +    MachineClass        parent;
>> +
>> +    const char          *soc_type;
>> +} NPCM7xxMachineClass;
>> +
>> +#define NPCM7XX_MACHINE_CLASS(klass)                                    \
>> +    OBJECT_CLASS_CHECK(NPCM7xxMachineClass, (klass), TYPE_NPCM7XX_MACHINE)
>> +#define NPCM7XX_MACHINE_GET_CLASS(obj)                                  \
>> +    OBJECT_GET_CLASS(NPCM7xxMachineClass, (obj), TYPE_NPCM7XX_MACHINE)
>> +
>>  typedef struct NPCM7xxState {
>>      DeviceState         parent;
>>  
>> diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
>> new file mode 100644
>> index 0000000000..d78d9f991b
>> --- /dev/null
>> +++ b/hw/arm/npcm7xx_boards.c
>> @@ -0,0 +1,156 @@
>> +/*
>> + * Machine definitions for boards featuring an NPCM7xx SoC.
>> + *
>> + * Copyright 2020 Google LLC
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
>> + * for more details.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "hw/arm/boot.h"
>> +#include "hw/arm/npcm7xx.h"
>> +#include "hw/core/cpu.h"
>> +#include "qapi/error.h"
>> +#include "qemu/units.h"
>> +
>> +#define NPCM750_EVB_POWER_ON_STRAPS 0x00001ff7
>> +#define QUANTA_GSJ_POWER_ON_STRAPS 0x00001fff
>> +
>> +static struct arm_boot_info npcm7xx_binfo = {
>> +    .loader_start       = NPCM7XX_LOADER_START,
>> +    .smp_loader_start   = NPCM7XX_SMP_LOADER_START,
>> +    .smp_bootreg_addr   = NPCM7XX_SMP_BOOTREG_ADDR,
>> +    .gic_cpu_if_addr    = NPCM7XX_GIC_CPU_IF_ADDR,
>> +    .write_secondary_boot = npcm7xx_write_secondary_boot,
>> +    .board_id           = -1,
>> +};
>> +
>> +static void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
>> +{
>> +    NPCM7xxClass *sc = NPCM7XX_GET_CLASS(soc);
>> +
>> +    npcm7xx_binfo.ram_size = machine->ram_size;
>> +    npcm7xx_binfo.nb_cpus = sc->num_cpus;
>> +
>> +    arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
>> +}
>> +
>> +static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion *dram)
>> +{
> 
> You might need a check such:
> 
>     if (memory_region_size(dram) > NPCM7XX_DRAM_SZ) {
>         error_report("Invalid RAM size, maximum allowed is 2GB");
>         exit(1);
>     }
> 
> Or add a npcm7xx_verify_dram_size(MachineState *machine) and use
> machine->ram_size.
> 
> Hardware don't really care you use more than 2GB, the memory
> above 2GB is not addressable by the SoC.
> 
> Maybe the check belongs to npcm7xx_gcr_realize() instead?
> 
>     if (dram_size > 2 * GiB) {
>         warn_report(...)
>     }
>     if (dram_size >= 2 * GiB) {
>         s->reset_intcr3 |= 4 << 8;
>     ...
> 
> If the GCR is generic to a family of Nuvoton chipsets and expected to
> also work when using ARMv8-A cores (able to address >4GB), then the
> check belongs to npcm7xx_realize().
> 
> With this addressed:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>> +    memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, dram);
>> +
>> +    object_property_set_link(OBJECT(soc), OBJECT(dram), "dram-mr",
>> +                             &error_abort);
>> +}
>> +
>> +static NPCM7xxState *npcm7xx_create_soc(MachineState *machine,
>> +                                        uint32_t hw_straps)
>> +{
>> +    NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_GET_CLASS(machine);
>> +    Object *obj;
>> +

Oh I forgot, you also need:

        if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
            error_report("This board can only be used with CPU %s",
                         mc->default_cpu_type);
            exit(1);
        }

With ...

>> +    obj = object_new_with_props(nmc->soc_type, OBJECT(machine), "soc",
>> +                                &error_abort, NULL);
>> +    object_property_set_uint(obj, hw_straps, "power-on-straps", &error_abort);
>> +
>> +    return NPCM7XX(obj);
>> +}
>> +
>> +static void npcm750_evb_init(MachineState *machine)
>> +{
>> +    NPCM7xxState *soc;
>> +
>> +    soc = npcm7xx_create_soc(machine, NPCM750_EVB_POWER_ON_STRAPS);
>> +    npcm7xx_connect_dram(soc, machine->ram);
>> +    qdev_realize(DEVICE(soc), NULL, &error_abort);
>> +
>> +    npcm7xx_load_kernel(machine, soc);
>> +}
>> +
>> +static void quanta_gsj_init(MachineState *machine)
>> +{
>> +    NPCM7xxState *soc;
>> +
>> +    soc = npcm7xx_create_soc(machine, QUANTA_GSJ_POWER_ON_STRAPS);
>> +    npcm7xx_connect_dram(soc, machine->ram);
>> +    qdev_realize(DEVICE(soc), NULL, &error_abort);
>> +
>> +    npcm7xx_load_kernel(machine, soc);
>> +}
>> +
>> +static void npcm7xx_set_soc_type(NPCM7xxMachineClass *nmc, const char *type)
>> +{
>> +    NPCM7xxClass *sc = NPCM7XX_CLASS(object_class_by_name(type));
>> +    MachineClass *mc = MACHINE_CLASS(nmc);
>> +
>> +    nmc->soc_type = type;
>> +    mc->default_cpus = mc->min_cpus = mc->max_cpus = sc->num_cpus;
>> +}
>> +
>> +static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
>> +{
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +
>> +    mc->no_floppy       = 1;
>> +    mc->no_cdrom        = 1;
>> +    mc->no_parallel     = 1;
>> +    mc->default_ram_id  = "ram";

... this here:

        mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");

>> +}
>> +
>> +/*
>> + * Schematics:
>> + * https://github.com/Nuvoton-Israel/nuvoton-info/blob/master/npcm7xx-poleg/evaluation-board/board_deliverables/NPCM750x_EB_ver.A1.1_COMPLETE.pdf
>> + */
>> +static void npcm750_evb_machine_class_init(ObjectClass *oc, void *data)
>> +{
>> +    NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +
>> +    npcm7xx_set_soc_type(nmc, TYPE_NPCM750);
>> +
>> +    mc->desc            = "Nuvoton NPCM750 Evaluation Board (Cortex A9)";
>> +    mc->init            = npcm750_evb_init;
> 
> Either use 'var = value' or pad and align the '=' :)
> 
>> +    mc->default_ram_size = 512 * MiB;
>> +};
>> +
>> +static void gsj_machine_class_init(ObjectClass *oc, void *data)
>> +{
>> +    NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +
>> +    npcm7xx_set_soc_type(nmc, TYPE_NPCM730);
>> +
>> +    mc->desc            = "Quanta GSJ (Cortex A9)";
>> +    mc->init            = quanta_gsj_init;
>> +    mc->default_ram_size = 512 * MiB;
>> +};
>> +
>> +static const TypeInfo npcm7xx_machine_types[] = {
>> +    {
>> +        .name           = TYPE_NPCM7XX_MACHINE,
>> +        .parent         = TYPE_MACHINE,
>> +        .instance_size  = sizeof(NPCM7xxMachine),
>> +        .class_size     = sizeof(NPCM7xxMachineClass),
>> +        .class_init     = npcm7xx_machine_class_init,
>> +        .abstract       = true,
>> +    }, {
>> +        .name           = MACHINE_TYPE_NAME("npcm750-evb"),
>> +        .parent         = TYPE_NPCM7XX_MACHINE,
>> +        .class_init     = npcm750_evb_machine_class_init,
>> +    }, {
>> +        .name           = MACHINE_TYPE_NAME("quanta-gsj"),
>> +        .parent         = TYPE_NPCM7XX_MACHINE,
>> +        .class_init     = gsj_machine_class_init,
>> +    },
>> +};
>> +
>> +DEFINE_TYPES(npcm7xx_machine_types)
>> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
>> index 13d163a599..c333548ce1 100644
>> --- a/hw/arm/Makefile.objs
>> +++ b/hw/arm/Makefile.objs
>> @@ -41,7 +41,7 @@ obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
>>  obj-$(CONFIG_STM32F405_SOC) += stm32f405_soc.o
>>  obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
>>  obj-$(CONFIG_XLNX_VERSAL) += xlnx-versal.o xlnx-versal-virt.o
>> -obj-$(CONFIG_NPCM7XX) += npcm7xx.o
>> +obj-$(CONFIG_NPCM7XX) += npcm7xx.o npcm7xx_boards.o
>>  obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
>>  obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
>>  obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o
>>
> 

