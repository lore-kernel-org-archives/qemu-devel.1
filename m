Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725A9C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA282464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkcPrGAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA282464D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icw4M-0003wE-Dw
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1icw2x-0003I9-Np
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1icw2w-0004Yb-4S
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:40:15 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1icw2v-0004U8-TR
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:40:14 -0500
Received: by mail-oi1-x243.google.com with SMTP id x195so3702318oix.4
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 10:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wpET3lzcKB22iPNVtFlsEzKa/4+3mu1B+c0PsjFBF2Y=;
 b=PkcPrGAhkb+DaTfiZwjROMKVihOXHHwj2emaoP151g9t7Wbca8W9qESxPnIT06fNuz
 0adVpiSY/67REJmRnpeC/Aq0q01tc3rnJTJGy7Ehj2EyCqMYR5y3PRWxUEXoYniJvTOy
 Z9cyE//zazj9I7urZ0hRZ6EGn17+jaV9EZwCPrrEAu6F2mmDvYvVfSwHWw0eX/5cIJl9
 YSTJGvBvLc9tTgszfGuvfdfE2Lx7lRE6LlTuTXev4GXDuH8tijs/LNvko8dATrJpBGVD
 2Zig4WdzNVEyiaV0/hxhJmx0wNrqLqhySjay7P9wyxBkL8gUKSkM4dd9VJqJoNFcmUKL
 WNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wpET3lzcKB22iPNVtFlsEzKa/4+3mu1B+c0PsjFBF2Y=;
 b=nA9j2lb9ENeTR/ZY1sGS2HwYHcchpPObO+TQEkvTpQYF7wh61wcNDf8oC/a8ePNEzh
 YjhQnKRVDodaYonN3FLw1qTIoCkkaXcZTAzWzhSqlnlLlRQcrlI8ItGOh+GbKqOaNjiz
 woxn08+JiogFoJhDWOgO4o8sxe/Bhk2yzWEPfGH+5SNgnU45BUsB3VjWDARoTzfqMy5L
 Murl12ZWsoXkCuhNuxV1TUskNKsWEF0hn7OtiicAhpeVNyPJHSfLZGwV9Z8cjbIWnH7Z
 b8hYh/4ecZeurmOmq6BQ1U4gKQiNrNROdBxvAkzJMRo5Fblzr74wmjuFSXTG/y1JuRKs
 oqXg==
X-Gm-Message-State: APjAAAXWSwPcol2vU7Ber83htmDYBpt/yQ3yBAdRw/NjB3LNKkNY89xE
 +GfiZv0usNzCZ//kYkIizSqZFOgeBs5ahE8kTLwoyw==
X-Google-Smtp-Source: APXvYqz3MJp/sBrmbbRiZjO/ftHK7vNqXHLQbOsRURa/k0qxR5qT0IrWHea8c6wS0/ELwPU31n87vbWy4rBMSYT717o=
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr8715903oih.163.1575571210836; 
 Thu, 05 Dec 2019 10:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-21-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2019 18:40:00 +0000
Message-ID: <CAFEAcA93AX9nikuqq9M1jZOxv1a7QJZpiocHnn=n-gSbsGBS7w@mail.gmail.com>
Subject: Re: [PATCH v5 20/22] target/arm: Create tagged ram when MTE is enabled
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 14:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5: Assign cs->num_ases to the final value first.
>     Downgrade to ID_AA64PFR1.MTE=1 if tag memory is not available.
> v6: Add secure tag memory for EL3.
> ---
>  target/arm/cpu.h |  6 ++++++
>  hw/arm/virt.c    | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu.c | 53 ++++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 110 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 93a362708b..faca43ea78 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -765,6 +765,10 @@ struct ARMCPU {
>      /* MemoryRegion to use for secure physical accesses */
>      MemoryRegion *secure_memory;
>
> +    /* MemoryRegion to use for allocation tag accesses */
> +    MemoryRegion *tag_memory;
> +    MemoryRegion *secure_tag_memory;
> +
>      /* For v8M, pointer to the IDAU interface provided by board/SoC */
>      Object *idau;
>
> @@ -2956,6 +2960,8 @@ int cpu_mmu_index(CPUARMState *env, bool ifetch);
>  typedef enum ARMASIdx {
>      ARMASIdx_NS = 0,
>      ARMASIdx_S = 1,
> +    ARMASIdx_TagNS = 2,
> +    ARMASIdx_TagS = 3,
>  } ARMASIdx;
>
>  /* Return the Exception Level targeted by debug exceptions. */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d74538b021..573988ba4d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1330,6 +1330,18 @@ static void create_secure_ram(VirtMachineState *vms,
>      g_free(nodename);
>  }
>
> +static void create_tag_ram(MemoryRegion *tag_sysmem,
> +                           hwaddr base, hwaddr size,
> +                           const char *name)
> +{
> +    MemoryRegion *tagram = g_new(MemoryRegion, 1);
> +
> +    memory_region_init_ram(tagram, NULL, name, size / 32, &error_fatal);
> +    memory_region_add_subregion(tag_sysmem, base / 32, tagram);
> +
> +    /* ??? Do we really need an fdt entry, or is MemTag enabled sufficient.  */

What's this '???' asking about? I would be surprised if the
kernel expected to have any kind of FDT for tag RAM
(with the exception that an implementation that puts tags
in a special part of normal-ram will want that not
to be described in the fdt as ram usable by the kernel), but
we should ask the kernel folks.

> +}
> +
>  static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
>  {
>      const VirtMachineState *board = container_of(binfo, VirtMachineState,
> @@ -1485,6 +1497,8 @@ static void machvirt_init(MachineState *machine)
>      qemu_irq pic[NUM_IRQS];
>      MemoryRegion *sysmem = get_system_memory();
>      MemoryRegion *secure_sysmem = NULL;
> +    MemoryRegion *tag_sysmem = NULL;
> +    MemoryRegion *secure_tag_sysmem = NULL;
>      int n, virt_max_cpus;
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>      bool firmware_loaded;
> @@ -1652,6 +1666,35 @@ static void machvirt_init(MachineState *machine)
>                                       "secure-memory", &error_abort);
>          }
>
> +        /*
> +         * The cpu adds the property iff MemTag is supported.

We've had confusion before from non-native-speakers and
non-maths-geeks about 'iff' in comments; better to expand to
'if and only if'.

> +         * If it is, we must allocate the ram to back that up.
> +         */
> +        if (object_property_find(cpuobj, "tag-memory", NULL)) {
> +            if (!tag_sysmem) {
> +                tag_sysmem = g_new(MemoryRegion, 1);
> +                memory_region_init(tag_sysmem, OBJECT(machine),
> +                                   "tag-memory", UINT64_MAX / 32);
> +
> +                if (vms->secure) {
> +                    secure_tag_sysmem = g_new(MemoryRegion, 1);
> +                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
> +                                       "secure-tag-memory", UINT64_MAX / 32);
> +
> +                    /* As with ram, secure-tag takes precedence over tag.  */
> +                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
> +                                                        tag_sysmem, -1);
> +                }
> +            }

Are there really separate S and NS tag RAMs?

thanks
-- PMM

