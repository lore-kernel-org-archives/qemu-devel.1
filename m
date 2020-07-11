Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1BBC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE14206F4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faXNdFoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE14206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juJP5-0002V0-GH
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1juJOS-0001l1-NN; Sat, 11 Jul 2020 13:34:32 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1juJOQ-0001Iv-Tm; Sat, 11 Jul 2020 13:34:32 -0400
Received: by mail-io1-xd43.google.com with SMTP id i4so9256229iov.11;
 Sat, 11 Jul 2020 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pJKbhCYt/hDoahS1RbD5LBHrBWpJpazO8Ppdjj/swjQ=;
 b=faXNdFoQdXzTsgPTykXwyWDN7OPtx5Ouidf+zcLIin1ePsYppkPI1gRq0tIYLN8C92
 3dp9v2D/GZg3neqfdd6krp72tOz6gdFlL9clNVVj1sFml+U64TP61Wd6oA2B4SlTnbsd
 x/SgkmF5yaM3BC5mjoZe/t/SE5xLedaGHHgnZi7YQCtwjVjxkIlJ+bQYLmMiwp1wdJbn
 dm2o+SzEwdJviGjQZXtRSdZhALxxkjP74NuZVtLjNqGPEymYV1dVoF8Hek7TtUvAHegV
 he+Hi1QuY4CJsetimZm/SZxIV34u5sDTen1GjbH5c60olr9Fvft478q4L3hsJA28bxyE
 zLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pJKbhCYt/hDoahS1RbD5LBHrBWpJpazO8Ppdjj/swjQ=;
 b=UIbgpmmKFyB+WJ/rN/h0mm4/dbcDTKi+5sCvuoxYysmewH9PvXLxcWoAxLdND9sUo2
 o8h3QWQ/zCDA9N94Shb9TV75fJ6oY/GrkOxQgl3C3ztl5aEus9QisFKnE2CNwIEUNcve
 gWERwoUaGCPbaSMM1uXfzadAOZCpEB1WQrT7sco5J+145eoRdl42oIsKSe7Qh1CF1WTg
 6JxGdRon2RtTOIkfxowRg6RMu0hLbUj4zwJq7NQZ/BNLDmmMzOTlwDWsZtLQSL5NTVYR
 vpM/j2jnSN/W6oexRZZ0jRe9nxWdTloWDWbeY6DnZ3pR8/QJIYIC8TjvLeqnK4d7AdnO
 LQhA==
X-Gm-Message-State: AOAM533tZVbahd98qzn0MUnuPVB0I+h+tdPGx5zsyW7BKGrCZnCtIy2P
 /8TLG1gUBpjmlNRAPdcvIP0HHY7CR5vPac36Ox0=
X-Google-Smtp-Source: ABdhPJyBxPvvvs0fqS6O+rmWb1QOSEydwuspryiGFVtns0qNQ7syEmqbJDc0/6L6VIha9FpsSt0JSrFTBADm2SSkZdc=
X-Received: by 2002:a02:1a06:: with SMTP id 6mr85644875jai.8.1594488869336;
 Sat, 11 Jul 2020 10:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
 <1594357499-29068-5-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1594357499-29068-5-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sat, 11 Jul 2020 10:24:34 -0700
Message-ID: <CAKmqyKM1m2j15ncbcW0rp5fk6FmbJ20uWOYUC40+v9PG=Hu7yQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] hw/riscv: Use pre-built bios image of generic
 platform for virt & sifive_u
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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

On Thu, Jul 9, 2020 at 10:07 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Update virt and sifive_u machines to use the opensbi fw_dynamic bios
> image built for the generic FDT platform.
>
> Remove the out-of-date no longer used bios images.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

This patch seems to break 32-bit Linux boots on the sifive_u and virt machines.

Alistair

>
> ---
>
> Changes in v4:
> - Remove old binaries in the Makefile for `make install` bisection
>
> Changes in v3:
> - Change to fw_dynamic.bin for virt & sifive_u
>
>  Makefile                                       |   4 +---
>  hw/riscv/sifive_u.c                            |   4 ++--
>  hw/riscv/virt.c                                |   4 ++--
>  pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 0 -> 62144 bytes
>  pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin   | Bin 49520 -> 0 bytes
>  pc-bios/opensbi-riscv32-virt-fw_jump.bin       | Bin 49504 -> 0 bytes
>  pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 0 -> 70792 bytes
>  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin   | Bin 57936 -> 0 bytes
>  pc-bios/opensbi-riscv64-virt-fw_jump.bin       | Bin 57920 -> 0 bytes
>  9 files changed, 5 insertions(+), 7 deletions(-)
>  create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
>  delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
>  delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
>  create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
>  delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>  delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
>
> diff --git a/Makefile b/Makefile
> index b1b8a5a..f06b3ae 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -840,9 +840,7 @@ palcode-clipper \
>  u-boot.e500 u-boot-sam460-20100605.bin \
>  qemu_vga.ndrv \
>  edk2-licenses.txt \
> -hppa-firmware.img \
> -opensbi-riscv32-sifive_u-fw_jump.bin opensbi-riscv32-virt-fw_jump.bin \
> -opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
> +hppa-firmware.img
>
>
>  DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index b434fd3..dc46f64 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -60,9 +60,9 @@
>  #include <libfdt.h>
>
>  #if defined(TARGET_RISCV32)
> -# define BIOS_FILENAME "opensbi-riscv32-sifive_u-fw_jump.bin"
> +# define BIOS_FILENAME "opensbi-riscv32-generic-fw_dynamic.bin"
>  #else
> -# define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
> +# define BIOS_FILENAME "opensbi-riscv64-generic-fw_dynamic.bin"
>  #endif
>
>  static const struct MemmapEntry {
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 85e17fe..5ca49c5 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -43,9 +43,9 @@
>  #include "hw/pci-host/gpex.h"
>
>  #if defined(TARGET_RISCV32)
> -# define BIOS_FILENAME "opensbi-riscv32-virt-fw_jump.bin"
> +# define BIOS_FILENAME "opensbi-riscv32-generic-fw_dynamic.bin"
>  #else
> -# define BIOS_FILENAME "opensbi-riscv64-virt-fw_jump.bin"
> +# define BIOS_FILENAME "opensbi-riscv64-generic-fw_dynamic.bin"
>  #endif
>
>  static const struct MemmapEntry {
> diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
> new file mode 100644
> index 0000000..23b4dfb
> Binary files /dev/null and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
> diff --git a/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
> deleted file mode 100644
> index 3e0da54..0000000
> Binary files a/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin and /dev/null differ
> diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi-riscv32-virt-fw_jump.bin
> deleted file mode 100644
> index bc56ed6..0000000
> Binary files a/pc-bios/opensbi-riscv32-virt-fw_jump.bin and /dev/null differ
> diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
> new file mode 100644
> index 0000000..16c0cf4
> Binary files /dev/null and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
> diff --git a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> deleted file mode 100644
> index 1acee86..0000000
> Binary files a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin and /dev/null differ
> diff --git a/pc-bios/opensbi-riscv64-virt-fw_jump.bin b/pc-bios/opensbi-riscv64-virt-fw_jump.bin
> deleted file mode 100644
> index c62f2b4..0000000
> Binary files a/pc-bios/opensbi-riscv64-virt-fw_jump.bin and /dev/null differ
> --
> 2.7.4
>
>

