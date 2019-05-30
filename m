Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D14C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3801225843
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTPMcnnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3801225843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWJGI-0006sF-Ca
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:30:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJFG-0006N0-LT
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJFF-0008P4-PW
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:29:18 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:37481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWJFF-0008Lm-FX
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:29:17 -0400
Received: by mail-ot1-x332.google.com with SMTP id r10so5260579otd.4
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 04:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=m+i09hM9CeqbzxFYPOj7yn0sm5pkrb1cBbZRiBx80a4=;
	b=kTPMcnnMGWj7joAII6NYgssOUR/vVOXRz0iDE/hHZ4VqhvnOUY4V5AXnm89Km9krS6
	plTEXSRa7HqLMZcPTPAWvSVEDPS4hRMy9eZ8xTCA9T+uwc96SwUWAur6wbZpTD/z5J5u
	7yJmgclZwTz1UzbZAI1OPuOzMzm6IIBu0kHegAV67YyxK3KayTCJD1zAc9MKU5W8u4yQ
	TCeuelRRGdD9t62QaGSeiS88BBZxp/TFZGDYP7W+VY+L+1+KQdWl9UZPR4gj2nQKuy+l
	XCGgnyh5Tqe9vmg2s8K0e27ctpmXRNXitd2dBbu8QNwBvxZTvR5blp+6QAoBVJD+2c8T
	ZNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=m+i09hM9CeqbzxFYPOj7yn0sm5pkrb1cBbZRiBx80a4=;
	b=X9tyqZ4//tXU07ai5pChMcId305d32mhXEynJQuw12K+Y3gud9mHvH0x0v+YzxiR2h
	hrP4qSD5Ek5wSyjetNoU8GHbfKh/Jsj+S7H96hIyFRljzB0jIfKZMXBOM6tjd8O+kLzB
	JJEyvp4llHf9v9rJJlrXdHKlH9/ECJkQF7y1Mr2Cm2ndkGRzmM0UCsyEH1GNtKr/aztA
	DFGWwL+QtLztD80ba9ATB8yEUfYD8P0Tm73q+/8B2l5QsIDk9V/DLNUojvBVQWPUwN1F
	ZkL5nhBaAWM+hQrLeOYwpIaeS6HOnrNKV/WZWRHntOssLcsKMN4w2l2/JJ5ph32jeEFK
	mRpw==
X-Gm-Message-State: APjAAAUNB8MtEDWNM3D0Y/JIBiteubJ+fo/ZVur5CqYZcOKfRKaVOXM2
	t6Tm66+n7oQ44m2muQVEbkNp31auz3JQ3ThoXN2cukdDED4=
X-Google-Smtp-Source: APXvYqxpJs6VFg89plW10rFPWsmY4LpYctptieduRlWFPyp8ATgsgQYhAaBKA/ptVrZmkPwy5f3+fiHIqSBJCWhJGm8=
X-Received: by 2002:a9d:5608:: with SMTP id e8mr2208508oti.135.1559215756369; 
	Thu, 30 May 2019 04:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190522184226.17871-1-richard.henderson@linaro.org>
	<20190522184226.17871-11-richard.henderson@linaro.org>
In-Reply-To: <20190522184226.17871-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 12:29:05 +0100
Message-ID: <CAFEAcA-=D+812uru4ZWfS5B0V-ot-RUvdWm0wV4mO8RUsETgbw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::332
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

On Wed, 22 May 2019 at 19:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This routine is intended to produce high-quality random numbers to the
> guest.  Normally, such numbers are crypto quality from the host, but a
> command-line option can force the use of a fully deterministic sequence
> for use while debugging.

> +void qemu_guest_getrandom_nofail(void *buf, size_t len)
> +{
> +    qemu_guest_getrandom(buf, len, &error_fatal);
> +}
>

Hi; Coverity complains about this because in the other 4 places
where we call qemu_guest_getrandom() we check its return
value, but here we ignore it. If qemu_guest_getrandom() can't
fail ever then we don't need the separate _nofail() version.
If it can fail sometimes but not here then we should assert()
so with a comment explaining why it can't fail, or we should
do an error-exit check like qdev_init_nofail().
(This is CID 1401701.)

thanks
-- PMM

