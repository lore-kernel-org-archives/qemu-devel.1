Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A69C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A242388B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxt+2Oh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A242388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIB3-00058k-Dv
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJI1l-0003dC-Rm
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:10:23 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:39214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJI1j-00014y-Dx
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:10:21 -0400
Received: by mail-ej1-x643.google.com with SMTP id p9so8587270ejf.6
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V6CX/vCz8VzkzRHDlh6aMLM6LMfbc6TOM4A3CUaD21w=;
 b=sxt+2Oh3fTfAXau7BMzo5YCOXV2KN1ZBOFUBRqyLDgJ+1Bcsoz5KSfi7P6QGa6UjOM
 ztGrSr1oyNQZ3ZEu7EnqFHYozgV6i4B0DsiEQZM1EfbE8ssMIWy2rFoCd8hpKtY3Ik9M
 FDOLvv4m/MgAW+RScNNIOzQo3RPb6LPJwLnZ7U93864tYui0VlE6J3mV5Ms4WevRykDZ
 u2K6SuqDjL3H2EMCpXcZa6Xx121wiRGCb9w+kAAvqiXbMdl5TguPccpWRmyKXh+84LYw
 MSXf3omizyHgLrnrIGIq5DSM1/pyxNu/hGEb7FfzyxtWKJ4MMdzLcHTCuAHpKXJ+fjTL
 59WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V6CX/vCz8VzkzRHDlh6aMLM6LMfbc6TOM4A3CUaD21w=;
 b=mg6BDwq+uopj6StsZz0mdYphidMQl2Kjv6+nXVcPfs2kEn7zbb+zUvcndw3aKhztI9
 QMw6m6XGJn0n3RLZSezxkU3oRFCyjbAvTjEeKr/jB23SBeGSXYv/Nh3bf1hBM3Ud2r6F
 u2sLofAhzGYa9hhBBG0Id7OuAKAzgQJX1fETTt4harjZ9m2nmXsc0QUr1mdwMSvhOLfE
 T0TtKcb5OHB0hquE1UNR1DAS21RVVY7OZJh8d0mDhzmtMVEvD98RUzERPG7GIEo84MXh
 WmL1LcUA2FKxJlHXjg7bKKqu40vSWrd2dTHqaxcmHuErIETnp/jGdm8juXsBVyTmnSS4
 ozBQ==
X-Gm-Message-State: AOAM531Km81MolSYXHxoMXRZddYYIOcSml4Z4z2fSSQh2niKblsz0UnH
 LJD+2N+jqXrL3uNWKLCo+hBqekJDCuDg66ykpOrHCw==
X-Google-Smtp-Source: ABdhPJyHvTCZZW/C+qwfT/MbYZHc3OSOFWjskmPk0bfNMHQ/Ttl6YZ3N6IEOcJT+Gt2BB2RXoCRMnNFv1vsq2dkcKvI=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr38296212ejv.56.1600441818033; 
 Fri, 18 Sep 2020 08:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200918150506.286890-1-mst@redhat.com>
In-Reply-To: <20200918150506.286890-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Sep 2020 16:10:06 +0100
Message-ID: <CAFEAcA-CxpmJAir0x_h4QovjGs3hcevyxCv8a7o2OuUFrsVcSA@mail.gmail.com>
Subject: Re: [PULL 00/15] virtio,pc,acpi: fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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

On Fri, 18 Sep 2020 at 16:05, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 8ee612722dc08830761516e761dde934c3753a14:
>
>   Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20200915' into staging (2020-09-16 14:47:50 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 4c67a4c6b399c8fadacb0a0b542d6372fd4092f5:
>
>   virtio-iommu-pci: force virtio version 1 (2020-09-18 10:58:09 -0400)
>
> ----------------------------------------------------------------
> virtio,pc,acpi: fixes, tests
>
> Fixes and tests all over the place.
> Batch iommu updates for vdpa.
> Removal of deprecated cpu hotplug commands.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Conflict in hw/i386/pc.c -- can you fix up and resend, please?

thanks
-- PMM

