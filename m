Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED138C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 21:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75FF2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 21:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+i5dRhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75FF2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHwXc-0003vm-Sh
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 17:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHwWx-0003Aa-Ja
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 17:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHwWw-0007pF-AW
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 17:28:43 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:36357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHwWv-0007nb-Tw
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 17:28:42 -0400
Received: by mail-oi1-x229.google.com with SMTP id k18so10131899oib.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 14:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XGYK6vm1j0waZeqUYiEuKA6Soo3ORUsfrTvhjCbOBHo=;
 b=G+i5dRhYcmo1CHQXny+m15mUEL5B81VfpZKSx/DPjAlLbCbkGU0B5xme2Ha1+GM2mG
 9Kf99ba6vs9NuL+MReD6H/V+i43ho7kO5Tfddh7Z1ISeh+rHxeBjUK8rmtBinJAVVUtP
 5PlsQCtPsYH6LRfyMB9z6Jzkv2zCjTjWXqQUiZVIg+BjwIJVhsSLNvyM33d3af9SkptS
 SisnquI61k/umceLX5yNGiOtmA9sUFG++jGuMUqwUXlweV9T1bP/D80SkxrlXNi7YhSl
 onFF71a1SfwRL2ZRwLjI2lhVcYWxEaJaWHPaHjOCOz+Wyebb2CREdnjZB/9Hn73IbsF5
 /EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XGYK6vm1j0waZeqUYiEuKA6Soo3ORUsfrTvhjCbOBHo=;
 b=Tdc5sG/HEMHf9RV+VH78s0qeUvvJD7ZvjMTocP3QaqEm3p4hYUdajhJz3i6G8LcFhK
 FcITcM6IkzeFdqH0X1Le2PTLtEmim5bgrDBfviOG7htPg2/gHXJt3oyHT+F4Bnva7dKI
 hUgrJKGBMT6pNdHizjrH5rJwnzFZlx3QBT3aPRbOKOYTzhH5DdZMHiADMh+EfwIAeRoD
 fqvPSyO9DMFDvj+el5iOpogWTJrY7gaaZpVtTCkRN1HzeUUezeBr2KyM/A6KWU3axDb3
 Uf/9JQ0ZrLRqwMMnU3OMajCaVI0CUJx2frtuJq/U7X1JHawseKLJJLzkai/YrRiXYj97
 0+NQ==
X-Gm-Message-State: ANhLgQ3ZnF/ooKFFzVthWPaHXmTHdCOD+iy3P/6q8YkfDRGvcsfOqduQ
 TR5imcQNwYn8Uus1Ee4u4zyK5EwHyUvpxQvMAyzFkw==
X-Google-Smtp-Source: ADFU+vtMflyl8+7PfPfJfGso+V1dSth5t7TcmtWrQbNle7+qLMH5zP9TPQD+lsYSGj1k/U8wZ84nsZFX3sKDyszkWSQ=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr676669oih.146.1585344520373; 
 Fri, 27 Mar 2020 14:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <6dbdab0f-93ff-1df0-bff8-dd720d990be3.ref@yahoo.com>
 <6dbdab0f-93ff-1df0-bff8-dd720d990be3@yahoo.com>
In-Reply-To: <6dbdab0f-93ff-1df0-bff8-dd720d990be3@yahoo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2020 21:28:28 +0000
Message-ID: <CAFEAcA8aMhEYr2o3Pk7KrPd_t82nYS4PQw8+sPBkeNxT1LRC_A@mail.gmail.com>
Subject: Re: Error building Qemu 2.12.0 on Fedora 31 GCC 9.2.1 with the below
 error
To: Viktor Madarasz <viktor.madarasz@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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

On Fri, 27 Mar 2020 at 20:49, Viktor Madarasz <viktor.madarasz@yahoo.com> wrote:
>
> Hi
>
> Im trying to build Qemu 2.12.0 on Fedora 31 with GCC 9.2.1 as this
> particular qemu version is the only one working for my
> qemu-systems-ppc64 emulation I need
>
> ./configure runs with no problem but running make breaks at this point.
>

If you try to build an old QEMU on a new distro like this
you're likely to run a bunch of minor build bugs that have
been fixed in mainline. You will probably need to trawl through
the git history or the mailing list archives to find the
relevant commits which fix them (searching for error messages
is often a good tactic).

You should also choose configure options to minimise the
amount of source you build that you don't need. If you
only need qemu-system-ppc64, then pass configure the
"--target-list=ppc64-softmmu" argument and it will build
only that and won't try to build the linux-user code at all.
If configure of that vintage supports --disable-tools that
is also going to be useful (and if some bit of source that
looks uninteresting fails check to see if there's a relevant
--disable-something to just stop building it.)

thanks
-- PMM

