Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE7DC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 20:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C45207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 20:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OstXaOiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C45207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYzFw-0000oY-Lh
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 16:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44421)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hYzEN-0000LD-9g
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 16:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hYzEM-0008TL-DP
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 16:43:27 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hYzEM-0008LY-5W
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 16:43:26 -0400
Received: by mail-oi1-x244.google.com with SMTP id y6so2600262oix.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZHurbQIi7RvE8tR+KYE0KZJK4mjg7hO9GnvBF9ABeTs=;
 b=OstXaOiPEVtCMNnGU9I9Tf/+Bjs7/XlDU0YIwWujYXXJ0bU5oGZsiT86gTxv3q7oXv
 bwr+7YbSCw6Xlg+Fa2QCdXxR6D/N4BERNbKc2TwokqfUwzqDfxIJYxem9ei90ARU8ZPd
 aBpHnlxqulidSTUFvRXSGnhvKifzvZUGLWtDN/axsIUUuaCNAoHakwlaryS4GN3tkyIv
 +fz+YFpQ03PMDnix6zBmkBblnM6Tik6s3LA8hjTBtVt1DuNHG716fbnxyzmUGVB7Mlen
 Tkl9EjosV3KqCzmdhzzwbpOblWBoE9HAquUlsfXZXDI4EZKt5RQnwb7CH5Rl+hwaZ7+Y
 AbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZHurbQIi7RvE8tR+KYE0KZJK4mjg7hO9GnvBF9ABeTs=;
 b=oD4cinA+zC3rdZ739IDZ5siPPvBxopm3R5FPqO87eOInmd9Xui+FJ+G+JNLyjLbZBy
 7ZJN6Yn8wSWZxRLcfkh/sfqVTcxlH1Lan/bxKtqQe8vTVqqWG11LYAbv1iKfmBM5KVpt
 /7Gs81CO/D6qfpSKhY3nhwvB2+MZQCf13lNTenT1Ce6GIgDTc966tBa2cyDtM5jlAW5V
 3paNTIOlnyGchXZFfnoddTxBD+1il5KLfPM4YcAIEXAdXJl16NAHyBGRkpf/k14meyUe
 DYZqHsgva68BGjcgp++3P1hILN29UTCQ/r08exw+nUZFp06iLe/fU1ZzGnSNHiGEp0bZ
 taEw==
X-Gm-Message-State: APjAAAVoaF8uZt4L1FCPF8eK1YigzIwxRPr0DrrnwqXIjxLuP0Jhw15F
 H8flF8El4kp4gGLLbOAGyy7kYw==
X-Google-Smtp-Source: APXvYqxtqoCHtCiLnzCO883U8n7ftvWXvOY7jyBXRuUcgo/zzBtGUC0mtHqJbgkTxc1SrjzubjD1AQ==
X-Received: by 2002:aca:3545:: with SMTP id c66mr1467000oia.129.1559853804650; 
 Thu, 06 Jun 2019 13:43:24 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id q125sm1094590oih.33.2019.06.06.13.43.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Jun 2019 13:43:24 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1559816130-17113-9-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7879c550-f333-7703-e47f-ca734ad47bf7@linaro.org>
Date: Thu, 6 Jun 2019 15:43:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559816130-17113-9-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 8/8] target/ppc: Refactor emulation of
 vmrgew and vmrgow instructions
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 5:15 AM, Stefan Brankovic wrote:
> +/*
> + * We use this macro if one instruction is realized with direct
> + * translation, and second one with helper.
> + */
> +#define GEN_VXFORM_TRANS_DUAL(name0, flg0, flg2_0, name1, flg1, flg2_1)\
> +static void glue(gen_, name0##_##name1)(DisasContext *ctx)             \
> +{                                                                      \
> +    if ((Rc(ctx->opcode) == 0) &&                                      \
> +        ((ctx->insns_flags & flg0) || (ctx->insns_flags2 & flg2_0))) { \
> +        trans_##name0(ctx);                                            \
> +    } else if ((Rc(ctx->opcode) == 1) &&                               \
> +        ((ctx->insns_flags & flg1) || (ctx->insns_flags2 & flg2_1))) { \
> +        gen_##name1(ctx);                                              \
> +    } else {                                                           \
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);            \
> +    }                                                                  \
> +}
> +
>  /* Adds support to provide invalid mask */
>  #define GEN_VXFORM_DUAL_EXT(name0, flg0, flg2_0, inval0,                \
>                              name1, flg1, flg2_1, inval1)                \
> @@ -431,20 +449,13 @@ GEN_VXFORM(vmrglb, 6, 4);
>  GEN_VXFORM(vmrglh, 6, 5);
>  GEN_VXFORM(vmrglw, 6, 6);
>  
> -static void gen_vmrgew(DisasContext *ctx)
> +static void trans_vmrgew(DisasContext *ctx)
>  {
> -    TCGv_i64 tmp;
> -    TCGv_i64 avr;
> -    int VT, VA, VB;
> -    if (unlikely(!ctx->altivec_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_VPU);
> -        return;
> -    }

This appears to drop the check for altivec_enabled.


r~

