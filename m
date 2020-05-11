Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8854AC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DB2206D6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QV2k81JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DB2206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8v7-000803-Ez
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY8n5-0002tn-QK
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:48:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35595
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY8n1-0004ZS-7S
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589204888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t3Q3yPKfSZyavoPRIzgRmVuFzWYmw9BiInQkEYAgKHs=;
 b=QV2k81JXHDap+qDsWST+scgleZpBeMOfVvG1XgI5AjRh3b2GiviEbCHYrn1DA+jaYpmHE0
 O5GngDIaoRm0gYvo+gSAaxPFo/lxE1C7ErTwye0JIs7lUt2/E+A0YODIilDuQP1C8LM63T
 R+sAc3GPq4G5EudKyCx0UkxUKmDcPuY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-t1Wf445gNGmPqG5koHKF0A-1; Mon, 11 May 2020 09:48:05 -0400
X-MC-Unique: t1Wf445gNGmPqG5koHKF0A-1
Received: by mail-wm1-f72.google.com with SMTP id w189so4674189wmg.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t3Q3yPKfSZyavoPRIzgRmVuFzWYmw9BiInQkEYAgKHs=;
 b=hyuae2PZcrK6QPQKS4RFWFNOIKX6FxE4T296nwJhC9+mCKnaLaclM3D7Hh3BrvCP37
 ZQWIrx/lBDWyOEnuWyj69dkUXOlFuHvIjZCESHWDns3vTqy7mVAa1a8Dkhww53OKXzyZ
 ZqKmVM5GDOm5fzBtn0ioD9Pu7yZ6YuvuZHAw9SYoCSxBdQtdXb1rDkutS1hmiS+mhlps
 PSt/NMjcdPNJqkNef0bWTQ5DCkgBio/Uf+/Tu6jq4PVLciqpi6dDSDXASDZ52jNDwfJm
 SxplciwvilCIAbl1mcdKmhN5LCnT/kq9u0xqyLHhp5tZqkb73cRSEoeUKAOGg2XoDvPQ
 Z03w==
X-Gm-Message-State: AGi0PuasVpz9wXiT6UEqPP8bfqzHbhS5Y6UYTH+ngKZvelHFPeUe2J+J
 qnORYmis59enDiasye5/BG6wCMld1lixsMSK80k97k+aGpPloEREc5yQQpUbiZ7fGqV916ZoPGn
 FyBn9V74LRMSLay8=
X-Received: by 2002:a1c:2348:: with SMTP id j69mr15383637wmj.11.1589204883814; 
 Mon, 11 May 2020 06:48:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypI3RuTnLMFd6Z2OlpE8IoPsci+ScNHlAOMxBHj9zug+qJOrKUU30pN/j1GlKt9521VLAgQvPA==
X-Received: by 2002:a1c:2348:: with SMTP id j69mr15383613wmj.11.1589204883480; 
 Mon, 11 May 2020 06:48:03 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t6sm2403061wma.4.2020.05.11.06.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 06:48:02 -0700 (PDT)
Subject: Re: [PATCH 1/1] tricore: added AURIX TC277 D-Step TriBoard
To: David Brenken <david.brenken@efs-auto.org>, qemu-devel@nongnu.org
References: <20200511122159.7260-1-david.brenken@efs-auto.org>
 <20200511122159.7260-2-david.brenken@efs-auto.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a0ccf008-cd88-633b-d22c-9528d17e0c6f@redhat.com>
Date: Mon, 11 May 2020 15:48:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200511122159.7260-2-david.brenken@efs-auto.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: kbastian@mail.uni-paderborn.de,
 Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello David,

