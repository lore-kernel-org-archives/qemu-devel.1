Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E62DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8A6206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8A6206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqLkV-00032d-0X
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqLhL-00063Y-Vi; Tue, 30 Jun 2020 15:13:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:41778
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqLhG-0005Vl-F8; Tue, 30 Jun 2020 15:13:39 -0400
Received: from host86-182-221-235.range86-182.btcentralplus.com
 ([86.182.221.235] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqLhG-0002XH-8C; Tue, 30 Jun 2020 20:13:35 +0100
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1593456926.git.balaton@eik.bme.hu>
 <c69a791c7cad1246f3f34b3993dee4f549b75aa2.1593456926.git.balaton@eik.bme.hu>
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
Message-ID: <ad28ac08-160d-0bde-7856-483308d164cb@ilande.co.uk>
Date: Tue, 30 Jun 2020 20:13:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c69a791c7cad1246f3f34b3993dee4f549b75aa2.1593456926.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.182.221.235
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v7 1/8] mac_oldworld: Allow loading binary ROM image
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

On 29/06/2020 19:55, BALATON Zoltan wrote:

> The beige G3 Power Macintosh has a 4MB firmware ROM. Fix the size of
> the rom region and fall back to loading a binary image with -bios if
> loading ELF image failed. This allows testing emulation with a ROM
> image from real hardware as well as using an ELF OpenBIOS image.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v4: use load address from ELF to check if ROM is too big
> 
>  hw/ppc/mac_oldworld.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index f8c204ead7..baf3da6f90 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -59,6 +59,8 @@
>  #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
>  
>  #define GRACKLE_BASE 0xfec00000
> +#define PROM_BASE 0xffc00000
> +#define PROM_SIZE (4 * MiB)
>  
>  static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>                              Error **errp)
> @@ -99,6 +101,7 @@ static void ppc_heathrow_init(MachineState *machine)
>      SysBusDevice *s;
>      DeviceState *dev, *pic_dev;
>      BusState *adb_bus;
> +    uint64_t bios_addr;
>      int bios_size;
>      unsigned int smp_cpus = machine->smp.cpus;
>      uint16_t ppc_boot_device;
> @@ -127,24 +130,32 @@ static void ppc_heathrow_init(MachineState *machine)
>  
>      memory_region_add_subregion(sysmem, 0, machine->ram);
>  
> -    /* allocate and load BIOS */
> -    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
> +    /* allocate and load firmware ROM */
> +    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", PROM_SIZE,
>                             &error_fatal);
> +    memory_region_add_subregion(sysmem, PROM_BASE, bios);
>  
> -    if (bios_name == NULL)
> +    if (!bios_name) {
>          bios_name = PROM_FILENAME;
> +    }
>      filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -    memory_region_add_subregion(sysmem, PROM_ADDR, bios);
> -
> -    /* Load OpenBIOS (ELF) */
>      if (filename) {
> -        bios_size = load_elf(filename, NULL, 0, NULL, NULL, NULL, NULL, NULL,
> -                             1, PPC_ELF_MACHINE, 0, 0);
> +        /* Load OpenBIOS (ELF) */
> +        bios_size = load_elf(filename, NULL, NULL, NULL, NULL, &bios_addr,
> +                             NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
> +        if (bios_size <= 0) {
> +            /* or load binary ROM image */
> +            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE);
> +            bios_addr = PROM_BASE;
> +        } else {
> +            /* load_elf sets high 32 bits for some reason, strip those */
> +            bios_addr &= 0xffffffffULL;

Repeating my earlier comment from v5: something is wrong here if you need to manually
strip the high bits. If you compare with SPARC32 which uses the same approach, there
is no such strip required - have a look there to try and figure out what's going on here.


ATB,

Mark.

