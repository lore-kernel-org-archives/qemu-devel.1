Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D96C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC942074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLPhrbPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC942074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kON79-0004jX-SB
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOMyr-0005Vb-I3
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:28:22 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:42033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOMyo-0002Iw-A0
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:28:21 -0400
Received: by mail-ej1-x643.google.com with SMTP id q13so2544267ejo.9
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tFI5JzehN3mc6X+UphLIA1R02oShmt7XY3dUv+fWOGI=;
 b=ZLPhrbPngyfAKUhEBb385G2Bp+gDk2Az8bKlx3Zx1s8FQ5ddfU2QbdmJdPrIBk7xJ/
 RpH5zQ68Vp5HpZiYER3HxvEQkqa6asBvCK8zjBofGeyPdYKk5IGN3JRzEd4XuG3Z8Umy
 4mdaKKkJfxxsZePI9WVx9Y8Lrw8RlF1Rl0uxkCPj0Jv1L6lT//YadhLlu6F79jimO906
 a0Kn8Kno41Isnjybbb/b0/K24O5LkVf3nB2PShcHMK6EMcuahKcdqa+A5xoPPrW72iXF
 +eYVyEcEWwLNIKlWZVnMY+HNswUQL/WGhETNsl3ABdJ1xvOhCEMfxJ1pWfCPkYGpUNb7
 nPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tFI5JzehN3mc6X+UphLIA1R02oShmt7XY3dUv+fWOGI=;
 b=eEZOQHI53oeraSdJnPg07garTGbcF3O6NvpTuElhqa2pjXb98GQJuDlMZePBr3v5Uc
 eXkcvOrhrZNTEVEgCxrXQdRotXBHciYRViHPrODf43v51VdptmtI3I3e1j8qYsNtB03F
 jOC0+mHQPCRKvXyfy65liLILnzqBeiWvBwENXR0R5M70vpu74xskiWJ8Zk9EMqNEOETD
 K40Q8Kn3gGafRTYum3l8nKXLMMTh8AdxxHUxyW1bQI9IntnxjinVuPeYPu18nA3Jt77k
 Kn8rxyZYLbmjIBijYqjHWnTrOkrxxnmyOFd9Wwm2lLHO9Ckr02O96Y52soAyfYjFNZHv
 5mDQ==
X-Gm-Message-State: AOAM5320NZZ6Zu8ZtrL9sL6ZCm8xLhZl8Iy5PdOw+LcS3cCTYaCk9oRk
 GV856yDJjqjD0n2/raivLz+I3H0sJPpI0X0CSt4gFQ==
X-Google-Smtp-Source: ABdhPJyPrL1R74Fpccbn70nezOJVMGdMiCjxHptgewq6iwWRcN8RwODNYlbLDEMGmGBygSKxUeO31ASCYPTiDiCB2P4=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr2738984ejb.382.1601652496399; 
 Fri, 02 Oct 2020 08:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
 <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
 <405d680b-d088-58ff-9364-fcfcea1345dc@redhat.com>
 <CAFEAcA9vr+HKe3HnNECo8=pP7KcdjZXr1cJqg8HTbYKbaNDY3A@mail.gmail.com>
 <a1ef11fc-7652-056e-bfcc-db0f8fcfc13f@redhat.com>
In-Reply-To: <a1ef11fc-7652-056e-bfcc-db0f8fcfc13f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 16:28:05 +0100
Message-ID: <CAFEAcA-MgZ9NcrGs6obbuZsc3xDtXjwB-_Xzk97+0kr+p=CxzQ@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 16:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Or is it loops vs. functions that you find ugly?

Lack of functions. Being able to abstract out what you're
doing into something with a comprehensible name is a
pretty basic software engineering requirement. Yes, you
*can* rearrange everything so that you ensure that
all the code that wants to do something sets up
some variables and then you loop over them, but
then you're contorting things out of the most readable
way to express them to work around limitations of the
build tool.

thanks
-- PMM

