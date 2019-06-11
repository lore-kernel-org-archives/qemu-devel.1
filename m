Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E5EC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39442086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alkn+XGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39442086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hak0z-0006kL-VV
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hajJn-0006tP-Hu
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hajJj-0005l3-DK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:08:13 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hajJh-0005hL-El
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:08:10 -0400
Received: by mail-ot1-x343.google.com with SMTP id z23so12400324ote.13
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 09:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JR9ZUNk9cSB5ZOSnmOXD6oGGd/boRFK2MnJ/XPOY0Hc=;
 b=alkn+XGaLBAL3V0l2ldlZsrnjhZ+iscwqfKm4Vh9zdKl1RbPqMLM5WsUd1QxGnURQn
 lGVydvjOL/dmSbGtDd5XLxMuOUODCETCWDx0zMBcAF7Vz+RG8cKGBUyA1JKdfRd8cHkm
 Fuf3it+3bcdCVWrDxo9+xYIgvgvkqXftUiy0PUrgiDp+VmvmxUNwvd+tymDmb/il/fF+
 aQ+VDIualH5pMIi9pPg7ItZcJ5xiZyhr6ZkjSZ345C+kNQ/oTZUwNkSx3IdcVB76/kow
 jUCYuf8BglJuLJ4RmKJLrLq4XjslbVQysvV4vQi8G4l7jL8Qzpm4Yli5Tzdft6YBRgNe
 hMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JR9ZUNk9cSB5ZOSnmOXD6oGGd/boRFK2MnJ/XPOY0Hc=;
 b=h7P7r6ZhLBnQyLRb4gFFyi+NZYgukzKHVsvBwVMEPIVb0L1FT8ybBUdTaLcHy++C53
 iCDGTfuExr9NhZBi3N5tiFzuB+prCgCThiMHM5sG5dFruCmYpuBhA4HwNuf65XdK9YPv
 y/U4uBoIxCYkBrj/zU6tW0xBzdd5lY/+3/fKmzelfdUWwyO6NusbBGHq7lzXwn9N6nUR
 dVu+6dOt8DCgYk4EUCHlZNclGADlRYHTRIlU3jN3c7xcFI0u1gL2OU4Qa7IZzGMHDafj
 Kd5CiXWYNUoCr6wBQczjjOJctzfvZttUaUujyu4ava+WrzuyWL431jwH/xlYjUwDSqCi
 QPpQ==
X-Gm-Message-State: APjAAAUndBw4iZedP8ix81qNI6QZklFx6qgqNfpVDdsDHhJVMUdKh98o
 owBdSfmNzFbKCdUqJG7B6dCyq+y0Q0YpGFlnqGT8qg==
X-Google-Smtp-Source: APXvYqzqXncvZCbkyMz9ft8F0KiMwreIBcKkNltlUjRrobyo39Meaa/kmjNea6VwNoWR33gMWl/k/uWngm2qGqXls1M=
X-Received: by 2002:a9d:630a:: with SMTP id q10mr98913otk.91.1560269286219;
 Tue, 11 Jun 2019 09:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190607211544.7964-1-ehabkost@redhat.com>
 <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
 <CAFEAcA9ZeB1knLYYQLJG0d5McG2vo6w8P9+vOBWgtSVgPEG0jA@mail.gmail.com>
 <20190611160329.GH5927@habkost.net>
In-Reply-To: <20190611160329.GH5927@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jun 2019 17:07:55 +0100
Message-ID: <CAFEAcA-cv8vPT=7YraioJvW7-WnvGy9YoJXOc_E+UEWUehE+Bg@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 0/8] Python queue, 2019-06-07
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Jun 2019 at 17:03, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Tue, Jun 11, 2019 at 04:50:34PM +0100, Peter Maydell wrote:
> > On Mon, 10 Jun 2019 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > Hi. This fails to build on one of my buildtest machines:
> > >
> > > ERROR: Cannot use 'python3', Python 2 >= 2.7 or Python 3 >= 3.5 is required.
> > >        Use --python=/path/to/python to specify a supported Python.
> > >
> > > The machine has python 2.7.6 and 3.4.3. (It's an Ubuntu trusty
> > > box; it's one of the gcc compile farm machines so upgrades to its
> > > OS are not really under my control.)
> >
> > Rereading this, I realise that either the check or the error
> > message is wrong here. The machine has 2.7.6, which satisfies
> > "python 2 >= 2.7", so we should be OK to build. The bug
> > seems to be that we say "prefer python3 over plain python
> > on python2" early, but don't revisit that decision if the
> > python3 we found isn't actually good enough for us.
>
> Right.  The error message is technically correct, but misleading.
> python3 is too old, but python2 would work.
>
> We can make configure not use python3 by default if it's too old,
> and fall back to python2 in this case.

Sounds good. Since I have now managed to get my alternate
aarch64 box set up, how about I apply this pullreq and you
send a followup patch which does the fallback to python/python2 ?

thanks
-- PMM

