Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B9DC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46C126CDC
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+Oq20K+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46C126CDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46681 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWl1B-0002jq-3u
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:08:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWkzW-0001gk-HO
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWkzV-0007A6-Ek
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:06:54 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWkzV-00078y-87
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:06:53 -0400
Received: by mail-oi1-x243.google.com with SMTP id y6so4639829oix.2
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=bGEgwcdg7BQDVwN5gbQCpbUXmzK9K+tKsUN6ULwLP6o=;
	b=B+Oq20K+qDarF0B/R080DljMCKoTpHjwGkkIGgNtEwo56QV9dFqJrlwSOSWdS7ZSfj
	r5NgIu/zy2qbJL5rTllite+Ns/f47+0XUxJ2i/EEhXSiTgorVeC7f9lpiXZMSClxtnUd
	adi8Ejl0ZrRDml7XaqzuqNFYLSDvKwBi0ny51QTi/PiD7ZDA3uQzL3hHsCUN3Kxrweed
	mF2v2ML3qfhGOD1kcmVBkkVh+LY8wMTVU4FgtcsqlGLzlFggGcYTmyFXe5qH0Nx4NF5y
	32MXCNiNfVWkUVRiUjF6Y6FiERrqAZtP8oIVIMqPnWsVHClGlIru/gZdTSsUUI1DYXLt
	Hn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=bGEgwcdg7BQDVwN5gbQCpbUXmzK9K+tKsUN6ULwLP6o=;
	b=fvJOmJYS6u8U4kcLmvZFg6dPVCaG3+QFCN8bEg2rWwd55LL3uoDatH9CexRPUmdE8l
	5CFXvZQqSgmXXFPeqNznGn2yXtXpHXopbhqop9vQ3mWF4kgx7icCKH7ZWjcekAddnRjf
	e5mbgj+2H308hr/H0IT/pNyPDD4x+MaKhHlCop6WPxgspFuknMICheysaV7WphaJ/Jgf
	KZ+oJmCQIaj7s3jYZl35HAbIS8H0uM791DtY8DqfM0IDiuyaIVH3G/x4HRXRGB4zXyx8
	DGk7N7Nfw7jIERJ3iZowghrWarEoqyaZN3glt1k5CQaIkcJj4VBg0gJp2bUZy1T7CdiE
	Hczg==
X-Gm-Message-State: APjAAAXvom7UthCU9jOLT9Tolaugo+SknMxd4W1HxyvbUfkkunKGd/UA
	ZtJyDzhIK0+p4P8XqsTP6bz1JShYpbXBCEB7VN8yXA==
X-Google-Smtp-Source: APXvYqy53KqPb3kHCJ8QIsSrO4QxITByDLUC+dJI1UCDwhRh0iGKs8RpEhibZG893xpMS2wEZLijU37i+k4yYu+vkek=
X-Received: by 2002:aca:6cc1:: with SMTP id h184mr2037150oic.170.1559322412328;
	Fri, 31 May 2019 10:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190531154735.20809-1-philmd@redhat.com>
	<CAFEAcA9TJGq-8fMv2amQEEGz9QKCNWYwJxCXrjqSh=Yc87yTww@mail.gmail.com>
	<947e851b-4b95-3126-2eaf-d5d16f8b831b@redhat.com>
In-Reply-To: <947e851b-4b95-3126-2eaf-d5d16f8b831b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2019 18:06:41 +0100
Message-ID: <CAFEAcA9m842==pUU2ux9PQzetJ2kDFp4LS+VT9TyTUqPEH-+Xg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Fri, 31 May 2019 at 17:40, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> I'll see what happened to Samuel series "Support disabling TCG on ARM"
> and see if it can be salvaged:
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02451.html

That would certainly be useful.

> I suppose in this thread:
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05641.html
> you refer to this series (not yet merged):
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03137.html
>
> I'll try to figure what "KVM injection of interrupts" is.

This is about some (rare) cases where userspace QEMU in a KVM
setup determines that it needs to deliver an exception to the
guest, and does that by adjusting the CPU state appropriately
(changing PC, PSTATE, ESR_EL1, etc etc) before telling KVM
to KVM_RUN again. Currently we only need that for some places
where we're doing debugging of the guest, but there is that
pending patchset that would also like to do it in case of
a detected hardware memory error. (Most of the time when the
guest takes an exception it's because the host kernel/KVM
have determined that it's necessary and done the relevant
messing with the guest CPU state.)

thanks
-- PMM

