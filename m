Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FD7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6352620890
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGBkctkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6352620890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0cD-0004hr-N7
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 10:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jr0bI-00041P-O4
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:54:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jr0bF-0005RT-Qy
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:54:08 -0400
Received: by mail-ot1-x343.google.com with SMTP id g37so585567otb.9
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i2xnCmnpS0//vm/HBEMJRvhX+TI+s9J1c5u0sgNUY4A=;
 b=cGBkctkFNaTh6z4cEfW4qJqKdb0PSJJblBUROlKAe8ERXDv44qyeP0lo1KZhGRiVbR
 SaI9Rb95zR3sRIPOr7JnpOIKrs5nva3nY5M5847GoL3YZBO/64v2CERyDTqL730D6+Sd
 Ggz5rg17WJVDWFMGrNPj0uwkczb+HeKcBVX3ictS/Q0fNLtlbsaoJQJWcCxY8QKphqNS
 FDHVAF8HbO7HTjfgFY6X4joP1Ez6DKL8yLEscIRFNYU/A0tlppjVci9EN8aHTxfPDqSX
 5RTHOlemmJraaM0kdjK/mGekpbFmU7BeDkFEDUQVsV+ezEYcS5auC9Bj+O6jWufjYHNW
 eHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i2xnCmnpS0//vm/HBEMJRvhX+TI+s9J1c5u0sgNUY4A=;
 b=chmyfLQNRf+iaRoSJ0eBjMyKWVrY6zCgRCShGGjUlwXLwv12TXBwUNWlMinbHLKluK
 JAr8uzsURwRwKCjAiLrgWRP+9avobWAs/CjeIkBrOZ0gZrBmjaQ6894nwpIDSRoA72g/
 s8wcB8WdtxHS+RFe6lwpTBgFWyoeP/0RSjXb9nvvhu8tgtj957t/tE8ukrHMjOusWJXA
 Qpuihwv6m3o3N9iNlO7hevpDoztcX78lj0CjhskPyypsazXrlpykaoxPQ2GvDIrjPX2g
 kfamP5j/qz/qPXvm1gx9thrJdTA3byWQhDUBAGRYJC3riSSO7FvtoIjVHX6HjSWgaR+Q
 hS6Q==
X-Gm-Message-State: AOAM531F9NfKTAKZNY/CImUjSqIEECsa7LeY/WJyDJCyye3QZxujaSW6
 K/W11nZa3M+5f6bvPAac85iRcFxzm8/tb4vX7co4AQ==
X-Google-Smtp-Source: ABdhPJwWDQQpBfg6j11qckTIOTuy0CLRItT5bHOBMaDA3b/7fvyZi9ChrZrHyQfRrHm+k9ry0Q3XH8yTXRzlq9uVHuo=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr20757381otk.221.1593701644250; 
 Thu, 02 Jul 2020 07:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200701150425.13739-1-kraxel@redhat.com>
In-Reply-To: <20200701150425.13739-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Jul 2020 15:53:53 +0100
Message-ID: <CAFEAcA-TjU=eLEBRcc-yPe6oFvhzMNtRp+iQzWPmnmXx5u4NbA@mail.gmail.com>
Subject: Re: [PULL 00/13] Vga 20200701 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Jul 2020 at 16:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
>
>   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20200701-pull-request
>
> for you to fetch changes up to 8db2a4fd8abf6550479f7a8caa8f655c34238d6a:
>
>   configure: vgabios cleanups (2020-06-30 22:54:47 +0200)
>
> ----------------------------------------------------------------
> vga: bugfixes for ati and sm501, vgabios cleanup.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

