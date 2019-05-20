Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB28C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E494204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guNvbUPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E494204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34797 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShSy-0004bU-Hb
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 08:32:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShR4-0003Qw-1Q
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShR1-0004vN-Tz
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:30:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hShQu-0004om-FU
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:30:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id d18so14403032wrs.5
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 05:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=xrwvphnno6l4ixveJHj+AxfroZn4GSIECtB/pT+LZo0=;
	b=guNvbUPn+75q+4cCNaxrJTth5vsxsH5h1qlOjsZevvfZVo2aK+z3SPIXDR8BtD8h3l
	isQkIiUMd2BZ7mJP5Tec/A4VFJdcKnr+2IMoNtYl5LrkeXY0x8mRKckCBgMk/djS82SV
	0fM9aJaIHF5en9cQfUa8XUEh8ZewstxrEbGn9VXwHZlQoTa+ZUi0g6DvFcSHEA34DhYB
	2CUniLw8TJeO6JOE154M+2bVIw6/tkwXPVqi0WAW/Lulbg4hsKjDryANtLceERaz7Kq0
	PYqhwGaINfqfP69t1+onsuJdkew/Ld8VB+UFrip2TwbmHrBy+amYQRGbCi5LSo5MUOjT
	QyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=xrwvphnno6l4ixveJHj+AxfroZn4GSIECtB/pT+LZo0=;
	b=tUQxqRt5b89KnFaGuK8AqthUheohw9mJmD4J/Uph0kh0oIE782+C+sy7YYRjJF6HYd
	3+lkgOzivoVNcGrZNEukQC7xKau3C+bNXte8r+Um9aeKO6fKtH/7xw2gTPpjABIZr1YX
	n5hgHOI1MBzg4sagdwkBH7NNGctfm/FfWbKl9dBwio8EVIkwjZwQ69CCxDigYg+yh71l
	LmXyxL374mzXYg/BlA2hvVfKUYDft8LBc7pvCpPARjQl1eyeGBIj3foNLicwQW++yieL
	30PY9hWYZSQGck8Wh5VSt7hh9M3anj7FxJ3VhVUIAyk6kXW3Y+m5sgSPl+LzcbqMt7B7
	dEYQ==
X-Gm-Message-State: APjAAAXI+9R0jTY7yRFdFDE3tJDjICzZdeyqHq7AhMpx3jXEE3uJHUSt
	8sxxCw4sowzDaOAfXAk49bepMA==
X-Google-Smtp-Source: APXvYqxVz8guds4p5tOe3lyNVL8Ir3skm20VW1uXCeX/DHjDMv4ncBVhpwL6fOVCClfQ7GAbJ9SUkw==
X-Received: by 2002:a5d:4946:: with SMTP id r6mr32592842wrs.310.1558355418769; 
	Mon, 20 May 2019 05:30:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	88sm42391956wrc.33.2019.05.20.05.30.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 05:30:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id BE09D1FF87;
	Mon, 20 May 2019 13:30:17 +0100 (BST)
References: <20190517224450.15566-1-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190517224450.15566-1-jan.bobek@gmail.com>
Date: Mon, 20 May 2019 13:30:17 +0100
Message-ID: <87v9y5gvfq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: Re: [Qemu-devel] [RISU v2 00/11] Support for i386/x86_64 with
 vector extensions
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> This patch series adds support for i386 and x86_64 architectures to
> RISU.  Notably, vector registers (SSE, AVX, AVX-512) are supported for
> verification of the apprentice. This is V2 of the series posted in
> [1].
>
> I decided not to drop the register definitions from the second patch
> as suggested by Alex Benn=C3=A9e [4], but replaced them in the fourth pat=
ch
> instead. This keeps the second and third patches code-motion only.
>
> I wasn't 100% sure how to acknowledge Richard's contributions in some
> of the patches, and eventually decided to include a Suggested-by:
> line. Let me know if that's (not) acceptable.
>
>  -Jan
>
> Changes in V2:
>   - included Richard Henderson's fix-ups [2] and vector register
>     support [3]
>   - replaced the magic numbers for XSAVE feature sets with symbolic
>     constants
>   - symbolic names ("sse", "avx", "avx512") as well as numbers are
>     accepted for the parameter --xfeatures

I'm not sure where my test went wrong but I guess it's around xfeatures.
The code says required argument but risu doesn't seem to stop me not
specifying it. I suspect we should default to the most minimal x86_64 we
can and explicitly enable extra features.

Storing xfeat in the stream is a good idea so people don't mix up their
dumps but we probably need more validation when running in master mode
that the feature you have enabled is actually available on the
processor. Otherwise you'll potentially end up generating test streams
on HW with no support and just get a bunch of undef noise ;-)

However the series is looking pretty good so far. Looking forward to the
next iteration.

--
Alex Benn=C3=A9e

