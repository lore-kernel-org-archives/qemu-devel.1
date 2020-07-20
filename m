Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA51FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945C220B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKDDpqx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945C220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWb9-0001Ux-My
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxWZy-0000YP-4I
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:15:42 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:46988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxWZw-0002Vm-GD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:15:41 -0400
Received: by mail-ot1-x332.google.com with SMTP id n24so12267593otr.13
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SUUKuJaLyTqBuFFL/1eIrTW+O1obGLygeWucWbERJF8=;
 b=lKDDpqx2RTsWHrv98/sRqSi+zJQg2WQpJgpY+RL/lpyTMCBx2jSAew9qx6NnyVwuhK
 mZRhwPiVc6dFuIal5qQzYGpe1Rlde4/9MPwQ7fLPutx4J7pF9s1VrYxEVrvzHaRv9Zuj
 O+G5+pdBJ7ZYrP3OCR9BqlxPCegBv47bXdPZSIyV+N57AXqb1IdAWnh76MRkF1U6bc0g
 hsYbfYm8qmuEnvzXIbrwML2ECwYjlm7j8Ml19FX+qbs52m/u165PgkTCGIx8CqkWuBgY
 hfrSGtz3EIuk2VSTdxlmYCll6bMvbauPZJCIL28bRESSuLvvCn48zB6MgHHCzujNZASF
 rPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SUUKuJaLyTqBuFFL/1eIrTW+O1obGLygeWucWbERJF8=;
 b=CIRIeDlxSVA9P82IxZ520GXbiIuBLjMsYosqIlLPFs5Rf3EmGlEl1Oyp5yZSbhZbzn
 5qTw/28nOaGa+5vP6doNqcqygUDVEPcUXxCbXec/I+Z2iI1qE+H7calxqaSc5RUlB3tk
 /WOKmILgpKeBMy/SRVysrcVouiXPH7p161IEP/NOWVF2gO0slcnAyH8tEH7VQsDakMPS
 bnMW0XAPRR/CpH86PthugAccFK5Zl52pW7JWryEEi/4toxBWBTWE60mGDpdfKXv4Z2Zy
 FHhIBBzlX+d6dr3Qu9WDM1oHxcD8QViBezCl/W6T3jxuEpPsrIFY1ZV2xF9h1rIkpy/v
 no4w==
X-Gm-Message-State: AOAM532vs4iF881/3wt3nwHVNgxEBFtwCvcWH6fKnL4pJLGWoNC2RA/Q
 oInhWVnGz0z8uxSgWWWlxbwe1/KsM8MGvY3m+YIKfA==
X-Google-Smtp-Source: ABdhPJzady6WuMPT19oPSEI4q5M2953wx5yGXERoPWVz+GYH/R109m6c/b3IsoUdpb7f5jtSELCDbur5ZVffrJHEhOE=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr20732674oto.135.1595254539347; 
 Mon, 20 Jul 2020 07:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_dEBT1jNLWeThhmKisFNwbaSUe+vAEEbv5bnVVb+=bjA@mail.gmail.com>
 <20200720104641.GB5541@linux.fritz.box>
 <90c29aa8-ad14-0538-0e29-c2c9c434a051@redhat.com>
In-Reply-To: <90c29aa8-ad14-0538-0e29-c2c9c434a051@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2020 15:15:28 +0100
Message-ID: <CAFEAcA_SWO7fwR6nDAn9=HoYOVEf=L6AomjsonjbscPvTejQQA@mail.gmail.com>
Subject: Re: various iotests failures apparently due to overly optimistic
 timeout settings
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jul 2020 at 15:12, John Snow <jsnow@redhat.com> wrote:
>
> On 7/20/20 6:46 AM, Kevin Wolf wrote:
> > John, I think this is a result of your recent python/qemu/ changes that
> > make failure of graceful shutdown an error rather than just silently
> > falling back to SIGKILL.
> >
> > Should the default timeout be longer, should iotests override the
> > default, or should iotests just always kill their VM instead of trying
> > to shut it down gracefully?

> Let's make it longer. Since you are seeing the failures, can you edit
> python/qemu/machine.py and find the default timeout of 3 seconds for
> shutdown() and change it to 10? 30? 60?

Not conveniently, because this is for merge pull requests, and
all the iotests failures are nested inside the tests/vm BSD VM
setup.

thanks
-- PMM

