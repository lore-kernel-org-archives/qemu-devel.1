Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B14DC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CA02220D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFi3luuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CA02220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSeb-0000ll-T3
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLSd2-00084T-I2; Thu, 24 Sep 2020 10:53:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLScz-0007ZB-C0; Thu, 24 Sep 2020 10:53:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id a17so4159392wrn.6;
 Thu, 24 Sep 2020 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hJsE7oC4N7Vw4BCi7Y8T2kEetFyc7K+JMx0EYJPw6fE=;
 b=aFi3luuUDMv16xJminAvdtHPz2kCnaYX84Xf4UZWI04Rn/j+kAsHCj+HWrfoC+1dwe
 EYsQQsS6kMQH+VETUedmcAqyo4yvZ6Fa0ncs59IAFomS46LADTUqD4teZpJLRogt68A3
 liCSPMjtm0QeF8haqR5R7U/sRkxLGZ2MincSNcTXuegUaC8feHjHfwMolT0kyVvJm30v
 +wPQZ70juLIaeLKDyaInl6K1r9uY5WWicHJZGJ631ry+5x5tEKpVuNPR3RMp83MtLPDG
 PiaJaZnjMsnmtnwEA8bRbJvz7Tl7D8xUlnrkuJamU9+jD2q5bD2oReXOrF6NW7MayN4v
 AKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hJsE7oC4N7Vw4BCi7Y8T2kEetFyc7K+JMx0EYJPw6fE=;
 b=uei7eqkg4aOOBd1G6NT1u0LNkmtuQ7Qn1YTTR4T1xK6O2BgkFTQvgDDKB6N6fiwhfi
 BPmSjyYX0RYl2xCiyHZixoLuFOF8iqBSmdYgpLF1i/NB6UIowmg8HE/MbjOcc2P7vpxw
 d5M8dOmKuR1gPZpfp3az1+dt4Y0tTAAzTbuH9sX9S1Dfji1qtVj27pWfp+rmSdLS2/OP
 dVqoDIaaE7whWS8xah4H02Xua1bv+0orRpWeXbVR+VOBXsB79x+rcrQHBEmHHNKNTQ1c
 X2jbsDS2YaYsUVdR6y42KwIjZ+Mm8m5ba6gDY77XjFCJulOyPF5MdX9wR3bJszDZMRry
 wWqw==
X-Gm-Message-State: AOAM533vk85ncPgov1jJkVeTNjJPInd3SOnSY7j05Y1d0Qr0GwW5IB7u
 w2OyJ21k5gqyeFLyY0fiUCw=
X-Google-Smtp-Source: ABdhPJzfCPXjJepRkuqYTCGW1TBI91Q8w3DWkzlnvFuGSC6ARn+ATSO11oYdYYAVvOnmRqLuYEHPoA==
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr199674wrj.92.1600959223231;
 Thu, 24 Sep 2020 07:53:43 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id u66sm13842342wme.1.2020.09.24.07.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 07:53:42 -0700 (PDT)
Subject: Re: [PATCH] hw/rtc/m48t59: Simplify m48t59_init()
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200914102425.1152962-1-f4bug@amsat.org>
 <20200916025022.GE5258@yekko.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <de2b5d0c-fcc4-a26c-5fda-610b7fa75862@amsat.org>
Date: Thu, 24 Sep 2020 16:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916025022.GE5258@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.214,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 4:50 AM, David Gibson wrote:
> On Mon, Sep 14, 2020 at 12:24:25PM +0200, Philippe Mathieu-Daudé wrote:
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
> 
> ppc part
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Thanks!

Can this go via qemu-trivial@?

> 
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

