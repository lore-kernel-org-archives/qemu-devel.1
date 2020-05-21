Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75184C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A71620748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHCCsaL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A71620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnxE-0006cr-BQ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnvv-0005mT-TZ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:20:36 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnvu-0001d7-Gj
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:20:35 -0400
Received: by mail-ot1-x341.google.com with SMTP id 63so5937060oto.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oKnMYKMXeLm/ukNnG5YEfp69hLPR73f0H1hgSgz5CUw=;
 b=OHCCsaL8DjcziR9fu6mwyytp5QcO5ArGa5yUwBs4H2LZmcpaM0yZx1aVPM2ngUbVLV
 juqvSwrSTopRymW4kCFLEmHGjUVHWUiH61kNkIYMFbHmje0Ij0rSSniPPQsOjKS/qw5H
 3e+aU3a9xK6sTUbW4b/Jd0jLhka/63uUeankXLmI7VDaqzqu7RQa8N7eDcoHK2UgKk+9
 1Ge165iZRUALn1WB1kR2sDTeRpWrFvg9wuHCHYejBuW9TGN3PJAGp+91Fwab9OSTk8Li
 a4Rf3Cl3FwLu7ra0dNhK4Uu2L6KoqrP2X3hfsT5Br2pWBZglNftIdne0Ld7Uh1l2DxEp
 7lPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oKnMYKMXeLm/ukNnG5YEfp69hLPR73f0H1hgSgz5CUw=;
 b=f4XaFe8GWfrwyJrCvc4kW0Tp56iAUxZToEm7IbgJ7cp87m7q1bpnjU1u98Cd8hfQ/U
 Ce9H9VrtyNP8s4VZ8ufsRrxFAtwRR49lQNQlyCPx/BziNjkWpt4whKcYVT+OjN5bi1Pu
 vImPigY0Xs4vLV2MP8slMBP0c5my2Ork+7nzgqEy5yVa5ATMBx7OhlgStBdvNXi5LUTs
 0+B9IX8tdrGVuhJq3qGKinv0jJ9B9+oMcAc/4urRNAY8tDjzvnD/+qyHEWdnQQ3qDOda
 AcCA99gwmTw5NYFSDmdFygP/4JOt63+uvoAq+334wU5kni2zbYllfoH/k5vuzSTVpqWg
 qNug==
X-Gm-Message-State: AOAM533B8SmYp8/wUmFX+/Z/dS49JHb9LIXk42rd8owFBFZZC5xdDTuj
 VHzMHjGI1Ug/eJeWxy271Ae68yTMKzqo7u8Sy4thO21o
X-Google-Smtp-Source: ABdhPJz4Y8eFERKa4rnSOorhdQH2K4T0G2/amosDW/HC+jguOobdnFa3Fj53dSmKZd3PZU7trOl6zlshvJs624/vMGE=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr7276227oth.221.1590078033295;
 Thu, 21 May 2020 09:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-4-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-4-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 17:20:22 +0100
Message-ID: <CAFEAcA89weeb76p6-kW8PYxMpYi+8H53AT2c6FWQwSCqSGnuqA@mail.gmail.com>
Subject: Re: [PATCH 03/24] sd/pxa2xx_mmci: Fix to realize "pxa2xx-mmci" device
To: Markus Armbruster <armbru@redhat.com>
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 06:04, Markus Armbruster <armbru@redhat.com> wrote:
>
> pxa2xx_mmci_init() creates a "pxa2xx-mmci" device, but neglects to
> realize it.  Affects machines akita, borzoi, connex, mainstone, spitz,
> terrier, tosa, verdex, and z2.
>
> I wonder how this ever worked.  If the "device becomes real only on
> realize" thing actually works, then we've always been missing the
> device, yet nobody noticed.

It works by accident: because the device in question happens
to not have a realize method, nothing breaks if we forget
to run the realize method. Undefined behaviour: we happened
to get lucky in this case.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

