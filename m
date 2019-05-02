Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9106C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 12:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721CC20645
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 12:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAvb1nob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721CC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50337 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMAbY-00075t-Kt
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 08:14:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMAa1-00066k-4n
	for qemu-devel@nongnu.org; Thu, 02 May 2019 08:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMAa0-0004vp-3f
	for qemu-devel@nongnu.org; Thu, 02 May 2019 08:12:49 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:43207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMAZz-0004vK-Tb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 08:12:48 -0400
Received: by mail-ot1-x334.google.com with SMTP id e108so1795511ote.10
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eK/BD6T/D7L5UQzRPwbDn7AvvJ5talP97DW9j4BBwv8=;
	b=dAvb1nobrunXLMq3TToRvUiCMtBtPrg17lpck1znBGMDIiMOOdaW0LhpBuWw1alTsC
	Zg0ggJnN3foSM1mdsZyHMI+oocCrsIYb86pjRpF6vE5asq0dVVDZg7UCOfz6VBmDMORo
	j75zxQlb8vJsWa0zJ3SgKzKUPB25UzvjLv+6wq6WSxnzOD8XMH43nKYMXUOBvyPN1Zn1
	Cq7fI9y03K2sgNOJUQUP09/BN4FlDaOysw4fHpmbkxU138PXLA4Sl7oKOssTXpb3tUlH
	O6Ii0sjX3RRugYHvc7ukdx+E2EqnkcGTIo7vJwn+Sj9oHfiH9JNO9SErh/RqHRfbeGUg
	CHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=eK/BD6T/D7L5UQzRPwbDn7AvvJ5talP97DW9j4BBwv8=;
	b=FrZgyaZeHFzATyUrcDGPC/BaHWeCvcmOlXZGuDnIbA64yYgJk/Tyb6AMsKeuAAFizk
	PFAnJBIldJloGQnAKV/hGYiJ/eE0BK+fdSP2oyKfSkrL/XSqAb9mNtK118OQfZDgM6vq
	4nUkIH2FNmw5OpnvwWF3vUkVXt42KeV/kWREDPjvaPo5mbgVYXwESdaLAuWKZoiMgezK
	g+RIVd4PR5hxgmbeX4z3z0DflZ1LSHwRi2jkLoSV4jLxGdoTkO9aDcxA/Gcg8Z1z0S2J
	XWTrzuusKcYdJDYO04feIBJ8Yopv4MfqOB8v9bECSkzBmxhu1cBz4i4z0gb8omPJdXWA
	lFCg==
X-Gm-Message-State: APjAAAXS6iqaqWqtcxDk/FMxSISYoIR8JEsSWZgMmNvmsxXpCCG9wGbN
	4O9SdAQE6WyDyZFJAAxALwpeZO+ypOQNFzZIZnZ/8Q==
X-Google-Smtp-Source: APXvYqxOWjg+kWDhxWrAAVNWOm85dF0YFtZFBTfxYFNJYghR0+UbJh6+hTJxeFrIU/+Uta/agl+HDvchN7QZzXBzOro=
X-Received: by 2002:a9d:404:: with SMTP id 4mr2157111otc.352.1556799166791;
	Thu, 02 May 2019 05:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190501202506.13875-1-jsnow@redhat.com>
In-Reply-To: <20190501202506.13875-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2019 13:12:35 +0100
Message-ID:
 <CAFEAcA9etUEg3E8VGTMqcfNM+5oxqnY9x8zdU_mHN+AN1og+5w@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::334
Subject: Re: [Qemu-devel] [PULL 0/2] Bitmaps patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
	qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502121235.P0nH5l_TrPIU5FDofkexRe--f93iDgxwiOOgy_fTODo@z>

On Wed, 1 May 2019 at 21:25, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 46316f1dfffc6be72e94e89f7b0e9162e7dcdcf1:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190311.0' into staging (2019-03-12 13:37:29 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>
> for you to fetch changes up to 90edef80a0852cf8a3d2668898ee40e8970e4314:
>
>   docs/interop/bitmaps: rewrite and modernize doc (2019-05-01 16:21:24 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> John Snow (2):
>   Makefile: add nit-picky mode to sphinx-build
>   docs/interop/bitmaps: rewrite and modernize doc
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

