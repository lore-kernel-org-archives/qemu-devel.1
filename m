Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70829C31E40
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 08:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4006A206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 08:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onyZoQ3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4006A206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsNpu-00077Z-HW
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 04:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsNpF-0006Eb-6i
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 04:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsNpD-0002fk-Uo
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 04:49:41 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsNpB-0002bD-TA
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 04:49:39 -0400
Received: by mail-ot1-x341.google.com with SMTP id l15so65465167otn.9
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d0M76miacXcy9t9W9z/UiYD80nYbOLxzcDAmZ1GSUAQ=;
 b=onyZoQ3NX5AoNs9LDSFOwbASz4tCB9bvWVy8XOMCYQA/81DVZWRIST6LNfU79goepG
 LwUN3VmW1V1Gy3y+IY5dhBHWALN7/rSAf8QcepjnSIqBpXafCtcbnbnp8rHHpguW+zfs
 aeE5PkdzTYqUSebBj8g5RS5Hd5kDpr8q+4DZgf22WqSR87yGYopWyfhSI1Hdsla+ank1
 H4+hL/IojGzHSExvywQPRdr/5AaSY7nQyiXT0U/BUtnULvfwztq4LUFsH00qI36NrVPi
 M78n+aZfLMStw0DwKeH51TMsFqETFLurP7K4LIpiRghWwmb9iPA60GQxwJve/2Qpk120
 JTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d0M76miacXcy9t9W9z/UiYD80nYbOLxzcDAmZ1GSUAQ=;
 b=Mw0a63dCXVtCObiMwF/Gn8/GVb4xcnyACyS3/sREYEiGOv3fNy8cfQKpvKacuj9Gbx
 UurNOgblq7NcQBHnuSKoi2GPJf1XPuVgafwrwxyp61kAuhKAKyIy/xqwoMMr0g+yNhec
 LgK/UF4L4TT0NIs7QlWqfpYLMyNLPjaAXNuNQ2yTGKsQbjsoJl6LI7p1ji54qvs9Qpph
 p1elpYFdiKEzFdT4vLuohAOgjH2mDmtc56GHVhNN35inKSRlgZ6LaDIFIO9bKefMkOcU
 r1xlhpufckJAbXSLVX5RGhEUITh42yy2uN/0aTWIrW+FYCgDDBZjOk2xhbpZbqFTL+Ah
 YRmw==
X-Gm-Message-State: APjAAAXBZMkNw7jr1vUuez5KUw7GH2H7yoghtSu4lUbHWhU24/h3kx0+
 Jf+LBWBOuZIDgdSrT+WO3BOi1gYvnjUUApG0VzrM9Q==
X-Google-Smtp-Source: APXvYqxAopKCkS3QXrIG/ah+a9YvDdOY49l6Gbt6Jyoj/NEF2VSdLfGi1YRqB/kRz2mh4qsXokWArOgWKBAJtBqSPGU=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr30281165otr.232.1564476575763; 
 Tue, 30 Jul 2019 01:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-11-richard.henderson@linaro.org>
 <CAFEAcA83GM6wgWs1xGygmqCoir=CXtFXYkzPBMdUeb638kCzmw@mail.gmail.com>
 <28a5710a-37a7-2d6a-1609-5218d5e8e931@linaro.org>
In-Reply-To: <28a5710a-37a7-2d6a-1609-5218d5e8e931@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2019 09:49:25 +0100
Message-ID: <CAFEAcA9WF3Ou4Nm8+ihusThyiyd53y1_ACpT_ygSROM-qyyBWg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 10/67] target/arm: Move test for AL into
 arm_skip_unless
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 01:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/29/19 7:32 AM, Peter Maydell wrote:
> > On Fri, 26 Jul 2019 at 18:50, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> We will shortly be calling this function much more often.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---

> >
> > In the other callsites for arm_skip_unless() the cond argument
> > can never be 0xe or 0xf.
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> In my original version I included cond in the fields collected by decodetree,
> and so every single trans_* function called arm_skip_unless, so that would not
> be the case there.

That remark was more a note about why the change is ok and doesn't
change behaviour for the other callsites that the patch doesn't touch.
(It's the kind of thing it's helpful to note in a commit message to
show that you've thought about it.)

> I discarded that in the version posted here, but I still think it might be a
> cleaner design overall.
>
> In the short term, maybe I should just discard this patch?

I don't have a strong opinion either way. Putting the cond check
inside the function seems cleaner even if we're only calling it in
a few places, I think.

thanks
-- PMM

