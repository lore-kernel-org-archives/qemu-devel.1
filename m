Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA80BC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7CA2553B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNKh0T0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7CA2553B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWdQP-0000DH-Ky
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 05:02:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWdPJ-0008CZ-09
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWdPI-00076G-0g
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:01:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWdPH-00074U-Ob
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:00:59 -0400
Received: by mail-ot1-x342.google.com with SMTP id 107so2645703otj.8
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 02:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=q6pv/FQFsCWJI7vYgX4n9cwOf3W3UOWrJeFAt5iBe6A=;
	b=oNKh0T0J8j2rqelCFaprkANrXdREw0B+sEM08h4k7ZRC7o0EzRjKsMGu/2ywiWsp2V
	acJryvisC1D+0ND4orOVoaYtv6X1+zGt9k3KWM+cu6cSa/yGddJQ3xuvkZK+yQzZIvC7
	a9r6JjjhEEc52/9FF8a+MxATf0dFDHNQUH+QPH7+IpFCyUT66o2JbfqqnT9BT4MBvEjt
	IyLPFMqAOeNTPPogD9R+GMT23Cvcrfek84+Kn9bs2Yxs1sblxJbIVWayp1eThgsGIztw
	OIMdCauxJKkilgdIKQX5UVcnHy8fCeXTtik7rvPKBETku4b33b0Q9FCfipw/hVIbZBpZ
	HF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=q6pv/FQFsCWJI7vYgX4n9cwOf3W3UOWrJeFAt5iBe6A=;
	b=Joq0K6FFuy4EvRYUFmGY9PmxHLyPDRHAjREEcmuFqIYVc2jAuFxtp7LUTTNY6ZQ8bT
	nKnlRHbf8AiybwiXjDuxiEdRUa+mWUYbSHG0PezZuoRTX5COr4p/H0FLtH/OFxtYWbAs
	k3GyBCcBU4rDz0uEPFbD+8q/YkhKsYLpkxdJnVW0M78UcVJJt0w3N01U6+NFo05mRfwx
	ftB+6apV6a+LuwwfOHQV9WoPSnSjcJlRp8vJCfXvE5AhcHIKqM6gP/jygu+0hS4hDbve
	QNJlO7i00gu/Ru6MZr9Q3hhTOD//FHGQkhhFZcikvOIAKr2LzipJTIdImlHf+j+1/6U0
	YrYw==
X-Gm-Message-State: APjAAAVZjqSyLFHhKVh58C7UMPO45X2RSXN1MQ/dFMKu5Ye318fH1N5l
	6pQouyfCe3ADY1C2KRMQ5OpUuZ9H8KrsJYpKeBNORg==
X-Google-Smtp-Source: APXvYqw0mXSocs1klp9c9f6dPwH9I94qOzoz8P3RxBIXhgLWVXwjesxYhFBqLS8FAfSq7xcHH3tW2e5i1rQI+qJ89vs=
X-Received: by 2002:a9d:2c29:: with SMTP id f38mr879996otb.97.1559293258702;
	Fri, 31 May 2019 02:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190530173824.30699-1-richard.henderson@linaro.org>
In-Reply-To: <20190530173824.30699-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2019 10:00:47 +0100
Message-ID: <CAFEAcA8QoncdF-rQt7LDHx3B09xSgzrOjZGxb7L71Jh4h3vM1g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] util: Adjust qemu_guest_getrandom_nofail
 for Coverity
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 May 2019 at 18:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Explicitly ignore the return value of qemu_guest_getrandom.
> Because we use error_fatal, all errors are already caught.
>
> Fixes: CID 1401701
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  util/guest-random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

