Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F203C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7B02077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVPi4dKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7B02077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHAIU-00033n-8V
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jHAHM-0001eu-Jh
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jHAHL-0001To-DN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:57:24 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:36284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jHAHL-0001Td-9K; Wed, 25 Mar 2020 13:57:23 -0400
Received: by mail-vk1-xa44.google.com with SMTP id m131so935270vkh.3;
 Wed, 25 Mar 2020 10:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8XBKuKHkiomYbsAdzYphsuRy+m0BwopVAsXsVOg9Wsg=;
 b=iVPi4dKSg6jjIAwnZkyZlR8QtQNVHvREPGZQtaxZzP3NATHbLxZT6m/vJ1DCB1p9rP
 EX72hXCJF3ncm0K+tvWwjdK5KuRfrbH/TI4zPbdrMvN3HSs0ERUR97ekNdrZi38R8lHO
 x/bDDqPixIFEEGmhz2yuTrJnQ99AiYk322+AfegVDQpyA8wsyZUBS8lK4GpEmJAzA+fw
 IkEVR7Vybe0Prn1L7idD/s5Ik3TDTaKn8VMADuBX+g0SzFlEORLyrSF8J5gPtD+u95w+
 7q7M5d7AJBQMgjyEwYje64GYKhlRxxXkwlQGkldSELGUTnNzZcO7C5dfmfpZyD6yp4G0
 OVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8XBKuKHkiomYbsAdzYphsuRy+m0BwopVAsXsVOg9Wsg=;
 b=XtlmDK07W158L7yFT4j2jR/sl19h80oYZ7wPGmpkqfv42nshk48ESyPM8fSzwyOEld
 QzG5h90cFOcubjJqidE2oBxUoTVLec3i8V+RT73I50YfLjScPZB6yi+YfFiYn42EUp/N
 vYxk0S0VoULKFBHoTNgUCd5hHpbnR50s71kDfGcqwn8AxpOMEfKZUdb7A6QZO6mOSHXJ
 +fUYsr80w4IbCG3J+gxstnqWmpWJKE6xHxN3v3UkHRzTZ7i777CCiZfhJNeuKdW2quAK
 XH7ilDbZM8NIDj6PRFxOfhrWJod5o1rYkdtd94jL7ZDQKMsF1GTwciz29qotl9d9MnHA
 olMg==
X-Gm-Message-State: ANhLgQ26TNIMOn+oybo1r0Sf7i7bXxoYQA7rCINiJLwfxz1/xXS1q/Xz
 RxF567evGWJDYqmQmuNfCFYBonfdJZyS/XQZLXw=
X-Google-Smtp-Source: ADFU+vtGAuzbaGJ+g1ehuxWBrsCvjjTdytj9yUTptXN/T2NfKIMhbeYzbcA8+cqvJmhRCMi7CgcVTt1bia8upqhnxYA=
X-Received: by 2002:a1f:5e0a:: with SMTP id s10mr3391436vkb.37.1585159042486; 
 Wed, 25 Mar 2020 10:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-62-zhiwei_liu@c-sky.com>
In-Reply-To: <20200317150653.9008-62-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2020 10:49:23 -0700
Message-ID: <CAKmqyKM=+x9gJGzLA4D9q189uvv+8Vhb=5nMLcPKuDbE2h4SOw@mail.gmail.com>
Subject: Re: [PATCH v6 61/61] target/riscv: configure and turn on vector
 extension from command line
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a44
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
Cc: guoren@linux.alibaba.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 10:09 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Vector extension is default off. The only way to use vector extension is
> 1. use cpu rv32 or rv64
> 2. turn on it by command line
> "-cpu rv64,x-v=true,vlen=128,elen=64,vext_spec=v0.7.1".
>
> vlen is the vector register length, default value is 128 bit.
> elen is the max operator size in bits, default value is 64 bit.
> vext_spec is the vector specification version, default value is v0.7.1.
> These properties can be specified with other values.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>  target/riscv/cpu.h |  2 ++
>  2 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6e4135583d..92cbcf1a2d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -395,7 +395,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>      }
>
>      set_priv_version(env, priv_version);
> -    set_vext_version(env, vext_version);
>      set_resetvec(env, DEFAULT_RSTVEC);
>
>      if (cpu->cfg.mmu) {
> @@ -463,6 +462,45 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>          if (cpu->cfg.ext_h) {
>              target_misa |= RVH;
>          }
> +        if (cpu->cfg.ext_v) {
> +            target_misa |= RVV;
> +            if (!is_power_of_2(cpu->cfg.vlen)) {
> +                error_setg(errp,
> +                        "Vector extension VLEN must be power of 2");
> +                return;
> +            }
> +            if (cpu->cfg.vlen > RV_VLEN_MAX || cpu->cfg.vlen < 128) {
> +                error_setg(errp,
> +                        "Vector extension implementation only supports VLEN "
> +                        "in the range [128, %d]", RV_VLEN_MAX);
> +                return;
> +            }
> +            if (!is_power_of_2(cpu->cfg.elen)) {
> +                error_setg(errp,
> +                        "Vector extension ELEN must be power of 2");
> +                return;
> +            }
> +            if (cpu->cfg.elen > 64 || cpu->cfg.vlen < 8) {
> +                error_setg(errp,
> +                        "Vector extension implementation only supports ELEN "
> +                        "in the range [8, 64]");
> +                return;
> +            }
> +            if (cpu->cfg.vext_spec) {
> +                if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
> +                    vext_version = VEXT_VERSION_0_07_1;
> +                } else {
> +                    error_setg(errp,
> +                           "Unsupported vector spec version '%s'",
> +                           cpu->cfg.vext_spec);
> +                    return;
> +                }
> +            } else {
> +                qemu_log("vector verison is not specified, "
> +                        "use the default value v0.7.1\n");
> +            }
> +            set_vext_version(env, vext_version);
> +        }
>
>          set_misa(env, RVXLEN | target_misa);
>      }
> @@ -500,10 +538,14 @@ static Property riscv_cpu_properties[] = {
>      DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
>      /* This is experimental so mark with 'x-' */
>      DEFINE_PROP_BOOL("x-h", RISCVCPU, cfg.ext_h, false),
> +    DEFINE_PROP_BOOL("x-v", RISCVCPU, cfg.ext_v, false),
>      DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
>      DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
>      DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
>      DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
> +    DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
> +    DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
> +    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
>      DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
>      DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index f42f075024..42ab0f141a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -285,12 +285,14 @@ typedef struct RISCVCPU {
>          bool ext_s;
>          bool ext_u;
>          bool ext_h;
> +        bool ext_v;
>          bool ext_counters;
>          bool ext_ifencei;
>          bool ext_icsr;
>
>          char *priv_spec;
>          char *user_spec;
> +        char *vext_spec;
>          uint16_t vlen;
>          uint16_t elen;
>          bool mmu;
> --
> 2.23.0
>

