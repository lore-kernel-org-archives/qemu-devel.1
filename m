Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78464C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F3320663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjlZl/KY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F3320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrmM-0004Wr-Bq
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkrlT-0003qm-7q; Mon, 15 Jun 2020 12:15:15 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:46016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkrlQ-0003RU-P8; Mon, 15 Jun 2020 12:15:14 -0400
Received: by mail-il1-x143.google.com with SMTP id 9so15809826ilg.12;
 Mon, 15 Jun 2020 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jFr1/KpNmOHeaq44SQLd3Y7cVXzFee0fXpzGhnbidqU=;
 b=qjlZl/KYsjudmWB/360AQz+KN/mv3ujVBVPXBEd8qhGfBhgiMDXdaB5yNwNJdcZV5T
 FNHyLg1wt5IY71t90NEjo47dfZfV33fWq3F435BHXulRg1bbFDQ8X1jGcPIx8pdwNMBf
 huz95H4RMTUQdNYdKjbIw+VJQWx+NPybyk27lUHJltHBSlAJAqpHH3Ia/ZBPqlS6imBW
 65wenusyALbQayVFjFY6/y9FIA1hEi0xiICny6DauJT6s4E4uvuNOup1S67kKhr4m27H
 1jrh4Vv6Zr0TVZ6W8uJhHNHq8Tyl9UrAs/DJB7R3stwWIH0RkCJnm+oz6/bXzok9lYDV
 8d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jFr1/KpNmOHeaq44SQLd3Y7cVXzFee0fXpzGhnbidqU=;
 b=BLb2OpduV3guwmCkY/qjD5SytEbVvaoZKwNqbfQNMwrsi5tXriTRZx6xCRSYQsNVP8
 aYHVgLDAYcYDKFfnWlJ3Vo16YZJUmKxY/QWmtjcGfAp3kk2MTliRUp5DWuElpthdoid6
 QAQgRScdYQ1pFLVl8oqFs3fJ3+fhEDpuA1zuAt/ZAt1KVMoyevrP/2raT8sTDzpCMVyX
 IET4rN+mIUhteVcq+ZxvOPFCi57wK7a9YGzVvQ5WvUTlOhOleOQzR5LXTkLWdvd3IlJt
 34oPIUnhAZQeznQNe3dmgvZP0uXNzORhqeZDq2CvzJ1z5Yq0Lkjr46Y7evLa8P+MXTpF
 VsSg==
X-Gm-Message-State: AOAM530ZzjqpMnr+mEnMMLINYRGj1LEc6Ggr3itUVF39oeAhPKV502g6
 kGCBOxLQhz/qUeCkzctR/YabnnxnGjk5xNAtywk=
X-Google-Smtp-Source: ABdhPJzGD3Cu6HLOZTVHuHJj8a4Jj5XuvuzgejVrw9IHvKoQlGsq1zMlucDa/sGCn7uHgir0RSBrMtmQQ3Qxytnjwlk=
X-Received: by 2002:a92:bb45:: with SMTP id w66mr27868277ili.131.1592237710720; 
 Mon, 15 Jun 2020 09:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-2-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-2-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 09:05:47 -0700
Message-ID: <CAKmqyKNH-sxGyPiWVLFWzKVNxxFKWT79r=4Q1pQvLueTMvi9FQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] hw/riscv: sifive_e: Remove the riscv_ prefix of the
 machine* and soc* functions
To: Bin Meng <bmeng.cn@gmail.com>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 7:20 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This was done in the virt & sifive_u codes, but sifive_e codes were
> missed. Remove the riscv_ prefix of the machine* and soc* functions.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_e.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 472a989..8fab152 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -75,7 +75,7 @@ static const struct MemmapEntry {
>      [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
>  };
>
> -static void riscv_sifive_e_init(MachineState *machine)
> +static void sifive_e_machine_init(MachineState *machine)
>  {
>      const struct MemmapEntry *memmap = sifive_e_memmap;
>
> @@ -124,7 +124,7 @@ static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
>      MachineClass *mc = MACHINE_CLASS(oc);
>
>      mc->desc = "RISC-V Board compatible with SiFive E SDK";
> -    mc->init = riscv_sifive_e_init;
> +    mc->init = sifive_e_machine_init;
>      mc->max_cpus = 1;
>      mc->default_cpu_type = SIFIVE_E_CPU;
>  }
> @@ -144,7 +144,7 @@ static void sifive_e_machine_init_register_types(void)
>
>  type_init(sifive_e_machine_init_register_types)
>
> -static void riscv_sifive_e_soc_init(Object *obj)
> +static void sifive_e_soc_init(Object *obj)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
>      SiFiveESoCState *s = RISCV_E_SOC(obj);
> @@ -159,7 +159,7 @@ static void riscv_sifive_e_soc_init(Object *obj)
>                            TYPE_SIFIVE_GPIO);
>  }
>
> -static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
> +static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
>      const struct MemmapEntry *memmap = sifive_e_memmap;
> @@ -243,26 +243,26 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>          &s->xip_mem);
>  }
>
> -static void riscv_sifive_e_soc_class_init(ObjectClass *oc, void *data)
> +static void sifive_e_soc_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
>
> -    dc->realize = riscv_sifive_e_soc_realize;
> +    dc->realize = sifive_e_soc_realize;
>      /* Reason: Uses serial_hds in realize function, thus can't be used twice */
>      dc->user_creatable = false;
>  }
>
> -static const TypeInfo riscv_sifive_e_soc_type_info = {
> +static const TypeInfo sifive_e_soc_type_info = {
>      .name = TYPE_RISCV_E_SOC,
>      .parent = TYPE_DEVICE,
>      .instance_size = sizeof(SiFiveESoCState),
> -    .instance_init = riscv_sifive_e_soc_init,
> -    .class_init = riscv_sifive_e_soc_class_init,
> +    .instance_init = sifive_e_soc_init,
> +    .class_init = sifive_e_soc_class_init,
>  };
>
> -static void riscv_sifive_e_soc_register_types(void)
> +static void sifive_e_soc_register_types(void)
>  {
> -    type_register_static(&riscv_sifive_e_soc_type_info);
> +    type_register_static(&sifive_e_soc_type_info);
>  }
>
> -type_init(riscv_sifive_e_soc_register_types)
> +type_init(sifive_e_soc_register_types)
> --
> 2.7.4
>
>

