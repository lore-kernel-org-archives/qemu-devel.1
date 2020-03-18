Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F632C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1062077A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wf7tSuhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1062077A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEfGs-0001AM-T1
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 16:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEfFZ-0007m8-GU
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEfFY-0003kX-4k
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:13 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:41054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEfFX-0003j5-UW
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:12 -0400
Received: by mail-oi1-x229.google.com with SMTP id b17so206600oic.8
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bZkQdV1RAJToKLRBg21j9Qa7EA7q2C8NxxzNAKY5oE8=;
 b=Wf7tSuhnSOzKnLr3Eb9ROqf8ubxsBp/e9j12yQAQ4xVrB0zkhvYjLn1PxzZTEvhXcG
 HqNCsKyoRw7oxJ1OI+CmfGfvvLd41mc7rp6adpMl8J8Hm/3M0vYITtZn4a6M7qFJWD4g
 a+wIlkRlzlOw2La5M2sStSjUjiEYBrqaksIxWSIWEg6oafNZHLjFLo720V5Dgckje4QY
 J/MuRTTw+UMT4UspKbFVz7yfT2csKgDyznPsgT+5UqelzYDoMmLGRRc3Ojy+7vjNj626
 ssFVT4FxP84n7y8v3bUsizMRj7S9Q4ezuMTvSy/A7mQWmZRi2c7JOcQin6lEiLNHO3nL
 HiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bZkQdV1RAJToKLRBg21j9Qa7EA7q2C8NxxzNAKY5oE8=;
 b=kdqY3Eou8n+7eXmIv4DfsS8BqRGBKDCVXf2DzEgr+upLyLL5dbdgbw4Jc71lT4Mdvp
 1N1tFI8ryCQpVQbs2CoaOpB+piQ84hOj9Pc/xgFmhVPL0J52j2eQM0bsqMfmMmGoKAMX
 6ganJx4/8NdwGQqUlKF6k2a0uoNt1ZwYSvodSgS3LhoCQA8CSGEYVoLUNV8bXysPpmG9
 6GbHtksS4Lel8MeBH1g8TDS12mWzRGvqBAwqN0DS6pjyjUa3AGuCdtjaOpiNiCA5XGl1
 ShqntIMZmGA9OYMC7l7bcnIzUCoTdPvSZiR5Hiqmu40gRFQNrE46hJriO0Et1k40oV47
 b8hg==
X-Gm-Message-State: ANhLgQ1/1NGDzXpS9/d/hsoyYpcfkYmThTGEGn2zxqlnhDqA/afyQZY5
 oNZZeDyHnS6/Y0FHMSKJyJk/Q85+JfaCJkM5gc8O2Q==
X-Google-Smtp-Source: ADFU+vtXaGoLg9BSXoZaaKhvhdRFqBMdvNauweYNQ/VrM24IckKnIDL2nf2zACW9dqQsNZ/SC8i6fWg3uQ5IL9vlvPI=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr4510757oib.146.1584563111106; 
 Wed, 18 Mar 2020 13:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200317163343.25028-1-armbru@redhat.com>
In-Reply-To: <20200317163343.25028-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Mar 2020 20:24:59 +0000
Message-ID: <CAFEAcA8R4eXrLSRBB3sQwBXz6XN9OLFf5_dPzx=1UbLHvDM9OQ@mail.gmail.com>
Subject: Re: [PULL 0/4] Error reporting patches for 2020-03-17
To: Markus Armbruster <armbru@redhat.com>
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

On Tue, 17 Mar 2020 at 16:38, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 40c67636f67c2a89745f2e698522fe917326a952:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200317-pull-request' into staging (2020-03-17 14:00:56 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-03-17
>
> for you to fetch changes up to 709dfb64925ed2b2978bf4c17ab98b2c7a9a05c1:
>
>   hw/sd/ssi-sd: fix error handling in ssi_sd_realize (2020-03-17 17:30:03 +0100)
>
> ----------------------------------------------------------------
> Error reporting patches for 2020-03-17
>
> ----------------------------------------------------------------
> Markus Armbruster (3):
>       Use &error_abort instead of separate assert()
>       hw/misc/ivshmem: Use one Error * variable instead of two
>       xen-block: Use one Error * variable instead of two
>
> Vladimir Sementsov-Ogievskiy (1):
>       hw/sd/ssi-sd: fix error handling in ssi_sd_realize
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

