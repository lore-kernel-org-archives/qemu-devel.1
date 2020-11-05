Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAD3C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25862072E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tv8aCbfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25862072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kadB9-0002rK-KA
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kadAA-0002El-Ob
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:10:42 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:44438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kadA8-0001oT-Sp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:10:42 -0500
Received: by mail-ej1-x633.google.com with SMTP id o23so1052676ejn.11
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 03:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9F6pPuViKQ1FO1OcQ/4DM9J2PsGjMQVVxAwaU6R4Wkw=;
 b=tv8aCbfpmeF4CsEC8jIG6xlZMQDkGXVQ1VIy5gTYndXP3uYn4DFuEIMU2BFzBVxfAW
 j9BrmmjN1cbqThA4XEYMCp5ZQamhH2Wyj9TbbM0o7qCjW5zZefq6LDV/gfS5Y71d90ZW
 Y+cDJm+G+GiFYDhb2w911KAav4bASUH803JIAymppUVlkc249Y+PwPOBQ9Lhd8PWdeFC
 q3tcYPYD7iuILvCuyP/Olh4dPss5TTXHcKZl0k9UpUuWP3pNorAnrtERPmxJ1UrpRQs4
 81VPJpyd27TXbegZDKHMkxgixHlafljUEBTnhVdB5NEbp+B8IORKpl18KeOrqpk2fODW
 rhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9F6pPuViKQ1FO1OcQ/4DM9J2PsGjMQVVxAwaU6R4Wkw=;
 b=PPCgbG+JxZe9k42SnU0xopJ8SwhZuuqI4Wh1tmqBXBUxGdjB5IbX4LSf6zPIq/rGPT
 BSWYDxHVCecFMpVQAwjSRhKzy6YyznXl+j+xbA6KTZFBBiEf1mjWDvyxjl94r09ZpsvV
 AXTtdakoqXatF9q7flhZSYPGQcgIw/pWc/0wu4ARydMDYEw2vaFNTpc4oJnu70RhqT0o
 +P/Jd4Jm2cUoMdVJeQSpkMEAWZgoPiAXVx9nAWJHV1c0o2fCBY+DPIYu+Ybijwtz+od9
 rCjlYBU+yz6rEzGNDhhLRyjAom7IFOaQOwTg/r3yFIqF5EbWSZD2ihywXnzBQz4Gdbks
 kd6g==
X-Gm-Message-State: AOAM533XvY8FHUS5pr0sp2Ji5MfxLy73xfDm/qa0VB0HHNzxTJP0cfue
 pBB9WMkrNDOLc/TuVNnrztLJ2GqpEPIY1lRDVW/fYA==
X-Google-Smtp-Source: ABdhPJwlU/zKDMGCDpKQ0+TWW1zqaYQRi9xBXL9nA7Cn6cMNPkC/5d3YT8rYvAGsbY2Z8dtcA1iuqs+lVlA7niy+iOY=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr1659364ejk.382.1604574639020; 
 Thu, 05 Nov 2020 03:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20201104154645.15877-1-kraxel@redhat.com>
In-Reply-To: <20201104154645.15877-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2020 11:10:27 +0000
Message-ID: <CAFEAcA_5c_Ug7KG6NjW9LvqTyqcgfz9pDNU9z+yORkbrCzW5Hw@mail.gmail.com>
Subject: Re: [PULL 0/3] Fixes 20201104 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Wed, 4 Nov 2020 at 15:49, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 3d6e32347a3b57dac7f469a07c5f520e69bd070a:
>
>   Update version for v5.2.0-rc0 release (2020-11-03 21:11:57 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-20201104-pull-request
>
> for you to fetch changes up to 577b808b0974fa4af53131cdfece6e9de3c6e4fd:
>
>   roms/Makefile: Add qboot to .PHONY list (2020-11-04 08:25:17 +0100)
>
> ----------------------------------------------------------------
> misc bugfixes for 5.2
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

