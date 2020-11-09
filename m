Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CB3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D4820731
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0THCknC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D4820731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7j3-00039F-4y
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc7dg-0005z7-1d
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:55:20 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:45476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc7dd-0005tQ-Ne
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:55:19 -0500
Received: by mail-ej1-x632.google.com with SMTP id dk16so12313343ejb.12
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 05:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZyuOdxYj/uh5T0hx9OPA5xmtuX1wzUHyAh3UvmZNJec=;
 b=p0THCknCmMZ8Pq5cyv+LEcXGXzLlvMOKwPStTW7evmMuIcK4RPtEaLYHpZXqgs6q3A
 mxT3nt8ZkjEsVr948nE8qYNxNms4iCe6uNHsQNmX/CEsQl7IVYJ++oYR/A+o6Ww3vLjo
 TU0tF6jnQrLM85uvqW5YNRX22i1qTHoeZOHmWmQr2bFJBy9yQnGaH/fJku24i8bZzuxl
 VLHrO638T/lZ3E9xCdTdKWpdtYgibOtkqneN7M6MHRoh1r19yBpSMNQc/EHH/ZIbT6UT
 lZJXVMJj3vgljRun5SZdin43ntveOIKPbmCBkNeY4nECa1Ymhn+FRnto7ozLNhY30Uwk
 GRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZyuOdxYj/uh5T0hx9OPA5xmtuX1wzUHyAh3UvmZNJec=;
 b=nWoFMLtSeNcBg0ycWU3FwekOtbO/3OAwcwe5+FCPLBiT6c27+Kurb+vTdlK9NBfufh
 O6vGaGCP4iQOjMeOQ5FUvVZMrgPeT9v3swzTG3dHkEk3IUkMSnJgvFDyNknZxxWnyIVE
 tCiHWuHrYIxY6S8wYhboHT189oQGCf47rEq8OjzwSUKfKZXpibNDeL3uW1WPUfb0tokw
 7I4ddGJr2gv4PzjU4dhtN0ln/kuh7Np3WnRCLJ7giC4TJ44RVletHrBqHy7xFaJAH24Q
 lJeleLIufHjmp7cnMc0PTeuEsHGkjUO+QSWCXXkPwqMs1DjZ5+IJwA6bR1WjXKmetlEr
 YWRg==
X-Gm-Message-State: AOAM530pdIZUX7ZobjNgg7zNfheFCQWtm9qj/FpjVP7u7NSLahThnr0k
 bgnRZ1IUuoTGcu3kL1Th+VS5AqIXeKtd8DdlMFIUA+/u1HE=
X-Google-Smtp-Source: ABdhPJyj91i0VutoyX1V5gnd7VrPnqyYAvR05Q9afeX7crw7IUxGwwo/7t+6yf5u/kF1OwNfFz1bL7A13gdaSQdqm9U=
X-Received: by 2002:a17:906:5a88:: with SMTP id
 l8mr5739775ejq.407.1604930115736; 
 Mon, 09 Nov 2020 05:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20201108235915.2396150-1-f4bug@amsat.org>
In-Reply-To: <20201108235915.2396150-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Nov 2020 13:55:03 +0000
Message-ID: <CAFEAcA8FR3DNjkhHEMerwMbmnrrHhqdZuDDBO8WaD7uxkiLSzQ@mail.gmail.com>
Subject: Re: [PULL 0/2] Renesas patches for 5.2-rc1
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Nov 2020 at 00:01, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> The following changes since commit 3493c36f0371777c62d1d72b205b0eb6117e21=
56:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201106' into =
staging (2020-11-06 13:43:28 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/renesas-fixes-20201109
>
> for you to fetch changes up to 60f6de8fbafa5dc57af63792e3ba1a910239d195:
>
>   hw/rx/rx-gdbsim: Fix memory leak (CID 1432307) (2020-11-09 00:53:07 +01=
00)
>
> ----------------------------------------------------------------
> Renesas patches queue
>
> - Demote target & hardware sections to 'Odd Fixes'
> - Fix memory leak (CID 1432307)
>
> CI jobs results:
> . https://cirrus-ci.com/build/5340929353580544
> . https://gitlab.com/philmd/qemu/-/pipelines/213407241
> . https://travis-ci.org/github/philmd/qemu/builds/742315021
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

