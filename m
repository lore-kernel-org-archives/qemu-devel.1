Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034B8C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 21:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7CE23439
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 21:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2atwxub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7CE23439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3oMk-0001vt-0x
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 17:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i3oLq-0001VJ-Mx
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 17:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i3oLp-0000R5-DA
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 17:22:34 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i3oLp-0000Px-1j; Fri, 30 Aug 2019 17:22:33 -0400
Received: by mail-lj1-x242.google.com with SMTP id u14so1132875ljj.11;
 Fri, 30 Aug 2019 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9OlsvitBiRTBCVWwC1rSgNVwLJ3LLEPKypBrzUVWeL0=;
 b=T2atwxubfzlQrGeaayHjYZX4QS6aBvcYm4GTp5ut7tzwouzNOwGq0nBE4zwkLREqo6
 jOdgiadlAJxuXFRTldA58RNS+MKfUB0SiEkyxf/LDmTE19P8oz0PDmJretFxIkGZoaLH
 yif+8rAaaWK1o455lJFBzR9VevkCtBxOSm8eVn1yvaWqy8S6iAO4kI1YObyGcmBZGbkJ
 yzdrTifuf0KBcBcJi9083ude7OyoAEnESMqfn9dcaTfCSk+ARERc2AMwG2ujmcQfUqwV
 s17BOqrKVcNwTk6SsgJvnq+d/fIYKqB01I72ZHlEwuq3ZImMB+0Vo8uNxaMLDkjetekc
 vvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9OlsvitBiRTBCVWwC1rSgNVwLJ3LLEPKypBrzUVWeL0=;
 b=BspvfIEml/QSVvfRFkL0wnBPByQBuW6vWYjSYn3lgy4oGUZBUc0Dt3lpmqxw7rMTVq
 vJn+G03ocpJYS0lfQtGA//olMEq+LWBJIbWSiqGS0yFuPA3qla0cdhFV4tIxbctts6x/
 +g8Mk19V7Zwp8R5ZvHmRTfaL06OWX4x4hjFjDxsztYx+yu6t1MjaS9V2+6OwynTSxpO6
 Qo6pxh9+vrrAqy/f3A0neNV8jo11tceCnwY6lpee1jpNqHzqUXuC5ajhe95yKZ1C3ldu
 gEEJHQqXkcu57eI1lvrB6VjbHCmIbmOiMX4ooYaYxR3fiHCZgoSscplfG7eLjt3WvT1B
 3S2w==
X-Gm-Message-State: APjAAAXS8xFDfyknOzdGaGBvEdVe/ilTi7oWprcCm25gi14bHXzWr5EK
 3VL0B87CL7lr2BYnWjsdrTQkcnF8kYJSbugF+cc=
X-Google-Smtp-Source: APXvYqyg4MOdVv+7Ki1YmnHVv6bX0CQneUC6G4Kb3tRollONEkDYJHGAIO1I5iyrejRiMpiWp7ozcso+TbRTUc0kCsw=
X-Received: by 2002:a2e:7c0b:: with SMTP id x11mr9594603ljc.85.1567200151738; 
 Fri, 30 Aug 2019 14:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
 <1566917919-25381-16-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1566917919-25381-16-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Aug 2019 14:18:21 -0700
Message-ID: <CAKmqyKMh-rWXnFYfxkug+cO8CAyAHfofTspXOnFr_mRAj62MXg@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v6 15/30] riscv: hart: Add a "hartid-base"
 property to RISC-V hart array
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 27, 2019 at 8:12 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> At present each hart's hartid in a RISC-V hart array is assigned
> the same value of its index in the hart array. But for a system
> that has multiple hart arrays, this is not the case any more.
>
> Add a new "hartid-base" property so that hartid number can be
> assigned based on the property value.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> ---
>
> Changes in v6:
> - use s->hartid_base directly, instead of an extra variable
>
> Changes in v5: None
> Changes in v4:
> - new patch to add a "hartid-base" property to RISC-V hart array
>
> Changes in v3: None
> Changes in v2: None
>
>  hw/riscv/riscv_hart.c         | 7 ++++---
>  include/hw/riscv/riscv_hart.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 9deef869..7cfc835 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -27,6 +27,7 @@
>
>  static Property riscv_harts_props[] = {
>      DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
> +    DEFINE_PROP_UINT32("hartid-base", RISCVHartArrayState, hartid_base, 0),
>      DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> @@ -37,7 +38,7 @@ static void riscv_harts_cpu_reset(void *opaque)
>      cpu_reset(CPU(cpu));
>  }
>
> -static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
> +static void riscv_hart_realize(RISCVHartArrayState *s, int idx, uint32_t hartid,
>                                 char *cpu_type, Error **errp)
>  {
>      Error *err = NULL;
> @@ -45,7 +46,7 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
>      object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx],
>                              sizeof(RISCVCPU), cpu_type,
>                              &error_abort, NULL);
> -    s->harts[idx].env.mhartid = idx;
> +    s->harts[idx].env.mhartid = hartid;

Couldn't this just be `s->hartid_base + idx`?

Alistair


>      qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
>      object_property_set_bool(OBJECT(&s->harts[idx]), true,
>                               "realized", &err);
> @@ -63,7 +64,7 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
>      s->harts = g_new0(RISCVCPU, s->num_harts);
>
>      for (n = 0; n < s->num_harts; n++) {
> -        riscv_hart_realize(s, n, s->cpu_type, errp);
> +        riscv_hart_realize(s, n, s->hartid_base + n, s->cpu_type, errp);
>      }
>  }
>
> diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
> index 0671d88..1984e30 100644
> --- a/include/hw/riscv/riscv_hart.h
> +++ b/include/hw/riscv/riscv_hart.h
> @@ -32,6 +32,7 @@ typedef struct RISCVHartArrayState {
>
>      /*< public >*/
>      uint32_t num_harts;
> +    uint32_t hartid_base;
>      char *cpu_type;
>      RISCVCPU *harts;
>  } RISCVHartArrayState;
> --
> 2.7.4
>
>

