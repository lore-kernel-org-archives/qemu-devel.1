Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACD3C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EFE20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsIbBF15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EFE20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAN8-0003c7-IK
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 04:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59009)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZAL3-00029u-NI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZAL2-0003ZA-NY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:35:05 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZAL2-0003Wo-Hd
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:35:04 -0400
Received: by mail-oi1-x241.google.com with SMTP id b21so873205oic.8
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QZh27MDwtQigSsjLoe7eOsRvP+b2kWgdCrVQwK5LlzQ=;
 b=SsIbBF15EIfFTm1NyJAnd0Y9i1k47tkzGXmYiPgSyCGsbqeJeneUj2nCtUbenpaW5S
 8Qo1nfVpFu2nYgHVKBeg2PlXBifSFew5XTR9H3xnMFhkWX/5m962NLOtvb6Jhu9WKBXU
 cfCYsR1X6pfFSdqjhLSZPMQYZG7vRxtLvvL0A11J/DkNYaVcGpgQTL2jIKp3829I/5Wo
 frtHfPmgbdG4G3MLHgd/5UcRd/SlcDahO0tF0VfMehtzNEKCE7mcgYXAi8UwShS9N/Qa
 FPJKJApkPrHybHbQ7V6ADfOoyi795FaR7OjyBWKzrIBT5VFbpLC+pmfnK5V8A42d0jnb
 KwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QZh27MDwtQigSsjLoe7eOsRvP+b2kWgdCrVQwK5LlzQ=;
 b=F3LDg4HV8+RBq6H4bqD+lfkqLXMZ5I2tpuvlAg8fAQPrd04JWVm5925g6bM+eIwK/R
 Pbr5E6Tp/0HYNy0sp2uQiNQIH7pQlR/zqhu7NKlH6GBl7G7gsFaBMd8Auwjxmk4NEtM1
 u5y5SnKEK+05k99yVNwK6MRpzXyZplL38VF3R2AVSp+gg5BPXL1ZeQ1zHTgJybHHGPgz
 V71EHD3FFmUe4hOfwX6IcLd6t99SPrcvLeCswsr5TZfqmzhZ0vWS0uv2ksNVj5EQzHYh
 jOb30CTofp+iywO3O4rfMX8qgo4zRlM8hJs0mRw/hcB3qN3WgomRslobQ/spAt/nH3cS
 d/Ug==
X-Gm-Message-State: APjAAAUAR1XNDgo4omzf1aIkoqskAUL4HiGCfYBVxHwkFhFB/n0sZDlx
 ugoYua2LTONc79mrEywLdGcLyXECEBoD8J+HnC7lmQ==
X-Google-Smtp-Source: APXvYqwjWi+nGoqDE04LndxzdFup7v4ugd5UJrQgQouyM1BgRelkfJXm7VBHWRgeOuG/WvO9uV96rOzCsQbVXnUPAp8=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr2917517oie.48.1559896503713; 
 Fri, 07 Jun 2019 01:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190606234125.GA4830@localhost.localdomain>
 <CAL1e-=i7WfrHq7k266grEs1xyf_FKVG_4JcvCbrrSZt66c4ftQ@mail.gmail.com>
 <20190607032825.GA5123@localhost.localdomain>
In-Reply-To: <20190607032825.GA5123@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 09:34:52 +0100
Message-ID: <CAFEAcA-40HYo3RhTPd-U6_iuYR-0ncn6SSgq2W4k1usfaX_0Tg@mail.gmail.com>
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2] m68k comments break patch submission
 due to being incorrectly formatted
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 at 04:30, Lucien Murray-Pitts
<lucienmp.qemu@gmail.com> wrote:
> checkpatch is correctly identifying the wrong style in the changed code.
> This changed code contains the original comments with ADDITIONAL edits
> resulting in pachew/checkpatch complaining.
>
> The m68k is, by my guess, older code and nearly all the comments are different
> from the style guide.  Some are "/**" or "/*commment here...." and so on.

Yeah. We have a fair bit of old-style code in the codebase. There
are two different approaches we take to this:
 (1) the most common is "fix the parts your patch is touching anyway"
(ie in a new-feature patch you make the minimum fixes to the surrounding
old code needed to keep checkpatch happy with it)
 (2) mass fix-up of old style stuff as a separate patch

Mostly we use (1) but this does have the downside that old style
can lurk in not-often-touched files for a long time. So if the
maintainer (in this case Laurent) is happy with a type (2) fix-up
that's good too. (Personally I used to be much more in favour
of sticking with approach 1 but my opinion has changed over
time as I've seen the downsides of it.)

thanks
-- PMM

