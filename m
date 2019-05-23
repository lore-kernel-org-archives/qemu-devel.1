Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3440DC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F320920862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8plRAFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F320920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36210 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnjT-0004TD-5r
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:26:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnYV-0003cF-7n
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnYT-0000rM-JR
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:14:47 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTnYT-0000q5-BO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:14:45 -0400
Received: by mail-oi1-x243.google.com with SMTP id q186so4336963oia.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=tJceJ2kwm4Gqq5cLya6XILrl4b3l3MMW0QBOUx4D7wI=;
	b=O8plRAFuvilI6zMjoHJTXkqLk5E2pqcMu03UyZoupVSDqz50LCBh11cKT3778JzHRo
	3HsP99TalWmY08B/FAw31i7oUi26/fDoqu7iJ+FTIPhbOjoPTL5sSEMV2P7zN96SDeW4
	Grr7T0i9QOntY3aJ2MZfO/rqKsnrZ9eEv0ysdc3yRmtoibDnC5ksFcH8p0+Q8NDBWN3f
	TUSPcerVGB0RAdBZDc1Osur4LG6GHSQ0Ffm1PA5yW2Ci7URRd7HySIqhiGm0yzySx8EG
	jGjGFNciyjjxjw7/pwwyznqmn/4X/1tJ9RmdSB7yI1U5MXoqK6Unr5KCKKnEBKq7FZHU
	ULRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=tJceJ2kwm4Gqq5cLya6XILrl4b3l3MMW0QBOUx4D7wI=;
	b=K2zyUmTzFFYOTQTat5u+6K2QSB17Zq/SjY8pO3MpR7/G0GrZ0ygnPdqelUxglaL6Cu
	XItBg7aNTMhGZSmDF1eV0hB7LrgFMT3qyc/Pto0MGMRaX68fdMVMbCbmsj+lCdKSouBI
	mZ+y2nR67OIZXHcAyP7Qt5/yd6kPAa9rIst1UcZScjtOB3xdyNSGpiwY48I8A0MeKvMB
	horA5OpTmdlXkHd/RwNy7CwwkU0MbPHR67ynKxpLXQ5CXhF5QkJkgrO24LMF/5NEwd0g
	w4X9691GbNazCGPjjmAOkHRh5SGGxxryNJwVNTBQRT1EjiMeN5SUf0qdEJcn+yUsrhXs
	dTPA==
X-Gm-Message-State: APjAAAXv59x6yBwrWClwj531Fbw/NVxuYi/sYNXSO1aqGmNjiZj+tvmG
	OJ5QTRt0674/LT32rli4Co+7pBuc2LqbCedB/rPCJg==
X-Google-Smtp-Source: APXvYqyjDYhIyaO7KiygW9L6se8HlUGbso9Lv2Z/FEtGofNzXQzG97nmS8UdOTnbdzdseu7jI5izsK4cujforrPAjks=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr2724472oif.98.1558617283652; 
	Thu, 23 May 2019 06:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190522184226.17871-1-richard.henderson@linaro.org>
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 14:14:31 +0100
Message-ID: <CAFEAcA-wBShyR9aP4OAdvN7zwXE8teMgKOwfj5ROkjLdxjP9TQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 00/25] Add qemu_getrandom and ARMv8.5-RNG etc
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
> This is v8, rebased to avoid a conflict with 8d5d515a0fb
> ("build: chardev is only needed for softmmu targets"),
> which affected patch 2.
>
> Daniel and Laurent gave me acks for issuing a pull request
> touching their subsystems.  The reasonable thing seemed to
> be to put those into the log for the signed tag itself.
>
>
> r~
>
>
> The following changes since commit a4f667b6714916683408b983cfe0a615a72577=
5f:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' int=
o staging (2019-05-21 16:30:13 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-rng-20190522
>
> for you to fetch changes up to 369fd5ca66810b2ddb16e23a497eabe59385eceb:
>
>   target/i386: Implement CPUID_EXT_RDRAND (2019-05-22 12:38:54 -0400)
>
> ----------------------------------------------------------------
> Introduce qemu_guest_getrandom.
> Use qemu_guest_getrandom in aspeed, nrf51, bcm2835, exynos4210 rng device=
s.
> Use qemu_guest_getrandom in target/ppc darn instruction.
> Support ARMv8.5-RNG extension.
> Support x86 RDRAND extension.
>
> Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Acked-by: Laurent Vivier <laurent@vivier.eu>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

