Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0746BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E1022227
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DA2f5Aej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E1022227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb3FV-0006zI-6y
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 10:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3EV-00066k-3A
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:00:55 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:34774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3ES-0007vA-4w
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:00:54 -0500
Received: by mail-ed1-x52e.google.com with SMTP id a15so1589438edy.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 07:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+zfoH1yivZLj4TQW5zFA8HwAp42huZ1S0ZMFVnRsdec=;
 b=DA2f5Aej5paRbTBJHXLmWRt04WY1fJl/0zIWUVdqb2s2/1aDZiy4SFLS3Y1OCouuCP
 qflwk3VqzSd2/o5RT/6Vet45z5w7HMaX6Tht2PiuNvRXnbU9bsCm7jNqbxUb6ftDW5IM
 0Cg15W03ATBK6gmqlff2W4BGSpNYZ2OmSD9X84TmiZh/Zwg24f8im+BsYJdkP4rxQiPi
 Th6JRbhw8CxbsZ7KtIgTsE1yKOAg+3L5/1UhtBuBgxOI5j3oZOhOGhf4WMT0HHkLg2uw
 m29mG7WcbTaWM+Ppbeiw9xGdpQWRvD1i9pb9QDhrrwUWB06FQGhhGSRm4wTr/WErCErx
 tSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+zfoH1yivZLj4TQW5zFA8HwAp42huZ1S0ZMFVnRsdec=;
 b=pu3ahMe3/eDEXIDVbPL6lLzA0EjqONr8K6kgDA79vnfNRvKa0Micoywsg2ra+tcgio
 251li+YdU613HW++LHFk8LRYPoGmvMCoyVO2CUGdsLcZb+fFNGF/sjgju3DA7aqEx1QL
 4BIuZte2qu4zkSdVvYG3wltX/TvWsiTtOKuD8rPvgTxZcw684/Pmn/m1CuUmEZyLae52
 fX/IuY0jDu0Yy6ch9I6HSIHKNdizipZPGMwaKHnb+p4qRzbieVfayVn/NaRAFzpFcNeP
 KXyIPtIShKLAex9Sj/105aCfgadSmXexbepBCsV7lFYwKT7Qc1j+9csECK7zTx7SEZyE
 YjpA==
X-Gm-Message-State: AOAM531B0Tjx4LIZLWO7fBQkyV6kdmmfOGrxSf1hJKSig3ah2yHuvDmP
 zXp5d95mD/OdM7l1coqjZ+E+9ic8p0c9Ci5NVTJisA==
X-Google-Smtp-Source: ABdhPJz6u96NXq4AolWxszeEyIzzMYtBeX/QVvBkjla7YGFm5/FkqotbnWWQ1FGl+HzTjR13eT8bq/JlRf336QtMzZQ=
X-Received: by 2002:a50:fc87:: with SMTP id f7mr2489651edq.36.1604674848602;
 Fri, 06 Nov 2020 07:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20201106131252.953499-1-cohuck@redhat.com>
In-Reply-To: <20201106131252.953499-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 15:00:37 +0000
Message-ID: <CAFEAcA8E2SfPwag5aQOfuDsez7UoVJdn9fBCwD7g64HzKow_VA@mail.gmail.com>
Subject: Re: [PULL for-5.2 0/4] s390x fixes
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 13:13, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 3d6e32347a3b57dac7f469a07c5f520e69bd070a:
>
>   Update version for v5.2.0-rc0 release (2020-11-03 21:11:57 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20201106
>
> for you to fetch changes up to 77280d33bc9cfdbfb5b5d462259d644f5aefe9b3:
>
>   s390x: fix build for --without-default-devices (2020-11-05 13:04:07 +0100)
>
> ----------------------------------------------------------------
> some s390x fixes, including a bios update
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

