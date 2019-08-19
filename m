Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB77C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A15B20843
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmBreZ8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A15B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhaP-00065n-Jb
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hzh1m-0005ar-Om
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hzh1l-0003nB-Ac
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:44:50 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hzh1l-0003mR-2N
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:44:49 -0400
Received: by mail-ot1-x343.google.com with SMTP id c34so1501419otb.7
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=eVweLXtZ+wSXU5GcqQegNDhfZ1nPcypw8IAPu4OvJ+c=;
 b=UmBreZ8Zhi+mbXoBKu4ueSTZJOvMFd4Zso0r1uo9XAO8lvMn1PQq1WAbG2DmpyFzs3
 Il+jMu4Et5vLc+0cdyZizvjdt+ZIIWb6eWL7eYzMDm+kKVp9MV7QOLgGbkCHJnFfLDur
 8g9cME0g//EbahgK1+ASCGP+YJ9IeAVCoephOW3qdc4bSYF3zP1h47hSUIk5DSxZcMtb
 ErT8G/MykDKA/TdBW0mxYtj0XdNrSvRKLGgq/70eI/fbBnmYKl1bUuxtKbWZs0OeFTs7
 YNDVPVwwVrobljTOhz27Jd7i9hfT55zl4Hqg5yf9dgkugtQDYlIqGfda4OIDQDOKVXuI
 ztOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=eVweLXtZ+wSXU5GcqQegNDhfZ1nPcypw8IAPu4OvJ+c=;
 b=AyrqSmRSLZIfD9TGYO2AtQa2Kx67vGCB24hutEDvfeZSguzHhg0b/ClSwWW7rts627
 +boiyWX1ywo643LdO5RsznIhuYH0O7Um5KnMFGkciyn3LjAIWIpe5fQZEfrqaNJ2EM/t
 HI2PZ390jFrirjPX5N8RfG25H4bvJSaYe3N6Z6vEflLIAurSUOy9/UIuvUxxS1lLx1Fo
 muBPDWNcUyXHziPxXX3XN1MHjc/iZ8qW6K6F+uZVrkhLV8ttx7Q4w8yjIVp+GGpyl6/J
 +tCmvxvL8CSpSnu2aDb+aOXsA6aTOxIncrkN2uG1qbMdv+cAXf/xviiRbIhhRWCwE82q
 Qqdg==
X-Gm-Message-State: APjAAAW37/Eh+PBGUwnDbLOIfiDbWJrdlJCqOv/kd9KWm/s3YuA2QfuN
 Qp8hurFlOgO+l8JLcNud1zRp2OQ882Pr7u5psYeUOQ==
X-Google-Smtp-Source: APXvYqwi6Rd5jlf5nVL9X3u7HRmPrafl0RRYkFH6658oNusW+FBCBOGkzFEhFuA9Eqik4lDOU9p8rN62rOoRzHdjeOg=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr18694147oti.91.1566218687905; 
 Mon, 19 Aug 2019 05:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190816125802.25877-1-peter.maydell@linaro.org>
In-Reply-To: <20190816125802.25877-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2019 13:44:37 +0100
Message-ID: <CAFEAcA-7Lr0nUD3g=C7S1Obgaa0E0p794XLhuBZRW_+fC5YjcQ@mail.gmail.com>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, 
 Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: Take exceptions on ATS
 instructions
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

On Fri, 16 Aug 2019 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The translation table walk for an ATS instruction can result in
> various faults.  In general these are just reported back via the
> PAR_EL1 fault status fields, but in some cases the architecture
> requires that the fault is turned into an exception:
>  * synchronous stage 2 faults of any kind during AT S1E0* and
>    AT S1E1* instructions executed from NS EL1 fault to EL2 or EL3
>  * synchronous external aborts are taken as Data Abort exceptions
>
> (This is documented in the v8A Arm ARM DDI0487A.e D5.2.11 and G5.13.4.)
>
> I noticed this by code inspection back last year sometime when
> I was investigating a guest boot failure that turned out to be
> due to an entirely different cause. I got about halfway through
> trying to code up a fix before I realised it was irrelevant to
> that bug. This patchset is just tidying up and completing that
> work so it doesn't get lost.
>
> Use of ATS insns in the cases where they might actually fault
> is quite rare (obviously nobody sets up page tables where there's
> no memory and they'll take external aborts, and even for the
> "take a hyp trap for a stage 2 fault" case you need a setup
> with a hypervisor and a guest that uses ATS insns, and Linux as
> a guest doesn't use ATS at all. So my testing of this patchset
> has been more "check it doesn't break things" rather than
> actively finding and testing a use of the throw-an-exception path...

I'm told that Xen for Arm makes more active use of ATS
instructions, so I've cc'd a few Xen people -- do any
of you have handy testing setups to try running Xen in
emulation under QEMU? Configs where the guest (EL1) actually
uses ATS instructions are the particularly interesting point
for this patchset.

(if there's a good set of instructions for creating a test
image I could probably add it to the ad-hoc set of things
I sometimes test with.)

> Peter Maydell (2):
>   target/arm: Allow ARMCPRegInfo read/write functions to throw
>     exceptions
>   target/arm: Take exceptions on ATS instructions when needed
>
>  target/arm/cpu.h           |   6 ++-
>  target/arm/helper.c        | 107 +++++++++++++++++++++++++++++++------
>  target/arm/translate-a64.c |   6 +++
>  target/arm/translate.c     |   7 +++
>  4 files changed, 110 insertions(+), 16 deletions(-)

thanks
-- PMM

