Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A5EC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6E920663
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpaeK4Rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6E920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCs4y-0005wu-Gt
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jCs4A-0005V6-TI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jCs49-0007Pl-Im
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:42:02 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:35204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jCs49-0007N6-Dz; Fri, 13 Mar 2020 17:42:01 -0400
Received: by mail-qv1-xf41.google.com with SMTP id u10so5480245qvi.2;
 Fri, 13 Mar 2020 14:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GY59U/7HQcWNi8/z2qIUgEQwnxnIagXUh1LLtb0qIXI=;
 b=lpaeK4RxZOC7ZJzntJSRhHHfBSR0MfgBLhDK+Ruak0tpDeqCawLb7sGrj827IyXZtt
 ls2HG/kk+mksSM6EeOlxcPDL3KSYR5s+/GzLdEk7ftdxOQZ1vLVRRWHiuSuRTI47skzU
 IgaWE5C8iNawbu1z4b8PutrEalcy18PR6yhIyWU6YWMgt2UPjMUiYBHEjR4LKYxwj7dN
 hco14xctKsmZFcBHrTXwrFuLItdHTnqmS7voC+geq2Ncc+01ByR/FJpJbZ33KNs0p6Kf
 tU5AK+1p0EFfiaeeUl1WyXiO1AtmMBpd1SAmN0PrcYqUugjgZ50x9ajG1YBjTejB9IPB
 tnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GY59U/7HQcWNi8/z2qIUgEQwnxnIagXUh1LLtb0qIXI=;
 b=s3+jBPmLs8hIEeQ01U2NyGTqWA/h+BJmpz7hieCd6Tzr27JqScgGKbg46PBmHT6UiJ
 bXHpixrKXa9ykf1s6vrOAEsIk7zeRqYTZWFrevhlBsu1lgn8KOzAk7GnfeJQpvyzCnz2
 WbmMUuqFCnHCSVanVkO6ZzXlrK7o3p584qOq49AFpHuYuLSieMm8fX9LuryA8Gx7XUSc
 zkzcL3A3CN/PdB6XPlGzhFtxsFOxBL/NbtRTJm18TFhwS7n6eyiZeE15/lctswN+M8Ao
 /XbUc65H5LSMZJnsxWLDZS/uY9Za3uJLZ9hFGK2SbRuOYQgVwmzjQWvEPmIyvKDmNGds
 1C8g==
X-Gm-Message-State: ANhLgQ2D/kTXqdF35TLIk0oL5l7vThevPrfRY9J+cu1jHOyaRI05eVPe
 AJNCGuh3/TY9xyietpmSESwmsXRwt6GB/6k9FQY=
X-Google-Smtp-Source: ADFU+vsKmd67qq7jG5PL77Rh6RR+UK9MqvNyzkj7VutrgG/kCeOacCoQ6uco65Ewqmd1etcavQ6NQJP2cLwxpdZd5JU=
X-Received: by 2002:ad4:436b:: with SMTP id u11mr13902281qvt.117.1584135720748; 
 Fri, 13 Mar 2020 14:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-61-zhiwei_liu@c-sky.com>
In-Reply-To: <20200312145900.2054-61-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2020 14:41:34 -0700
Message-ID: <CAKmqyKMJb=6GgtEToPvv+6AArmvmJ5PkjAdr_1j+evYurjf7MQ@mail.gmail.com>
Subject: Re: [PATCH v5 60/60] target/riscv: configure and turn on vector
 extension from command line
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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

On Thu, Mar 12, 2020 at 10:00 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Vector extension is default off. The only way to use vector extension is
> 1. use cpu rv32 or rv64
> 2. turn on it by command line
> "-cpu rv64,v=true,vlen=128,elen=64,vext_spec=v0.7.1".
>
> vlen is the vector register length, default value is 128 bit.
> elen is the max operator size in bits, default value is 64 bit.
> vext_spec is the vector specification version, default value is v0.7.1.
> These properties can be specified with other values.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>  target/riscv/cpu.h |  2 ++
>  2 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6e4135583d..5f1cdd4f2b 100644
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
> +    DEFINE_PROP_BOOL("v", RISCVCPU, cfg.ext_v, false),

This should be x-v as it's experimental.

Alistair

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
> index e069e55e81..36ead8d6d5 100644
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

