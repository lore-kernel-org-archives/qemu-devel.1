Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8587C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3F420656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuMv6FQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3F420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7ma-0000dG-TB
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:01:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7lc-0008T3-RE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7lb-00015F-8O
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:00:28 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7lb-00013n-3M
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:00:27 -0400
Received: by mail-ot1-x343.google.com with SMTP id a10so63716otl.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=E5RF0Ia1Y5fxdB6CYb8ZjPq2PzSNq4s44TzJmH8Vz/o=;
	b=DuMv6FQjCINkfTRibj9ZRv03z9IVh0CR9OOz1BRenWjFlpSYG7KMdELWsL9V5z28ua
	4zdjvTE0mE7TucQ11CS7C/pPWqczlHW+fRGieFZsjmVWrlHp8IXsVX4ZfKaVdysJg6pV
	3ibHKW72VVb3wiBgXmpdoP1PcDZQwNwEqPsOcV3noEBtVMOR78lLnFtcnYtFbj2xbEWK
	OIIxMfChPEF9PKpwCNtOegZK+8yC4BCrBjKGFvs/ZTATyKbvClNi/bmaO5MIt8U8XNPP
	OgioFSlOmg/k5wMPH8sidkpZuIkuNK5YwT2u6LfJY5FMrPHNsI4XviMAtG89VToaU29g
	NduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=E5RF0Ia1Y5fxdB6CYb8ZjPq2PzSNq4s44TzJmH8Vz/o=;
	b=muabFZZn3dlFxT0c59gqHxQzAibYmbbHLl4XqGGzWCq+kK0mUZwjHqNDhMHEWWf7aJ
	dQ4qUEFNYysZIm3yDpgkav2+C/rcea8J+nij2jx5oyZoWHrn+ETCDhL7Z81lwesntK6P
	Q0utOzudJrFYw3edAWtinXMPomsLYmhnRb6tI7dJE0I+a3Vi4oTJu3b8eVXqkfpYP0hO
	V5C5VpMUvoElbRrp4JhdkJl+tt/+hr7S7sw0EO8h6+6Dc/tjkkk1Ti/JMr5X8DakxolN
	kTfjcE6vY/naXjPQZT+RjJzb5X3mrXo57qm5DYw0GsCpNsYPC1vnk+Rp+gkbhcfwgBoI
	+XPg==
X-Gm-Message-State: APjAAAUfRRdtfGzy7zd1kpGYt+Dz3giWkYUv6fGahUpN8cn+mkSLhwH/
	yAYwB12naHWT7GusvJGslF0c2z8ATOOwbr490A62CPV+YYo=
X-Google-Smtp-Source: APXvYqwbr/FfVBj8jJFBigzM0qBMUJxFaw1NjU8Mo+V98OKuRjSlaXv8Bd8xFN6SWmqm13uCSDw1NoqyLGs2XWllAFw=
X-Received: by 2002:a9d:404:: with SMTP id 4mr36672498otc.352.1556550025607;
	Mon, 29 Apr 2019 08:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-37-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-37-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:00:14 +0100
Message-ID:
 <CAFEAcA-an2BRh+Ji0y-6P9e_3=Z22CDVSMJ1RAEXefa-MFZdFw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 36/36] tcg/arm: Use LDRD to load
 tlb mask+table
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
Message-ID: <20190429150014.RLDh3NIbmowQf-vPm8-0lnUN_rNn6_qEEs0CULiShCo@z>

On Thu, 28 Mar 2019 at 23:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/arm/tcg-target.inc.c | 109 +++++++++++++++++++--------------------
>  1 file changed, 52 insertions(+), 57 deletions(-)

I think this would be easier to understand if the commit message
included what the old and new generated code fragments looked like.

(git diff seems to not have done a very good job of identifying
what's actually changed in this patch, unfortunately.)

The same remark about a compile-time check that mask and
table are where we expect from patch 35 applies here too.

thanks
-- PMM

