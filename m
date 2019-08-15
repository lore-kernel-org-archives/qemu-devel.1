Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED9C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD01721743
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wg+w4F+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD01721743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyD6S-0003De-J5
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 06:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyD5m-0002bV-Pp
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyD5l-0000hL-Np
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:34:50 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyD5l-0000gh-Ei
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:34:49 -0400
Received: by mail-ot1-x344.google.com with SMTP id w4so4770052ote.11
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wuaRNQLmLhAHwn7C4YMQ4QBrE3stkQ5CO7o/igmRQM0=;
 b=wg+w4F+YeLVZk/eUMuhlqZVJ38mcwzATYaPXs4+FmpCFsdgRPHDuus4jKb9sICuyMa
 AyG7nZWwb9igjeBq3gTLP3+AvxjSbiDMMmKYhSxhj21VEan4izX3wtdvbLEK7fW7g3ke
 cwac9RMRevFnpmhZLPmGtqrMeQ7/8R5fBN/bLooZSvbdbBhRSCmWRBMV1HVWLJJV1vJs
 bYCp9uJQ+CngDFuwrGXCf1rg7ZPncERTVp2myqoIXfA2JSTnPpki6NnEHeP8A61/ikMW
 qaPiQdF5NlcGLTxREU84ECu72H0j4ZUo5q+Qibl2GJUEKr+UGjyYBz5cuLYHubhqaHGR
 tOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wuaRNQLmLhAHwn7C4YMQ4QBrE3stkQ5CO7o/igmRQM0=;
 b=WE5bEf9XBKQZ59jCGbQ6h/Wl9zXbwbv4ob/BkcTDH6QSwJN/V91li0S8QOIV4KCl2Z
 7NpyUKRLXnkLQkG7P1QUU/RVbgU2qqAEWAy0RQjb8nzm02YJA7J9ufdllpearY7d96vB
 r8Jj/szDc82sgDkRWe5CvXiIvZz3p5rQndgvQg9OD36n5wU+HDwYmoESsE7eN0PtNZKb
 tkeVm99AQtkwUucuOIux15E0SMhn8/h/sqqwnzY/Qk31OwYKS96eDlR7ZNwqm5As0GYk
 062rTq6bmw2q+yTvDThgeJJipYccuJElxySRx7UG8vP4otLJP3tr7IgN50lWtxK2pZxZ
 5eEQ==
X-Gm-Message-State: APjAAAUZJVpk7FlCs3ryS6pQapxT/+mJXqpaPql3f4EKsfp9AL9kCrfT
 M+dwOC4rETjunuP5X9V84S3ADeWpzjWVHLSraYS9Nw==
X-Google-Smtp-Source: APXvYqxOCUVxLWy05im/UmQn+ooEAf3KGj+CpqUYvmHyUCVRXpoJv8TRSG/dhw609d52NMySPcbr3YO5eDDm8uP5VI4=
X-Received: by 2002:a05:6830:2103:: with SMTP id
 i3mr3053755otc.135.1565865288391; 
 Thu, 15 Aug 2019 03:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190808202616.13782-1-richard.henderson@linaro.org>
In-Reply-To: <20190808202616.13782-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Aug 2019 11:34:37 +0100
Message-ID: <CAFEAcA_TiXH0KsqKVwjaC9bSqw2sUCvAGv3bxYecyfUkLhHF9A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 0/7] target/arm: Misc cleanups
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Aug 2019 at 21:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Some of these were cleanups that I was making simultaneous
> with the decodetree split.  Let's do those beforehand to
> make the split easier to read.
>
> Some of these are new, noticed while I was in the area.
>
>
> r~
>
>
> Richard Henderson (7):
>   target/arm: Use tcg_gen_extract_i32 for shifter_out_im
>   target/arm: Use tcg_gen_deposit_i32 for PKHBT, PKHTB
>   target/arm: Remove redundant shift tests
>   target/arm: Use ror32 instead of open-coding the operation
>   target/arm: Use tcg_gen_rotri_i32 for gen_swap_half
>   target/arm: Simplify SMMLA, SMMLAR, SMMLS, SMMLSR
>   target/arm: Use tcg_gen_extrh_i64_i32 to extract the high word

Applied to target-arm.next, thanks. (I had a comment on patch 6
but it was about the tcg docs, not the patch itself.)

-- PMM

