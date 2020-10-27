Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F0AC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 20:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462D720791
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 20:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWGM/oVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462D720791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXVqV-0002Oj-36
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 16:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXVpa-0001bK-IR; Tue, 27 Oct 2020 16:44:34 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:43327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXVpY-00076f-MP; Tue, 27 Oct 2020 16:44:34 -0400
Received: by mail-il1-x143.google.com with SMTP id k1so2737780ilc.10;
 Tue, 27 Oct 2020 13:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=geKCiEuVs4Vr5RFHereyk+gtB55kHNUfsY0dTfRlKTU=;
 b=IWGM/oVbSNgJ4SPQ0iYUo96HuJjPDiDezcjt1bWKy01J9BJHWEo8VkwYyxAOOQ+egt
 PUWYxcoS/b+n9GJtEhRw2yZqBWPnKITadQGwAAhCo0U3pr2jH/K1lT0HJ2VklAjQ1Oh5
 DJchF2rTHZJrzqxcLZLGkW+CKfY7i6BR4LQylSGy4nn7cAfCU+8KQG/TAt1Oj/ViWl0d
 R9S8+ujgqDJNyMjHFLFlUq/lMQyFX1O+6j7D6o1hPcTI9mRgMs+Y0P0PdNwtzUxFq6C6
 3NTA1RKzC8d2qZGwkC31P9Nu7J9fm6gGQUeTgCZvn+9QB+h2sWTMHCMs7fmrt7mjD9AN
 3Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=geKCiEuVs4Vr5RFHereyk+gtB55kHNUfsY0dTfRlKTU=;
 b=KBRJa7/xsDjiAUqoNHL5rNYKzgLTOtHyZu0nCCHSPem8fYRCbnoTVo12xvRoEIqRjT
 u5Tz91CGxAzvWdJmuLbYPLBb5ATPWWrX3xU/5GnSrS2m6c1mycuJClW5smB/I2ln0NFx
 joRPQMzMzju9ZFz4z4uHgMJF/nSDjemU4/2V4uH9x7KZoxxyyRnUSuJdSopGoAKK9sAg
 WWOA2m4TiARj32JC8Igkp3ervJX9IDZ/AviNxQBvgO1ozstZpTebcvU1tJ/3anO6SmNR
 njQXGTfIb0zJc9vD+qiIbgQIyldX5NL/dsfcIa87lHETKyldQMdoOj+6xcY3oCWeVOOG
 4iGQ==
X-Gm-Message-State: AOAM533bQHA6dEJ4DAfI9TV1nxzjyuU1D6QtRTrPofEFAKsNgcAwZZ5H
 78Js0WPR1PuTGcz3LJE7XqmpnT5Kfjfb4Y3SMEI=
X-Google-Smtp-Source: ABdhPJwnqLZsLikrq+Hmvm9NLslm4HdoWMQ4BnKfLW2n0tA+GJETTLLbMb1eCw5FGI0UgjDSbbcVpx/TWZors3eW29M=
X-Received: by 2002:a05:6e02:c:: with SMTP id
 h12mr3585818ilr.177.1603831470526; 
 Tue, 27 Oct 2020 13:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201026212853.92880-1-keithp@keithp.com>
 <20201026212853.92880-2-keithp@keithp.com>
In-Reply-To: <20201026212853.92880-2-keithp@keithp.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Oct 2020 13:32:40 -0700
Message-ID: <CAKmqyKPFAz=UhDAYC7frbeNgPOUYST_wcKO5u_5hugwRRZanMg@mail.gmail.com>
Subject: Re: [PATCH 1/4] semihosting: Move ARM semihosting code to shared
 directories
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
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

On Mon, Oct 26, 2020 at 2:34 PM Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> This commit renames two files which provide ARM semihosting support so
> that they can be shared by other architectures:
>
>  1. target/arm/arm-semi.c     -> hw/semihosting/common-semi.c
>  2. linux-user/arm/semihost.c -> linux-user/semihost.c
>
> The build system was modified to reflect this change, but the contents
> of the two files are unchanged.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/arm/arm-semi.c => hw/semihosting/common-semi.c | 0
>  hw/semihosting/meson.build                            | 2 ++
>  linux-user/arm/meson.build                            | 3 ---
>  linux-user/meson.build                                | 2 ++
>  linux-user/{arm => }/semihost.c                       | 0
>  target/arm/meson.build                                | 2 --
>  6 files changed, 4 insertions(+), 5 deletions(-)
>  rename target/arm/arm-semi.c => hw/semihosting/common-semi.c (100%)
>  rename linux-user/{arm => }/semihost.c (100%)
>
> diff --git a/target/arm/arm-semi.c b/hw/semihosting/common-semi.c
> similarity index 100%
> rename from target/arm/arm-semi.c
> rename to hw/semihosting/common-semi.c
> diff --git a/hw/semihosting/meson.build b/hw/semihosting/meson.build
> index f40ac574c4..fbd2841e59 100644
> --- a/hw/semihosting/meson.build
> +++ b/hw/semihosting/meson.build
> @@ -2,3 +2,5 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
>    'config.c',
>    'console.c',
>  ))
> +
> +specific_ss.add(when: 'CONFIG_TCG', if_true: files ('common-semi.c'))
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
> index 2b94e4ba24..2fdd12cee5 100644
> --- a/linux-user/meson.build
> +++ b/linux-user/meson.build
> @@ -17,6 +17,8 @@ linux_user_ss.add(rt)
>  linux_user_ss.add(when: 'TARGET_HAS_BFLT', if_true: files('flatload.c'))
>  linux_user_ss.add(when: 'TARGET_I386', if_true: files('vm86.c'))
>
> +linux_user_ss.add(when: 'TARGET_AARCH64', if_true: files('semihost.c'))
> +linux_user_ss.add(when: 'TARGET_ARM', if_true: files('semihost.c'))
>
>  syscall_nr_generators = {}
>
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

