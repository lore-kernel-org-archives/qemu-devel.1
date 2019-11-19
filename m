Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA62C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078BA2230D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axF5bmiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078BA2230D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX5sJ-00057q-BA
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 10:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX5qq-00048c-Gu
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX5qp-00057f-4c
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:55:36 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:46409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX5qo-00057C-Vs
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:55:35 -0500
Received: by mail-ot1-x329.google.com with SMTP id n23so18257856otr.13
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 07:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=TtvtTUwSqIM5ntkOpFBTChAB+Y/qvDSYk1XmP+I3qUI=;
 b=axF5bmiAkqmDaGeoOL6uARup6vWi0sBa+Cu4GK0sMKwSi5I23CHNRYwQ1OwFh9N/+S
 lye4kbXUQa1ytuVJpC30cZ8jFEbU0fP7613pykwHAbKc9aon/P40mRzURAQoBoHXfonk
 G3I/1vws7Mxw0QvIw7CqX0jdl2SXLX5YAxDQicTfTwwvds1jRyerRMQU/MoFRWNFAkkH
 K/d0xTSpj7x8siCLeBDtXDtO73ZvXsmFJtfVhuOFKSpDjs2kpkHlF/tetrgXrZ6nuL09
 SzDE47z3SpIwAFI9RyCbS8pI5rPm8E888nEV5WFasklUGJpss6eqBy7MD6XpfM7iJkFc
 ZTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=TtvtTUwSqIM5ntkOpFBTChAB+Y/qvDSYk1XmP+I3qUI=;
 b=jLjI4OPz+ekts9C2E7HliZh412ZXs/vhWYD3fSwWzPx8Mvo+wP/ju4AtnYm40Li+Xi
 K5AURV2sKOPSX9JwBm5hJ7BoAPnKWccW7WX+B1/kIHlTVKYCCJtAlPgp5L9qVm45J66X
 kxLeoAGY17FNhs+JPp8XgyiQ8Dy4nPplI4nGn4R11jH9NRNv+ni9/GxHPCrrQb2UILP3
 efFfXOeqAyJr7ANoDbH62jn+sXGSawt2hRu2EK3jAzvu1Fls/m7zBalMQ3FxsBLDNXP/
 tjUhdqEVcWkbDX7XRJ1a4ElV9VFhRgIjc6V+wFMYBvxDMKHGk1epjCbBzk1IGOO7/cPE
 0IpA==
X-Gm-Message-State: APjAAAWJ/fkvL7zu3i03Enw1xJwVkLXtvpIji4Ol7iv5BKGAXPepofml
 TnmmkQJdqcN/EC/RVk0cXuixTn7mnEPAd67HbaGX7+bZBd8=
X-Google-Smtp-Source: APXvYqxT4fMY5LFAjouJtMmoK/Os7iMgh5hDSWWDxGyj8Fi5i9Q5hyyN+gHO9HMzWxS9A/4c7mtD8+Z9wO1l3JeooV0=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr4272256otn.135.1574178933164; 
 Tue, 19 Nov 2019 07:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20191119133145.31466-1-peter.maydell@linaro.org>
In-Reply-To: <20191119133145.31466-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 15:55:21 +0000
Message-ID: <CAFEAcA_kPu8KU3LDn+btA_iGZXM9Y_mD71vDRrQ7WRN03NCS0g@mail.gmail.com>
Subject: Re: [PULL 0/7] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 at 13:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Target-arm queue for rc2 -- just some minor bugfixes.
>
> thanks
> -- PMM
>
> The following changes since commit 6e5d4999c761ffa082f60d72a14e5c953515b417:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2019-11-19' into staging (2019-11-19 11:29:01 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191119
>
> for you to fetch changes up to 04c9c81b8fa2ee33f59a26265700fae6fc646062:
>
>   target/arm: Support EL0 v7m msr/mrs for CONFIG_USER_ONLY (2019-11-19 13:20:28 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Support EL0 v7m msr/mrs for CONFIG_USER_ONLY
>  * Relax r13 restriction for ldrex/strex for v8.0
>  * Do not reject rt == rt2 for strexd
>  * net/cadence_gem: Set PHY autonegotiation restart status
>  * ssi: xilinx_spips: Skip spi bus update for a few register writes
>  * pl031: Expose RTCICR as proper WC register
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