On 5/11/20 2:21 PM, David Brenken wrote:
> From: Andreas Konopik <andreas.konopik@efs-auto.de>
> 
> Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
> Signed-off-by: David Brenken <david.brenken@efs-auto.de>
> Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
> Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
> Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
> ---
>   hw/tricore/Makefile.objs           |   1 +
>   hw/tricore/aurix_triboard_tc277d.c | 240 +++++++++++++++++++++++++++++
>   2 files changed, 241 insertions(+)
>   create mode 100644 hw/tricore/aurix_triboard_tc277d.c
> 
> diff --git a/hw/tricore/Makefile.objs b/hw/tricore/Makefile.objs
> index 5501f6c1a8..e4a2106dd9 100644
> --- a/hw/tricore/Makefile.objs
> +++ b/hw/tricore/Makefile.objs
> @@ -1 +1,2 @@
>   obj-$(CONFIG_TRICORE) += tricore_testboard.o
> +obj-$(CONFIG_TRICORE) += aurix_triboard_tc277d.o
> diff --git a/hw/tricore/aurix_triboard_tc277d.c b/hw/tricore/aurix_triboard_tc277d.c
> new file mode 100644
> index 0000000000..86deff9a50
> --- /dev/null
> +++ b/hw/tricore/aurix_triboard_tc277d.c
> @@ -0,0 +1,240 @@
> +/*
> + * Infineon AURIX TC277 D-Step TriBoard System emulation.
> + *
> + * Copyright (c) 2019 Andreas Konopik <andreas.konopik@efs-auto.de>
> + * Copyright (c) 2019 David Brenken <david.brenken@efs-auto.de>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "hw/qdev-properties.h"
> +#include "cpu.h"
> +#include "net/net.h"
> +#include "hw/boards.h"
> +#include "hw/loader.h"
> +#include "exec/address-spaces.h"
> +#include "elf.h"
> +#include "hw/tricore/tricore.h"
> +#include "qemu/error-report.h"
> +
> +/*
> + * The TriCore processor architecture defines their respective on-chip memory
> + * layout. Therefore, in contrast to other common architectures, the QEMU
> + * TriCore machine and cpu are closely coupled.
> + *
> + * Memory maps are aligned with the TC27x D-Step Microcontroller layout.
> + */
> +
> +#define TC27XD_MEMMAP_DSPR2        0x50000000
> +#define TC27XD_MEMMAP_DCACHE2      0x5001E000
> +#define TC27XD_MEMMAP_DTAG2        0x500C0000
> +#define TC27XD_MEMMAP_PSPR2        0x50100000
> +#define TC27XD_MEMMAP_PCACHE2      0x50108000
> +#define TC27XD_MEMMAP_PTAG2        0x501C0000
> +#define TC27XD_MEMMAP_DSPR1        0x60000000
> +#define TC27XD_MEMMAP_DCACHE1      0x6001E000
> +#define TC27XD_MEMMAP_DTAG1        0x600C0000
> +#define TC27XD_MEMMAP_PSPR1        0x60100000
> +#define TC27XD_MEMMAP_PCACHE1      0x60108000
> +#define TC27XD_MEMMAP_PTAG1        0x601C0000
> +#define TC27XD_MEMMAP_DSPR0        0x70000000
> +#define TC27XD_MEMMAP_PSPR0        0x70100000
> +#define TC27XD_MEMMAP_PCACHE0      0x70106000
> +#define TC27XD_MEMMAP_PTAG0        0x701C0000
> +#define TC27XD_MEMMAP_PFLASH0_C    0x80000000
> +#define TC27XD_MEMMAP_PFLASH1_C    0x80200000
> +#define TC27XD_MEMMAP_OLDA_C       0x8FE70000
> +#define TC27XD_MEMMAP_BROM_C       0x8FFF8000
> +#define TC27XD_MEMMAP_LMURAM_C     0x90000000
> +#define TC27XD_MEMMAP_EMEM_C       0x9F000000
> +#define TC27XD_MEMMAP_PFLASH0_U    0xA0000000
> +#define TC27XD_MEMMAP_PFLASH1_U    0xA0200000
> +#define TC27XD_MEMMAP_DFLASH0      0xAF000000
> +#define TC27XD_MEMMAP_DFLASH1      0xAF110000
> +#define TC27XD_MEMMAP_OLDA_U       0xAFE70000
> +#define TC27XD_MEMMAP_BROM_U       0xAFFF8000
> +#define TC27XD_MEMMAP_LMURAM_U     0xB0000000
> +#define TC27XD_MEMMAP_EMEM_U       0xBF000000
> +#define TC27XD_MEMMAP_PSPRX        0xC0000000
> +#define TC27XD_MEMMAP_DSPRX        0xD0000000
> +
> +static struct tricore_boot_info tc27xd_db_binfo;
> +
> +static void tricore_load_kernel(CPUTriCoreState *env)
> +{
> +    uint64_t entry;
> +    long kernel_size;
> +
> +    kernel_size = load_elf(tc27xd_db_binfo.kernel_filename, NULL,
> +                           NULL, NULL, &entry, NULL,
> +                           NULL, NULL, 0,
> +                           EM_TRICORE, 1, 0);
> +    if (kernel_size <= 0) {
> +        error_report("no kernel file '%s'",
> +                tc27xd_db_binfo.kernel_filename);

What kernel are you using? Do you have one we can use to try this board?

> +        exit(1);
> +    }
> +    env->PC = entry;
> +
> +}
> +
> +/*
> + * Initialize the auxiliary ROM region @mr and map it into
> + * the memory map at @base.
> + */
> +static void make_rom(MemoryRegion *mr, const char *name,
> +                     hwaddr base, hwaddr size)
> +{
> +    memory_region_init_rom(mr, NULL, name, size, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), base, mr);
> +}
> +
> +/*
> + * Initialize the auxiliary RAM region @mr and map it into
> + * the memory map at @base.
> + */
> +static void make_ram(MemoryRegion *mr, const char *name,
> +                     hwaddr base, hwaddr size)
> +{
> +    memory_region_init_ram(mr, NULL, name, size, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), base, mr);
> +}
> +
> +/*
> + * Create an alias of an entire original MemoryRegion @orig
> + * located at @base in the memory map.
> + */
> +static void make_alias(MemoryRegion *mr, const char *name,
> +                           MemoryRegion *orig, hwaddr base)
> +{
> +    memory_region_init_alias(mr, NULL, name, orig, 0,
> +                             memory_region_size(orig));
> +    memory_region_add_subregion(get_system_memory(), base, mr);
> +}
> +
> +static void tc27xd_memory_maps_init(void)
> +{

Nitpicking, I'd rather use a SoC structure, ...

> +    MemoryRegion *dspr0 = g_new(MemoryRegion, 1);
> +    MemoryRegion *dspr1 = g_new(MemoryRegion, 1);
> +    MemoryRegion *dspr2 = g_new(MemoryRegion, 1);
> +    MemoryRegion *dsprX = g_new(MemoryRegion, 1);
> +    MemoryRegion *pspr0 = g_new(MemoryRegion, 1);
> +    MemoryRegion *pspr1 = g_new(MemoryRegion, 1);
> +    MemoryRegion *pspr2 = g_new(MemoryRegion, 1);
> +    MemoryRegion *psprX = g_new(MemoryRegion, 1);

... holding 3 CPU structure regions + the default alias...

> +
> +    MemoryRegion *pflash0_c = g_new(MemoryRegion, 1);
> +    MemoryRegion *pflash1_c = g_new(MemoryRegion, 1);
> +    MemoryRegion *pflash0_u = g_new(MemoryRegion, 1);
> +    MemoryRegion *pflash1_u = g_new(MemoryRegion, 1);
> +    MemoryRegion *dflash0 = g_new(MemoryRegion, 1);
> +    MemoryRegion *dflash1 = g_new(MemoryRegion, 1);
> +    MemoryRegion *olda_c = g_new(MemoryRegion, 1);
> +    MemoryRegion *olda_u = g_new(MemoryRegion, 1);	
> +    MemoryRegion *brom_c = g_new(MemoryRegion, 1);
> +    MemoryRegion *brom_u = g_new(MemoryRegion, 1);

... and one structure holding the flash regions.

> +    MemoryRegion *lmuram_c = g_new(MemoryRegion, 1);
> +    MemoryRegion *lmuram_u = g_new(MemoryRegion, 1);
> +    MemoryRegion *emem_c = g_new(MemoryRegion, 1);
> +    MemoryRegion *emem_u = g_new(MemoryRegion, 1);
> +
> +    MemoryRegion *pcache0 = g_new(MemoryRegion, 1);
> +    MemoryRegion *ptag0 = g_new(MemoryRegion, 1);
> +
> +    MemoryRegion *dcache1 = g_new(MemoryRegion, 1);
> +    MemoryRegion *dtag1 = g_new(MemoryRegion, 1);
> +    MemoryRegion *pcache1 = g_new(MemoryRegion, 1);
> +    MemoryRegion *ptag1 = g_new(MemoryRegion, 1);
> +
> +    MemoryRegion *dcache2 = g_new(MemoryRegion, 1);
> +    MemoryRegion *dtag2 = g_new(MemoryRegion, 1);
> +    MemoryRegion *pcache2 = g_new(MemoryRegion, 1);
> +    MemoryRegion *ptag2 = g_new(MemoryRegion, 1);
> +
> +    make_ram(dspr2, "CPU2.DSPR", TC27XD_MEMMAP_DSPR2, 120 * KiB);
> +    make_ram(pspr2, "CPU2.PSPR", TC27XD_MEMMAP_PSPR2,  32 * KiB);
> +    make_ram(dspr1, "CPU1.DSPR", TC27XD_MEMMAP_DSPR1, 120 * KiB);
> +    make_ram(pspr1, "CPU1.PSPR", TC27XD_MEMMAP_PSPR1,  32 * KiB);
> +    make_ram(dspr0, "CPU0.DSPR", TC27XD_MEMMAP_DSPR0, 112 * KiB);
> +    make_ram(pspr0, "CPU0.PSPR", TC27XD_MEMMAP_PSPR0,  24 * KiB);
> +
> +    /*
> +     * TriCore QEMU executes CPU0 only, thus it is sufficient to map
> +     * LOCAL.PSPR/LOCAL.DSPR exclusively onto PSPR0/DSPR0.
> +     */
> +    make_alias(psprX, "LOCAL.PSPR", pspr0,
> +            TC27XD_MEMMAP_PSPRX);
> +    make_alias(dsprX, "LOCAL.DSPR", dspr0,
> +            TC27XD_MEMMAP_DSPRX);
> +
> +    make_ram(pflash0_c, "PF0",    TC27XD_MEMMAP_PFLASH0_C,  2 * MiB);
> +    make_ram(pflash1_c, "PF1",    TC27XD_MEMMAP_PFLASH1_C,  2 * MiB);
> +    make_ram(dflash0,   "DF0",    TC27XD_MEMMAP_DFLASH0,   1 * MiB + 16 * KiB);
> +    make_ram(dflash1,   "DF1",    TC27XD_MEMMAP_DFLASH1,   64 * KiB);
> +    make_ram(olda_c,    "OLDA",   TC27XD_MEMMAP_OLDA_C,    32 * KiB);
> +    make_rom(brom_c,    "BROM",   TC27XD_MEMMAP_BROM_C,    32 * KiB);
> +    make_ram(lmuram_c,  "LMURAM", TC27XD_MEMMAP_LMURAM_C,  32 * KiB);
> +    make_ram(emem_c,    "EMEM",   TC27XD_MEMMAP_EMEM_C,     1 * MiB);
> +
> +    make_alias(pflash0_u, "PF0.U",    pflash0_c, TC27XD_MEMMAP_PFLASH0_U);
> +    make_alias(pflash1_u, "PF1.U",    pflash1_c, TC27XD_MEMMAP_PFLASH1_U);
> +    make_alias(olda_u,    "OLDA.U",   olda_c,    TC27XD_MEMMAP_OLDA_U);
> +    make_alias(brom_u,    "BROM.U",   brom_c,    TC27XD_MEMMAP_BROM_U);
> +    make_alias(lmuram_u,  "LMURAM.U", lmuram_c,  TC27XD_MEMMAP_LMURAM_U);
> +    make_alias(emem_u,    "EMEM.U",   emem_c,    TC27XD_MEMMAP_EMEM_U);
> +
> +    /* TODO: Control Cache mapping with Memory Test Unit (MTU) */
> +    make_ram(dcache2, "CPU2.DCACHE", TC27XD_MEMMAP_DCACHE2,  8 * KiB);
> +    make_ram(dtag2,   "CPU2.DTAG",   TC27XD_MEMMAP_DTAG2,       2560);
> +    make_ram(pcache2, "CPU2.PCACHE", TC27XD_MEMMAP_PCACHE2, 16 * KiB);
> +    make_ram(ptag2,   "CPU2.PTAG",   TC27XD_MEMMAP_PTAG2,       6144);
> +
> +    make_ram(dcache1, "CPU1.DCACHE", TC27XD_MEMMAP_DCACHE1,  8 * KiB);
> +    make_ram(dtag1,   "CPU1.DTAG",   TC27XD_MEMMAP_DTAG1,       2560);
> +    make_ram(pcache1, "CPU1.PCACHE", TC27XD_MEMMAP_PCACHE1, 16 * KiB);
> +    make_ram(ptag1,   "CPU1.PTAG",   TC27XD_MEMMAP_PTAG1,       6144);
> +
> +    make_ram(pcache0, "CPU0.PCACHE", TC27XD_MEMMAP_PCACHE0,  8 * KiB);
> +    make_ram(ptag0,   "CPU0.PTAG",   TC27XD_MEMMAP_PTAG0,       2560);
> +}
> +
> +static void tc27xd_tb_init(MachineState *machine)
> +{
> +    TriCoreCPU *cpu;
> +    CPUTriCoreState *env;
> +
> +    cpu = TRICORE_CPU(cpu_create(machine->cpu_type));
> +    env = &cpu->env;
> +
> +    tc27xd_memory_maps_init();
> +
> +    tc27xd_db_binfo.ram_size = machine->ram_size;
> +    tc27xd_db_binfo.kernel_filename = machine->kernel_filename;
> +
> +    if (machine->kernel_filename) {
> +        tricore_load_kernel(env);

        } else {
           // error message
           exit(1);

> +    }
> +}
> +
> +static void tc27xd_tb_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "Infineon AURIX TC277 D-Step TriBoard";
> +    mc->init = tc27xd_tb_init;
> +    mc->is_default = 0;
> +    mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc27x");
> +}
> +DEFINE_MACHINE("AURIX_TriBoard_TC277D", tc27xd_tb_machine_init)
> 


