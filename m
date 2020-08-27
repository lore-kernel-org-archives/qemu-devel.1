Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E853BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1864207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="etNcWTVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1864207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEpy-00079o-0I
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 06:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBEpE-0006hd-Dg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:08:08 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:44209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBEpC-0000av-OH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:08:08 -0400
Received: by mail-ej1-x642.google.com with SMTP id bo3so6841509ejb.11
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b5NmqhmU1uFE17J7e6zkJnP29si5/EMfl8QLXrSYhlg=;
 b=etNcWTVw6CZxW7gkREmQhVZwk9C4J0nn63NNbEjOvnmOX0FF6g6N7DFrc3XRqeo+QR
 PfPMh63WctOPy04ctep7ADxUfeX7P5O5XHUYHzitYwR/dPj2qlOGQdLS8LDrtiS5ZPp9
 it2GZQCmXQ6hwpnxEGhiJdexK+rOJ8GO4KiCEpKjO+tXGwdnVsdhBMH5uGjj1RZ3WEsF
 Du/h3ri8O0n9tKgx5Xjd89IJqYUBiltlYzeW3qkuHNNWG/A/f1dNf38JDVvyZ9M2j65U
 GNsg9UVRnxTbN3EbjTa0IHJTl74kZNWFcqGhb5lC/UZgtJInpwP4VO0YWUwNp2GHdVDu
 qrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b5NmqhmU1uFE17J7e6zkJnP29si5/EMfl8QLXrSYhlg=;
 b=ellRqtYXDV4iT6iRLTOIW9nFLlLHD1shvZrQLwL8DcRt0TSvZ7xU1tEHfc3m/Lo+G+
 Ja/mrqbWL0ccklErzS+gACAjAvnbr7FmnETr006Iug0Eo7ijSU15oV0ksZvVOWOR9P9X
 QXO1KQ4BMAaSgfQ/46Az3UPcagC4sT476VK2etcgDzQr2O1mxDFczjYj8yW/mrhTLgDb
 3k4HsrMi3VxpCts1k7SrKXcz76GB7FGn4F9uGMmG0ivRTULkFon26bLntlX3ZAMG1P1M
 yACm1brJvfNXYqSmCw5dpiUcylm8WCBw2JsmQqf77UKRYAlxkRw+0AeCdqJOzjMOWp0j
 wmvA==
X-Gm-Message-State: AOAM532QsI2QwLBA7SBIFomcHzAtHUsElIPSdgPnJ+X+9QV/M5tUp+4q
 bI4hhiYB8NkOQOTe7jfG0clx04RbQ86S2OZ4dva1qg==
X-Google-Smtp-Source: ABdhPJxY2YuPhz1K1lZsNCGO9ZOeKD1Qx5Qx/ZMqUSA8y/qquLVy3b+PfTra9Ghxlwg0ypUD/XBl1zudUaVjJsCEr8U=
X-Received: by 2002:a17:907:2066:: with SMTP id
 qp6mr10883343ejb.85.1598522885104; 
 Thu, 27 Aug 2020 03:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200826190128.22707-1-pbonzini@redhat.com>
 <3c7ca48a-5eb0-cfd4-bac0-a2a7475eec39@vivier.eu>
 <CABgObfZhE1+N1XiHBaPx7SZHawUwNeA4yG5g1TPNQ5TMCO9xSA@mail.gmail.com>
 <CABgObfas4KFFc=0r9o_N8BYC0jHUoVx=iS0VYFU+zSCj-9yVQg@mail.gmail.com>
 <CABgObfYrFxgUSx2MYDf_uJA_cDXe_befjTm8GuiCBENzRttkOw@mail.gmail.com>
In-Reply-To: <CABgObfYrFxgUSx2MYDf_uJA_cDXe_befjTm8GuiCBENzRttkOw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 11:07:53 +0100
Message-ID: <CAFEAcA8_ehUpuiCHkpdjdWQLHd8PG4D4ijtTo=vwk88wVip5HQ@mail.gmail.com>
Subject: Re: [PATCH] ninjatool: quote dollars in variables
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 10:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> ... and actually it's fixed in 0.55.1. We can therefore just update the submodule and declare 0.55.1 the minimum required version for QEMU.

Oh, I meant to ask -- if 0.56 is the one that gets rid of the
warnings about unstable-keyval backwards compatibility issues,
is there a reason our submodule version is 0.55 rather than 0.56 ?

thanks
-- PMM

