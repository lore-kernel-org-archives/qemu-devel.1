Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFCEC04AA8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FFB2087B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN1QbCGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FFB2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLa01-0007QC-BD
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 17:09:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLZyd-0006W6-Ex
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLZyb-0004Wa-J4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:07:47 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:36959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hLZyb-0004Vs-6u
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:07:45 -0400
Received: by mail-yw1-xc44.google.com with SMTP id a62so6997313ywa.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 14:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Nn8XWHXQJIluwQB/meGRemUNDEIdQ3iJZuNEL5RJjvA=;
	b=EN1QbCGnNh02ABO4I9/5nwcZMyNWggcu25f+U7169xR/D6nvaE9/wgaVMIkXrqsIT8
	KOppNy2iU93DPmAGmT/doJxe25QJwZkKVVtaGKYUBXJ+wvDeCd129s66vi2vmqVHdvZo
	4KGretPeCj69NyQGsOpzexNLQRASeTvh4zxMsKsUy4/f7eChmZLg1q3PecLczLNdzlSc
	4RHOYAZmcojGmxx007Zd98otDgIwv7wjCodga2TBHXavZHV0xoYo2HbPX4wCWu/RVLjQ
	2uT5YTh7fnBHF0sV7vKx+EzDhOemDLbkz9BOmmUcfonI1bhdUzPM8uthHZYanmYLXNyw
	K8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Nn8XWHXQJIluwQB/meGRemUNDEIdQ3iJZuNEL5RJjvA=;
	b=FHsX7f32AbF/lc3Vd+sr4RJcNUK3N257NUfdbcGevgXRvcKdFB3MJJkYYQ+iICCe+z
	pinGrOn1i38IAJf1i6KlYqOwrf+S/q2QMR3EpgkrE0lS23oiP9wFaJbzA0TyGcqPb6pM
	HmsS+ufRioOIkEVGarEjq15AEji4MKXc6GuAIDTwVyRe8qjqpEFkst0cOR0QxZtsTRye
	QZu65igY5/SlPuKWwLMQRuzUw+E6FPIc5LVqAEb7bFxYMGcDcB0AthlE7h7gsY8nHQrG
	aC2B1g2d7JXA4HMCjThPgq36speO63fUnONOY5OnRst93kW2iysJ8E1bVaB7UwQeADi2
	pwyw==
X-Gm-Message-State: APjAAAWs97xleGV5/RDqGZ71A23d/9dc6Z1alf0Wi1wargV4ijOkd3sZ
	1iDHI5ZUQ2ZH2TDNm269srHsuLXHjJKEpzUTCr4=
X-Google-Smtp-Source: APXvYqwqR4dwOlB5if1EaZcLolIAUeIT0fhRP0r2StQWeH1qGzLijchDeXXq7lIdbq/IzBahOMjxWWkHyWeQJLvyBQc=
X-Received: by 2002:a25:4946:: with SMTP id w67mr33629253yba.445.1556658463898;
	Tue, 30 Apr 2019 14:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-24-richard.henderson@linaro.org>
	<CAFEAcA_FZHKXJHg4819JOZkwwhE44Vx874GKrnxRrOau1HhzRw@mail.gmail.com>
	<CAMo8BfJVdDvYWEdN_08ed5OKBGXc+U8kSbmWaSWY9WCuvDj2pw@mail.gmail.com>
	<bd57c22c-1bdc-80b4-0415-565117f6ae3e@linaro.org>
	<CAMo8BfJsC9aPYUhi5Rg6SAXT4dhaZaU=dqy=um+aBJtnPMSwdA@mail.gmail.com>
In-Reply-To: <CAMo8BfJsC9aPYUhi5Rg6SAXT4dhaZaU=dqy=um+aBJtnPMSwdA@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 30 Apr 2019 14:07:31 -0700
Message-ID:
 <CAMo8BfKjGrHsTn+riEnS8rxQDPgAQ9STwJrB4_TrYnqs2uHtmQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: Re: [Qemu-devel] [PATCH 23/26] target/xtensa: Convert to
 CPUClass::tlb_fill
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430210731.UWXA-pvsm-lqGxoAmykELUPklbXu_vXMbByNLoSS6ks@z>

On Tue, Apr 30, 2019 at 11:14 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Tue, Apr 30, 2019 at 10:44 AM Richard Henderson
> > And Peter's right that I should have kept EXC_USER.

It appears to work as is: the EXC_USER is set up by the
exception_cause helper because there's always PS_U in
the PS, PS_EXCM is cleared in the cpu_loop and the
current PC is preserved by the xtensa_cpu_tlb_fill.
I'll play with it some more...

-- 
Thanks.
-- Max

