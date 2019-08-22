Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99702C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6428221726
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wucQCZ/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6428221726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kv1-0004x5-Jz
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0ktl-0003Iw-Vr
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0ktk-0005st-GB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:04:57 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0ktk-0005sM-BD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:04:56 -0400
Received: by mail-ot1-x343.google.com with SMTP id c7so5081272otp.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NYa+/rURSKgY/V70970UKgcUAVqcgZSMitLhCjtBxq4=;
 b=wucQCZ/WA6hzcjZIjJxuN55sIFsVV+ke0AzifkadsjXQ5WnLvodT7Proyq+wJ81oB1
 cmjtHGeXQsFod2XvJDmpSuxVd5dsG6RaxZXeFZI6q1kErfshlhamD4jdxPdqqEkoYVM/
 2TcXCKP9Tjqqh10TWycrLQHD5pqFOLu8WFNru17Ltn4X2CXvhsBkAuKpN06AIjFsI2NA
 nwj0wH+Xi/uTuMlVyHxjKtqMMYGDaCAmHKo810yZqMguDiOAp/f35PvYIuogJ4AV+xIp
 BRvNmzIjUWwAK6ilMh89V6P1ggkYEf+zLOSmmKqld5wuYy1Z7eU1fCLJ0IuAOdnyhs7B
 Z6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NYa+/rURSKgY/V70970UKgcUAVqcgZSMitLhCjtBxq4=;
 b=lqfgC3/chsYj3mHUFiAlZZhH/5g46toi/1xKjDCn/umV4cB1VUEAxPjqtXe3EV3pIN
 dqOuSomi1wg8s5Wl+MxVBK9mC2ZH54P9SFkw/hhuLjyY2YMhw/TNyUIuAs4e10+M6+bq
 sHqqtfkn69UCTNhS0WnK6KtocBb6y3SupbmBvrv/PxnKwL8PQz+/QWX/OBjblvEPOokx
 /MZGHUMyq/wd/AAr1gv6ms65c0z2diFBdCX1mDaiG/Sspxm51NqwveeqCxXqmO0cb6Im
 ATwBIHZM+pX4j/5RGgVdKpXzqnQ9/AtbNqyJm+Q8IIrcBKD4Q94aQBQS1RKZIifDI/O5
 CstA==
X-Gm-Message-State: APjAAAU+cXwgKFmzHDdu1r4WlbAx7xBYBDDbhIwyfHnzbw/QmMtSF+69
 KJ6X7PQK+jjKF4k0nltgzcjXi09Jn6AsRLlWXeiWbA==
X-Google-Smtp-Source: APXvYqyeJ5ZwRYeND7GwhREEQu+pa0FBbn5s+MBmYBZbkRWjsO3A5mYf1HFAGJnGIss2UbQfunfrPb1fuEyj52otis8=
X-Received: by 2002:a05:6830:2103:: with SMTP id
 i3mr6088492otc.135.1566471895054; 
 Thu, 22 Aug 2019 04:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
 <20190822104957.GE20491@stefanha-x1.localdomain>
In-Reply-To: <20190822104957.GE20491@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 12:04:44 +0100
Message-ID: <CAFEAcA8c_BukhU+ZgfqUxPUqsOaN6MJdJL5n3-Daf-j05ZeTig@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] more automated/public CI for QEMU pullreqs
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 at 11:50, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> One-off tasks:
>
> 1. Create CI runners that offer similar cross-architecture coverage to
>    Peter's current setup.  qemu.org has some x86, ppc, and s390 server
>    resources available.  I'm not sure about ARM and other architectures.

Quick list of what I currently have:
 * freebsd/openbsd/netbsd -- these are just running the tests/vm stuff
 * an x86-64 machine doing the w32/w64 crossbuilds
 * aarch64
 * aarch32 (done via chroot on an aarch64 box)
 * osx
 * ppc64 (on a gcc compile farm machine)
 * s390 (on a machine Christian arranged for project use)
 * x86-64 various configs
 * there's also a sparc64 box in the gcc compile farm, but I am
   not currently using it because 'make check' hangs intermittently
   in a weird way that last time I tried to dig into it made me
   suspect a bug in the host kernel (we were doing a syscall with
   what seemed like a valid timeout and never timing out)

Of those the s390 is OK for project use. I'm not sure the gcc
compile farm stuff is recommended for fully automatic CI, so
if we can avoid that it would be better. Linaro can probably
provide some arm-server resources but I haven't checked/asked yet.

> 2. Write CI configuration to run Peter's "make && make check && make
>    check-tcg && linux-user-test".

My local scripting for all this is archived here:
https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree

thanks
-- PMM

