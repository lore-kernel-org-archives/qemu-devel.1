Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAE8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48652080A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48652080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX81p-00045K-Hp
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kX7uI-0006AP-Rx
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:11:50 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:36535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kX7uG-0007bK-4d
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:11:50 -0400
Received: from [192.168.100.1] ([82.252.139.38]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N8GAQ-1kK9QE0p4i-014AG2; Mon, 26 Oct 2020 20:11:42 +0100
Subject: Re: [PATCH 07/15] m68k: remove bios_name
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-8-pbonzini@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <457e6a0b-8c33-0d40-950b-6829d4f9a1d1@vivier.eu>
Date: Mon, 26 Oct 2020 20:11:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026143028.3034018-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IL4h2fkqOVqzFk6boK74uZfJAwQtL9velJzM4/7REYpDwsIkc17
 YAV7J1TY8rzN0cS7SHoXL9UYrnkd6BN9eW5h1aF6SVISSdXMs3YIX/U77JOPWsDKFumLU1j
 HnsLGDq+B4c5angkeTYe7eph/YRyODOcebs51Rk+CY0viqUY/SHK1D2FihkAyqfz6Obkbng
 nyQXiiMkbSc1B5n7dmpJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dnjt7dBrZgU=:uuBaPgCR5SBbxoDAS30hMi
 u3B46Wy4yFLIPGiF7X6ESPHvoyJpDad6CL3zgGMhrtzljn8voaL13s+dTm5ADb5A7bwogc+Ca
 X0J1gTp36Y7Jar1x2WXaKsJ3KGEw8TogquLZh6417eeYnns3d3JzVgo3igzJoq1RjFCrGAznB
 +QkjaUQKHmsWkxj2lfZZ7TkTkbVL2+MenCb/mUrXwYEAvpomoJreX2nHtQZpJDHztOs3jdvbx
 YEYxz9oEbjY7ijkfJIwNSGpEBWjhvsS6NiIiGmSVaRf9/HC9hzA7uXUJEXAmPhFy7SsWs617c
 IgaJDlucJ5cecuTOnpVGGdUngKvNfSAEKrtu5qCzg0U1+U47yREtIMLdQcs0tj0nrm5MJl6Bj
 vj8/wpeebzqd31u67Enn8ejCNVIZVDo73ssLNmfGPhIdpU6PHzWTRjfBpCBIFOw/OeGz0Ebzn
 +R/d+IJBqw==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 15:11:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/10/2020 à 15:30, Paolo Bonzini a écrit :
> Cc: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/m68k/mcf5208.c   | 10 +++++-----
>  hw/m68k/next-cube.c |  4 +---
>  hw/m68k/q800.c      |  4 +---
>  3 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index d310a98e7b..7c8ca5ddf6 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -301,17 +301,17 @@ static void mcf5208evb_init(MachineState *machine)
>      /* 0xfc0a8000 SDRAM controller.  */
>  
>      /* Load firmware */
> -    if (bios_name) {
> +    if (machine->firmware) {
>          char *fn;
>          uint8_t *ptr;
>  
> -        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware);
>          if (!fn) {
> -            error_report("Could not find ROM image '%s'", bios_name);
> +            error_report("Could not find ROM image '%s'", machine->firmware);
>              exit(1);
>          }
>          if (load_image_targphys(fn, 0x0, ROM_SIZE) < 8) {
> -            error_report("Could not load ROM image '%s'", bios_name);
> +            error_report("Could not load ROM image '%s'", machine->firmware);
>              exit(1);
>          }
>          g_free(fn);
> @@ -323,7 +323,7 @@ static void mcf5208evb_init(MachineState *machine)
>  
>      /* Load kernel.  */
>      if (!kernel_filename) {
> -        if (qtest_enabled() || bios_name) {
> +        if (qtest_enabled() || machine->firmware) {
>              return;
>          }
>          error_report("Kernel image must be specified");

Why do you do differently for mcf5208 than the others?

    const char *bios_name = machine->firmware;

and no other changes?

With or without this:

Acked-by: Laurent Vivier <laurent@vivier.eu>


> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index e7045980b7..37bc35dfa4 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -868,6 +868,7 @@ static void next_cube_init(MachineState *machine)
>      MemoryRegion *bmapm1 = g_new(MemoryRegion, 1);
>      MemoryRegion *bmapm2 = g_new(MemoryRegion, 1);
>      MemoryRegion *sysmem = get_system_memory();
> +    const char *bios_name = machine->firmware ?: ROM_FILE;
>      NeXTState *ns = NEXT_MACHINE(machine);
>      DeviceState *dev;
>  
> @@ -924,9 +925,6 @@ static void next_cube_init(MachineState *machine)
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x0200e000);
>  
>      /* Load ROM here */
> -    if (bios_name == NULL) {
> -        bios_name = ROM_FILE;
> -    }
>      /* still not sure if the rom should also be mapped at 0x0*/
>      memory_region_init_rom(rom, NULL, "next.rom", 0x20000, &error_fatal);
>      memory_region_add_subregion(sysmem, 0x01000000, rom);
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index ce4b47c3e3..6ebcddcfb2 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -167,6 +167,7 @@ static void q800_init(MachineState *machine)
>      const char *kernel_filename = machine->kernel_filename;
>      const char *initrd_filename = machine->initrd_filename;
>      const char *kernel_cmdline = machine->kernel_cmdline;
> +    const char *bios_name = machine->firmware ?: MACROM_FILENAME;
>      hwaddr parameters_base;
>      CPUState *cs;
>      DeviceState *dev;
> @@ -400,9 +401,6 @@ static void q800_init(MachineState *machine)
>          rom = g_malloc(sizeof(*rom));
>          memory_region_init_rom(rom, NULL, "m68k_mac.rom", MACROM_SIZE,
>                                 &error_abort);
> -        if (bios_name == NULL) {
> -            bios_name = MACROM_FILENAME;
> -        }
>          filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>          memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
>  
> 


