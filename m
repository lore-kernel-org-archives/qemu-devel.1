Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21E9C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 12:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C252252B3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 12:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtRUUjNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C252252B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53519 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWKJs-00086F-HG
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 08:38:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWKIl-0007Xu-I4
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWKIk-0008Qt-MJ
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:36:59 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:46334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWKIk-0008Gh-FH
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:36:58 -0400
Received: by mail-ot1-x334.google.com with SMTP id j49so5398996otc.13
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=SNhDjSsemuPua9o7EteytJfzv74/9R2ERNOQV11FCkg=;
	b=gtRUUjNGz5WcK1q0mE3McQZNFlmnr+5vghfPfPw0O3ftbyitlTmic3ESP+QU4YpwM6
	dtxrvVLgrtuW/osFylnOVD++U1Lzrd32TInDCywE7k+FGPftc3OJhImX/RKj798Jg8iW
	zV9BXATpTDGoL6H0VLE4sCzf0R+30Xz/isYoLWpn6YPamIJ3UJuiHJuacgGE58srnrkN
	1xTQyRLTkOuqHmj4K2Nx8ZfQpUsejWyPuehPVnRPU5UMi+jgthTRMogTupEnxV6Lot65
	oE6Gc0tZ+Z2PcOZEQ0r1IycGpaSD2Plg8VEHdbMCN6zfaciSJEdZ+dSymU2Cv+AZCSG2
	YQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=SNhDjSsemuPua9o7EteytJfzv74/9R2ERNOQV11FCkg=;
	b=rz1HKmqwn2BlUFv4SaOKLB5b9JJEnGNaYRZYNOpDAxiWkfMe64tq1vOngqCIZEF3aT
	icgQVwWs3wOCe2DnAdpTfrV8u3JwTvGsffNrV6ZvIeO8kFuboW8njwz8NG6Bp75AXdAl
	tLDXMWBb61Ngkx2i3s+9b5RbJmKBFziVR99Rwn4sjTWZpoboZumEDKLAWrZsjqceuwFd
	IElQ0/1pc7EZzMaHeQFAs2Y9NvojlRRO1F0OmL+BvBGYbT/gdleOCAg37jK4PlOxHDAv
	PZyqhwlRrovyBrE4en7HZBe7W64bAQz5PJgegv4BdwWfvfr2eQcp0WQp+ebdMckINTjx
	x/0g==
X-Gm-Message-State: APjAAAWkS1nfkD4Q1tprvK/bToFyURsNwvHAfgp4Uzh4I+tswzNDmuEY
	un81MaVavKYewncgWYYcVEdcbz5gqWoByDvgukwXoA==
X-Google-Smtp-Source: APXvYqxVYJLaNeCSkyuj76RNGsZiSLJCe9qmWrrCTxGIruiqFPONjOjHYpxwCJbLjvRYJwXdrIwtBI9tVG9m9D9hELY=
X-Received: by 2002:a05:6830:209a:: with SMTP id
	y26mr2464331otq.232.1559219817616; 
	Thu, 30 May 2019 05:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190528094953.14898-1-alex.bennee@linaro.org>
	<20190528094953.14898-7-alex.bennee@linaro.org>
	<CAFEAcA8Azc9g7MfWE1_WbRQCMejHXpE62bYojRw+B9maAX=+hQ@mail.gmail.com>
	<87zhn43yt8.fsf@zen.linaroharston>
In-Reply-To: <87zhn43yt8.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 13:36:46 +0100
Message-ID: <CAFEAcA_jaYEhnw4C6oPEW6tMvVC+W2v-upPqf8y1qmtm9CkJVA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::334
Subject: Re: [Qemu-devel] [PULL 06/28] target/arm: use the common interface
 for WRITE0/WRITEC in arm-semi
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"open list:ARM" <qemu-arm@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 May 2019 at 13:35, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Also it looks a bit dodgy that we are passed in a
> > specific length value but we then go and look at the length
> > of the string, but we trust the specific length value over
> > the length of the string. If len is larger than the real
> > length of the string (including terminating NUL) then the
> > write() will read off the end of the string.
>
> It is an admittedly in-elegant hack to deal with the fact we call the
> same function for outputting a character as well as a string. None of
> the guests actually give us the length:
>
>  * @len: length of string or 0 (string is null terminated)
>
> We could formalise it by making s/len/is_char/ and making it a bool or
> just add some more text to the description.

I think it would be cleaner to have separate functions for
"write a char" and "write a string" rather than having one
function with a bool flag parameter which every callsite passes
as a constant value.

thanks
-- PMM

