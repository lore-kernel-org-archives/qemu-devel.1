Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445B6C47420
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5BA20754
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9a8F5rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5BA20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNyXu-0004il-PH
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNyWb-0003ZA-2V
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:21:33 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:46722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNyWZ-0007rg-EW
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:21:32 -0400
Received: by mail-ed1-x541.google.com with SMTP id 33so5242580edq.13
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kI5N9woVdkcmZaqXXWsHrrg9RlktdsmqJsWFNEJvQ2o=;
 b=q9a8F5rcd4bVA0oXnHxYCIfKGqFmW+ZXuWrmuxhrG9ev8ETjy+5jky8KRHmLKMxP5t
 xU4lSzZ7DHrunjpu4+Nd0NIiOeoLgLttUN22RAo1QqGgyTohkfBBdDwU5WNdmxfIsW01
 n6b6Q57D4TRWcNn67odde+6QFj1G3qPi92uPvi09hCBkGPEG5XZBDkSc2OA69TM9TLt8
 jrx2ax5XT4hVN9e4/1oQk8GNnhITwhPWss1fFj66zhjtEdq4OITH0hcLPK4IkekPUYnS
 ND65Qfu9D2XNAFcspmNiZqcEbVBrXjst9ke6SFyHZewnmBLbcHz0m5fotxsLbzoec/gu
 xowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kI5N9woVdkcmZaqXXWsHrrg9RlktdsmqJsWFNEJvQ2o=;
 b=hw16fKnrR42IuMjHKxG+z/JTukmckaa3Eq/gAL/lfoNLRPNPlYyr61BGMCaT4+3sNc
 qztirjb4YydalAtf8MP78/x6Qhb0rCYVKVJ7dVvwXhAZKkhC8SJaTpgEFtqRyszCOEWl
 L5TI/zavIrM4T1/70K6EVceqwlmJ8vsMTsRA6+2SFvYPtWS4AjV7nj7ZZdDk03bhYETr
 DuLpCCqnNiY71LFRtA6lAqaBYH0wSFRKXtgbFt0OdeiR3iwBFTNzzm1br2nLk3+sCHWx
 e8Ske6O+0nmvjMY+deULhnmvs1bY5Fa1YnPiW7Xy/VQbophZOEOBGjlfulpMt0FIHUhF
 6eSA==
X-Gm-Message-State: AOAM532+WAxjmyRFLO7xTuWoYSQzBmhysqNKN+jofOHwO1/trFOmeFan
 CZiFQcklx0YOxMg/u2czNeYqxucO+Z6fRrIrwUatSw==
X-Google-Smtp-Source: ABdhPJwQY2mDDXsOf8OlO3Be20XB4Jj5yI/qmcHFryfC92vDM5xKnzTJQ2qve6svZzshMYrZeP1KSjHQd9iztP5ZQmk=
X-Received: by 2002:aa7:c7d7:: with SMTP id o23mr6269798eds.44.1601558489406; 
 Thu, 01 Oct 2020 06:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200916014102.2446323-1-richard.henderson@linaro.org>
In-Reply-To: <20200916014102.2446323-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 14:21:18 +0100
Message-ID: <CAFEAcA8yrvreS+4VpLymBynFcsHinAfbX+BTJ0YqtH9WGyfYAg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix sve ldr/str
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 at 02:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The mte update missed a bit when producing clean addresses.
>
> Fixes: b2aa8879b88
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

