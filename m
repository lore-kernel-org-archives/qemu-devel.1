Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FBAC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9409520708
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9409520708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNaGP-0000MF-L1
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 07:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kNaF7-0007bq-9R; Wed, 30 Sep 2020 07:25:57 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kNaF5-0003Q8-5Z; Wed, 30 Sep 2020 07:25:53 -0400
Received: from [192.168.100.1] ([82.252.145.98]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MYedH-1jtWO21e3X-00Ve35; Wed, 30 Sep 2020 13:25:45 +0200
Subject: Re: [PATCH] hw/rtc/m48t59: Simplify m48t59_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200914102425.1152962-1-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <116cc893-74c3-42d7-adbd-0afa1660805b@vivier.eu>
Date: Wed, 30 Sep 2020 13:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914102425.1152962-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:27+uFBK3TmNp+LoTxM5aLQ55i5mEpD6uNbamKfJuasbzW0FW53w
 Uq4HprSAHH1llolSspJOfrQfQjNF2HmIrvJib4McNkcyV/7+z3akSboQOQK/dF32lNg+pBz
 lIUBHasypSpii+dBJmeJdDh5BcXDR1yKSVeDOfyViOl/2NsmtNs6OCvxKIoUgKtDRy5Fd5A
 67HvVlb7O56HMkm1lKJlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yn7KJZQP+E0=:ryQmMxRXNzaEFeP9YQIMyn
 /+052sTmjXgvy+9W9Sag9qlFimDZhwwnJZlEylMTQbSN1d6mQMwTfjy5ugp+CwSRH0IrEbdqX
 jlCOZNZEKtfq/mzqRVYDVovMGXES4kthGxYiMEehBJup3gJs+2LhxabAzsk1bedDsFuLw/119
 Zko9I4TJ4QKv8H4YCqD4gsPP5DVHP+KmCtfV/QSt4VKFUkUAoddDIwKRzsmoIMAuNiGWskSnk
 ec0b8qSZ69ljFol7SJquvxf/ymJ5sJcFPgZ36KIAHG1Nip63ayrvHuGLFwrKIS3CFbrbqyaRO
 t/yExpGt0ac0JhR/u67F+FjAWILwYcCSpeesS7SUY1gaUxneDxZIcGJLLf6gphn76x5EDkeOM
 g7frxusB1PrbCif/RU23bR47M00i2VupFDy0CDeZWnxGCIcSytkQZEbPl+GxKnRzB53SojTMo
 NJ0CEJkGW+ky/kD90XgOqC+U7kemusIxAHPnZJEfMik/4yDo9O2q4pmSH0ZSsfxQGE9HbJ3Ms
 cWqwYA0xG7BoUPKgA5zcWGv1pZ24k3ZrSJNhIpukp8d7YgGbHYVWNaum3x3zVhVm46CDwHF/H
 EvalASBhOj0+ylPcoinJgjrIdgANBE4UGa7pBw4JS3zcbSgz31+i4vGnyC4NurOV+78JnkdLY
 W3CoPH4S/99AjwSDicoqqJXQP4GEjJbaUfnxAtRW5mzyYQ1QaUw34qFIM3c8kiTgXN/6ayjwC
 riJDjAz/9QVHqpAG7KLC3Zj4CNgGuGHYR+wROYGPuqUE3/VktWZNOO8+c/yqCUPQWHr18PsTI
 2oZ6gZukJggs1lKpI5vMDXjHjxdT14owjuwAj5I91rt3VLUKH3eF18kwCSXlKvbPkLGZelf
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 07:25:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.373, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 14/09/2020 à 12:24, Philippe Mathieu-Daudé a écrit :
> As the 'io_base' argument of m48t59_init() is unused (set to 0),
> remove it to simplify.
> To create a device on the ISA bus, m48t59_init_isa() is the
> preferred function to use.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/rtc/m48t59.h |  2 +-
>  hw/ppc/ppc405_boards.c  |  2 +-
>  hw/rtc/m48t59.c         | 10 ++--------
>  hw/sparc/sun4m.c        |  2 +-
>  hw/sparc64/sun4u.c      |  2 +-
>  5 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
> index 04abedf3b2b..62297ee0db1 100644
> --- a/include/hw/rtc/m48t59.h
> +++ b/include/hw/rtc/m48t59.h
> @@ -50,7 +50,7 @@ struct NvramClass {
>  Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
>                         int base_year, int type);
>  Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
> -                   uint32_t io_base, uint16_t size, int base_year,
> +                   uint16_t size, int base_year,
>                     int type);
>  
>  #endif /* HW_M48T59_H */
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 6198ec1035b..93ffee801a3 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -227,7 +227,7 @@ static void ref405ep_init(MachineState *machine)
>      /* Register FPGA */
>      ref405ep_fpga_init(sysmem, 0xF0300000);
>      /* Register NVRAM */
> -    m48t59_init(NULL, 0xF0000000, 0, 8192, 1968, 8);
> +    m48t59_init(NULL, 0xF0000000, 8192, 1968, 8);
>      /* Load kernel */
>      linux_boot = (kernel_filename != NULL);
>      if (linux_boot) {
> diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
> index 6525206976b..2d6a095c4e4 100644
> --- a/hw/rtc/m48t59.c
> +++ b/hw/rtc/m48t59.c
> @@ -566,7 +566,7 @@ const MemoryRegionOps m48t59_io_ops = {
>  
>  /* Initialisation routine */
>  Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
> -                   uint32_t io_base, uint16_t size, int base_year,
> +                   uint16_t size, int base_year,
>                     int model)
>  {
>      DeviceState *dev;
> @@ -584,13 +584,7 @@ Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
>          s = SYS_BUS_DEVICE(dev);
>          sysbus_realize_and_unref(s, &error_fatal);
>          sysbus_connect_irq(s, 0, IRQ);
> -        if (io_base != 0) {
> -            memory_region_add_subregion(get_system_io(), io_base,
> -                                        sysbus_mmio_get_region(s, 1));
> -        }
> -        if (mem_base != 0) {
> -            sysbus_mmio_map(s, 0, mem_base);
> -        }
> +        sysbus_mmio_map(s, 0, mem_base);
>  
>          return NVRAM(s);
>      }
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 947b69d1597..56a0d38f274 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -970,7 +970,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>          create_unimplemented_device("SUNW,sx", hwdef->sx_base, 0x2000);
>      }
>  
> -    nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
> +    nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0x2000, 1968, 8);
>  
>      slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cpu_irq, smp_cpus);
>  
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index b4aabfc076f..1cc57b030a7 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -675,7 +675,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      pci_ide_create_devs(pci_dev);
>  
>      /* Map NVRAM into I/O (ebus) space */
> -    nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
> +    nvram = m48t59_init(NULL, 0, NVRAM_SIZE, 1968, 59);
>      s = SYS_BUS_DEVICE(nvram);
>      memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
>                                  sysbus_mmio_get_region(s, 0));
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


