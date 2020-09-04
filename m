Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CEDC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41573204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5ChZWSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41573204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFpu-0000Vx-1g
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEFoS-0006zO-HS; Fri, 04 Sep 2020 13:47:48 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:43801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEFoQ-0007tk-OM; Fri, 04 Sep 2020 13:47:48 -0400
Received: by mail-qk1-x741.google.com with SMTP id o64so7065717qkb.10;
 Fri, 04 Sep 2020 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1vrpxo0tGaiVeVzzMdwlpzTmytl519Go3H/uu2kk5OE=;
 b=I5ChZWSuWWnAAFS1DSUF1CwDA00lfmllMlpecxLl5Xh1aXMk3YhLqMdEe+cdvU/+CB
 xk3S2eJY8iXphA9UMNOCZbnm3g5Z0Qcv/YIOVXaClBipgMUEwIMS36SwLY0SaxsmHjVm
 f/d0gaJgN+07o4xFjyVJiIdTzYgkDU+eLxGe0Cexoo6iFaX7atSAsAklQRlqZn2fcsMt
 s1vztU5znIeuAK7g2k0o8Gs99ZP0uyPOq/Jb5GlPZ/tVb3A1i3TjZIkUZCUT6bvXx4da
 hjs4wkUdgoCDJFwqctUuXd3JxC0nbtaM7tNdm1oO+wvoJcB5upDvX76LxbAh2vpJx38+
 OFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1vrpxo0tGaiVeVzzMdwlpzTmytl519Go3H/uu2kk5OE=;
 b=Hqk2HCBfExXddeQ5fa/QzIeVrqsBEez1YFeQqI+FmFHb2qWHldywX5+vnSKqRuqpMM
 5cwHtnO8S2EySjk2DPoOHra65LPTg3qDKhDCWrgh3+pw60xLeQcnG7NRTqC5kejA8DJB
 UXUygPIP/xaarv0Tyap4lxahdwmhW8dpOESxoP/WWEuhUDdIGqf+3eRZp3twllkO/G1b
 RGmWcTCTHMjhtknc5NH4/Bmhw9jl/cjo/XhWLSgPSxG7JchkKZLQfiNT5G0ttfN70Sf2
 vIC8YMrydREZj6UWwttXe3AAPncIl7wBti1Z1+O3OM0CuVzq4sMWPbHQCa7UdmS6ZdZW
 cpoA==
X-Gm-Message-State: AOAM5315RTqQBd7VyhH+VLEIO2bT+Lku7hP/gUhFyYLlLImThpzVr8PH
 mtTWCWb2+avF/jKbpZrszTemYo993QWXD7lOw10=
X-Google-Smtp-Source: ABdhPJwPHRpgVJLg5VNJwlxm6v2zr/NoZ52LzHvUIZFWX8/FkDeakQFFwLVKWoNKX/xLY/aHRPpkDLIghXPvzsEtwJg=
X-Received: by 2002:a37:a5ca:: with SMTP id o193mr9042140qke.126.1599241665426; 
 Fri, 04 Sep 2020 10:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
 <1599129623-68957-9-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1599129623-68957-9-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 10:36:50 -0700
