Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D9BC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAEE320652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+rxR76b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEE320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57328 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL5tA-0003xI-Vl
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:00:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5s3-0003LZ-QL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5s2-00018h-KQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:58:59 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL5s1-00018J-VK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:58:58 -0400
Received: by mail-oi1-x244.google.com with SMTP id t81so8153681oig.10
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=2NwYw4b+IY8M1YCsdRxbhgNk1mMcb2Nc3jtJjBgki9I=;
	b=C+rxR76b1anyoTzvOnkmMgBE6S3nboec/wWOsEDgwS2KK6lMB1r17oQCcg4/kAKF0z
	PN7mhxELRBIgyAdl0Foku62EBIdeYxfeYkjlii/1EBi/vJ6cmaA8nmac5Ho8RJjz82IA
	/6W6a2uI0vMjUaRoQkeUPJQKeLpbvmGWpFtUTsPqWFfTBWctnhfrTKaYB4en0/pFfwTk
	dGcYumXDV0oXa4NPUBHs3sCIs1DonDHteX5aJl/XGHSz+bPjRx4aEtX/goc5b/GyHd9a
	r9mUNexvpx7GMqa/ijjFu2cT575BG0TPAy4HQiRpvZQKlWC+gZJkgY7ccdFhCMEj0I3Q
	Sgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=2NwYw4b+IY8M1YCsdRxbhgNk1mMcb2Nc3jtJjBgki9I=;
	b=f4SyGb4iidaLJQoEX295X+pR+KBlUCk09GEEgaBfAa2qnUF+WeNXne+4i6fhHu51if
	K0Lwitr1sY0PFn+dmJ38RIY2uK4gYKB9AaqKqQy92BeZgCEoIRyniXtcFqX5fEsGMpAU
	S4854eoJmF2jKkDMqvyEDc7qIvvbeyVsO8POkuLthaPu7x30H/Xd2J4nFzVC7eK1Cbg0
	ohDBILy8SjJfJlXgmnjbROTTNi6thHo7vzTrCiDFeRc9WDy46JWqZsoOiN1H2H6GdRhB
	ySNQaFmrIgakRb9uIbp9zUaQFJhaSAF0+ToQ8QgsmBKr0IcIuvC88lFPk5OlKOJ8scfP
	Blug==
X-Gm-Message-State: APjAAAV58IJdWJKOcUeIZ44Yfve3sAOqK2Iw1fc6a6dlzsYQIFk6hb1d
	Hh4KLbDzf44IOCBAXxzckbcnKgHURQ98DxXsWV/8/Q==
X-Google-Smtp-Source: APXvYqxBHccMqWKsqWDz1ZSQ7vm/0xhup6iPl8eHXjgDoAbUA05cg0QjiwXIheACiSowdp38vOY7XN49BsabzVgqvAg=
X-Received: by 2002:a05:6808:301:: with SMTP id
	i1mr12823600oie.163.1556542737181; 
	Mon, 29 Apr 2019 05:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
	<20190426091702.GA2071@stefanha-x1.localdomain>
	<CAFEAcA8OVKO087uiNvwDGObiaxHAPYHwoXLEN1t5Y4v9B43r9A@mail.gmail.com>
	<20190429122819.GB7587@stefanha-x1.localdomain>
In-Reply-To: <20190429122819.GB7587@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 13:58:46 +0100
Message-ID:
 <CAFEAcA9_=a72BAmyb0eJhLF_nYLhRb_O7e=__MPazQ0nLC9Tmw@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
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
Cc: Jim Mussared <jim@groklearning.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Steffen Gortz <qemu.ml@steffen-goertz.de>,
	qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
	Thomas Huth <thuth@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429125846.K_8SmwJF91EnehX0b0L5DzJIBI6Q1jQBFpB4k3wDaxM@z>

On Mon, 29 Apr 2019 at 13:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, Apr 26, 2019 at 12:45:37PM +0100, Peter Maydell wrote:
> I was going to add a function to check kernel_filename and the presence
> of -device loader.  Then each machine type init function would call the
> function with flags indicating which modes are allowed:
>
>   /* Allow both -kernel and -device loader */
>   check_kernel_loaded(KERNEL_CMDLINE | KERNEL_LOADER);
>
>   /* Allow only -kernel */
>   check_kernel_loaded(KERNEL_CMDLINE);
>
>   /* Allow only -device loader */
>   check_kernel_loaded(KERNEL_LOADER);

Every machine should permit -device loader: the point
of it is that it is entirely generic and works the same
way on every machine.

thanks
-- PMM

