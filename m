Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2C5C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B33206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjakDQc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B33206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMdn-0008Ur-3m
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMd7-0007qT-RB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCMd6-0002HF-Qr
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:08:01 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCMd6-0002Fc-M1
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:08:00 -0400
Received: by mail-ot1-x343.google.com with SMTP id a9so5888111otl.6
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tHYrDMVb220UMVs2+9QuEEQTPM5/i9JloyJzmFNIQgI=;
 b=fjakDQc20ZQMd+HcIKxZMjZqbpggBR59F/RSRfpRF8nyxdnm1FeiiQypmSgrSJ5FwZ
 g88vsFAOuLs8DRTlRKVdW4o0/PKgZv3z5bZsZ9KimtDWzbmp2vLA5Md6e35v9mKiShQT
 n547vdbuz0gfnn/LNLZ9LaXpeQZ3e6+zoSKRsF20MTm4DkbgITmBMjCHkoP7FBsyCSwj
 Ac1Nj2dudpCnmYQPWkiQqaVS3RmGG+y/Z6nnb70xpIwiLrb+annXBpwRaogQaiGU8WNl
 6frzStqbhn5NKz/uBDY4AVLRpFT154ca0sAd02yP9j1uezy/i1AmsmUH5FlzEvGRiDEQ
 jTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tHYrDMVb220UMVs2+9QuEEQTPM5/i9JloyJzmFNIQgI=;
 b=Zqt5OOhOhi0nsMA3V/MzcU//qm+MO0EGq/pBq4AsGZhIaliEMuW6tsJodVJAAS+2kC
 2DS+VSjtx8zp4aKc0Y/FD6iQTYgsCIPGJIrugPzp+wNcsxFoOLRKSeI5ySvAExBkDCJ+
 MVihVKDDodIoQYUTCME6DjiUSCa89HWk0G4/VeSrJ3x647fdJ3N/oCwmMaMuAfCxoHWi
 D6LQ+CRe3rxIS3X6EBhjVmcxUJQnRkcWb1bPHBwUXOGxb5eg+b4vQD9yMTimRfvQ3jeL
 JzEeN7JmjeAgQnJRUfyYKwytnR2Cc/DsC0DpCJnmCqG9vX8OiQJmn1xrs2SQu9zNkmxH
 oyKw==
X-Gm-Message-State: ANhLgQ3DX17iAOg/5GvT++1AYMf31jmVMnGxwbTsx934kKrZwYIxMyJZ
 kk6mBImat8pGsOrIl/b8mdyyzscc1l7rjgGMqyKWSQ==
X-Google-Smtp-Source: ADFU+vscGKG4YcTGzf/acSLlajkK3ER6vWRj1ZKpLVIoSfYQDukbmiSKv8qVuXoIQT0SF1Bdhx5qIPudovHtrv3zAhg=
X-Received: by 2002:a4a:9d08:: with SMTP id w8mr3732955ooj.64.1584014879606;
 Thu, 12 Mar 2020 05:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <158387822543.945.6014167629593674326@39012742ff91>
 <d07cc722-247b-4976-dd3b-00e3bdd5c808@roeck-us.net>
In-Reply-To: <d07cc722-247b-4976-dd3b-00e3bdd5c808@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 12:07:48 +0000
Message-ID: <CAFEAcA-uXmQGV2n6WJ9_rv1cbZPj2MQ4LWVk0TOdXYj3jnwyrw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Wire up USB controllers in i.MX6 emulations
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Jean-Christophe DUBOIS <jcd@tribudubois.net>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 22:54, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/10/20 3:10 PM, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/20200310210434.31544-1-linux@roeck-us.net/
> >
> >
> >
> > Hi,
> >
> > This series failed the asan build test. Please find the testing commands and
> > their output below. If you have Docker installed, you can probably reproduce it
> > locally.
> >
>
> I have no clue what this log tries to tell me. On the plus side (well, kind of),
> it looks like other patch series experience the same problem, so my working
> assumption is that this is either a test infrastructure problem, or that it is
> caused by some other patch which already made it into qemu.

Yeah, it's an existing problem in master (one of our tests fails for
some reason on this one config in patchew, but we haven't yet been
able to debug why). We'll either turn off the patchew config again
or disable the test.

thanks
-- PMM

