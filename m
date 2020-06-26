Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F69C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADEA2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2iuLHk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADEA2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonnn-0002wz-QY
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jonmm-00021Y-HI
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:48:52 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:40216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jonmk-0006L8-Dv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:48:52 -0400
Received: by mail-oi1-x234.google.com with SMTP id t25so7947002oij.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=++siMY8I7z85WmlHPh4Vsight/h6IhTQwtFdqO/J20Y=;
 b=N2iuLHk7zmTtnqLsaAtF989lz7ABE/9kTp76q88gflz4HTqRN6xqyKRDp09VI9VD91
 zQk4+p0ssdsh2gFQz1Vo71vR/yWHL8M/C6pX4In1CWkWk3M/bMOXZQo5TZxxa3x8USHx
 hvyuCp4QXheNfubpBMKaWCMUZOxtzn/m65AoLt5f49u5LOgf50o9/KoMnn8VXpaP6riQ
 D6FcU5wwCbokxWN/7sjUSPsd/8i8QKLZ1drksdQQGKOstoQ+lK0nzk1OlGna6KRgVruy
 yLFyMZs5y4nCQF0imegAXhPbvHerUpK5ITWW1i4b5/ZXcoNQiOEK3wOensm0IPqABqx5
 FSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=++siMY8I7z85WmlHPh4Vsight/h6IhTQwtFdqO/J20Y=;
 b=Il1wUcnvNJXipTULGZlKMvMVMssZzoxzbUTI6txVGYaiHTGI/MEzBcmEDFKje4NTCM
 Y+k6t7HYG38hX8dsWL9TMzx2W8GsR5rL5Eaa3Jzhq53b8A5mlEbH6+MuXKW9Coiptxax
 CyhqKYonWiblbhEjzKPhE54EoE8LbERqfFLtGK44+3jwcjtqBHNluRpXKFmweS5CVOYr
 /M9qNVsml1cySvXGBTxHq1h8aYYKSFwFNCS9TIQg78hghp1ZCINPrFzHxWoScb6acrkO
 m0ZsUQnJ4NxB34KqIYcnJkbIKA6Bhi/0XooGa65ckuJ4j4PU9WlcFXA0EFI2AN8DER4U
 GXLg==
X-Gm-Message-State: AOAM530JOGYDYROly8nXwGzK6fsmHZ+hiqaXAIo5fWsGGQZeOrPPZnxO
 OIxJMiDcAx7Z4FwcXBhDN0FS2WBc+4m6j+L58CiimEKOczs=
X-Google-Smtp-Source: ABdhPJyAwBpsZsrASR45xxyCayps37zsvkJVClsWeHzCGwE8VUFCGJF6cx+L+yi82BHZ+Hx4fjRI9+kPnYNvxlDGFtU=
X-Received: by 2002:aca:568c:: with SMTP id k134mr2109559oib.48.1593175728963; 
 Fri, 26 Jun 2020 05:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 13:48:37 +0100
Message-ID: <CAFEAcA-+sr4Q+iKiTbYa2z5n-DPkmqsNRF9oiHBW3Bf+k0A6nQ@mail.gmail.com>
Subject: Re: [PULL 00/22] qemu-macppc queue 20200626
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 10:23, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit 5acc270a355120ce967ca1f1eeca0abbdb9303c8:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20200625-xtensa' into staging (2020-06-25 21:20:45 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-macppc-20200626
>
> for you to fetch changes up to e590e7f01479a1d4544aac062fe9fdb986502294:
>
>   adb: add ADB bus trace events (2020-06-26 10:13:52 +0100)
>
> ----------------------------------------------------------------
> qemu-macppc patches
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

