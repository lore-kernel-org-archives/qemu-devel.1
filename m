Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C18C04AAD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975AF20850
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuQqDhKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975AF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37111 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOMWZ-0003sJ-L5
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 09:22:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOMVK-0003Df-OT
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOMVJ-00087f-O2
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:21:02 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:33352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOMVJ-00086J-Fg
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:21:01 -0400
Received: by mail-oi1-x234.google.com with SMTP id m204so9438744oib.0
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=JLU1dr3a6nhMIKpBug6cSiBb3t2x3IElS8SvjTFIkiY=;
	b=JuQqDhKPXxV1D+WFrx/dbrmIvhNnU3TlV2rSebtJTmY1bQ3t/qc1dDq8wf/X875/3H
	JbbiuPR8taAXHmFdzv1RkOK34RoLa56eYlfUx1XcKbqMuGmONFMyz1u/aqhQBT7aw2F9
	L4+pkg+gcniPJ/uAibTt4ieyQjTubZhGHLUJ1BUhlqPZM3G0wEMXqhi0Dj9pmSqFo9GE
	YTZ9BD8wsd0SVL2WZp2qsQVfJx3gEAXbEnB9685OmURk/X/FulpHf0LkADdKNaUpOA4G
	9rNzMyeiyv1Z0+tFVgVzET8MCjp6dVdwfw3DZw9Uz3FGPqBQqPYPI+OVhFPI6VzcVwLo
	hMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=JLU1dr3a6nhMIKpBug6cSiBb3t2x3IElS8SvjTFIkiY=;
	b=WlslhfEKoW81XjG9BMFmfRXnSqO6bbBrW/Rlp3Qq0urTelcD+VYyXHL+kmE1yH6qGY
	Mzzr46oxz/IYRnVHh3yCSZyGaZWJ4kCAgBXonqOkJfECWX9NsUVa76+EENcFdFNDlPI5
	jMzDtGGZpiwvqcLjo2+IcwPTUXdlbICuheFqugkQmQzcrv/kGkOjcTVNGqoFi3xE/ljw
	2HCi1/4Vp/d95f17UULYy56Pg9uBDiF1Ye+LQEuopS0pubo2LZz3s8nc4AnErkeeQ6Xk
	Tu8PwzPDdq+rkQOTGL8k8nQ1AwM6xSNga2O3QvJu0CCKjHutoS6UbRcrc8JZ7zjSdRbU
	WBpQ==
X-Gm-Message-State: APjAAAXeTYj2k67cYJSwhRpjsCg/262x5CzzbL/spmCAvjap+1Q8tIYN
	asKYtGPb/vOhOTFH/yq4i849VW018gyWF7XzKbn9yN2P
X-Google-Smtp-Source: APXvYqxv2CU/gYIQSm11luOmDWZqri3uHZHYme0oBZA0HT1eMNww4kTPr9VonZ/7C+inhIsTuZuqoAXFBVmLwtD9GAc=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr2283064oif.98.1557321659720; 
	Wed, 08 May 2019 06:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190507120011.18100-1-peter.maydell@linaro.org>
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 May 2019 14:20:47 +0100
Message-ID: <CAFEAcA8a9EXHH86k9n13QPA6SnhdUnbDjfZuXCmLLDB7xJRsjQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] [PULL 00/15] target-arm queue
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

On Tue, 7 May 2019 at 13:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> A mixed bag, all bug fixes or similar small stuff.
>
> thanks
> -- PMM
>
>
> The following changes since commit 19eb2d4e736dc895f31fbd6b520e514f10cc08e0:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-05-07 10:43:32 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190507
>
> for you to fetch changes up to 63159601fb3e396b28da14cbb71e50ed3f5a0331:
>
>   target/arm: Stop using variable length array in dc_zva (2019-05-07 12:55:04 +0100)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

