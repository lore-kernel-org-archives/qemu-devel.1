Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C17BC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575B520656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lur107uV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575B520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57926 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmKT-0004oV-N4
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:55:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOmJc-0004Mh-9V
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOmJb-00088z-9v
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:54:40 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOmJa-00088L-Nc
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:54:38 -0400
Received: by mail-ot1-x344.google.com with SMTP id f23so2923094otl.9
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=o/8Jsiv0uTeGp70LdVI1zEpotx/WMlKHuO9O8CVae+E=;
	b=Lur107uVhf7h91ogbRFh7tOFu+0nUBqnXVQwHBhoVPdre1RbIENiHuvIyJ+4hufdyd
	1FLLgdJhrGs1HVk5VJFxzV+y681eA3veIy5mnaG3WB2Jsb15PjeoTZiY6KJsUGMYLvbl
	BnpA5i3ZcbpLp11VMK+4AXFCCmEa/aeTJ5d3ne5TtY5LcghelYNkzfE1c/+BY4SlAPTL
	eA+Wbi2058F1xgrB6dVmkZTzl0P/XETUtoqyoIiFUqLSP1WvCo5vT1jNw1vy07A4djwk
	sbMbpYFS14qpyXwxVi/exBGWV/YgVeRFHelkOg2pEWQVJg8PXRlmtbTqwPQq5tr0m8Mx
	LMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=o/8Jsiv0uTeGp70LdVI1zEpotx/WMlKHuO9O8CVae+E=;
	b=bJA2dL5r2mHOrJNwaZF7tZxG6ll76da6QdEg0WxyTfbAjsush4d5z0tzMcGLoqJs+2
	wHJq2mJK8T0g+aChYudLIYPYmh4FUNica4xHEgyEnjFX2L61aACmzKBbI2McyqeH2HBz
	0eY/TtS4G5p/Nv4TqOUJIB17DGZd9ojdf0jK7EbTapsdvDn8kIjHGhPcCc6nZMacAAzk
	9ES4iMquJ6JF92zvJaYehD3s+Tkn05wTg75V1P0aDUfGh4NkdSdiWGdF9/EC4R3ySJt4
	4D4Q0LYJXSQh/7L7X9v9w+1lp30Chx1ApYFDEgNjkc2xTwbHS8MCb1X4MCtVgwKK7NP8
	Eyeg==
X-Gm-Message-State: APjAAAU81Ou3ksZiskMfT70qx0OIas2HtNfaZMVwhFKtBTybyhbnyQU9
	z2XGHUKt8cA/EQodcFu3t43h3IvgxZ0okcACdKO2HQ==
X-Google-Smtp-Source: APXvYqyL0YOnQb3mcY1LMZDPPMV8y1ia/A7YcxZE++o5Aq+hMYDJ4fFGejBQyprxJsQH1aSDvqU+5qhk6JN6bB+/TVw=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr2406377oto.151.1557420877725; 
	Thu, 09 May 2019 09:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190507134521.31044-1-thuth@redhat.com>
	<CAFEAcA-j+wQXjPW+puxk=foi2T8O=MzXHtxdWJ6E5P7o89WQSg@mail.gmail.com>
	<c0cda8fc-cc68-eadd-0750-cc9eeca094a4@redhat.com>
In-Reply-To: <c0cda8fc-cc68-eadd-0750-cc9eeca094a4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 17:54:26 +0100
Message-ID: <CAFEAcA8RoJ-ZSsn3Lhzj5hd3oYOE7Uxy8MvUUWrzhNfBmD=AWQ@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL v2 00/28] Kconfig for Arm machines
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	qemu-arm <qemu-arm@nongnu.org>, John Snow <jsnow@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 May 2019 at 16:33, Thomas Huth <thuth@redhat.com> wrote:
>
> On 08/05/2019 17.09, Peter Maydell wrote:
> > On Tue, 7 May 2019 at 14:45, Thomas Huth <thuth@redhat.com> wrote:
> >> ----------------------------------------------------------------
> >> Kconfig settings for the Arm machines
> >> (v2: Fix the dependency of q35 to AHCI_ICH9 in the second patch)
> >> ----------------------------------------------------------------
> >
> > Hi -- this is still failing in the build test where I 'make clean'
>
> Very weird. What is running before the "make clean"? Could you provide
> me with the content of i386-softmmu/config-devices.mak please?

Nothing runs before make clean -- my scripts effectively just do
a git merge, then make clean, then make, then make check.

http://people.linaro.org/~peter.maydell/config-devices.mak
is the i386-softmmu/config-devices.mak
(it does not include AHCI_ICH9).

I notice that "make clean" does not delete config-devices.mak,
and "make" doesn't cause anything to update it, either.

Further, if I "touch hw/i386/Kconfig" and then run make, nothing
is rebuilt at all, so something seems to be wrong with our
makefile dependencies somewhere.

It's kind of weird that it only shows up with the from-clean
build and not with the incrementals, though.

thanks
-- PMM

