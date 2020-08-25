Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BDBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A5E20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcOPay4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A5E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZLq-0005xS-DC
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZKm-0004wP-QN
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:49:56 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:36394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZKl-0007wL-3C
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:49:56 -0400
Received: by mail-ej1-x643.google.com with SMTP id l2so10596364eji.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IrwLCuwFbPGLYup8f/G3fqANTB3ttMDuHxDlYTNB3XI=;
 b=hcOPay4ViyGxp55HZWkG1kD9BCUdFK4WUtCRFVau7ruVHetxS+zIB1gNFzlDbKLm0u
 W6VzfeCK+fHvVNmf4sbw281mDs0V75xdkGU11tBJdQB2aE2VpbjMPNYgtd0VG1SjoA0g
 8ATyOqGAHOq0P25L7Q0DUPy1vasstEh+jVWwafojyPoNVMLNJjcoSKjqH44a2Ns+RNlv
 4gHdpA9iRg7I274DE8kVhIDQ+5K8/3I/tlyKQtiT7BfRC9KIo4uISPLqSXJvtm5616hJ
 PB5LcfZMbjVzKDJ1qY8Dp0XkjDTTLfaM9UzAYycxFgFs7qKKQfUFb4PBTPOu0YYl5Yt0
 cFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IrwLCuwFbPGLYup8f/G3fqANTB3ttMDuHxDlYTNB3XI=;
 b=hbyOxJdd3I13QJQkwXlji/jpJZ1ReLbiWfkd6St7Ct7XzPWvM+j3g0xJzVDe+lgAjV
 7/EOkKZQhJpZQSxDC+6XbgZwDHcDkYh3xmqtCaaev89ZQ8RlsBqoBJAquBaQcYNZta90
 DZy8b9eTgPXX10ZlqdK2NGFSAIxVqURhVTWkcI18LtnMV3YMkvThvnUOk91mQ0pYbeH+
 o82qZE8qNf/WCKwAG2iET5cu/iIeAQ3F8zYDBiXznZYx1Okarv6HLI0zaafEJhi7EEAN
 8CVSchuFss/cNGqDgSHrS9YoAfjIU8mqIX2Un1RTohSOyeke6UopUwiEFe0qVg4mwtLR
 pQGg==
X-Gm-Message-State: AOAM532V6IvLxYvwQnAWpMda0zKc22yMui4TxXIfYMvJ2z2y+5JTVjdH
 bf17/7chIhgHdGuJsUWcbGkiCll+R+zEL97xlyoalw==
X-Google-Smtp-Source: ABdhPJyWAWBT0oZoFvlsUNVQ2vhdpNIW0wx0xuDlJcR3Bg5r5qEbg0UAO7bApsjXRUFRjyRIT56vm9EfvJVy/gEz85A=
X-Received: by 2002:a17:906:2b0b:: with SMTP id
 a11mr1027071ejg.250.1598363393531; 
 Tue, 25 Aug 2020 06:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-17-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 14:49:42 +0100
Message-ID: <CAFEAcA8s==-CGT88P97xFaxcNkOf6WdNYi-3HSwjWRBXh+KQxw@mail.gmail.com>
Subject: Re: [PATCH 16/20] target/arm: Fix sve_zip_p vs odd vector lengths
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
> Wrote too much with low-half zip (zip1) with vl % 512 != 0.
>
> Adjust all of the x + (y << s) to x | (y << s) as a style fix.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/sve_helper.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index fcb46f150f..b8651ae173 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -1870,6 +1870,7 @@ void HELPER(sve_zip_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
>      intptr_t oprsz = extract32(pred_desc, 0, SIMD_OPRSZ_BITS) + 2;
>      int esz = extract32(pred_desc, SIMD_DATA_SHIFT, 2);
>      intptr_t high = extract32(pred_desc, SIMD_DATA_SHIFT + 2, 1);
> +    int esize = 1 << esz;
>      uint64_t *d = vd;
>      intptr_t i;
>
> @@ -1882,33 +1883,35 @@ void HELPER(sve_zip_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
>          mm = extract64(mm, high * half, half);
>          nn = expand_bits(nn, esz);
>          mm = expand_bits(mm, esz);
> -        d[0] = nn + (mm << (1 << esz));
> +        d[0] = nn | (mm << esize);
>      } else {
> -        ARMPredicateReg tmp_n, tmp_m;
> +        ARMPredicateReg tmp;
>
>          /* We produce output faster than we consume input.
>             Therefore we must be mindful of possible overlap.  */
> -        if ((vn - vd) < (uintptr_t)oprsz) {
> -            vn = memcpy(&tmp_n, vn, oprsz);
> -        }
> -        if ((vm - vd) < (uintptr_t)oprsz) {
> -            vm = memcpy(&tmp_m, vm, oprsz);
> +        if (vd == vn) {
> +            vn = memcpy(&tmp, vn, oprsz);
> +            if (vd == vm) {
> +                vm = vn;
> +            }
> +        } else if (vd == vm) {
> +            vm = memcpy(&tmp, vm, oprsz);

Why is it OK to only check vd==vn etc rather than checking for
overlap the way the old code did ? The commit message doesn't
mention this.

thanks
-- PMM

