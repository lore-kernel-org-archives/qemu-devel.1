Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24027C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 19:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678BF208E4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 19:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbHyfH5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678BF208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZIgR-0003lc-DN
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 14:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZIfb-0003Eg-Fs
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 14:05:39 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:32769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZIfY-0007wi-Vh
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 14:05:39 -0500
Received: by mail-ej1-x62e.google.com with SMTP id 7so15692119ejm.0
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 11:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2pyT2Y5H9CSJSZhAQQWv2AmWpVdl61TMS1tj9FpI76U=;
 b=xbHyfH5W2ufGmBnbhh9hoMBlzF1MFGBqm6Sib/WMJ/MRtXP7zqs4/bU3P/Sq14pOpd
 2ojSDmOeMtOgGQUVJVvvAp6nTTqbKu0rDv2xKOiyv5d/aM00wqKFJIaz6O2aawY+yv61
 HK0w0FaToBVFBJKeHR2IqxuB+fn9o4D41AOhRaZaQaoEm+U0o765+xihbfRYw8fzDRKG
 Vx8DVRgnDXObem1SzqaaD+k55gpjrkArfm/oZFokIoIsTvdBBXFePP8OinEmEOSuNbIj
 FX5yEepu3ApAIFS/c2rHvoZOQYfD33+74VgRWMf/Q933xQSlbyGecqMW3AIU+OmPFZ2h
 VkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2pyT2Y5H9CSJSZhAQQWv2AmWpVdl61TMS1tj9FpI76U=;
 b=rjw/lZhMLcXG1r4rHxEpotjkCrOUcfOlX3EaBjeXal8VBQvBywxAYTu165MUWISQqL
 iVI7RSar0+OLcbYaUygRqopvibMgQ+srYpHpinVUw7YAB6zojPurXEV74H5eZ/uFXy1Z
 XbsVfPCa/Mpkatz5Vo8xzXYBrBMrab6tks08jNj7IXvd2HfNgMHTuhhV0jBTcChKv1XG
 5zqP2K59om76woLXAt+QwWlnWLQbl7+A7nT7TohA9TPKQw2i0lHIJFj90yJOwQ4D5wFR
 gjM04Noum/jyzV3EwdmQN4wXNxy295CWZAlKird8+zeeEn64KlyN+Vw8DyS46A1Dos4j
 hb7Q==
X-Gm-Message-State: AOAM532GmkQY2gnOAnXFMtO2CijJigdf85QV79z5A1bvMDTl2EBbGGaD
 LA3R8IjkTEWK8Qz4go8E29XeX4q+OljEMdy21PKYjQ==
X-Google-Smtp-Source: ABdhPJz4U4p+hdpJX+T0wR1X4CfM7H4EmMP0/3+Ce0akydramK7L1/85HwLqAwxOHTFka7MEHriqJFxqPWteYJwYvyQ=
X-Received: by 2002:a17:907:9e3:: with SMTP id
 ce3mr12320308ejc.4.1604257534748; 
 Sun, 01 Nov 2020 11:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20201030141136.1013521-1-mst@redhat.com>
In-Reply-To: <20201030141136.1013521-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Nov 2020 19:05:23 +0000
Message-ID: <CAFEAcA93GGtoh5yie7x1BuTazpHe6iosJN7Osqwi5ni0mGDd+A@mail.gmail.com>
Subject: Re: [PULL 00/15] pc,pci,vhost,virtio: misc fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Fri, 30 Oct 2020 at 14:11, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 802427bcdae1ad2eceea8a8877ecad835e3f8fde:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201027-1' into staging (2020-10-29 11:40:04 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 73beb01ec54969f76ab32d1e0605a759b6c95ab0:
>
>   intel_iommu: Fix two misuse of "0x%u" prints (2020-10-30 06:48:53 -0400)
>
> ----------------------------------------------------------------
> pc,pci,vhost,virtio: misc fixes
>
> Just a bunch of bugfixes all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

