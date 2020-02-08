Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6A4C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA5E20726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2MyCco0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA5E20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Pay-0004Ea-4U
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 07:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j0Pa0-0003UB-Lh
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j0PZz-0002Vi-CX
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:51:24 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j0PZz-0002VP-7q
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:51:23 -0500
Received: by mail-oi1-x243.google.com with SMTP id b18so4843437oie.2
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zXrA6wX+JL4TNxSVLkBP8gCx3FSprhY4VxthsxdFvbM=;
 b=R2MyCco0Vvdj3ByiQt/KVwl7bO5+AHkBaO77QNeHSPQkT81F/rB/YAFZfQIMsb29wo
 rcOv5cGx58nVqxvL+BbrY2dBGJdacpPX+s96NA9L0rHHnmptSh0Vcb/JnPl62fxYe2Kn
 T8bfevMF/Q0wJ1imM+GGJNW4Uz6DwB92UC6GRG2Xk3Dg/LQVH117uDc0FCmDVzUSB2xI
 pj3LaZMG+/esdkMPV+F4GZ8JpdJ0z8y7FC7dNuSY+G+GsrZUAs8IC8FlVokPDCu+3Fsb
 dfSbndiPKT3x/z+CG/NRb8lQFUWRggxgnTpc6g3lV4K2aZDE+DTZ38Xm2j2sspIBbYuk
 EzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zXrA6wX+JL4TNxSVLkBP8gCx3FSprhY4VxthsxdFvbM=;
 b=TqkUZ+lpqfNUkOREZ+a39z5HfyUcavDK3zbADmQDL4VzLFcMs6rO0VKAaUjUt/7W7/
 9nOMlhPnRsbtgAXnMXx2urDkWNEUTKYsHtrf0f0DtH1wF/VxRtl/MuspJ7At1QI296ti
 VjTkbMNme1CcJQ8UHaEaiCLuEnqhB3j4SKX6ta3C20VVyMVu1elpV+4EZgt07BeZTDwK
 4esoJ0m2FVVGMj9AdFQ3INFzfQXeztYpr4HtdGft7kVnS2HqZ8r6G63vG2OXeBnKSoPz
 mTO1jplnUO0rxQ4JVBvAsF04tUqmkdXatUidbegZ6/MVZLTD671bbDVyDFq9R2glOLEC
 VbwQ==
X-Gm-Message-State: APjAAAXTJIuLdWyaNLdU7U0+/v9CxYo63OkAx0uEPMcd0m2vJtSqYOEk
 MFoXgjJzamXo6cDvWo86gl5gUfbaRf3BsEoGo0GfyQ==
X-Google-Smtp-Source: APXvYqy49HKEgN/7ViT4wBnHFhtclnKDQrqNF+Vxp8SGScC6BH6+ZEi41qkbW8xS6GBt1BXQc96Km5Md4ECO2EUbtUc=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr5430736oiy.170.1581166281781; 
 Sat, 08 Feb 2020 04:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <5d0def0e-0943-3345-784d-80f8ccc318b9@redhat.com>
 <CAFEAcA8HPvzaxA1pguscX5FsuWvpJhkDAuFSApofabEWVzzjQQ@mail.gmail.com>
 <20200207192734.GA13258@localhost.localdomain>
In-Reply-To: <20200207192734.GA13258@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Feb 2020 12:51:10 +0000
Message-ID: <CAFEAcA8by97FNVG+kXMuFO+jQQJ64_vt2Q=6pYxpOno6ti7pdw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 19:27, Cleber Rosa <crosa@redhat.com> wrote:
>
> On Fri, Feb 07, 2020 at 04:26:53PM +0000, Peter Maydell wrote:
> > If we have a CI setup where KVM reliably works then we should
> > ideally test a --disable-tcg setup somehow. Right now my pullreq
> > tests don't test that because I run them on my work desktop box
> > and (as the config says) sometimes I'm running VirtualBox which
> > causes KVM to fail -- but that should be irrelevant to our CI
> > runners...

> You got me confused here Peter.  Do you intend to reuse the same
> machines you're using now (say your work desktop box) or is there an
> expectation for different machines to be introduced and used for these
> jobs?

No, I specifically don't want the CI jobs to be running on my
work desktop, because that use of private-to-me machines is
one of the things that's blocking us from passing the pullreq
handling to a wider group of people.

The thing I was trying to say was that the reason why current
pullreq testing doesn't include a --disable-tcg is a pure
accident of the setup it's running in, not a deliberate decision
that we should not be testing that config. It would be better if we
did test it, and if the new CI setup allows us to test it then we
should.

thanks
-- PMM

