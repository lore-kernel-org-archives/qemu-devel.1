Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C2BC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D03B2137B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5vuNAYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D03B2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5Us-0000cE-9K
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU5TV-0007P2-S0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU5TV-0004sy-0I
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:27:21 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:39406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU5TU-0004oP-IP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:27:20 -0400
Received: by mail-oi1-x235.google.com with SMTP id m10so4637954oie.6
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QaYXM/PYSJvOhQey35cK14T5lpdWIAM/ZMjLatNnLhc=;
 b=E5vuNAYYifG8ySYmgTzn4RYS/IUeNFmw0cPkrM6zjwPjViM8IqM3nFMbHRCdmX4zAS
 5f8ogxcBhqLso7jRjQXVgh8A4LjIno1K5WL8rZsn0+64JmvO1rU9CVuljD0a7Fb9Ia94
 hreinWKp6hvTGyCQ2OwP0dl7w/MvqHneJ+UgBMBryWgF1boUUwgqeL+dpiTLRsdjapTP
 vlLQ+QIfKnzIBd+R/EOua3d+BJP7d/ljXTVHBYN0NkQqxBrfMMNRbylEcrn/aKS/gFKZ
 S89U+h0+1UvB0q9hOhuLOkoL/TPJUEcdDef1cuiykGQE6cLMzC3y55Re+CZG+vT8BDwB
 Eh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QaYXM/PYSJvOhQey35cK14T5lpdWIAM/ZMjLatNnLhc=;
 b=oQRXQ2NZnjWSp/x7JGRQPX9uwiVfZxQP9KAmT9rkRtdQ6yYquTWNp+wSXb+G9Z0tQB
 DM+7gkbBAuiirk8Biq4/w53pvXwkR57o8ip53coNfZr8eH1QTQI1DD/bX5NbmF7d6suF
 jqmUybVDKpQf56dFEuvgfXAmB2/8X/0M8lltT+wabZAyQsG4ysMrG6HOLgH0xvrBOT+W
 h6IHYYQTBW0nF2E+n0xzil5OZ9OqVUTXEdDoBVCt6qp6pao/tynVr8MA7JH+0DbRMxHg
 JozBS7uVXcPRn9J3EMUgEb/qU/Ub8MgsHWueoZ7Q6hhhR0OAbhV+FChftuUVJHsu0QxA
 pxDg==
X-Gm-Message-State: AGi0PuYmTqABNV/pCOJmNo/Qk0O9q7NnPy9z4/vjaLlyx3D86fsioD3j
 Us71TLO42AT/Z59hfbFDUFTvzvvL3QRJaznNqpU4BQ==
X-Google-Smtp-Source: APiQypJRKYrwsXX0L86cm18hWc+OzVPQnA76oyTGye/oV3Y3hYH7fORIX62hTy5XulBrJXlk1K+ACNPlf+ITUt3aUVY=
X-Received: by 2002:aca:895:: with SMTP id 143mr356705oii.163.1588238839088;
 Thu, 30 Apr 2020 02:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
 <20200429155719.GL1495129@redhat.com>
 <87k11xh2kq.fsf@dusky.pond.sub.org>
In-Reply-To: <87k11xh2kq.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2020 10:27:07 +0100
Message-ID: <CAFEAcA9-oxkMD-kJ1z12d4K1S_Jaz7Wj6_38Ah7ChSaBfQNkkA@mail.gmail.com>
Subject: Re: Failing property setters + hardwired devices + -global = a bad day
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 at 08:09, Markus Armbruster <armbru@redhat.com> wrote:
> Our means to configure onboard devices are weak.  We sidestepped this
> for isa-fdc by taking it off the board, and thus make -device work.

This seems to be a general dynamic: the x86 pc machine works
via -device options (or is changed so it can work that way);
and then people propose dropping/deprecating/etc the config
options that work with onboard devices, without providing
clear solutions/instructions on how the command line needs
to change/etc for the mass of boards which are not the x86
pc machine and which do have a lot of onboard devices which
can't be handled via -device.

So my gut reaction to the "we should deprecate -global"
suggestions in this thread was a bit "here we go again"...
What works for x86 or even "what is sufficient for libvirt"
doesn't necessarily cover all the cases.

thanks
-- PMM

