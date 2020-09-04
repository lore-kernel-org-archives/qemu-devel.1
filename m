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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EDCC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EB820665
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S84YiHlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EB820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFtj-0002rD-7n
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEFsr-000226-QA; Fri, 04 Sep 2020 13:52:21 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEFsp-0008Ob-U1; Fri, 04 Sep 2020 13:52:21 -0400
Received: by mail-qt1-x844.google.com with SMTP id b3so5219988qtg.13;
 Fri, 04 Sep 2020 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fprJ0PaZ2bAxGvrxX/n7pb6yxC0ZfFJucd+BZpvETr0=;
 b=S84YiHlmE4pHt5qT9kewwmA0eDiNegfOhC11mPgtbrXPnQCDQJNTndSikHsiDMq46v
 LfaRWbsYt4LtsrObzpuvNe1IqVrlcnhRJmQkE35AsVcswd2DiA6HL7o4Pu0xLqHYQ1Yt
 0I+13FDXBALlbmov/f6H0Xezn41zvpOubzWKERJMvBhmoTjq6GKIdZyq/w43FsABD5eE
 EAqx1AEpj9ooJYcyMifWUyLRWcItQcp2201Z9z3afjedF2Nc2Gmy+hWnnI1Ob/Ae5N5o
 M/xaltfXHHIKyZWV1MtOVVimefboebSofHGf9zh2ZZABOtFhwanXAi0MIZfRSh68TORs
 2FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fprJ0PaZ2bAxGvrxX/n7pb6yxC0ZfFJucd+BZpvETr0=;
 b=R1TnSRrEwnizjjmFVGqvMexur7s9m0XUPHB+QTt2Njus8aWccBluQXvK2Kbrhoea9w
 /wpKYrAI0kx1L2sNUU4V0gjce4JQKHQLlXEgYhp/U8YZ8A2F3lGj+EiW0vwMgiwRk0Jv
 Mx+qOmdM6AW/KBtkfb8LH+MTvxhLNKR+kqh29gjFYchXe/4Q98siDN2IkrWFitiUYMRm
 j239RE7Il33zcV5X4Zysln0hu6463ideqTczZnlohDIaRvOvddLF1SKrB0cCOwPgsIUf
 Js6U5MLr1Mn9EwjuJR8mk4Y+iGhB5VT3vERPLeRSFwlAeXUA3bDU/h8YXdF7URiYBTyS
 b8Ew==
X-Gm-Message-State: AOAM531AiTmg3cTZQhFidu8C+0BPyynRpvWiOSaP0lMKdjNEWrYrt83q
 1X91O1qAB1MoCbJWEtCrJ61Z2h7X7VR5vhJm1sQ=
X-Google-Smtp-Source: ABdhPJyyk1NrlCZiSgSTjzVTC1/6R72rfXtfmvAVGI4EoAhmHEM7ay2Fikcy0AGiIyv6rcz8uMx5z9RiOjS9ot7m3Lg=
X-Received: by 2002:ac8:2ab1:: with SMTP id b46mr7064063qta.76.1599241938015; 
 Fri, 04 Sep 2020 10:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
 <1599129623-68957-10-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1599129623-68957-10-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 10:41:23 -0700
Message-ID: <CAKmqyKMt1MpkJ+GPCHV5dCDwwUfn5AEO6AUhf6oL3qBOZMZk7g@mail.gmail.com>
Subject: Re: [PATCH 09/12] hw/riscv: Move sifive_test model to hw/misc
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=alistair23@gmail.com; helo=mail-qt1-x844.google.com
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

On Thu, Sep 3, 2020 at 3:46 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This is an effort to clean up the hw/riscv directory. Ideally it
> should only contain the RISC-V SoC / machine codes plus generic
> codes. Let's move sifive_test model to hw/misc directory.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  include/hw/{riscv => misc}/sifive_test.h | 0
>  hw/{riscv => misc}/sifive_test.c         | 2 +-
>  hw/riscv/virt.c                          | 2 +-
>  hw/misc/Kconfig                          | 3 +++
>  hw/misc/meson.build                      | 1 +
>  hw/riscv/Kconfig                         | 1 +
>  hw/riscv/meson.build                     | 1 -
>  7 files changed, 7 insertions(+), 3 deletions(-)
>  rename include/hw/{riscv => misc}/sifive_test.h (100%)
>  rename hw/{riscv => misc}/sifive_test.c (98%)
>
> diff --git a/include/hw/riscv/sifive_test.h b/include/hw/misc/sifive_test.h
> similarity index 100%
> rename from include/hw/riscv/sifive_test.h
> rename to include/hw/misc/sifive_test.h
> diff --git a/hw/riscv/sifive_test.c b/hw/misc/sifive_test.c
> similarity index 98%
> rename from hw/riscv/sifive_test.c
> rename to hw/misc/sifive_test.c
> index 0c78fb2..45d9399 100644
> --- a/hw/riscv/sifive_test.c
> +++ b/hw/misc/sifive_test.c
> @@ -25,7 +25,7 @@
>  #include "qemu/module.h"
>  #include "sysemu/runstate.h"
>  #include "hw/hw.h"
> -#include "hw/riscv/sifive_test.h"
> +#include "hw/misc/sifive_test.h"
>
>  static uint64_t sifive_test_read(void *opaque, hwaddr addr, unsigned int size)
>  {
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 0caab8e..41bd2f3 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -30,12 +30,12 @@
>  #include "hw/char/serial.h"
>  #include "target/riscv/cpu.h"
>  #include "hw/riscv/riscv_hart.h"
> -#include "hw/riscv/sifive_test.h"
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/boot.h"
>  #include "hw/riscv/numa.h"
>  #include "hw/intc/sifive_clint.h"
>  #include "hw/intc/sifive_plic.h"
> +#include "hw/misc/sifive_test.h"
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/device_tree.h"
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index fa3d0f4..3185456 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -134,6 +134,9 @@ config MAC_VIA
>  config AVR_POWER
>      bool
>
> +config SIFIVE_TEST
> +    bool
> +
>  config SIFIVE_E_PRCI
>      bool
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 018a88c..bd24132 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -22,6 +22,7 @@ softmmu_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
>  softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
>
>  # RISC-V devices
> +softmmu_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
>  softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
>  softmmu_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
>  softmmu_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index a046157..8e07100 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -61,6 +61,7 @@ config RISCV_VIRT
>      select SIFIVE
>      select SIFIVE_CLINT
>      select SIFIVE_PLIC
> +    select SIFIVE_TEST
>
>  config MICROCHIP_PFSOC
>      bool
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index da32148..3cf9380 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -4,7 +4,6 @@ riscv_ss.add(files('numa.c'))
>  riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
> -riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
> --
> 2.7.4
>
>

