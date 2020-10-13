Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5140C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34F7208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHgi38SP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34F7208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSQKW-0006VH-LJ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 15:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSQJW-0005xH-Ga; Tue, 13 Oct 2020 15:50:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSQJT-0003PU-K0; Tue, 13 Oct 2020 15:50:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id n6so755039wrm.13;
 Tue, 13 Oct 2020 12:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ABIm1lG34M/zrUJE+H9qXJ66CM0yrKj9NMLYN89BYoc=;
 b=UHgi38SP54j4CSgDVuWx4fyoG5r/FCCzq50IDDYctcSG8/tbY8DBF6KbVGGwgT/Bu7
 CmyqrjV+uDD+KSTA533aoERWjleYodHJkiV6k51+4aKeucNjZWk8yaj4eY77QTwy/BwG
 fz8mnycygWTOSlQARQGo5wolV8AZ+qMr4hLeQoFp9ew70dh4z6McILRlY9lo0Kf7bZu6
 Zy3NFv/fy3abevDA3alwZOYmxgKa2RcXk7aF1dMbmlIGLUJ8wkzBZTGVEpgvvVXK6t0X
 ZscTWH0jnFoHikA+9jxYCq/qsfH5Vvq37qTevfSxsx+egANMHuX0a+WqcIMWFmMWVTCk
 JbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ABIm1lG34M/zrUJE+H9qXJ66CM0yrKj9NMLYN89BYoc=;
 b=gnpxVyvWk4E41VJhekBbUGxOUIUX/Nxdi3C17ZRD16lI6Om/HTi2eXEQISy5hx+tRW
 +jZkYqnTcHNJPauvZO4jINVH1ZkjsSWScwqc3QuKml4E/5oGKOPjrDWeRxDRVdSwAJwW
 rgTtqdcitGpURjrdnOSVXj65t8anzGQbm9Flqfri/j7c9gzq89tQ90r7u3ce6oZyijRj
 3cARfra4vbDl8LsDRHs6RRgyvXpY5btfsVhKoArpRfs9mXgAx8WziU840j2z43t4Hd0I
 dLX9Vvjr5Ez0cW+sS5zUnQMtb8lbtqKI75NB7z281GEyx1r5k1qT1j7w8EvhffxedpFd
 xazQ==
X-Gm-Message-State: AOAM532BuBDLy3sSOx1hLQrJ2xbRGUjpTUrjgesfb13G/J9ejJc3JtY7
 JqxNN3KANx3zLaKk6uba5Kw=
X-Google-Smtp-Source: ABdhPJxzdRR8w3dH0vSmNJPP8AsAyZDZesmiMxalqtb6qOIWhrdiI9xVYf07B35jYQI5fhS0unGYdg==
X-Received: by 2002:a5d:4144:: with SMTP id c4mr1335884wrq.311.1602618621650; 
 Tue, 13 Oct 2020 12:50:21 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x4sm902735wrt.93.2020.10.13.12.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 12:50:20 -0700 (PDT)
Subject: Re: [PATCH v7 8/8] mac_oldworld: Add SPD data to cover RAM
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1593456926.git.balaton@eik.bme.hu>
 <9f5f44878dc0f60b073201e657d6e4dcc940f68c.1593456926.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5f4c18c1-80ff-f605-fdd7-7ae474443690@amsat.org>
Date: Tue, 13 Oct 2020 21:50:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <9f5f44878dc0f60b073201e657d6e4dcc940f68c.1593456926.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 8:55 PM, BALATON Zoltan wrote:
> OpenBIOS gets RAM size via fw_cfg but rhe original board firmware

Typo "the".

> detects RAM using SPD data so generate and add SDP eeproms to cover as

EEPROMs?

> much RAM as possible to describe with SPD (this may be less than the
> actual ram_size due to SDRAM size constraints).
> 
> This patch is more complex as it should be which I intend to fix once
> agreement can be made on how to get back the necessary functionality
> removed by previous patches. See in this thread:
> https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg08710.html
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/mac_oldworld.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 6276973c95..6a27287c9f 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -34,6 +34,7 @@
>   #include "hw/input/adb.h"
>   #include "sysemu/sysemu.h"
>   #include "net/net.h"
> +#include "hw/i2c/smbus_eeprom.h"
>   #include "hw/isa/isa.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_host.h"
> @@ -104,6 +105,8 @@ static void ppc_heathrow_init(MachineState *machine)
>       DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>       void *fw_cfg;
>       uint64_t tbfreq;
> +    uint8_t *spd_data[3] = {};
> +    I2CBus *i2c_bus;
>   
>       /* init CPUs */
>       for (i = 0; i < smp_cpus; i++) {
> @@ -121,8 +124,16 @@ static void ppc_heathrow_init(MachineState *machine)
>                        "maximum 2047 MB", ram_size / MiB);
>           exit(1);
>       }
> -
>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> +    for (i = 0; i < 3; i++) {

3 -> ARRAY_SIZE(spd_data)

> +        int size_left = ram_size - i * 512 * MiB;
> +        if (size_left > 0) {
> +            uint32_t s = size_left / MiB;
> +            s = (s > 512 ? 512 : s);

MIN()?

> +            s = 1U << (31 - clz32(s));
> +            spd_data[i] = spd_data_generate(SDR, s * MiB);
> +        }
> +    }
>   
>       /* allocate and load firmware ROM */
>       memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", PROM_SIZE,
> @@ -302,6 +313,12 @@ static void ppc_heathrow_init(MachineState *machine)
>       macio_ide_init_drives(macio_ide, &hd[MAX_IDE_DEVS]);
>   
>       dev = DEVICE(object_resolve_path_component(OBJECT(macio), "cuda"));
> +    i2c_bus = I2C_BUS(qdev_get_child_bus(dev, "i2c"));
> +    for (i = 0; i < 3; i++) {

3 -> ARRAY_SIZE(spd_data)

> +        if (spd_data[i]) {
> +            smbus_eeprom_init_one(i2c_bus, 0x50 + i, spd_data[i]);
> +        }
> +    }
>       adb_bus = qdev_get_child_bus(dev, "adb.0");
>       dev = qdev_new(TYPE_ADB_KEYBOARD);
>       qdev_realize_and_unref(dev, adb_bus, &error_fatal);
> 


