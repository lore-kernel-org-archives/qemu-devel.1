Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66966C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 11:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F973206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 11:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU4xtcHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F973206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7GXJ-0000Vx-EN
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 07:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7GWd-0008Tl-1Q; Sun, 16 Aug 2020 07:08:31 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7GWb-00011a-Ip; Sun, 16 Aug 2020 07:08:30 -0400
Received: by mail-wm1-x342.google.com with SMTP id 3so11612773wmi.1;
 Sun, 16 Aug 2020 04:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5GvLVLGqpYTSLQIGcRzC/iIT+OaUSzG/PtZakdijJE8=;
 b=iU4xtcHF8+zAZx2jONwyL/bmwQ672lFWTKYC37E4xVORu+qDIZ3p5a5DGzZignphlY
 JiOu/BOX/OcxB0TBfSJU/jkdQH5mtZBMjOGE7PHIwDUAk5peOh6+h/kzsrNKIt91o1Y5
 /Vl1G4fyknjzn/cG9RxE90ccYuCs1enYen9r4wiCGLy8GUTN8SXRW8uTz1y4KHEK8cH+
 urecgX7tJWBpEWTMD9tgGTwar6ApEelBD0kxEWkExJlzzbLJ+NcW8XcpzURGp6Hjg8QB
 QwyWgElBQIenKzg7gqKM53DIrb9RE7pWeyXuQx5XKJZfN33kwG6PhH5n9keDJF5ZHupf
 L1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5GvLVLGqpYTSLQIGcRzC/iIT+OaUSzG/PtZakdijJE8=;
 b=OjFaFTfuBDvOCo4dtVhaZ6i15to1mL8MQziLtLj4TFjAQulA2mEU2cSJVueZI7hmQ8
 73JtA6vxRq3079xOU9HCRn7bBfiCDymaUkac1w6bOrJVsJeMcC4gzUDMlLx8xIN7xFhZ
 9TnbPQbhLdwauZIWrV+TGBfrmNFIlZNv1OhriofWarbvIsOOoZSIwQHMoDQvPmS5zjRe
 RluGLCrCxeBjh94/WCc5JR33dl0is6IZB94nImCFdxz5l++VP8dmByQUwHgUgO9r2TSs
 a97CO4zT4I5+djvxsViZ/byV6y5TYjtOyLPOJhHSjdGkqpdN2NPaZpHwfsQd+IaFdeJy
 Eu5Q==
X-Gm-Message-State: AOAM5301t8gvva4lNxQa/kVZZ7PqYQd73/8EW9C6/EnbKaukhr3U9jnW
 UjRLU4g71u0ybiRt5NY33Vo=
X-Google-Smtp-Source: ABdhPJzLF8CoodQ+T7G7yRm74QmJWf17z+AXnBahKXkvl+cKYQ3a1eNnQCvIL+rKKEbMxzEXktIQVA==
X-Received: by 2002:a1c:e244:: with SMTP id z65mr10277155wmg.34.1597576107546; 
 Sun, 16 Aug 2020 04:08:27 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 128sm25655841wmz.43.2020.08.16.04.08.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2020 04:08:26 -0700 (PDT)
Subject: Re: [PATCH 13/18] hw/riscv: microchip_pfsoc: Connect a DMA controller
To: Bin Meng <bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-14-git-send-email-bmeng.cn@gmail.com>
 <e96742b4-3d58-e9b7-def9-3fb1fb89f750@amsat.org>
 <CAEUhbmUx_bpR_aKgJN-VTp-vJyy_YwnwLogoOxacPzOWj3_x2g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8539f87c-02e3-b393-af27-c23c6117ff18@amsat.org>
Date: Sun, 16 Aug 2020 13:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmUx_bpR_aKgJN-VTp-vJyy_YwnwLogoOxacPzOWj3_x2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/20 10:57 AM, Bin Meng wrote:
> Hi Philippe,
> 
> On Sat, Aug 15, 2020 at 5:00 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 8/14/20 6:40 PM, Bin Meng wrote:
>>> From: Bin Meng <bin.meng@windriver.com>
>>>
>>> Connect a DMA controller to Microchip PolarFire SoC. Note interrupt
>>> has not been connected due to missing information in the manual how
>>> interrupts are routed to PLIC.
>>>
>>> On the Icicle Kit board, the HSS firmware utilizes the on-chip DMA
>>> controller to move the 2nd stage bootloader in the system memory.
>>>
>>> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>>> ---
>>>
>>>  hw/riscv/Kconfig                   |  1 +
>>>  hw/riscv/microchip_pfsoc.c         | 10 ++++++++++
>>>  include/hw/riscv/microchip_pfsoc.h |  3 +++
>>>  3 files changed, 14 insertions(+)
>>>
>>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>>> index 7412db9..9323701 100644
>>> --- a/hw/riscv/Kconfig
>>> +++ b/hw/riscv/Kconfig
>>> @@ -55,4 +55,5 @@ config MICROCHIP_PFSOC
>>>      select SIFIVE
>>>      select UNIMP
>>>      select MCHP_PFSOC_MMUART
>>> +    select MCHP_PFSOC_DMA
>>>      select CADENCE_SDHCI
>>> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
>>> index 7c09078..1c67cbc 100644
>>> --- a/hw/riscv/microchip_pfsoc.c
>>> +++ b/hw/riscv/microchip_pfsoc.c
>>> @@ -13,6 +13,7 @@
>>>   * 2) eNVM (Embedded Non-Volatile Memory)
>>>   * 3) MMUARTs (Multi-Mode UART)
>>>   * 4) Cadence eMMC/SDHC controller and an SD card connected to it
>>> + * 5) DMA (Direct Memory Access Controller)
>>>   *
>>>   * This board currently generates devicetree dynamically that indicates at least
>>>   * two harts and up to five harts.
>>> @@ -71,6 +72,7 @@ static const struct MemmapEntry {
>>>      [MICROCHIP_PFSOC_BUSERR_UNIT4] =    {  0x1704000,     0x1000 },
>>>      [MICROCHIP_PFSOC_CLINT] =           {  0x2000000,    0x10000 },
>>>      [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,     0x1000 },
>>> +    [MICROCHIP_PFSOC_DMA] =             {  0x3000000,   0x100000 },
>>>      [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,  0x2000000 },
>>>      [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,  0x4000000 },
>>>      [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
>>> @@ -114,6 +116,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>>>                           TYPE_RISCV_CPU_SIFIVE_U54);
>>>      qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", RESET_VECTOR);
>>>
>>> +    object_initialize_child(obj, "dma-controller", &s->dma,
>>> +                            TYPE_MCHP_PFSOC_DMA);
>>> +
>>>      object_initialize_child(obj, "sd-controller", &s->sdhci,
>>>                              TYPE_CADENCE_SDHCI);
>>
>> I haven't looked at the chip specs, but maybe you can add the SD
>> controller after the DMA controller so so you can directly link
>> a DMA address space to it.
>>
> 
> I am not sure I understand what you meant about adding the SD
> controller after the DMA controller. The Cadence SD controller has its
> own built-in DMA and does not depend on this DMA controller.

Ah OK. What I'm concerned about is the SD controller do its DMA
access in a proper DMA address space.

> 
> Regards,
> Bin
> 

