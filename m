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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09381C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5880D20665
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAkYmUU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5880D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFd9-0005Fv-7k
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEFcN-0004mo-A5; Fri, 04 Sep 2020 13:35:19 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:38127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEFcL-0006JD-FG; Fri, 04 Sep 2020 13:35:18 -0400
Received: by mail-qv1-xf42.google.com with SMTP id x7so3398074qvi.5;
 Fri, 04 Sep 2020 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=at1s6EaHojkmloPxxcNCr1MyzhednyNzJ4U7vYLY1+s=;
 b=LAkYmUU2S2IQyurHQxkpjgd9HhIrQn5MKdsd4cyycJ4pZbnzEZQUhQRz9DWZsC9OEI
 7uE6CQTmYZmYZ1bUiKhrz+oSKfCI/mgMv+EJ1akh5lAiN1pK+8vtEBYiLp/mQyDXc88u
 YGkJszyMndUSdNHnOUG2vMciUMqRUnJnNk51SoA8vnDHCizMl90W2gtWl8V7zjVPYVgG
 muNU7VtxD3EaHd39Mn+IGtwJneCLUyuGuP/SBhkFVmurAgkKlVKpctEIwuDyU29nAc/9
 S9koq6GhVkB0/d81PW4Zo7+xdTw+an2JpAUDVUcqbnAwc8KyWTpNgiP0ptbTpfW9pi5h
 tSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=at1s6EaHojkmloPxxcNCr1MyzhednyNzJ4U7vYLY1+s=;
 b=uVsZ19VAXRd4ns8Ke9ec89ImXwqy5AzCPS8DqPWyz88gTzirtGgo+Rh/lDP277tbmJ
 OTl7zluc23fNUwkwJ/DULuPU3FrcsmAPrGDpYvrXoU6TdIUgiit+AbvShM/EkVbVoTRB
 16IMqTy61qAqjODkmX7S/1oOKdjrgFIx4xlM/Z+0NeaPGW5KXtTI5KmAMEL979xY6ZAX
 DBuwnkB1/UGmfHBlix/vjlSqtGx9ya1toW2FNvOAy5/pPz3bf2oy1b6jIE7bwQ/gBuUm
 woAjvwT7Kh6eA5bnX3cm4EIcudGMmnYNfFy1iX9HHdABdKs4t8XIKiDNpXHEBJZf9Ky6
 oizw==
X-Gm-Message-State: AOAM530i7fgetHtZZkkFqMaP/mB81LzI4SIu4uOiam0wF1RL0Ly9/K+g
 0DKWypRn77ObQ3EN7hDiFCHWi7cy+wSL6tpojtg=
X-Google-Smtp-Source: ABdhPJyvvgNz0d3HqR4R1Kak17OQKz7gpjsdZYNe+fWQc9skq1kY8PqSC28BAiWiJ4iagoMdQ7I+7jmTfO181Kc/BFE=
X-Received: by 2002:a05:6214:1784:: with SMTP id
 ct4mr8001974qvb.10.1599240915620; 
 Fri, 04 Sep 2020 10:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
 <1599129623-68957-2-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1599129623-68957-2-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 10:24:20 -0700
Message-ID: <CAKmqyKMFu3dZ0JO9xvwo7BYi6ptyV6r5sZb53r-HAww6u9-H1g@mail.gmail.com>
Subject: Re: [PATCH 01/12] hw/riscv: Move sifive_e_prci model to hw/misc
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=alistair23@gmail.com; helo=mail-qv1-xf42.google.com
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

On Thu, Sep 3, 2020 at 3:42 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This is an effort to clean up the hw/riscv directory. Ideally it
> should only contain the RISC-V SoC / machine codes plus generic
> codes. Let's move sifive_e_prci model to hw/misc directory.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  include/hw/{riscv => misc}/sifive_e_prci.h | 0
>  hw/{riscv => misc}/sifive_e_prci.c         | 2 +-
>  hw/riscv/sifive_e.c                        | 2 +-
>  hw/misc/Kconfig                            | 3 +++
>  hw/misc/meson.build                        | 3 +++
>  hw/riscv/Kconfig                           | 1 +
>  hw/riscv/meson.build                       | 1 -
>  7 files changed, 9 insertions(+), 3 deletions(-)
>  rename include/hw/{riscv => misc}/sifive_e_prci.h (100%)
>  rename hw/{riscv => misc}/sifive_e_prci.c (99%)
>
> diff --git a/include/hw/riscv/sifive_e_prci.h b/include/hw/misc/sifive_e_prci.h
> similarity index 100%
> rename from include/hw/riscv/sifive_e_prci.h
> rename to include/hw/misc/sifive_e_prci.h
> diff --git a/hw/riscv/sifive_e_prci.c b/hw/misc/sifive_e_prci.c
> similarity index 99%
> rename from hw/riscv/sifive_e_prci.c
> rename to hw/misc/sifive_e_prci.c
> index 17dfa74..8ec4ee4 100644
> --- a/hw/riscv/sifive_e_prci.c
> +++ b/hw/misc/sifive_e_prci.c
> @@ -24,7 +24,7 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "hw/hw.h"
> -#include "hw/riscv/sifive_e_prci.h"
> +#include "hw/misc/sifive_e_prci.h"
>
>  static uint64_t sifive_e_prci_read(void *opaque, hwaddr addr, unsigned int size)
>  {
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 36ccfb2..7f43ed9 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -43,8 +43,8 @@
>  #include "hw/riscv/sifive_clint.h"
>  #include "hw/riscv/sifive_uart.h"
>  #include "hw/riscv/sifive_e.h"
> -#include "hw/riscv/sifive_e_prci.h"
>  #include "hw/riscv/boot.h"
> +#include "hw/misc/sifive_e_prci.h"
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 92c397c..5073986 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -134,4 +134,7 @@ config MAC_VIA
>  config AVR_POWER
>      bool
>
> +config SIFIVE_E_PRCI
> +    bool
> +
>  source macio/Kconfig
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index e1576b8..b6b2e57 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -21,6 +21,9 @@ softmmu_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
>  # Mac devices
>  softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
>
> +# RISC-V devices
> +softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
> +
>  # PKUnity SoC devices
>  softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_pm.c'))
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e53ab1e..5855e99 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -15,6 +15,7 @@ config SIFIVE_E
>      bool
>      select HART
>      select SIFIVE
> +    select SIFIVE_E_PRCI
>      select UNIMP
>
>  config SIFIVE_U
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index cf1aa99..d73ea99 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -10,7 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_plic.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
> -riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e_prci.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u_otp.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u_prci.c'))
> --
> 2.7.4
>
>

