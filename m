Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA9C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5967224670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2wDGqW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5967224670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIZw-00010x-8p
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idIXl-0007mO-4L
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idIXi-0005fy-NF
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:41:32 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44551)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idIXg-0005dY-GN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:41:28 -0500
Received: by mail-ot1-x341.google.com with SMTP id x3so6607035oto.11
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 10:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y3qrSWJ9tKXnvGZeIDT1ZIZabMRzmWdakCUiKtIRzm8=;
 b=O2wDGqW9FUCHZH6upZUDAu3Xl3kQkbu0PiYH/bdTEFlGIjkUaYDk1FR4WwrmaVvnK+
 k5B+W/K9yDdJWgQ86FYsKcNa0ob+RfKw9pICMFZedXoyxEyZgTOQbiPPZqsHO+Ut/wgo
 XsjJz/vyGyxDyNdy4JOpUcj5SQZIL7zExUBDrfb/b9uwHVcItuPxc5P4wi/EB1y3m8Cb
 3cDiPrazD2BYNuWoGG8D6+mbzy4t9SHSe/A9g+moPgZXyDsvE3C6GL6hg23VfQ75K+IX
 nbFxPjAfXe3daxfd4D2xJeB5qGbLN4VKE1TyRgPTWDZ8IHhql9VdMIOV0fzToJDGlSSc
 8JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y3qrSWJ9tKXnvGZeIDT1ZIZabMRzmWdakCUiKtIRzm8=;
 b=kldeczBhExUmvE99f+GVS2SLyQ7iud7Ds9yud5RLku8NVIk3Eg/XiZnyeqg1pbIGDP
 U0DZRXI5PhysUDPZrc/l22Nv4XxbbfDmXyrx9Tm22D3WYMUt2fwK4HsXiaO93XFkaXYQ
 bHi2zE1qhhw57yTLLA4ewZJPam0S6l1D+nJFG9WCfrCyp90JeTLMuvjHn6STFoMrF0St
 MgCr8VqcP+Jzoa2O55LxoNKfcPWufhjK6bgXB+26eO282qt549Xf8uNsAgI6hl50Y5ta
 Dz4A6sZI6P0UHS3XiDVXSNelSEru6e6VggpGQB3EeTnIHJ66yvQal/Vb/cfPH7vHIDmw
 NGxg==
X-Gm-Message-State: APjAAAWPbvrn518dx9lP3V81t8vRHgu9pEeLxbNuwbiR7VO0DIjaHFp5
 JhZFuA4rzywrV2yb8YDS7urNKgtd5gkRG9EB4Z6aHA==
X-Google-Smtp-Source: APXvYqyddEknKNbnkRw3u8SFiEBTkX2BuxGO0yJAsmt1h8g7vKqhhrwFYi+rkYA473gpJNW2p/cvbTvPiqWXwNm6EDs=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr11724931otm.221.1575657687001; 
 Fri, 06 Dec 2019 10:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-28-richard.henderson@linaro.org>
 <CAFEAcA8taFKOtz0pM-N3KRiQrguh43SNLSM__ZJH5xzVK5YkZg@mail.gmail.com>
 <ef270139-bca6-e7d9-57b8-b5a7416bbb56@linaro.org>
In-Reply-To: <ef270139-bca6-e7d9-57b8-b5a7416bbb56@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 18:41:16 +0000
Message-ID: <CAFEAcA-k9Ay3fEYOK=BKraFMhtm=9SxMqJNHGXZmDjpCeWGLWA@mail.gmail.com>
Subject: Re: [PATCH v4 27/40] target/arm: Add VHE system register redirection
 and aliasing
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Dec 2019 at 18:36, Richard Henderson
<richard.henderson@linaro.org> wrote:

> >> +static void el2_e2h_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >> +                          uint64_t value)
> >> +{
> >> +    CPWriteFn *writefn;
> >> +
> >> +    if (redirect_for_e2h(env)) {
> >> +        /* Switch to the saved EL2 version of the register.  */
> >> +        ri = ri->opaque;
> >> +        writefn = ri->writefn;
> >> +    } else {
> >> +        writefn = ri->orig_writefn;
> >> +    }
> >> +    if (writefn == NULL) {
> >> +        writefn = raw_write;
> >> +    }
> >> +    writefn(env, ri, value);
> >> +}
> >
> > I see how this works when we have a readfn or writefn,
> > but how does the redirection work where the access
> > goes directly via .fieldoffset ?
>
> When there is no .writefn, we use raw_write, which uses fieldoffset.

Yes, that's what I mean. There's no 'if redirect then this
fieldoffset else that fieldoffset' codepath, so how does
it update the right field?

thanks
-- PMM

