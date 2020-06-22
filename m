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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16282C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 21:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48EC20716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 21:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU1rudWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48EC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnU5N-0006Nk-Uq
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 17:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jnU44-0004Tg-R1; Mon, 22 Jun 2020 17:33:16 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:34749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jnU43-0006Nx-0b; Mon, 22 Jun 2020 17:33:16 -0400
Received: by mail-il1-x143.google.com with SMTP id x18so17426214ilp.1;
 Mon, 22 Jun 2020 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rubvoy2h9dj43M6haU17R2Jj0U2JGfulVap4b2+HV3E=;
 b=MU1rudWMMjLWg3D6rZjVl0BxvQ+V5vIb/5gcRp017isnGCtSUqZ+ceCQyyAOlLo8ZM
 6T1Y07AZ9O9EFIDCv6j8uzrvuYIiFaTVru770EYko5pUeLrF7Tg7fXD3empyg4d/DgQT
 Dte7lJijv85lHtto7IMfxLhbUhMs8kVtZsWLS3tjl45DVDPaeToAayFfP/CEPwNye0AB
 5y3XzsmrN2vIcv4oloStXXSdfnR79N17HeQbxCR4Y6T65d1E1ccHY3zew8k3prIeXfOf
 q+Cjamr5VQXtu8Z3LJ2/geXCFTcOBGSZ8k5l2B67DVW5RTbae5shgyXrWMD/3VHPbgOZ
 Biow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rubvoy2h9dj43M6haU17R2Jj0U2JGfulVap4b2+HV3E=;
 b=ICejKYHAA6bAeONNlmF7FjcrLcUUJS+9VEys//3wRr63bICTuVJSgeao+VC1ZerTeP
 i/2P2LECi4U1roDjYaW2bz50qtUcCcnXE4Q1dGPtXrJ98YrJgpJ9K3CBwC1ap2r80oRI
 xQ/QcZVvoTbC0G0kQSizeKffoTMfbEX3/MVHuWx2HHlN0SmxzBT7q3Ti6f6E8ouygCNr
 81tH3fZGezzAsd4wagEIWzfAuGGToUh5bT7gUzUvFaffJ/f77i3EYmqhUEXHFsQCERQj
 MYdztij438jfJeJgycfnUS2mgCy+X+1xhJltnwq8GAfDC2PNHk3QcYiYTdgagp6R86Kv
 In5Q==
X-Gm-Message-State: AOAM531XSe8WgsOiqT5U+nvvC0dNc79JQrzGMGawaVYK9NGic+7WXtmx
 8uLrzmJkjAVxJ7kPPLr6OLZr0nClHd174YrRIBjH6SZx
X-Google-Smtp-Source: ABdhPJx3zLP+jqYHUX5mL1kxyY+1K1xfY7PZrzBQN/RhbkbOsL1DkVvf18FOy+Jg5dDPOIqIlRAEdBHnftZbw88DC5Q=
X-Received: by 2002:a92:d647:: with SMTP id x7mr19941431ilp.267.1592861588354; 
 Mon, 22 Jun 2020 14:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200622104250.1404835-1-armbru@redhat.com>
 <20200622104250.1404835-19-armbru@redhat.com>
In-Reply-To: <20200622104250.1404835-19-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2020 14:23:36 -0700
Message-ID: <CAKmqyKOhfK2FcibsM_LxhcpekWZw=0S6+BsjL22xowzj0cX=5g@mail.gmail.com>
Subject: Re: [PATCH 18/22] riscv/sifive_u: Fix sifive_u_soc_realize() error
 API violations
To: Markus Armbruster <armbru@redhat.com>
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 3:55 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
>
> sifive_u_soc_realize() is wrong that way: it passes &err to
> sysbus_realize() three times before checking it.  Harmless, because
> the first two can't actually fail (I think).
>
> Fix by checking for failure right away.
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
>  hw/riscv/sifive_u.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index ea197ab64f..3857b92d9a 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -587,11 +587,15 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>          memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
>
> -    sysbus_realize(SYS_BUS_DEVICE(&s->prci), &err);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->prci), errp)) {
> +        return;
> +    }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
>
>      qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
> -    sysbus_realize(SYS_BUS_DEVICE(&s->otp), &err);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
> +        return;
> +    }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
>
>      for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
> --
> 2.26.2
>
>

