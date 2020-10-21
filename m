Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89894C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 20:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A38208B8
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 20:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAYXmDJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A38208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVKpg-0005Pi-6C
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 16:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kVKny-0004bA-2G; Wed, 21 Oct 2020 16:33:54 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:45580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kVKnr-0003x8-MR; Wed, 21 Oct 2020 16:33:53 -0400
Received: by mail-il1-x144.google.com with SMTP id g7so3742432ilr.12;
 Wed, 21 Oct 2020 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UfnLJVxvS7tlgzkX75GEVoAMSTkpG0UmfBuTjtue+Fg=;
 b=SAYXmDJO7+9Pd/r/7XMZXHd3StO8dsxpDF77JJvz2+tuVkxy8Pgo4Q0j/NiWjwkLql
 hmX2HCZRwM8ghH4TEBDEl3gISxoqIR/cGO6ED73n0XX8S0kSQG3xeQViAny79X5Mlst1
 YwuePtOMnBPdcHqhVoqpXJs2rvvroETJC/vTjN9t3UAJBZ/q9k901s/uJxgmnRjrd23d
 FPGoE32ACZ0fOvN8v9xZRzTK41VfynrFf4K3YVe64KFQazJgo8yCkM1U7+Bz/NT9gcQ+
 xnl3VSIEaEqCrlnT3KM5O5qch3Je1DOA2SDfq7jlMwFtlbSWRveHssCr9XJ93NMAIwNF
 LQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UfnLJVxvS7tlgzkX75GEVoAMSTkpG0UmfBuTjtue+Fg=;
 b=c5/UwnC+a8WAzt/yBvG9HjOtumBiNyJ6e7+79jVItb2Wrgh0oe2YCLBTz16hUoxoqa
 4XAz3qUjo9BtyivSbdcmN1WRqQTbfQIJtmHp51fr2x63UyOrw63Zl7lRaz0TQwlA+Ue9
 APjGoHU2zP/SfqQXIO//TLOSXjLhQ9+r8jvoXMR8bPbOXuVsXKq3fFWrU8KD4oSJfMyl
 oI9WMfjR3ZyhL3W0ULKvAWMTyWkX6fnTtYfkkbkOF2JqYxBJ6GFSIwys3euMlZ02gpGp
 +XgnN4LqrFV2maS9uXg4tYf1qL3dOrYJdZ+OUrQ+SYFDnRWqDBwFnei/LjQ7FKx1Xg0V
 cshw==
X-Gm-Message-State: AOAM530D1tVP5mVt3gE3HApMKy8ytmZNf0ycmWMSQBZAGke98vRTHJJ0
 TZxsUtarBP6WsWSMyYZy4e9DDPybFzIREEIoam0=
X-Google-Smtp-Source: ABdhPJzkFHoo5or1zZlgbNWRfFgXLG+49i5yQcHpODhZvqtsHPsZn9f4Yc8nnwiG+w4alqDMvZ7saxyBOQgh5Fr85w0=
X-Received: by 2002:a92:c5ce:: with SMTP id s14mr3961681ilt.40.1603312426041; 
 Wed, 21 Oct 2020 13:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201017071154.20642-1-space.monkey.delivers@gmail.com>
 <20201017071154.20642-2-space.monkey.delivers@gmail.com>
In-Reply-To: <20201017071154.20642-2-space.monkey.delivers@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Oct 2020 13:22:02 -0700
Message-ID: <CAKmqyKPdsmfZwnnTpGM70BZ3nQMZ8_5sS9NiVswj8vrfQpSHgg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] [RISCV_PM] Add J-extension into RISC-V
To: Alexey Baturo <baturo.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 space.monkey.delivers@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 kupokupokupopo@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 17, 2020 at 12:15 AM Alexey Baturo <baturo.alexey@gmail.com> wrote:
>
> Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
> ---
>  target/riscv/cpu.c | 4 ++++
>  target/riscv/cpu.h | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 0bbfd7f457..fe6bab4a52 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -438,6 +438,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>          if (cpu->cfg.ext_h) {
>              target_misa |= RVH;
>          }
> +        if (cpu->cfg.ext_j) {
> +            target_misa |= RVJ;
> +        }
>          if (cpu->cfg.ext_v) {
>              target_misa |= RVV;
>              if (!is_power_of_2(cpu->cfg.vlen)) {
> @@ -516,6 +519,7 @@ static Property riscv_cpu_properties[] = {
>      DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
>      /* This is experimental so mark with 'x-' */
>      DEFINE_PROP_BOOL("x-h", RISCVCPU, cfg.ext_h, false),
> +    DEFINE_PROP_BOOL("x-j", RISCVCPU, cfg.ext_j, false),

Usually you only want to allow the user to enable the extension at the
end of the series. That way if someone checks out QEMU between patch 1
and patch 5 they don't have a half working implementation (it will be
there, but they can't enable it).

Alistair

>      DEFINE_PROP_BOOL("x-v", RISCVCPU, cfg.ext_v, false),
>      DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
>      DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index de275782e6..eca611a367 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -66,6 +66,7 @@
>  #define RVS RV('S')
>  #define RVU RV('U')
>  #define RVH RV('H')
> +#define RVJ RV('J')
>
>  /* S extension denotes that Supervisor mode exists, however it is possible
>     to have a core that support S mode but does not have an MMU and there
> @@ -277,6 +278,7 @@ struct RISCVCPU {
>          bool ext_s;
>          bool ext_u;
>          bool ext_h;
> +        bool ext_j;
>          bool ext_v;
>          bool ext_counters;
>          bool ext_ifencei;
> --
> 2.20.1
>
>

