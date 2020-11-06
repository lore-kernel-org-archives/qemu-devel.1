Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03913C388F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55716206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZCFmX1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55716206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6pz-00088s-Bq
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb6lu-0006Er-NM
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:47:38 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:45374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb6lp-0007bg-Of
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:47:38 -0500
Received: by mail-ej1-x62f.google.com with SMTP id dk16so3280131ejb.12
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 10:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qTea7u09LmUSsj33BByt++aboIv2MdWJRzUrljlpN3k=;
 b=wZCFmX1ck6Nm8UYoImoLHrxGu4C2leZ6IQfZdz5QdV/c7YLvHI/hGNFnAW/xi+hFM2
 iHCTh8ByWQX0taOVGShWLGQdHA6fP6JSa9feML3FzQYZyQSi0XZutD2g/A/roLDUO+gf
 Oxwrg/nGDASpSzPTqYe3mBxasn5C3C/r8SCvrBpl//2UugO+Rfe9Pr7pfgZYstR5sgpJ
 tJ2YEdj4JJ1f72e1dFXxvvlAZ+mf4WGiRRtP9HFgzJ9YQ4x3NxxXQT+4ujBMBM16aMzv
 osoTo8eDsG2+MHXGIIKyTAl3IEtbKoxXhN95IsdkBX2RkO76NVgz+g1ntkgZvQdGbu0h
 YbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qTea7u09LmUSsj33BByt++aboIv2MdWJRzUrljlpN3k=;
 b=GPVkD206VI3DBFWR4mLQW1H0snBR6xtu9hJ1QRokxqq+r7MXpwqA+owaFYlnO4WXlE
 rUdLqzP7L8qI6r2WnQ05H0sDznKAmEhTnsLO4uGtuHeBpcNrxI+Y7EZ3xqKM5DBxUfcJ
 Yo03dcw9Uni8ai+s8Wy80Sg2OkJyCD6E/gp3hycDTDaga17RQTQoRi5vVXelBxylyH8t
 0epP8VPnZo9YQsRXzlp01szXLe4Pj2iLNBV25zL8UM6AUXuKn2/8x93I4Y939iTWsQt/
 y3P6hhnRCu8A6V7FA9lQtJEUb02lTNoADJfXrlkmivixNro1kF28vAYkds3iQ8B8az9Q
 Z+9w==
X-Gm-Message-State: AOAM531prx4h/xa2CfF9J+M+KvESs7+JMa2b5VfEpHGUX0b69nPcuGjy
 A09Q41IAsdvq2vrtbD1NXxFnR8zkxyKMRNVwR5PDug==
X-Google-Smtp-Source: ABdhPJwSzsTCRt3/0bqOBZH7XRfWyq4mgPSv/oZB1i4sYu+aHgxkSZlbuJaNhsaIkdlgug93zLU11IrQ+4GhPoDWVsM=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr3309085ejb.85.1604688451893; 
 Fri, 06 Nov 2020 10:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
 <20190218143049.17142-34-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-34-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 18:47:19 +0000
Message-ID: <CAFEAcA9WV=x3=FDoe4kHAkzJ4jXmg=4fTs1sVYCf2s0EEvmS8A@mail.gmail.com>
Subject: Re: [PULL 33/43] target/ppc: convert xxspltw to vector operations
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Feb 2019 at 14:31, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Message-Id: <20190215100058.20015-8-mark.cave-ayland@ilande.co.uk>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

So this is a commit from 18 months back, but I happened
to notice an oddity in it while grepping the code base for
something else:

> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
> index 944fc0608a..0e8cecb00a 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1359,38 +1359,24 @@ static void gen_xxsel(DisasContext * ctx)
>
>  static void gen_xxspltw(DisasContext *ctx)
>  {
> -    TCGv_i64 b, b2;
> -    TCGv_i64 vsr;
> +    int rt = xT(ctx->opcode);
> +    int rb = xB(ctx->opcode);
> +    int uim = UIM(ctx->opcode);
> +    int tofs, bofs;

[...]

> -    tcg_gen_shli_i64(b2, b, 32);
> -    tcg_gen_or_i64(vsr, b, b2);
> -    set_cpu_vsrh(xT(ctx->opcode), vsr);
> -    set_cpu_vsrl(xT(ctx->opcode), vsr);
> +    tofs = vsr_full_offset(rt);
> +    bofs = vsr_full_offset(rb);
> +    bofs += uim << MO_32;
> +#ifndef HOST_WORDS_BIG_ENDIAN
> +    bofs ^= 8 | 4;
> +#endif

The ifdef is HOST_WORDS_BIGENDIAN without the
third underscore, so this XOR operation will be
done on both little and big-endian hosts.

Should the ifndef line be fixed, or is this actually
a case where the xor really should be done on all hosts
so we should drop the ifndef/endif lines?

>
> -    tcg_temp_free_i64(vsr);
> -    tcg_temp_free_i64(b);
> -    tcg_temp_free_i64(b2);
> +    tcg_gen_gvec_dup_mem(MO_32, tofs, bofs, 16, 16);
>  }

thanks
-- PMM

