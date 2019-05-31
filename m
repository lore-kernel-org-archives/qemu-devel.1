Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F7C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F8C2084B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NW3DvrDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F8C2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46666 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkzy-0001gx-73
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:07:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWkxV-0000Rq-3D
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWkxS-0005HW-Th
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:04:49 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWkxQ-0005Ce-TL
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:04:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id g18so9849405otj.11
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=7fQjKjvMizxEUH+ZmLWmHokn2Oviwij2SRB/vhvQN/s=;
	b=NW3DvrDD9ptKFwR7osjK1zByZU1LbYTlrcX4ARTtvm/qg9tDXKqGQHLJloFyczyx/+
	538PPalK2XcoTDx929BA6jJiOHrMT4xWrejpT2VTlmkSJQnX4vXVbcQ6DgixglLRAvDh
	YF+O3yz6OVUPMgYq5poP33yHeFkeTbFSt6CVNT3rk7dCYRuxwpJjW7Igw9C3yFTivcSL
	dBWeBjcV4y1nNJPfCFHPUbR/sCmLvtLpPlwwTwmubey0NzfLSUUuGykbPxz9SV/KwyPx
	AvHjbRx8jUcZKmWisWiU4+IiAsuTN+FDOQgrtNP9DgGulfrsxJgNCju7GnxZJdvH7mNV
	80uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=7fQjKjvMizxEUH+ZmLWmHokn2Oviwij2SRB/vhvQN/s=;
	b=tRjFadwrVQEm7JTANcYeeiix2eNYtrdMbYzosPjKxjOGLtSCfF+bXe/j6bpo1nxdUS
	GTOPZnogtZU2hSBIlvJtGrzTU2FdhzPfaVl/Kj7bZXXFqgNOFNa4XJXaaRRoc4dleMWq
	Q3MipetNs01mgUS5OLvRoEqvgc1WyrFmTwQZtd4Nf0mrf9Ofq3nDguYFJp5iZ5jBwmJw
	zQNJLXZRLRRDqxO+5sjO6fh7/g4e5UMmxgrdt44yARzLxHGDr0vBKu6vvEJXwrGphpzg
	FjgUe/Y+Gz3kS1FyO97qVqayOgrq4aRFq9ANzxWkq77p3KgyzgDk/Gp2RtvzeJqrczCC
	Dsww==
X-Gm-Message-State: APjAAAUSlD3Y5cSGWNdcAAO/9ncxxkw74RQE5mV9YqMhqgK6Hs/Nk41A
	nIWnVFTXWrze0vkIef1ynvYdCUkAi3a262kJG3uC9A==
X-Google-Smtp-Source: APXvYqz+eieM/Aiez3X/SAhpyNPCiRqcRRsbo+/FHP9dUHyU2LDOMfQAwx8zaPzm8vlE3qGmka1oDsJIpprBlz3AoJo=
X-Received: by 2002:a9d:193:: with SMTP id e19mr2663060ote.135.1559322281450; 
	Fri, 31 May 2019 10:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190531154735.20809-1-philmd@redhat.com>
	<CAFEAcA9TJGq-8fMv2amQEEGz9QKCNWYwJxCXrjqSh=Yc87yTww@mail.gmail.com>
	<947e851b-4b95-3126-2eaf-d5d16f8b831b@redhat.com>
	<431872249.25606899.1559321648368.JavaMail.zimbra@redhat.com>
In-Reply-To: <431872249.25606899.1559321648368.JavaMail.zimbra@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2019 18:04:30 +0100
Message-ID: <CAFEAcA_KKH62rK2pbR8dWXOCJWe1X8wif5whc+y0_e-hTpmoRQ@mail.gmail.com>
To: Miroslav Rezanina <mrezanin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] target: Build with
 CONFIG_SEMIHOSTING disabled
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Rob Bradford <robert.bradford@intel.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 May 2019 at 17:54, Miroslav Rezanina <mrezanin@redhat.com> wrote:
> What about CONFIG_ARM_VIRT - can we use it to introduce dependency on
> CONFIG_SEMIHOSTING or is there valid scenario of qemu build with CONFIG_ARM_VIRT
> enabled and CONFIG_SEMIHOSTING disabled?

Semihosting is a feature that works on all Arm CPUs
regardless of which machine model you're using (or whether
you're using softmmu or linux-user), so I think
the machine's Kconfig fragment is the wrong place to try
to pull it in.

thanks
-- PMM

