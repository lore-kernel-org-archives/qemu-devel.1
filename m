Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC351C0650F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9214720880
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brnDH+ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9214720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hunMi-0004J6-TY
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 20:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hunMB-0003qv-1v
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hunMA-0007ms-1O
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:29:38 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hunM9-0007mM-Qj; Mon, 05 Aug 2019 20:29:37 -0400
Received: by mail-lj1-x241.google.com with SMTP id d24so80737171ljg.8;
 Mon, 05 Aug 2019 17:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X7k5HPEhC+tqeqA3jeiuHdAzU9KLZWJrT3lUZzgOOyI=;
 b=brnDH+eagOcy+pKW112BWM2ytGGIr5Vr+vMLwz5FEyeWabvKJeJHhUMfthERayJzVH
 CUMNCcn0dMoyRfp4pbctJZcRIzS+qf71a9eDoOIrrlF8VuGAlOT/yyCSlbUZrsO83XNZ
 +bonOiB+UPbHQTIpjr4vyF1rMrvyBiuT2CUr2oqtbnXKkA/d0luQOvTKLduu5VKB/gmE
 vcjg3W9hnm6g5AioVHQ7ofIzIWrWGG6cudyH+TNOx81oYKBtUya127Xl0TnExYmJlsHI
 AngrjqRLnKZhPSoUwDRx6CGC00I+KxPmMW4W0Rx+QvTh4PjZykfpsqjIfvWpPC5VVXW5
 BgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X7k5HPEhC+tqeqA3jeiuHdAzU9KLZWJrT3lUZzgOOyI=;
 b=BzgDTj0kD8zpWMFKN4W2MC0CBYQX7W3HRlDNw5xQ9wufDWi1qeABNg/qKWvEJ2vMv8
 eFmr5d0zlv1kKJn8qUhBe/mx0iE7WoK3Rts7e2a3MNAfSFhTpa8b0iW+zJ9oEULKzCoh
 /r1PiC6wRiRzdeVVJa9+oQRLjJ6OIJwacXRlbGckCfClqfzWp4pnobrdqBQeugiokgKb
 u+H2MaEIWWSISgLyMXgTdKi8B7Rg1BiHC9X9Up/Mz48U+5HdRNUKTAjO0bkPzMJBF69S
 C4oe0iPemWFvWOQ22ygzOyPMU0XXzMXDVomscd6sjXHehH92yT/RTRjJNyG/buFEZqe1
 MrsA==
X-Gm-Message-State: APjAAAUXqEUGndgUtWYW2KY92pCWJbT4zvk17dv7qeavi5TJQQTegfJQ
 dZhOV8bQi6Mn/SNj0/jAX2BJzgMLYIEtJM7VrVE=
X-Google-Smtp-Source: APXvYqyW3JmjMuYs6AR7DsUEOa/SH0Q0NikVFRYtR/+QChpW7WyxwuV9GpRxI+wkKApZGXnmThZrk+1iyFBsYkp+YLg=
X-Received: by 2002:a2e:480a:: with SMTP id v10mr225910lja.94.1565051376564;
 Mon, 05 Aug 2019 17:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
 <1565020823-24223-24-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565020823-24223-24-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2019 17:25:27 -0700
Message-ID: <CAKmqyKPa=Osu5jNcWNzt_jGbdf52KMkDjrJWdXFeDaAtU0Aw6Q@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 23/28] riscv: sifive: Move
 sifive_mmio_emulate() to a common place
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 5, 2019 at 9:08 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> sifive_mmio_emulate() is currently only used in the sifive_e machine
> codes. It can be helpful for other machines as well.
>
> Change it to an inline routine and move it to sifive_cpu.h, so that
> other machines like sifive_u can use it.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

I don't like this. I don't think we should use this function. This
seems like we can use create_unimplemented_device() instead.

Alistair

> ---
>
>  hw/riscv/sifive_e.c           |  8 --------
>  include/hw/riscv/sifive_cpu.h | 10 +++++++++-
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 2d67670..7e0fe7b 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -74,14 +74,6 @@ static const struct MemmapEntry {
>      [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
>  };
>
> -static void sifive_mmio_emulate(MemoryRegion *parent, const char *name,
> -                             uintptr_t offset, uintptr_t length)
> -{
> -    MemoryRegion *mock_mmio = g_new(MemoryRegion, 1);
> -    memory_region_init_ram(mock_mmio, NULL, name, length, &error_fatal);
> -    memory_region_add_subregion(parent, offset, mock_mmio);
> -}
> -
>  static void riscv_sifive_e_init(MachineState *machine)
>  {
>      const struct MemmapEntry *memmap = sifive_e_memmap;
> diff --git a/include/hw/riscv/sifive_cpu.h b/include/hw/riscv/sifive_cpu.h
> index 1367996..897b8f8 100644
> --- a/include/hw/riscv/sifive_cpu.h
> +++ b/include/hw/riscv/sifive_cpu.h
> @@ -1,5 +1,5 @@
>  /*
> - * SiFive CPU types
> + * SiFive CPU types and common utilities
>   *
>   * Copyright (c) 2017 SiFive, Inc.
>   * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
> @@ -28,4 +28,12 @@
>  #define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U54
>  #endif
>
> +static inline void sifive_mmio_emulate(MemoryRegion *parent, const char *name,
> +                                       uintptr_t offset, uintptr_t length)
> +{
> +    MemoryRegion *mock_mmio = g_new(MemoryRegion, 1);
> +    memory_region_init_ram(mock_mmio, NULL, name, length, &error_fatal);
> +    memory_region_add_subregion(parent, offset, mock_mmio);
> +}
> +
>  #endif /* HW_SIFIVE_CPU_H */
> --
> 2.7.4
>
>

