Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E62C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 21:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D70A206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 21:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPZ7R6Fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D70A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0tHk-0000h3-TD
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 17:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0tH1-0000Eh-IO
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 17:06:03 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a]:35756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0tGz-00008S-Qd
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 17:06:03 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id w1so4809117ooj.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 14:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VX6rzapjdOL192LMGbCg6L0Q0ZT0XT/ujqfanrVNQdk=;
 b=oPZ7R6FnCKklWith2EJ2B66NioWPmf+xYlWnzQOhl/V2qYhNOkSho63dnryD0iCyXo
 CJ0CMtx9w0gwMvYgQ3dlwQwZsVTdNPb5oJA6454nYYMPCmhc1djVnR90SSUQKdUn4vjj
 FK4Q8dHXShAJUDYoOA8PEJo5ZxoHUm10uUClqOuq5Z8JY1GWPbqnTarbbM3FJLufgyhH
 Jv6E2w3pQ4wK9/Oup+8giEQ5M2wlEkQQdGnoSi0YXg1ztwMYmcGoORJ2YtTb2C+1Eevr
 sYu2tgTJWsjBzXPbUiefagK/GfamzoiSC2deiYROhRxOPTD3B5fruP2GvPYY20UQiYZK
 V7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VX6rzapjdOL192LMGbCg6L0Q0ZT0XT/ujqfanrVNQdk=;
 b=IrnUySQAIBdOVGOgXZzfXiyCC44r7uBwcV+ErEn5G8v/APGu7jOUyQq7+lwSl/ze+S
 lpg0InqClLqfovNGNczKYRiAaXuwxTmenppFA2ZWXfwbNA58RcRMutxyVtXowruoyCp7
 5i5RVPmQkj62vgzsxfk9MIloiLLg0xkFWc0b5K36iR2Bcf0KvhLYnFrdFN6GpvKIUseq
 kJyQNXansHEy9amO93eDXXdtq9Hy1dp3njUXdeOOfg2p7Li5+54NqQWzsc1jxiksxkju
 ppkFuXecvqBG7ywO1ugEHEEcAVUQHsB/9X2gn0LPNf75821ApCQ9WhTofdHIAe2KsJfq
 stQg==
X-Gm-Message-State: AOAM532PO+IgWVyFqUS5wu500E3opmk27/obm5lwD8XD/ClzP1nE2gLY
 okkM9Oykn8MEAq/O09zzRjAg9J8+kQU6JzN7zc8CFA==
X-Google-Smtp-Source: ABdhPJzXkokXbN9xv8EUeGla84gUTV/vEVovL8w6AReczDCQwD2d1zHWm3VwKWR59FmLSinNlZewwWutQlpNM/l/e10=
X-Received: by 2002:a4a:8dc1:: with SMTP id a1mr64413ool.69.1596056760388;
 Wed, 29 Jul 2020 14:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <SN4PR2101MB08805B8E85196354ACA49B54C0730@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <c0ff07b6-87bb-f0da-d345-71e62e6c8ef6@gnu.org>
In-Reply-To: <c0ff07b6-87bb-f0da-d345-71e62e6c8ef6@gnu.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Jul 2020 22:05:49 +0100
Message-ID: <CAFEAcA-5Xb=A26D-uTy7FyUvyQ4V=MrAv9HX3_9EjjgjyNFkQA@mail.gmail.com>
Subject: Re: qemu repo lockdown message for a WHPX PR
To: Paolo Bonzini <bonzini@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jul 2020 at 21:29, Paolo Bonzini <bonzini@gnu.org> wrote:
> I was not referring to github pull requests, but rather to a maintainer
> pull request.  This is also sent to the mailing list.  There is no
> QEMU-specific documentation since maintainers are generally experienced
> enough to have observed how these are sent

We do have some notes on the wiki:
https://wiki.qemu.org/Contribute/SubmitAPullRequest
but they're more in the nature of points to check assuming
you have a basic understanding of the workflow rather than
a complete tutorial.

thanks
-- PMM

