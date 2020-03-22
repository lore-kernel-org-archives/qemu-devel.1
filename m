Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565A3C4332E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 17:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DDF20732
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 17:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEnY9Hpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DDF20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG4I6-0000aR-AE
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 13:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jG4HE-000090-35
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 13:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jG4HC-0004vi-NA
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 13:20:43 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:42222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jG4HC-0004vT-AG
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 13:20:42 -0400
Received: by mail-oi1-x22a.google.com with SMTP id 13so12328032oiy.9
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Iuxh++40bO5//93o1QJR6DaGFa4lgj0HXEklfsl0K8U=;
 b=EEnY9Hpb4vj3YL6U8uaR6mUY1we8jOEnD0bdAcf8b0NNYLoAugq2fXW0T38nWpwUrv
 Qf3OJrTJyRfJ1DN8BewmLyP7oUah1wEr/JB+WLkfKD25Gfv0iA2YKPULQMnzxvK6dth+
 7IWUpijv7Rk6anqKcZPbOC2HAXyygfm8nmy2MFml28251bvP2H5Ul8rMju9fsx3Fekgl
 +1W8gWkJSSLrLy0G0/AirGgcXSpX5Y0KWsKKqSC/+kiemVWRVN0VVWNtPNQCwHXSfhAJ
 +E0TiR3BDJ34zaF4PaYlmHE8EkOGCYs9Sen2/CqWpXWMueutfSYY0PNOIbOaa5Oo7e+A
 rg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Iuxh++40bO5//93o1QJR6DaGFa4lgj0HXEklfsl0K8U=;
 b=l0nOJ0CyGkpz3a4aFWzea2kqUpiXOz7Fr4IgWlt0syVjPupYUP7H92uum8nnfV0dFD
 2UXJTGeyaW76/affspOeYhVQjoy2V2XvEE1SIaON0MuUP59YUjghHGFwAJxicNAtoBKJ
 tcJdddXNM/koKGNZ2cPNcpWTPdyMo5uAwxVaRLMFIiim5lOxic44JpMTztad/Es/NlNR
 C0s83YKMHLWSwhV1lE6+w2t/WkiX4PsMkx2XoFJwOt2i7aFsmQemhbf+OVi8tkHRO+/S
 LaC8HGtO4760H3rtZPMY7oPJ5/yN7YYTeBUEfQWq+ex2uQ2jn6x9m7TTELYsk5is7YWO
 nibA==
X-Gm-Message-State: ANhLgQ3DEDAOEeffRuehZw/y3Uea89JuhDmVwe9OQhas+M3R1J9ix0xe
 dRzUdjWXp/Q1/AbZlbSIgt1Luw8q3ENi2aplhaayyg==
X-Google-Smtp-Source: ADFU+vvL+FDuYWvFa4vOEDobbT9vDS0F9HHx2bedkJjn1p7NTQfesWBvAA6vher22tUpTGnvuQiEJ+Tbw9ieVVDxm04=
X-Received: by 2002:aca:190f:: with SMTP id l15mr13645425oii.48.1584897641179; 
 Sun, 22 Mar 2020 10:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <CAL1e-=gKB0qRxGntXrU0im2gjMh1tq_SLGTm+HsmgBRGXQ9+Bg@mail.gmail.com>
In-Reply-To: <CAL1e-=gKB0qRxGntXrU0im2gjMh1tq_SLGTm+HsmgBRGXQ9+Bg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 22 Mar 2020 17:20:30 +0000
Message-ID: <CAFEAcA-Yn_O=G-63O1Ug9=HYqN0_o_NH_nLpWmBv2bjk2Y_85A@mail.gmail.com>
Subject: Re: deprecation of in-tree builds
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 22 Mar 2020 at 15:29, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> If the "progress" (in the form of deprecation) is so impotrant, than the authors should devise it so that there is no dammage to existing features, and no adverse effects.
>
> In this light, perhaps in-tree builds deorecation is 5.0 is little premature.

The idea of deprecation is to give advance warning. So it's
better for our users if we announce it earlier, rather than
later. Strictly speaking our deprecation policy is for
user-facing features, not build-time stuff, where we are
less strict about how much notice we give people. But it
seems to me that if it's easy to give some advance notice
then why shouldn't we do so?

I agree that we should obviously make sure that everything
that currently assumes an in-tree build also works with an
out-of-tree build before we drop the support...

(Also, if we don't announce that we're planning to drop
support, nobody's going to report to us issues which
we need to fix :-))

thanks
-- PMM

