Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB65C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABE42076C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRA2bZaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABE42076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZFA-0002Ox-Ei
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZEc-0001t1-88
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:43:34 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:33680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZEZ-0007Gu-Vz
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:43:33 -0400
Received: by mail-ej1-x641.google.com with SMTP id a21so628666ejp.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JoZvFYFa6pW9bqQHJjGu2ZZPsgkZ7OsyVjCOfIUy6UY=;
 b=FRA2bZawAhOPDG6D/EIfyI9frClVgwThAEKnTnz5nDC2kQLz9LQAi3jObJrqOQBUWl
 l9eJrcusFH5D/O4NAAR+6wwtQ8LB9HlgwHLAL3erJcD+pSOysL8vq8JIxxGRzMKWeXcW
 wxhme+TsMoSInYSUQfaEB9hVyWWCj+uxRRZT+FBO6R++OiZHkoYahE8dr2jjcg2Z/cEe
 2dWFktBwN9j7EHfTXpd+t0v65o8OXnZsWaH9SERvKuDEyneUGvA4XQ8C3lKXZFqrRAlX
 ucftYd/gI2EO2nAeMdQwLQz8E+eKEo0cAX3mf1bwxEIXXrfcpswmyoWa8aroxMxpv9xz
 ZH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JoZvFYFa6pW9bqQHJjGu2ZZPsgkZ7OsyVjCOfIUy6UY=;
 b=bz5iO1d74emiTT7FjSkthAx6u1VkN5YVw52O2sF/Pvw1bE43l4qP9+hIeFlW5vbivm
 isO1MS0nZzwwOddvQ62eLwXGzlRj8mpgKXSWs/Lc2KAra0xVrXYgNZaJIRlETFHOEorU
 sRWOdY0bm+zlyXN2afL2SdqbDbWp4At8zAzuO1V5iavDhqa+13FPzdxXTjsYZU+WZE2J
 N/P0N1y7reCy+0tsVnb4izk+e7l8MTe15bbuTIdlZ2JLGFXui/t/ED6YB5Ah/hZa4Gvz
 yLBR4YUqyrHmqQWp7Ym8oSXH6dqfDa+go+h2oCZhzndr+0iqDWV5j8vSPmIi5skLDVb6
 mHEA==
X-Gm-Message-State: AOAM533XzllQVdr8qIqEJDJRrrRof4D/v2LuDQsYD7P0q6T1a/ds2ole
 um8hexCY/f8BRNCx7xS3K3NpTz1ZeGkF7Cufh916uw==
X-Google-Smtp-Source: ABdhPJzXXwDaJsTeIoUUL5hA2ykR8jciLnTUeMB5HPZwxYMq0jOCDiqX+jMeBD08HwI8ptqBpg7xcYPbkZAxeiKeSdY=
X-Received: by 2002:a17:907:2066:: with SMTP id
 qp6mr1552038ejb.85.1598363010306; 
 Tue, 25 Aug 2020 06:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-16-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 14:43:18 +0100
Message-ID: <CAFEAcA9KPLqMkzT1ckdQPniJJ9y180YncJxfJ3W4TC_tvq9csg@mail.gmail.com>
Subject: Re: [PATCH 15/20] target/arm: Fix sve_uzp_p vs odd vector lengths
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Aug 2020 at 02:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Missed out on compressing the second half of a predicate
> with length vl % 512 > 256.
>
> Adjust all of the x + (y << s) to x | (y << s) as a
> general style fix.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/sve_helper.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 4758d46f34..fcb46f150f 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -1938,7 +1938,7 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
>      if (oprsz <= 8) {
>          l = compress_bits(n[0] >> odd, esz);
>          h = compress_bits(m[0] >> odd, esz);
> -        d[0] = extract64(l + (h << (4 * oprsz)), 0, 8 * oprsz);
> +        d[0] = l | (h << (4 * oprsz));

Why did we drop the extract64() here ? This doesn't seem
to correspond to either of the things the commit message
says we're doing.

Also, if oprsz is < 8, don't we need to mask out the high
bits in l that would otherwise overlap with h << (4 * oprsz) ?
Are they guaranteed zeroes somehow?

>      } else {
>          ARMPredicateReg tmp_m;
>          intptr_t oprsz_16 = oprsz / 16;
> @@ -1952,23 +1952,35 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
>              h = n[2 * i + 1];
>              l = compress_bits(l >> odd, esz);
>              h = compress_bits(h >> odd, esz);
> -            d[i] = l + (h << 32);
> +            d[i] = l | (h << 32);
>          }
>
> -        /* For VL which is not a power of 2, the results from M do not
> -           align nicely with the uint64_t for D.  Put the aligned results
> -           from M into TMP_M and then copy it into place afterward.  */
> +        /*
> +         * For VL which is not a multiple of 512, the results from M do not
> +         * align nicely with the uint64_t for D.  Put the aligned results
> +         * from M into TMP_M and then copy it into place afterward.
> +         */
>          if (oprsz & 15) {
> -            d[i] = compress_bits(n[2 * i] >> odd, esz);
> +            int final_shift = (oprsz & 15) * 2;
> +
> +            l = n[2 * i + 0];
> +            h = n[2 * i + 1];
> +            l = compress_bits(l >> odd, esz);
> +            h = compress_bits(h >> odd, esz);
> +            d[i] = l | (h << final_shift);

Similarly here, why don't we need to mask out the top parts of l and h ?

>
>              for (i = 0; i < oprsz_16; i++) {
>                  l = m[2 * i + 0];
>                  h = m[2 * i + 1];
>                  l = compress_bits(l >> odd, esz);
>                  h = compress_bits(h >> odd, esz);
> -                tmp_m.p[i] = l + (h << 32);
> +                tmp_m.p[i] = l | (h << 32);
>              }
> -            tmp_m.p[i] = compress_bits(m[2 * i] >> odd, esz);
> +            l = m[2 * i + 0];
> +            h = m[2 * i + 1];
> +            l = compress_bits(l >> odd, esz);
> +            h = compress_bits(h >> odd, esz);
> +            tmp_m.p[i] = l | (h << final_shift);
>
>              swap_memmove(vd + oprsz / 2, &tmp_m, oprsz / 2);

Aren't there cases where the 'n' part of the result doesn't
end up a whole number of bytes and we have to do a shift as
well as a byte copy?

>          } else {
> @@ -1977,7 +1989,7 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
>                  h = m[2 * i + 1];
>                  l = compress_bits(l >> odd, esz);
>                  h = compress_bits(h >> odd, esz);
> -                d[oprsz_16 + i] = l + (h << 32);
> +                d[oprsz_16 + i] = l | (h << 32);
>              }
>          }
>      }

thanks
-- PMM

