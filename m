Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45ACECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E66A2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3wjScqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E66A2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL99X-0002gX-FF
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL8Yf-0005r4-Tt
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL8Ye-0006do-P2
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:23:25 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL8Ye-0006dS-Jm
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:23:24 -0400
Received: by mail-oi1-x241.google.com with SMTP id a15so2701648oic.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=y9ZSlsYdwjwLKINTtXzEqwFkN0ObS5a2YzjMPz4vtNo=;
 b=A3wjScqK8w1PwuBDHmD/Muw5+PwOiR0GccU8Nv7E2p+k6O2fPS8cFPPFBWIHy77Pye
 Gvz4X3ayIU7Nl1LlSXHMUzyzmCB8XIZsTVPmFfGoYBWWdNDjACCpC6KTHPphCr6T/TRp
 5qwdlvjqCERziOFwfLqjdcRXjd2k9mXD/g9C1+BQRP3jh4HTeLX35kks2SUu8OSjXjRi
 HJ5gyTWNqGOtHzbKy4qOlmd2F1+fM/77m6FDYsQlIJS3wrH+ZY315p4CnRnRV9tm9lFQ
 kkjXB+pPy9f5/4utcMH7tEb1zmHabQ63p0MOzQe1aCPIVg7waH18z3ThtZa7KujFxBBm
 tihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=y9ZSlsYdwjwLKINTtXzEqwFkN0ObS5a2YzjMPz4vtNo=;
 b=EI2TWJ/MxgqG+3ULZAyClT0xTCY4/0UmhaiXSIZK3UQFguE8sQD0ci6t3EVfHGeyWH
 TIKD8qx3EBKehw20XHOKjjDLQDoJaG/7sdrSjJTrygV1vrUXGm+bnzc2lUmOay/BL9xM
 u/uAazlu11mKb3D5000CqWKdu5kFHQZp4TgZypbQNj0c6CZY2Lb9n5JmserEPHypmlEe
 a8wQ736krADpNeTr8PdPjgtLO/zwF+hhu48SB7+iLzgVkxHIU4X8bblHi40UqP8YWcrm
 +323oZghocyWdbKrPIzVvE7vdA3biJq0cjOpdeU8P26y/d01n1CvOyvNF6lUBEPZahSn
 Bzbg==
X-Gm-Message-State: APjAAAWlKehKQ126KBv3eFgUeXITc/iOuBnpzI+ku1TbBgbJAQ+ModP7
 MMA+OJCmtfNqMnIVZhKZjMXk2/a1lO6hacMte04O/A==
X-Google-Smtp-Source: APXvYqxfM4jeF+m+YVtOI6WXtLgGDcTWlVLYpC846dI9F084Sdpjm558vXGT4ccuF34Ds9lgJQ1Mr7Fc96PrtxWDp28=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr3997466oic.98.1571329403409; 
 Thu, 17 Oct 2019 09:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191007170646.14961-1-f4bug@amsat.org>
In-Reply-To: <20191007170646.14961-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 17:23:12 +0100
Message-ID: <CAFEAcA9DiMXu9a6nzSo4967y9G2E3tC8ijHF2=b6Kvpt=XeYEw@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm/raspi: Split the UART block from the AUX block
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 7 Oct 2019 at 18:06, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> The BCM2838 has many more peripherals than his little brother,
> the BCM2837. With the raspi4, the Linux kernel takes more steps
> to configure the various MUXed devices. At some point it started
> to bug me, so I plan to add a dummy simple BCM2835_SPI block.
> It is cleaner to add it as a separate device than mixed with the
> AUX block. As a first step, split the UART block out.
>
> Since this part is self-contained and my raspi4 branch is getting
> too big, I'm sending it as a single series.

If you squash patches 1 and 2 together and avoid doing
things like renaming all the register offset constant
names (or, for stuff like fixing up comment syntax and
checkpatch nits, do them in a preparatory patch), then it
becomes somewhat easier to review, because then you can use
git diff --color-moved and can see easily that code has
only been moved to the other file without any accidental
extra changes.

thanks
-- PMM

