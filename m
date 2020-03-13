Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D87C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA94F206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZMl/bh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA94F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClF2-0005lh-Uu
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jClEB-0004ka-3w
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jClEA-0000xB-0W
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:23:54 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jClE9-0000vA-QG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:23:53 -0400
Received: by mail-oi1-x243.google.com with SMTP id k8so8079918oik.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kgIvQwxPqr9EiBmI959VMtHbm7uK2wJv5w6hXNipx5c=;
 b=gZMl/bh/OB1Qsd5WdHMEULLr2kpbIgBkuO5zIbqQNZqoIZxdLjpGYK7bYH3yW6xuNa
 AaIJVfEUZQ5BP5J2ieYknB9ZzeUA5ZxcTqOH54wTgRApvmwuOBdnha3hhPBOaN+scWoX
 N2tQGxFqzWBf6PZPq/sOW0yn833O6oyvKJ0gNvuqbUnqmocRV6nEP4OmFyoTwnHpVCS4
 eGPPJ+OHKO9MDUvjnHLDq2oLhVvukQL5ebLsqhLpaNp5ip0SDmlfS1G1cMiRM1WmfWsU
 0FZaSmW0jMxIoMRJ+cZinKCm1UgONOVVAasLOMvMZRFxdWvIgLkILQj+oWJi2tA9wqSr
 k5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kgIvQwxPqr9EiBmI959VMtHbm7uK2wJv5w6hXNipx5c=;
 b=s8QFe0OGCHFJ0chsF/TgNND823M1RsbBrq/dAg1QvHOVM9VFOF7L5xc/Y1CBRzKFsH
 NYTNnP4ec54+9yYyNA3YVF8Yu1TJiBsYVXZbDdYPLpzN3ePK+L453jFyhUsQa2QLlU5m
 iC1a0ckEBA5VudqO8yviirWOAObRyUkAzdx3/4Y6mWNAjNLUj1L5aAtb2apjBJbhezhN
 DioUrCq52u8LpLY2eBOnQJDNi6emvM8hp3Ghhu8b4XPA1WJDa+3OEzz5BJkfT3Nuf+d4
 Y9vanAKY+Oah9mxkNUndIsY5ESQ01BBFmakW/kmCv+Wlyk4IBGr3fgT0MwB1WW6QwzBg
 lkcA==
X-Gm-Message-State: ANhLgQ0PKsith7EJXo6HZAiuagj/QVr9kH+Osrv1PlbQkLRAMtTh2+q9
 X8vRV3dpZWN7RFpr1EJP9ovDWVR3Z2OvNRD38Dsh+w==
X-Google-Smtp-Source: ADFU+vvNcaB2thzuHzgUcvWrdlbR7+QjD1HlPKh/K5ieOmj9jnBYQfAEHCSqnHRwLtmTJlc03basNbpEMkNbk2SXRG8=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr6874265oib.146.1584109432834; 
 Fri, 13 Mar 2020 07:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200313123014.206828-1-dgilbert@redhat.com>
 <CAFEAcA8KPovUiycEr2hHb4LP0SL-hBCTNgkA9KFKMb6FQTceuQ@mail.gmail.com>
 <CAFEAcA9pBMC0W9cHKmq5nttPcA9qpYofSvkZEnmkGuS2g_vPTA@mail.gmail.com>
 <20200313133451.GD3581@work-vm>
 <CAFEAcA-E-pu_SBbZAWE5Sg1qRVm7jT-idbd4CCdk3h=yYNNOQg@mail.gmail.com>
 <20200313135732.GE3581@work-vm>
In-Reply-To: <20200313135732.GE3581@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 14:23:41 +0000
Message-ID: <CAFEAcA_FBNB6o-mXMB_GzXtisCrPtYS8YLCLta53swpUA8cshQ@mail.gmail.com>
Subject: Re: [PATCH] exec/rom_reset: Free rom data during inmigrate skip
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 at 13:57, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> Ah yes, I think you're right, so something like:
>
>   if (runstate_check(RUN_STATE_INMIGRATE) && rom->data && rom->isrom) {

I think you would see the difference here for images
loaded into RAM, rather than ROM -- they need to be
reinstated on reset, because the guest can scribble
on them. So we retain the data and don't free it.

thanks
-- PMM

