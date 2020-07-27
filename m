Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225C3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14FD20786
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5adfvoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14FD20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0BwS-0000HJ-4W
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 18:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0Bvt-0008Fs-LK; Mon, 27 Jul 2020 18:49:21 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:38785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0Bvr-00027z-TO; Mon, 27 Jul 2020 18:49:21 -0400
Received: by mail-io1-xd43.google.com with SMTP id l1so18748887ioh.5;
 Mon, 27 Jul 2020 15:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cv1uHciEEYiPiKTkN7vOzBhm3aM/wkxwyDHaZBgNM1c=;
 b=I5adfvoT5r0eS1L+68NZYcc53AOsLul5SrhvQjnVw7bx6iVpIPyDLtUY83JMKcIbWg
 J0JOtD+cKiOFkFOmvMk/FvBSwJecr/88EG/QKO5XwFSD2LIqK3V95pHuYHKkc2DUJ7cH
 twOzFoH4bE34InurUR0ZEqt7c0fqHCPUj+Zrn/YswB6GrF7fWVSguEXWo41mde5Z7iXK
 Q1ysWXapf8vq5RbI6Hw4rQutfOHkh+usKdwtE/LOSbVg/wdExmsd/I4w/dr3Mbcaaijm
 Tgc+G7+J7NpPbMSihrHjr3C19KJ8fuFbdSjCRvmQ+hMCmld5V8tZ0qES3/GGSDstbLyP
 SAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cv1uHciEEYiPiKTkN7vOzBhm3aM/wkxwyDHaZBgNM1c=;
 b=BZ8wqtHnkGyEq3MEw8AO3cwK+in/xujFG6YDtpCvvkreWqKtn8e9umBeCqmZnkhM8W
 IeAYK3nntAR/u0cmHgk7puXBMwoQmVfw02YdGAGIPneeViShkMaN+5M99EJWWQPnlkeF
 xRTWAFjILc0M66SR2NYJGw3cL9ob7ELFW2fVn0p7HjZbdkMb/u/211DyFKUCoKWlebmN
 3g+yN1VBj3AxMWR3lQbdmaFjJ/g+/Z679m37++cRPmiHqSOxGdckGNLLkx7GAQ3fSljL
 xEzt/uQEsW2kJTSCM6kMmdpYh5VPh/UPz2qRuztPwKfIkMgr8+Av5dPln4ocqsR61wbJ
 R3Eg==
X-Gm-Message-State: AOAM5318FRCIbe9uBssNaaZkJkclIZkcPlbVCFgimnUtSSnx15P7ijyG
 tKqqg8iyz1T7hHx20ESJiuN6QjmwvpLM1UyH5jA=
X-Google-Smtp-Source: ABdhPJyXiQf7w7JrkMdJ2WOr3A9MoJdtPYMHzFaP90xuaTJRYhlcHmGxdPbD0JfRmvTudCMaBkUWgTueTWPvC85W+eQ=
X-Received: by 2002:a6b:e006:: with SMTP id z6mr22016297iog.118.1595890158467; 
 Mon, 27 Jul 2020 15:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595689201.git.zong.li@sifive.com>
 <a3b3b05f429a50b5ea061f4e8385d4f8d6d77d58.1595689201.git.zong.li@sifive.com>
In-Reply-To: <a3b3b05f429a50b5ea061f4e8385d4f8d6d77d58.1595689201.git.zong.li@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Jul 2020 15:39:01 -0700
Message-ID: <CAKmqyKNgVD2sb4GEdmFwgHtpbooV=dNkxHHN+mNWDzC1e1S1DQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] target/riscv: Fix the translation of physical
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

On Sat, Jul 25, 2020 at 8:05 AM Zong Li <zong.li@sifive.com> wrote:
>
> The real physical address should add the 12 bits page offset. It also
> causes the PMP wrong checking due to the minimum granularity of PMP is
> 4 byte, but we always get the physical address which is 4KB alignment,
> that means, we always use the start address of the page to check PMP for
> all addresses which in the same page.

So riscv_cpu_tlb_fill() will clear these bits when calling
tlb_set_page(), so this won't have an impact on actual translation
(although it will change in input address for 2-stage translation, but
that seems fine).

Your point about PMP seems correct as we allow a smaller then page
granularity this seems like the right approach.

Can you edit riscv_cpu_get_phys_page_debug() to mask these bits out at
the end? Otherwise we will break what callers to
cpu_get_phys_page_attrs_debug() expect.

Alistair

>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  target/riscv/cpu_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 75d2ae3434..08b069f0c9 100644
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
> --
> 2.27.0
>
>

