Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5093FC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B5A2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWzbRK++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B5A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42992 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLQCi-0006zq-9n
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:41:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQBx-0006gy-DW
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQBw-00017G-GH
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:40:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLQBw-000171-A9
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:40:52 -0400
Received: by mail-ot1-x341.google.com with SMTP id r20so10305914otg.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=I2g1JZKKUGt7zUMCwvl8AylYZZl2MDUGCK0hlhPv3Ws=;
	b=dWzbRK++/mgT9s/+h1RH25HLF3UAHEtf0+k4dRccSGm+BscsZlYjnDZEnV2fjbHw2r
	sqOSr2kcfpEmiXfGvQjEGsMRnJOCtJyfbGCb9BWZxhZwCTe+XCfHh6KVwzpwLtXb6FGU
	rBd+7yQGQwAlpFQUjJRGL8rkVtJwc9yuwTSH3tQKmJOsxf15tePTWMXz4bDk9ozxIf1w
	7+95ji4UYdDfs2C7VTuo6lSRPMImzWXGVmSkejyrPTuOOXi5uI6x9MzuWcrwV5XyTdbw
	Omjy/+myhxUubav7hjINvGXPHgnpG+QZMISxXVK5O4KczVZ0Ei82l2Dsh+7p708UvMhP
	0mBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=I2g1JZKKUGt7zUMCwvl8AylYZZl2MDUGCK0hlhPv3Ws=;
	b=tDjvZK/XQNMb3kcE5pg8nMTnPhc+gerukhsfFZ3Z7uXYtpQ3yRYYGqpn00MnsNaT2s
	mwvxs052ZNXotXUfeZDwsceVrWcOM3bMbbyl6uEyY9sm6eBsJooBsnXNNeTZU4e6P1KZ
	ajIcEP8l1fifL8XenK82LgvpBHxgwyPn3eD2BtBk2+wUHmgypG+oRURv4/Dh3iYwB7iQ
	V8xtKCG+iRqNe7KRt8qgF3NhRFDxIaV//FLvOVVKrK23qaetJk8+XLZHDZTHndaaQjLr
	AHH0bM0wA5TrXZ8NtyqT/+9VahgoFI1usa3CX5EhdRTlGJ84E+eHF0ucs0bSI2f+t2Hq
	w7TA==
X-Gm-Message-State: APjAAAW12IYHrBA/Zio4Vfd/kwKr6/jsOLZOTdfwZs5uy7s+Q9eIJcMN
	+uk/bSZW+jpURZAgSHk1QI8LLQSi6cjVzAbkUUR1+w==
X-Google-Smtp-Source: APXvYqxjvu/vGLyrt5W/fKCKv/DRYhMP1GbS8r6goaxVXxM6nkTHPTOaZUcba3lS1AYUt1BlGYowj/s+E6mQspp4RtQ=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr4433492otk.316.1556620851272; 
	Tue, 30 Apr 2019 03:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-3-richard.henderson@linaro.org>
	<CAFEAcA98_q1yx==QkHO1HiJA8cJqGv8k5OrCU5W=dC3ZWNPY=w@mail.gmail.com>
	<920a0801-ed1d-23e8-9975-43d4d185707e@linaro.org>
In-Reply-To: <920a0801-ed1d-23e8-9975-43d4d185707e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 11:40:40 +0100
Message-ID:
 <CAFEAcA-=JyNF94OTq+rJRVxbfhJ_B6=fLm93s+y0ScX9Uyfngw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v4 2/4] linux-user: Set PAGE_TARGET_1 for
 TARGET_PROT_BTI
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430104040.vrEwGk-z6lmGOa6SRZIf09-voxEdQwlxEOWs41zBpC8@z>

On Mon, 29 Apr 2019 at 21:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/29/19 9:21 AM, Peter Maydell wrote:
> > This looks ok code-wise, but we'd need to hide it behind
> > a defaults-to-off x-something property if we wanted to
> > commit it before the kernel ABI is fixed.
>
> I'm not intending to change the user-level abi, only the
> internal abi within qemu, for handling of the elf notes.

You're changing target_mmap(), which is used by the
guest mmap syscall, though, right?

> You think this should be done differently, so that there's
> zero possibility of a user-level setting the relevant bit?

I think that we shouldn't allow guest binaries written
to the ad-hoc TARGET_PROT_BTI ABI to work without an
explicit x-something command line argument to QEMU, to
indicate that the user knows they're doing something
odd and that these binaries won't always continue to work
in future QEMU versions.

thanks
-- PMM

