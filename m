Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BADC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 10:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8954224125
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 10:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8954224125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig56H-0006eU-PN
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 05:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ig55f-0006Ce-UT
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 05:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ig55e-0001Fz-6h
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 05:56:03 -0500
Received: from mail.ilande.co.uk ([46.43.2.167]:48454
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ig55d-0001Cx-5X
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 05:56:01 -0500
Received: from host86-191-82-191.range86-191.btcentralplus.com
 ([86.191.82.191] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ig56O-0003jF-Vl; Sat, 14 Dec 2019 10:56:53 +0000
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191212200142.15688-1-laurent@vivier.eu>
 <20191212200142.15688-4-laurent@vivier.eu>
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
Message-ID: <d5852871-077c-fba9-4a7b-bea851563954@ilande.co.uk>
Date: Sat, 14 Dec 2019 10:55:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212200142.15688-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.191.82.191
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 3/3] q800: add machine id register
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.43.2.167
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

On 12/12/2019 20:01, Laurent Vivier wrote:

> MacOS reads this address to identify the hardware.
> 
> This is a basic implementation returning the ID of Quadra 800.
> 
> Details:
> 
>   http://mess.redump.net/mess/driver_info/mac_technical_notes
> 
> "There are 3 ID schemes [...]
>  The third and most scalable is a machine ID register at 0x5ffffffc.
>  The top word must be 0xa55a to be valid. Then bits 15-11 are 0 for
>  consumer Macs, 1 for portables, 2 for high-end 68k, and 3 for high-end
>  PowerPC. Bit 10 is 1 if additional ID bits appear elsewhere (e.g. in VIA1).
>  The rest of the bits are a per-model identifier.
> 
>  Model                          Lower 16 bits of ID
> ...
>  Quadra/Centris 610/650/800     0x2BAD"
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  hw/m68k/q800.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 9ee0cb1141..c2b2aa779f 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -97,6 +97,23 @@ static void main_cpu_reset(void *opaque)
>      cpu->env.pc = ldl_phys(cs->as, 4);
>  }
>  
> +static uint64_t machine_id_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0xa55a2bad; /* Quadra 800 ID */
> +}
> +
> +static void machine_id_write(void *opaque, hwaddr addr, uint64_t val,
> +                             unsigned size)
> +{
> +}
> +
> +static const MemoryRegionOps machine_id_ops = {
> +    .read = machine_id_read,
> +    .write = machine_id_write,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +};

Should there be a .endianness here just to be really safe?

>  static void q800_init(MachineState *machine)
>  {
>      M68kCPU *cpu = NULL;
> @@ -110,6 +127,7 @@ static void q800_init(MachineState *machine)
>      MemoryRegion *rom;
>      MemoryRegion *ram;
>      MemoryRegion *io;
> +    MemoryRegion *machine_id;
>      const int io_slice_nb = (IO_SIZE / IO_SLICE) - 1;
>      int i;
>      ram_addr_t ram_size = machine->ram_size;
> @@ -159,6 +177,10 @@ static void q800_init(MachineState *machine)
>          g_free(name);
>      }
>  
> +    machine_id = g_malloc(sizeof(*machine_id));
> +    memory_region_init_io(machine_id, NULL, &machine_id_ops, NULL, "Machine ID", 4);
> +    memory_region_add_subregion(get_system_memory(), 0x5ffffffc, machine_id);
> +
>      /* djMEMC memory and interrupt controller */
>  
>      djmemc_dev = qdev_create(NULL, TYPE_DJMEMC);

Otherwise looks good and I see it being poked by a MacOS ROM so:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.

