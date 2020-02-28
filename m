Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE36C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B889D2468E
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BckALGRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B889D2468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7kvZ-0007JP-N5
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 14:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7kux-0006cP-93
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7kuw-0001MM-8O
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:03:23 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7kuw-0001M1-2x
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:03:22 -0500
Received: by mail-oi1-x244.google.com with SMTP id j80so1865087oih.7
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 11:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qhZ31X135cuYdATYDFYvdleK2ZEMRZ9mZZiVRHSMJFY=;
 b=BckALGRCO2gA+PtEZ37n/fmzm0REileBlk69/M6WCOiIfsFEvh7lrp2qlzgn3tP78o
 8LFCzK+eZ9U++NRfHqQSyZwa3HTvJduNbydzvdQDluDu9+0J8uWWdiIM84JO1OFRislV
 WrMuax4T6TgL32Oq8T9YVFMwQZvCgbIgIw+q8+zVSz2M0HXS+hb2CwCn24mGWYGuTSoe
 Y6lAom67AeybF5sEckezdmmlhbOmR+c2KuDpEkdx847o+9aYqF55P9AleDLmWcZVMTaU
 esVS1H5rOBVxInAUqq5BF3Ye+nUdy3YfV9gbwrrermlsWZRENSbpqtaBI2A+KiVjNGo1
 C0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qhZ31X135cuYdATYDFYvdleK2ZEMRZ9mZZiVRHSMJFY=;
 b=UK2rZunWMjVvdSkQkAbDng7vyuwZM+J9vxbbU9vTmtK+kGmtk75IU+DedeMcdwDyxc
 JwibggIUSzJpRk0PFgeFmcvNgfOc+bRMKUGRn98VoIig9iF4qzke8l+uCKEKEwwDuEb3
 /ahxgrKCfUwlT6iMTdYbjN+saK1v4EROK/oJB/0dWbYtetjtwnrbsre20Jc2wroADqA4
 tOf6yVq6tDdAjWqyyRIgk3tFbfyp5TiZipLH0xB9s1NdPFnEJjnn90lDzB3trKqdHLeg
 wWsB5HzETTYtRU8HPRE33M8BiSbr8q/6QEC5G+xojzbcCkOoeGjCE3cZqBLF0PCiJgjk
 CvGA==
X-Gm-Message-State: APjAAAWqbhypB7OsvBuHjeq4hVTge9haECEKN/8aEwSk3zkJRnYgva8z
 vov8pKRaCGgJ8iwKM0h88M8LSx19mTR9tdncE5KGog==
X-Google-Smtp-Source: APXvYqy/cGtNBnuXIeTLit43h2i78NIDzYEgvSsXvAwPWsw2IQiEjkESirCT+Z0IZmTuImh8lpT7WOZ2xanA5AkRWIQ=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr4245311oid.98.1582916601193;
 Fri, 28 Feb 2020 11:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20200225180831.26078-1-richard.henderson@linaro.org>
 <20200225180831.26078-2-richard.henderson@linaro.org>
 <CAFEAcA8ipK0nZioEgbNq5B1L-tqA+rzn-C2yyfet4_4yNVnYqA@mail.gmail.com>
 <e4a70637-f4b7-eaa7-237a-57053c5a63cc@linaro.org>
 <CAFEAcA-8a4eQXf+LRS3KLURyyEPpPm9uh6q6r6D-1-sh3t8Pdw@mail.gmail.com>
 <5c484ae5-b4da-8eae-c10a-547c670c89e5@linaro.org>
In-Reply-To: <5c484ae5-b4da-8eae-c10a-547c670c89e5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2020 19:03:10 +0000
Message-ID: <CAFEAcA96AZB765TizrPLJYfXhx=KUcb_feL3JK1WNmf5dRSR0w@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] target/arm: Improve masking of HCR RES0 bits
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Feb 2020 at 18:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/28/20 9:34 AM, Peter Maydell wrote:
> > You could refine the valid mask as the & of the bits which we
> > do want to exist in aarch32, rather than &~ of the reserved bits:
> >
> >  valid_mask &= TTLBIS | TOCU | TICAB | ...
> >
> > ?
>
> Yes, that's a good idea.

It occurs to me that we should check what the required
semantics are for the opposite half of the register
if the guest writes to one half of it via hcr_writehigh()
or hcr_writelow() -- is the un-accessed half supposed
to stay exactly as it is, or is it ok for the
RES0-for-aarch32 bits to get squashed in the process?
That would seem at least a bit odd even if it's valid,
so maybe better to do aarch32 RES0 masking in
hcr_writehigh() and hcr_writelow()?

thanks
-- PMM

