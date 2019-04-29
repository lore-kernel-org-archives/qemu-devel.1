Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452A2C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD0920673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRrjTXRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD0920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL78l-00036x-5s
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:20:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL75a-00015p-3u
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL75Z-0005es-CI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:02 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL75Z-0005U0-7q
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:01 -0400
Received: by mail-ot1-x343.google.com with SMTP id u15so8704769otq.10
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=yRdimTruHnaYAfntnwK9F9KnC1KmxcYmJ9WjuzAppmE=;
	b=KRrjTXRoyKdxHhDo2CH/yPQJTyi1VbQ7v2VBhPiSC9ztq51qpcikX1gcPgFIsphcBE
	o7p/TxfqVlWEw7GgH2DdKyjW5spFYpLyS8oPR0PBqmnmE34ckwRp07vHE0E9pRz6vk+h
	l1nojplAGwF+FBc3vHCIE5zb4RfHjYLIFDoR+WBraiw+FaLSok/N8xydYEw+/YNaIOWh
	xuyx01qUR5vDTnrzueDU9kfL3NRjLiCfWsuBlJloK97htIR8Ddj8VfBjLcytXjkJQC05
	N8Tt66QYUlce5WtfHfUFZKtuzVHDf+LOeAk3gxTRSujhevAhafD/POHkVmHWZIO8QKvZ
	L5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=yRdimTruHnaYAfntnwK9F9KnC1KmxcYmJ9WjuzAppmE=;
	b=iIZ4acM3H0K9S2sVbAhjID7OJ2eZEfYtvLVbAFaOI5UP/qa2h9tuZ25+duQBGU5/in
	6J/tbhX9AleTzLrmC0C9lwn8IsH3pXAR/mr2x64TRv24smTcEfiRnX91gt1f1VXq+mLt
	bF8TDm8GVfhAhArL2U0yc5f+8EyZ604op7O28JM1w1gdufDxGc1tohf5ZoZGtBCgOIfi
	yfvIfUkjJMO45qF8IHLD3b508pIO5jF93P5TPSUZaSrYqefPBjAtzBxvj4fatMV3J/W8
	fAPcw6kw5Ag9Fa8V7GWowFKPfR6hZW1XewztC7qMHAiWf+ShxHFuEKQofuWwvpevs+tR
	I2Ew==
X-Gm-Message-State: APjAAAVBt2ffrxlk46Pw8nZnkjRANzEpBnbqUqFn5H5LDBaYm4AsYx2x
	goqeETTWJM3NdFVRt3bnuSphsw5TlFA6T5kXFk8zow==
X-Google-Smtp-Source: APXvYqyOAMIyUskJbkXPtauO+QDxwp0Ah46TeorObsK6O9IfvbwcXvSOp/+WzIcIPc6yw3Gn4mnVSk3KToCkNkb8QlU=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr1339555otk.316.1556547404586; 
	Mon, 29 Apr 2019 07:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-18-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:16:33 +0100
Message-ID:
 <CAFEAcA-2n=wjNcLWyNvmewiUryyt+sTXY62jbRyVa3Xmj2ak+w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 17/36] target/moxie: Use env_cpu,
 env_archcpu
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
Message-ID: <20190429141633.QLG1C93HO5AjZ-UxxqTWo9MptbKHrrt5oYfDTzbwT5s@z>

On Thu, 28 Mar 2019 at 23:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/moxie/cpu.h       | 5 -----
>  target/moxie/helper.c    | 6 +++---
>  target/moxie/translate.c | 2 +-
>  3 files changed, 4 insertions(+), 9 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

