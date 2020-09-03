Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E925C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B0020737
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuiuBB5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B0020737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDikh-0007Z0-F4
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kDik8-00078H-EL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:29:08 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kDik6-0003XS-3O
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:29:08 -0400
Received: by mail-oi1-x241.google.com with SMTP id x14so1966175oic.9
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 23:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=coW6mEXkbJIZpGedgRHKkaohcq/+ycRzMPWZhVtpfjc=;
 b=FuiuBB5OkgJDAbg65TPJCGEu8DoTaBhZEf8tJ1e5z88UI3qA46KjIEIrx9KR51aCmV
 2FCb2W2JS7TNDyrzJcinlxf7pKJ6cpoHy+J+2y1pd7pNq7wdqGsHKqB64A4kjnY8PU9h
 2/pNqutISbUmCy/oy5mZ+ms3Wr9uRI+PIBxmKG5+74Nb5DpJzS8uTHtZVm4Skw7r5MMT
 +WXlN9dGn4p8ed8JbdXeF5pqjQULYLRjMcqj7ALCIEgyR16mcwkfazrqh06YG8Smpw0E
 RmRpVG0V7MwvlTxsmDCGurz45syzujks0Dy5TfJH7YeESDmCn9JJOv3DX6xUPbdYRR2a
 sJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=coW6mEXkbJIZpGedgRHKkaohcq/+ycRzMPWZhVtpfjc=;
 b=rCaw0U17A2sAnw6Yu7AskRHTCRkoJLQk8J/UtDyhnimdqW5QmKnB+pRX/OmpQlPlqo
 Rp9UBty7pX5oH5IzKWbEDM5mEyx2kk3hiZXjwsXfv8bzS96oSHrV/yv0zVw1UR66CsAS
 Q++Zwnw2PkKz6Qc6UdPWwcbem4C/TtFsq7uugcF30IjHkX98hW3hd1gR9X6webVy/3xu
 Uxl5GZgJn0h5uaMHIiN7jl8GNYSJFbB9DUMVQHEhgxEYX1IdP0Z1Y+t2ex4IHlLeRvy5
 J3AmKGP99Zmj+nB0B8LaC9tvjFY/ktGOOMYoHz8WTBQD7FSwwTNgTFvDXOdYEMxG9Gsl
 q3tQ==
X-Gm-Message-State: AOAM533O7gR9zlRvq4N2AgePnCu/A8biKD6KdzcePK0K0fBP4M/Vp99R
 svQPEp1JFMx5xPeRkNDt0Zqj1YQslbbbRUM5wxc=
X-Google-Smtp-Source: ABdhPJyJUDLEq8GWXawgJeZUuh/IaEpNCrITYC/IQRhVZOwzk9udmSCFjUTpJBsZD4rg/ldleLwYsqc9qn0Uqi0MzS0=
X-Received: by 2002:aca:1117:: with SMTP id 23mr1128074oir.97.1599114544745;
 Wed, 02 Sep 2020 23:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200902162206.101872-1-liq3ea@163.com>
 <b840aab8-542d-af43-43e5-0a07f442b5d5@redhat.com>
 <20200903040611.fjam4nwqopec723y@mozz.bu.edu>
 <801411e4-e847-6d79-fc54-7cdd692b9c43@redhat.com>
 <CAKXe6SLB280LqvMzfMbRvMNff6Yt21unVpCs7TygF_bSPCTe8w@mail.gmail.com>
 <b6c01013-7b26-5da2-ba8b-401ff3e58256@redhat.com>
In-Reply-To: <b6c01013-7b26-5da2-ba8b-401ff3e58256@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 3 Sep 2020 14:28:28 +0800
Message-ID: <CAKXe6SKMzWTy_Wcy7iWEjFBwUVwUj_+N0fGZLVY1U42Da+em0A@mail.gmail.com>
Subject: Re: [RFC 0/3] try to solve the DMA to MMIO issue
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
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
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=882:16=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 2020/9/3 =E4=B8=8B=E5=8D=8812:50, Li Qiang wrote:
> > Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=883=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8812:24=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2020/9/3 =E4=B8=8B=E5=8D=8812:06, Alexander Bulekov wrote:
> >>> On 200903 1154, Jason Wang wrote:
> >>>> On 2020/9/3 =E4=B8=8A=E5=8D=8812:22, Li Qiang wrote:
> >>>>> The qemu device fuzzer has found several DMA to MMIO issue.
> >>>>> These issues is caused by the guest driver programs the DMA
> >>>>> address, then in the device MMIO handler it trigger the DMA
> >>>>> and as the DMA address is MMIO it will trigger another dispatch
> >>>>> and reenter the MMIO handler again. However most of the device
> >>>>> is not reentrant.
> >>>>>
> >>>>> DMA to MMIO will cause issues depend by the device emulator,
> >>>>> mostly it will crash the qemu. Following is three classic
> >>>>> DMA to MMIO issue.
> >>>>>
> >>>>> e1000e: https://bugs.launchpad.net/qemu/+bug/1886362
> >>>>> xhci: https://bugs.launchpad.net/qemu/+bug/1891354
> >>>>> virtio-gpu: https://bugs.launchpad.net/qemu/+bug/1888606
> >>>>>
> >>>>> The DMA to MMIO issue I think can be classified as following:
> >>>>> 1. DMA to the device itself
> >>>>> 2. device A DMA to device B and to device C
> >>>>> 3. device A DMA to device B and to device A
> >>>>>
> >>>>> The first case of course should not be allowed.
> >>>>> The second case I think it ok as the device IO handler has no
> >>>>> assumption about the IO data came from no matter it come from
> >>>>> device or other device. This is for P2P DMA.
> >>>>> The third case I think it also should not be allowed.
> >>>>>
> >>>>> So our issue has been reduced by one case: not allowed the
> >>>>> device's IO handler reenter.
> >>>>>
> >>>>> Paolo suggested that we can refactor the device emulation with
> >>>>> BH. However it is a lot of work.
> >>>>> I have thought several propose to address this, also discuss
> >>>>> this with Jason Wang in private email.
> >>>>>
> >>>>> I have can solve this issue in core framework or in specific device=
.
> >>>>> After try several methods I choose address it in per-device for
> >>>>> following reason:
> >>>>> 1. If we address it in core framwork we have to recored and check t=
he
> >>>>> device or MR info in MR dispatch write function. Unfortunally we ha=
ve
> >>>>> no these info in core framework.
> >>>>> 2. The performance will also be decrease largely
> >>>>> 3. Only the device itself know its IO
> >>>> I think we still need to seek a way to address this issue completely=
.
> >>>>
> >>>> How about adding a flag in MemoryRegionOps and detect the reentrancy=
 through
