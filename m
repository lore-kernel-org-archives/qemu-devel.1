Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A93C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2BA206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5oHFlPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2BA206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtxn1-0002a7-Ik
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 14:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtxll-0001k2-3s
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 14:29:09 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:36373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtxlj-0005oy-0H
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 14:29:08 -0400
Received: by mail-ot1-x330.google.com with SMTP id 72so4883766otc.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=63ZT757P5weU9D1gEkdPogX86zZV2Md4Bn6eVgv+H38=;
 b=u5oHFlPk+PviXgvqv3eg50G0VYKC+wJZYmRw5S5Xx3AkHWiPW26yZNFeRDI+Uz31iW
 lBtswkddEZytCy7sPm80GUyUxZs/xca7iCag2x7BF9BG6yRIhJlxeH2STZ1oalIMlxAs
 KpvlMaDMJk/doDsJlryZwPysKLJI1NRAKofcD9Ftb4WccLjrwdL2TGOQ0ZSYOSr3bQh0
 Ds6NeXWGTjMhVyukO9Goi20l1WZJbY1JM7Iw2UJTNHg/xjuN+zYSAssvy0XD9dMK9hTF
 stLzpobr/+HABo/D+GNMfraZrT64mrvmq2BTdo+ItOYdaHxuhPtFLdX9YEoj84U4y2+J
 fGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=63ZT757P5weU9D1gEkdPogX86zZV2Md4Bn6eVgv+H38=;
 b=fGGj4rTLw1xmszhC1pCijalqd309GpCA52B0gYHMryPxHMA3IEQO6i1h10KgMOYLER
 9LwKiJw/wr8TWWEW6Ay23I3LAP3Lz1uAEpoF1CoTYoyI+s40qyLdGr5QiOZ7mReGCyek
 FR7Na8aw9LC/fFX2xaXCwfyeZpL10Tt/TKvsdjYiOwCfPr7xmpbUZzDU+Lw9jRuQ4xfl
 cbWJizUzQbSeYR1fJJylQOqZWcR9POg3iFsGAX6RVeUkzfNGKiTVbzOztW8yAgv3vady
 V/HngXoXVdRx0wSMz2NWD5zFksG0n3YuEAonr9jTNTStkxjjoXhvmhy4D/ELnbMVXmno
 xJ8A==
X-Gm-Message-State: AOAM530mHI46i8goe9vjkaq2fp55yEVFODYoVFwukcFfqG3eZ0SPVVkS
 IknqHoE7cj4YTfDVuICWwz4BVIbHBnIkMyLHYIT5msCt
X-Google-Smtp-Source: ABdhPJxcsCisJDuORubEMj9hcxIeQDLJsyzIoD976PWiya7vi0ja6xesz8IT9FlEgjuqn5Asm0T1mY2hSjPwiSorjnM=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr51466110otk.221.1594405745535; 
 Fri, 10 Jul 2020 11:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200707210749.18699-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20200707210749.18699-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 19:28:54 +0100
Message-ID: <CAFEAcA9sX0KBoRwLziAXtawRCWodnU1PZX=q3VSQm_5kkv=s4Q@mail.gmail.com>
Subject: Re: [PULL 0/1] qemu-openbios queue 20200707
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x330.google.com
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

On Tue, 7 Jul 2020 at 22:08, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit eb2c66b10efd2b914b56b20ae90655914310c925:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-07-06' into staging (2020-07-07 19:47:26 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-openbios-20200707
>
> for you to fetch changes up to 1e04092feecfc8caaf314df2670bf9c645a0b122:
>
>   Update OpenBIOS images to 75fbb41d built from submodule. (2020-07-07 21:54:37 +0100)
>
> ----------------------------------------------------------------
> qemu-openbios queue
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

