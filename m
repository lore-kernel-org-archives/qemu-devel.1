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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1832C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E8220665
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yuc8MNgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E8220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFun-0004C0-5m
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEFtT-0002ea-GV; Fri, 04 Sep 2020 13:52:59 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:33746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEFtS-0008RN-0n; Fri, 04 Sep 2020 13:52:59 -0400
Received: by mail-qk1-x742.google.com with SMTP id p4so7156003qkf.0;
 Fri, 04 Sep 2020 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/MPGgw7TJanQsmptVlMzrhffmoYIVJZtdI1dbW8sSYE=;
 b=Yuc8MNgXK2sCgm32vAfCrFxRxXckymXbVdkuTTWfi0qyBGmavvPZIypBgFR39G6x9P
 8uFCET54HHYYSc7trSjdj1rfrvpVigzvKeZs8QEhzeT4OXIBCgf7b2hKD8uljw857xW8
 FZnA20SftmgXuRmGUNcB+/uuIib45Ws2Knew34RLGHRW+EtvwwJjFgV0teZH1qYga5GQ
 wjCJueHr9JprimLMp6kb0wlw6LtCl313xS4W5rjtRYhDpME7kjv6ZwrI/ITUuQ1/cSK9
 rOoNOSz5YuMEoSLSewZugjS7hdQPTssdMOmq8/3U14p+30jPF0I8p8o5w5WTHBMOJ2jI
 Se4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/MPGgw7TJanQsmptVlMzrhffmoYIVJZtdI1dbW8sSYE=;
 b=HKhVYdSGwLCrE7Lgo3hNuLQ8htjInRvYVi6ZZtBlR2H3wE3wXAh/SzQV+XZKKOIC1u
 K4f/pqMkBQdcQ/eWRYhkNhsuw9KfOTuslsjYOk1gbx916YMx0SvaXYSX+33YsEBhoyq5
 rms3nexamxGz94VS3SD8z/6gxT/Tdz3PJ0ENMdbOTlFPICSGkGsTV1pKtAMJJYAhBG9U
 CODxym7ZVddZSr+J8g60ehAgocqlwpMxeFB9DLl0TfC3f9LHXjVc4KjjwCbBkr45MhRv
 7B8y9nMdoExYfkVS7izQ7NOdKLBBTumHzc6blHHHaB4d19rV1ARrEOZ2ZetNg2XNX1IQ
 M2Iw==
X-Gm-Message-State: AOAM532wa03P8hb1+yTUXbsMlVqiUoBDWeqebJjdowgWDNnfYy6cFgq7
 tyaHOT/AOE0A8+NS6ASOjj3e9tRuAYyJy4fJFZ0=
X-Google-Smtp-Source: ABdhPJxVP/uYiJIfo3g/rlsYFzlwSZHMvDzevfdAUEMQkmIe4HU80chzYtpTW/fx3kNwzCiBi0Jfi+ia3IDhBMt9JPU=
X-Received: by 2002:a37:9304:: with SMTP id v4mr8612137qkd.496.1599241976799; 
 Fri, 04 Sep 2020 10:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
 <1599129623-68957-11-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1599129623-68957-11-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 10:42:02 -0700
Message-ID: <CAKmqyKPswrSd-fVggWuRt2LHVnAeQKJi_hBC7sP89Dt_24U++Q@mail.gmail.com>
Subject: Re: [PATCH 10/12] hw/riscv: Always build riscv_hart.c
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x742.google.com
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
> Every RISC-V machine needs riscv_hart hence there is no need to
> have a dedicated Kconfig option for it. Drop the Kconfig option
> and always build riscv_hart.c.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/Kconfig     | 9 ---------
>  hw/riscv/meson.build | 2 +-
>  2 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 8e07100..7d017bc 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -1,6 +1,3 @@
> -config HART
> -    bool
> -
>  config IBEX
>      bool
>
> @@ -10,7 +7,6 @@ config SIFIVE
>
>  config SIFIVE_E
>      bool
> -    select HART
>      select SIFIVE
>      select SIFIVE_CLINT
>      select SIFIVE_GPIO
> @@ -22,7 +18,6 @@ config SIFIVE_E
>  config SIFIVE_U
>      bool
>      select CADENCE
> -    select HART
>      select SIFIVE
>      select SIFIVE_CLINT
>      select SIFIVE_GPIO
> @@ -35,7 +30,6 @@ config SIFIVE_U
>
>  config SPIKE
>      bool
> -    select HART
>      select HTIF
>      select SIFIVE
>      select SIFIVE_CLINT
> @@ -44,7 +38,6 @@ config SPIKE
>  config OPENTITAN
>      bool
>      select IBEX
> -    select HART
>      select UNIMP
>
>  config RISCV_VIRT
> @@ -52,7 +45,6 @@ config RISCV_VIRT
>      imply PCI_DEVICES
>      imply TEST_DEVICES
>      select PCI
> -    select HART
>      select SERIAL
>      select GOLDFISH_RTC
>      select VIRTIO_MMIO
> @@ -65,7 +57,6 @@ config RISCV_VIRT
>
>  config MICROCHIP_PFSOC
>      bool
> -    select HART
>      select SIFIVE
>      select SIFIVE_CLINT
>      select UNIMP
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 3cf9380..dbedf9b 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -1,7 +1,7 @@
>  riscv_ss = ss.source_set()
>  riscv_ss.add(files('boot.c'))
>  riscv_ss.add(files('numa.c'))
> -riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
> +riscv_ss.add(files('riscv_hart.c'))
>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
> --
> 2.7.4
>
>

