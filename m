Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF863C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9607F208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4O60mOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9607F208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcrKp-0001rV-LC
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49143)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcrEB-00082c-68
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcrEA-0004za-3J
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:59:15 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:40525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcrE8-0004xl-Mv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:59:12 -0400
Received: by mail-oi1-x22a.google.com with SMTP id w196so6907971oie.7
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ob2gNaiO8VelF2LbDr1KKTZtlu7JChaQlMjY5/0YieY=;
 b=c4O60mOagXeECB/HpXPpdrgPqU82dVVZrWk0dQL0gQWvioZaV3elasBxSsq6o8is1r
 CRVQspERgu9Ix4whx4wTWbHBHn67h3XbW/drJGAXnE0qzDQQrnQ6Ce0IYIwDoZ+0Tp/W
 eHNRv3hrz88r753PPYis1fSnIImvEE4otVbxJqKdkFiQE66rvFGTjJMxTq97NbALFvra
 w8idFuSbjyq0xaJWERtsz8EjA9oBANgbgNLwgFcTcrJKwYuschwwQfLfzovMk3Z0xQ8/
 ZTQHn/hE6p522pTjqc6W6arbjAhJcQxc22Rn1uyhMMjve5w8qpSPQbjDg0LGbKjmffbG
 3Myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ob2gNaiO8VelF2LbDr1KKTZtlu7JChaQlMjY5/0YieY=;
 b=AP8VS11KyAJq9fGDUR+GBpwdp73EQkGkmoM75sBPRLRHo2Gn6i7N/wmLbq4MSSA+4X
 kbkmjOxZO25GAfe1ewVs599/oTMQ/0lUtiN3xJM33s2S8lxlfvU92V3ct+zCsqZoUMtA
 bxZZQ+lfFDRKq9CFkxypSiiNFvUw+Y5U6i15AGN9jaKKQogEbP12Fc8Hz/9JrwA+002T
 RydZ6IQBScx94aFkE4ciREQtpbd55TGuSyOWH5C9jeankCQf94cYRd3owR0KK1zjmP4u
 z+VtABe0ig2unZbDPuT47MHwJ32+bmromHm1eYz1AZvYNGzpL7rvmey5W7vH9nOwVm06
 AhZA==
X-Gm-Message-State: APjAAAXLHuOuyks/O4bDpBcThFFnKGy/2gLpfhNDmQiADMCseCybYhVh
 T7+0TG3J3YQlUI/DvOyrOEBmblr+kT3rM0Q6OsKczw==
X-Google-Smtp-Source: APXvYqzrwEYMWyZIPyW5gcNKK7+caTWEmwayXuw0ERgrzBD7Zow15rUKQsd3FUmpZijt0td3qLzAOOx85E/pcqYLLB4=
X-Received: by 2002:aca:ebd0:: with SMTP id
 j199mr10005088oih.146.1560776351670; 
 Mon, 17 Jun 2019 05:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190616213540.20430-1-mst@redhat.com>
In-Reply-To: <20190616213540.20430-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jun 2019 13:59:00 +0100
Message-ID: <CAFEAcA-T7-vSv3X-VtF_R_t+pgkLD4+dO2Sg3kOEdWN13ustCw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
Subject: Re: [Qemu-devel] [PULL 00/11] virtio, acpi: fixes, cleanups
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

On Sun, 16 Jun 2019 at 22:36, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit f3d0bec9f80e4ed7796fffa834ba0a53f2094f7f:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-06-14' into staging (2019-06-14 14:46:13 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 5f6b3561bf58395fd6c906d7064a1a5693a2e426:
>
>   tests/rebuild-expected-aml.sh: blow out difflist (2019-06-16 16:44:44 -0400)
>
> ----------------------------------------------------------------
> virtio, acpi: fixes, cleanups
>
> A bunch of minor fixes all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

