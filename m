Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92847C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567A52073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZx14f8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567A52073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYHl-0001Y4-Hr
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYGQ-0000am-Sd
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:15:06 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYGO-0000e6-Fm
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:15:06 -0400
Received: by mail-oi1-x242.google.com with SMTP id k4so2167080oik.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a9v06V1+XrX3+C+l6vH5TCzZOPyiKXb0t5CSeFWvgDw=;
 b=mZx14f8fkSZA+AqtimtgJkQqhD6HdgUhmZNlPhUu71ooynfvJ2jhkqogMFOTcXQGe3
 3VupSrKDydY9DO6qYS2kvBAfU2fYidpKgM9noFmMrotraDqXcgQvJYmmW8aFG3suvmOA
 V1Cafk0fjuertC9u8etMf6Ih/+JOot73cliBigKVDwP9OJ6yOMvyalczNBP0oL3/Hd+W
 l49jZkZl4/b9O/IiBLoYOAsgKR0W56KRkNPuWuRahkWkwx1CHXx8gX+Z/EIfN6BySUEk
 frnaq3ceUmvnM82kg8bI1ScGlwSSQn9m3WAfEeJ0ATPKwXmB69CvwRVhbnlOCEXtVIvu
 z3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a9v06V1+XrX3+C+l6vH5TCzZOPyiKXb0t5CSeFWvgDw=;
 b=guRERaC6R0c0eMIXDYd1lAjb2TJxaTCtn62ojU8/y01AQchpMp8O4a5tJrmFtEyfPG
 X6F3ZCoczXLRPYUrC0tJDaclcLIQfnooOQr4FJsOnb0DfUfkwO5pbyyMbMXJ/Qs+P3sy
 9msdBaa3tZlfTPLA3TTc4HOl7ETpSP0Zwmk21p1GCuY43+22y1ddq2wkXd6dIbmwogMR
 Pj9LTuXb8+dbys0Srjgh0m5dfSwalPoYkdxY/caTujcjJ9uwcSNSFfVJWXBCL1eRKsW6
 /5GpiD/mcHlmzoyKUEPPKdil1oEHU0udiCVg7TwcoMlnsoCr+rTtqtcgkLhVScZFTnNR
 xx3A==
X-Gm-Message-State: AOAM532lJDVtu5NTEyxHVCdk2SUVDxb9a85F3wVfdLI0Dm8tQ4UL60cE
 z3M29xMexW5IRwMFxAbFiZiUOVljeoSk/q5+4pIUlg==
X-Google-Smtp-Source: ABdhPJzWHM5fQzVRaCBcs7znQgXmYkjZI0LpGvheeumpVCYTJ4dOxmZUf4EvkRR9HGA+bpVX69CkPbzi4kumIyazGpc=
X-Received: by 2002:aca:2819:: with SMTP id 25mr454726oix.48.1594307702997;
 Thu, 09 Jul 2020 08:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200704182750.1088103-1-mst@redhat.com>
 <20200704182750.1088103-41-mst@redhat.com>
In-Reply-To: <20200704182750.1088103-41-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 16:14:52 +0100
Message-ID: <CAFEAcA-j5dgjCEEf7jOSYhezvzjQMZ0CiEaJJ8Xv1Zniq4VBZw@mail.gmail.com>
Subject: Re: [PULL v2 40/41] vhost-vdpa: introduce vhost-vdpa backend
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Jason Wang <jasowang@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Lingshan zhu <lingshan.zhu@intel.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 4 Jul 2020 at 19:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Cindy Lu <lulu@redhat.com>
>
> Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> vhost-user. The above patch provides a generic device for vDPA purpose,
> this vDPA device exposes to user space a non-vendor-specific configuration
> interface for setting up a vhost HW accelerator, this patch set introduces
> a third vhost backend called vhost-vdpa based on the vDPA interface.
>
> Vhost-vdpa usage:
>
> qemu-system-x86_64 -cpu host -enable-kvm \
>     ......
>     -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-id,id=vhost-vdpa0 \
>     -device virtio-net-pci,netdev=vhost-vdpa0,page-per-vq=on \

Hi; Coverity reports some issues with this change:


> +static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
> +                              void *vaddr, bool readonly)
> +{
> +    struct vhost_msg_v2 msg;
> +    int fd = v->device_fd;
> +    int ret = 0;
> +
> +    msg.type = v->msg_type;
> +    msg.iotlb.iova = iova;
> +    msg.iotlb.size = size;
> +    msg.iotlb.uaddr = (uint64_t)vaddr;
> +    msg.iotlb.perm = readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
> +    msg.iotlb.type = VHOST_IOTLB_UPDATE;
> +
> +    if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {

Here we write the contents of the struct down the pipe,
but we have not initialized all its fields; specifically,
msg.reserved is not initialized and so those bytes will
be random. We'll also transfer random contents from the
stack in the padding, potentially.

This is CID 1420267.

The easy fix is to zero-initialize the whole struct at the start:

   struct vhost_msg_v2 msg = {};


> +        error_report("failed to write, fd=%d, errno=%d (%s)",
> +            fd, errno, strerror(errno));
> +        return -EIO ;
> +    }
> +
> +    return ret;
> +}
> +
> +static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
> +                                hwaddr size)
> +{
> +    struct vhost_msg_v2 msg;
> +    int fd = v->device_fd;
> +    int ret = 0;
> +
> +    msg.type = v->msg_type;
> +    msg.iotlb.iova = iova;
> +    msg.iotlb.size = size;
> +    msg.iotlb.type = VHOST_IOTLB_INVALIDATE;
> +
> +    if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
> +        error_report("failed to write, fd=%d, errno=%d (%s)",
> +            fd, errno, strerror(errno));
> +        return -EIO ;
> +    }

Same here (CID 1430270)

> +
> +    return ret;
> +}
> +

thanks
-- PMM

