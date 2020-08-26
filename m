Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC48C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EFD20825
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7544kPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EFD20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAyBf-0002R3-H9
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 12:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kAyAn-0001Ba-Iy
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:21:17 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kAyAm-0006Rh-4g
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:21:17 -0400
Received: by mail-lj1-x243.google.com with SMTP id v9so3047565ljk.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=FzuqdgMVAbOHPhjMlBNHfTWpwKAsl3mbdeA9W34Vynw=;
 b=t7544kPddpwle0PCvku18ofVKIGEs0qCJhDSVy7ZthieQwa1XgFM2qb9ZZoQpzfomV
 Rc3NQ7Gt9+XICVc3HgtScF+Enq+etZQ9r3TGgqkVuW4tsdeUsgu0mv4IqlbPOM9UrhW/
 /t6GUf6Oop3Tfj6KxLNf0HyweN77ycJLb3E2f0Zb2xYclQOXp6gzG+UTHIVn/IAcgZJp
 dNO9U1Fv/20dxCH+3BquyrJu3t3e5rqu0Pjf7CL0fE6mEjhrknu8/B2v+qoHD/Bpd0MX
 E15QyQyFuJYhO0Nd6Hmcado8t6l+/REj+BLCMvfnmld34Eg+ZRdHgiD0yUSqOFz/U2G1
 Sclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=FzuqdgMVAbOHPhjMlBNHfTWpwKAsl3mbdeA9W34Vynw=;
 b=GkChKTilWWD1b1lP3u5tX6mSF4PykaY6F/WkKhdH25vzP+L3TFKoV8kcE8LCuBICF5
 W9Jc6DOZ8aquUYvV18s8KSonszCGnNayW3pomqoCyuDyDUv8aJ9GFkUqH0UpCM/e66kM
 ez02spNYNVYeVlqC0iq9IluvvmogbZ1XFIwc1fwPx5JTV9PHncwI3b74e/U+1AfrjvU0
 bX3XnaELq0PQt2OfZoVDeS+JpIBzT6T4bw3h8ei3ROzJ/e6dVwSz9iC8Wt28q8bXadvp
 hTHZUi52xCXAWO9xzydtJdGL9eD3B81LC9lZBzV/NjPAERqltAoPjVs35vGAB0ojdxX9
 E//Q==
X-Gm-Message-State: AOAM532E4Ofv4VIqJjBQf/F50tY80k7vJJN10vZ7zMjW4yIuqr9IydnS
 WODwOgCoXQ8tWu5gqpfsWCY=
X-Google-Smtp-Source: ABdhPJxPWL4MDtQvv2RMg1LVq6kaSxK3smFREK67a+mJ52ETxcPz9b5EYb9xjHr1WH/BGGQb+vlhQA==
X-Received: by 2002:a2e:9003:: with SMTP id h3mr8023289ljg.185.1598458874257; 
 Wed, 26 Aug 2020 09:21:14 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id m8sm257449lfj.88.2020.08.26.09.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 09:21:13 -0700 (PDT)
Date: Wed, 26 Aug 2020 18:21:13 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 03/77] tests/tcg: Do not require FE_* exception bits
Message-ID: <20200826162113.GH2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200825205950.730499-4-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.066, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 01:58:36PM -0700, Richard Henderson wrote:
> Define anything that is missing as 0, so that flags & FE_FOO
> is false for any missing FOO.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  tests/tcg/multiarch/float_helpers.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tests/tcg/multiarch/float_helpers.h b/tests/tcg/multiarch/float_helpers.h
> index 6337bc66c1..309f3f4bf1 100644
> --- a/tests/tcg/multiarch/float_helpers.h
> +++ b/tests/tcg/multiarch/float_helpers.h
> @@ -8,6 +8,23 @@
>  
>  #include <inttypes.h>
>  
> +/* Some hosts do not have support for all of these; not required by ISO C. */
> +#ifndef FE_OVERFLOW
> +#define FE_OVERFLOW 0
> +#endif
> +#ifndef FE_UNDERFLOW
> +#define FE_UNDERFLOW 0
> +#endif
> +#ifndef FE_DIVBYZERO
> +#define FE_DIVBYZERO 0
> +#endif
> +#ifndef FE_INEXACT
> +#define FE_INEXACT 0
> +#endif
> +#ifndef FE_INVALID
> +#define FE_INVALID 0
> +#endif
> +
>  /* Number of constants in each table */
>  int get_num_f16(void);
>  int get_num_f32(void);
> -- 
> 2.25.1
> 

