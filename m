Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189EFC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE232087B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV9DN1gu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE232087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwrDv-0001U0-5J
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 13:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57508)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hwrD1-0000yC-H8
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hwrD0-00041b-FM
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:00:43 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hwrD0-00040S-8U; Sun, 11 Aug 2019 13:00:42 -0400
Received: by mail-ot1-x344.google.com with SMTP id c34so10941452otb.7;
 Sun, 11 Aug 2019 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fbB2d0ZXqx/HgSBqFZsbfsL+6307BAZlOHb+z8rL79k=;
 b=KV9DN1guiU17XS5XECguVBJpdtTA4PZ1zmj+Br0+DPMZ6n4VoATbp1wbRqCKJy73Xi
 AS6MtgTKx5wuOBhCY9mt3zkXl7A7ogn9Sah1UJio3wH5MzNVm95dHujQcXy9Q+jfMtQ8
 DIWAeyN/72DuqsPLK0SvqCR8tezwHHy+t0gOZAgNmNjEFAyCsOrm/4fOMKT3QCW8vSLF
 c6QwyRqOk7Cqt9+yIUJk7EKIAB/UwmG9p4Ohy5lZr7Tk+U3vWICGA0AmVdAdJmJCwAHB
 MVE6FwGJrYb9QslK4EvhWEknJMt4gGYE+IMYCXf4S8R5/RHNhiG4P4fXuCtT7rW3XUHh
 XFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fbB2d0ZXqx/HgSBqFZsbfsL+6307BAZlOHb+z8rL79k=;
 b=PL1Uu7bMyLaaHszUVI2Xckpa/ZJgYn3VSs012a3gTzQ88whY4q/XyCQZ4HV7EiKWZ+
 I1lN4j9WZN1cOyBMupoT2BPvxSq70NjQglIhrdU6Kp6Lhe3mbUrd+6jG90UPAwvREx6D
 ehM4JFYW2emudCQnnW1TOrKEIbLXxUSNBaf6sxCCiWsPJlMyUrpdSIkcHNCha0npWEZL
 2VkjB8yKd66vg9VulyO1KRXPpu2IyacsnGqJVqP8liia553CG8ncWJw3jY7IfY98Dz2b
 +jKi/cW4XLUn+WtZmrOlrY0RXSR0M9F2AE45CO4baMeQYCTse6JyQOw6vEI1CMsRNS6E
 NJWg==
X-Gm-Message-State: APjAAAWfTLxnLQxloJTrxJbcHAq8v9bJqYTjd18/8oYniG9G5DgKsdPy
 m9lv9OTVznq2dXg5/xDsq+Ovy2LpHowtzQ5AYLE=
X-Google-Smtp-Source: APXvYqx+mQvAKHt1lPgZyLsKvw9UUgcm/xgoHwuGp+ri973Bjl2EB0Z0TUWupAbjCS0c1TFXcneYQcoeslQ3YxnLmHs=
X-Received: by 2002:a02:37c6:: with SMTP id
 r189mr22355534jar.118.1565542841106; 
 Sun, 11 Aug 2019 10:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
 <1565510821-3927-5-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565510821-3927-5-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 11 Aug 2019 10:00:13 -0700
Message-ID: <CAKmqyKOG9EV8L7KQ3KvGG5EmXB_WPdAdfPfZoHMp2w0ynKB5Yw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v3 04/28] riscv: hart: Extract hart realize
 to a separate routine
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

On Sun, Aug 11, 2019 at 1:07 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Currently riscv_harts_realize() creates all harts based on the
> same cpu type given in the hart array property. With current
> implementation it can only create symmetric harts. Exact the
> hart realize to a separate routine in preparation for supporting
> heterogeneous hart arrays.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  hw/riscv/riscv_hart.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index ca69a1b..3dd1c6a 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -37,26 +37,33 @@ static void riscv_harts_cpu_reset(void *opaque)
>      cpu_reset(CPU(cpu));
>  }
>
> +static void riscv_hart_realize(RISCVHartArrayState *s, int hart,
> +                               char *cpu_type, Error **errp)
> +{
> +    Error *err = NULL;
> +
> +    object_initialize_child(OBJECT(s), "harts[*]", &s->harts[hart],
> +                            sizeof(RISCVCPU), cpu_type,
> +                            &error_abort, NULL);
> +    s->harts[hart].env.mhartid = hart;
> +    qemu_register_reset(riscv_harts_cpu_reset, &s->harts[hart]);
> +    object_property_set_bool(OBJECT(&s->harts[hart]), true,
> +                             "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +}
> +
>  static void riscv_harts_realize(DeviceState *dev, Error **errp)
>  {
>      RISCVHartArrayState *s = RISCV_HART_ARRAY(dev);
> -    Error *err = NULL;
>      int n;
>
>      s->harts = g_new0(RISCVCPU, s->num_harts);
>
>      for (n = 0; n < s->num_harts; n++) {
> -        object_initialize_child(OBJECT(s), "harts[*]", &s->harts[n],
> -                                sizeof(RISCVCPU), s->cpu_type,
> -                                &error_abort, NULL);
> -        s->harts[n].env.mhartid = n;
> -        qemu_register_reset(riscv_harts_cpu_reset, &s->harts[n]);
> -        object_property_set_bool(OBJECT(&s->harts[n]), true,
> -                                 "realized", &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> +        riscv_hart_realize(s, n, s->cpu_type, errp);
>      }
>  }
>
> --
> 2.7.4
>
>

