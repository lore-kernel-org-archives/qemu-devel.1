Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCE2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 08:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A0F2078C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 08:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="Q/p3GvBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A0F2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiwQC-0003YQ-3l
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 04:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jiwPN-00037V-OT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 04:48:30 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18]:60678)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jiwPL-00080l-KQ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 04:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MPyekeLyem22xMtRGl6J/9gDXPlbWT9twoB+W6ppBCI=; b=Q/p3GvBxmOYQKsx4mLGHylV6O
 l2+9RNUNiPsaliqxo0IwIkpRuhx6eQFRQLr/s35buGzB0nmBPA468HjEKSvc162zkgjF5Rm4CCneB
 fiXiDQyLDnnQmmo5Jo6A6i3kggL9YVni5577gthkSUVxvIz6vOWlPP+eKYpHaPjZ0bgjg=;
Date: Wed, 10 Jun 2020 10:48:18 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: David Brenken <david.brenken@efs-auto.org>
Subject: Re: [PATCH v2 1/1] tricore: added triboard with tc27x_soc
Message-ID: <20200610084818.yrzxqm6466w2wpiz@schnipp-desktop>
References: <20200609152553.4376-1-david.brenken@efs-auto.org>
 <20200609152553.4376-2-david.brenken@efs-auto.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609152553.4376-2-david.brenken@efs-auto.org>
X-IMT-Spam-Score: 0.0 ()
X-Sophos-SenderHistory: ip=2a02:908:2214:e5a0:d6f6:93ca:dcc:aa54, fs=147495,
 da=79387964, mc=5, sc=0, hc=5, sp=0, fso=147495, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.10.83917, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.10.5740001
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

thanks for the patch. In general this looks good to me. However, a have a few
nitpicks.

On Tue, Jun 09, 2020 at 05:25:53PM +0200, David Brenken wrote:
> From: Andreas Konopik <andreas.konopik@efs-auto.de>
> +static const int tc27x_soc_irqmap[] = {
> +};

Since this is empty, it's best to just remove it.

> +
> +static const hwaddr tc27x_soc_memmap[] = {
> +    [TC27XD_DSPR2]     = 0x50000000,
> +    [TC27XD_DCACHE2]   = 0x5001E000,
> +    [TC27XD_DTAG2]     = 0x500C0000,
> +    [TC27XD_PSPR2]     = 0x50100000,
> +    [TC27XD_PCACHE2]   = 0x50108000,
> +    [TC27XD_PTAG2]     = 0x501C0000,
> +    [TC27XD_DSPR1]     = 0x60000000,
> +    [TC27XD_DCACHE1]   = 0x6001E000,
> +    [TC27XD_DTAG1]     = 0x600C0000,
> +    [TC27XD_PSPR1]     = 0x60100000,
> +    [TC27XD_PCACHE1]   = 0x60108000,
> +    [TC27XD_PTAG1]     = 0x601C0000,
> +    [TC27XD_DSPR0]     = 0x70000000,
> +    [TC27XD_PSPR0]     = 0x70100000,
> +    [TC27XD_PCACHE0]   = 0x70106000,
> +    [TC27XD_PTAG0]     = 0x701C0000,
> +    [TC27XD_PFLASH0_C] = 0x80000000,
> +    [TC27XD_PFLASH1_C] = 0x80200000,
> +    [TC27XD_OLDA_C]    = 0x8FE70000,
> +    [TC27XD_BROM_C]    = 0x8FFF8000,
> +    [TC27XD_LMURAM_C]  = 0x90000000,
> +    [TC27XD_EMEM_C]    = 0x9F000000,
> +    [TC27XD_PFLASH0_U] = 0xA0000000,
> +    [TC27XD_PFLASH1_U] = 0xA0200000,
> +    [TC27XD_DFLASH0]   = 0xAF000000,
> +    [TC27XD_DFLASH1]   = 0xAF110000,
> +    [TC27XD_OLDA_U]    = 0xAFE70000,
> +    [TC27XD_BROM_U]    = 0xAFFF8000,
> +    [TC27XD_LMURAM_U]  = 0xB0000000,
> +    [TC27XD_EMEM_U]    = 0xBF000000,
> +    [TC27XD_PSPRX]     = 0xC0000000,
> +    [TC27XD_DSPRX]     = 0xD0000000,
> +};

Can we add the sizes here as well? That make it much easier to read. See
hw/riscv/sifive_e.c

Also what do the _U and _C suffixes mean? I could not find them in the user
manual [1].

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

These seem like very common idioms. It might be worth while to make this a
generic QEMU API. However this is out of scope for this patchset.

> +    /*
> +     * TriCore QEMU executes CPU0 only, thus it is sufficient to map
> +     * LOCAL.PSPR/LOCAL.DSPR exclusively onto PSPR0/DSPR0.
> +     */
> +    make_alias(&s->psprX, "LOCAL.PSPR", &s->cpu0mem.pspr,
> +            sc->memmap[TC27XD_PSPRX]);
> +    make_alias(&s->dsprX, "LOCAL.DSPR", &s->cpu0mem.dspr,
> +            sc->memmap[TC27XD_DSPRX]);
  
These aliases point to reserved memory in the user manual [1].

> +static void tc27x_soc_init(Object *obj)
> +{
> +    TC27XSoCState *s = TC27X_SOC(obj);
> +    TC27XSoCClass *sc = TC27X_SOC_GET_CLASS(s);
> +
> +    sysbus_init_child_obj(OBJECT(s), "tc27x", OBJECT(&s->cpu), sizeof(s->cpu),
> +                        sc->cpu_type);

Unnecessary cast. Just use sysbus_init_child_obj(obj,...)

> +static void tricore_load_kernel(const char *kernel_filename)
> +{
> +    uint64_t entry;
> +    long kernel_size;
> +    TriCoreCPU *cpu;
> +    CPUTriCoreState *env;
> +
> +    kernel_size = load_elf(kernel_filename, NULL,
> +                           NULL, NULL, &entry, NULL,
> +                           NULL, NULL, 0,
> +                           EM_TRICORE, 1, 0);
> +    if (kernel_size <= 0) {
> +        error_report("no kernel file '%s'", kernel_filename);
> +        exit(1);
> +    }
> +    cpu = TRICORE_CPU(first_cpu);
> +    env = &cpu->env;
> +    env->PC = entry;
> +}

Just a note for the future. This seems like a function that ought to be
generalized for all TriCore boards.

Cheers,
Bastian

[1] https://hitex.co.uk/fileadmin/uk-files/downloads/ShieldBuddy/tc27xD_um_v2.2.pdf 

