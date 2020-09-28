Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5225EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 15:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03512075A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 15:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPQw6qL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03512075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMvQX-000395-Rr
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 11:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMvOo-0002PT-Gk
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 11:49:10 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:39348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMvOm-0001Sr-CH
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 11:49:10 -0400
Received: by mail-ej1-x630.google.com with SMTP id p9so9222993ejf.6
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ttw+TU6VsZYGQg1kHmP3ni0TLoY2zJuzQRwAgvD5cYQ=;
 b=DPQw6qL7Ji/WMRQ5ReL5mLrazcNrceuk2oHPa9vi3GhCTaZ8rrO9Z1hm5eEHxF/Jkr
 fI4CgxO8y0D08/n+WThC8q8rv+lsstu2tMECBmJ2LukjvsF2SXCUdEfkilzZUF+StULr
 1UBQnXXh5gOIu+lEQk6VcaQR6XIStLfjvaRcJh0MKRVtgJuPh8ZoUwxcAX3rJiwN0hZp
 Oh/FY18wGnFsL4vFLKLWCN6HzFh0X04npuYAX0bNaXtgqe/mQvE0oZB61e3JRRmzvTTp
 tzQse3+ThuJc0FMvZFToWjCOAAPnfOnYz8sJTkMO50x0QIJLZGcLGDhqBshwflB4y7Ys
 vWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ttw+TU6VsZYGQg1kHmP3ni0TLoY2zJuzQRwAgvD5cYQ=;
 b=HlzYkQUIJYmcRosJ2X3YgJ8hjknFWLbvGs//5FZiMvYzgSJbOdiG9cYUZubF+9YLg0
 MQWjoD2WfnH2aXdMACljYixW34eAp+aTH6ziAt3ryHMIg7uBj2NExeXzZjqZjGq2tYcJ
 jFzpQlLKq7bsyT64TKfiWBrw6wZar/OcrRvoAAD7GaKOwp+m+Ql3N8BVK+Pr0NPsyFCn
 vxXZn8QIJfJocqLEKBDiKHFyZPkMN1pq21HGQ2OdsiYu/blfUOzrKD1+0aVMWl6U0PvY
 BvSNApLNY/Ou7ZZm8nQoUYZTTsDbUKrzV2710WIMVlYuiPcysvW/zq7wS4bXnghBKGqZ
 LNLg==
X-Gm-Message-State: AOAM530dM1RcmxrXSgkq+yEshwnzs3sbYRMRHQVxE2t7vA1eEegKPCnB
 xEKeyPRO6GfVTOeQgIuziqnn+KGdq5SIoRjmn7Vcbg==
X-Google-Smtp-Source: ABdhPJwMSjLPiP8K7SHH+dv/REIlEKH0Nyhze6dO/tnpUU2s5Y99gAyaa7hOdkjpDRXGJDp7OK+TFYDeTdu2q3M6BsY=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr2404568ejv.56.1601308146586; 
 Mon, 28 Sep 2020 08:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200928091602.383870-1-laurent@vivier.eu>
In-Reply-To: <20200928091602.383870-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2020 16:48:55 +0100
Message-ID: <CAFEAcA8jPB4zt_8h_LxS=NXeysirmowjTQM3buvMQeQOwnfsZw@mail.gmail.com>
Subject: Re: [PULL 0/8] Trivial branch for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 10:21, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit c122bca9cd7b986be4d473240a4fec6315b7a2c2:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-bitmaps-2020-09-21' i=
> nto staging (2020-09-23 15:11:38 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request
>
> for you to fetch changes up to c66790b5dfc2430c04bf5876cf485e1f538af7f2:
>
>   docs/system/deprecated: Move lm32 and unicore32 to the right section (2020-=
> 09-23 19:19:57 +0200)
>
> ----------------------------------------------------------------
> Trivial Patches Pull request 20200928
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

