Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2BEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 06:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E55720870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 06:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ21mF6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E55720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9NDx-00043F-HX
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 01:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhangfei.gao@gmail.com>) id 1j9NDC-0003Iu-Ap
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 01:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhangfei.gao@gmail.com>) id 1j9NDA-0002JZ-Q7
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 01:08:54 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:34804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhangfei.gao@gmail.com>)
 id 1j9NDA-0002Gk-Iy; Wed, 04 Mar 2020 01:08:52 -0500
Received: by mail-il1-x144.google.com with SMTP id n11so848412ild.1;
 Tue, 03 Mar 2020 22:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XAqiLN0OgRe/jbNp58CksxYpFnTEMaVgJDYDHSkgmSM=;
 b=AZ21mF6XLfInPy23883eXqsbBJCXQoPszGqiGihAF+JxySrPF3x6fQfXjGEV5Yt5+D
 08okTFQMnKaLtNDxt9jCDXWZotzcXGSX4KVK1ecn8v10BTVB9BEpEhj87SgguEf5+adv
 xbiBiyDxcQ2cwlbNbvXQXzmGgJ0kT2UMzov1iFLTirNuWq9cp/yv2AtD4tmIVBIsqwSP
 iccjIBwr6W9L5wF/3bMhYeaB5mArJglpFz5mfXU+VAYeCmOjRmmi3oKmwtwcNpOUU1L8
 jaFuIOS64wRiHCqVyZCDrbceLuir1FGhKHKZ1lBivdJ+U6yx0Fpui2vYcfWYVVRaYm6T
 DjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XAqiLN0OgRe/jbNp58CksxYpFnTEMaVgJDYDHSkgmSM=;
 b=dOeDcTp7biRdOTWHBkuSrSOBgkP9dLuSlKlNIxFhkc8bN3EV6HBdcuVobeEYivD/+N
 wSJsOyWZ4NmOzNekeFiWCYbRkiBHNUZr9cncj4LoRZ08IxdqgKM7rDoLy2AF+6XtgQa+
 vi7lS+enFVpIGqOadw16QJ+1tA+qxvyGFI+hiiBc4ngxXLEB29WzbGRYWa7vIdhYunlx
 LKTCBm9l65a2eXJ7I5psfpp3nUuM0Jg5K3sylAkgd9BAU1m8sT6o3F/Oo+XSvcOzOEWY
 zdJpSZcUFLtSodkKbEVA08yhUu8+Hz1l6BXUU+aRnzG/OqCjLkjxeB13Xf4a4S2fmUGK
 eRNw==
X-Gm-Message-State: ANhLgQ0NUdppw9YoIyCEGADSBvgKa++ja8IeBZ/vEHJTPiGzDRvy23xr
 RpLrCzWzLJzvq3i3Y5rsRT0FInXaQxPO6p9fZuc=
X-Google-Smtp-Source: ADFU+vtNYBw3adgJSSLzzl5DBYlZFzxIX0HE1+HluFRIhkERVPKshGR7fsiWeUYIdxx+PBYyC9GFpH4iuzMwT1WwUH8=
X-Received: by 2002:a05:6e02:e93:: with SMTP id
 t19mr1370243ilj.286.1583302131279; 
 Tue, 03 Mar 2020 22:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20200214132745.23392-1-eric.auger@redhat.com>
 <20200227111717.GG1645630@redhat.com>
 <431cb39d-833c-6d02-d7b3-02b3e90446e2@redhat.com>
 <CAMj5Bkib3CTzCB02ScueFR84r28LGowF7uxYO8Ygmnj9X7oNOg@mail.gmail.com>
 <fea625f1-b58e-6da6-8e2a-f32fc9391fc8@redhat.com>
In-Reply-To: <fea625f1-b58e-6da6-8e2a-f32fc9391fc8@redhat.com>
From: Zhangfei Gao <zhangfei.gao@gmail.com>
Date: Wed, 4 Mar 2020 14:08:39 +0800
Message-ID: <CAMj5Bkgm1LKbN3E2qTTxmrGhpmdL9NWarSfX-mYCWF0yt5E9eg@mail.gmail.com>
Subject: Re: [PATCH v16 00/10] VIRTIO-IOMMU device
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kevin.tian@intel.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 kenneth-lee-2012@foxmail.com, tnowicki@marvell.com,
 "Michael S. Tsirkin" <mst@redhat.com>, quintela@redhat.com,
 zhangfei.gao@foxmail.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 "Wangzhou \(B\)" <wangzhou1@hisilicon.com>, jean-philippe@linaro.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 3, 2020 at 5:41 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Zhangfei,
