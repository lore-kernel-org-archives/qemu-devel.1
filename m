Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509D1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663FE2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pA9PAewh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663FE2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY6It-0002Yj-9o
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 07:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY6Hk-0001vL-1x
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:40:04 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:45169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY6Hh-0001qZ-2I
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:40:03 -0400
Received: by mail-ej1-x62e.google.com with SMTP id dk16so2758545ejb.12
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c6o23mTbsZY74jpgZWLq8WmlnDYe4iOb3Z1a4aEBa6A=;
 b=pA9PAewhmyYP09Z9kVLfeNuXsquceqTbkFj1/5CzpvuXzagvnutm4/VX1qsUrtapCT
 uwlBceKJ/Nh/geLqCqzAv9Msvnr24f7yeSBkSAT/ouvmXn36+oIABb7sb1GjGJ4Rk/yE
 9PXYAR5OwIRhMZATTN0JZgouVut0qGblY1QvWIRO1w2L66JvDQ4DVUdz1458cvTslIY1
 5bRgWBo2GYBQqXbr7FdL+RAs+cnAh7AJCVW49oHCirrPKkBvgSK0HgAZuTrwC4poPkhX
 4GBqfuuGHQxO/iZLjJy6PKePwAYhY0VDLLI69md/fEkZk/zDHiSNJbvtsJ6LSFivDQd6
 rRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c6o23mTbsZY74jpgZWLq8WmlnDYe4iOb3Z1a4aEBa6A=;
 b=bazfe39ZxLCqfJ1TDzooyswp7XgZYnvC2r++kiBsAwPiRsvD3zb12CzgTrDMvxxwGU
 JK5kQJJvc0eUA6ditRW8NHJStj3yJAQ0nmpWpG/zAMSkf1W0KUeGlAafLpMSQKtpSSU/
 HMNe6v+SOdIMzyL0LDkiEz/Rf4eChpfeOVIL82KQoVnmDIhAS7GnJadP46uGgu/4PLqn
 4KX2MNJh1akQpUQbQD7ammDdXnBhGopWQbFQO5wDw7oPSQ/ZGEZ8mOKvA/KcVaPVSUKf
 LC8i7W2mLqPwLdbXbpyXXID1WqYMRO3SxtAu3nPotfoIovAnQguJWUTnQRMIn3+VXq8h
 /Ylw==
X-Gm-Message-State: AOAM531sIei1LBz+KxaD9PHWWbTx/CGAClQAVKKOmUYmwQzRRcV6+klv
 vs5iEx+zLpG0ZGIQdnmpgxHn1JLdMGGcgAaBcWT9HA==
X-Google-Smtp-Source: ABdhPJz+L7WWGWVxdT6MXgEIQxYjacldk4AZEj00nIlrlEvKfgymkhDwCoLKTzmRpsCmSj3mxGG8a23SUagxgXv0pc4=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr3622631ejb.482.1603971599493; 
 Thu, 29 Oct 2020 04:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201027104932.558087-1-its@irrelevant.dk>
In-Reply-To: <20201027104932.558087-1-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 11:39:48 +0000
Message-ID: <CAFEAcA8EcEfaFZYUicbL5ShA5y5sTP7hmNNX5Ot=3ZyAGnV81A@mail.gmail.com>
Subject: Re: [PULL 00/30] nvme emulation patches for 5.2
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 at 10:49, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Hi Peter,
>
> The following changes since commit 1dc887329a10903940501b43e8c0cc67af7c06d5:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-20201026' into staging (2020-10-26 17:19:26 +0000)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/qemu-nvme.git tags/nvme-next-pull-request
>
> for you to fetch changes up to 843c8f91a7ad63f8f3e4e564d3f41f3d030ab8a9:
>
>   hw/block/nvme: fix queue identifer validation (2020-10-27 11:29:25 +0100)
>
> ----------------------------------------------------------------
> nvme emulation patches for 5.2
>
>   - lots of cleanups
>   - add support for scatter/gather lists
>   - add support for multiple namespaces (adds new nvme-ns device)
>   - change default pci vendor/device id
>   - add support for per-namespace smart log

Hi. This tag appears to have been signed with a GPG key
which isn't one that's been used before for an nvme pullreq
and which isn't on the public GPG servers...

thanks
-- PMM

