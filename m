Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F65FC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FDA20850
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FDA20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51054 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hblKE-0007bE-6G
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 08:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hblHG-0005hG-TI
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hblHF-0005Wx-Lp
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:25:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38259)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hblHF-0005V0-Ff
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:25:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so2133153wmj.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 05:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xNGiJfOXo0PVTmUfInZBcYfyLuMJcVBrbhkjrKCfte8=;
 b=rL18ye15lEU5NAHKN+06XbIaCF+yFaOnig7KUDnGiyKnTezyCC58H5sWNv6rmt/yS8
 ylrp7hrlSR4O/VCZnk6+GzIWRksbEs7o7QndUlA/ORWC2PdpY/J8ZPmMxb6iO9uCN7Ea
 9zcaX11RI4ayr/knZaN5zikKnqH0sfAm7T9z5HqzHiTmOWKM7idXP8GrJmbJAsbLUoy0
 h5ZxccXFa9NMsEU0XatmpC3Tc5DmwFrQr3enWVnkn7VEjzzhuaYt+bAPTEtgn5r/9gwQ
 4GxK1OHiy1oAExqkV0mp8WriFvFPa2uD9D0dY/bxKhbUZXx/ISNo4YhSfOx4N57ruBsB
 b3hw==
X-Gm-Message-State: APjAAAVA1mB3df27HxTA9k86jntRAS7UGp1FeTO1eokjXsXsGzVphAc/
 csoADJIgO0Zjl+0Jus9ZnJaR4kYei8M=
X-Google-Smtp-Source: APXvYqwsCNi+s4PLKIAL7LzotALybwH3Ghz3zZ/9rQEbvbx8J21kwLu3m0sYI0T5mjB1xH76tTM1uQ==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr7380684wmk.36.1560515151988;
 Fri, 14 Jun 2019 05:25:51 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id x129sm4277512wmg.44.2019.06.14.05.25.51
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 05:25:51 -0700 (PDT)
To: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org
References: <20190614120830.21850-1-palmer@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <13fe08a2-c89c-b015-3799-067e0f04bfd3@redhat.com>
Date: Fri, 14 Jun 2019 14:25:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190614120830.21850-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Fix a memory leak when realizing a
 sifive_e
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 2:08 PM, Palmer Dabbelt wrote:
> Coverity pointed out a memory leak in riscv_sifive_e_soc_realize(),
> where a pair of recently added MemoryRegion instances would not be freed
> if there were errors elsewhere in the function.  The fix here is to
> simply not use dynamic allocation for these instances: there's always
> one of each in SiFiveESoCState, so instead we just include them within
> the struct.
> 
> Thanks to Peter for pointing out the bug and suggesting the fix!

a.k.a. Suggested-by: Peter Maydell <peter.maydell@linaro.org>

Maybe the thanks can go below the '---' tag, so it doesn't stay in the
git history.

> 
> Fixes: 30efbf330a45 ("SiFive RISC-V GPIO Device")
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/riscv/sifive_e.c         | 12 +++++-------
>  include/hw/riscv/sifive_e.h |  2 ++
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 80ac56fa7d5e..83375afcd1d6 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -158,17 +158,15 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>  
>      SiFiveESoCState *s = RISCV_E_SOC(dev);
>      MemoryRegion *sys_mem = get_system_memory();
> -    MemoryRegion *xip_mem = g_new(MemoryRegion, 1);
> -    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>  
>      object_property_set_bool(OBJECT(&s->cpus), true, "realized",
>                              &error_abort);
>  
>      /* Mask ROM */
> -    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.e.mrom",
> +    memory_region_init_rom(&s->mask_rom, NULL, "riscv.sifive.e.mrom",
>          memmap[SIFIVE_E_MROM].size, &error_fatal);
>      memory_region_add_subregion(sys_mem,
> -        memmap[SIFIVE_E_MROM].base, mask_rom);
> +        memmap[SIFIVE_E_MROM].base, &s->mask_rom);
>  
>      /* MMIO */
>      s->plic = sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
> @@ -228,10 +226,10 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>          memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
>  
>      /* Flash memory */
> -    memory_region_init_ram(xip_mem, NULL, "riscv.sifive.e.xip",
> +    memory_region_init_ram(&s->xip_mem, NULL, "riscv.sifive.e.xip",
>          memmap[SIFIVE_E_XIP].size, &error_fatal);
> -    memory_region_set_readonly(xip_mem, true);
> -    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base, xip_mem);
> +    memory_region_set_readonly(&s->xip_mem, true);
> +    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base, &s->xip_mem);
>  }
>  
>  static void riscv_sifive_e_machine_init(MachineClass *mc)
> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> index 3b14eb74621f..d175b24cb209 100644
> --- a/include/hw/riscv/sifive_e.h
> +++ b/include/hw/riscv/sifive_e.h
> @@ -33,6 +33,8 @@ typedef struct SiFiveESoCState {
>      RISCVHartArrayState cpus;
>      DeviceState *plic;
>      SIFIVEGPIOState gpio;
> +    MemoryRegion xip_mem;
> +    MemoryRegion mask_rom;
>  } SiFiveESoCState;
>  
>  typedef struct SiFiveEState {
> 

