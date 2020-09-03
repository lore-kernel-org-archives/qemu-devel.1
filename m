Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD4DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 04:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E2C20758
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 04:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnFGZ1/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E2C20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDhEO-0001Wl-3b
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 00:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kDhDo-00017V-AN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 00:51:40 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kDhDi-0000aZ-NG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 00:51:38 -0400
Received: by mail-ot1-x341.google.com with SMTP id c10so1444644otm.13
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 21:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tAG4OLYHGwe3S4AqZj+sxwJwcT3poL9xrVG48K+h9JM=;
 b=PnFGZ1/O4gdSSi0aB5h5zS7+gcozobR962nHxDutaANuOcM8A9WzUBhFMY81lu0OC/
 rP/6vX7WgWac6wqPVrE5x3qAQN5dLlzCeoHbNKW/ssF92H4JnhCYtdF0bZ146nfc7lbP
 k6qrPcCxSe0pSw4RSRv9Rck+jiRBly/oJ1i+JWbaQRse9Yeird257K1lYpkLwlsdWgFR
 nBA86Hd36OHlYTzAtmgpNpYoKHK68FfEFPa94up0Dik68Cng088Djf1aR/tZuC3dFK8s
 DK94QP/Z11P8J33Av/cl5W8nWPIzkazbM8vt3kagp2qD/kQCubUAQGJulwzMi7oEDVTh
 XF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tAG4OLYHGwe3S4AqZj+sxwJwcT3poL9xrVG48K+h9JM=;
 b=FqnWFw5XSOiDbTENOBuxPOjDfqFwuLAybMBGfCsXcRKzgkp/tKCo6tiVP6YlZQEjQ7
 peweaNemGxMRhUZLxc5noqpBys2pqzuSwZMa/2VvR1tuqKY5z6BnRwO6B2XA+uHZAICD
 o0f0n5fnOOIWil6TqUxgMCmljAKZnlJw/SX/rhH3pdAliZ92iX4BE3PL93663WLmtUxd
 xooA9ytwiJj3m9mQ8ok+g86HsJ8hVJjHkvTF/4DKJKVPrsx5emphr8KMyNDDbAoIwF7U
 q30HDUcUKpP2hZlfnuBg+WYpV60IkR7oFfuw3o/ZlhBHfgLEhBsz5uHjWk01N/cml6/Q
 dvOQ==
X-Gm-Message-State: AOAM5331ibQlfNIwEvLbjY8pizyrglgN/m/4jiBnhM6u+XdtlP/OabLD
 PZlesqHmYUJRoCotsfzpI6///uFeevWE7kKfSzI=
X-Google-Smtp-Source: ABdhPJxkm7FLJQ6Ll6Tvk8Ds61be7qDmbRNjnlS9HJdg5l3W1Ifm0BFvS4kG+IUvV7PBv4+mo2WPe3zUudMz4YK/mxo=
X-Received: by 2002:a05:6830:610:: with SMTP id
 w16mr232669oti.353.1599108692031; 
 Wed, 02 Sep 2020 21:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200902162206.101872-1-liq3ea@163.com>
 <b840aab8-542d-af43-43e5-0a07f442b5d5@redhat.com>
 <20200903040611.fjam4nwqopec723y@mozz.bu.edu>
 <801411e4-e847-6d79-fc54-7cdd692b9c43@redhat.com>
