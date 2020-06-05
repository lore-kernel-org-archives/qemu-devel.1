Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5347C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 20:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791A7207D5
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 20:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SrdaVTgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791A7207D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhJ2A-0005S6-Lk
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 16:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhJ1E-0004tp-TU
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 16:32:49 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:43562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhJ1D-000219-UU
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 16:32:48 -0400
Received: by mail-oi1-x236.google.com with SMTP id j189so9309494oih.10
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a8zSriWtw28k7NQpw1iPUjIxGiMSLPbPAKoticuVOec=;
 b=SrdaVTgHZ0TD0QyDQIp6fh6eSUrOqRZHehMtkjogyQaarzzrspI1p3s5io1S6KsD6x
 7TO1/k4qfIRzghU9aQe5MLTceV4U+L8rYsViisuWlVSTzfFGunYTyiilxz6SWS59Wkn8
 gHcXn/y3C+4GBd4MWzbTCaQ1IhPFByJcSCIQw3ko5jBnODLhhis8fCw241JO3hR3pkcW
 27D4sR9Te4OGAjwF4sKdlmzfQ6oMu7p3NPFan/hVT++tyJ2sTUXyfJf+BCwcD9Nv3gc5
 k1R4Ig7naN8SPKAdFOWF3qkUwB9XJ2d4MXFcFT/rUm/K5JUs/D9hgOiW5oCnLYcDstia
 SsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a8zSriWtw28k7NQpw1iPUjIxGiMSLPbPAKoticuVOec=;
 b=iR7SQIDMqfGh1Iz35MGY9UhK9H7+03COv26yevjtFeylc0CLzJFEgccQcpAbprJNpL
 3hOf0zdrBjq6EVRPQP1MXgNmrs1nCmG0pu/a7rRVEr0lCDnfy3VLGQJvMDArMmRneOBn
 TRbh5pR399XvH6g0UWUc4N+YeQwTbrcl5I73wWtnIE0QWMaySMOLSlKZL8e3Xzym90y1
 8yWk+qt0zlHiMZqdFz4NGwRxNIbSi1teLZyzNy4zz88W1yubTqLle+bzQPhOVrwjreZA
 8h56XBiRMpN7/m9dkz+v8ZkDaYJyUFshAo9IiXYvfYyjgcXlAzclH3+cWhrDfkMUB0jH
 g/gA==
X-Gm-Message-State: AOAM533kWsvPWMErW9/UcPlnAWqdQHgsFa90agIZQpU2/arvse0X5aJ1
 zreqR26nxKwmsK4RBWiJr+Y0UanX8CxYlONxC8llOA==
X-Google-Smtp-Source: ABdhPJyfAhXsmcqwD+2OXGVWH/yTCBekcAMxbVe/V2rQsmeMfMB91dBpgOxjj2PlWoB8gvhenQwylLxh2mCcGzgf6Yc=
X-Received: by 2002:aca:568c:: with SMTP id k134mr2842371oib.48.1591389166536; 
 Fri, 05 Jun 2020 13:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200605114700.1052050-1-laurent@vivier.eu>
 <CAFEAcA9f3jLSnf=M_V4tuWjjY12QFqzp5_PvkdbG38AmEK6dAw@mail.gmail.com>
 <67f3b206-6bf1-65c3-1054-3aded4c69a23@vivier.eu>
In-Reply-To: <67f3b206-6bf1-65c3-1054-3aded4c69a23@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jun 2020 21:32:34 +0100
Message-ID: <CAFEAcA_TFYV=+f=NNib4dO2WTxaaN4wjwcdQPie2biAs2REk-g@mail.gmail.com>
Subject: Re: [PULL 00/19] Linux user for 5.1 patches
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x236.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 20:20, Laurent Vivier <laurent@vivier.eu> wrote:
> I was thinking this kind of problem would be detected by the travis-ci
> builds, but in fact ppc64 and s390 builds don't build other architecture
> linux-user targets.

That's an unfortunate gap in the CI -- we should ideally cover
the whole tree with at least one big-endian platform.

thanks
-- PMM

