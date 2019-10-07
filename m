Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F2BC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02D3205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1OFw184"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02D3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHSKT-0004HK-3g
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHSIn-0002ZF-JX
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHSIl-0008Mj-Hw
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:39:49 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHSIh-0008L2-Vk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:39:45 -0400
Received: by mail-oi1-x244.google.com with SMTP id x3so11501087oig.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 05:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YDLy2+RFcFLz/VZiKL7vYfb1b3sSo2lHhiUd1uYCkA8=;
 b=D1OFw184AbdczwBwQaC0gGJ8jkhwzU/A83+rDooq1B1TfCrkIkJPCH7itbzd8LVWue
 o/H/XSpJbwH4iXiJPvC41RTVNWDRWaok0C9oKAyy/LqL44pL4vtHKwkGyVO5Bed7/Zzk
 MKMapDzRLM0bbWJtatTG24dMykOf11CrAQ759NV5PY9/6tYFg+CG0ReiV2CRRnfNfRPy
 r0SeI+j3Cj6IeZg7NlYaeYqXB+POHdKLvBe172HVbWEk3alZ8Mqp9MvN2epGAo0raS22
 Alssyotk6tYyV168nswWmKE6PFLml9TXYh07ymSmQQQ4aggRRFiZx6CIQuk/6sCrQlQ1
 nRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YDLy2+RFcFLz/VZiKL7vYfb1b3sSo2lHhiUd1uYCkA8=;
 b=BAQy8isDvLl+yCLymHAsFHME/59KP0+INbdi6sQKLEpCuPh4LzJvWhzBel/07vvZxh
 VvWyFWQjyQs+DDXG/c7EXXMLqYF6PP4Tz+eXFkNhct1uIugDCm2nOnzqMg7uD7ceU50I
 r1k4i9nj71ufCDOKIbMCnCDVOGPnCCAwojFLppAFqDTexK2YTl0Pv1clwmv7MndW65FJ
 NG7IL+R/t8xP4YsiAOCLf01mVssZMNPN59WAmqwAd33yusn24rqjA52mexvr5L63fxz0
 DYwqyvQaQlTiCXo82ijzQZ0R/cnLdW0Kht9+4r7aoD4Ca2uEpaHYrGDU6nlp4F9Fspt9
 FyJw==
X-Gm-Message-State: APjAAAV/yjW0FyGc12LEhnpzXdqmS1A9ZtlM1E+PLjzTASHNYeJ1u2QU
 u7rhAaPMMkuKkphB81sMgZI0qMHt1j8gjgxhT6zQ6g==
X-Google-Smtp-Source: APXvYqyZk0TvroKjWrkxzYENAeCtQ4hB0Ph8Q1WCL6wQVjGJPKEydP3K9nQbwN0HyINq9/okJYJIZ32kgmvfe95TZGc=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr2234867oib.48.1570451981338; 
 Mon, 07 Oct 2019 05:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <874l13qmvb.fsf@dusky.pond.sub.org>
 <20191004130242.27267-1-g.lettieri@iet.unipi.it>
 <CAFEAcA8ut__ruS4yEMT7-qCKu+BFihFwhaNoq7L1cdoqxpXx6g@mail.gmail.com>
 <87pnj8ltih.fsf@dusky.pond.sub.org>
 <CAFEAcA9KLDruPS6o85H5XJnQjoSXV2+-d=dnNGPvc80jiBthiQ@mail.gmail.com>
 <87zhicg2ce.fsf@dusky.pond.sub.org>
In-Reply-To: <87zhicg2ce.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2019 13:39:30 +0100
Message-ID: <CAFEAcA9ydS1LR+dW+mT9gCPrevov_U9jKKrEKu2De_OTWeCETg@mail.gmail.com>
Subject: Re: [PATCH] netmap: support git-submodule build otption
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 7 Oct 2019 at 13:36, Markus Armbruster <armbru@redhat.com> wrote:
> If CI of QEMU code isn't useful, then I suspect the QEMU code isn't
> useful, period.  Giuseppe assures us the netmap QEMU code *is* useful.
> It followe we better make sure our CI covers it.

It would be an interesting idea to have a requirement that
any new library dependency can't be introduced into QEMU
unless one of the systems we do builds on can be set up
so the new code is compiled...

thanks
-- PMM

