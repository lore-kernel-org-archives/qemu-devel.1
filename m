Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA95C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 07:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D112071A
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 07:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/CJ/4iJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D112071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYmPt-0000ab-Up
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 02:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iYmPF-00008g-KE
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 02:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iYmPE-0006tv-3X
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 02:34:05 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iYmPA-0006qJ-E0; Sun, 24 Nov 2019 02:34:00 -0500
Received: by mail-lj1-x243.google.com with SMTP id e10so2928585ljj.6;
 Sat, 23 Nov 2019 23:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s7Zmr8bvQVhMBLI//4GPF3vV9J/C4rxuzQb97UON0t8=;
 b=E/CJ/4iJKAOZL/rYkI3U+p8BsKd4VZzcfHC9bjPC1SwbFKfJHN9Rq2JZG2pNvk2rux
 e3Rk3dJpjc2w/Sg9M2a3fwnEZpTjADnXai58PQlBn6LEDwa9bNL9jKyGNyJuzfcUhH5t
 gdq2dWKpm2TOZtPLMH/yof31tExTbwYd1MsvlTxZvtdDksbyCcI7rp6ofTuGra0y16rt
 Ntto0vcLxW4ig/4YPo5yxpn7ywGwhFWzk4rWFBTYu9Depwn6XR5Jqkx1Dj3a616pwpbj
 gbXyWOosHLaifNMl4BUjltLNi2QTII/ZuVRiqtX2l5nMOdLHXk5Ra1ex0c+kVRhreUeA
 bppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s7Zmr8bvQVhMBLI//4GPF3vV9J/C4rxuzQb97UON0t8=;
 b=Sz21EQh8YH1+vx+G4XGzF34QkEHs9DCNCca7MPwbWpwwIAIYIm4LCsIpg+r+hHYC83
 oI/TVsSt1IP+/4GWBmsocN0jqNqDARZAE5IBITszA8OF/wBEs7NG2CCGpPVxJnYJ9/wL
 jT4G6hIJ/pjp1LbKRsc+MRdzgL2JoHyATVx3mwYVX1UI734SoWwveYHJm1p09I1iT+jb
 Lpua/pqNHN618ADLgcn2unk4cKWYUf5NkWL70a2bfR1GXgkc9pUCQWiqiFouM2CjAwmE
 2Q+MjNnoT2sXtCsGI63pfBikodTiTDWCitsC6KBeD4zLqE+faPE7qSMQI29l3JWXklkv
 AV0g==
X-Gm-Message-State: APjAAAUglDxIRG5fZkVIZqtuGbDGQhVTS73PPrXJwV6g/vCRvFXPbW+q
 Fap0TB3x7w6hcEdxWP947dhW+E0HAdEcCBHkPKI=
X-Google-Smtp-Source: APXvYqzhxZypmHxeKNZLJpSP4+NVaDU0uKT6bswuZv5Lupdv7hmLHK4MoWthjxhc8PvIIheI6RRTpTOezvOaJmfSTEM=
X-Received: by 2002:a2e:7301:: with SMTP id o1mr18440345ljc.16.1574580838008; 
 Sat, 23 Nov 2019 23:33:58 -0800 (PST)
MIME-Version: 1.0
References: <20191119062005.5787-1-siwei.zhuang@data61.csiro.au>
In-Reply-To: <20191119062005.5787-1-siwei.zhuang@data61.csiro.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Sat, 23 Nov 2019 23:33:30 -0800
Message-ID: <CAKmqyKNjAxxT+QbYBDngG6ad7VBJuEvnDDXw-AyPaCjZpeiEZg@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: Add optional symbol callback ptr to
 riscv_load_kernel()
