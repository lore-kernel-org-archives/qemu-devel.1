Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54513C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 23:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56BB206B2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 23:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDUJhjcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56BB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcGeH-0003JL-QL
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 18:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kcGbp-0002En-4v; Mon, 09 Nov 2020 18:30:04 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:39363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kcGbn-0003xW-7d; Mon, 09 Nov 2020 18:30:00 -0500
Received: by mail-il1-x141.google.com with SMTP id q1so9967431ilt.6;
 Mon, 09 Nov 2020 15:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9zhmEwHuPdfGZDmJDkilGO+uesabvVPYWIlifT6IxQw=;
 b=PDUJhjcb10gs6MU7sTR3MUaHkX7Xc2HC8UWp0y+8ocZoE4XQFREbTMNfVzc/GU0/OG
 5SOJS2eo4VoIM63lEnHGpqHLhjGjv9uG/6xHOvXqSGuHyNSk8AiDrHxOrl2upOx9N612
 2+MGSTftdWVs93nFEFkoHjc/Lkahwn2c/Bcoge4jSlc577TghsaBjA6I+ihE7J2gcJjy
 0dju29dQ0GtGPe+AnS53v+whIjQx0moCD3aS5dIoReCfHoznaLegBrflQjYWtJ2xTgvP
 1+XtjJYbe3EP3vn2oyOaqEj3exgq9rnLKQ5M5tLWMqC4PVo4aNWfMrd0WIOXVqVYiKK+
 pFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9zhmEwHuPdfGZDmJDkilGO+uesabvVPYWIlifT6IxQw=;
 b=tJ6dhAldGrg09Uzo5XGckRIfXKOirQLekOliqf+GKTmLWDZ6yiF+8DnWb8SDMs5uXb
 pyTPt+kc7RV2JHDeRBop5G+ddJH4Di9F2Odo1DdpXzj5dhiIAqyKtWr28TG/o9Cdh++W
 ZNvHz/t8NzX9cjBBtGXgZ17cmP3PJHTxjLxGruf2+Z6xGewP//Q7O3W1dS7BEgqVeQK2
 GVfAodw03xOuMi+ok4fSm/wvaLE6X0Khd5gzIDsLL+LpwDj2SbJg0Ax1ZfGvdiN4/Iwu
 fTBYydF+sz1a4IgixDV6oaLxANjQ0CuXVIeZIAliB0lJW4w1Hhw2+1oi2hWGwDpgj4ju
 YkjQ==
X-Gm-Message-State: AOAM532BSibz1a3Zi7mVEpDEIm2AeJ5tCQlW4Xs0P7y2yA2kNl+rRFyS
 5inr8fXbdyJrkhgSqJgjPhA/Cn4slF3OoYO85hY=
X-Google-Smtp-Source: ABdhPJzLVHEAPyidN5FJxvybj3CMMiz4wDCiBMadBkmSLsd3zfxzCSbEswT8McDGzWPjhhvfLRqcf7LUKS24JuYhXtI=
X-Received: by 2002:a92:c5ce:: with SMTP id s14mr12298087ilt.40.1604964596913; 
 Mon, 09 Nov 2020 15:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20201028185722.2783532-1-keithp@keithp.com>
 <20201028185722.2783532-2-keithp@keithp.com>
