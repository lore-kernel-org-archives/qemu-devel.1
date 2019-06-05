Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469FCC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D432075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH14dOYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D432075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50281 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYdHK-0003ve-BK
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:17:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hYd8L-00067z-83
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 17:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hYd8K-0007YG-4c
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 17:07:45 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:34192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hYd8F-0006hd-3d; Wed, 05 Jun 2019 17:07:39 -0400
Received: by mail-lf1-x142.google.com with SMTP id y198so9674907lfa.1;
	Wed, 05 Jun 2019 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Ir0aWXK1HA8gcf6jmWHtEGBp8js2Rqbgng0/bt00rrs=;
	b=SH14dOYnPi0pfbMUatsB0A5d8hVtipS6wJ3jVI0m59/9vCU6jmMe+O0Sg7jEpNWzai
	2r6/2qPhz42PRcZNaf1VtD+kHyWRAznX3nlLkRYmFIGDVwR2v/viVQAOhiReWUDAEgaV
	ZXrqFladVAhDjY/hfXG3mJ0EUoNx9Wa5QEYlP0tA/2tMJeFRHk+kAp2hfLgby41C1eYG
	B8/AJIP+qY6YhpnKbm0TK6Y3AHOD4voz2tTLfIQJuwBwnIqhemrX8IwOh/0WYkBKb9nW
	VczZKiFfxPZ0ldgqmNMFz2PuEjIPwzh5gImZmz+awDNWEaTyI1z7kBbm0wlTrmKL6BCD
	O7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Ir0aWXK1HA8gcf6jmWHtEGBp8js2Rqbgng0/bt00rrs=;
	b=cif6IOtwJxo6r1uAoTZoIRmKtts0q/8wPgRlbYKU6abrnzV2EChqEfAo3WTk3u4KGq
	ldmA2lh/nCyOA/mbKmZPfG/adxoxG2c7fQzkLeq1Z2Esi55hIZd4jzdBHw1jVsrDibPw
	kb94Blh79iF68k9ScYRCGD7bB+3XREYHb7c0wL0roJjqIg746Wl91tQXJKpPrWjciK0e
	8+1XnE/ZUx7Eu0ERZVeBFLBN631pw/MIogE5IA1KkQx4V+GxR+VfcfaPkRPIwZ94wc9/
	AIXhuWGM6zl2y7rAScUhyvDH3uLh2IdkYqZL6SLoKkYAG2IocQ/ynHxXzk+l8d4afvFb
	Z+Ng==
X-Gm-Message-State: APjAAAVP2blNMZR7K6zXx8fuVMXfYihW6QMVwBYGp3d9Urxw/CJnlvMk
	wvqhgXEbsWd37XESXD3tEC1pukxeKC7iquLiKY4=
X-Google-Smtp-Source: APXvYqzBLswPnrZOv9FXdT+Ka89QvSuyWfwL5jUYZwp/6jJiOx6fmqpnezYzVn5ckU7I3RT+BR1RWX6RUoZcaJu2P+M=
X-Received: by 2002:ac2:4990:: with SMTP id f16mr20714968lfl.93.1559768839418; 
	Wed, 05 Jun 2019 14:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190530135135.19715-1-Hesham.Almatary@cl.cam.ac.uk>
	<20190530135135.19715-4-Hesham.Almatary@cl.cam.ac.uk>
In-Reply-To: <20190530135135.19715-4-Hesham.Almatary@cl.cam.ac.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2019 14:04:46 -0700
Message-ID: <CAKmqyKNwec3HaNZ_=vsA1eYa3yjRWe8Q9ZaNcQ9AXZcGvbsQdw@mail.gmail.com>
To: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCHv4 4/6] RISC-V: Check PMP during Page Table
 Walks
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 30, 2019 at 6:52 AM Hesham Almatary
<Hesham.Almatary@cl.cam.ac.uk> wrote:
>
> The PMP should be checked when doing a page table walk, and report access
> fault exception if the to-be-read PTE failed the PMP check.
>
> Suggested-by: Jonathan Behrens <fintelia@gmail.com>
> Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
> ---
>  target/riscv/cpu.h        |  1 +
>  target/riscv/cpu_helper.c | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c17184f4e4..ab3ba3f15a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -94,6 +94,7 @@ enum {
>  #define PRIV_VERSION_1_09_1 0x00010901
>  #define PRIV_VERSION_1_10_0 0x00011000
>
> +#define TRANSLATE_PMP_FAIL 2
>  #define TRANSLATE_FAIL 1
>  #define TRANSLATE_SUCCESS 0
>  #define NB_MMU_MODES 4
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 5a1cd7cf96..00bc4f1712 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -211,6 +211,12 @@ restart:
>
>          /* check that physical address of PTE is legal */
>          target_ulong pte_addr = base + idx * ptesize;
> +
> +        if (riscv_feature(env, RISCV_FEATURE_PMP) &&
> +            !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
> +            1 << MMU_DATA_LOAD, PRV_S)) {

Shouldn't we be passing mode in here?

Alistair

> +            return TRANSLATE_PMP_FAIL;
> +        }
>  #if defined(TARGET_RISCV32)
>          target_ulong pte = ldl_phys(cs->as, pte_addr);
>  #elif defined(TARGET_RISCV64)
> @@ -413,8 +419,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          (ret == TRANSLATE_SUCCESS) &&
>          !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type,
>          mode)) {
> +        ret = TRANSLATE_PMP_FAIL;
> +    }
> +    if (ret == TRANSLATE_PMP_FAIL) {
>          pmp_violation = true;
> -        ret = TRANSLATE_FAIL;
>      }
>      if (ret == TRANSLATE_SUCCESS) {
>          tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
> --
> 2.17.1
>
>

