Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5978FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B7B207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H84eD2/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B7B207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugP0-0002tp-Cx
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iudWZ-0002Sn-DW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iudWY-0003jY-9h
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:31:59 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iudWY-0003j3-3H
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:31:58 -0500
Received: by mail-oi1-x243.google.com with SMTP id p125so3026402oif.10
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lPzKUKgDI6EfoUly07hIA847tJbp2OidHNEfK6m6wHE=;
 b=H84eD2/EMD5H3V2VWLi9H11N6nJKsn/a2uCeojKPSmnB1yUpKIPkS2Q45KvJWKQRSq
 crzk8erXNCWeBp3q6ZnToEZswMUI1/1CUpYoeTZQIhcKiOwErkQAAJ9iRls9DFt8nohO
 l7Eq/0nym3XUJLFwoYQl4P3sHxzs+5Jdj9pvaXZuYC5kORqJgzOvAX2oPzx+4YuxjTjU
 sQPq47k5Es43ZlJkNzeLXpaucWxzWhlv+sOeLn1x3HPEJeFGD//tjcVVOCfkusRXt5bz
 47lSHK6l+nVa0OLUEoN85CtlnrkihaWZpWjmizDlix/CZLsJxuPp2tRjUBFzrjwexPe6
 A/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lPzKUKgDI6EfoUly07hIA847tJbp2OidHNEfK6m6wHE=;
 b=YQOy4kxP+V88JokHBWysWIHPaU1klbHoHcI2vxYdyjATRXn51ihn9NqqNlrO6383ro
 +e/Wm/3ncstSD9RYTHLVYswouEuz6V3IBLc7/aK1zM7/Bgq2wiVV2qyq2Er9unBRELfr
 N1pmOZZi8Vo3455KOp6dCvHJ6Xf+F0iaQXryDxcL+I727M487Vuqa3o9ijJYNABGdVBd
 2oYrJXCmwv33vCIlKjDxinBAmpLhnHxLVClRBSi/u+KJi3DrQzVuCQTYCnEJn9I1yead
 z15QXzQAzIWFx0k5llyw6bhmufy/nvdk2IU+bffDgidnZauahZKK17aE9UYi1kAJ3bOE
 fu6Q==
X-Gm-Message-State: APjAAAWlMvniYnR1lBJpM8rdbuEi88QlQapbEN6onPFA8Tj5S5Nu7CDY
 Ozsa5ABRJOysAS2fOyv9NXbukeRbjVxk+cW/PmfLeg==
X-Google-Smtp-Source: APXvYqz79iETQpNZ48Zv72JMrXYhrgeohcSeAl/Mn5OB64COFTpZyA/btbY2ogBa7ltGqTajvZwWpdtYywm5vDMB3CQ=
X-Received: by 2002:aca:570d:: with SMTP id l13mr10472675oib.146.1579789917244; 
 Thu, 23 Jan 2020 06:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20200123070913.626488-1-mst@redhat.com>
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 14:31:46 +0000
Message-ID: <CAFEAcA9XTcNjRnaACo9JNyCZWTD0fAcVa8HGJ9xUAPRoUjeZmw@mail.gmail.com>
Subject: Re: [PULL v3 00/18] virtio, pc: fixes, features
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 07:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Changes from v2:
>     - add a coding style fix
> Changes from v1:
>     - add a missing expected file
>
>
> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20200121' into staging (2020-01-21 15:29:25 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 8347505640238d3b80f9bb7510fdc1bb574bad19:
>
>   vhost: coding style fix (2020-01-23 02:08:15 -0500)
>
> ----------------------------------------------------------------
> virtio, pc: fixes, features
>
> Bugfixes all over the place.
> CPU hotplug with secureboot.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>



Judging by the commit hash I think what actually got applied
was this v3.

thanks
-- PMM

