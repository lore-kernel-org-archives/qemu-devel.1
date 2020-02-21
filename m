Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EA0C35663
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 19:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DA024650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 19:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ofl7iXyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DA024650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5EIl-0004db-QT
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 14:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j5EHu-00048X-HM
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 14:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j5EHs-0007fx-RS
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 14:48:38 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:36298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j5EHp-0007XE-R4; Fri, 21 Feb 2020 14:48:34 -0500
Received: by mail-lf1-x144.google.com with SMTP id f24so2345984lfh.3;
 Fri, 21 Feb 2020 11:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sapn+jpPCNk3Dm9ydmgp0LW7y1MLHCMChd43Rt/WXnQ=;
 b=Ofl7iXyZ5H7Rs+gAIE3lFS/iqBE1mUcBs4RkuMczleShU6R2NxC5RTcOUdDd7tg63q
 Ml0Iav3Dy48JNH4veL/jbq41BR3T7WxXXllad16sjej6km4cdBQHJdW8vyyZbdCngn16
 Fv0Gi27HRtkM45ixKtgZjYLXvEGREyfDBXRFTd4sL06KKBRVUhUHc3hREEYybv1NjIB1
 rvotkkku4rJjmHS3uHneI8f07WUFpGJEgxCLaleyIvN79D9Lm8RgtkOtE3qZEfMFreA5
 avx2gF6It9vYKtL7yF55B1mEjIEnHwBsLxCoY/JqLnclUp5ThUt2N7kbpcwju2HZKp2A
 bhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sapn+jpPCNk3Dm9ydmgp0LW7y1MLHCMChd43Rt/WXnQ=;
 b=LVuJtk3g3dO18MJ/OniASxpM47s3SfuUHeXRg7gYwJHFEjai6PcjOzKh/ahx0m/CEk
 FrQOBRhtPzjL+r9ZQfI1fCfrVeZQhMg62N+0o4puJl2cfK2Fb0TSAgtP6Xm6b7iU7Fbc
 VGqfkuEH+O0sOqljYiAPhdnhGON/3B1GbSWn5gX/3qmfiLd7lRHtZe9A6VofXWV6iizV
 FqjkSaYIttA2usY0BqxSBUbAvsIiBHc9vgULPYU6HVGvI09kQRD0ZD1hoeDPu5gfQaW8
 UA3XBBuqGYTZUIi/064Kq7SHxLBHX+xGj9+3FuIKpaqXq6PRz2RhUU2AzZBdz3xkneMR
 MVRQ==
X-Gm-Message-State: APjAAAVnf4zQdFNHcxyTKO4Lo4qKrE+NacTBuc8VyUoTMggpLrvI2FLN
 lkZ9TGn2dpnFU0rtIhT+wWW4Go0jQOi5udFnVtKmkJsc
X-Google-Smtp-Source: APXvYqz3cdnLOteJTBjv7wL/GUtS040vtyRfToNdgj245nLbJTEGSp1fCPl669iBuMlsxhkYREpB6G/luAUYAQN1eQI=
X-Received: by 2002:a19:23d0:: with SMTP id
 j199mr20721823lfj.137.1582314511946; 
 Fri, 21 Feb 2020 11:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20200214072127.64330-1-anup.patel@wdc.com>
 <20200214072127.64330-2-anup.patel@wdc.com>
In-Reply-To: <20200214072127.64330-2-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Feb 2020 11:48:05 -0800
Message-ID: <CAKmqyKMrTxjpsxcoV_=n-KDSdqoHD9uApK-Fo+Jnofx5sBXN2A@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/riscv: Add optional symbol callback ptr to
 riscv_load_firmware()
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 11:24 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> This patch adds an optional function pointer, "sym_cb", to
> riscv_load_firmware() which provides the possibility to access
> the symbol table during kernel loading.
>
> The pointer is ignored, if supplied with flat (non-elf) firmware image.
>
> The Spike board requires it locate the HTIF symbols from firmware ELF
> passed via "-bios" option.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/boot.c         | 13 ++++++++-----
>  hw/riscv/sifive_u.c     |  2 +-
>  hw/riscv/virt.c         |  2 +-
>  include/hw/riscv/boot.h |  6 ++++--
>  4 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 027303d2a3..7ec94dc701 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -36,7 +36,8 @@
>
>  void riscv_find_and_load_firmware(MachineState *machine,
>                                    const char *default_machine_firmware,
> -                                  hwaddr firmware_load_addr)
> +                                  hwaddr firmware_load_addr,
> +                                  symbol_fn_t sym_cb)
>  {
>      char *firmware_filename = NULL;
>
> @@ -76,7 +77,7 @@ void riscv_find_and_load_firmware(MachineState *machine,
>
>      if (firmware_filename) {
>          /* If not "none" load the firmware */
> -        riscv_load_firmware(firmware_filename, firmware_load_addr);
> +        riscv_load_firmware(firmware_filename, firmware_load_addr, sym_cb);
>          g_free(firmware_filename);
>      }
>  }
> @@ -96,12 +97,14 @@ char *riscv_find_firmware(const char *firmware_filename)
>  }
>
>  target_ulong riscv_load_firmware(const char *firmware_filename,
> -                                 hwaddr firmware_load_addr)
> +                                 hwaddr firmware_load_addr,
> +                                 symbol_fn_t sym_cb)
>  {
>      uint64_t firmware_entry, firmware_start, firmware_end;
>
> -    if (load_elf(firmware_filename, NULL, NULL, NULL, &firmware_entry,
> -                 &firmware_start, &firmware_end, 0, EM_RISCV, 1, 0) > 0) {
> +    if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
> +                         &firmware_entry, &firmware_start, &firmware_end, 0,
> +                         EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>          return firmware_entry;
>      }
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 0140e95732..0c84215f42 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -341,7 +341,7 @@ static void riscv_sifive_u_init(MachineState *machine)
>      create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>
>      riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> -                                 memmap[SIFIVE_U_DRAM].base);
> +                                 memmap[SIFIVE_U_DRAM].base, NULL);
>
>      if (machine->kernel_filename) {
>          uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index c44b865959..90a5bfef63 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -476,7 +476,7 @@ static void riscv_virt_board_init(MachineState *machine)
>                                  mask_rom);
>
>      riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> -                                 memmap[VIRT_DRAM].base);
> +                                 memmap[VIRT_DRAM].base, NULL);
>
>      if (machine->kernel_filename) {
>          uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index df80051fbc..474a940ad5 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -24,10 +24,12 @@
>
>  void riscv_find_and_load_firmware(MachineState *machine,
>                                    const char *default_machine_firmware,
> -                                  hwaddr firmware_load_addr);
> +                                  hwaddr firmware_load_addr,
> +                                  symbol_fn_t sym_cb);
>  char *riscv_find_firmware(const char *firmware_filename);
>  target_ulong riscv_load_firmware(const char *firmware_filename,
> -                                 hwaddr firmware_load_addr);
> +                                 hwaddr firmware_load_addr,
> +                                 symbol_fn_t sym_cb);
>  target_ulong riscv_load_kernel(const char *kernel_filename,
>                                 symbol_fn_t sym_cb);
>  hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
> --
> 2.17.1
>
>

