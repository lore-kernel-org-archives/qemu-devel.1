Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47473C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 10:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D702175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 10:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQbyKCuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D702175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51939 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU76c-0001CD-5c
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 06:07:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU75k-0000tg-31
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU75i-00026i-Jf
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:06:24 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU75i-00025y-EC
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:06:22 -0400
Received: by mail-ot1-x341.google.com with SMTP id t24so8162420otl.12
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 03:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=cjRO5usI+3nJWBU69HZ2bNukSQBaUzWsMNtAqnqWm8I=;
	b=eQbyKCuJXrllnm9/h/CEGTw3BhCd4k/u+3JWNETAu0KrkenbTWs+rxxSN2s8sSU6Jk
	eiXf9DzKUcK9Lj3xK4cQxVV4XD2K2Y15O9JWpsGzvCYNwdH7RZHO+mrrWBgkao6dxeci
	VBdMnC/NYhgYQe5D0wi4zHImazchkatSE8cIsZ10z+DKsE7cTn0LdJQ0gePm7ChDCEpk
	K8SZxa8YtgSgqDRz/hI0BG7MuHQyJAgz+Z6b0sQ8mQHLl18t90GAZcJ4B/vCAUDlV+fU
	f5y1/fjAhKX5u5iqNaIImDik7kM6J1MFeiUAacRDTJncjfrkKYpKvcTJjHezbBJv3NnF
	dvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=cjRO5usI+3nJWBU69HZ2bNukSQBaUzWsMNtAqnqWm8I=;
	b=NM2iszwaoJeEADbqTQ3Kr5mRDiqmLQGLeP+TnF9IWPFKPFiT5O7zQmZlPk9NyMGMtC
	y9bIzHRFRw44vt0PJwZq0uxKOtfCKHdP6s4+5iBKZdYD+h1+iuzvvJA9fuYtClWZyBX9
	oJTTPBSHS2ksQc0HHSMPBzW3IGvDLIxlXvGzppE4ehqJf8mQMzpIsrHLDQuBU0zC2TDh
	Mk9ewUk/rMajoarrdQk3h/XIX2Mr44itYTO6EC0kSxEJaGjlEnaZ8ULYUIOhYgRWS3/f
	bbKeKtZJRoslQg1sb3nPgEUq8R0EAtyyK6L6NHbeK9COoiWX3iKBP56Y9R/HP9k0/v/o
	pzNQ==
X-Gm-Message-State: APjAAAVNgwkZMzgN3LuVU4mYcH34q6FcqQkvScVmM6aBFeapo9Pr8wny
	SExTPYYLywLlRQ4QLlWoggypLbQLLQz4fYrlfOlH5T6y+Zo=
X-Google-Smtp-Source: APXvYqyO+zRmXclKeDyg7/NTyZKQByF8IWn34qp8NTH3l1NxOV4lsKnpmxDffXYoHxMXVy57QMiGtXI3YK2BlfyICOU=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr24735002otp.91.1558692381002; 
	Fri, 24 May 2019 03:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190523142357.5175-1-peter.maydell@linaro.org>
In-Reply-To: <20190523142357.5175-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 May 2019 11:06:10 +0100
Message-ID: <CAFEAcA8QWMFSwvQ=xEMZYKQFM+GpuCd2Q5s=JMcAa4awMGKtOA@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 00/12] target-arm queue
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 at 15:23, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Not very much here, but several people have fallen over
> the vector operation segfault bug, so let's get the fix
> into master.
>
> thanks
> -- PMM
>
> The following changes since commit d418238dca7b4e0b124135827ead3076233052b1:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-rng-20190522' into staging (2019-05-23 12:57:17 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190523
>
> for you to fetch changes up to 98e4f4fdb8ea05d840f51f47125924c2bb9df2df:
>
>   hw/arm/exynos4210: QOM'ify the Exynos4210 SoC (2019-05-23 14:47:44 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * exynos4210: QOM'ify the Exynos4210 SoC
>  * exynos4210: Add DMA support for the Exynos4210
>  * arm_gicv3: Fix writes to ICC_CTLR_EL3
>  * arm_gicv3: Fix write of ICH_VMCR_EL2.{VBPR0, VBPR1}
>  * target/arm: Fix vector operation segfault
>  * target/arm: Minor improvements to BFXIL, EXTR
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

