Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7133DC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 16:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAA1207FF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 16:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vAvUnHWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAA1207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTTBu-0006E9-9B
	for qemu-devel@archiver.kernel.org; Sat, 09 Nov 2019 11:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iTTB3-0005hf-E6
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 11:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iTTB2-0001N3-Bz
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 11:01:29 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:32989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iTTB2-0001Mp-7U
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 11:01:28 -0500
Received: by mail-ot1-x330.google.com with SMTP id u13so7845526ote.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 08:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DfQOHYOpKGfTabijNjh+5bPNAs78Xfr9AzqoqapvMVQ=;
 b=vAvUnHWhlcHMIYQ7MzT59V9B+k8SXkFBwHz7WUmfnLzIgM+wlPfysLFoLo/cnIGXnQ
 8awMmOfoMSwNUxDRddP4kmctbA4HpKsRqpuncY1rms3OqhJziWX6sbX2pWOAkze6RJXD
 PeELyJiJkrCZt5rNoor574BSI0miOAy9FYTJqeCfiQej2nkOLFveehIA0hMaevsbBHsU
 84wKvzjpr4HDC+Vrtm5bHyyhU6sqSvQIaOaOTO8DihD8AOZlXv/6AojHVIw7p8LQRxHH
 xshSvVIs8W6UG7kBLnyEvdrrqs4uw72YhKZ898b82C1aZKuamAqgW+Rpe2KQmSv0gXYi
 3Esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DfQOHYOpKGfTabijNjh+5bPNAs78Xfr9AzqoqapvMVQ=;
 b=M21SqdPXNe3RYfe96p6FPYE+kvAAppn/gP27hh40xHshdqIEaOh9rIK587D+cEzWCf
 Up7MIQkzq0F35VTZ84C6212ctclyeIUZjvJnDmdXdrsg+uOtamyM8bPDWZlpLnPui4O4
 GlMQRxJPfL4nLajcvS2yuekeiKkHa7UbHAnnTVNq4crPlLUFiaJ/vBkXx0dok652nH3T
 EKLtqzbbuR00ssxPbG25HwrId0fQC1PZk3q7uan78Q03AucKrxyaR7zv/22b/H32GALl
 J8o3XeSa/D5PgovXfnxu08NJM8BckzfQAF41aio62ZAAbTxJUUtGqzLi2rDqu6T/x/TJ
 4MvA==
X-Gm-Message-State: APjAAAXf4cwrYB1LOcAGVIK5GAS1zMM4PwFpuvQJo8pJqviFuGLOo/5I
 zxzvj1SDYsVfM/Y6QRAehBx1HtbRtvt9Fxa6UWCzHA==
X-Google-Smtp-Source: APXvYqxbW1/JBnDnLMJGlbUxemcLT4XVxRtXp1l3JacUI8Y+GzLyCNWryV/Gphc/dklZK9IqCsz+p6xs31obV7U4JJQ=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr14421209otg.232.1573315287265; 
 Sat, 09 Nov 2019 08:01:27 -0800 (PST)
MIME-Version: 1.0
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
 <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
 <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
 <CAL1e-=hcS8_2Y1YJS01GTwFbMYBJmWopYkSDi_aw6yzOHk=3Lg@mail.gmail.com>
In-Reply-To: <CAL1e-=hcS8_2Y1YJS01GTwFbMYBJmWopYkSDi_aw6yzOHk=3Lg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Nov 2019 16:01:16 +0000
Message-ID: <CAFEAcA-tNBNGE75+MZ3+r_9iLA-_3+meoseVxhgzJZ5PvDofuA@mail.gmail.com>
Subject: Re: Looking for issues/features for my first contribution
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: Rajath Shashidhara <rajaths@cs.utexas.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 19:32, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> > [a] Is there any particular reason that you picked DS3231 ? Linux kernel
> > has drivers for DS3232/34 only [1]. I did read the datasheets of both
> > 3232 & 3231 and found that they are quite similar except for the 236
> > bytes of SRAM support found only in 3232.
> >
>
> Yes, DS3231 is a part of a board we want to support in future.

We should probably prefer to go with a device that's a
missing part of a board we already support -- generally
the project prefers not to take device models that don't
have a use, ie they go in with the board model rather
than before. This also means we have some way of testing
the code :-)

thanks
-- PMM

