Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA72BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E95207BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 04:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOleJMu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E95207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy6pr-0003bx-1n
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 00:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jy6pJ-0003AF-2h; Wed, 22 Jul 2020 00:57:57 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:33044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jy6pH-0004q0-I0; Wed, 22 Jul 2020 00:57:56 -0400
Received: by mail-yb1-xb44.google.com with SMTP id c14so384525ybj.0;
 Tue, 21 Jul 2020 21:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AywOsFIlwmIbHv/IGfx+vHRTo2l6JU9nGGTgBfGkgW8=;
 b=rOleJMu+zawfVGQmQ5d2ezF4ZSczEqQpY8wLjxTNSYc6y/AkpfNxB8IbeBXiIYlbzk
 v8BeEtXvm/yrHxxlttkeGALHYzoi1D6IGZ5v9ZADQbiu24RrFjJs6lf/8RJNiK+4Sz6E
 q0rz6iMGYVo15D5UPFv7mrkUiKM/ZNNKdfQv7Sxrn4hDldWynRWy7V/t+4+O+c5cQiGU
 kh89HGV5wSvkmCnKCMbwwX8E6oZnqTwGy5z9Ctarb9XzJxIIdZj+t9eN73T5W+Rt7oz7
 wi1usDKsgYtAidLhm1OuQPtqAaTl0RqBg3vUp/Wt6pxtqQCSs8MZEyQ1/xlF8NN0/ezx
 tRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AywOsFIlwmIbHv/IGfx+vHRTo2l6JU9nGGTgBfGkgW8=;
 b=Dyg84Vgs4L5TFJpe1jkeYv73GDJ4LX3r+5pnnRKpG3jPOro29UYQKs+r3hMYRm4lI2
 isSjt2rl8IY0cL+uZ0pubFBHcbtr0umEioaisrhk1aPq6sXGnt1qS4zQZ0tgoOdjSTvX
 JJPjbhUI54h+0naKbVastZuMjR+9akbOcIJK/355Pn8srXS4S57Wbz4IYoh9hK2L0cgI
 X7AuEUbWmStKCn4aH6RCMRyDR1vqVlFWVo4UZ+WFCZfE8PxGWVUUbctiCARgM13ZYzoP
 G9bCxB0UNkDqDOrqXSoEiysplTANiIaqMd+FnDIncE7wWXv77CW0CBRfNduJrDdtiW9j
 ZHXg==
X-Gm-Message-State: AOAM533G8zM2bhBD5Qkfiss/5XGAO6v0ZvQb5YhZK1z0bMEZvEdhWwBw
 oYu+mspwxs85v3sek/P/dXVG7mHbgtalybteJuA=
X-Google-Smtp-Source: ABdhPJwt36PAcimD/wv81fnLnwXu7r9EN/7gNeAZcYCE4VEmETwA7yggGhaSCm6lQztjPVeba4pIqxwkZ/rCKuTdDP0=
X-Received: by 2002:a25:24c7:: with SMTP id
 k190mr47307724ybk.306.1595393873800; 
 Tue, 21 Jul 2020 21:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595335112.git.zong.li@sifive.com>
 <80450819119ba8493f18c825517f1b4f37eeb600.1595335112.git.zong.li@sifive.com>
In-Reply-To: <80450819119ba8493f18c825517f1b4f37eeb600.1595335112.git.zong.li@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 22 Jul 2020 12:57:42 +0800
Message-ID: <CAEUhbmUFq+j4fD5pKDwp8RPPZNaRvFcG5uUAsp6KZSKhSC8dWQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] target/riscv/pmp.c: Fix the index offset on RV64
To: Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zong,

On Tue, Jul 21, 2020 at 8:41 PM Zong Li <zong.li@sifive.com> wrote:
>
> On RV64, the reg_index is 2 (pmpcfg2 CSR) after the seventh pmp
> entry, it is not 1 (pmpcfg1 CSR) like RV32. In the original
> implementation, the second parameter of pmp_write_cfg is
> "reg_index * sizeof(target_ulong)", and we get the the result
> which is started from 16 if reg_index is 2, but we expect that
> it should be started from 8. Separate the implementation for
> RV32 and RV64 respectively.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
>
> Changed in v3:
>  - Refine the implementation. Suggested by Bin Meng.
>
> Changed in v2:
>  - Move out the shifting operation from loop. Suggested by Bin Meng.

As I mentioned previously, these changelog should go after --- below.
It should not appear in the commit message.

> ---
>  target/riscv/pmp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 2a2b9f5363..f2d50bace5 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -318,6 +318,10 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
>          return;
>      }
>
> +#if defined(TARGET_RISCV64)
> +    reg_index >>= 1;
> +#endif
> +
>      for (i = 0; i < sizeof(target_ulong); i++) {
>          cfg_val = (val >> 8 * i)  & 0xff;
>          pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
> @@ -335,6 +339,10 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
>      target_ulong cfg_val = 0;
>      target_ulong val = 0;
>
> +#if defined(TARGET_RISCV64)
> +    reg_index >>= 1;
> +#endif

We should also move the following:

    trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);

before shifting reg_index. Otherwise it traces the wrong pmpcfg CSR read.

> +
>      for (i = 0; i < sizeof(target_ulong); i++) {
>          val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
>          cfg_val |= (val << (i * 8));
> --

Regards,
Bin

