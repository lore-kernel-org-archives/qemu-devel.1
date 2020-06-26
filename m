Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D54C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9576207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9576207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonlA-00085e-1W
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jonkK-0007AV-UV; Fri, 26 Jun 2020 08:46:20 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:34890
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jonkJ-0004GQ-1L; Fri, 26 Jun 2020 08:46:20 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jonkI-0000Ui-9c; Fri, 26 Jun 2020 13:46:21 +0100
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1592315226.git.balaton@eik.bme.hu>
 <de15b4f489d2277d0d11c0b652c514905ee8f875.1592315226.git.balaton@eik.bme.hu>
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
Message-ID: <128959fe-6b62-0835-b8ec-e5bcc46dc7d8@ilande.co.uk>
Date: Fri, 26 Jun 2020 13:46:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <de15b4f489d2277d0d11c0b652c514905ee8f875.1592315226.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v5 04/11] mac_oldworld: Drop some variables
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/06/2020 14:47, BALATON Zoltan wrote:

> Values not used frequently enough may not worth putting in a local
> variable, especially with names almost as long as the original value
> because that does not improve readability, to the contrary it makes it
> harder to see what value is used. Drop a few such variables.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/mac_oldworld.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index d1c4244b1e..4200008851 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -83,14 +83,11 @@ static void ppc_heathrow_reset(void *opaque)
>  static void ppc_heathrow_init(MachineState *machine)
>  {
>      ram_addr_t ram_size = machine->ram_size;
> -    const char *kernel_filename = machine->kernel_filename;
> -    const char *kernel_cmdline = machine->kernel_cmdline;
> -    const char *initrd_filename = machine->initrd_filename;
>      const char *boot_device = machine->boot_order;
>      PowerPCCPU *cpu = NULL;
>      CPUPPCState *env = NULL;
>      char *filename;
> -    int linux_boot, i;
> +    int i;
>      MemoryRegion *bios = g_new(MemoryRegion, 1);
>      uint32_t kernel_base, initrd_base, cmdline_base = 0;
>      int32_t kernel_size, initrd_size;
> @@ -108,8 +105,6 @@ static void ppc_heathrow_init(MachineState *machine)
>      void *fw_cfg;
>      uint64_t tbfreq;
>  
> -    linux_boot = (kernel_filename != NULL);
> -
>      /* init CPUs */
>      for (i = 0; i < smp_cpus; i++) {
>          cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
> @@ -159,7 +154,7 @@ static void ppc_heathrow_init(MachineState *machine)
>          exit(1);
>      }
>  
> -    if (linux_boot) {
> +    if (machine->kernel_filename) {
>          uint64_t lowaddr = 0;
>          int bswap_needed;
>  
> @@ -169,30 +164,33 @@ static void ppc_heathrow_init(MachineState *machine)
>          bswap_needed = 0;
>  #endif
>          kernel_base = KERNEL_LOAD_ADDR;
> -        kernel_size = load_elf(kernel_filename, NULL,
> +        kernel_size = load_elf(machine->kernel_filename, NULL,
>                                 translate_kernel_address, NULL,
>                                 NULL, &lowaddr, NULL, NULL, 1, PPC_ELF_MACHINE,
>                                 0, 0);
>          if (kernel_size < 0)
> -            kernel_size = load_aout(kernel_filename, kernel_base,
> +            kernel_size = load_aout(machine->kernel_filename, kernel_base,
>                                      ram_size - kernel_base, bswap_needed,
>                                      TARGET_PAGE_SIZE);
>          if (kernel_size < 0)
> -            kernel_size = load_image_targphys(kernel_filename,
> +            kernel_size = load_image_targphys(machine->kernel_filename,
>                                                kernel_base,
>                                                ram_size - kernel_base);
>          if (kernel_size < 0) {
> -            error_report("could not load kernel '%s'", kernel_filename);
> +            error_report("could not load kernel '%s'",
> +                         machine->kernel_filename);
>              exit(1);
>          }
>          /* load initrd */
> -        if (initrd_filename) {
> -            initrd_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
> -            initrd_size = load_image_targphys(initrd_filename, initrd_base,
> +        if (machine->initrd_filename) {
> +            initrd_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size +
> +                                            KERNEL_GAP);
> +            initrd_size = load_image_targphys(machine->initrd_filename,
> +                                              initrd_base,
>                                                ram_size - initrd_base);
>              if (initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
> -                             initrd_filename);
> +                             machine->initrd_filename);
>                  exit(1);
>              }
>              cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
> @@ -336,9 +334,10 @@ static void ppc_heathrow_init(MachineState *machine)
>      fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, ARCH_HEATHROW);
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
> -    if (kernel_cmdline) {
> +    if (machine->kernel_cmdline) {
>          fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_CMDLINE, cmdline_base);
> -        pstrcpy_targphys("cmdline", cmdline_base, TARGET_PAGE_SIZE, kernel_cmdline);
> +        pstrcpy_targphys("cmdline", cmdline_base, TARGET_PAGE_SIZE,
> +                         machine->kernel_cmdline);
>      } else {
>          fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_CMDLINE, 0);
>      }

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.

