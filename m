Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E961C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFB624683
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRDE4TWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFB624683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is92S-0004T1-4A
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 12:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1is91H-0003aW-Me
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:33:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1is91G-0007pm-Ct
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:33:23 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1is91G-0007pJ-7X
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:33:22 -0500
Received: by mail-oi1-x243.google.com with SMTP id l136so19588224oig.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 09:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0ZPDZo0jMU1ikuXpVDiiyq0aSPvd42ukajRTz1Bdats=;
 b=ZRDE4TWGmwxZIi/9SHI7x3kquTv9WHQ60uRhPs9+KM32HVYmUxnbD6sZyijh+Cagb3
 ruhdjm8AT17Cz4BAYCf5cbxAZ44I/JSQjVIEeDIJ4zmz8kOxBjcZHbYP1qTTrkyDrcn6
 frm6JPg0aZKFbUXEqz96C0MJTvJCNYb4Hug7bHIA/okQNroHer3y1MOlaEFy/XJAq0+i
 be4Tu+l40KP1qAqbvKyNPJ6HD19Hp0MmfTl0P9/RSbt63u/8Tv+tmfot68Kcf+qBMuon
 enFWrfzRbDgyXg39u4onqHcyYUWcaH8hVeNxnOYXLPyKqYkto2u0XoCR2qkX6O14wjW7
 z+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0ZPDZo0jMU1ikuXpVDiiyq0aSPvd42ukajRTz1Bdats=;
 b=eEim7KzAmT25KavePDNXXiMjEKL0NvCB+jtaU54OQ+qIAHz9qZDYv7y4bJSFOE7RxJ
 mLoa+gxYrb3rW9mOlQUcgfhQfa68R/17OLGaX9kzmXgDZ0G5514EDJ4Y9eJxPk1HB93g
 o8ICDkWbSPKQuk3RDH3jzJpIVkAIjP2cqmD7p5VQDSYDQWE7i3lnhZAjglgGFnf3dz73
 3b1f+ctUM+MGIvFExS8YKMgT5S0+KVK1wicUiRM315qFzXeNWqrh0N1WY09osfeLk6g0
 4+PeHPZInSFbJABk8yovd3lH6QrR5SX9F3VT9kW5pZR9xFS/DP37QB7pXlSRG0qwhdSR
 bOhg==
X-Gm-Message-State: APjAAAVpvctUBAO6GDuleG71hGFszuUIXndazVRf1CN8945wFjpHibVy
 1jPHcTXkS0R1dgkrupkG+CoTap4yT3qjdiYsuN/qIA==
X-Google-Smtp-Source: APXvYqw64hFrvoILnDE+AajhKI6PNO2eeX/wZ/NFbURRGCHaHDCvLtaWphrvbc2/AAgzpQcRoBKmMLOLH1yZ0qUYO7g=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr108518oig.163.1579196000981; 
 Thu, 16 Jan 2020 09:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20200109041228.10131-1-masahiroy@kernel.org>
In-Reply-To: <20200109041228.10131-1-masahiroy@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2020 17:33:10 +0000
Message-ID: <CAFEAcA8Z486dBHo-zkjw4eqLWRD9ukSdMmxqCk_rsV-oAkWcAA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/arm-semi: fix SYS_OPEN to return nonzero
 filehandle
To: Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jan 2020 at 04:13, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> According to the specification "Semihosting for AArch32 and Aarch64",
> the SYS_OPEN operation should return:
>
>  - A nonzero handle if the call is successful
>  - -1 if the call is not successful
>
> So, it should never return 0.
>
> Prior to commit 35e9a0a8ce4b ("target/arm/arm-semi: Make semihosting
> code hand out its own file descriptors"), the guest fd matched to the
> host fd. It returned a nonzero handle on success since the fd 0 is
> already used for stdin.

I think this bug existed even prior to that commit, because
in the old implementation we would handle the ":tt" magic
file by returning STDIN_FILENO or STDOUT_FILENO, and
STDIN_FILENO is zero.

So although I agree we should fix this bug, it would probably
be wise if your code using the API treated 0 as a success,
because QEMU's probably not the only implementation that
decided to use "just pass through the host fd"...

> Basically, there are two ways to fix this:
>
>   - Use (guestfd - 1) as the index of guestfs_arrary. We need to insert
>     increment/decrement to convert the guestfd and the array index back
>     and forth.
>
>   - Keep using guestfd as the index of guestfs_array. The first entry
>     of guestfs_array is left unused.
>
> I thought the latter is simpler. We end up with wasting a small piece
> of memory for the unused first entry of guestfd_array, but this is
> probably not a big deal.

Yeah, I guess so.

Applied to target-arm.next.

(This also reminds me that I never got round to fixing a bug where
if the guest does a SYS_OPEN on :tt and then a SYS_CLOSE then
we close the host stdin/stdout, which we should not...)

thanks
-- PMM

