Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC7C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21246206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUGQFmhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21246206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVm9-0000Vt-AG
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVko-0007lc-HQ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:19:30 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVkn-0003ag-OS
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:19:30 -0400
Received: by mail-oi1-x243.google.com with SMTP id r25so18340194oij.4
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nBhFze27TmY6tu2sIDwtvAnEG/0xhy8iMkQm4bljeik=;
 b=DUGQFmhrSgPQaFducqVBDAQX0GwnXOUWfzF4YJg1TparF0jKelE8W1u7mBR1pCoezN
 qjHDdoTLuevQnqv307zQlnh0PzClHR1DW/ub/gkteyTV2LsfB4WvH/gRTOT3bCSJgxPL
 O4lhev5LdyHO4pSH/Pv5spn+okeZXAMQ6T49pUUQR28v/VVZ0yHKSTUbf5rEitod0Dxu
 yuFQ0h9ZIXL394MxsM+kUUTUfrzYVpRS1Lkml+2xchXcRebnL7dD7JuUrptJyC/FqTs7
 K6oNtxbDKphDDAQQtVrrPyPxnZbzv2Xfl2bYJieE+9JrWbIH51L3agg+y70TWTK42qVL
 mbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nBhFze27TmY6tu2sIDwtvAnEG/0xhy8iMkQm4bljeik=;
 b=SI/75kWPBoEmEy8W5LOsobin1qJMd1XIr+2y1MGAEoTYzUK1m59DdewmKR8yWQICYz
 nFt4uTUI7bLQKaQWY4hSqdpCjo+SbmCdKGIJZyHAEDYNbcfWU13D+pO24SPcCl/VJDLI
 DuAoFXStzpY058kwpXOnDMwfsLkNvU7Ra5lfXwx3Be3OGOPApDBBUjMoW+2EzUA+N7pA
 MNmlqkS16W6ujuBPHn0YQ37Q08defGlzZt9YqodJmn0M+XnqrX16z9TdoWUGOICmTfVk
 IKZLNnwf9hZRfK5rJaGE8OMZdQtqgjLqWzpMfAtjjsqHqvQaNjKTyjtWYSVWPq1dRIlM
 IPsA==
X-Gm-Message-State: AGi0PuYwx0S5zSzh+8yagRItmkH4BdALYuyZsPj18+AmXD9ZW9DTEmeP
 k4wG0nSA7Rpih09vhP/z0rXuM9hOeLgyS96qUoMpHA==
X-Google-Smtp-Source: APiQypJ/EcyQgR8yUti6BdTKN/ItsKn52hrwRcJmwfu+tT4TT+nokxrzcToybBKNS42hTw151v524gAtzAl5Yv0JPr8=
X-Received: by 2002:aca:895:: with SMTP id 143mr23545353oii.163.1589293168526; 
 Tue, 12 May 2020 07:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-12-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 15:19:17 +0100
Message-ID: <CAFEAcA_MqC3Uk7d-NuUe-j0kKh6iFHps0usG2K+n3FyTZQyvsQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] target/arm: Remove fp_status from helper_{recpe,
 rsqrte}_u32
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These operations do not touch fp_status.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index 930d6e747f..a792661166 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -1023,7 +1023,7 @@ float64 HELPER(rsqrte_f64)(float64 input, void *fpstp)
>      return make_float64(val);
>  }
>
> -uint32_t HELPER(recpe_u32)(uint32_t a, void *fpstp)
> +uint32_t HELPER(recpe_u32)(uint32_t a)
>  {
>      /* float_status *s = fpstp; */

We should delete this stale commented out line of code too.

>      int input, estimate;
> @@ -1038,7 +1038,7 @@ uint32_t HELPER(recpe_u32)(uint32_t a, void *fpstp)
>      return deposit32(0, (32 - 9), 9, estimate);
>  }
>
> -uint32_t HELPER(rsqrte_u32)(uint32_t a, void *fpstp)
> +uint32_t HELPER(rsqrte_u32)(uint32_t a)
>  {
>      int estimate;

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

