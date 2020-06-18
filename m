Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1564C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0B5208C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIEDoxW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0B5208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlxil-0000ZG-Rk
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxi7-0008GL-S5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:48:20 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxi6-0005Q9-9e
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:48:19 -0400
Received: by mail-oi1-x241.google.com with SMTP id d67so5676335oig.6
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MIaopRgZwcmRCA/lg2/yULeuxB87+hr36Ym/eRQQyNY=;
 b=RIEDoxW/20jEtBTtJIZFmrzbTX6qXvQ/Nbe+cVSfDMLGNBCZs35FKf2yyCmgmvc08w
 gtUnBWgHKCJPAc1hYN9g2SpRHzOM8dLd+KkBjODfhb0ZI748D27SyZud0CtLzOBVVhdA
 Mp/sPKn123wQrUxrkoUNQtOIeRzcJVORdvhyeB4JhAi9s2OkJ/UXjPyi9p6ooKz7DxqN
 ugfivVbyLfZhSFyOMMlp61P0E8hXSsqTVunNVbX5YImK3O3LVeEKCDbJkqA+44e+HDYY
 ScbgBKtMn520Rp8xMb0icFukvrYK2pXbOAOcFGFFzxbihtsaNK9ox/kU3KkWxYZBY1Ee
 S7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MIaopRgZwcmRCA/lg2/yULeuxB87+hr36Ym/eRQQyNY=;
 b=h5U+kYPazzKHjyh3RzE+8ll9xossSxyKBMdyziZcGNEQ2veIVLIz8cbBxT2qbV2AvI
 hveo3Ld46pJ0+iIL4HWjzuVRAzS+sytV+iKPOFmO13/BHrqJ39Mq29JoMWsJJueHofds
 vWLQZafPkuTaEhPAQdQr/XPl3pvziN5C2HR4qdTxaOYbFXjlLANSUyhiM5nqRAkxYuEx
 iG/uYqOu5w4QBFwFUXjx4k511DeVvq7wTNmiGhLXZD2MbWZJ/c1KJTpOIjGw4fDCgwcK
 eYTWYJH7+k9g3wTkbXi7jhkTOZc3a/NxEAeSytpMiOCYdYf26FtFZuObgObtYwfPaDo6
 JoFQ==
X-Gm-Message-State: AOAM530V0lLwetL/Lgu6QCnMhMYgAcmfjFHhN5DyFVQuVHYA36wI1puj
 5BGeKSY7p8wkGspbol09fEuiM5emfipdzuH5zScgXw==
X-Google-Smtp-Source: ABdhPJw/38m8nh2NM3Lm7OaIjG8ivmz1CRjDjoYP68XGQDPX+dIYue6iYkfQaY8bFyGDZIcxQncBAdy+BY5+A96YEOk=
X-Received: by 2002:aca:568c:: with SMTP id k134mr3546238oib.48.1592498897156; 
 Thu, 18 Jun 2020 09:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592266950.git.balaton@eik.bme.hu>
 <a972d774b01c3fa1b6f65eeeb35e8ff71a893deb.1592266950.git.balaton@eik.bme.hu>
In-Reply-To: <a972d774b01c3fa1b6f65eeeb35e8ff71a893deb.1592266950.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 17:48:06 +0100
Message-ID: <CAFEAcA9UMtJgmTCzQoe4KAd0HucoeijV+=4ir09kg=fA2YWH2Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] sm501: Convert debug printfs to traces
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 01:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c      | 50 +++++++++++------------------------------
>  hw/display/trace-events | 12 ++++++++++
>  2 files changed, 25 insertions(+), 37 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

