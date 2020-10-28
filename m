Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE74C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DAA247D4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZnexfNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DAA247D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXrcW-0003yB-DT
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 16:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXrba-0003L9-Mr
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:59:34 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:39035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXrbY-0004tw-Ms
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:59:34 -0400
Received: by mail-ej1-x633.google.com with SMTP id bn26so644769ejb.6
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sF1VirB+M+pEzLh1yCLKstOE6NCpjgMLDF0n9vcdnC0=;
 b=zZnexfNP+aQQ469lmiSCaV9l5D0huVnqbB3cRpXakMx/tGPkUddynPGaGzdpC3eiMP
 ihJuEvAUq8ti8kWix95xh+Y+5cxpMFAt8aptftx8tlFNwCIKfwj0F90lZNWrDppxrtpz
 D9M0SqI4GTjEhdIe6y+lV1bwCcAnfHm4GhInPiksTt4mksFWyqAGmW7rEEuJv0LigtHe
 4twfHUQ38VgbskEcEJVmxxQjpFCg6lS02T4/r7PJoZGF+zrLV1D3ik2TVSDywhqxWTNL
 1CzIv/3/d+c/7ZoGLMbGWXu3LINoUoSmbdU1pXS/zZUGyravKVzXbBz4GHvTmcuIl6Y7
 xhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sF1VirB+M+pEzLh1yCLKstOE6NCpjgMLDF0n9vcdnC0=;
 b=R5clnrsaqOxmGDGw3V0IT2dzic6RM+DlnghLANIjOe3KSscd3hA04KYqYYFWhINceo
 m8g47kgOJIw0VqbdeRPMeOzyuuK1RYYdBmxhhyVV0hA848iClpBOkxs5+lf5YTOk3ywE
 9oDkaFDJW+h0y67rj2m/txjbVkrqYtBHJhfstAsvAPM+54U9Dz7qb3+k6mdnyjPRW6Yn
 1kr3usio6MZAxJpNpK1vrbRVTvYZbglgFElNW3HZN4VkqSLhV2KHzd2zwQQSec1dgeta
 HYXgRaYtRVra1R55x6sVPZFT2lKsCFs2pFxf0SSx9UjPRN9niwcKZcY2hMvrEiaUB8BL
 davg==
X-Gm-Message-State: AOAM5331u84JSY2HQAEIRgDh2T4o7LlmCCJQgP2PMDrHtsmWAqRt5Saf
 3jSdH5/ZcvxJKT9IfH+7l13aKo8mHUdWEOKokdmLcA==
X-Google-Smtp-Source: ABdhPJz5kbfT8U4bLMEbKEITWS4S/qjcTk0Gbq5wDdyW218N4q4xvkgKzPc8NR9ziD3ePhnQ3Y6lHiXn4nDhZdnDFNM=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr684661ejk.407.1603915171215; 
 Wed, 28 Oct 2020 12:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201026232935.92777-1-f4bug@amsat.org>
In-Reply-To: <20201026232935.92777-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 19:59:19 +0000
Message-ID: <CAFEAcA8oRgDQtmfm0X3-+NGApSaQPUUGf9mPm1hxo8u5fv-a+g@mail.gmail.com>
Subject: Re: [PULL 0/8] Renesas patches for 2020-10-27
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 23:32, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The following changes since commit 1dc887329a10903940501b43e8c0cc67af7c06=
d5:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-202010=
26' =3D
> into staging (2020-10-26 17:19:26 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/renesas-20201027
>
> for you to fetch changes up to 81c76433407a1c5b5560a3b8fb593671667e9b13:
>
>   target/rx: Fix Lesser GPL version number (2020-10-27 00:22:56 +0100)
>
> ----------------------------------------------------------------
> Renesas patches (SH4 and RX)
>
> - Fix few warnings (Thomas Huth)
> - Fix typos (Lichang Zhao, Chetan Pant)
>
> CI jobs results:
> . https://cirrus-ci.com/build/6368903343374336
> . https://gitlab.com/philmd/qemu/-/pipelines/207919103
> . https://travis-ci.org/github/philmd/qemu/builds/739133105
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

