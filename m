Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3B2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 23:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D2022CED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 23:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp7/Gh76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D2022CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5HwM-0002pz-3L
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 19:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i5Hvg-0002Ob-6C
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 19:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i5Hvf-0007w6-41
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 19:09:40 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:47028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i5Hve-0007uu-Sl; Tue, 03 Sep 2019 19:09:39 -0400
Received: by mail-lj1-x241.google.com with SMTP id e17so6721815ljf.13;
 Tue, 03 Sep 2019 16:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PPwljZA2rPpRbvS0e37mfASF5sIMRnIrD2rdGIOq6EE=;
 b=Bp7/Gh76IvXkUb2TIwPCQH7SkPJRZb4pKec+pQ34MTd+g2k9gZSwuKT7i3fhZFlT4y
 MYT+91RolBwwgBOwg0SWOT9MkTkdq+gYaZZ3a13wbYlFgkDjJpdxaPkCHQOt6xeE+FBg
 Abwv7ZjXhrCVmqfRkMcF0KSX9G9MukfhfLMn95WSaQVy71OvNZpPOj0S7oqflonqpvZz
 +UjTpi/4EQ/vtoIc1zunJcpky9EYB8NsamzGnAPgBxdaJjTOikqhfzYkM9CIyWnoJiic
 K2I0eYakAKR4fncR4pT390H4GUKn1JfwiTmii8BboZJ+5EgEpRj72jkm2cBPXNxHX+J0
 6PLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PPwljZA2rPpRbvS0e37mfASF5sIMRnIrD2rdGIOq6EE=;
 b=ISnH5bwHSBgon9hhjIjM7mICdEe0cpXU15aECjxG/LH/Mun/t5rJqjH4XvXz1atYfC
 yobkpLALvk+PtqdfRavEAvsp1p4v2XM0cU/WM3FzHUUDbLxgYYs0F5Po63lmMcccIaLt
 zoPBICpoTUcBha25bZ4gN7ieSeN/Z6pX3Y6szWVFeWjeNypkCU2NP96DAtZingZBZTXp
 1VxXHfUa2G3fDpHc2xReGRoCJr/+RkjEzdOv2KQAprWPHTnl0HOtBXDWnEzhOip5cWiR
 kkW4BefKmO/KEyOqZ+vfxfrAVuqMT6D9yYg23hAKAik5FBODM73fO5ojqk59fSvYQyNE
 l57w==
X-Gm-Message-State: APjAAAWygJuss8H0JaFD/l3gJw4MYrZbeY+qn3Ez4klEz6HTMhiMPiq2
 AFA49tWJinvTTWYw9rcqZdn9VleooywORasul2s=
X-Google-Smtp-Source: APXvYqyRcEcIj7iHac1aJtg6fUExpgZ4lqDRh6vfSsv1K0FkpfV7qQGOpK2NoE/yeOUQLWSIr6BUOYzovawXZspAvVM=
X-Received: by 2002:a05:651c:109:: with SMTP id
 a9mr21125800ljb.33.1567552177827; 
 Tue, 03 Sep 2019 16:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
 <1567306391-2682-16-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1567306391-2682-16-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Sep 2019 16:09:11 -0700
Message-ID: <CAKmqyKOmP6KjJBrY8Taw1DKqcmkeY22gNgJZ9r8=ccRwbzxtXw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v7 15/30] riscv: hart: Add a "hartid-base"
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

On Sat, Aug 31, 2019 at 7:58 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> At present each hart's hartid in a RISC-V hart array is assigned
> the same value of its index in the hart array. But for a system
> that has multiple hart arrays, this is not the case any more.
>
> Add a new "hartid-base" property so that hartid number can be
> assigned based on the property value.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v7:
> - use `s->hartid_base + idx` directly
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
>  hw/riscv/riscv_hart.c         | 3 ++-
>  include/hw/riscv/riscv_hart.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 9deef869..e28db80 100644
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
> @@ -45,7 +46,7 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
>      object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx],
>                              sizeof(RISCVCPU), cpu_type,
>                              &error_abort, NULL);
> -    s->harts[idx].env.mhartid = idx;
> +    s->harts[idx].env.mhartid = s->hartid_base + idx;
>      qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
>      object_property_set_bool(OBJECT(&s->harts[idx]), true,
>                               "realized", &err);
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

