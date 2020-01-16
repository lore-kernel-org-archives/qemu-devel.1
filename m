Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0158AC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 08:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD032073A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 08:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD032073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is0sH-00059C-1l
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 03:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1is0rS-0003mE-LG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1is0rR-0005X0-Dj
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:50:42 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:38118
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1is0rO-0005VQ-GX; Thu, 16 Jan 2020 03:50:38 -0500
Received: from host86-191-119-91.range86-191.btcentralplus.com
 ([86.191.119.91] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1is0rI-0005gM-3O; Thu, 16 Jan 2020 08:50:34 +0000
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-69-git-send-email-imammedo@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <f9614930-c04e-772d-2bb7-dd55a140e4c5@ilande.co.uk>
Date: Thu, 16 Jan 2020 08:50:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-69-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.191.119.91
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 68/86] ppc:prep: use memdev for RAM
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: No (on mail.default.ilande.uk0.bigv.io); Unknown failure
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41c9:1:41f::167
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
Cc: hpoussin@reactos.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/01/2020 15:07, Igor Mammedov wrote:

> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: hpoussin@reactos.org
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> ---
>  hw/ppc/prep.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 862345c..bf75dde 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -400,7 +400,6 @@ static int PPC_NVRAM_set_params (Nvram *nvram, uint16_t NVRAM_size,
>  /* PowerPC PREP hardware initialisation */
>  static void ppc_prep_init(MachineState *machine)
>  {
> -    ram_addr_t ram_size = machine->ram_size;
>      const char *kernel_filename = machine->kernel_filename;
>      const char *kernel_cmdline = machine->kernel_cmdline;
>      const char *initrd_filename = machine->initrd_filename;
> @@ -413,7 +412,6 @@ static void ppc_prep_init(MachineState *machine)
>      MemoryRegion *xcsr = g_new(MemoryRegion, 1);
>  #endif
>      int linux_boot, i, nb_nics1;
> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>      uint32_t kernel_base, initrd_base;
>      long kernel_size, initrd_size;
>      DeviceState *dev;
> @@ -444,15 +442,14 @@ static void ppc_prep_init(MachineState *machine)
>          qemu_register_reset(ppc_prep_reset, cpu);
>      }
>  
> -    /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "ppc_prep.ram", ram_size);
> -    memory_region_add_subregion(sysmem, 0, ram);
> +    /* map RAM */
> +    memory_region_add_subregion(sysmem, 0, machine->ram);
>  
>      if (linux_boot) {
>          kernel_base = KERNEL_LOAD_ADDR;
>          /* now we can load the kernel */
>          kernel_size = load_image_targphys(kernel_filename, kernel_base,
> -                                          ram_size - kernel_base);
> +                                          machine->ram_size - kernel_base);
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'", kernel_filename);
>              exit(1);
> @@ -461,7 +458,7 @@ static void ppc_prep_init(MachineState *machine)
>          if (initrd_filename) {
>              initrd_base = INITRD_LOAD_ADDR;
>              initrd_size = load_image_targphys(initrd_filename, initrd_base,
> -                                              ram_size - initrd_base);
> +                                              machine->ram_size - initrd_base);
>              if (initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               initrd_filename);
> @@ -576,7 +573,7 @@ static void ppc_prep_init(MachineState *machine)
>      sysctrl->nvram = m48t59;
>  
>      /* Initialise NVRAM */
> -    PPC_NVRAM_set_params(m48t59, NVRAM_SIZE, "PREP", ram_size,
> +    PPC_NVRAM_set_params(m48t59, NVRAM_SIZE, "PREP", machine->ram_size,
>                           ppc_boot_device,
>                           kernel_base, kernel_size,
>                           kernel_cmdline,
> @@ -596,6 +593,7 @@ static void prep_machine_init(MachineClass *mc)
>      mc->default_boot_order = "cad";
>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("602");
>      mc->default_display = "std";
> +    mc->default_ram_id = "ppc_prep.ram";
>  }
>  
>  static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
> @@ -814,6 +812,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
>      mc->init = ibm_40p_init;
>      mc->max_cpus = 1;
>      mc->default_ram_size = 128 * MiB;
> +    mc->default_ram_id = "ppc_prep.ram";
>      mc->block_default_type = IF_SCSI;
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");

Note that the prep machine is scheduled for removal soon (I believe Thomas has posted
a patch on-list for this), but the 40p part looks fine.

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.

