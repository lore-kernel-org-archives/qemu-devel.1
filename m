Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECD7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE5D206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luLN5QAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE5D206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslyr-0004o4-I0
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 07:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsly1-0004Ml-K1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 07:40:53 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jslxz-0000Dx-V8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 07:40:53 -0400
Received: by mail-oi1-x244.google.com with SMTP id l63so33181096oih.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6hKK0pPuh8CecxBqlkjR3ganqcN3m0licd12d2QR7CI=;
 b=luLN5QAuAzEuuPi8sza1j/xzGagzmdlUjFANof2WYeILdiY3vvSv6BL2wkY+idbbMN
 dfw9bdJ6lMsgfE1pIhObr0IkBqJ7VFGyty1dhlzMYswijoR5ZXeFZddIr1fsYZDAlm+Z
 Io2MOIH9ipyfJvV4xhfrUnkS2Mcr/zty3gjzm6hfOBn4nlsSm1kQ/rfBp0HFJTV5g5li
 PYmaPWZVXMhufHwmMU/+oLLCpmrvDcislonib9V5THTO7gREdyVKZ8M3og2FTsAuy4Rg
 Ulwtg5sy6nTwVo5hGoMc2E4KUjdwAMrOVAMqJjyQRMH2Ivj5BrM2YPJVRObBLGFlCJk4
 hYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6hKK0pPuh8CecxBqlkjR3ganqcN3m0licd12d2QR7CI=;
 b=P780KS/1XVK456bBLBLloAAb07kC61GF9Nl179Q8zsPCHfcTIjko0ZCjXK0Y6b+0fK
 PKPHBsSK2D70iObaGawqq+w9BAVPHSsbWkPu2QFinFb5FiCNQuYam6QpuYE+X5lALAZJ
 JcfYI3KnYG44TZbmVprl16kNv3nFKbrrezChaxr1itnocGGChUE84JIT57pGuC4JTgVV
 6qW85GJmdx1hdFZ3+D+PjuPdTHw2Yh0GNLXpJp03GrHlih8vn1FofVdFTfUPqq57T7AE
 NR1yKMMJXjcTxx/ZUh8e4bAxN/r7cCobxsDOU4L95ldWnVDTLRHuqRgoQlzJNyd0ddCl
 TZfA==
X-Gm-Message-State: AOAM531a8uETB2xcf91wV5iLF44v+BulUt2ng833Uq86bKDkZx9ZpLQm
 Mh4mkpdgnjUv808kF4zaYqIcVm4bL2UwSZD21uSAAQ==
X-Google-Smtp-Source: ABdhPJwa9+2ejcHxHKuMOOi0hmqm0TSyvlX39JNcZFtXLKa5Q83zUvTch2w+HbUBT+J/rIQZYd2Zegm3ECPOr+F5hiw=
X-Received: by 2002:aca:2819:: with SMTP id 25mr2686191oix.48.1594122050690;
 Tue, 07 Jul 2020 04:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200704182750.1088103-1-mst@redhat.com>
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2020 12:40:38 +0100
Message-ID: <CAFEAcA_LrhvLmbwsSrhHUYZ+z9EZoDZwct+s3xfoaGLyLkOPfg@mail.gmail.com>
Subject: Re: [PULL v2 00/41] virtio,acpi: features, fixes, cleanups.
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Sat, 4 Jul 2020 at 19:29, Michael S. Tsirkin <mst@redhat.com> wrote:
>
>
> v2 of the pull, fixing non-Linux builds.
>
>
> The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
>
>   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to f7d98068bf7a0913744dd4ac0a28e8c841df2af5:
>
>   vhost-vdpa: introduce vhost-vdpa net client (2020-07-04 11:13:50 -0400)
>
> ----------------------------------------------------------------
> virtio,acpi: features, fixes, cleanups.
>
> vdpa support
> virtio-mem support
> a handy script for disassembling acpi tables
> misc fixes and cleanups
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Hi; I'm afraid this fails to build on 32-bit:

/home/peter.maydell/qemu/hw/virtio/vhost-vdpa.c: In function
'vhost_vdpa_dma_map':
/home/peter.maydell/qemu/hw/virtio/vhost-vdpa.c:48:23: error: cast
from pointer to integer of different size
[-Werror=pointer-to-int-cast]
     msg.iotlb.uaddr = (uint64_t)vaddr;
                       ^

This should probably be "= (uintptr_t)vaddr".

thanks
-- PMM

