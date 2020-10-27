Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEC9C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 23:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28583207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 23:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnxNei85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28583207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXYdF-0006IW-35
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 19:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXYcS-0005pQ-KZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 19:43:12 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:34893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXYcQ-0006R3-Tf
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 19:43:12 -0400
Received: by mail-ej1-x644.google.com with SMTP id p5so4687525ejj.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 16:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4AQKxe/3fYWR0gmt04iWkPsdYWVb7D+ilPUUb5GKqO8=;
 b=nnxNei85e7SJmX9MDsMbRQqijTHBbFkj/cmuRBrLPm47tcOpCQgRrxX4esZGQDw8oY
 MMMmhC3Z4Ke3DAf5eZ4e1UjdY4/DtjgXyuljVRuJl3PbB5zgN1TRBsxYxYVEvISoFbzF
 sgl155guqvmvwJzF4U4qFiOK+n/WR0N7xavb/IQXyOQnl9WYLnPX/MsfpLeWLlOQAUAM
 EJcchYv+16Ixiv0esdF0AJ0SOpzyDW/VuvplV5/pyzQCsZxYwLjOLqUzEYQoqm4aGyXW
 yj3PCIh1CD7eIdKaWXcw4uLp7GLHDbyBjH9AQ8REmxnNurrl1LKt0UOPM+GIqUuajQKF
 lamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4AQKxe/3fYWR0gmt04iWkPsdYWVb7D+ilPUUb5GKqO8=;
 b=VI8pM/eLrhSmVvnFPYfg4Ve+MVTProHKntyop6sF77E4BG0mLDlNYAzE5etScKVpts
 BurCkv9mS6GJ491STNwSUiPan4BgEXEjaRDpltDtkEKNHrJXsSEBowrSYIx+jwslROI1
 q9KUkhqb9h8mzLXFzd0xr9VmBEdTCzJzXAAPUsxRYTNJJZpXRvA+SQi9VeHzo/SWnHya
 WMJ5bexQUsqDQ3gs+n4R7ZP2fiGeTT9wq+K1hHVTtGJKrpZJnNLDjYd9ZC/aJVS9sTpp
 BaK72K+j+1XHiQpF7iz6yMShTfb9o8+GOUi/QP/EDvyIbtNHCcSCShbDETz2lmSRx2GB
 rh0w==
X-Gm-Message-State: AOAM530ib5nrsLCnx1hNq5PnEooVi2SUnH5zdD42pnUeKEKi5DB0idmt
 7f8Ft2tmJuqRXUhQrKPSB9C2eIqmdRFGkq2U8R8RMQ==
X-Google-Smtp-Source: ABdhPJwZ95RXfRxElswmhyBD/1QxR1Kq1VPZ4/jLKXDeiNe/CifuuzZor3ggnvwZa3pZeVHbatUpFWOpMiHjRCZIFhs=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr4921343ejb.4.1603842189200; 
 Tue, 27 Oct 2020 16:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <160374054442.22414.10832953989449611268.stgit@gimli.home>
In-Reply-To: <160374054442.22414.10832953989449611268.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2020 23:42:57 +0000
Message-ID: <CAFEAcA8yBrUH-Bqe7oNhBKqtyeUNw0xVA9aKm8DJFE-WLzLTwQ@mail.gmail.com>
Subject: Re: [PULL 00/32] VFIO updates 2020-10-26 (for QEMU 5.2 soft-freeze)
To: Alex Williamson <alex.williamson@redhat.com>, Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: Artem Polyakov <artemp@nvidia.com>, Zhengui li <lizhengui@huawei.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Neo Jia <cjia@nvidia.com>,
 Amey Narkhede <ameynarkhede03@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 19:39, Alex Williamson
<alex.williamson@redhat.com> wrote:
> ----------------------------------------------------------------
> VFIO update 2020-10-26
>
>  * Migration support (Kirti Wankhede)
>  * s390 DMA limiting (Matthew Rosato)
>  * zPCI hardware info (Matthew Rosato)
>  * Lock guard (Amey Narkhede)
>  * Print fixes (Zhengui li)

I get a conflict here in
include/standard-headers/linux/fuse.h:

++<<<<<<< HEAD
 +#define FUSE_ATTR_FLAGS               (1 << 27)
++=======
+ #define FUSE_SUBMOUNTS                (1 << 27)
++>>>>>>> remotes/awilliam/tags/vfio-update-20201026.0

I assume these should not both be trying to use the same value,
so something has gone wrong somewhere. The conflicting commit
now in master is Max's 97d741cc96dd08 ("linux/fuse.h: Pull in from Linux").

Can you sort out the correct resolution between you, please?
(My guess is that Max's commit is the erroneous one because
it doesn't look like it was created via a standard update
from the kernel headers.)

thanks
-- PMM

