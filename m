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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C53C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE6E204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpnk4G6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE6E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFfi-0007ju-K2
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEFeo-0006rb-V4; Fri, 04 Sep 2020 13:37:50 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:43629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEFel-0006du-EQ; Fri, 04 Sep 2020 13:37:50 -0400
Received: by mail-qk1-x742.google.com with SMTP id o64so7031272qkb.10;
 Fri, 04 Sep 2020 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3CxgLMlPhZiuTqKRt4anlkBHmiQSgxRWjA+Kq3fnAqE=;
 b=tpnk4G6oJmZugN36snrWMBIpYYy2WNQkIoICvWhANKyUpONxGLa8s0gRFt/zcpVrET
 /TuqeC3GEQhgNTf9ibR8Y5164tdu3gbMyhLh+4Ek/jyIHg6LKk4vJJDr6+vI57hqo89C
 nCZpinly/xmS/qN9xC5/WNWw6LuMrIPHN9we5z8kEY704fFVHBMwBb10nfi7A2e34ehQ
 rgN5ciB+8WtOpgLBb7+i+h1JYJjX4PYPoyxUXRKkZkWZlDOCUhgogoC2Yc9cecRJKXaz
 ewY1RZ/X2cHI7O1+qJcaJGdWXXcIiXmxewV4ZxRi5gYF7B/FrHAcwHSwRkDT/Ahlvvj2
 Ju2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3CxgLMlPhZiuTqKRt4anlkBHmiQSgxRWjA+Kq3fnAqE=;
 b=bN1fK4aIqUw4jhl1QGcvRIbUYo/FKI+TL83YTfDxx0w/+gzb/14XizhvkMMioNPnzg
 pa97kOGKVsqtC20BX8Sp9ZYD3IMKMFTthDqgzaaeSm04dUTUqqyoSCqkk9QB3OkXfqL7
 Qsihxdcs2TDNLBJxrfo5PGszdwjVhZgtCsmjHAI6ys+t3r3LOgdOUJis0+K6h8mCVY/Q
 eOmHvnGLi1QdifrUNi9YjpHLiaYmXt9VTKRMjGMOsqqp85yZipiOlFddxabjmilXdiuN
 JVgf+5IJqhvS4+fDApLlTSpGqn3PMrm7Q8e6jg8Wz2yZpq0c+AgqXS4zZcPNHeUXHeB2
 yzMQ==
X-Gm-Message-State: AOAM5335Vb93hIuSF8Es5XZqqD48mKNb2KkxmTKU0Zkhvb3omUu0bDws
 94WTYa1TxIRBC5ll7icUxOjqa3VxD1954i+UE7k=
X-Google-Smtp-Source: ABdhPJwwtc4EcPOgGWgReKEW++Wy9W91G3SkfW3G5Y5vCMCQznpTTIV915fQvLIiklU3JhIvqThLM8GDBTZU5KmfODU=
X-Received: by 2002:ae9:f44c:: with SMTP id z12mr8982419qkl.339.1599241064054; 
 Fri, 04 Sep 2020 10:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
 <1599129623-68957-4-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1599129623-68957-4-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 10:26:49 -0700
Message-ID: <CAKmqyKPLgN-W+=A5RCZSwsCOVhRji3aNfgnPB2W=edSNsHtp1Q@mail.gmail.com>
Subject: Re: [PATCH 03/12] hw/riscv: Move sifive_u_otp model to hw/misc
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

On Thu, Sep 3, 2020 at 3:44 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This is an effort to clean up the hw/riscv directory. Ideally it
> should only contain the RISC-V SoC / machine codes plus generic
> codes. Let's move sifive_u_otp model to hw/misc directory.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  include/hw/{riscv => misc}/sifive_u_otp.h | 0
>  include/hw/riscv/sifive_u.h               | 2 +-
>  hw/{riscv => misc}/sifive_u_otp.c         | 2 +-
>  hw/misc/Kconfig                           | 3 +++
>  hw/misc/meson.build                       | 1 +
>  hw/riscv/Kconfig                          | 1 +
>  hw/riscv/meson.build                      | 1 -
>  7 files changed, 7 insertions(+), 3 deletions(-)
>  rename include/hw/{riscv => misc}/sifive_u_otp.h (100%)
>  rename hw/{riscv => misc}/sifive_u_otp.c (99%)
>
> diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/misc/sifive_u_otp.h
> similarity index 100%
> rename from include/hw/riscv/sifive_u_otp.h
> rename to include/hw/misc/sifive_u_otp.h
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index cbeb228..936a3bd 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -24,7 +24,7 @@
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/riscv/sifive_cpu.h"
>  #include "hw/riscv/sifive_gpio.h"
> -#include "hw/riscv/sifive_u_otp.h"
> +#include "hw/misc/sifive_u_otp.h"
>  #include "hw/misc/sifive_u_prci.h"
>
>  #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
> diff --git a/hw/riscv/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
> similarity index 99%
> rename from hw/riscv/sifive_u_otp.c
> rename to hw/misc/sifive_u_otp.c
> index f6ecbaa..c2f3c8e 100644
> --- a/hw/riscv/sifive_u_otp.c
> +++ b/hw/misc/sifive_u_otp.c
> @@ -23,7 +23,7 @@
>  #include "hw/sysbus.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> -#include "hw/riscv/sifive_u_otp.h"
> +#include "hw/misc/sifive_u_otp.h"
>
>  static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>  {
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 65f3fdd..fa3d0f4 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -137,6 +137,9 @@ config AVR_POWER
>  config SIFIVE_E_PRCI
>      bool
>
> +config SIFIVE_U_OTP
> +    bool
> +
>  config SIFIVE_U_PRCI
>      bool
>
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 9e9550e..018a88c 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -23,6 +23,7 @@ softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
>
>  # RISC-V devices
>  softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
> +softmmu_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
>  softmmu_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
>
>  # PKUnity SoC devices
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 109364b..76eaf77 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -24,6 +24,7 @@ config SIFIVE_U
>      select HART
>      select SIFIVE
>      select SIFIVE_PDMA
> +    select SIFIVE_U_OTP
>      select SIFIVE_U_PRCI
>      select UNIMP
>
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index e6c8af0..2ba4757 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -11,7 +11,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
> -riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u_otp.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('riscv_htif.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
> --
> 2.7.4
>
>