> >>>> that flag?
> >>> What happens for devices with multiple MemoryRegions? Make all the
> >>> MemoryRegionOps share the same flag?
> >>
> >> I think there could be two approaches:
> >>
> >> 1) record the device in MR as Qiang mentioned
> > I have tried this as we discussed. But has following consideration:
> > 1. The performance, we need to check/record/clean the MR in an array/ha=
shtable.
> >
> > 2. The multiple MR and alias MR process in the memory layer. It is
> > complicated and performance effective.
> > So If we let the MR issue to the device itself, it is just as this
> > patch does-let the device address the reentrancy issue.f
> >
> > Another solution. We connects a MR with the corresponding device. Now
> > the device often tight MR with an 'opaque' field.
> > Just uses it in the calling of MR callback. Then we add a flag in the
> > device and needs to modify the MR register interface.
> >
> > So in the memory layer we can check/record/clean the MR->device->flag.
> > But this is can't address the DMA (in BH) to MMIO issue as the BH runs
> > in main thread.
>
>
> This is probably good enough to start. To my point of view, there're two
> different issues:
>
> 1) re-entrant MMIO handler
> 2) MMIO hanlder sync with BH
>

Agree, here I want to address these two kind of issue in a manner so
it just be left to the device itself.
I  will try to add a new memory register function
memory_region_init_io_with_device
to connect the MR and device. And solve it in the memory layer.


Thanks,
Li Qiang

> For 1), we'd better solve it at core, For 2) it can only be solved in
> the device.
>
> Thanks
>
>
> >
> > Thanks,
> > Li Qiang
> >
> >
> >
> >> 2) Only forbid the reentrancy in MMIO handler and depends on the devic=
e
> >> to solve the multiple Memory Region issue, if the regions want to acce=
ss
> >> the same data, it needs to be synchronized internally
> >>
> >> But the point is still to try to solve it in the layer of memory
> >> regions. Otherwise we may still hit similar issues.
> >>
> >>
> >>> What about the virtio-gpu bug, where the problem happens in a bh->mmi=
o
> >>> access rather than an mmio->mmio access?
> >>
> >> Yes, it needs more thought, but as a first step, we can try to fix the
> >> MMIO handler issue and do bh fix on top.
> >
> >
> >> Thanks
> >>
> >>
> >>> -Alex
> >>>
> >>>> Thanks
> >>>>
> >>>>
> >>>>> The (most of the) device emulation is protected by BQL one time onl=
y
> >>>>> a device emulation code can be run. We can add a flag to indicate t=
he
> >>>>> IO is running. The first two patches does this. For simplicity at t=
he
> >>>>> RFC stage I just set it while enter the IO callback and clear it ex=
it
> >>>>> the IO callback. It should be check/set/clean according the per-dev=
ice's
> >>>>> IO emulation.
> >>>>> The second issue which itself suffers a race condition so I uses a
> >>>>> atomic.
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> Li Qiang (3):
> >>>>>      e1000e: make the IO handler reentrant
> >>>>>      xhci: make the IO handler reentrant
> >>>>>      virtio-gpu: make the IO handler reentrant
> >>>>>
> >>>>>     hw/display/virtio-gpu.c        | 10 ++++++
> >>>>>     hw/net/e1000e.c                | 35 +++++++++++++++++++-
> >>>>>     hw/usb/hcd-xhci.c              | 60 +++++++++++++++++++++++++++=
+++++++
> >>>>>     hw/usb/hcd-xhci.h              |  1 +
> >>>>>     include/hw/virtio/virtio-gpu.h |  1 +
> >>>>>     5 files changed, 106 insertions(+), 1 deletion(-)
> >>>>>
>

