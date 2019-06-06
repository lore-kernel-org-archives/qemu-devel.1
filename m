Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBFAC28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C9B207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1+Wt+iP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C9B207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58961 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqxT-0008EZ-It
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:53:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYqwV-0007b7-FR
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYqwU-0007V3-9f
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:52:27 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:41159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYqwS-0007R1-Jg
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:52:26 -0400
Received: by mail-ot1-x332.google.com with SMTP id 107so1638611otj.8
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 04:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=A7C0h/TfFaxqOtUCw5B2LDS/Hp657jd8wZcMNGFcB74=;
	b=b1+Wt+iPru8oEGaVcpoJvy2iyTXBkAvyRqqArc0q9vHdhiOMNJZ5+PMm+7rs+O6yro
	YyqdGB4Noo9XGmsNiDC4nt7RvjLbWGVG2vJLwkybHwus9774UEsl4xRQh5F/F8PIldvY
	+QvjyE7P5C8HkdPZC7r+EXbWo+xivm5QYE+cknIZNEQGbZ4SE/MJbYHFVHeaaBqBDxVY
	gV5WMQb9qU6GoN+bGQhqX037T7DCLbNzzQGw/tsXd3+hp+QmhvrbHhL8G20qCPeqHD5X
	px3i7eBb+3YCcf+yZ0mxhHuNK39j5lSHbM8oREydACejC++fR5qR+3vTwBwLNq3i+IB5
	b5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=A7C0h/TfFaxqOtUCw5B2LDS/Hp657jd8wZcMNGFcB74=;
	b=qYNeZ4yt1ePw1bKKZ8S5pCm3vlBJ2daakwrPIRmYPFPwBOtYlD+9A1g6iKDF5BWQEx
	/SR/d8PrsWtWOeXAYZ8+AB9MQnuF2NeR2X3tcJVUSZC0zJrlzRFqKwJStnVPMYjPDvmt
	dl1h3CvtdD9qWemWvMW+6mIiOc0i2XhBBxeEh4a9HPRudKafxeYx1HUnysjJ6IFezC/f
	Bu38wjareVZqdKIKTg02xbIA3Hm/kEVGgpw47HZBCsTeHRszisVG8NlrBFJ3VEki3+Hp
	maAnKVlbewY5kO+Vrd4SKDjuMPzniKs5Q18pFMM7IXbqgKl1PPfYNejayLCMLKWrJdZ2
	BBRw==
X-Gm-Message-State: APjAAAXHoqhNbbkTjr5qxpYK4skr9kGG6ZZimHMmFj+4HtKATgjegpAw
	z5PrLWpoH3ElZthgxKF9oKinxnAu2cTNrm6yIIYZcg==
X-Google-Smtp-Source: APXvYqz1CMbbrk8k0rFNW1z36Sw1EuZnMhMgWaW5hFaNhOc6Kf3SomXTGumaWE0M16keE8xDUZnj8axfafCe3yNjA5M=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr14556222otk.232.1559821942439; 
	Thu, 06 Jun 2019 04:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <1559745620-18828-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1559745620-18828-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jun 2019 12:52:11 +0100
Message-ID: <CAFEAcA-DAbnXyf6=LmFTsP3RroLv9H4uVrUcjG1r4j3+H_v3EA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::332
Subject: Re: [Qemu-devel] [PULL 0/2] SCSI/vl.c patches for 2019-06-05
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

On Wed, 5 Jun 2019 at 15:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit c87759ce876a7a0b17c2bf4f0b964bd51f0ee871:
>
>   q35: Revert to kernel irqchip (2019-06-03 14:03:03 +0200)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to edfb4389c26cbfd873707306024130bda6049780:
>
>   vl: Document why objects are delayed (2019-06-05 16:15:32 +0200)
>
> ----------------------------------------------------------------
> * Fix pr-manager-helper (Markus)
>
> ----------------------------------------------------------------
> Markus Armbruster (2):
>       vl: Fix -drive / -blockdev persistent reservation management
>       vl: Document why objects are delayed
>
>  vl.c | 13 +++++++++----


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