In-Reply-To: <801411e4-e847-6d79-fc54-7cdd692b9c43@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 3 Sep 2020 12:50:56 +0800
Message-ID: <CAKXe6SLB280LqvMzfMbRvMNff6Yt21unVpCs7TygF_bSPCTe8w@mail.gmail.com>
Subject: Re: [RFC 0/3] try to solve the DMA to MMIO issue
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=883=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8812:24=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 2020/9/3 =E4=B8=8B=E5=8D=8812:06, Alexander Bulekov wrote:
> > On 200903 1154, Jason Wang wrote:
> >> On 2020/9/3 =E4=B8=8A=E5=8D=8812:22, Li Qiang wrote:
> >>> The qemu device fuzzer has found several DMA to MMIO issue.
> >>> These issues is caused by the guest driver programs the DMA
> >>> address, then in the device MMIO handler it trigger the DMA
> >>> and as the DMA address is MMIO it will trigger another dispatch
> >>> and reenter the MMIO handler again. However most of the device
> >>> is not reentrant.
> >>>
> >>> DMA to MMIO will cause issues depend by the device emulator,
> >>> mostly it will crash the qemu. Following is three classic
> >>> DMA to MMIO issue.
> >>>
> >>> e1000e: https://bugs.launchpad.net/qemu/+bug/1886362
> >>> xhci: https://bugs.launchpad.net/qemu/+bug/1891354
> >>> virtio-gpu: https://bugs.launchpad.net/qemu/+bug/1888606
> >>>
> >>> The DMA to MMIO issue I think can be classified as following:
> >>> 1. DMA to the device itself
> >>> 2. device A DMA to device B and to device C
> >>> 3. device A DMA to device B and to device A
> >>>
> >>> The first case of course should not be allowed.
> >>> The second case I think it ok as the device IO handler has no
> >>> assumption about the IO data came from no matter it come from
> >>> device or other device. This is for P2P DMA.
> >>> The third case I think it also should not be allowed.
> >>>
> >>> So our issue has been reduced by one case: not allowed the
> >>> device's IO handler reenter.
> >>>
> >>> Paolo suggested that we can refactor the device emulation with
> >>> BH. However it is a lot of work.
> >>> I have thought several propose to address this, also discuss
> >>> this with Jason Wang in private email.
> >>>
> >>> I have can solve this issue in core framework or in specific device.
> >>> After try several methods I choose address it in per-device for
> >>> following reason:
> >>> 1. If we address it in core framwork we have to recored and check the
> >>> device or MR info in MR dispatch write function. Unfortunally we have
> >>> no these info in core framework.
> >>> 2. The performance will also be decrease largely
> >>> 3. Only the device itself know its IO
> >>
> >> I think we still need to seek a way to address this issue completely.
> >>
> >> How about adding a flag in MemoryRegionOps and detect the reentrancy t=
hrough
> >> that flag?
> > What happens for devices with multiple MemoryRegions? Make all the
> > MemoryRegionOps share the same flag?
>
>
> I think there could be two approaches:
>
> 1) record the device in MR as Qiang mentioned

I have tried this as we discussed. But has following consideration:
1. The performance, we need to check/record/clean the MR in an array/hashta=
ble.

2. The multiple MR and alias MR process in the memory layer. It is
complicated and performance effective.
So If we let the MR issue to the device itself, it is just as this
patch does-let the device address the reentrancy issue.f

Another solution. We connects a MR with the corresponding device. Now
the device often tight MR with an 'opaque' field.
Just uses it in the calling of MR callback. Then we add a flag in the
device and needs to modify the MR register interface.

So in the memory layer we can check/record/clean the MR->device->flag.
But this is can't address the DMA (in BH) to MMIO issue as the BH runs
in main thread.

Thanks,
Li Qiang



> 2) Only forbid the reentrancy in MMIO handler and depends on the device
> to solve the multiple Memory Region issue, if the regions want to access
> the same data, it needs to be synchronized internally
>
> But the point is still to try to solve it in the layer of memory
> regions. Otherwise we may still hit similar issues.
>
>
> >
> > What about the virtio-gpu bug, where the problem happens in a bh->mmio
> > access rather than an mmio->mmio access?
>
>
> Yes, it needs more thought, but as a first step, we can try to fix the
> MMIO handler issue and do bh fix on top.



>
> Thanks
>
>
> >
> > -Alex
> >
> >> Thanks
> >>
> >>
> >>> The (most of the) device emulation is protected by BQL one time only
> >>> a device emulation code can be run. We can add a flag to indicate the
> >>> IO is running. The first two patches does this. For simplicity at the
> >>> RFC stage I just set it while enter the IO callback and clear it exit
> >>> the IO callback. It should be check/set/clean according the per-devic=
e's
> >>> IO emulation.
> >>> The second issue which itself suffers a race condition so I uses a
> >>> atomic.
> >>>
> >>>
> >>>
> >>>
> >>> Li Qiang (3):
> >>>     e1000e: make the IO handler reentrant
> >>>     xhci: make the IO handler reentrant
> >>>     virtio-gpu: make the IO handler reentrant
> >>>
> >>>    hw/display/virtio-gpu.c        | 10 ++++++
> >>>    hw/net/e1000e.c                | 35 +++++++++++++++++++-
> >>>    hw/usb/hcd-xhci.c              | 60 ++++++++++++++++++++++++++++++=
++++
> >>>    hw/usb/hcd-xhci.h              |  1 +
> >>>    include/hw/virtio/virtio-gpu.h |  1 +
> >>>    5 files changed, 106 insertions(+), 1 deletion(-)
> >>>
>

