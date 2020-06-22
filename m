Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529E3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 21:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B113206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 21:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb38PViv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B113206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnU1O-00021V-BR
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 17:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jnTzf-0000Su-8S; Mon, 22 Jun 2020 17:28:43 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:36471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jnTzd-0004EV-Kr; Mon, 22 Jun 2020 17:28:42 -0400
Received: by mail-io1-xd41.google.com with SMTP id y2so3483406ioy.3;
 Mon, 22 Jun 2020 14:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F1p4zzPgRjNq8whbDdvwLh4qbc2rmMf1KFz2ImorXrE=;
 b=Wb38PVivBnhtoHF3m6stOGcp81t1Vd03fWHHZeM8Q+ea4C4ANrtglBkPGeq7clTc85
 z6nuwypIGrxPBP5dQgwrN/5QsPzEWQJCbwSXuHd0W/mUFENrcfH/zUkV8PSvW4l3TQuF
 nsxdVYN4vr+SnDz1VWUF0V3fFLYizydpXLmMct1CUzNl1zbAYxMSR0IZM5zsLR6gOzmP
 vJJ3EycudLAlCJGChjNQ96WCEDqZHJygYe0RCevzjeoQkUyZMpB6BNKy8MS6U5ZcXWiR
 7gR8ZAVgC/lCtar5HJm4yYP0BGuqsYSSmqtIogcjhxidn01Smtay9xm3gYvE+RFEz0P/
 L5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F1p4zzPgRjNq8whbDdvwLh4qbc2rmMf1KFz2ImorXrE=;
 b=KB5SOyioIkjPoPjeUKvS8StGr25WDSOdbpBSS5nes1wuULxmyE5G5SGeGYCz/benam
 ObTqVqW9a5fx1AUO7BNj5KHSbdVWIIazYZtaY01XxMgyX/cbZ7UtQ+/wvs86iWpGzrkG
 90keXhb+udMP2GGBWukefeHBiIH28CHMmDFufJqX4pFbA9Bm2VenIl+iUjg2Qigi24Yu
 y+jCsCkVnB7lZRneS6OiUZfoH/WiYUMBcmzKap/CLb8Hwmwp+Vi7nUpyS5ZfTcyDrTEf
 XZhDGO4MMTPAUX6lxoZ632ircSfP5hIQEt7d6sM/lthC3qCJz8FYxR/eWuE9KhAoSdpk
 ba6w==
X-Gm-Message-State: AOAM5304NQAyPm0ZuTMZCdlPQUtUVenGp0/8+yhs0GxZ0AjZgRLtUnZk
 x3cKHph85Y27xjNiQsigg51qQkghZy6FSMtFZvQ=
X-Google-Smtp-Source: ABdhPJxkRMiKuuCIMSi0triEbRJMZ2Rrdig8kmVLnKwKqqGwv7TInh9UIRwkDCN6YmI5GC0UnoUDBY6ZwKtDHkpZ8yQ=
X-Received: by 2002:a5d:88c1:: with SMTP id i1mr20372022iol.176.1592861319661; 
 Mon, 22 Jun 2020 14:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200622104250.1404835-1-armbru@redhat.com>
 <20200622104250.1404835-20-armbru@redhat.com>
In-Reply-To: <20200622104250.1404835-20-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2020 14:19:05 -0700
Message-ID: <CAKmqyKPDA8gfTSX2d+OUos10v5z=6_366LSj=LBbVVXYDFisZg@mail.gmail.com>
Subject: Re: [PATCH 19/22] riscv_hart: Fix riscv_harts_realize() error API
 violations
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 3:51 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
>
> riscv_harts_realize() is wrong that way: it passes @errp to
> riscv_hart_realize() in a loop.  I can't tell offhand whether this can
> fail.
>
> Fix by checking for failure in each iteration.
>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: qemu-riscv@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv_hart.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index e26c382259..f59fe52f0f 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -40,19 +40,13 @@ static void riscv_harts_cpu_reset(void *opaque)
>      cpu_reset(CPU(cpu));
>  }
>
> -static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
> +static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
>                                 char *cpu_type, Error **errp)
>  {
> -    Error *err = NULL;
> -
>      object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
>      s->harts[idx].env.mhartid = s->hartid_base + idx;
>      qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
> -    qdev_realize(DEVICE(&s->harts[idx]), NULL, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> +    return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
>  }
>
>  static void riscv_harts_realize(DeviceState *dev, Error **errp)
> @@ -63,7 +57,9 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
>      s->harts = g_new0(RISCVCPU, s->num_harts);
>
>      for (n = 0; n < s->num_harts; n++) {
> -        riscv_hart_realize(s, n, s->cpu_type, errp);
> +        if (!riscv_hart_realize(s, n, s->cpu_type, errp)) {
> +            return;
> +        }
>      }
>  }
>
> --
> 2.26.2
>
>