> On 3/3/20 4:23 AM, Zhangfei Gao wrote:
> > Hi Eric
> >
> > On Thu, Feb 27, 2020 at 9:50 PM Auger Eric <eric.auger@redhat.com> wrot=
e:
> >>
> >> Hi Daniel,
> >>
> >> On 2/27/20 12:17 PM, Daniel P. Berrang=C3=A9 wrote:
> >>> On Fri, Feb 14, 2020 at 02:27:35PM +0100, Eric Auger wrote:
> >>>> This series implements the QEMU virtio-iommu device.
> >>>>
> >>>> This matches the v0.12 spec (voted) and the corresponding
> >>>> virtio-iommu driver upstreamed in 5.3. All kernel dependencies
> >>>> are resolved for DT integration. The virtio-iommu can be
> >>>> instantiated in ARM virt using:
> >>>>
> >>>> "-device virtio-iommu-pci".
> >>>
> >>> Is there any more documentation besides this ?
> >>
> >> not yet in qemu.
> >>>
> >>> I'm wondering on the intended usage of this, and its relation
> >>> or pros/cons vs other iommu devices
> >>
> >> Maybe if you want to catch up on the topic, looking at the very first
> >> kernel RFC may be a good starting point. Motivation, pros & cons were
> >> discussed in that thread (hey, April 2017!)
> >> https://lists.linuxfoundation.org/pipermail/iommu/2017-April/021217.ht=
ml
> >>
> >> on ARM we have SMMUv3 emulation. But the VFIO integration is not
> >> possible because SMMU does not have any "caching mode" and my nested
> >> paging kernel series is blocked. So the only solution to integrate wit=
h
> >> VFIO is looming virtio-iommu.
> >>
> >> In general the pros that were put forward are: virtio-iommu is
> >> architecture agnostic, removes the burden to accurately model complex
> >> device states, driver can support virtualization specific optimization=
s
> >> without being constrained by production driver maintenance. Cons is pe=
rf
> >> and mem footprint if we do not consider any optimization.
> >>
> >> You can have a look at
> >>
> >> http://events17.linuxfoundation.org/sites/events/files/slides/viommu_a=
rm.pdf
> >>
> > Thanks for the patches.
> >
> > Could I ask one question?
> > To support vSVA and pasid in guest, which direction you recommend,
> > virtio-iommu or vSMMU (your nested paging)
> >
> > Do we still have any obstacles?
> you can ask the question but not sure I can answer ;-)
>
> 1) SMMUv3 2stage implementation is blocked by Will at kernel level.
>
> Despite this situation I may/can respin as Marvell said they were
> interested in this effort. If you are also interested in (I know you
> tested it several times and I am grateful to you for that), please reply
> to:
> [PATCH v9 00/14] SMMUv3 Nested Stage Setup (IOMMU part)
> (https://patchwork.kernel.org/cover/11039871/) and say you are
> interested in that work so that maintainers are aware there are
> potential users.
>
> At the moment I have not supported multiple CDs because it introduced
> other dependencies.
>
> 2) virtio-iommu
>
> So only virtio-iommu dt boot on machvirt is currently supported. For non
> DT, Jean respinned his kernel series
> "[PATCH v2 0/3] virtio-iommu on x86 and non-devicetree platforms" as you
> may know. However non DT integration still is controversial. Michael is
> pushing for putting the binding info the PCI config space. Joerg
> yesterday challenged this solution and said he would prefer ACPI
> integration. ACPI support depends on ACPI spec update & vote anyway.
>
> To support PASID at virtio-iommu level you also need virtio-iommu API
> extensions to be proposed and written + kernel works. So that's a long
> road. I will let Jean-Philippe comment on that.
>
> I would just say that Intel is working on nested paging solution with
> their emulated intel-iommu. We can help them getting that upstream and
> partly benefit from this work.
>
> > Would you mind give some breakdown.
> > Jean mentioned PASID still not supported in QEMU.
> Do you mean support of multiple CDs in the emulated SMMU? That's a thing
> I could implement quite easily. What is more tricky is how to test it.

Thanks Eric

Discussed with Jean before, here are some obstacles for vSVA via nested pag=
ing.
Do you think they are still big issues?

Copy "
* PASID support in QEMU, I don't think there is anything yet
// this is not a big issue as your comments.

* Page response support in VFIO and QEMU. With Eric's series we can
inject recoverable faults into the guest, but there is no channel for
the guest to RESUME the stall after fixing it.

* We can't use DVM in nested mode unless the VMID is shared with the
CPU. For that we'll need the host SMMU driver to hook into the KVM VMID
allocator, just like we do for the ASID allocator. I haven't yet
investigated how to do that. It's possible to do vSVA without DVM
though, by sending all TLB invalidations through the SMMU command queue.
"

Thanks

