Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76BCC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A525A20737
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDYW4O7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A525A20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtmo-0003rH-Mk
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHtlK-0003Gq-R4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHtlJ-0000jP-5z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:31:22 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:33327)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHtlI-0000he-NQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:31:21 -0400
Received: by mail-lj1-x242.google.com with SMTP id f20so11284013ljm.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YM+mZVnIoOOnkVmaqk5LohqCwxsDoS3kTLEUUXJOTcU=;
 b=dDYW4O7qK0JdtZCQ8Oin2UrY7zWv1M5VZwJKIjOfZYL4RzhwGRuNeo5RChUxWz3YxI
 Yh4U8OZPJsZfGF54hdn9N/qMTE6t4aHnHMmGaGAEp6r/0au6raQGqZ5KNrZh7jSo9j3C
 1DkvTHI5bKmNSke8PJpF5CDLyc+8BpPKtMjgVhI0ArZXdJcH1EK7RTBAuGnG8Yc9MXl4
 Fyl2mitalK00zNBmXs430ibN77RwnyNJ+MvBpf6zmYcHa26LCNEJL3lSxRXj+ka2sB+e
 eeBR3REIMlxynBnM/x3un8jswxJawPN+c6NkIpzPCSgOeUeyemgsmkWtMULoN92aolHS
 TkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YM+mZVnIoOOnkVmaqk5LohqCwxsDoS3kTLEUUXJOTcU=;
 b=s4F8L+ziRqYNujeWBmMedwEZVb4GlLPkKNZDbJG88tUygeZ1WYJHnL9AL//RMJq+aU
 pAqL9ui1qsrPMGLJyLnbUnA7ztZHEilJFBYDUPS4wVz6YEzb5yp9EUbBx16+DQ6MKay7
 Y2o/pRbN0bsowue3NN/DMixq8lLPzvyegyyusX30qLhMvKajH7Qb24snDCdcb/MW/8kw
 R7LhRmCx+j9SQnmsh70lRnMVE8aSUsfe8T7pHKH8ssr2oZfSk92ljssVLUnfPWdFZ083
 ZgqExrfHaoJr6vJZLM/rp7rgt9fgvGlKSqFdrl9/xl/UWpE0Fa/uRyOsVUKPyz4xQrzg
 EP1g==
X-Gm-Message-State: AGi0PuaQflmeLE3IMBWIe6HyCk+IgmAuAihhdfUuoTxb7/G7itzSzkSs
 ziujuR90LI4AYi+3bhh/f8jeBnlXlbgMFGqc5G0MUw==
X-Google-Smtp-Source: APiQypKc46TSkZlqYVsQjhUSSqb0w3MF2ID8aGj6om3c+EVuQ/R+W09J0osLorNvkR/w9vQ8KYJvKKaTuHBHFljaCHw=
X-Received: by 2002:a05:651c:287:: with SMTP id
 b7mr162153ljo.129.1585333878362; 
 Fri, 27 Mar 2020 11:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200327051457.GA2815@t420>
In-Reply-To: <20200327051457.GA2815@t420>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 27 Mar 2020 14:30:49 -0400
Message-ID: <CAEyhzFsWc+qpWLFU3XT0Vb_jeAHbE5Bxoejq21_q-1_vZBp8iw@mail.gmail.com>
Subject: Re: [PATCH v8 00/74] per-CPU locks
To: "Emilio G. Cota" <cota@braap.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Puhov <peter.puhov@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 at 01:14, Emilio G. Cota <cota@braap.org> wrote:
>
> (Apologies if I missed some Cc's; I was not Cc'ed in patch 0
>  so I'm blindly crafting a reply.)

Sorry I forgot to including you in patch 0, my bad. Will be sure to
include you in the future.

> On Thu, Mar 26, 2020 at 15:30:43 -0400, Robert Foley wrote:
> > This is a continuation of the series created by Emilio Cota.
> > We are picking up this patch set with the goal to apply
> > any fixes or updates needed to get this accepted.
>
> Thanks for picking this up!
>
> > Listed below are the changes for this version of the patch,
> > aside from the merge related changes.
> >
> > Changes for V8:
> > - Fixed issue where in rr mode we could destroy the BQL twice.
>
> I remember doing little to no testing in record-replay mode, so
> there should be more bugs hiding in there :-)

Thanks for the tip!  We will give record-replay some extra testing to
hopefully shake some things out. :)
>
> > - Found/fixed bug that had been hit in testing previously during
> > the last consideration of this patch.
> >  We reproduced the issue hit in the qtest: bios-tables-test.
> >  The issue was introduced by dropping the BQL, and found us
> >  (very rarely) missing the condition variable wakeup in
> >  qemu_tcg_rr_cpu_thread_fn().
>
> Aah, this one:
>   https://patchwork.kernel.org/patch/10838149/#22516931
> How did you identify the problem? Was it code inspection or using a tool
> like rr? I remember this being hard to reproduce reliably.

Same here, it was hard to reproduce. I did try to use rr on some
shorter runs but no luck there.

We ran it overnight on one of our ARM servers and it eventually
reproduced after about 12 hours in a loop across all the
bios-table-test(s) (no rr).  Never got it to reproduce on an x86
server.  It was fairly consistent too on the same ARM host, it always
reproduced within 8-12 hrs or so, and we were able to reproduce it
several times.

Thanks & Regards,
-Rob

