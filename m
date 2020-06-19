Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B31CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 21:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53C5217BA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 21:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc3OgTh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53C5217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmOUc-0001Kf-1o
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 17:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jmOTs-0000bT-Oh; Fri, 19 Jun 2020 17:23:24 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jmOTr-0005qU-91; Fri, 19 Jun 2020 17:23:24 -0400
Received: by mail-io1-xd41.google.com with SMTP id q8so13000828iow.7;
 Fri, 19 Jun 2020 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w3KSNHNfhUCImvmD/yBXIaV81jE1bDzMWZ0ArXYcyr0=;
 b=Pc3OgTh/PSNKUwgQHRBFBHQMq4H9Ssw4bVP0I2NhLR5KPPvPQ54qhfxS6XQtTQWdMs
 KFvJpVwVg9V6FIXMDguW10CLC8uSltRnr4h3JOdRKSmTxWcBGWIutzjkW2Q3QZudzKoH
 HoOLOb7eajImWgj6cGP01IwWjpGZE8zR90QVVqsVkT7LBfBNt9g4tZP+aUDVnPJNNFq2
 ImI/2DZSVVQbCM5hQKAYZD4dSHlf0fx02bKj9Z/bmY9TYUpYY6Dn11OoQt+2Ghz1IYp9
 w++3zCZpG49t6srl1gEW/Po0gl6JJKSY4PffMURi+9TP0vTQpsWsEyKU6VGZxxw2NG0Q
 Ph5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w3KSNHNfhUCImvmD/yBXIaV81jE1bDzMWZ0ArXYcyr0=;
 b=MyLo3FAxAibtw5+ebSqh3xC0Y3k2+ZTVUDNTv0MIap9/vMb6vmJRGppN/dIBbc11ID
 txBqHGUUEhzcodFEsRvdJR6DNMoWYctxfNlBwN/07gJKBdRB7BlncaRaJiOo4zWU+or3
 iSkAWV3PDoo9fqamX+zfM6p/rizJyulD6oKH6KmfKHt/Iutw9w8q8O5vspE5bdC90EpZ
 SJlyCoKknhpKXxfXQku7HKGK+h64kXohsunoI/ZBk4FcsCtXBKQ/l0KVCjh8cHwEAT/w
 E0JCFNlevNleJIHPxtXBEXyV8z8uj5u6Huf0HWIEPbxETFdj2gZdAQPlcXPqiGMERRbr
 lXcw==
X-Gm-Message-State: AOAM533gfrXXbQbHhw1L/IcIdXO5uORQw5uj+9oFbCkFX++aDzMVcsIv
 QVdwTO9mEceAmWO71j9O99dUGa/XQNOa8tU2h/4=
X-Google-Smtp-Source: ABdhPJyQBHfqpsetQewInfCYK6HfXDVS6wl06GNNEQTh+z+4Vnavk7vI1fbv4pcnKPPRDYRAYHm+btQChfhQ42sk/Jo=
X-Received: by 2002:a6b:b503:: with SMTP id e3mr6322630iof.175.1592601801680; 
 Fri, 19 Jun 2020 14:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200618193556.19459-1-jrtc27@jrtc27.com>
 <20200618202343.20455-1-jrtc27@jrtc27.com>
In-Reply-To: <20200618202343.20455-1-jrtc27@jrtc27.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Jun 2020 14:13:54 -0700
Message-ID: <CAKmqyKPBX8o3FJB9LJE-e-McoPrgwhJJosJm+X7sDjxQ3OUsQQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: plic: Honour source priorities
To: Jessica Clarke <jrtc27@jrtc27.com>
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
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 1:24 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> The source priorities can be used to order sources with respect to other
> sources, not just as a way to enable/disable them based off a threshold.
> We must therefore always claim the highest-priority source, rather than
> the first source we find.
>
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>

Thanks for the patch!

This looks good to me, I'll apply it to the RISC-V tree and it'll be
in my next round pull request.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Changes since v1:
>
>  * Initialise max_prio to plic->target_priority[addrid] rather than 0,
>    allowing the target priority comparison to be dropped and covered by
>    the max_prio comparison.
>
>  hw/riscv/sifive_plic.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
> index 4f216c5585..d91e82b8ab 100644
> --- a/hw/riscv/sifive_plic.c
> +++ b/hw/riscv/sifive_plic.c
> @@ -166,6 +166,9 @@ static void sifive_plic_update(SiFivePLICState *plic)
>  static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
>  {
>      int i, j;
> +    uint32_t max_irq = 0;
> +    uint32_t max_prio = plic->target_priority[addrid];
> +
>      for (i = 0; i < plic->bitfield_words; i++) {
>          uint32_t pending_enabled_not_claimed =
>              (plic->pending[i] & ~plic->claimed[i]) &
> @@ -177,14 +180,18 @@ static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
>              int irq = (i << 5) + j;
>              uint32_t prio = plic->source_priority[irq];
>              int enabled = pending_enabled_not_claimed & (1 << j);
> -            if (enabled && prio > plic->target_priority[addrid]) {
> -                sifive_plic_set_pending(plic, irq, false);
> -                sifive_plic_set_claimed(plic, irq, true);
> -                return irq;
> +            if (enabled && prio > max_prio) {
> +                max_irq = irq;
> +                max_prio = prio;
>              }
>          }
>      }
> -    return 0;
> +
> +    if (max_irq) {
> +        sifive_plic_set_pending(plic, max_irq, false);
> +        sifive_plic_set_claimed(plic, max_irq, true);
> +    }
> +    return max_irq;
>  }
>
>  static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
> --
> 2.20.1
>
>

