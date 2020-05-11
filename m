Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABD6C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A2C206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxZDdl9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A2C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8QA-0003ho-GR
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8PI-00039M-R3
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:23:44 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8PH-0003zm-Pf
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:23:44 -0400
Received: by mail-ot1-x341.google.com with SMTP id g14so7463538otg.10
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mZ2mm1X13K7VhdGcrTzAsOcmCjSGuWXDhkFlvmsEV0A=;
 b=pxZDdl9EK1T1PxZd6owq6Aw2uYn9p0WVwAOws590VO8HcpkD1CCG4ty/0FeRSI370O
 hGr1tWirka1EgXA//BZlBHqIvM0y6PPgckwbjbQK+2AuSV6HiyFfHibo2Jg9+H3d61Lf
 CMScmnHLyiGC/dmjVkhBvicpIMVJJyQrczRw7fwUArxMbeX3VYY+W0L17kjNXTVUV65F
 lK1L4wBxe/kYcdFF5U/f+uVLlwLGB0wbyNz5y71LaCQ7smwo3uNpI4PRZZ4cSOqKHePh
 mJm/Wq4k17zEG8sWMqmhfAJoUf0yHs0tQSqn+ubED7sNFEhYwWo+Am3VgIlbjqpFarND
 Eu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mZ2mm1X13K7VhdGcrTzAsOcmCjSGuWXDhkFlvmsEV0A=;
 b=Y6G4KoGjSgVimfK0TEnuO2q2qw9gRnFXqJ62isdtpQmwMAnWJ+jsZH4qBusEIVedQ5
 YK0AH6oOxU5XZ7fr4iQ15kUKsd0Ugqj+1iJbWF19/70NZ5pn4DhrNnZDGnT7kZtz63SF
 MU8Q5OhQI5W53D0DIFdxcXahb1wQb1V6+felS6kDVtEHB3Ea826yaiF/dXFRc3JlHdIV
 aCejaFe0lIfHPeJCdsjs21nyDX0cFPcRg/T+q03SAGAyJW2SKs7veRjyFt2Qb57z/7Jd
 UdvoJkWnvAar5Ad/SBzJY1mR01HLko4xyXVXZSRCokrhD0bakzc/YKolgyDiYgu7p3yD
 IGoQ==
X-Gm-Message-State: AGi0PubHBvYIuw7hEO+ZtILDirYsXnhdYLxhKq3Qx8345eSFgzr9JjsL
 hcaOVA8tWFDOOQ6Fr1G5vwVrIoKB6B9Np2u696ayGQ==
X-Google-Smtp-Source: APiQypL+Z2wNlEutmBdcDmwf3E9zExQM0VUXQbjOUwrRlZ71p3O29XKsWBlbQlP3fA2TDr5PgeRP3U+OMRSbiCGhq5A=
X-Received: by 2002:a9d:398b:: with SMTP id y11mr511044otb.135.1589203422325; 
 Mon, 11 May 2020 06:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200511131117.2486486-1-amanieu@gmail.com>
In-Reply-To: <20200511131117.2486486-1-amanieu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 14:23:31 +0100
Message-ID: <CAFEAcA_2X2CY3Z6Pwcd=p-vboPuYZPJOfx4smoQCoWtjo5sABQ@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/arm: Reset CPSR_E when entering a signal
 handler
To: "Amanieu d'Antras" <amanieu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 at 14:11, Amanieu d'Antras <amanieu@gmail.com> wrote:
>
> This fixes signal handlers running with the wrong endianness if the
> interrupted code used SETEND to dynamically switch endianness.
>
> Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
> ---
>  linux-user/arm/signal.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

