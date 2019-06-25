Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530A3C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E4C2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzPADc7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E4C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnTD-00084f-DF
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58559)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hfnGQ-0006uO-TE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hfnGP-0003I8-OL
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:21:42 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hfnGA-0002xt-5D; Tue, 25 Jun 2019 11:21:28 -0400
Received: by mail-lj1-x243.google.com with SMTP id t28so16667463lje.9;
 Tue, 25 Jun 2019 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8k32kILfnaI5q812rKLEj40kaQZaiC/LxwuWyTXi9RA=;
 b=LzPADc7Z9xCfUkU2D7n5+DVcZVms89cCExZBkpS3KcfgenQYOa6qTV2aCXfFaTrT7x
 ts3W+YBR9v6BVViFXG8nFnc7dCzD1cV5rdYr8jObb0/LAkEgpI4ijKeNGpKY1W7Kfyv4
 xRYNb2jX+qrWQUkJsyt93K5/bSk+SxtPD5onkK1Ua/dVEgOTQHsYC1YlHuMxzZ56s7AI
 LHAZxTbZF5T2CXmW0v5s6ETcArESVwXYAq0R8fqGwBl7YISlyUJ7CryDU6pXOpd/pGjT
 FF5If98U365UfkDeEzAkAOMYzTmm+9p4MufCHAU3VVqB3yYP7dY559RFc5Zim10bIJuS
 lYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8k32kILfnaI5q812rKLEj40kaQZaiC/LxwuWyTXi9RA=;
 b=AvekQDQN1Qt9OlXWzWspx8qEh3hbB3RL1PLynD9NCk0ANsn/7K0tGYMIj8I68wwgHO
 BSHOhMC+z9r/yFm2SHqBwehw/oh5lXiV/fdE0EuNhBfDHqBwPjf/biUlfAZ9JQUemfo+
 nf8aRSMZnuKzkcNmMEqHV22f305U4Q5BE2JGTf+z32BSkmkX5QAnf+XxLgsTNBJJkccu
 CMl54CzIeRYGLlYYrIwRYZU1n/jlztUHO65PRHrkhMg5ItH9dHuT9vVREvbn1eXI57IC
 88kmhdjUoTo6yB/WSmYe0mTqVnPSsd563uQ9fks28PSOLr7iUbJCOQnNS1TBmJTYYtvT
 oQkA==
X-Gm-Message-State: APjAAAU3tCt5d14+QnIJqfrrf/8HQVGjmuo0T1az44ca8H0GCfD1/l+E
 UhYDnxjXENlrI13K37Fjd6GOZvs3QoIBw9u0K4s=
X-Google-Smtp-Source: APXvYqyt5vs93B1JGMEqOzbZv0GdGKu8NeMpS3WTZpBTmP5TS/HxWaSCmqPWUfdtEvHf981dm9gMwZHY2AeucRRG8M4=
X-Received: by 2002:a2e:9758:: with SMTP id f24mr33283818ljj.58.1561476083998; 
 Tue, 25 Jun 2019 08:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190625100757.12580-1-palmer@sifive.com>
In-Reply-To: <20190625100757.12580-1-palmer@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Jun 2019 08:20:55 -0700
Message-ID: <CAKmqyKOGKuMJXSPJJEWn7s6OkUZ4ZRL7KFOqtaBWTErrbi6+aQ@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Add support for the Zicsr extension
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 3:09 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The various CSR instructions have been split out of the base ISA as part
> of the ratification process.  This patch adds a Zicsr argument, which
> disables all the CSR instructions.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  target/riscv/cpu.c | 1 +
>  target/riscv/cpu.h | 1 +
>  target/riscv/csr.c | 5 +++++
>  3 files changed, 7 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index bbad39a337b3..915b9e77df33 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -442,6 +442,7 @@ static Property riscv_cpu_properties[] = {
>      DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
>      DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
>      DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
> +    DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
>      DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
>      DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
>      DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index ba551cd3082c..0adb307f3298 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -224,6 +224,7 @@ typedef struct RISCVCPU {
>          bool ext_u;
>          bool ext_counters;
>          bool ext_ifencei;
> +        bool ext_icsr;
>
>          char *priv_spec;
>          char *user_spec;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index de67741f3648..ff988917b995 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -793,6 +793,7 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
>  {
>      int ret;
>      target_ulong old_value;
> +    RISCVCPU *cpu = env_archcpu(env);
>
>      /* check privileges and return -1 if check fails */
>  #if !defined(CONFIG_USER_ONLY)
> @@ -803,6 +804,10 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
>      }
>  #endif
>
> +    /* ensure the CSR extension is enabled. */
> +    if (!cpu->cfg.ext_icsr)
> +        return -1;

QEMU style include curly braces around a single line if. Plus I think
it makes it less error prone. Can you add braces?

After that:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +
>      /* check predicate */
>      if (!csr_ops[csrno].predicate || csr_ops[csrno].predicate(env, csrno) < 0) {
>          return -1;
> --
> 2.21.0
>
>

