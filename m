Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0955DC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBBF9269CC
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RephA6JP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBF9269CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkIs-0002fb-2V
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:22:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWkI4-0002Fu-0m
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWkI2-0005Vj-5d
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:21:59 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWkI0-0005TS-8X
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:21:58 -0400
Received: by mail-ot1-x341.google.com with SMTP id u11so9738181otq.7
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=0emDJioIFk0tduFleQFkf5DeJDgDNS63MamuovSIrH0=;
	b=RephA6JPpJ4HeyaJ3T8sxSyXKYCFiV0R7HnMng0oFWsI/8NswwZmMOXxVaLJp+yKby
	xZeY6VreqoR2/0DR8Y7pFvOH+wMCggiMaUKJuNEbv9sT04OIDvqr/iklZaJ68NCFoCOT
	zwTIZaDNgCy0QJU0dNvfy8llqpY6RhCGyy8iFTnu4CKOfx9jdaQm0xJzSDaYaD+tBWad
	HajhH2PEupEqNKm1NAUX5YiEf10QgnYc3Eknb6moXHmMHKCrlFVcspXh6u6sm4VsqKhP
	i8o8XOW8U9w6fynmxkMh8vdfZ5eEpC0MWXsmIQX93TghGe8oW/cYZ8wnG9oFun+0SgEV
	Pj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=0emDJioIFk0tduFleQFkf5DeJDgDNS63MamuovSIrH0=;
	b=rnwzoyJjf92vXIMxRUqDdPAn6woy0IQhiU/PYF1Sd2eWDOMJQQC9MvVTZhqzldxSEl
	PiQgxBttr1JZlfVmZddy3hfjfxjHrJdMbibe+wNvJB4M3bWn4osxXS3IRPTWryV1ld/M
	f+6AHf5XnwkLbVOAbZtJc/eP+8/6drFzt7JMIAiZSEiZm0ToktXqwLSrfryne72l1UBN
	D4kRNx1SxkCxhOcTJHxfYDZjr/Kna/VtnXSLX30wM0gZcHwYvUQpxrIn7ESMvGZY8yKf
	QifRGTLgdHUKLHOk4BhrBDuGG5K5f0WLrHgy2N8AUH/1Y0H2/QwLPwxpMp/vWETKsjA4
	VuMA==
X-Gm-Message-State: APjAAAXTJ1VDECZbd0yaUE9ynyZfdTFlE6HvkCXtOn6TncDgT8YrWaiU
	x7d8TLapXK2gJ392ddHKL/7HIIHZcKe+/VeisjbDgQ==
X-Google-Smtp-Source: APXvYqyYOX4iJd5wwfLagRDExDKN3HDfsh6RuCAl349mfvt2yWNU+5LF4ifE+Y2enzyYnWCH4Axaw8IEJ0icg6Dj0/g=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr2540782otp.91.1559319714329; 
	Fri, 31 May 2019 09:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190531154735.20809-1-philmd@redhat.com>
In-Reply-To: <20190531154735.20809-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2019 17:21:43 +0100
Message-ID: <CAFEAcA9TJGq-8fMv2amQEEGz9QKCNWYwJxCXrjqSh=Yc87yTww@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Miroslav Rezanina <mrezanin@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 May 2019 at 16:47, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Amusingly Miroslav and myself hit this issue at the same time.
>
> Currently there is no way to pass a CONFIG_X to sources in target/,
> except via a Makefile rule (and filling with stubs).
>
> Paolo says this is on purpose, CONFIG_X selectors are meant for
> devices and we try to avoid having config-devices.mak in
> config-target.h.

...but some things in target/ are devices (like the Arm CPUs,
which inherit from TYPE_DEVICE).

Is there a way we can have a Kconfig fragment that expresses
"if you asked for an Arm CPU then this should 'select SEMIHOSTING'" ?

thanks
-- PMM

