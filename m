Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165EFC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1F420868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgFo4rji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1F420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51178 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKBO-0006bW-Lu
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35626)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZIoN-0001hC-SZ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZIoM-0006sK-2S
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:37:55 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:35461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZIoL-0006pV-7k
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:37:53 -0400
Received: by mail-ot1-x335.google.com with SMTP id j19so2613695otq.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UDFtgeBuUJbyVO78BVK1jvam/9/OM+P3NZpnL3d8rok=;
 b=RgFo4rjiICyj/DZkMFNYiyogdhPRrsVoHyi+/hkDdHb4qyVqQnTeqt9ly7CDo1Cdl+
 y6hpuZC2BJVP56I8N74bs5hNp96cWLhPkpigyP7uzQVwOAGPaQWb7xcoqBHUWTD5AFNq
 ZDGIRPR2CsotK3bMnTZbIhSnBFMz2mhsMclJyeya8aJgshMw2LgR+qL+etB4uyqrPo1n
 eXkHwivSifLZS8XIwpK6+n/QgQw1L+PsxL549fnN0Bkw7LaVRroShNu6eFZT9wNum3S2
 agzRsmJ95UP2E3fu+lNDY73HJNG1p5By0p+THw6Sf7hJ7m3MGWtq8oBSXP2cmSmusa6/
 n6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UDFtgeBuUJbyVO78BVK1jvam/9/OM+P3NZpnL3d8rok=;
 b=bc++SxeioVslMTAzKFAJLo31mLHNNaUyc5osTAwsLHut6iwBjNa1p63Q8wiCpewZRf
 w16vCepTbMXBUxWNzd1nQaGkPQ39DBu7ZbgdT0QfSfpJUpIgeJOBtsQcG8UmATbj2Zs8
 BSeM/GEz0Neq4TLIrAugr3/McqqKXgVOuKkcdLfl5WX+bbAWQmoy1j2pw8Wo1DRiECPh
 aXx/AHOCzaX9UYMsfLA56JYTq4szV7TWPje7B7Fa48w1xAdzJkE3VHFJIIWkUKe9IUTK
 78clF55rgXtQU8Zx/+hdcP2eXXi/s6jCQ+JwRQs6XE5v7ScObiUZLh5J52vyF50Z0XW7
 MeHA==
X-Gm-Message-State: APjAAAXASM5+NiopPrkIk8kVBZVGaD3IKP6ZVY21efc5nswfbfWLigv0
 ezZQXKsiS25S73CLRr3TflOPCbY7ewG7I9NeIBqtBiUharc=
X-Google-Smtp-Source: APXvYqxYcisu+YkA9yjbUOxKPM2kWhOlzHB7nFaLDnmljJPdlLY+ufJgnIlSlIxdGlNKuWZxw80GLgRBxwX9jU0ZrVM=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr20507707otp.91.1559929071526; 
 Fri, 07 Jun 2019 10:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_-DptTwe7dkbZ171HJ+DtXCAOKt08pja=4-QbQKJSEvQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_-DptTwe7dkbZ171HJ+DtXCAOKt08pja=4-QbQKJSEvQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 18:37:40 +0100
Message-ID: <CAFEAcA9MOWkMGAyV_efH+FRBErJgM_9gwX+kutqSzH_0ou58Dg@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] Sketch of a transition of QEMU docs to Sphinx
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 19:56, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Currently we have a vague plan that we should migrate our
> documentation away from Texinfo to using Sphinx, plus some isolated
> bits of documentation already in .rst format. This email is an attempt
> to sketch out a transition plan for getting us from where we are today
> to where (I think) we want to be.

Since nobody seemed to disagree particularly with this sketch,
I have overhauled/rewritten the wiki page
https://wiki.qemu.org/Features/Documentation
to be more or less a copy of it.

(I also sent out a patchset today which does the very easy
step 2 "move some developer docs into the devel manual".)

thanks
-- PMM

