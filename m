Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE733C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BFC20706
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9iUaqPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BFC20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyKO-00043Y-8m
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIf-0002FL-Vg; Mon, 26 Oct 2020 04:56:22 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:36673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIe-0005lK-80; Mon, 26 Oct 2020 04:56:21 -0400
Received: by mail-yb1-xb43.google.com with SMTP id f140so7015822ybg.3;
 Mon, 26 Oct 2020 01:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=44qrQ8NNE+/WRWF6a1v2WjNNEx9zyyXSgAqeuTAea5M=;
 b=u9iUaqPdBYsuyEa5rRFpo8xQGSB8PntyJDuYXVjO0IFxn8W0dpPoNXedbi0lWgjqfE
 0YuKZmy+J/cT5qlSuQwSz8W3ChbuPv7eSTPuOEzq7KNkaYW6pOBGfIrMwfbo3wKzEosW
 YGy8Kvb+iWOK2UOiVD50CSEye5wmNPUdO29yzISvFLG5IDCza4pankopDJpsqArJaA23
 nfV/PLMO2SDHjroYLXmHiKBN8Y49h5Rz2kjIym2wgyqr7eBmcW7CCJozwwzYQtbFIOq4
 emCZcPznHkmPCL/kc9yFpmK2MjW/F+qoflcadGeQKTfLSg/6C0cZXUG1STkcCGUcVeaC
 MBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=44qrQ8NNE+/WRWF6a1v2WjNNEx9zyyXSgAqeuTAea5M=;
 b=R3yf2qXNZ/umIwkYpXmuXkLPvqtTtXhvG2ve5kESCjRrRrMMWPIzE6SQAjDUZ7H0Ie
 /JvQ08We7x3T9hKLuSbhCvyIuylcSUqEesMa1OEkb4VF4aOnUnwOMPZzIJzsuTrED+Ov
 IOC5okOgYkZP93niCvTTrd+JHi6uAscYq2C5TMESm3NEb6RP0+iAqAq8I13ufBaJx4Sl
 4pi2P8Sil93XLkmwUisoNdLMkUPhs88IrUiJmjUstD7l5YSNAYn1vj/PvEbBs255d0qP
 1wCJC1P/qBjzzTWQVFXxHy6WkVAhoLQfd0Kae9DpoVq2TbDDpIdqLKka+ITygkrMiwWh
 rWag==
X-Gm-Message-State: AOAM532698HcgThd6aibQOSwqltXE67jL3q/g+eKXMwb5uWVJ15ZFCHs
 1R9uO3cCIru7UuEcL3z4sC3xE3NhnHem+Ec6JRg=
X-Google-Smtp-Source: ABdhPJyEgM04AI3oh8A1o317FY92efNKSdJl3h7CeC7z6iXCD3R8fWqdXmfxVz7yhFzFLf8R2c7Tn+MYtSF1/7kBwH8=
X-Received: by 2002:a25:520a:: with SMTP id g10mr18953468ybb.152.1603702579069; 
 Mon, 26 Oct 2020 01:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603467169.git.alistair.francis@wdc.com>
 <8786fd77439c26f677eeac2eccedf75ba3b68bb4.1603467169.git.alistair.francis@wdc.com>
In-Reply-To: <8786fd77439c26f677eeac2eccedf75ba3b68bb4.1603467169.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 26 Oct 2020 16:56:08 +0800
Message-ID: <CAEUhbmUotC9UXgSH2GiipxZ6nrzHvWMFgYqjGE4AF8mO3JSAmw@mail.gmail.com>
Subject: Re: [PATCH v1 08/16] target/riscv: fpu_helper: Match function defs in
 HELPER macros
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 11:44 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>

Could you please put some details as to why changing uint64_t to
target_ulong (and vice versa) is needed?

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/fpu_helper.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index bb346a8249..507d7fe7fa 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -224,13 +224,13 @@ target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t rs1)
>  }
>
>  #if defined(TARGET_RISCV64)
> -uint64_t helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
> +target_ulong helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
>  {
>      float32 frs1 = check_nanbox_s(rs1);
>      return float32_to_int64(frs1, &env->fp_status);
>  }
>
> -uint64_t helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
> +target_ulong helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
>  {
>      float32 frs1 = check_nanbox_s(rs1);
>      return float32_to_uint64(frs1, &env->fp_status);
> @@ -248,12 +248,12 @@ uint64_t helper_fcvt_s_wu(CPURISCVState *env, target_ulong rs1)
>  }
>
>  #if defined(TARGET_RISCV64)
> -uint64_t helper_fcvt_s_l(CPURISCVState *env, uint64_t rs1)
> +uint64_t helper_fcvt_s_l(CPURISCVState *env, target_ulong rs1)
>  {
>      return nanbox_s(int64_to_float32(rs1, &env->fp_status));
>  }
>
> -uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1)
> +uint64_t helper_fcvt_s_lu(CPURISCVState *env, target_ulong rs1)
>  {
>      return nanbox_s(uint64_to_float32(rs1, &env->fp_status));
>  }
> @@ -337,12 +337,12 @@ target_ulong helper_fcvt_wu_d(CPURISCVState *env, uint64_t frs1)
>  }
>
>  #if defined(TARGET_RISCV64)
> -uint64_t helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1)
> +target_ulong helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1)
>  {
>      return float64_to_int64(frs1, &env->fp_status);
>  }
>
> -uint64_t helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1)
> +target_ulong helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1)
>  {
>      return float64_to_uint64(frs1, &env->fp_status);
>  }
> @@ -359,12 +359,12 @@ uint64_t helper_fcvt_d_wu(CPURISCVState *env, target_ulong rs1)
>  }
>
>  #if defined(TARGET_RISCV64)
> -uint64_t helper_fcvt_d_l(CPURISCVState *env, uint64_t rs1)
> +uint64_t helper_fcvt_d_l(CPURISCVState *env, target_ulong rs1)
>  {
>      return int64_to_float64(rs1, &env->fp_status);
>  }
>
> -uint64_t helper_fcvt_d_lu(CPURISCVState *env, uint64_t rs1)
> +uint64_t helper_fcvt_d_lu(CPURISCVState *env, target_ulong rs1)
>  {
>      return uint64_to_float64(rs1, &env->fp_status);
>  }
> --

Regards,
Bin

