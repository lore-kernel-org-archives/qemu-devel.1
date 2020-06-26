Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD77EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910282081A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910282081A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonh9-0002uo-Lm
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jongR-0002D6-BF; Fri, 26 Jun 2020 08:42:19 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:34830
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jongP-00026Z-Jn; Fri, 26 Jun 2020 08:42:19 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jongN-0000Sr-B5; Fri, 26 Jun 2020 13:42:19 +0100
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1592315226.git.balaton@eik.bme.hu>
 <ef4d9dc2e9241f8bd29b727e8fa32c4768718c9a.1592315226.git.balaton@eik.bme.hu>
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
Message-ID: <52c26191-cfaf-4bc0-b60f-58d13964f5c6@ilande.co.uk>
Date: Fri, 26 Jun 2020 13:42:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ef4d9dc2e9241f8bd29b727e8fa32c4768718c9a.1592315226.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v5 02/11] mac_newworld: Allow loading binary ROM image
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

> Fall back to load binary ROM image if loading ELF fails. This also
> moves PROM_BASE and PROM_SIZE defines to board as these are matching
> the ROM size and address on this board.

Probably worth a quick mention here that you are removing BIOS_SIZE and PROM_ADDR
from the common Mac code.

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> Notes:
>     Unlike mac_oldworld where the openbios-ppc image loads at end of ROM
>     region here we only check size and assume ELF image is loaded from
>     PROM_BASE, Checking the load addr here is tricky because this board is
>     also be compiled both 64 and 32 bit and load_elf seems to always
>     return 64 bit value so handling that could become a mess. If this is a
>     problem then it's a preexisting one so should be fixed in a separate
>     patch. This one just allows loading ROM binary too otherwise
>     preserving previous behaviour.
> 
>  hw/ppc/mac.h          |  2 --
>  hw/ppc/mac_newworld.c | 22 ++++++++++++++--------
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index 6af87d1fa0..a0d9e47031 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -38,10 +38,8 @@
>  /* SMP is not enabled, for now */
>  #define MAX_CPUS 1
>  
> -#define BIOS_SIZE        (1 * MiB)
>  #define NVRAM_SIZE        0x2000
>  #define PROM_FILENAME    "openbios-ppc"
> -#define PROM_ADDR         0xfff00000
>  
>  #define KERNEL_LOAD_ADDR 0x01000000
>  #define KERNEL_GAP       0x00100000
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 5f3a028e6a..eec62d1e90 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -82,6 +82,8 @@
>  
>  #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
>  
> +#define PROM_BASE 0xfff00000
> +#define PROM_SIZE (1 * MiB)
>  
>  static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>                              Error **errp)
> @@ -100,7 +102,7 @@ static void ppc_core99_reset(void *opaque)
>  
>      cpu_reset(CPU(cpu));
>      /* 970 CPUs want to get their initial IP as part of their boot protocol */
> -    cpu->env.nip = PROM_ADDR + 0x100;
> +    cpu->env.nip = PROM_BASE + 0x100;
>  }
>  
>  /* PowerPC Mac99 hardware initialisation */
> @@ -153,25 +155,29 @@ static void ppc_core99_init(MachineState *machine)
>      /* allocate RAM */
>      memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>  
> -    /* allocate and load BIOS */
> -    memory_region_init_rom(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
> +    /* allocate and load firmware ROM */
> +    memory_region_init_rom(bios, NULL, "ppc_core99.bios", PROM_SIZE,
>                             &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), PROM_BASE, bios);
>  
> -    if (bios_name == NULL)
> +    if (!bios_name) {
>          bios_name = PROM_FILENAME;
> +    }
>      filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -    memory_region_add_subregion(get_system_memory(), PROM_ADDR, bios);
> -
> -    /* Load OpenBIOS (ELF) */
>      if (filename) {
> +        /* Load OpenBIOS (ELF) */
>          bios_size = load_elf(filename, NULL, NULL, NULL, NULL,
>                               NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
>  
> +        if (bios_size <= 0) {
> +            /* or load binary ROM image */
> +            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE);
> +        }
>          g_free(filename);
>      } else {
>          bios_size = -1;
>      }
> -    if (bios_size < 0 || bios_size > BIOS_SIZE) {
> +    if (bios_size < 0 || bios_size > PROM_SIZE) {
>          error_report("could not load PowerPC bios '%s'", bios_name);
>          exit(1);
>      }

Same as with the previous patch: presumably if you fix the issue with load_elf() then
this should work fine as it does with SPARC.


ATB,

Mark.

