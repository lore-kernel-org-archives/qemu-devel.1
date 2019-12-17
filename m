Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46299C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1249A206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gubyXtSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1249A206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGtO-0006z2-Rk
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihGoX-0000i3-2L
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihGoV-0007jz-18
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:39:15 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihGoU-0007gv-LQ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:39:14 -0500
Received: by mail-oi1-x243.google.com with SMTP id i1so6019465oie.8
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 09:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r6nMlH6NQ/zXzXEPNeLi6nAjmBQajsuEkVBCjNWQcD0=;
 b=gubyXtSh0zHIgd1Re0/fWLr0b0mA3drEhj/W9zkdeQOx/PRivitrxOyU2vII8ACCiW
 RLJX90qNIllHkvM9VELh/n9gw0TCy1HRFZ0b1HJSYrXnRSK15qsDqy513O9sE3MTUTzO
 DGsm+cfW24w5bdDwRU/RnV7hyTr0HzcK70vFSTzokUUT2zevhXAYWhVFFQul9Pbd84uf
 iFB1i8ksaAcm4190NS/AhLRrRO/KF+dBELhlLNH1Pgm17ihdIMmAh7zec7J4+p9m7SU8
 AO2pyInuDPggJEWqw83Wv+1NLM6WBYwortx8/EQc2BgbhCpeKrxBhXQ0/QYUtdWiGA6f
 c7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r6nMlH6NQ/zXzXEPNeLi6nAjmBQajsuEkVBCjNWQcD0=;
 b=biwhK9iMcpZ740pbbSxd8iAVkaXVn2/Jg+PkyyX3HswyN1XQroerq/kl4nAKSriYeY
 Wn0o3fRyM+66olSlQG8rLWsdH9R8/3ISoCLIIiPfzgAYDOG31P8MvIFZi7ur+2SWU/7N
 D2R+eivw7hOR/WYKV+0LBtEbuB4hzw0GovYYye09j6mZQCaVhmFZyoIqD7HoTxoGCXS5
 5lM15UcKxwAX09h1v17SmvFIao9aMFfCt3C16Dn8l+vhkYPYLp4yoxlLGvkcY9W04EiO
 1SIYnueukYE046h7oKTz+DVvpSJoIv+MmJeAGVeHDHy7jGIa32ywdQYmVqUWPfCCwVAK
 ilAw==
X-Gm-Message-State: APjAAAVy62I45IfRlcOa121cnh/B+GblhoffrsNiPlVnUsnLay0970pi
 MES40EnZe+bmx4x5c3HDgKC0j/Cao+l7XH078uSj5g==
X-Google-Smtp-Source: APXvYqzL8ssQdFbcn8W7G6YxFMKH2/1Rfsh8FGWBvv+exO3TO894Sz604o0/OIpKK8ZdlRRwXNdN/ty70Ne+IhJU7/4=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr2135701oic.146.1576604353813; 
 Tue, 17 Dec 2019 09:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <20191216233519.29030-7-nieklinnenbank@gmail.com>
 <CAPan3WpW1Q3zpnqgk=MWRWe99=MQ4XoW2kw8L3tioFxfEBXd+Q@mail.gmail.com>
 <CAFEAcA8Viii4Em_bf4Y=AG0jU+EFFFTX6dO-52qd=RT4uHbCVw@mail.gmail.com>
 <19e4f2ac-6067-f61f-f340-108545fb0f02@linaro.org>
In-Reply-To: <19e4f2ac-6067-f61f-f340-108545fb0f02@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 17:39:02 +0000
Message-ID: <CAFEAcA-mzCB2OhU4AvgpSfjQMqvxm8Nn3iamoW9CY4QSA4k3gQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] arm/arm-powerctl: rebuild hflags after setting
 CP15 bits in arm_set_cpu_on()
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 at 16:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/17/19 6:12 AM, Peter Maydell wrote:
> > Cc'ing Richard : this is one for you I think... (surely we
> > need to rebuild the hflags from scratch when we power up
> > a CPU anyway?)
>
> We do compute hflags from scratch in reset.
>
> It has also turned out that there were a few board models that poked at the
> contents of the cpu and needed special help.  Some of that I would imagine
> would be fixed properly with the multi-phase reset patches, where we could
> rebuild hflags when *leaving* reset.
>
> In arm_set_cpu_on_async_work, we start by resetting the cpu and then start
> poking at the contents of some system registers.  So, yes, we do need to
> rebuild after doing that.  Also, I'm not sure how this function should fit into
> the multi-phase reset future.
>
> So:
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks; I've applied this patch to target-arm.next.

-- PMM