To: "Zhuang, Siwei (Data61, Kensington NSW)" <Siwei.Zhuang@data61.csiro.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 12:03 AM Zhuang, Siwei (Data61, Kensington
NSW) <Siwei.Zhuang@data61.csiro.au> wrote:
>
> This patch adds an optional function pointer, "sym_cb", to
> riscv_load_kernel() which provides the possibility to access the symbol
> table during kernel loading.
>
> The pointer is ignored, if supplied with Image or uImage file.
>
> The Spike board requires the access to locate the HTIF symbols.
>
> Fixes: 0ac24d56c5e7 ("hw/riscv: Split out the boot functions")
> Buglink: https://bugs.launchpad.net/qemu/+bug/1835827
> Signed-off-by: Siwei Zhuang <siwei.zhuang@data61.csiro.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/boot.c         | 7 ++++---
>  hw/riscv/sifive_e.c     | 2 +-
>  hw/riscv/sifive_u.c     | 3 ++-
>  hw/riscv/spike.c        | 6 +++---
>  hw/riscv/virt.c         | 3 ++-
>  include/hw/riscv/boot.h | 3 ++-
>  6 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 7fee98d2f8..027303d2a3 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -114,12 +114,13 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
>      exit(1);
>  }
>
> -target_ulong riscv_load_kernel(const char *kernel_filename)
> +target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sym_cb)
>  {
>      uint64_t kernel_entry, kernel_high;
>
> -    if (load_elf(kernel_filename, NULL, NULL, NULL,
> -                 &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0) > 0) {
> +    if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
> +                         &kernel_entry, NULL, &kernel_high, 0,
> +                         EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>          return kernel_entry;
>      }
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 0f9d641a0e..8a6b0348df 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -111,7 +111,7 @@ static void riscv_sifive_e_init(MachineState *machine)
>                            memmap[SIFIVE_E_MROM].base, &address_space_memory);
>
>      if (machine->kernel_filename) {
> -        riscv_load_kernel(machine->kernel_filename);
> +        riscv_load_kernel(machine->kernel_filename, NULL);
>      }
>  }
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 9552abf4dd..0140e95732 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -344,7 +344,8 @@ static void riscv_sifive_u_init(MachineState *machine)
>                                   memmap[SIFIVE_U_DRAM].base);
>
>      if (machine->kernel_filename) {
> -        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
> +        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
> +                                                  NULL);
>
>          if (machine->initrd_filename) {
>              hwaddr start;
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 8bbffbcd0f..8823681783 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -184,7 +184,7 @@ static void spike_board_init(MachineState *machine)
>                                  mask_rom);
>
>      if (machine->kernel_filename) {
> -        riscv_load_kernel(machine->kernel_filename);
> +        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
>      }
>
>      /* reset vector */
> @@ -273,7 +273,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
>                                  mask_rom);
>
>      if (machine->kernel_filename) {
> -        riscv_load_kernel(machine->kernel_filename);
> +        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
>      }
>
>      /* reset vector */
> @@ -359,7 +359,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>                                  mask_rom);
>
>      if (machine->kernel_filename) {
> -        riscv_load_kernel(machine->kernel_filename);
> +        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
>      }
>
>      /* reset vector */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 23f340df19..65557c837e 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -476,7 +476,8 @@ static void riscv_virt_board_init(MachineState *machine)
>                                   memmap[VIRT_DRAM].base);
>
>      if (machine->kernel_filename) {
> -        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
> +        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
> +                                                  NULL);
>
>          if (machine->initrd_filename) {
>              hwaddr start;
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 66075d0e57..df80051fbc 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -28,7 +28,8 @@ void riscv_find_and_load_firmware(MachineState *machine,
>  char *riscv_find_firmware(const char *firmware_filename);
>  target_ulong riscv_load_firmware(const char *firmware_filename,
>                                   hwaddr firmware_load_addr);
> -target_ulong riscv_load_kernel(const char *kernel_filename);
> +target_ulong riscv_load_kernel(const char *kernel_filename,
> +                               symbol_fn_t sym_cb);
>  hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
>                           uint64_t kernel_entry, hwaddr *start);
>
> --
> 2.24.0
>

