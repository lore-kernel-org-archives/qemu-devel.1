Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6694C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CAD206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vfquCY+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CAD206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrI6-0001HW-ND
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kCr9e-0007Qz-8K
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:54 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:46405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kCr9b-00018b-Cs
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:53 -0400
Received: by mail-ej1-x633.google.com with SMTP id d11so10331499ejt.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0UQ6VTEVRfIanwC4eNvtEZrLMZBMokRT3Vp3FLp0O84=;
 b=vfquCY+YMA8g0V+v0ySfPZqnpt9o+IuZC3/l4dtsLKg04tvKrLCgIYWQusef5p27PP
 rV0ZVWa5kofpDpC74+KtKdc67vfb4WN2YOgaOuJgEc9vhB0OYeHicBpF1LR2cwIpo2f3
 nHAMSTP/zPAstLa0mFlCrlCMSomXSQmPQIm5xD6DokAYjS0C3I5e4PiJwGq7WArX4ISc
 j7Ij0mKqt8EN1qDJgT89a8hGwfBdh52e1whFzT/L2rm+AroFf/InIWPOC5Pj8o3bFPVF
 K6Wm1GcN94oj9sKxqxrAH7QmfkjA6/mD/z1m7fXX5w8rEXExGI42LgRSA0d+v2v5Whgk
 JpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0UQ6VTEVRfIanwC4eNvtEZrLMZBMokRT3Vp3FLp0O84=;
 b=FSgucJbH8+0c40GZorRnci+t+UPOSROfu+UiBY1myaEdlMKNQ7ci3W0SqxQUjzcoqV
 FW4yXzWldGAa1TW7m8kjrfevbBgSkBVFnOzz9TknsHE3NkVzXNHXehJKT204OL7pKOkL
 U3nnvlxUNC5ujiCUUoQ/nuQgSRpYXOkilOMSgFl8HNpZ/swTHaCkdK6ii6+9e0JhdlxX
 JNwQppWHchpmeGoLoCklfFqgHXpV+VaSVL29Km3ZGV2y3QLmaUgsESrKoohXZ8lXEmzD
 vG/u/MVgbvkJYlmBWN1zsnbJVtDdoB6G0zonG0Z4EZ9hlcdZtyXfRNU1/N/WXuCWqZfN
 8Y5Q==
X-Gm-Message-State: AOAM5304T838ocHEGjW3SXrlzmZB/0bnsCdXubkKnmGlzZhuVkKjFqq2
 wmcrMNFL6ky+iTGF7nxussrjmyUQ/AWJt6/vgvCsBg==
X-Google-Smtp-Source: ABdhPJyXRE/o1y7FsKTdDmg5v85WY12AzfQ1T78falyQwM/aOd9UktSS9eS72N+cNwfIFcNdFgDgy2CO1pJgA8epUWM=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr2611458ejb.382.1598908548556; 
 Mon, 31 Aug 2020 14:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200831083301.6357-1-kraxel@redhat.com>
In-Reply-To: <20200831083301.6357-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Aug 2020 22:15:34 +0100
Message-ID: <CAFEAcA8=rifbVy9Dnbr+m77p7Kb1NDTaOrQU8iT0FRGB86Y36w@mail.gmail.com>
Subject: Re: [PULL 00/18] Usb 20200831 patches
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 at 09:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3a3e0:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pull-=
> request' into staging (2020-08-28 22:30:11 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20200831-pull-request
>
> for you to fetch changes up to b946434f2659a182afc17e155be6791ebfb302eb:
>
>   usb: fix setup_len init (CVE-2020-14364) (2020-08-31 08:23:39 +0200)
>
> ----------------------------------------------------------------
> usb: usb_packet_map fixes for ehci and xhci.
> usb: setup_len fix (CVE-2020-14364).
> usb: u2f key support (GSoC).
>  * v2: 32bit build fixed.
>  * v3: libu2f-emu dependency fixed.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

