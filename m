Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C08BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 00:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FC2207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 00:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE/2D3oD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FC2207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ZcO-00011F-Cv
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 20:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0Zbf-0000DG-2G; Tue, 28 Jul 2020 20:06:03 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0Zbc-0003i4-3Y; Tue, 28 Jul 2020 20:06:02 -0400
Received: by mail-io1-xd43.google.com with SMTP id v6so7457107iow.11;
 Tue, 28 Jul 2020 17:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NcDFvjgGbx9VfQKK+9SR4tGKVPrq8hLqVBMEwEgtI1g=;
 b=VE/2D3oDZjS2kA7KnhC3cmX7UCzNo9HeSJYGntlnuymMmtpsaLGRDIfZXSXRfHYAgT
 oo4ZQqgLit7ySt0aqubkX1C/oDsC/RgRdngH+SkzsvOu5VumsnnGahUizyUEbLq6u2GN
 rdI5kWJCXuJKyXWmAYc7hx1nPmSh2yEa/1ZbEu+Sxdic7NOU+uuPWBxezVQuzBULAO5+
 9AljGa/7Sv5GxOafn2PmUMGud9dhDTQb2rdfNXGk8WtGlsWHO6+2k9iOOco9gl1PBMPD
 YNKaAhGnBMq8iYlqeC0ZRbZjP06EGoIAwYqiFZSe2BqtHfQPz3GG2XNLAC/DRkB4Gk0Q
 T80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NcDFvjgGbx9VfQKK+9SR4tGKVPrq8hLqVBMEwEgtI1g=;
 b=IC8UskCfD40lMAntD6T9ZMbToKcQe+MTGjhxNGUhBKyj8AiGnis9F8BJiPsiTDOMcq
 Mn+6GQ1iWnVa8aDFGRwT1bFa3eHA+ykySfjsxVv7s/hD4ZqsRSnYjUVZ96pfHk5uOMaf
 6hLoXz802/Nt/7iWczSHjKxB+Bzl1pyboSflqY8cx4su8t9Lz2pCCmZ6HakUzvhBjB7y
 lW8c1HGOX4Z9j/81Ueg3hB+iDPStHkSSHx2k3CHxDaoSpHs8is0a5Ohpr+39p+C/0kp4
 WZ8lPluuR/iqNo4mEUAYPUMnguDIzNjyY8e4hqHa63MZVJh/Mg7yHb8cgnyaGjpwwYRE
 rAmw==
X-Gm-Message-State: AOAM53253RU/dcaozM0N2EukDDH/crTbyv4vtOAHMaAoIZqpRrimO+Ki
 rpk7vsCZcVrqakcx62uUdcZM1F9STvLWHLtTcM4=
X-Google-Smtp-Source: ABdhPJxyHpm88VGyz4zKwjx5GGp0El/E9c9cv/o3/VD5aHvw4FCy+uIl/GZQV2baRFgmz8lsc9A5NJpuD8Y89hN+Hwk=
X-Received: by 2002:a5d:9306:: with SMTP id l6mr31791462ion.105.1595981158403; 
 Tue, 28 Jul 2020 17:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595924470.git.zong.li@sifive.com>
 <370a983d0f9e8a9a927b9bb8af5e7bc84b1bf9b1.1595924470.git.zong.li@sifive.com>
In-Reply-To: <370a983d0f9e8a9a927b9bb8af5e7bc84b1bf9b1.1595924470.git.zong.li@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Jul 2020 16:55:45 -0700
Message-ID: <CAKmqyKPex+98-jN5pWON1EHQ=Y16uwRAS0y-WnYG8QSCzqjY7A@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] target/riscv: Fix the translation of physical
 address
To: Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 1:26 AM Zong Li <zong.li@sifive.com> wrote:
>
> The real physical address should add the 12 bits page offset. It also
> causes the PMP wrong checking due to the minimum granularity of PMP is
> 4 byte, but we always get the physical address which is 4KB alignment,
> that means, we always use the start address of the page to check PMP for
> all addresses which in the same page.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 75d2ae3434..2f337e418c 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -543,7 +543,8 @@ restart:
>              /* for superpage mappings, make a fake leaf PTE for the TLB's
>                 benefit. */
>              target_ulong vpn = addr >> PGSHIFT;
> -            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
> +            *physical = ((ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT) |
> +                        (addr & ~TARGET_PAGE_MASK);
>
>              /* set permissions on the TLB entry */
>              if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
> @@ -630,7 +631,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>          }
>      }
>
> -    return phys_addr;
> +    return phys_addr & TARGET_PAGE_MASK;
>  }
>
>  void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> --
> 2.27.0
>
>