In-Reply-To: <20201028185722.2783532-2-keithp@keithp.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Nov 2020 15:17:56 -0800
Message-ID: <CAKmqyKP1kiitjexn9jPxNq=qrC3sm88++a_LF5rjNEcxiU1C=w@mail.gmail.com>
Subject: Re: [PATCH 1/4] semihosting: Move ARM semihosting code to shared
 directories [v3]
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm <qemu-arm@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 28, 2020 at 11:57 AM Keith Packard via
<qemu-devel@nongnu.org> wrote:
>
> This commit renames two files which provide ARM semihosting support so
> that they can be shared by other architectures:
>
>  1. target/arm/arm-semi.c     -> hw/semihosting/common-semi.c
>  2. linux-user/arm/semihost.c -> linux-user/semihost.c
>
> The build system was modified use a new config variable,
> CONFIG_ARM_COMPATIBLE_SEMIHOSTING, which has been added to the ARM
> softmmu and linux-user default configs. The contents of the source
> files has not been changed in this patch.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ----
>
> v2
>         Place common-semi.c name in arm_ss, just as arm-semi.c was
>
> v3
>         Create CONFIG_ARM_COMPATIBLE_SEMIHOSTING and assign in
>         arm config files
> ---
>  default-configs/devices/arm-softmmu.mak               | 1 +
>  default-configs/targets/aarch64-linux-user.mak        | 1 +
>  default-configs/targets/arm-linux-user.mak            | 1 +
>  hw/semihosting/Kconfig                                | 3 +++
>  target/arm/arm-semi.c => hw/semihosting/common-semi.c | 0
>  hw/semihosting/meson.build                            | 3 +++
>  linux-user/arm/meson.build                            | 3 ---
>  linux-user/meson.build                                | 1 +
>  linux-user/{arm => }/semihost.c                       | 0
>  target/arm/meson.build                                | 2 --
>  10 files changed, 10 insertions(+), 5 deletions(-)
>  rename target/arm/arm-semi.c => hw/semihosting/common-semi.c (100%)
>  rename linux-user/{arm => }/semihost.c (100%)
>
> diff --git a/default-configs/devices/arm-softmmu.mak b/default-configs/devices/arm-softmmu.mak
> index 08a32123b4..0500156a0c 100644
> --- a/default-configs/devices/arm-softmmu.mak
> +++ b/default-configs/devices/arm-softmmu.mak
> @@ -42,4 +42,5 @@ CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
>  CONFIG_SEMIHOSTING=y
> +CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
>  CONFIG_ALLWINNER_H3=y
> diff --git a/default-configs/targets/aarch64-linux-user.mak b/default-configs/targets/aarch64-linux-user.mak
> index 163c9209f4..4713253709 100644
> --- a/default-configs/targets/aarch64-linux-user.mak
> +++ b/default-configs/targets/aarch64-linux-user.mak
> @@ -2,3 +2,4 @@ TARGET_ARCH=aarch64
>  TARGET_BASE_ARCH=arm
>  TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
>  TARGET_HAS_BFLT=y
> +CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
> diff --git a/default-configs/targets/arm-linux-user.mak b/default-configs/targets/arm-linux-user.mak
> index c7cd872e86..e741ffd4d3 100644
> --- a/default-configs/targets/arm-linux-user.mak
> +++ b/default-configs/targets/arm-linux-user.mak
> @@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common,oabi
>  TARGET_SYSTBL=syscall.tbl
>  TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
>  TARGET_HAS_BFLT=y
> +CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
> diff --git a/hw/semihosting/Kconfig b/hw/semihosting/Kconfig
> index efe0a30734..4c30dc6b16 100644
> --- a/hw/semihosting/Kconfig
> +++ b/hw/semihosting/Kconfig
> @@ -1,3 +1,6 @@
>
>  config SEMIHOSTING
>         bool
> +
> +config ARM_COMPATIBLE_SEMIHOSTING
> +       bool
> diff --git a/target/arm/arm-semi.c b/hw/semihosting/common-semi.c
> similarity index 100%
> rename from target/arm/arm-semi.c
> rename to hw/semihosting/common-semi.c
> diff --git a/hw/semihosting/meson.build b/hw/semihosting/meson.build
> index f40ac574c4..5b4a170270 100644
> --- a/hw/semihosting/meson.build
> +++ b/hw/semihosting/meson.build
> @@ -2,3 +2,6 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
>    'config.c',
>    'console.c',
>  ))
> +
> +specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
> +               if_true: files('common-semi.c'))
> diff --git a/linux-user/arm/meson.build b/linux-user/arm/meson.build
> index 432984b58e..5a93c925cf 100644
> --- a/linux-user/arm/meson.build
> +++ b/linux-user/arm/meson.build
> @@ -1,6 +1,3 @@
> -linux_user_ss.add(when: 'TARGET_AARCH64', if_true: files('semihost.c'))
> -linux_user_ss.add(when: 'TARGET_ARM', if_true: files('semihost.c'))
> -
>  subdir('nwfpe')
>
>  syscall_nr_generators += {
> diff --git a/linux-user/meson.build b/linux-user/meson.build
> index 2b94e4ba24..7fe28d659e 100644
> --- a/linux-user/meson.build
> +++ b/linux-user/meson.build
> @@ -16,6 +16,7 @@ linux_user_ss.add(rt)
>
>  linux_user_ss.add(when: 'TARGET_HAS_BFLT', if_true: files('flatload.c'))
>  linux_user_ss.add(when: 'TARGET_I386', if_true: files('vm86.c'))
> +linux_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING', if_true: files('semihost.c'))
>
>
>  syscall_nr_generators = {}
> diff --git a/linux-user/arm/semihost.c b/linux-user/semihost.c
> similarity index 100%
> rename from linux-user/arm/semihost.c
> rename to linux-user/semihost.c
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index f5de2a77b8..15b936c101 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -32,8 +32,6 @@ arm_ss.add(files(
>  ))
>  arm_ss.add(zlib)
>
> -arm_ss.add(when: 'CONFIG_TCG', if_true: files('arm-semi.c'))
> -
>  arm_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c', 'kvm64.c'), if_false: files('kvm-stub.c'))
>
>  arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
> --
> 2.28.0
>
>

