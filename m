Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76072C31E49
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 08:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDB821473
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 08:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDB821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcQKq-0004Hk-Oe
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 04:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56745)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hcQJx-0003op-7G
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 04:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hcQJw-0001b7-1f
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 04:15:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hcQJv-0001aO-Qz
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 04:15:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so6036910wml.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 01:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=MAPTb1gHYmhUvkCjrnUgb2AR28xywHkPNE5DYPJmeQ0=;
 b=ApqJF18RQbsYdBH0wjrDE6Z+VSOkPDVBUjLzCvmONMnLK7GRYuRdTO/9DZtDivCNYL
 W855PulSFsvwhCYCvC6FA2twksxV2uOAnY6a3nTNvkkn8mR8dCZtIqHfIgxxJ1vzSn/V
 w22VwmDABUTjAC1mH9vhsJ0naUGmSF+K4VTnNDx31/3LaCo7G1rqdi71/J0lK2x0L388
 WJ/XgQvV7xkro/yfXA9qhKNMF/RDibYXKhvMLcrdo0hFMkiDh6Yy4TlhJR6FXtJoxzPz
 Upq9YU6Yc9szmrA6JVfsRghh7ONPGQLu3iDn5B38xwyYvD24ho3Sx7xEij4J1NCeDMv6
 SDbw==
X-Gm-Message-State: APjAAAU48LNzkM/2KWtXw7Mp3lp6hPecmDERXql9VwJ7WpkK+RsbtCBN
 8r5gxGixZQi1OEfWU1tLQePGMg==
X-Google-Smtp-Source: APXvYqxN9ew032ceUIPVjHSXKS4SRDC3ELzEoaozxSbZrexYbRdTVyCQE8cHHEmYjsh0D79d67TKSQ==
X-Received: by 2002:a1c:44d7:: with SMTP id
 r206mr14702954wma.164.1560672921844; 
 Sun, 16 Jun 2019 01:15:21 -0700 (PDT)
Received: from localhost ([83.137.6.189])
 by smtp.gmail.com with ESMTPSA id d3sm21324189wrf.87.2019.06.16.01.15.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 01:15:21 -0700 (PDT)
Date: Sun, 16 Jun 2019 01:15:21 -0700 (PDT)
X-Google-Original-Date: Sun, 16 Jun 2019 01:07:34 PDT (-0700)
In-Reply-To: <13fe08a2-c89c-b015-3799-067e0f04bfd3@redhat.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: philmd@redhat.com
Message-ID: <mhng-fb0f4eaf-5e38-4e66-958a-9942273b48c3@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 05:25:50 PDT (-0700), philmd@redhat.com wrote:
> On 6/14/19 2:08 PM, Palmer Dabbelt wrote:
>> Coverity pointed out a memory leak in riscv_sifive_e_soc_realize(),
>> where a pair of recently added MemoryRegion instances would not be freed
>> if there were errors elsewhere in the function.  The fix here is to
>> simply not use dynamic allocation for these instances: there's always
>> one of each in SiFiveESoCState, so instead we just include them within
>> the struct.
>>
>> Thanks to Peter for pointing out the bug and suggesting the fix!
>
> a.k.a. Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>
> Maybe the thanks can go below the '---' tag, so it doesn't stay in the
> git history.

Works for me.

>
>>
>> Fixes: 30efbf330a45 ("SiFive RISC-V GPIO Device")
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks!

>
>> ---
>>  hw/riscv/sifive_e.c         | 12 +++++-------
>>  include/hw/riscv/sifive_e.h |  2 ++
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
>> index 80ac56fa7d5e..83375afcd1d6 100644
>> --- a/hw/riscv/sifive_e.c
>> +++ b/hw/riscv/sifive_e.c
>> @@ -158,17 +158,15 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>>
>>      SiFiveESoCState *s = RISCV_E_SOC(dev);
>>      MemoryRegion *sys_mem = get_system_memory();
>> -    MemoryRegion *xip_mem = g_new(MemoryRegion, 1);
>> -    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>>
>>      object_property_set_bool(OBJECT(&s->cpus), true, "realized",
>>                              &error_abort);
>>
>>      /* Mask ROM */
>> -    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.e.mrom",
>> +    memory_region_init_rom(&s->mask_rom, NULL, "riscv.sifive.e.mrom",
>>          memmap[SIFIVE_E_MROM].size, &error_fatal);
>>      memory_region_add_subregion(sys_mem,
>> -        memmap[SIFIVE_E_MROM].base, mask_rom);
>> +        memmap[SIFIVE_E_MROM].base, &s->mask_rom);
>>
>>      /* MMIO */
>>      s->plic = sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
>> @@ -228,10 +226,10 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>>          memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
>>
>>      /* Flash memory */
>> -    memory_region_init_ram(xip_mem, NULL, "riscv.sifive.e.xip",
>> +    memory_region_init_ram(&s->xip_mem, NULL, "riscv.sifive.e.xip",
>>          memmap[SIFIVE_E_XIP].size, &error_fatal);
>> -    memory_region_set_readonly(xip_mem, true);
>> -    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base, xip_mem);
>> +    memory_region_set_readonly(&s->xip_mem, true);
>> +    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base, &s->xip_mem);
>>  }
>>
>>  static void riscv_sifive_e_machine_init(MachineClass *mc)
>> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
>> index 3b14eb74621f..d175b24cb209 100644
>> --- a/include/hw/riscv/sifive_e.h
>> +++ b/include/hw/riscv/sifive_e.h
>> @@ -33,6 +33,8 @@ typedef struct SiFiveESoCState {
>>      RISCVHartArrayState cpus;
>>      DeviceState *plic;
>>      SIFIVEGPIOState gpio;
>> +    MemoryRegion xip_mem;
>> +    MemoryRegion mask_rom;
>>  } SiFiveESoCState;
>>
>>  typedef struct SiFiveEState {
>>

