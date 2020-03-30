Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06EBC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCE7206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOnGJXeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCE7206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIqJ2-0000Ty-IR
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 05:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIqH7-0007Xb-Pe
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIqH6-0007jV-6O
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:00:05 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIqH5-0007f8-Q8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:00:04 -0400
Received: by mail-oi1-x244.google.com with SMTP id d63so15031911oig.6
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IefMEDo/ksObL7E3s1fyaGqBJe55H0aDff5JnBVInmQ=;
 b=HOnGJXeUE4klv+DMJLzI7BSix95FYL1xlaxm94oZXT5n3cu8ZjXHQiRg/XVyKGHbSl
 dX1++/3l8lLuxPbx0OyC+boB8XgcuXiTkYRblHyGU3bneDUidGX6h0zrQdk/cC4yJrZ5
 lMpYpCFC1grkkTRg8dLnCnIn/uJv6du9W3+UnPTSZ744/1q6L7c1R5vgHbjTc4cHLB7i
 d9rXl+xX2ixnMFmR/mjLjX6K7ZZLLjHLDkSzI5hZI56mQa8Bct4HlKevfHFWi7ejdWQ9
 aOJU5iDQtA0zHdTITrdu5571Cyd7BFD/1cVAMqrCiCS20+OglEJZxUOqiuqKQO0zxz32
 kPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IefMEDo/ksObL7E3s1fyaGqBJe55H0aDff5JnBVInmQ=;
 b=am7iSmvzYKOBOcJwL4No+eqShGQo002DpySx+3sIudNy15suRKbdfiVbYpyrXCFNaX
 HXxDHbwhP29kLx/QaQjx3320IVG5D/kX3yufIMJ8aqYDKDz1Qd5FChzB+YOZo1+v/uBY
 G5fOpC/uubc3Jj86H48ZbVGRL0gcppcZ0aeMoRn7rUXNX168LLfDbT3OcL4emZuuzOek
 uAnmJ9/p/NT+Z/EV9fnR3J+ys875yofFs+zFsTyniLcOMpE9n+qbZZKgigRUIYelyXH+
 sim4VPEbsAkcY0WxMB7PIyppMX1vzW9Mx5zI+linwWb/TLHtwzH8px3I/uuHYakBf2WM
 Jcsg==
X-Gm-Message-State: ANhLgQ3P2IKrUfVL6NslPqKN7S9LLTKNg9blyggj3925PDXWtH/jCKyt
 Gi9a+9HLdbGNgBy8LDMxhojqUzxk/Wy/InFWU3gIHQ==
X-Google-Smtp-Source: ADFU+vsk7R3DJ40oMcf+o1a3wvpHYnV7KOITmk7ORNKdZwMMOmWUi4HNda/BhxTuKdjtRKszjBMUheS3GE1yC1NwLUY=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr6610435oih.146.1585558802541; 
 Mon, 30 Mar 2020 02:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
 <158471180295.15515.1369533827289907154@39012742ff91>
 <20200323132556.GG261260@stefanha-x1.localdomain>
 <CA+ZmoZUFojqmMxNQ1bhGMzjML7OFgDt1GNbogGTw5rte5LD4iw@mail.gmail.com>
 <1b0fa063-6fe4-ad40-06b2-9c3f2f955a06@linaro.org>
 <04a411d6-72e7-d2d2-15f9-895f6a765d22@redhat.com>
 <CA+ZmoZXfrGh3+jnN4K-cfZitR+DVPL=ieZpTZGzH3cYSxko=eA@mail.gmail.com>
 <CAFXwXrkkOzuS=4Gfqm9XtkL5kc5m_5-9WmuziGgTfhFdm8VD0A@mail.gmail.com>
 <CA+ZmoZXvQ0iduKP_zWA0wTnpVSjjx=M6d5knWV-cayVuSQ2usA@mail.gmail.com>
 <9072334f-e4a9-cc6d-7c72-b97110e74cbc@linaro.org>
 <CA+ZmoZUwTYsFv73sfhgexRDU-+qqk0P-Teje+mzu4Rn+D2=YQg@mail.gmail.com>
In-Reply-To: <CA+ZmoZUwTYsFv73sfhgexRDU-+qqk0P-Teje+mzu4Rn+D2=YQg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2020 08:59:51 +0000
Message-ID: <CAFEAcA863jRT3qBRd-q4bPSYkODZSS5nHTExRRk5W8isHo+wPQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Replaced locks with lock guard macros
To: Daniel Brodsky <dnbrdsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020 at 06:54, Daniel Brodsky <dnbrdsky@gmail.com> wrote:

> Using `#pragma clang diagnostic ignored
> "-Wtautological-type-limit-compare"` suppresses the errors (on Clang
> 9). I could go and drop that in for the problem areas? There's only a
> few so it wouldn't be a major change. I'm thinking of adding a macro
> like this:
> #define PRAGMA(x) _Pragma(stringify(x))
> #define IF_IGNORE_TYPE_LIMIT(statement) \
>         PRAGMA(clang diagnostic push) \
>         PRAGMA(clang diagnostic ignored "-Wtautological-type-limit-compare") \
>         if (statement) \
>         PRAGMA(clang diagnostic pop)

This is not an in-principle objection, but we have found in the past that
various gcc/clang implementations of _Pragma() are simply buggy
when used inside macros; see the comments on this patch attempt:
https://patchwork.kernel.org/patch/10620079/
(one of which has a link to half a dozen gcc bug reports involving
_Pragma and three clang bugs). For that particular case the approach
we eventually took was to only use the _Pragma() stuff on clang because
gcc mishandled it and luckily the spurious warning was clang-only.
It's a shame, because the whole point of _Pragma() is to let you do
this kind of thing in a macro, but the actual implementations in
compilers are clearly just not fit-for-purpose.

So if you do go down this path please make sure you test it on a
wide variety of different clang and gcc versions.

thanks
-- PMM

