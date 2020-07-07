Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22901C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 22:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEA12064C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 22:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2N4TUcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEA12064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jswHO-0004cT-6n
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 18:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jswGh-0004A0-Mo; Tue, 07 Jul 2020 18:40:51 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jswGf-0005jm-VV; Tue, 07 Jul 2020 18:40:51 -0400
Received: by mail-pg1-x542.google.com with SMTP id l63so20660204pge.12;
 Tue, 07 Jul 2020 15:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9sLDerCc5NAH8q3xQUvKg+J+VjEosVK7ND1jg30oabs=;
 b=L2N4TUcLqYR3b5iS4KxYVL667DQ7VR2Tzy9N1LTYVmzxMocqieadvhbJiNJe+ZzGZz
 mqbDkid+IezBwLHy2b7qBb7WZc+I/7WnFovbNQCWTA0fsviIF1FPSrDIZq8yZUH1Mzp0
 GA3eCoFHAF0XhWMadQlWaxCyZtpymvRAHQA1KkDL8M2JUlndThY9z3rQKW10/tP6ebJP
 V81rCROoMuZxoTqT/noY8MGfrTC2RlviRHvnloWcprp04NVK5ifE4RHYyEG0zZmD19vv
 /MeWbZne9QbZAK1GaIZUScNWunh+2wBR4hsod+zXhJvyVUnurIXrPnIYFRATAfxcEKJj
 s5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9sLDerCc5NAH8q3xQUvKg+J+VjEosVK7ND1jg30oabs=;
 b=ZqRgFCWYtASS7KsHZRsPK5Q6EfbUd6Ja6Yz5QTdhDI6jvo63LzoKBwwdaYcRvPhVfa
 F7mOShu8unPFXxpwEZ82Yj13rAlFvshxupBLGxH/gEIqsQwzgMzb4ggwx0ZIyewoU01v
 N9RbQ+yKaSJwugHaqTJeA6Uvr6vdjOPJJtrnGWPIGPqBPE3vw5sYmxGTA81K+dkN3kcr
 ojQ+z4JfwfOy8oZM+CQlfYFw/CafdwOipSqG3gibeUav52J53mJlRiMe8ZOqZLqpSypX
 XxOHZFcyUIO69eB90eygl/bwRLldJklKQ+lhgnZNoibJjjkzzsUtaTFt5q600k4JZhgO
 HhJQ==
X-Gm-Message-State: AOAM530Ot8OC90aZQpdWdhqM8j280Vn9v9OuRM0v/k4w1Jd+UnVqbSwV
 WBTZ1ci9JAWcsRTDHUGZQW9hAjOT808kyYiIgMSMCdlYSNs=
X-Google-Smtp-Source: ABdhPJyIOCIr83J4h7kV3uBJYjdWkZrJSR7+SVAS4fejHjuL08UoGQ3v5AfPLB/9FNeeL+KyyPPOssjuN+Og6j1rmzA=
X-Received: by 2002:a6b:8dd1:: with SMTP id
 p200mr33302860iod.118.1594157368298; 
 Tue, 07 Jul 2020 14:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <1593746287-19251-1-git-send-email-bmeng.cn@gmail.com>
 <1593746287-19251-4-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1593746287-19251-4-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jul 2020 14:19:36 -0700
Message-ID: <CAKmqyKOYsTh+wojDfJKMxm1Qwar5CvB0uTGy0wYCztWBoY9Z2A@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] roms/Makefile: Build the generic platform for
 RISC-V OpenSBI firmware
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 2, 2020 at 8:22 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> The RISC-V generic platform is a flattened device tree (FDT) based
> platform where all platform specific functionality is provided based
> on FDT passed by previous booting stage. The support was added in
> the upstream OpenSBI v0.8 release recently.
>
> Update our Makefile to build the generic platform instead of building
> virt and sifive_u separately for RISC-V OpenSBI firmware, and change
> to use fw_dynamic type images as well.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v3:
> - Change fw_jump to fw_dynamic in the make rules
>
> Changes in v2:
> - Copy the ELF images too in the make rules
>
>  roms/Makefile | 32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
>
> diff --git a/roms/Makefile b/roms/Makefile
> index f9acf39..5d9f15b 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -64,10 +64,8 @@ default help:
>         @echo "  u-boot.e500        -- update u-boot.e500"
>         @echo "  u-boot.sam460      -- update u-boot.sam460"
>         @echo "  efi                -- update UEFI (edk2) platform firmware"
> -       @echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
> -       @echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
> -       @echo "  opensbi32-sifive_u -- update OpenSBI for 32-bit sifive_u machine"
> -       @echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
> +       @echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
> +       @echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
>         @echo "  bios-microvm       -- update bios-microvm.bin (qboot)"
>         @echo "  clean              -- delete the files generated by the previous" \
>                                       "build targets"
> @@ -170,29 +168,19 @@ skiboot:
>  efi: edk2-basetools
>         $(MAKE) -f Makefile.edk2
>
> -opensbi32-virt:
> +opensbi32-generic:
>         $(MAKE) -C opensbi \
>                 CROSS_COMPILE=$(riscv32_cross_prefix) \
> -               PLATFORM="qemu/virt"
> -       cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-virt-fw_jump.bin
> +               PLATFORM="generic"
> +       cp opensbi/build/platform/generic/firmware/fw_dynamic.bin ../pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
> +       cp opensbi/build/platform/generic/firmware/fw_dynamic.elf ../pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
>
> -opensbi64-virt:
> +opensbi64-generic:
>         $(MAKE) -C opensbi \
>                 CROSS_COMPILE=$(riscv64_cross_prefix) \
> -               PLATFORM="qemu/virt"
> -       cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
> -
> -opensbi32-sifive_u:
> -       $(MAKE) -C opensbi \
> -               CROSS_COMPILE=$(riscv32_cross_prefix) \
> -               PLATFORM="sifive/fu540"
> -       cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
> -
> -opensbi64-sifive_u:
> -       $(MAKE) -C opensbi \
> -               CROSS_COMPILE=$(riscv64_cross_prefix) \
> -               PLATFORM="sifive/fu540"
> -       cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> +               PLATFORM="generic"
> +       cp opensbi/build/platform/generic/firmware/fw_dynamic.bin ../pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
> +       cp opensbi/build/platform/generic/firmware/fw_dynamic.elf ../pc-bios/opensbi-riscv64-generic-fw_dynamic.elf
>
>  bios-microvm:
>         $(MAKE) -C qboot
> --
> 2.7.4
>
>

