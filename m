Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F34CC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 18:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E628214C6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 18:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StgEArY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E628214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huhOB-00043Q-KK
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 14:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huhNp-0003aE-06
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huhNo-0001Xs-0t
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:06:56 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:33371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huhNn-0001XN-SD
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:06:55 -0400
Received: by mail-oi1-x236.google.com with SMTP id u15so62741531oiv.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ra3DuW54lqwAH+QzdQ8DThAuJ696QjiDYOkaHEk/bTA=;
 b=StgEArY4Ps44E+3R2Z4Ae23m8inZtb77gb1ne4fvGFckn9+NnWiWz7gN2az5ll8MrQ
 7pbjoOd1RHNCQLX4wCqcbzLg0XJveHrrRL89JflTYUhE7m8UDwywIfXhElC9ugkloQiD
 9M+fvUcfc/7rbiTY5gDuyiIibYXxrPRiFi1FPDtZH9VOD89nJHjBFFuAfVzGzWkuDWxW
 wvPU1wgq/E8KUJugcQOA3fmIpDbFZanVJ9N2akgUAo4+9e1hvAHIPuaKQpMr8VfZ5tfn
 uQIHYJQTCx8djA0MPXR+lsSZPasDkZo9ytk66ima+aikzVMWE0TRydWK+ocEI9xiTHh1
 Kxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ra3DuW54lqwAH+QzdQ8DThAuJ696QjiDYOkaHEk/bTA=;
 b=Ub4qjwp36xon7qMnjWpCzqKyfF9zDr+JJc6+hnmHQL0+i28naJv3xJ6ZITFLD0gPwh
 vHIw0TAnrg/V95ED/Un5O44M9usfdz5/a1OeTt0EUb+nIfmYDcuS/Sw6T4SZSVqkUh5k
 Bhkt6ZDuHzW1MtcCKgBZDg5OFGuIBhYd6+WMSHdjRs2FWUEtURE5IXLQDyvWWhFxbh1X
 s9pZVoaq4CHrIA8kLMM2/oFoLJ1ex1yGSlnA+bcBfTn6HgoHV1Nkgb4Osj5cNLeQ6qlX
 yAOdzzujY6pSmKGYUwgwKmBj2MsTPni3VIMRA6zkrWSIHK9SaH3S91rIUWj3zaX9dbDq
 aAfA==
X-Gm-Message-State: APjAAAWZCHlt5Kuu2dhho8N7BM7bLggAA79lsqud2LBqqDAVj99aapi4
 ZAy6E3wZA5dtbYd677r3uJvXTl1ljQURuV3sr1ledw==
X-Google-Smtp-Source: APXvYqzgGfT2nOSbMHcJgUjEvisQd97lcm2cAzh9Sqt6IOW8sDYe1hRxQ9zvi13v22mnqrm8bl6UkT5J6y6JBh/ZTqI=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr11715272oij.98.1565028414917; 
 Mon, 05 Aug 2019 11:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190805163740.23616-1-mreitz@redhat.com>
 <CAFEAcA9UH0g2A5g=akRbcLS4RXKQcDfFySFum3-fgO=R=mE=Ng@mail.gmail.com>
In-Reply-To: <CAFEAcA9UH0g2A5g=akRbcLS4RXKQcDfFySFum3-fgO=R=mE=Ng@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 19:06:44 +0100
Message-ID: <CAFEAcA-1K1wxDu4MXwnyJ2vFXJCo+Yd6RA+soY++7dBoq-B=0Q@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
Subject: Re: [Qemu-devel] [PULL 0/7] Block patches for 4.1.0-rc4
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Aug 2019 at 19:05, Peter Maydell <peter.maydell@linaro.org> wrote:

> This is quite a lot of changes for rc4 -- how confident are
> you about them ? I suppose 3 out of 4 commits are updating
> the test suite...

3 out of 7, I meant :-)

thanks
-- PMM

