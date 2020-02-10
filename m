Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDA1C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E7E2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QY8FNc0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E7E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j17qJ-000513-9q
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 07:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j17pP-000441-L3
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j17pO-0003HC-Ft
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:06:15 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j17pO-0003Gu-9v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:06:14 -0500
Received: by mail-ot1-x343.google.com with SMTP id 77so6033742oty.6
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 04:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=uAN3ghp/n/6vh/1hlFbQCNGnTqkVyNFft3uJxIbliGg=;
 b=QY8FNc0Kp0TUtJ0cyXAf4ojvtLP0ghyzIPsYpFYEy6Q2yF1OmK3bNvB7jPQdvAvZGM
 tz0LhGZB89kbeJT16DUJHSCEmVeweg9adc/CZC6ZP1icofuDLUzlUNfhfiPeGpb016dk
 gr87VHVECiUOxSx/tzlSBfwh0Ca2zxmTNpbbFNKFbAk2jSwO7PEqFqG5g2W7KN1vRqh/
 p2yZ3hOkicdcROlNztQfxdRKDJaszv9aVqrt46pKAGhlKe9Mjt8vHDDSeI9Vp+M8yOpd
 v89YERToITSBqojrMY1xYJkhIGymHdU/2LELoFzvwKJP2Ue2giF9M1dvPiKPkFHtVz/p
 bWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=uAN3ghp/n/6vh/1hlFbQCNGnTqkVyNFft3uJxIbliGg=;
 b=LwmKa39wi3HXGa0505OZXb1znxDAQvCBLJHCeomQ94NO+2A6YlPNDFIsFLGeV0WIu1
 +yrIAn+H6JgDfbEgzTLS4Sa50my2siEE5bq7NI6YXZsO/eLs8u1GY4O+Hf7HBocnF+TX
 Vqe3uru2QT8rvV4Sak2Eif8yMqkNwQxsEKTAr+UScGqm2w9EHy5YuiK7f0ndXMkirzRZ
 kWObPmJnJ10iawxUgEXQGhAtT/A3g1b7hAzahjT9wNXACue3j5UUtuNHihTKELawqwXe
 +chqmSUoDX8YE9nzqRKKtfuMX7cmOIuOlQmXxamBBAXHatcwKIlnI0oChb6o3m4amySo
 mPIQ==
X-Gm-Message-State: APjAAAUdakVdkzznjqmrLbGXvhyc2YMmDqTVi3f1G1+u7fMMM/aLZ3Z7
 RYNaaeiZ8srk7oMpb1PHiN/Vcp4So3TTnL0ff9XVbbl0
X-Google-Smtp-Source: APXvYqxnfzn/nURGyqLTYnJFcmqDDDwU60QCwzw+1KaPpGYxe3y2nlYLp4qJ9AUrVfKUS0Sq1IjPGqYi6MiFwS43ijs=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr803438otq.135.1581336372835; 
 Mon, 10 Feb 2020 04:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20200207143343.30322-1-peter.maydell@linaro.org>
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2020 12:06:01 +0000
Message-ID: <CAFEAcA9JtxMtc2N-=XQeKeDdZF17FpS4pTvr+6z6srZFxqqU_g@mail.gmail.com>
Subject: Re: [PULL 00/48] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 14:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The big thing here is RTH's patchset implementing ARMv8.1-VHE
> emulation; otherwise just a handful of smaller fixes.
>
> thanks
> -- PMM
>
> The following changes since commit 346ed3151f1c43e72c40cb55b392a1d4cface62c:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-20200206.0' into staging (2020-02-07 11:52:15 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200207
>
> for you to fetch changes up to af6c91b490e9b1bce7a168f8a9c848f3e60f616e:
>
>   stellaris: delay timer_new to avoid memleaks (2020-02-07 14:04:28 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * monitor: fix query-cpu-model-expansion crash when using machine type none
>  * Support emulation of the ARMv8.1-VHE architecture feature
>  * bcm2835_dma: fix bugs in TD mode handling
>  * docs/arm-cpu-features: Make kvm-no-adjvtime comment clearer
>  * stellaris, stm32f2xx_timer, armv7m_systick: fix minor memory leaks
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

