Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C5DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88E020838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTXoMx7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88E020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFup-0000QF-SC
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJFt3-0006f6-DR
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJFt1-00083B-Si
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:20:56 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJFt1-00082j-N3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:20:55 -0400
Received: by mail-ot1-x341.google.com with SMTP id c9so21730937otl.12
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 05:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=29o0+x8I8rOpXzLXlMZ+0SkdspZUS6/mbj3floAanmQ=;
 b=eTXoMx7VPMPHKqqP5W7b/lYNtCWPmNyKC6UkDp7IPkVBWMNmuTQT2FqawckVGCMIat
 WDVaaOq/hiGZ68a6hytUFQcnV1qYN6RZ1SGyTjcVuY6xAMBs0Woy0Es8CxnYSywXWJKj
 d44LalKHD9RZ4pJ44YlPkL9yk3RhDGGIk662px2fLvKa3N0+hQMhHxkrU/6Xtvo7vorP
 /taCHvUcXQlc1w23PyUqcGrsHhuPaXN1NTdcVVSJ61emex8qh4DsDhtowlh81s+lpBz0
 Yw76T3bpzgEClts7gqDtrBg5/xGCzqFKQDREqMfiSDjjGJCQhFLcvaZBiF8ij1UZioY3
 DvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=29o0+x8I8rOpXzLXlMZ+0SkdspZUS6/mbj3floAanmQ=;
 b=p3xwZS2CbWkVVGYqGCRthwbb6WaFjBPbo8gNYf8oEjXgkzvI5DSuBwpuw2p6lXPpqB
 B8nBFJ/lRhcGhij9sIudLQEJxS4WX/BnAfk8PClzhqBZfMAH1TgXDO/afbSF5cXU0FPF
 IldDJKMVtylHBf4uBow1IRfp1gonxD2aZXeKDk8qiMaZp09ZgL0y1vVk+g++03tH8zNS
 b5LruGZasowzSmbOpqth5/j/oHPwJWK0Qo55dZiBABm5/7zvY2fYwkUqYoe+H4atpHuB
 LwUhrO/h89yEvJ0PX/BmcG1jlp6yhmuLqECngP8xW+Wtz2z9jEe0bKuJujnt0DrG7i9L
 CW9A==
X-Gm-Message-State: ANhLgQ2fd+mGCc0FiHGYRqWlA6iDqJC0XkiD7raimq3+x3fTDHoIwvzS
 XcywjXkaRqyq/52oWSENK99gHBZ9azAee/mKasV17w==
X-Google-Smtp-Source: ADFU+vu8v5Bq8HW7ta7TOc0fFWcVCD8DO+wCVF+oLK8B21Yc+7/HjR7dQOyvHRPOb4Du9zq+Q8PleVTOIRGshqeRx/A=
X-Received: by 2002:a4a:a226:: with SMTP id m38mr13024100ool.94.1585657254599; 
 Tue, 31 Mar 2020 05:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200331035456.6494-1-richard.henderson@linaro.org>
In-Reply-To: <20200331035456.6494-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2020 13:20:43 +0100
Message-ID: <CAFEAcA8ZZPQpgSciPbHc+G03CwoPhfU++0=v5656nmtzjbYo2w@mail.gmail.com>
Subject: Re: [PULL for-5.0 00/10] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Tue, 31 Mar 2020 at 04:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> My tcg patch queue, plus one mips patch on request of Aleksander.
>
>
> r~
>
>
> The following changes since commit 5acad5bf480321f178866dc28e38eeda5a3f19bb:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2020-03-28 00:27:04 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20200330
>
> for you to fetch changes up to b412378785c1bd95e3461c1373dd8938bc54fb4e:
>
>   decodetree: Use Python3 floor division operator (2020-03-30 11:44:04 -0700)
>
> ----------------------------------------------------------------
> Improve PIE and other linkage
> Fix for decodetree vs Python3 floor division operator
> Fix i386 INDEX_op_dup2_vec expansion
> Fix loongson multimedia condition instructions

NB: something in your workflow is leaving the '---' and the following
v1/v2 changes info in the commit messages in pull requests. We usually
prefer to strip those out.

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

