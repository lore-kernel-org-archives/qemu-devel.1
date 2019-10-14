Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07406C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC53620873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrR+6ZZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC53620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4ba-0002py-Re
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK3xq-00048a-Tl
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK3xp-0003zg-Pi
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:16:58 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK3xp-0003z1-Jw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:16:57 -0400
Received: by mail-oi1-x242.google.com with SMTP id k20so14380947oih.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2im1edU0mZbhUh9AOBW8hzpbDNHdOPOP0ikRcICpz34=;
 b=WrR+6ZZSvuvq6msblEYhhO+U7GRmmmIQiUgVZ3N0+snGp92gkjO/GSVDPhiXzjzWL1
 kna3fsqsVCH9vVkL/+sUOHNbW6im+kBvXASSfAE7Dv8NPJNo7GSkCxb/4n1tLB0C8eZl
 jwqpIa+BSMzP0U9jN8bTFc258aoP9wjIMq8SEMoul5frzn8E5BAHVP0DbyS0Q4BogEet
 mcf5xb41RtVYE/SJjU9byKoLv7BMEf2ioE3V2Xd1u7AAJOwsXL18oeQ9Mc2CmoJn83zW
 8mHtuOvs5Bh8IpnGSfH/gzC4TxXVbI5frmyIJJ01eO6osS+eksUcmXYGDfXtAKSkdBqD
 s/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2im1edU0mZbhUh9AOBW8hzpbDNHdOPOP0ikRcICpz34=;
 b=EAIHooQw++ueY3RTFwMmRxZkA2zcAckCgM0Em9btdsP2omsXFOvSU/imY15sKQT4cu
 c3tgqpq/NiPCZJBOT5y6ZFj+VvTqFgdXQ1h78FK0Oz1udjHufrPZpbmVf3psrgC6vgAP
 RYHB+8qBdBjSgv0dazErXZYOAiddWS4MBMhuiQdPih2liVHYFYRaEcLI3oqX9cHMa0Qp
 TUrxIjEKR/z0TMn0mWJiAkWoyQrr7qKVMj4Y1xJgBlWSUJUimnUOSjufw1F9D9V/4DLD
 FRWFtT8Ix6Z4a0mPUM1M+6xP7CXjBKBEadw9HiKR/6akJH3+M465vOqNXCnaPVl71eiB
 /Fdw==
X-Gm-Message-State: APjAAAXZZU+VTl9Ydz6PtrosNN5HNsD9p4T7qMVDpkvXk6rjtGfL+N09
 eN61HKWE1if/BFlN8mup4F0WSogPbsmSWYqyztnMgg==
X-Google-Smtp-Source: APXvYqyugRlwVHLFFKzhyNDFflLTXXklZ2qAfRan2Q3v9bmdVxjY2iC1dfRCTtoBmROo7mUIUJUSjqppbZ7Ebo3Un2A=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr24025585oik.146.1571073416735; 
 Mon, 14 Oct 2019 10:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191014141608.80923-1-hikarupsp@gmail.com>
In-Reply-To: <20191014141608.80923-1-hikarupsp@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 18:16:44 +0100
Message-ID: <CAFEAcA8nG9gLd3-mgpy6eTPfYPcpJDGS8EV-aRQPRTq=NuHYvA@mail.gmail.com>
Subject: Re: [PATCH v2] ui: Fix hanging up Cocoa display on macOS 10.15
 (Catalina)
To: Hikaru Nishida <hikarupsp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 at 15:16, <hikarupsp@gmail.com> wrote:
>
> From: Hikaru Nishida <hikarupsp@gmail.com>
>
> macOS API documentation says that before applicationDidFinishLaunching
> is called, any events will not be processed. However, some events are
> fired before it is called in macOS Catalina. This causes deadlock of
> iothread_lock in handleEvent while it will be released after the
> app_started_sem is posted.
> This patch avoids processing events before the app_started_sem is
> posted to prevent this deadlock.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1847906
> Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
> ---
>  ui/cocoa.m | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index f12e21df6e..bccd861d16 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -134,6 +134,7 @@
>
>  static QemuSemaphore display_init_sem;
>  static QemuSemaphore app_started_sem;
> +volatile sig_atomic_t allow_events;

Sorry, I failed to spot this on version 1 of the patch...
I think we don't need to mark this 'volatile sig_atomic_t',
but could use a simple 'bool', because both applicationDidFinishLaunching()
and handleEvent() are called from the same thread (the OSX run loop
thread).  Could you test that it still works with plain 'bool',
please?

(If we did need to handle multiple thread accesses we should
probably prefer one of the QEMU atomic primitives described
in docs/devel/atomics.txt, since 'volatile' isn't really sufficient.)

thanks
-- PMM

