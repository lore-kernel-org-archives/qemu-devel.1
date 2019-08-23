Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4050C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE74621848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVycuUxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE74621848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Els-0007zY-Gc
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 14:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i1EPc-0001vm-Kx
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i1EPa-0000Pd-9I
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:35:48 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i1EPZ-0000P6-Vk; Fri, 23 Aug 2019 14:35:46 -0400
Received: by mail-lj1-x243.google.com with SMTP id e24so9713715ljg.11;
 Fri, 23 Aug 2019 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kEW7lCKno7GnKLpFH7Xa5j9FpbIosAkE/RbWFoepRSA=;
 b=gVycuUxnCn9/R/kpnhdxeQs4vsYHFukPWk/Hm5GqvYF2EhiC0zi4z5HkuBdkGKKNRW
 xk9WXmUKZP4xu+x5AjAMLvqKT2mF7d3PH42qTK7H69I5Np8dU2dkekheUJyDKWXYFhsv
 cdHUt/zvMLb6cZr2+xTfg2YlyRSJEO0qawq1Wed+5/uNzRyRyBG3M15GBWSypNXztLnI
 r6hSibm7kkuGRziMArG7HxtCEU/EeLHYbWDQsCkjDojHFO+iK1de05jfboXceljLjEOj
 +z4dswH5DAdasnjFJMNp4kJzJiXK1wkfqeA3uIZ+ttbAkJ5PJS5UE5+PHZh0WDzzLrSO
 HDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kEW7lCKno7GnKLpFH7Xa5j9FpbIosAkE/RbWFoepRSA=;
 b=VCzl1+gHbNDoftQ/O7mAFn8aGylGJbJpHSv16eurFjHNZ68XJgOA8xhBnTozPhPmxW
 yxH9As7BC1TOp2cu4duEbrMe+fDAQ8mEqPa/xDrdNvsVHnEyPxaD1SNXf5XGJzOFe5u1
 QdyP660Nuuj4+YxErhJfW2hWnEP+TVn0e1GTxelS6xvbHveHTQgyZ9hU99MpxChhsu2y
 a7/F3YpdT4zmwWQSYxV0ARSocY1M/mKeQ/895VbE8de46I418tSkDoCmnuFReQ2h++00
 h8pUAYhfk64l2CzqGyu/lJ/iMGp8Jj24VfImWYyCubxHXJA4XT5FAgvVzPu12Z8M9j4x
 SrrQ==
X-Gm-Message-State: APjAAAXlcATe1gkqTr8XECord1Hv3WHSenVEQkhIt1TShRNQIpQNRK6L
 TH7Ij9daMhToneo0rkP5VkhpqLXYD2/KWRBS6tw=
X-Google-Smtp-Source: APXvYqwlAHKf6rmQx1mYt1D2JzVQ3YLFODYSe47TPAcROX03i8be+y+ECDzWkCk9SgzMk4zgFr5L0pPeLg7kX0eb5hg=
X-Received: by 2002:a05:651c:c1:: with SMTP id 1mr3915812ljr.119.1566585344237; 
 Fri, 23 Aug 2019 11:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
 <1566537069-22741-16-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1566537069-22741-16-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Aug 2019 11:31:37 -0700
Message-ID: <CAKmqyKP3Nusu5zUgFECSn5fOXfrJerYAW6q3o+wjYcrAU3YDEA@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v5 15/30] riscv: hart: Add a "hartid-base"
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

On Thu, Aug 22, 2019 at 10:29 PM Bin Meng <bmeng.cn@gmail.com> wrote:
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
> Changes in v5: None
> Changes in v4:
> - new patch to add a "hartid-base" property to RISC-V hart array
>
> Changes in v3: None
> Changes in v2: None
>
>  hw/riscv/riscv_hart.c         | 8 +++++---
>  include/hw/riscv/riscv_hart.h | 1 +
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 9deef869..52ab86a 100644
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

Do we need to pass hartid, can't we just get it from s here?

>  {
>      Error *err = NULL;
> @@ -45,7 +46,7 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
>      object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx],
>                              sizeof(RISCVCPU), cpu_type,
>                              &error_abort, NULL);
> -    s->harts[idx].env.mhartid = idx;
> +    s->harts[idx].env.mhartid = hartid;
>      qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
>      object_property_set_bool(OBJECT(&s->harts[idx]), true,
>                               "realized", &err);
> @@ -58,12 +59,13 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
>  static void riscv_harts_realize(DeviceState *dev, Error **errp)
>  {
>      RISCVHartArrayState *s = RISCV_HART_ARRAY(dev);
> +    uint32_t hartid = s->hartid_base;

I think s->hartid_base can just be used directly, instead of a extra variable.

Alistair

>      int n;
>
>      s->harts = g_new0(RISCVCPU, s->num_harts);
>
>      for (n = 0; n < s->num_harts; n++) {
> -        riscv_hart_realize(s, n, s->cpu_type, errp);
> +        riscv_hart_realize(s, n, hartid + n, s->cpu_type, errp);
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

