Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8FBC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 13:46:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E222F259D7
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 13:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMJq2yf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E222F259D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54289 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWLOG-0008K1-3m
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 09:46:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWLNL-0007me-3j
	for qemu-devel@nongnu.org; Thu, 30 May 2019 09:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWLNJ-0007ci-UB
	for qemu-devel@nongnu.org; Thu, 30 May 2019 09:45:46 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:36125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWLNJ-0007bi-II
	for qemu-devel@nongnu.org; Thu, 30 May 2019 09:45:45 -0400
Received: by mail-ot1-x32f.google.com with SMTP id c3so5649361otr.3
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ErMyDkZZzVjh4LSNyQ0aew4RuCiUfbCr2v7Eeqf58VQ=;
	b=tMJq2yf7LOfP9MJJf37Go4Y/u5Rvpu4389zNiqMA4lgBvIBaRrSI+7c+UFQcbmiLFz
	j3qHUX86m/sGEzmMDRiegJ6bcjaCHaA5xUGqjtlRqc+aVVWjG8cUDPka04wA+3mTj5Z3
	NwAXnjqAM7lDsFOY0Ut4oNEmxjabgSU397Ty4EmZD1DyvMSEhbTGdz7ZmNWE6oy3Ph8F
	NxtRIhluV40zrs5q88+zHtIgSmFXqlGYMRkNayto5ZcwHCZYBbvxiDF6S1LlIxVXK/Y+
	ZSKbzf6RRXfXtlvKSrGwmZoAqfx9qh0q+9f98QFlfzIC1s9ZCLwQXEv+p5X72GAwiLQE
	dFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ErMyDkZZzVjh4LSNyQ0aew4RuCiUfbCr2v7Eeqf58VQ=;
	b=Lfc7elbsRd+jzHy6FO091NC7w4KeRdPKI9nHyx5vOzmkgfD/TTQKCDhfNjwNs93v/p
	bbyKPAcWnr2YNDsokGqmAVrR1hupVsZcNZN1TmWw2d3yTDghQI/y0yjPhRrfDTd9bvTC
	v9Gy6SZoyhnmodaxgjTw72lbR8NXnrtPjyP8jX5lWPaxjvnes0iFhHF/S6vWvLFr4Jk8
	q1zDdUeILetokRvL1BA/PQfGMUy34d4ISE5ee27GIXadjvQ4XA+fDlgsNFRmV8xA4zQ9
	o8SDRgBuBsw60idUme9oeCya2gOB2/Yi23uo2TvyIuuK2he4JV3KXqSO8IAPCgFeD6Mm
	md1g==
X-Gm-Message-State: APjAAAXktOmbVojrnawbkBRihZ13auNMkRZCfyyyhRVJtMbnIEAAhJiB
	f6z5T6vGpri5c49mXh6/wf1tVbaPKq7j1VehFtfCzQ==
X-Google-Smtp-Source: APXvYqzMwv/QyPWa+AFFPVU13x9mfpaUM19WJVlFteP5DaGSUkdiJwQl1A6fPgzGCyZ7l3UCtIpgro/LWt35QQU4uy0=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr2705110otp.91.1559223944585; 
	Thu, 30 May 2019 06:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190522184226.17871-1-richard.henderson@linaro.org>
	<20190522184226.17871-11-richard.henderson@linaro.org>
	<CAFEAcA-=D+812uru4ZWfS5B0V-ot-RUvdWm0wV4mO8RUsETgbw@mail.gmail.com>
	<4c6a0080-85db-e81d-10f1-50acab162d8c@linaro.org>
In-Reply-To: <4c6a0080-85db-e81d-10f1-50acab162d8c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 14:45:33 +0100
Message-ID: <CAFEAcA-ULkvtVmmgQBPZA8MHkFc-OHFmDtBn4z5XKDU9y93CDw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32f
Subject: Re: [Qemu-devel] [PULL 10/25] util: Add qemu_guest_getrandom and
 associated routines
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 May 2019 at 14:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/30/19 6:29 AM, Peter Maydell wrote:
> > On Wed, 22 May 2019 at 19:42, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> This routine is intended to produce high-quality random numbers to the
> >> guest.  Normally, such numbers are crypto quality from the host, but a
> >> command-line option can force the use of a fully deterministic sequence
> >> for use while debugging.
> >
> >> +void qemu_guest_getrandom_nofail(void *buf, size_t len)
> >> +{
> >> +    qemu_guest_getrandom(buf, len, &error_fatal);
> >> +}
> >>
> >
> > Hi; Coverity complains about this because in the other 4 places
> > where we call qemu_guest_getrandom() we check its return
> > value, but here we ignore it. If qemu_guest_getrandom() can't
> > fail ever then we don't need the separate _nofail() version.
> > If it can fail sometimes but not here then we should assert()
> > so with a comment explaining why it can't fail, or we should
> > do an error-exit check like qdev_init_nofail().
> > (This is CID 1401701.)
>
> Because of &error_fatal, we will have already exited on error.  As a qapi
> programming pattern, that seems clear in this context.

Whoops, I didn't see the error_fatal. I think that a cast to void
will indeed silence the Coverity error (at least a quick google
search suggests it will).

thanks
-- PMM

