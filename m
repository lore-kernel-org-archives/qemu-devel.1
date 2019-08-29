Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC408C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 07:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A4E22CF5
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 07:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekvp2m20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A4E22CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3FDN-0005mi-Ed
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 03:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1i3FBF-0004tC-5H
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 03:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1i3FBE-0003RS-3Y
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 03:49:17 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:33557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1i3FBD-0003Qp-VN
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 03:49:16 -0400
Received: by mail-io1-xd44.google.com with SMTP id z3so5144458iog.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=adccLH9JPHx0vzU1PLIFSfgdslaTa3jy+ljiKtT7sAM=;
 b=Ekvp2m20soLeC0ZHiAi3IJJgWQnqg6qKx3pRcHAOeVBufUJeOnfzx2YJZJ6P/tlj3h
 PTECKY24fp3kEAYIw398pekkPGFpNql1s2cVb/RwYXTCAAxhliSdA34iF65U6bIvah/y
 lNmC72P8HVty1sqWP67KivLZR0kpV54uoU57zPuWPG2STieHn5XM+XVx1lzx0X8qtmVT
 VL63bnmptDjzPsQ7PXyzWZHor1jPiCxioArl5xXCQZKCoDmUXepQLXECE3Pyk7vh6Tal
 ANkISwpRfh1Es26ABKqtvtHMbH2HGm68IRX7F6zGJLcvgPFyl+rRD+92ePonx3zza3aG
 VfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=adccLH9JPHx0vzU1PLIFSfgdslaTa3jy+ljiKtT7sAM=;
 b=PY1oS75hFsmVbXxygYlAF9LV30o97DML9Om/BK93wUQBqBTTN2nBSKxq2Pce00ZyxZ
 SaYyFiqH/lOhG1khjuL/+tc5PSqPx7R88/GGfEcLLw4mQcUh0U3k1Pyr/TeUha3/RY57
 piKV568iMrrlDMQaIundecMGPoaXZ6dbiHiIv/A7+GBGOBUAKotzLGXjjfGdm9JdGaKM
 dbtD+eJZLkcilrOIVmjJEPTHVwJFToRQfJtfM1eQBHkzeOryg7EXCCRh7xgKO10ANNVg
 o0tsIgkrOGaOWZHdtULa7C5cEsG06PRsOS2b5wur+KSe5gB9JK8GSjNLoY/ReWtvSLTn
 wkjg==
X-Gm-Message-State: APjAAAVyBzhX0BKCi67E0szcPJ883JBw1dGD8gHNgX0lwl9tZqRqkmVU
 hpsVXX9Jy9CxPVueH2E/J5ukZrIVbfgUBrEUm2o=
X-Google-Smtp-Source: APXvYqwVhTJ/ByxO4Y6p4BXePvvf0RPiz+msR1gmvLG6p9rTfsCd7k+oXCXPFksX3pTcCzdSDjkF8rGITEJ4F0dOFkQ=
X-Received: by 2002:a02:4047:: with SMTP id n68mr9374092jaa.10.1567064954983; 
 Thu, 29 Aug 2019 00:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190829013258.16102-1-richard.henderson@linaro.org>
In-Reply-To: <20190829013258.16102-1-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 29 Aug 2019 09:49:07 +0200
Message-ID: <CABoDooNfcz2fxgE6fG-nM1faq1RcmS9bCCjU=TSqAHBu9+Y1Hw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [PATCH] target/arm: Fix SMMLS argument order
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Thu, Aug 29, 2019 at 3:33 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The previous simplification got the order of operands to the
> subtraction wrong.  Since the 64-bit product is the subtrahend,
> we must use a 64-bit subtract to properly compute the borrow
> from the low-part of the product.
>
> Fixes: 5f8cd06ebcf5 ("target/arm: Simplify SMMLA, SMMLAR, SMMLS, SMMLSR")
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  target/arm/translate.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index cbe19b7a62..a0f7577f47 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8824,7 +8824,16 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                          if (rd != 15) {
>                              tmp3 = load_reg(s, rd);
>                              if (insn & (1 << 6)) {
> -                                tcg_gen_sub_i32(tmp, tmp, tmp3);
> +                                /*
> +                                 * For SMMLS, we need a 64-bit subtract.
> +                                 * Borrow caused by a non-zero multiplicand
> +                                 * lowpart, and the correct result lowpart
> +                                 * for rounding.
> +                                 */
> +                                TCGv_i32 zero = tcg_const_i32(0);
> +                                tcg_gen_sub2_i32(tmp2, tmp, zero, tmp3,
> +                                                 tmp2, tmp);
> +                                tcg_temp_free_i32(zero);
>                              } else {
>                                  tcg_gen_add_i32(tmp, tmp, tmp3);
>                              }
> @@ -10068,7 +10077,14 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>                      if (insn & (1 << 20)) {
>                          tcg_gen_add_i32(tmp, tmp, tmp3);
>                      } else {
> -                        tcg_gen_sub_i32(tmp, tmp, tmp3);
> +                        /*
> +                         * For SMMLS, we need a 64-bit subtract.
> +                         * Borrow caused by a non-zero multiplicand lowpart,
> +                         * and the correct result lowpart for rounding.
> +                         */
> +                        TCGv_i32 zero = tcg_const_i32(0);
> +                        tcg_gen_sub2_i32(tmp2, tmp, zero, tmp3, tmp2, tmp);
> +                        tcg_temp_free_i32(zero);
>                      }
>                      tcg_temp_free_i32(tmp3);
>                  }
> --
> 2.17.1
>

