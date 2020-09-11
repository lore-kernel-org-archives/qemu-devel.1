Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E8C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9396C20731
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TR3X+pgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9396C20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjQ0-0006SQ-Go
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 09:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGjP3-0005Wx-0J
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:47:49 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:41011)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGjP1-00044s-6Y
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:47:48 -0400
Received: by mail-ej1-x636.google.com with SMTP id lo4so13871048ejb.8
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DPTzWY6sQa9WgsbnDrYYsM6mvezjF0/NuKEiE7uCFgI=;
 b=TR3X+pguFER2rLcfelyrs9fSEnfw8cQwDyOAsto2sYGWc34bX3jLXfL34emZNrX19R
 xL/pumEwUPygsWqLVgKHtJoxDb6sGacUXNamEoJeq4ASZBSageM6YJp5lvw3KUuT6gbL
 xkb4cJOc2WyRgXYbryx7Rk3gSzq92oCeiPZjntxdaGpEr7E9j4H0fF29psYJsVAcJ6Ye
 3VoGl7ZZzGdAwx/zrMueksPkYawiyzfhzP7AY/g761aKBhRATLwNEhgREhb1D9L7sI5R
 Hd3kZZz/a0OQwxe5d7Fqe+mFr6zJbFa32enRJ5M73J1Y/KlkhNTkIzSNGPdj12sl5AlA
 G5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DPTzWY6sQa9WgsbnDrYYsM6mvezjF0/NuKEiE7uCFgI=;
 b=Ehwp3951c+6pbs7ya4KpSeKRhaTiQJHgsxuVAyyiRpeFGFCaXwTHzUzlKLg5mTZY8r
 hMeXQLHIVDD7as15JXLxLuGmIIbGaJNAF16puRPRHrnvo8oJUY8NDpMud+Ph7rUMnM0u
 Bd6RREV5Da5bYl2c+VaFQzyWHufrk7UiBt7hKB1msQBDjKeCMqHOUYlf1NhjwznKZDuP
 WnK7zZPFxAweYr43HqgCRdVVRCDvZj1mKEgwQm4FFhgWDHwxAKWw33svPn8ijwg3bXRW
 wVJfkBjj3FgNLKUb+6WrAlvIHM5KryG3BI1iA/PZ+RGEAUU0viArJSZJtGtFmXD9Qg9E
 RIsg==
X-Gm-Message-State: AOAM531r6uqUi7fZ7QYQ1JcAm2wHGvmc9EzbICDBuuoiGfJqspLcHn4+
 D2Lc7LlYn0LnYxS0yPkaUEuA64RJSGyO6RaQMaedsw==
X-Google-Smtp-Source: ABdhPJwDDZ3iu6TxzfpLfokixawZDoPzdO1cvStQYxOjcCOXcOQKbG2pkN8amnEFmY93ILafYVKYdFYxKr6xFuzs9xg=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr2064463ejb.85.1599832063772; 
 Fri, 11 Sep 2020 06:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200910081049.38393-1-stefanha@redhat.com>
In-Reply-To: <20200910081049.38393-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Sep 2020 14:47:32 +0100
Message-ID: <CAFEAcA_WnokSYf7ifm4jJGkz1Y+7psBGpGVyCM+QePDqXptyfg@mail.gmail.com>
Subject: Re: [PULL v2 0/8] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Thu, 10 Sep 2020 at 09:11, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/sirius/ipxe-20200908-pull-request' into staging (2020-09-08 21:21:13 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to b15e402fc8861adb65d168d380f39b310599a533:
>
>   trace-events: Fix attribution of trace points to source (2020-09-09 17:17:58 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> v2:
>  * Rebased after meson and resolved conflict in "softmmu: Add missing trace-events file"
>  * Dropped "meson: Don't make object files for dtrace on macOS" (already merged via Paolo's tree)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

