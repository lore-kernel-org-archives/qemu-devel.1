Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1690C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE46121773
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nz7IA0dH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE46121773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpla-0003i8-0N
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:36:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTpkh-0003Nh-VX
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTpkg-0006WU-Nz
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:35:31 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTpkg-0006Vz-Ho
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:35:30 -0400
Received: by mail-oi1-x243.google.com with SMTP id u199so4692889oie.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eZiiQDvg04dzCzt56jsZ+MM8TN+mVrl0e4KLgW6VXiA=;
	b=nz7IA0dHytUeM0k/3KjWPfBPC6NgQYCphpS2pxnCu4nTMjeCQKKTRvF1zvtKqiMSc+
	BNm2naiCCkVk3UZzK7n+kMSSUQKKQjy8KdYz7jmz6d0M6OndFXWXT+Ic6FFN4KrSdg7c
	1FD1QYJbloMXmGULJ1uV7bUtworyU1M3hQkjF6DOlLSMTFiWmcVcA0MXoZlsjhYUVy2J
	NY/tDwz4LwmugSq0xcFnO/I0VnqtLeDgpj2l6BoIYpb8n8w1/xxzne8nnyGuP2VbrwJQ
	jrd3917HBj4CVCZdVNWg2bq9erg402TE60dTPzFoA0QbEIANPTAZuutXdt7Q6SWm3Qx9
	z9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=eZiiQDvg04dzCzt56jsZ+MM8TN+mVrl0e4KLgW6VXiA=;
	b=MQ4iZB2ob2r5867/gJ+oqtITKvOyMT+vBLh7hhkvghE973Nh1RwZvhxNsg5bpi6B0I
	0N+dEfG/aKZ1g71RUqq8xkRtIvxYN5dN9GWvwQ+Ck30WOeC8MjrO8dymDBiWCZdeA03e
	jR78A1ScTBuG/XnZIUi23LmtH1+8rkVvl+Zsb/w8Ysy8OiUnLYxCSm+XX/CeDQsggBfe
	JwBolZ3SF52p2ar/SuOPvscO811CuGkj5Gxzj0n5Yo/mJ5Br+gfijVZoIgdABdS4Hwpm
	2sNgVUN5vxSqqmbkFSK3DK0P+zZl457BR+FUUzZFU3JKWhNOk9TvllI7dI8Hlb+oOBDj
	EUlw==
X-Gm-Message-State: APjAAAUaNNZcH30agYhkbfmq1ne61gljGhibVqIMJI5IDzr5+TV6YNDA
	y1L3cQZq1NvjXZ6IfJ1IJ2bKivAoquPNbI1kTCEI7EH43Q4=
X-Google-Smtp-Source: APXvYqwpTJBgUYT2vq3/1csTGqn9TwcSfS3wwRVaAFgmu71r530tBrFqR6e58hG+2/hUbMsj1xyCS3qb87f3VO34BeI=
X-Received: by 2002:aca:cd12:: with SMTP id d18mr2923632oig.146.1558625729177; 
	Thu, 23 May 2019 08:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190523140059.18548-1-richard.henderson@linaro.org>
	<155862541672.24.12725600441391809811@549697c9ad12>
In-Reply-To: <155862541672.24.12725600441391809811@549697c9ad12>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 16:35:17 +0100
Message-ID: <CAFEAcA-nZAW7QZNwtAEUXaLFzNr-Do9HAup9Sv-A8FzTp8zJkA@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 00/13] Add RX architecture
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 at 16:30, <no-reply@patchew.org> wrote:
>

> 3/13 Checking commit db39b054cd7e (target/rx: CPU definition)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #14:
> new file mode 100644
>
> ERROR: code indent should never use tabs
> #383: FILE: target/rx/cpu.h:137:
> +    qemu_irq ack;^I^I/* Interrupt acknowledge */$
>
> total: 1 errors, 1 warnings, 599 lines checked
>
> Patch 3/13 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

> 5/13 Checking commit c06f2e7abea6 (hw/intc: RX62N interrupt controller (ICUa))
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #39:
> new file mode 100644
>
> ERROR: code indent should never use tabs
> #434: FILE: include/hw/intc/rx_icu.h:9:
> +    TRG_NEDGE = 1,^I/* Falling */$
>
> ERROR: code indent should never use tabs
> #435: FILE: include/hw/intc/rx_icu.h:10:
> +    TRG_PEDGE = 2,^I/* Raising */$
>
> ERROR: code indent should never use tabs
> #436: FILE: include/hw/intc/rx_icu.h:11:
> +    TRG_BEDGE = 3,^I/* Both */$
>
> total: 3 errors, 1 warnings, 442 lines checked

I'm not going to block the pull request just for a code style
issue, but it would be nice if you could send a followup patch
once this has landed that fixes the hard-coded tabs.

thanks
-- PMM

