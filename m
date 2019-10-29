Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA88CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 18:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0936320679
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 18:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8VR3fF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0936320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPW40-0004tD-2y
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 14:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPW2d-0003nr-CT
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 14:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPVtG-0004cj-KF
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 14:06:47 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPVtG-0004c2-Ed
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 14:06:46 -0400
Received: by mail-ot1-x342.google.com with SMTP id z6so10596999otb.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/ZpOBpkmuHhyFlC0yLyEw0pQYVuMMLKFxg7JU51845Y=;
 b=n8VR3fF4Nvfs9ryuFx7Y1f9dTKb3W+9MVZmab4KogY8JlfmuJgHLPfLV36TqJek2T8
 pxQ1bu1YbNgFe3swNuKy9NtqIfUM37vC86mNpFPMGv+y3LXSrB911jMmmHwBCrLMFRBx
 re3fMII+KKWWhhNEbJjwUmTo6YgGFWnFgKwX419uPdhUIOXTmbetzaOUw9CL6FzbIkVU
 GGsQVjXMKwajr0MiDaOQ1X5CYvFbqDOBa1Gd8pEBTHK7AIk9mpQnOQ1acMyJnE9YKzIJ
 RqvjXQ1/xcyHOSHck9sV1CB0cvAJ8carrP78L2XcycnhMYoPnTolRgWdVAC7GF1iljE6
 O1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/ZpOBpkmuHhyFlC0yLyEw0pQYVuMMLKFxg7JU51845Y=;
 b=DOVrhXeBZ2Y17qWip08XrbkoejPeZK7aUk0I4x9+9mOa9YvpRrfwgdCkjMxdxfFhlj
 7qijuadhmi34CPx6czt303az8gUU3k6ybsEiGzipUrXAZTpNe4Qcrug1Z9thLn5uVHgd
 xR3JpZ/Xwj8vhjV6necwfhG9YAnqrpLO6RemXEov5XEH5dalZuNvjicV3VZdhnj1egEF
 ioBJ3R5BEhFy3CCb1kurV1psTETF9Ek+I7e/qRbwKBNlSmBHJNxlvIvhqOnmS/l96ZdG
 QRxrqz5vBpIfM0NGPsTt3uHQoWptPsBrMP8qTcsYGnM7oFebzzf/ryj7MMRKFYk+HE3T
 nJQQ==
X-Gm-Message-State: APjAAAUHNQisoTN9GKxF+wgVFdwC8ZSPw5QQPHGjYSGYBp4VHhA1TWKp
 rSrexDfLNaFEPuPjzjskvypfSBs5g+Xyymzo7AVzig==
X-Google-Smtp-Source: APXvYqxlr0Lsl4K0DGyDxk13se3HUJTg/bjFHvRiyP1yvzy0BuAxu82aNuCVKu8OE/d1F0OKK7OSZomfkKyRdiE3tdo=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr18275357oto.221.1572372403650; 
 Tue, 29 Oct 2019 11:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191028181643.5143-1-laurent@vivier.eu>
In-Reply-To: <20191028181643.5143-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2019 18:06:44 +0000
Message-ID: <CAFEAcA_yMKGnxQA36fDZW4KePLzCK4fxb=xjEJViQnkJaFULdw@mail.gmail.com>
Subject: Re: [PULL 00/11] Q800 branch patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Oct 2019 at 18:48, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 7bc8f9734213b76e76631a483be13d6737c2adbc:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20191025' into staging (2019-10-25 13:12:16 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/q800-branch-pull-request
>
> for you to fetch changes up to f7d85525f14b99aaa7bf561c9f3cf11c85a080c9:
>
>   BootLinuxConsoleTest: Test the Quadra 800 (2019-10-28 19:07:22 +0100)
>
> ----------------------------------------------------------------
> Add Macintosh Quadra 800 machine in hw/m68k
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

