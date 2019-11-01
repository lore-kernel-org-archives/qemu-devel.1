Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9655CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDA321734
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x66evxSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDA321734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQUPV-0001Hw-QG
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 06:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQUOX-0000KQ-Vy
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQUOW-0000aZ-MA
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:43:05 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQUOW-0000Yf-FB
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:43:04 -0400
Received: by mail-oi1-x244.google.com with SMTP id s71so7763864oih.11
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 03:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RRCPdvuPxal8vX64DWImMo/sKxIAjv2N6JAaqUg4zcQ=;
 b=x66evxSpB8HAJvTXNEz6dvUVWvbHxwkG+B7iAyQyK7pRPr1OL/pyKEO94v3impUI+J
 tZBSwhWhtg/F3yZ6qJxykiiaLkxihfLxUPsHkyU6sMP2f7W3a3LL3QuvV0SsQVVyKt5C
 fpNuVqwMqUX5KsXfNUI6EOtQC27Qxoj6NXU73RO+osO7mtwAhwPwJIuQwG2u4xacmtgm
 IfE/+fV0tiBxxIWVIYVlp8yvn8ooYUxYJmLvTqhcLRl+orOGKpRK4bUyCQTFt8YkeuXR
 xwp0sccJjT3FKXEyUx11Z7TtNMpB+2jWVSSx1tLhdVZ6uiwIkT27lt/4GV+8+5DyDb3/
 3ZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RRCPdvuPxal8vX64DWImMo/sKxIAjv2N6JAaqUg4zcQ=;
 b=TqKdSUN1eA/L7LJP5IcLuUlAFn9kh2lvMl1kHaebWObsRZeJoKON66qO3DYvPgZ0V7
 ANOFz3GzEETPqESncopmHmgY37tJvZ8lhD/ugU2SABvDA5504hV3f+mDIV99BZoHusLq
 C1iWhiqOyNNnhc/oaBJzK9jOf8ZuV3cgzmzBhIJffOxNt2GH3vYv5ZjT4spKwSKaGp1o
 Cz+k0SuTts3Kyy609eORnqydk8Gk6yuZDq3uOfx4dTXoGnVByPCyud3a1H9veRNOpcuT
 j+Ua0ZvzaPG4SdZJvBFJrV+fBy/iNYDQ3LSm66nsE+cOSSsx/TR+W0qaFBd5M1rRreOL
 pEuA==
X-Gm-Message-State: APjAAAV2dSZEH9ET7DJu3l58gTW8Aj4hYmLIljLLMt0/6EU9M75gyJfM
 gEQ6eU577nnjEvpVqAdGauI4r6/dNXpzeIP5Dn5RaA==
X-Google-Smtp-Source: APXvYqwMQp1n7qktTOaTojmmcEGUO6vER9yISMKqzV01LQOBi0VLcdjPKwyvkRDrQux5usRmW+dBUIBfJ5LTC4c4zXA=
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr2211696oia.146.1572604983188; 
 Fri, 01 Nov 2019 03:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191101103232.3692818-1-luc.michel@greensocs.com>
In-Reply-To: <20191101103232.3692818-1-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Nov 2019 10:42:52 +0000
Message-ID: <CAFEAcA96tfJNVrnQzKyzooy7sJ__WKWWHXdAy_TNy=hSB_DOQQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/pxa2xx: rebuild hflags cache when modifying CPU
 state
To: Luc Michel <luc.michel@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 1 Nov 2019 at 10:32, Luc Michel <luc.michel@greensocs.com> wrote:
>
> This machine modifies the CPU state when simulating suspend mode. This
> commit adds a missing call to arm_rebuild_hflags after those
> modifications.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
> I came over this missing hflags rebuild while reviewing Edgar's similar
> fix in hw/arm/boot.c. I could not find any other place where it would be
> missing but I may be wrong.

pxa2xx_pwrmode_write() is a cp14 coprocessor register write
function, so I think that the hflags rebuild that is done by
translate.c:disas_coproc_insn() after a cp register write
should already handle this case ?


The other place that might need checking is the PSCI/etc
code for doing CPU power on/off (and other callers to the
power up/down functions like the imx6 power control regs).
Richard, did you look at that code to see if it needed hflags updates?

thanks
-- PMM

