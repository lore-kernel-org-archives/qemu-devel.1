Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37F8C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7601D20848
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7601D20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in1FX-000180-KH
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 09:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1in1Ef-0000Gc-DK
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1in1Ee-000852-8J
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:14:01 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:37625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1in1Ed-00084Q-VQ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:14:00 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M6EKU-1ipC280ZR2-006gA4; Thu, 02 Jan 2020 15:13:56 +0100
Subject: Re: [PATCH v2] q800: implement mac rom reset function for BIOS-less
 mode
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-devel@nongnu.org
References: <d3eb847b-a6b9-4ac7-3c06-576686cca608@vivier.eu>
 <20200102120150.281082-1-Jason@zx2c4.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e3aa2cf1-0273-aec3-4624-eedab333677c@vivier.eu>
Date: Thu, 2 Jan 2020 15:13:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200102120150.281082-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OjdSGDrw9FKm6kk/zeC50X7w7Sga14wFFgjXb+LA+PWWH46wpCL
 hBs/G51s9808qO/b45EWgNGEGfsf9UPrn9kh+HTJl5JPAfu7MRE9ZVrr9K6if4rZjx6lgG5
 prtKdzicJydH9wMJJXBEsehOCbtudtGjHocUOAnIdl0oKMjwA5GGRfUFVonOlaD3PH3tCEW
 dmg0x0S5RnHge65TjI/5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kw/sMB05Akc=:D9Wz3Ix866p/N/Ti9v+Ktb
 7ejnfXKthkETn8JMHtAeaH817g/AgKTXiR6j2O8MfozIB0rfyBXuUSJTgNNBaafqSM78LiZYa
 XcIjg1o61EftAuyMYL7jpjFccnRFDWMvfnqMyNTHhlrX6xzFnjnhPq2I5JsPPwam104lIYRjD
 E2Nadcxyd0fBbqYHvnaPhGEataJzPARrOsUum7RRGDbIIUlKobiUSsLgTSZXQQkYEkF6qKyZN
 n+tQiGkaoHn2mJqgR8B4r/0IH0pHVSpkasoabfOxnro9C663Avvsegor993BWPM40O+ExGe7u
 8L+4O8GUxUTGf3DiDVlJzwiTEzYWFn8NPCcyP7vPe0sMoHzRsRh3RtZ0deER4OA7g/yC1KxWB
 9DRAk+Vc1J5b1TTb5FNzSRwT+2lVPYIPspRogPQMnyqpU2j4dRqvGMvxZ3EAGV2XqeRhpB7jd
 CRMFrYSSyJfHArtf4q7nkMOYRwlMheqarzHWu8llzVrNSkXQh+k9bZbr/y3sK0Cs/SdRbLaih
 LmiwD2IUxb+0dV8OsJHCZk+uwVAgOflnZKKSHdxSbuKggahQZU6BOuKqJA5KD0whz4hZa7FcN
 gC0NHxpAzAgqub9kmObSEmIVjsNrIJhrimx9SnexW84vR7hcdJIEv9vttJOP3b8s2R6zs6U36
 UsBkgI5kBbLkIzJvBWEWizQSmNGo2JO3uEB/RGmM/YEfa4RAe9Fi2Jts0LwqVvk3/lyuHA+Yu
 1/GSyykg0+VsAmh55sh/EyibG5dLIrcGA8LzEv0xYlIQsjIFdQam0cb+jNajzxKl6oarIskge
 SGrKdMOmnJ/eFzDyDRx6Yg87ePe/mbWLQYmPKlMTZE0w9JvmspepoVEE5vIoyQj1X0yi7ARFW
 RJHqDauWTLnT+FbavpIsBXFIyzXrLI/9sSUJjiodk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/01/2020 à 13:01, Jason A. Donenfeld a écrit :
> On Linux, calling `reboot(RB_AUTOBOOT);` will result in
> arch/m68k/mac/misc.c's mac_reset function being called. That in turn
> looks at the rombase (or uses 0x40800000 is there's no rombase), adds
> 0xa, and jumps to that address. At the moment, there's nothing there, so
> the kernel just crashes when trying to reboot. So, this commit adds a
> very simple implementation at that location, which just writes to via2
> to power down. We also correct the value of ROMBASE while we're at it.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  hw/m68k/q800.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 4ca8678007..f03679e24c 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -47,7 +47,7 @@
>  #include "sysemu/runstate.h"
>  #include "sysemu/reset.h"
>  
> -#define MACROM_ADDR     0x40000000
> +#define MACROM_ADDR     0x40800000
>  #define MACROM_SIZE     0x00100000
>  
>  #define MACROM_FILENAME "MacROM.bin"
> @@ -128,6 +128,27 @@ static void main_cpu_reset(void *opaque)
>      cpu->env.pc = ldl_phys(cs->as, 4);
>  }
>  
> +static uint8_t fake_mac_rom[] = {
> +    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +
> +    /* offset: 0xa - mac_reset */
> +
> +    /* via2[vDirB] |= VIA2B_vPower */
> +    0x20, 0x7C, 0x50, 0xF0, 0x24, 0x00, /* moveal VIA2_BASE+vDirB,%a0 */
> +    0x10, 0x10,                         /* moveb %a0@,%d0 */
> +    0x00, 0x00, 0x00, 0x04,             /* orib #4,%d0 */
> +    0x10, 0x80,                         /* moveb %d0,%a0@ */
> +
> +    /* via2[vBufB] &= ~VIA2B_vPower */
> +    0x20, 0x7C, 0x50, 0xF0, 0x20, 0x00, /* moveal VIA2_BASE+vBufB,%a0 */
> +    0x10, 0x10,                         /* moveb %a0@,%d0 */
> +    0x02, 0x00, 0xFF, 0xFB,             /* andib #-5,%d0 */
> +    0x10, 0x80,                         /* moveb %d0,%a0@ */
> +
> +    /* while (true) ; */
> +    0x60, 0xFE                          /* bras [self] */
> +};
> +
>  static void q800_init(MachineState *machine)
>  {
>      M68kCPU *cpu = NULL;
> @@ -340,6 +361,12 @@ static void q800_init(MachineState *machine)
>                    (graphic_width * graphic_depth + 7) / 8);
>          BOOTINFO1(cs->as, parameters_base, BI_MAC_SCCBASE, SCC_BASE);
>  
> +        rom = g_malloc(sizeof(*rom));
> +        memory_region_init_ram_ptr(rom, NULL, "m68k_fake_mac.rom",
> +                                   sizeof(fake_mac_rom), fake_mac_rom);
> +        memory_region_set_readonly(rom, true);
> +        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
> +
>          if (kernel_cmdline) {
>              BOOTINFOSTR(cs->as, parameters_base, BI_COMMAND_LINE,
>                          kernel_cmdline);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

