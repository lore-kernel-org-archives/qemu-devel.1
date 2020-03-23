Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03635C10F26
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 06:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2FA20736
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 06:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr2NEZPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2FA20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGGwy-0004k2-UK
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 02:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npickito@gmail.com>) id 1jGGvi-0003Iu-0B
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 02:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npickito@gmail.com>) id 1jGGvg-0002GR-Lp
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 02:51:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43418)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npickito@gmail.com>)
 id 1jGGvd-0002F9-NH; Mon, 23 Mar 2020 02:51:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id b2so15462381wrj.10;
 Sun, 22 Mar 2020 23:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2sIlJFNgf7wDJ5p+emrpXzKOTkZ6DOWugYMcQx5pMHg=;
 b=Gr2NEZPtPeXGumJSy72h6AKl19BlEfWZNNJPpWFyWuc7JIcycnC8/BdqLqXHw3QCDH
 FPQ4doayfgVnROoMO/kv7Bwgwznqb/eC25I7+imv2TiTVlM5PKDnvkdjdIxatHkCSoo9
 WhF/MCso6DLAl0cDNvyplGL2bOQe9hMjJpHkVldmbhdBzicxRhqfrzF7skKF8++ir3VM
 NjQ2hGm03azi8Z9I2BdqRproRPdnAeaQuXx+JjSNM55SppXe2eywt0ifywdCGKvQA3L9
 P14nLvrpCUj0CqQsmaP3wni3TrVCWGXSeKnyp0NiM6GR9gIaBt24yiggmAFdceeI+Trs
 uAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2sIlJFNgf7wDJ5p+emrpXzKOTkZ6DOWugYMcQx5pMHg=;
 b=WeEtEbjoa5vUPkVDVt+2efX9/wvpDDWOJdCibFmN5krWUmAQHPOw2fPbyyyuLpYacM
 ccHPPjLVffJzVx2LwSrEEuDJT8ebuwNsfH0BcDSwrYlv199CmYfYbCeqLo1bxX590IFH
 HQmLYWZHC0KB0hHumKc7KgNq2oBNakS0f5ncC6z3LnsDqkA8+ueYMJ6Mj1N9GHs+9VGn
 I7DFlycwit/N4lvEoH09pCQMDgwcfRtC8+rugASwm+7OacoD2/TIKJZDBi2M1m4xgQpd
 GORe+pVRHrXJzoInhwh49KIXWBw14JMeqs+Ty1p2pBrVTLOhVlE7mzGPPX0w+jghUYU+
 +Jrw==
X-Gm-Message-State: ANhLgQ3creawcDYs3+X+vmSJ5Nix1QQAmYtdcuVUQZ57CuiJ72TcJDM/
 UZQ/0QsValGaWtezzSbckzHiozWi2ruSk/v0vFM=
X-Google-Smtp-Source: ADFU+vvzPcFjf3ekT3UE9DMT3G6DkixRvEP5hfCwhBURaIon5EiLHVsjurJ0feraotxc2K8hlgjktw12D26zTfJ/OJc=
X-Received: by 2002:a5d:6150:: with SMTP id y16mr28230786wrt.352.1584946275409; 
 Sun, 22 Mar 2020 23:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-5-zhiwei_liu@c-sky.com>
In-Reply-To: <20200317150653.9008-5-zhiwei_liu@c-sky.com>
From: Kito Cheng <kito.cheng@gmail.com>
Date: Mon, 23 Mar 2020 14:51:03 +0800
Message-ID: <CA+yXCZCWS2fF+LOi-4bUgNXrGm=v9yuYUQR5gpk7+230Z86ykw@mail.gmail.com>
Subject: Re: [PATCH v6 04/61] target/riscv: add vector configure instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Alistair Francis <alistair.francis@wdc.com>, guoren@linux.alibaba.com,
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 Chih-Min Chao <chihmin.chao@sifive.com>, wenmeng_zhang@c-sky.com,
 Palmer Dabbelt <palmer@dabbelt.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zhiwei:

vsetvl and vsetvli seems like missing ISA checking before translate,
this cause those 2 instructions can be executed even RVV not enable.
My testing env is qemu riscv64-linux-user mode.

> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> new file mode 100644
> index 0000000000..7381c24295
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -0,0 +1,69 @@
> +/*
> + * RISC-V translation routines for the RVV Standard Extension.
> + *
> + * Copyright (c) 2020 C-SKY Limited. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl * a)
> +{

Missing vext_check_isa_ill(s) check?

> +    TCGv s1, s2, dst;
> +    s2 = tcg_temp_new();
> +    dst = tcg_temp_new();
> +
> +    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
> +    if (a->rs1 == 0) {
> +        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
> +        s1 = tcg_const_tl(RV_VLEN_MAX);
> +    } else {
> +        s1 = tcg_temp_new();
> +        gen_get_gpr(s1, a->rs1);
> +    }
> +    gen_get_gpr(s2, a->rs2);
> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
> +    gen_set_gpr(a->rd, dst);
> +    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
> +    lookup_and_goto_ptr(ctx);
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +
> +    tcg_temp_free(s1);
> +    tcg_temp_free(s2);
> +    tcg_temp_free(dst);
> +    return true;
> +}
> +
> +static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
> +{
Missing vext_check_isa_ill(s) check?


> +    TCGv s1, s2, dst;
> +    s2 = tcg_const_tl(a->zimm);
> +    dst = tcg_temp_new();
> +
> +    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
> +    if (a->rs1 == 0) {
> +        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
> +        s1 = tcg_const_tl(RV_VLEN_MAX);
> +    } else {
> +        s1 = tcg_temp_new();
> +        gen_get_gpr(s1, a->rs1);
> +    }
> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
> +    gen_set_gpr(a->rd, dst);
> +    gen_goto_tb(ctx, 0, ctx->pc_succ_insn);
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +
> +    tcg_temp_free(s1);
> +    tcg_temp_free(s2);
> +    tcg_temp_free(dst);
> +    return true;
> +}

