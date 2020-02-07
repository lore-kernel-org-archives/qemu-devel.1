Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B01C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB6421741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJ2GVknT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB6421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j03vC-0005Gs-Lq
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j03uT-0004N8-Gg
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j03uS-0004ky-Jx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:43:05 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j03uS-0004iB-Dz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:43:04 -0500
Received: by mail-oi1-x242.google.com with SMTP id b18so2015029oie.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 05:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eK//0BPXdBXVSYF8DmGT+mKJGovA13PbHe5p+AC94I0=;
 b=uJ2GVknTZQi3bnKKzFqOMaOQD9HwXGryyhbJe84a1ttYmIBqI80uG2qNA2c4yE/PXS
 LmCiQGX1fBTEal8sYT8nt6YlhfzAzGjtxRZqhXHawYyTSULdunt1VooAnPhnGPgxjxz9
 a7MCJFmTnZksueclHQY39xS54q130t18er9pgE5fF0Gj0hUSWIP+lUw2Gvu4jxabE1fG
 /46zYYuuijpmEN2hjaLYXHvKetHm0jBdgwvFH+4JgAgBH0KI3z1YiY08mYeYtlFTB54r
 +fvW14I1D346uPdySMBJBVIm2cpHX2QV8qOZTMeCv+EioT4UiNRuRBzNtJacCEChUSsR
 QF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eK//0BPXdBXVSYF8DmGT+mKJGovA13PbHe5p+AC94I0=;
 b=ZJJgfMip15vGGEn9nU9lipOHyGwoePlztFbc2Ud2kGBhYfqcPKMzcyg9W0NCZrSvC9
 7R7afJ7D0qf9rAO2kh0W7tZBhlng369HteUKcrydCYUvNbnqhFKjC8COF2vV8nRjIz/v
 6hb4yNuyc00s/yjdOcjqPSZVz45TOS4487FJPOH/qfXB5fHeZnzDvPBPZqsr5CSEM9Xe
 ziO1esZN8I/KY4M+jbmsltpoWeQVq4SmDk22rrHJf0pvqPBf4Oa1Gny3AAeVG1FMuu8N
 1vc92jEyONaZntZkh7DSkGEP2uhuxL95G15J5d0xyfl1wBrq90V0YXtt7bH5yHINDzD1
 uhRQ==
X-Gm-Message-State: APjAAAWPKarqef1iCDg7p0yujvKFrZL0DxzePAcOntHE6r58VszBZM4j
 D5aAcfGniOQ9YBH7kJqk1w6coLSHtMCUAufYHZq+sw==
X-Google-Smtp-Source: APXvYqwDTyqzraJ1llNxCsTO5uiz+cQ4V68UyrRnJ19lgwuHZAjQUjAA2weE64T49ET6techC6DousXF7ePyF5IyjHI=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2174647oiy.170.1581082983449; 
 Fri, 07 Feb 2020 05:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20200205070659.22488-1-pannengyuan@huawei.com>
In-Reply-To: <20200205070659.22488-1-pannengyuan@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 13:42:52 +0000
Message-ID: <CAFEAcA9FmeoHyGMXtVn_ioYFoM7h3tcY8+Ts4boxJy24uExcEQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] delay timer_new to avoid memleaks
To: pannengyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Feb 2020 at 07:07, <pannengyuan@huawei.com> wrote:
>
> From: Pan Nengyuan <pannengyuan@huawei.com>
>
> This series delay timer_new into realize() to fix some memleaks when we call 'device-list-properties'.
>
> Pan Nengyuan (3):
>   armv7m_systick: delay timer_new to avoid memleaks
>   stm32f2xx_timer: delay timer_new to avoid memleaks
>   stellaris: delay timer_new to avoid memleaks
>
>  hw/arm/stellaris.c         | 7 ++++++-
>  hw/timer/armv7m_systick.c  | 6 ++++++
>  hw/timer/stm32f2xx_timer.c | 5 +++++
>  3 files changed, 17 insertions(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM

