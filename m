Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10471C3A5A4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD206206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erydJuso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD206206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Y7A-0003Jy-V3
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Y4f-0001h9-68
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Y4d-0008VQ-Of
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:47:36 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2Y4d-0008Ug-JK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:47:35 -0400
Received: by mail-ot1-x344.google.com with SMTP id b1so18078520otp.6
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+LxfYnczmfkVOCS9NuTth/9LmeNCAq8MFuY9y9ur+xk=;
 b=erydJusoO6985uD5RjWiqmYc7Q+Ac6wPZgOdvNFuKDUO2FX28OYxI/3xPlhmBdyDzF
 1QEc9VczyfaudlmYni6qhwn1YrM3sts3wt+w+acePl8aB3Cm2J5KU0UIrUOalUNvlW3H
 XEua1TMz1OBhoIIpTUQ4iqvvRGfuWmwEB6Fhdqw0w+8Sd2AuiiY3xmIkEn9cFkGWHLJN
 FpPaOTI+A60ceR9yxyGIdzyJ+/xII0lY543DJLfIyWWTmC9yYyuTFUIRopH0Hvghnm04
 /UxNiETkOIfCwGHE2uSSX0ed8+Qp28vWg+h4PCPnL2ER7Q3CiqfNsjgsv4RUZb6fdij/
 ZAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+LxfYnczmfkVOCS9NuTth/9LmeNCAq8MFuY9y9ur+xk=;
 b=GAaDFstf8QcEUg7ygXM5WDcOyuMX9UH8WZCeXEXtJOvIxXzdzuEuSUUIXPYC3m/N0z
 h1O3a18KqLVTX2jIqXrdXrKYXAO6xEc6vsRfKOENz8iUdcqzMZ+qZyspHTsvStUXTOU7
 26a7VH1Mv4bblAigJVcDhuP1g5cudREQYTcsA8yABm0CZnwkbLL3Ofh9eyf5yUlDqhib
 YNOreyJ4R5pT5os1+A15c6FcKx5jf/tXjhblcQZdognUjOpwzzBUrw7Qym9uV80zWt5e
 xKS8mzdZx0vXNJgYHjs++Gj2hEFtE2MVGzq+JR3rbghFRy6gBz41qMw5ur78UkAAH98Y
 wPdw==
X-Gm-Message-State: APjAAAVQTuOnkHwSXcoaHqOiZZMK3lOMW0tBTYY7/QsBzmcW5RJ/GxYl
 s42cifaz8tcZOmvldqkgmma2vpnpHz1sXRdkwj+1Sw==
X-Google-Smtp-Source: APXvYqxeYdTJbDGaKzYBK2bRrcte/Q6ixwSMOuplugn8jQEbk/sIKzOe6zIP4eDobiwLfsGZnh/gpZnB2SswOn/Qv8k=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr2500729oti.91.1566899253393; 
 Tue, 27 Aug 2019 02:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <1566898915-3129-1-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1566898915-3129-1-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 10:47:22 +0100
Message-ID: <CAFEAcA-QunKkEW1BUXrEZVt+QP_Wc=dd0JJpnE+ypkPrca9TXw@mail.gmail.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: Load the Non Linux initrd to
 the memory
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 at 10:42, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> Except support linux operation system, qemu also supports other
> operation system which is non linux, such as microkernel system.
>
> But now Qemu only load linux initrd, so change it to load both
> linux and Non-linux initrd Image.

We currently support two methods of booting:
 (1) using the boot protocol defined by the Linux kernel
     (which includes how to find the DTB, initrd, what the
     secondary CPUs do, and so on)
 (2) you're a 'bare-metal' image, in which case you get
     complete control of all the CPUs at once in the same
     way the hardware does. Raw hardware doesn't provide
     initrd files, and nor does QEMU.

This patch seems to be trying to introduce a third hybrid
thing. Is there a specification for whatever this boot
protocol is? How many guest OSes use it? Are they common?

If you want an initrd, you can always wrap your guest OS in
a shim which complies with the Linux kernel boot protocol.
I think that would be a better approach than this patch.

thanks
-- PMM

