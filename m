Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38489C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011792074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9nZCSpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011792074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8io-0005La-0J
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8hy-0004UH-Os
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:20:46 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8hw-0008Fp-Ub
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:20:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id s13so15508146otd.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JuYp9Og1tcdQuLSkD2J/5unvKLO5U1ivbIW1w9nyQ80=;
 b=k9nZCSppAKKgf9stEiP3SuCd0fMsZwbBIuNboa6lsrHv+34GGhEJbXOq6wnqfJPK7k
 L7+/WH0IiN689p4OMJBjTybJaKD1XvyhXcTsWbHQ7C4QuhzTa/uODHD+5sNCSDCZB6cf
 lnF1G4LjYHaeH/RhIUuaAs55U422euCkB763wC0rddEqKDpiTt4bMnVaqjD1Oo42N7H4
 w9eCDWUdZX5rEkLw7Yj6EbNeXCmjsSFx8hJrpIDdwvMOh8Vf5McHqxqAFhh1F/mja5X1
 ohFt+adeb3DEbcUbpZ/YY3A/Y2Har7BLG0PbbeOJSqkZ1O2+iV7sy3sQi9nRinLDF21D
 TGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JuYp9Og1tcdQuLSkD2J/5unvKLO5U1ivbIW1w9nyQ80=;
 b=uczI8Ea7kmarcs0KO1+0fZJoHJK6lE2jtQme5H/UlA9pmar6DfXzkBUO/1QIJq/Wth
 bKRZSDczyKK6BbPmwGGImQKKchrIN109Sh7R9aVYpMVi73ViQnum1cNk2ZcFT3+bv3id
 AbR76SLc7fgwSdOpoaZqKGxDruzFVG5VM1y6Mgpc3/po36YvX0V1mJqWQcvdRWSI1A7B
 NZrjdZ+oh3znMkGcYz0P7TzBg6QLtZu5+IAAQpWdrlYPPvyFq0Tg6JwtKX9n/hYUha9B
 /cT+3XU/FZADgsnje5MJ0dseham4abpIHdzqn2ZfXT0M6HBIb27+7gAmf2LiSAW/Dlgx
 281A==
X-Gm-Message-State: AOAM531vGIg+j8KzCDlN6s2XnQBmSnukQzpKRx7PFiyyM3n8vOq8fG+A
 eK8+h/uTwkraR5p0NgQ0omeO+u7wi14taA7AZvt4Tg==
X-Google-Smtp-Source: ABdhPJy1Z++SvMeHio+eeVgU3WmXhzqHFSW8BYxR4OiVkdsmcKkdqv4awPaoF0ovOqefblNCh8z1ZzBz2vrpl5XgBhc=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr1795027oto.91.1592302843654; 
 Tue, 16 Jun 2020 03:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200616063157.16389-1-f4bug@amsat.org>
 <20200616063157.16389-5-f4bug@amsat.org>
In-Reply-To: <20200616063157.16389-5-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 11:20:32 +0100
Message-ID: <CAFEAcA-jW0n9gcLUoY66cC1BEO3fAX4FZSqxdKjqANot7YBvtg@mail.gmail.com>
Subject: Re: [PATCH 4/7] hw/arm/mps2: Add CMSDK AHB GPIO peripherals as
 unimplemented devices
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 07:32, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Register the GPIO peripherals as unimplemented to better
> follow their accesses, for example booting Zephyr:
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

