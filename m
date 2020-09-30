Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12571C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2D12071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJRS2uzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2D12071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZRr-0005Ty-Jb
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZFR-0006cE-4y; Wed, 30 Sep 2020 06:22:09 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZFP-0006Zw-A7; Wed, 30 Sep 2020 06:22:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id e11so927397wme.0;
 Wed, 30 Sep 2020 03:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ffvdVpz6qk0ca0WBUblQrsJnJG2P8c1t+fIKqaw2HWg=;
 b=IJRS2uzLRxlsrsU1zvHS0srMz8OWFnTeETmroomLVMYRRci+AnaH8k60n50De9ezou
 McKVN40IIOghwmGHuagWXufS4vZdRJnDjJjTnrjWv5w35EoQy1uyMf8/GeG7HiIhy2nE
 9m8eqnxeVqtr43lEmA0qUl60kIKQ0Nv3xs/bQPxtPBEUOeasPt5puATwKYa9hNRQdAEL
 wiORZyIdsfoLp86mk0arOm3CTcSHJaFBO5Tfh7nZWKrFMZrE6DC+JC0fvb12FxTOyz2K
 mGe9th+nhKjk1FCXqXD+IlVlzQc6zVBqN+KsPtRINaqG6OQ4mua7MrROpfvqMkB/GZgn
 dR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ffvdVpz6qk0ca0WBUblQrsJnJG2P8c1t+fIKqaw2HWg=;
 b=nxQNU8PtOYBHDzIAqiebKn6Z7CkQOAJr1EbZIdhRJ9/E86hPTmd4ZSaNEtqPBiGdh4
 147oy0eudg5SS3IIKQz+GjN3FXAvY/oWtx0XtiMQ/SnE7LYt9s8GsITAffTy1sWre60w
 8ZJdC7RxbvsOvmtICyYz4yFLp3+Uhxxzz2vmAsskJaphMwV9XBpiPPQf0Kn+6OxE3kmx
 6EHAWM2F2bukPbbIkxdd+k2+OiJQoXuW+ladcgvVtAK60j5dz8TcwDFnY/VL+uJiena3
 ixqeoD+itgYK1OroxB2mEEAWwEu8APZ4zXdLHMGbBFoz2E+6wa4YWFf7OVSn5rCO9BI2
 ZfrA==
X-Gm-Message-State: AOAM5323GNnzfX4v1/9lyCWQXfdBokxIcH1ftj3pfn7Bg8/Ideeob5Gr
 QBSupDcGhwL3OUzprTnVMQg=
X-Google-Smtp-Source: ABdhPJz2WWiA1YgONKSUxgaldMQ25eB8Xpl1kLYEDTGptk3+Mq7R69MWXgSr6o+CvS+NyVJnPaRaBQ==
X-Received: by 2002:a05:600c:2312:: with SMTP id
 18mr2143116wmo.141.1601461325013; 
 Wed, 30 Sep 2020 03:22:05 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id g12sm2066548wro.89.2020.09.30.03.22.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:22:04 -0700 (PDT)
Subject: Re: [PATCH] hw/rtc/m48t59: Simplify m48t59_init()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20200914102425.1152962-1-f4bug@amsat.org>
 <ff2fd61b-b0ae-97f2-820e-79209e9882eb@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bcd0d490-da5e-6d43-3f4d-38be88565ac3@amsat.org>
Date: Wed, 30 Sep 2020 12:22:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ff2fd61b-b0ae-97f2-820e-79209e9882eb@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 10:35 AM, Mark Cave-Ayland wrote:
> On 14/09/2020 11:24, Philippe Mathieu-Daudé wrote:
> 
>> As the 'io_base' argument of m48t59_init() is unused (set to 0),
>> remove it to simplify.
>> To create a device on the ISA bus, m48t59_init_isa() is the
>> preferred function to use.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/rtc/m48t59.h |  2 +-
>>  hw/ppc/ppc405_boards.c  |  2 +-
>>  hw/rtc/m48t59.c         | 10 ++--------
>>  hw/sparc/sun4m.c        |  2 +-
>>  hw/sparc64/sun4u.c      |  2 +-
>>  5 files changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
>> index 04abedf3b2b..62297ee0db1 100644
>> --- a/include/hw/rtc/m48t59.h
>> +++ b/include/hw/rtc/m48t59.h
>> @@ -50,7 +50,7 @@ struct NvramClass {
>>  Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
>>                         int base_year, int type);
>>  Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
>> -                   uint32_t io_base, uint16_t size, int base_year,
>> +                   uint16_t size, int base_year,
>>                     int type);
>>  
>>  #endif /* HW_M48T59_H */
>> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
>> index 6198ec1035b..93ffee801a3 100644
>> --- a/hw/ppc/ppc405_boards.c
>> +++ b/hw/ppc/ppc405_boards.c
>> @@ -227,7 +227,7 @@ static void ref405ep_init(MachineState *machine)
>>      /* Register FPGA */
>>      ref405ep_fpga_init(sysmem, 0xF0300000);
>>      /* Register NVRAM */
>> -    m48t59_init(NULL, 0xF0000000, 0, 8192, 1968, 8);
>> +    m48t59_init(NULL, 0xF0000000, 8192, 1968, 8);
>>      /* Load kernel */
>>      linux_boot = (kernel_filename != NULL);
>>      if (linux_boot) {
>> diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
>> index 6525206976b..2d6a095c4e4 100644
>> --- a/hw/rtc/m48t59.c
>> +++ b/hw/rtc/m48t59.c
>> @@ -566,7 +566,7 @@ const MemoryRegionOps m48t59_io_ops = {
>>  
>>  /* Initialisation routine */
>>  Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
>> -                   uint32_t io_base, uint16_t size, int base_year,
>> +                   uint16_t size, int base_year,
>>                     int model)
>>  {
>>      DeviceState *dev;
>> @@ -584,13 +584,7 @@ Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
>>          s = SYS_BUS_DEVICE(dev);
>>          sysbus_realize_and_unref(s, &error_fatal);
>>          sysbus_connect_irq(s, 0, IRQ);
>> -        if (io_base != 0) {
>> -            memory_region_add_subregion(get_system_io(), io_base,
>> -                                        sysbus_mmio_get_region(s, 1));
>> -        }
>> -        if (mem_base != 0) {
>> -            sysbus_mmio_map(s, 0, mem_base);
>> -        }
>> +        sysbus_mmio_map(s, 0, mem_base);
>>  
>>          return NVRAM(s);
>>      }
>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index 947b69d1597..56a0d38f274 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -970,7 +970,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>>          create_unimplemented_device("SUNW,sx", hwdef->sx_base, 0x2000);
>>      }
>>  
>> -    nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
>> +    nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0x2000, 1968, 8);
>>  
>>      slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cpu_irq, smp_cpus);
>>  
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index b4aabfc076f..1cc57b030a7 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -675,7 +675,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>      pci_ide_create_devs(pci_dev);
>>  
>>      /* Map NVRAM into I/O (ebus) space */
>> -    nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
>> +    nvram = m48t59_init(NULL, 0, NVRAM_SIZE, 1968, 59);
>>      s = SYS_BUS_DEVICE(nvram);
>>      memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
>>                                  sysbus_mmio_get_region(s, 0));
> 
> Looks good to me. In fact, if you're working in this area there are a couple of other
> quick wins here too:
> 
> - Remove m48t59_init() and replace with QOM/qdev properties
> 
> - Remove m48t59_init_isa() as this seems to be unused, along with the associated
> complexity of handling the m48txx_isa_info[] array

OK.

> 
> Anyhow:
> 
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks!

> 
> 
> ATB,
> 
> Mark.
> 

