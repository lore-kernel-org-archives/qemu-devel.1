Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3B4C433ED
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D8E2076D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qgsVKRz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D8E2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv0sg-0003Hm-6Q
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv0rI-0001cM-O4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:59:12 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv0rG-0008Ow-Lt
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:59:12 -0400
Received: by mail-ot1-x342.google.com with SMTP id g37so9883138otb.9
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=0mFgljGDAeRnFmVKh7ThMXYFgcKoKBiT39DjrLx+DXY=;
 b=qgsVKRz9EsNrf2zqYbGtLGyj7PnhxA64GPYzvWq8stNjZ6Y4Lwdg2LG2P1B73tJz98
 nHyar99DEHy1PRr+lItoonFON6KC/azrbIMaaiXdesJu/7JHXfE8Grb4UvfMYYwWdgvy
 J8tNA+KZAyXZ3jvs/V0Gi02Z0g2hvxdZe4nnqrCZPDvti1byg8kKd8gfaZWM/NGA4nHV
 zs4RKFegJtRzQSF/tGrF/+A1aDPjp1OKnGyeulmV9xbRyuPG0ui6SMbfn+LwfvR2Ytet
 K03Aa+ZMctzci8Wkw9PbY3slIpos4NqrQiEjwZVA0oET2e84KZ3LCWV1p/vcvgoPHTcd
 aqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=0mFgljGDAeRnFmVKh7ThMXYFgcKoKBiT39DjrLx+DXY=;
 b=AnCzNIRR9TI0BtvUZOVbZSUL55FwpUMO9WMIBGj236IQWeiMHgA3Aq8IcvLWv+nqJ8
 Te6bRtxZ0/YSCOrKLpWqW8kNw8sh87V5ztlGppqKM6l689cRdJRGDnwPHNQrP0hxU6x3
 UJzFziasYMxA5BK/jMusR1v9z7bvY0zGaZD7v4Eux20aCw1Z2kxwqaqO8uu11HzoL6nv
 kP1XVuTbWF+gWoHj0ij/PuIZAbXhhZxUuxwa1kvZtyFZ2r/U6XkBMWJE8SaE5TrtNcmt
 RTYFBPsnkyA9g9s/YLjmsqg4Hb7ugrkkwPLGvmHLQrf+62xDaDTChFqW7nOMYKtQTky1
 CWaA==
X-Gm-Message-State: AOAM533h1tGUqMJ6t4ygiXCt+xBD68K3mOAgdlvNMAX4CMFvA1iYhynO
 WWIRJL6YqvokKJanVsqf8KNaxtIQ7dhg2qYDJN6KkO8o
X-Google-Smtp-Source: ABdhPJzxkKQtpSCtSbr7e69b43TGl560rR10HGKTCzrECtwrgEYUdl7UdvbGq1kcOroqHLnhnGXKrMytVIjS7NhU+tM=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr208510ota.91.1594655948770; 
 Mon, 13 Jul 2020 08:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200713141104.5139-1-peter.maydell@linaro.org>
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 16:58:57 +0100
Message-ID: <CAFEAcA-ULj8BGkm6k2f9ye-ovg9FCKrHg6BRMuKf+F7O3sJtFQ@mail.gmail.com>
Subject: Re: [PULL 00/25] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 15:11, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Last lot of target-arm changes to squeeze in before rc1:
>  * various minor Arm bug fixes
>  * David Carlier's Haiku build portability fixes
>  * Wentong Wu's fixes for icount handling in the nios2 target
>
> The following changes since commit 00ce6c36b35e0eb8cc5d68a28f288a6335848813:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-07-13' into staging (2020-07-13 13:01:30 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200713
>
> for you to fetch changes up to 756f739b1682bf131994ec96dad7fbdf8b54493a:
>
>   hw/arm/aspeed: Do not create and attach empty SD cards by default (2020-07-13 14:36:12 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/arm/bcm2836: Remove unused 'cpu_type' field
>  * target/arm: Fix mtedesc for do_mem_zpz
>  * Add the ability to change the FEC PHY MDIO device number on i.MX25/i.MX6/i.MX7
>  * target/arm: Don't do raw writes for PMINTENCLR
>  * virtio-iommu: Fix coverity issue in virtio_iommu_handle_command()
>  * build: Fix various issues with building on Haiku
>  * target/nios2: fix wrctl behaviour when using icount
>  * hw/arm/tosa: Encapsulate misc GPIO handling in a device
>  * hw/arm/palm.c: Encapsulate misc GPIO handling in a device
>  * hw/arm/aspeed: Do not create and attach empty SD cards by default


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