Message-ID: <CAKmqyKMJQV5W88uU5LK4LXt-30qLNFGowdvAXqPjRSCFBSKwfg@mail.gmail.com>
Subject: Re: [PATCH 08/12] hw/riscv: Move sifive_uart model to hw/char
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x741.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bin Meng <bin.meng@windriver.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 3, 2020 at 3:48 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This is an effort to clean up the hw/riscv directory. Ideally it
> should only contain the RISC-V SoC / machine codes plus generic
> codes. Let's move sifive_uart model to hw/char directory.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  include/hw/{riscv => char}/sifive_uart.h | 0
>  hw/{riscv => char}/sifive_uart.c         | 2 +-
>  hw/riscv/sifive_e.c                      | 2 +-
>  hw/riscv/sifive_u.c                      | 2 +-
>  hw/char/Kconfig                          | 3 +++
>  hw/char/meson.build                      | 1 +
>  hw/riscv/Kconfig                         | 2 ++
>  hw/riscv/meson.build                     | 1 -
>  8 files changed, 9 insertions(+), 4 deletions(-)
>  rename include/hw/{riscv => char}/sifive_uart.h (100%)
>  rename hw/{riscv => char}/sifive_uart.c (99%)
>
> diff --git a/include/hw/riscv/sifive_uart.h b/include/hw/char/sifive_uart.h
> similarity index 100%
> rename from include/hw/riscv/sifive_uart.h
> rename to include/hw/char/sifive_uart.h
> diff --git a/hw/riscv/sifive_uart.c b/hw/char/sifive_uart.c
> similarity index 99%
> rename from hw/riscv/sifive_uart.c
> rename to hw/char/sifive_uart.c
> index 9350482..3a00ba7 100644
> --- a/hw/riscv/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -24,7 +24,7 @@
>  #include "chardev/char-fe.h"
>  #include "hw/hw.h"
>  #include "hw/irq.h"
> -#include "hw/riscv/sifive_uart.h"
> +#include "hw/char/sifive_uart.h"
>
>  /*
>   * Not yet implemented:
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 0ddcf15..40bbf53 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -39,9 +39,9 @@
>  #include "hw/misc/unimp.h"
>  #include "target/riscv/cpu.h"
>  #include "hw/riscv/riscv_hart.h"
> -#include "hw/riscv/sifive_uart.h"
>  #include "hw/riscv/sifive_e.h"
>  #include "hw/riscv/boot.h"
> +#include "hw/char/sifive_uart.h"
>  #include "hw/intc/sifive_clint.h"
>  #include "hw/intc/sifive_plic.h"
>  #include "hw/misc/sifive_e_prci.h"
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index faca2e8..4f12a93 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -46,9 +46,9 @@
>  #include "hw/misc/unimp.h"
>  #include "target/riscv/cpu.h"
>  #include "hw/riscv/riscv_hart.h"
> -#include "hw/riscv/sifive_uart.h"
>  #include "hw/riscv/sifive_u.h"
>  #include "hw/riscv/boot.h"
> +#include "hw/char/sifive_uart.h"
>  #include "hw/intc/sifive_clint.h"
>  #include "hw/intc/sifive_plic.h"
>  #include "chardev/char.h"
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 91da92f..939bc44 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -58,3 +58,6 @@ config AVR_USART
>
>  config MCHP_PFSOC_MMUART
>      bool
> +
> +config SIFIVE_UART
> +    bool
> diff --git a/hw/char/meson.build b/hw/char/meson.build
> index 3db623e..196ac91 100644
> --- a/hw/char/meson.build
> +++ b/hw/char/meson.build
> @@ -30,6 +30,7 @@ softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_uart.c'))
>  softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_uart.c'))
>  softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
>  softmmu_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'))
> +softmmu_ss.add(when: 'CONFIG_SIFIVE_UART', if_true: files('sifive_uart.c'))
>  softmmu_ss.add(when: 'CONFIG_SH4', if_true: files('sh_serial.c'))
>  softmmu_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
>  softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index a0e256c..a046157 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -15,6 +15,7 @@ config SIFIVE_E
>      select SIFIVE_CLINT
>      select SIFIVE_GPIO
>      select SIFIVE_PLIC
> +    select SIFIVE_UART
>      select SIFIVE_E_PRCI
>      select UNIMP
>
> @@ -27,6 +28,7 @@ config SIFIVE_U
>      select SIFIVE_GPIO
>      select SIFIVE_PDMA
>      select SIFIVE_PLIC
> +    select SIFIVE_UART
>      select SIFIVE_U_OTP
>      select SIFIVE_U_PRCI
>      select UNIMP
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 619bf80..da32148 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -5,7 +5,6 @@ riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
> -riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
> --
> 2.7.4
>
>

