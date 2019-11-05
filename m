Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B87CC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B9121929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZGvqdpvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B9121929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5RZ-0005x0-Av
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iS5Qu-0005Py-Re
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iS5Qt-0006KR-Su
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:28:08 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iS5Qt-0006KF-Ob
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:28:07 -0500
Received: by mail-ot1-x342.google.com with SMTP id c19so2704126otr.11
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 12:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=57MtDgGya2ixDopTm0gAiXbS8omOEDYfogKw+vGRjhI=;
 b=ZGvqdpvfnQyqTLv/MkMjdDGyVc15ttlZ5MksgLkwcA6KwIc9rRDLQ/poLcyV1yvLrX
 KRvku6zCccMzyWqcXa2VbNTbnBjDV96592miGLatFcnwplPafMeNmCEMYyop4Z5mJksA
 JEe7y2YBDNlzMPk3JOx0knNzLOWuIsrIVk779ATBYGY2w6PPsgUzmEVklUAimS1AGi8q
 obPkmAX7e8ouWA5amKAVXXfKle7knW/PJM2ZznrkgwNMekf467huYDxB2NpMO8HrxqVl
 f0tpfhiiooN44DOv+fWMCTJoQvWCPLucA6//8mEHf5BrySPiOVH57YK/k5/xjABvSXWX
 Iqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=57MtDgGya2ixDopTm0gAiXbS8omOEDYfogKw+vGRjhI=;
 b=KeyMITPnzBBVa6Zx8zhrdojPyeN6gm5MwNkVR312DZEHKLAtwKakS9VCvQMX9eenUX
 SV5F8azo9dgNUPIH597UNqzegdauzqD53JsWggpbaxdsx6/RQwXbeINXqPfNKEgTTOSH
 oZQcvX8il3rSrQ7dxcD6VEd/y8ECyoMgydWlxpMEubl3OkOqWxLW3VeMBv8Rkc+qVXfP
 rYUn4LAA7jW7X/WlZvjjSmzIlAKwqw+7/r9GR/rnd05pkUwOeVIg6TZZvES8DK445hFR
 7Nec6gAh5GysCuKA8yKGlM4OFA+HwL5Her1SRlk5Y+bf9zRh2dJdU54WKA2xFQKx0/dw
 ZRxQ==
X-Gm-Message-State: APjAAAUqGOF2hQkCahB0h3Str6wmMNg62XZ760uRO99y4WTDFWz0pPbd
 fzqLaDmQVl3xymI4pRVHH9QUx0QmZrqinH5oimXvRA==
X-Google-Smtp-Source: APXvYqwwGDUErhpxp5DQC8PyWvMFndu6e/Z9OMSQUQRDjrVZdX8WkwnenEjqYizPnFWk+qgk2g2R06XkU0CDnJtOhV4=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr22806746oto.221.1572985687172; 
 Tue, 05 Nov 2019 12:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20191101103232.3692818-1-luc.michel@greensocs.com>
 <CAFEAcA96tfJNVrnQzKyzooy7sJ__WKWWHXdAy_TNy=hSB_DOQQ@mail.gmail.com>
 <aff8e672-e0c7-a0f5-9c53-403a2e57524d@linaro.org>
In-Reply-To: <aff8e672-e0c7-a0f5-9c53-403a2e57524d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2019 20:27:59 +0000
Message-ID: <CAFEAcA__axmxsKL6NPYbGBMLS+YZ-aKNntn9hkSSg3nQR9Ksnw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/pxa2xx: rebuild hflags cache when modifying CPU
 state
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 at 11:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/1/19 11:42 AM, Peter Maydell wrote:
> > The other place that might need checking is the PSCI/etc
> > code for doing CPU power on/off (and other callers to the
> > power up/down functions like the imx6 power control regs).
> > Richard, did you look at that code to see if it needed hflags updates?
>
> I had a quick grovel through hw/misc/imx6_src.c and didn't see anything; was
> there something more specific you were thinking of?

Not anything all that specific, but all the power-on/off
code is basically doing "change the state of this other
CPU by mangling its register state/etc". I forget how much
of this we do in common code and how much in the calling
code that handles the specifics of ACPI/imx6/etc.

thanks
-- PMM

