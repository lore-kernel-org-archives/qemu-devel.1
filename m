Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F536C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 06:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBE620678
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 06:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/fHbGgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBE620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8egx-0003he-1H
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 02:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1i8eft-0003Fj-GJ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 02:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1i8efs-0007gm-Cc
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 02:03:17 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:46221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1i8efs-0007ga-5i
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 02:03:16 -0400
Received: by mail-io1-xd44.google.com with SMTP id d17so38621401ios.13
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 23:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bOPqtsCZUEmkW61Z1UiHPSnn4D8rdaBaYSAyKW+ncYE=;
 b=T/fHbGgIgn8xyldrBaYWce5u6TqbSP2FZbK5kld2oH+2OFtPOIxR2FpF4/Ss63CyJt
 5dJtzUqGPFoELq99cRZzGBOaTtyesjB79jSbNS6iZS5BNQksaKHVZM5ryDWktBvfb/y6
 bBUNAEHmh+qoB/ZV1ZxvxHKl+/HEsbMleOApyJ91t6v86bFWRtSmjHLeVcDMdLtJSTDd
 N9zpvyreupbNOmCZMbkQzHr7FSkZjKVm8fcPwedX+S4n26/SWAq0EefxvJh5T+bhwTmj
 JVamrY6p589Cf1hjE9GfDqh1y/b0ldjglqediRSaYKyqTfCQbWRr/Y263EDlCnpfJQ59
 YuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bOPqtsCZUEmkW61Z1UiHPSnn4D8rdaBaYSAyKW+ncYE=;
 b=a799UDBUjx4si8kknSwSGvNn+uzH7oGA0Lk03Yszpo690+2mBs4cipN5lEQngNx/CZ
 xlfUSo84PjqRL6y2ThEO1Cuy35TVeiHJazdzFERezFZwwylTT3chVKRxXK/FTEZiHMY6
 P5rvc2D3I3pmNYFNrt5yabwLbRSR6tuT+Ko54ZSzhJ+eCjR8VhnqfcNxOJ1zxfwRElGi
 DHr46T8reogp5O5axaPZzJMpspJ99g6e77MlXBr72p19xagomD5epb27E/iFfdhO2ETv
 BXROeEBuB/kDq4DnKJDVpV0qFPGND/V+ZqDHEuMGAoob2MWXDrQgpYfOAorU7pw7nlKM
 yMig==
X-Gm-Message-State: APjAAAUVLEgz7b+S8JdVfxgB0dLOEDZpHbS5uQ1KFhqeLvYhMGKUC7vv
 RnfuFljUnsrp8Ah1vZGGNJvtploI+6q9gMmHbQ4cxyTod9vbIGJX
X-Google-Smtp-Source: APXvYqyt8+J2ZwOnkb3EMzzO/QM39jah4XO6uQZiAgAYESei6hXqXv9QW6T58DGRdEs96c1CsK5Qf8F/5Z6FK+HNZcE=
X-Received: by 2002:a02:92:: with SMTP id 140mr12079572jaa.98.1568354595125;
 Thu, 12 Sep 2019 23:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190912183058.17947-1-richard.henderson@linaro.org>
In-Reply-To: <20190912183058.17947-1-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Fri, 13 Sep 2019 08:03:11 +0200
Message-ID: <CABoDooNuDmKmPdRZ-tXrKuvN3W9LEKrF+-xLcbRB__7rU0i1Lg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [PATCH] target/arm: Fix sign-extension for SMLAL*
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Thu, Sep 12, 2019 at 8:31 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The 32-bit product should be sign-extended, not zero-extended.
>
> Fixes: ea96b374641b
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

No more failures on my tests.

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  target/arm/translate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 34bb280e3d..fd2f0e3048 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8045,7 +8045,9 @@ static bool op_smlaxxx(DisasContext *s, arg_rrrr *a,
>      case 2:
>          tl = load_reg(s, a->ra);
>          th = load_reg(s, a->rd);
> -        t1 = tcg_const_i32(0);
> +        /* Sign-extend the 32-bit product to 64 bits.  */
> +        t1 = tcg_temp_new_i32();
> +        tcg_gen_sari_i32(t1, t0, 31);
>          tcg_gen_add2_i32(tl, th, tl, th, t0, t1);
>          tcg_temp_free_i32(t0);
>          tcg_temp_free_i32(t1);
> --
> 2.17.1
>

