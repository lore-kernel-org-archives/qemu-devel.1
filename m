Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EDAC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA30F21655
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vilib7dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA30F21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0vpr-0007e2-L6
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 18:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i0voS-0006mo-Uc
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i0voR-0007To-Rn
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:44:12 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i0voR-0007T9-FQ; Thu, 22 Aug 2019 18:44:11 -0400
Received: by mail-lf1-x141.google.com with SMTP id x3so5726475lfc.0;
 Thu, 22 Aug 2019 15:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d2T4wKxS1KKymICOxEGke4WdM/IZDPhGlMnPvHlzYIM=;
 b=Vilib7dlthePpM0iiprRQFH32oBxI3oDMbvkOmRnX2fk3pTGi71x2tsYurlDOuIdOj
 oga04CtAb8dDdZtrKKyYrwUtIWkZiyZwlUYwmZmxzL2doSm1JtzxAr2EPkdxdwJHGFkE
 gP2e0Eh+ZtRWOz/EoB1Ln0cSAdyBjsf7Jbvfn01U/AcvP7epdKaY7YcPLcsaavOfhCad
 0wYIeR02tn9qOVDkwGqOM/uoov6D3r7eZfeOjc8FWR+obWQXf/vUF5l0j08nmOm+neNL
 CjA8dDFRXiQeOHsaQAAYzws55NjR0VcEW088RgO2mUzUqEImypZMbvNykNWg9cs1s1He
 ZyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d2T4wKxS1KKymICOxEGke4WdM/IZDPhGlMnPvHlzYIM=;
 b=ZwdB5KPtfr+ESCffhkIYUKUlJCSiclRtNOUM6KQhKhST2qbkSv14wR9BH6bzaCzT5I
 sH3OHcw6ELXomviCm8L9Bu7A0K/fdmGwQXgVaTaMkd4k1ijsuPF4LYWdUyBHKyMgbA/4
 FJOjAmuDm3ZD93ItuFitTFZNpFwjKOueCY7J7r5/4JHGHPtPyv/ZjCuPzUuylSOoBiIb
 gdT2FhichzvPW//KK8MGr3kMzK9fBCwB6oCPPs4QNQQ/7bukAm06YMfh1kTmizia4AZT
 epR0mpa1HlLMHd0bdUvy2rUfkY4ATMRffu03ArSOZsY7YXBQ6X0/y3RuFps4IU/8dg5/
 oLYw==
X-Gm-Message-State: APjAAAUnPx/5rg5Z1fUDBD7yC5M2ieGailLmEEeDvaA7Ku4xNJogO15Q
 IR2Vvp3lJ+arE/fxRSFZM14OUWEesw0QxDO1uOoJX5Df
X-Google-Smtp-Source: APXvYqwJJdD4hb3EzPNuGIP2w19ENYIUZspdThf++o/h8zMAAXs+pK5iSHe8yjdpCy+6D3T7e+XAiQAN8upJ8oKbJPU=
X-Received: by 2002:a19:7006:: with SMTP id h6mr795648lfc.5.1566513850329;
 Thu, 22 Aug 2019 15:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
 <1566191521-7820-14-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1566191521-7820-14-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 Aug 2019 15:40:05 -0700
Message-ID: <CAKmqyKO-FvyWnMimAGNAEwSRqrswkY9QW1=iiaaSZMh6kgXLCg@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v4 13/28] riscv: hart: Add a "hartid-base"
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

On Sun, Aug 18, 2019 at 10:27 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> At present each hart's hartid in a RISC-V hart array is assigned
> the same value of its index in the hart array. But for a system
> that has multiple hart arrays, this is not the case any more.
>
> Add a new "hartid-base" property so that hartid number can be
> assigned based on the property value.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Why do we need this patch?

Alistair

>
> ---
>
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

