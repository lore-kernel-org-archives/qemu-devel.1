Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2585CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E957120836
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8ygNard"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E957120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9553-0001em-41
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j954I-0000sP-Kr
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j954H-0002Y0-HM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:46:30 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:40525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j954H-0002Xs-C8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:46:29 -0500
Received: by mail-qk1-x743.google.com with SMTP id m2so2861133qka.7
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 02:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e7ZXQWD2g/ZiIeyLYpV0pgiVNJxG9wcvVkwwd7627ak=;
 b=T8ygNardj8pFPqzlepQ4Ze6O4pDlnXhgTj2az/CN2LKy8CaRFuIGgolFaSuXhnRFFZ
 itEZbdt327X2c4leaO9xw9Y6bmma6P0LrzwXXhnVL/fqcLLp2+SqRBCjfuXw1yoEaPh8
 GAVe37JifNxlzkEYOEX84qK/qeFduwPJfAX2o3rPfAP6IYSNyGH9kSj+HbERCyIYv+DA
 eOh5Xnch/E259umuSy8ZTygQxWlQVNKmN1ljOg+HAaDxgaPAueSGywUfqwYK2k6MUrLc
 JAGhQd5M4Fo/2q7fH1/CgCqqOCCg2QzW3k51NgDY5PFDpJb4GlrsBxbnwMzWShoC870/
 WEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e7ZXQWD2g/ZiIeyLYpV0pgiVNJxG9wcvVkwwd7627ak=;
 b=SGLEVD3EGqASvMEHS02oxqy3kYkAu5kqQXOdlqR33rVeOGwFKEeDlBm3uajBhlDtUn
 X68C/p9V1zrWwGXKP+4WxUCBjP9ntr0roWht7Ys4xa2uiLlzqq/ppzlUwaTq5Uulwqhk
 8NhV8KoRO/vRd0/x6xcEIliXiZKiqMWLviTwpdfblc4FoQCuT+g3sWBVJXvkqKLbEqUI
 E14KgmZoKK/H2O6bbUHgMv5xNq+XwRoQ+ANMSuS2I+fpX2f6S1wS9WzXDk7dGlfrHlTo
 h1CQQfJdM8o9hqn9PE+YOZKfHUGlOl7a7qoTZIeBu4LU2uo9BF/s1OukmR+VR4Ke65wQ
 UrTQ==
X-Gm-Message-State: ANhLgQ3/j58x29WizSCbLKDOjTyseA4/ltG2qJq6pnSUIENjHk1DSTCZ
 xjOdmmxQTtEGuxucOa8fW5WVMjB3mQod1Uwge18=
X-Google-Smtp-Source: ADFU+vuNjwFb3ZZPX/YRdTaijOkxXCGo2JOiwpVA8ocWdfnylMxPBq7POXXlZ9KqjdmwgRm2URicHAMhBW9UAcv4Ogg=
X-Received: by 2002:a37:a28f:: with SMTP id l137mr3441308qke.196.1583232388672; 
 Tue, 03 Mar 2020 02:46:28 -0800 (PST)
MIME-Version: 1.0
References: <CAPV47zf2Bz1xNTcD_1M=hf7tyVnCYh8yLagN=r8ocgrz2GT2Hw@mail.gmail.com>
 <20200302173604.GB682016@stefanha-x1.localdomain>
 <CAPV47zdPz+Z5=bOFNGjTG8nEWgH4gb78_AE3SGU0TD_7TNmSLw@mail.gmail.com>
In-Reply-To: <CAPV47zdPz+Z5=bOFNGjTG8nEWgH4gb78_AE3SGU0TD_7TNmSLw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Mar 2020 10:46:17 +0000
Message-ID: <CAJSP0QXd9fhz45OdA190XizdiwYF84UzHhD7QQVdzh9293iH9A@mail.gmail.com>
Subject: Re: New Hardware model emulation
To: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 3, 2020 at 7:45 AM Priyamvad Acharya
<priyamvad.agnisys@gmail.com> wrote:

Please use Reply-All when replying to mailing list emails so that
qemu-devel@nongnu.org is included in the CC list.  That way the
discussion stays on the mailing list.

> Hi,
> I have written code to emulate a custom PCI device.
> Now I want to run custom device with Qemu, so that user application can perform read/write operation with custom PCI device.
> So what is the method to do it?

1. Add the source file somewhere below hw/.
2. Add a make rule to build the object file in Makefile.objs in the
same directory as the source file.
3. Compile QEMU and run with -device testpci.

> I am new to emulating a custom device model in Qemu, so request you to explain me in that way.

Reading the source code is necessary to understand how things work.
You can find many examples of devices in the hw/ directory.  Using
git-log(1) can be helpful because it shows how new devices were
introduced.

Stefan

