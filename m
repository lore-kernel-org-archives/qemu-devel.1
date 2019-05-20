Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECACC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750E520675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bd/wwIMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750E520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSep1-0002vJ-MK
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 05:43:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSeoG-0002dC-3c
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSeoF-0004R2-23
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:42:20 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hSeoE-0004Qk-U2
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:42:19 -0400
Received: by mail-oi1-x241.google.com with SMTP id f4so9496523oib.4
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=gYYpRdqjvfmBUZ84pd+XMit/EGky43aU0PpHUXhrbfU=;
	b=bd/wwIMpNirzCHKaKClX+F+sZ1oLZ1trzVtMba/FS2YM97cryqNFVtz8EAenB4JvM4
	SD9TXTTHiwtVtfgnI8qJraASWNzN7IpbJz0bMj2IkBluo97LmnuoTrKrmzpO/BVJhzbY
	bwyK+p2bHpYstP0Kd59kqN+zAgKytWYLebd7OziKaf62likxmAABXow4dIOju2PG89U7
	pJiP2WIc1TpmeM20u8ENZHA0Kufb1QrXJwwxoDtqZxvZykMPdC3suUwQek7aIdwyleNg
	/QHqAWQ3UL4PllMDOReTj7LcRFtIMy/jA+ALrM0crZ2mJh484+iLwnUvHBNEmsQdJZrc
	qM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=gYYpRdqjvfmBUZ84pd+XMit/EGky43aU0PpHUXhrbfU=;
	b=debiI+Adr+/i3vmtmIioRHAtvpj5CVyCYlqY1/zC7D6K0nHiZx4Pn/RZbVDKX8Mvd1
	Wi3/k7IRPfDalaKPjH1bdYJIBNHSf2+Ks/6uMQbPqtwWFbo5em/Ffz8sSO28K/YpIscr
	gx7CywAbrzwlXvn+H/M/Mq/uDvsF+Ag+ToogaxsSU06Yyh8jy1Z/I2Q6QXr1Zh+bNPyI
	NK/P577lzf7XXSCN+5VfYZnKArtQbleZUfq8c103KNymZVst3X6ce0nkHmNIAGvdskoq
	or1tka4cuDMwS4W5ZPQz3xyfIbkvzmHmGwe/0oc0l3BfRyx1pDdLM7Zk/0kDvg2ZOqP0
	sdtg==
X-Gm-Message-State: APjAAAXuKUzHrOn7h8x569QLV1w2xc+DQGXNKfGh9dF9ovco3p8F3x2Z
	tz5Jo1Jfqzn04m0QEu3ZaAkBQJ6JaJsCAWF+YdgEKg==
X-Google-Smtp-Source: APXvYqzsKrEvozZ/xJ7sPu7LaJojV9rTCPBDl+oF3PxfEI6wfcQv0fRjlrXFtxgSlhQgJ8GmJPCFA9lh+vp/Mpsi6nA=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr23737991oif.98.1558345337514;
	Mon, 20 May 2019 02:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190519203726.20729-1-richard.henderson@linaro.org>
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 10:42:06 +0100
Message-ID: <CAFEAcA_W6i42hSCOYMVicyNg3x1tZJM347wc0d=9Am=ZtHgjJQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v7 00/74] linux-user: Split do_syscall
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 19 May 2019 at 21:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: <20190519201953.20161-1-richard.henderson@linaro.org>
> Aka "linux-user: path, clone, sparc, shmat fixes"
>
> Version 6 was
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04794.html
>
> Since v5, I've fixed the ioctl failure that Laurent found, and
> have done a few more syscalls.
>
> I've tried to do more testing with LTP, but it's a really annoying
> testsuite.  There are at least 3 tests that hang forever (before
> and after this patch set), and the host kernel's OOM handler kills
> my login session, ending the test run.  This seems to be different
> behaviour than I was seeing in January, when I did have test runs
> that completed successfully.

If these are different from the ones we're already skipping
in the skiplist documented at https://wiki.qemu.org/Testing/LTP
we should update that wiki page to also skip these new
hanging-tests (and whatever it is that eats all the memory).

thanks
-- PMM

