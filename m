Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CFEC74A36
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 01:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671C720844
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 01:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U91na2lN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671C720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlOHp-0006Rk-L6
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 21:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45582)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhangfei.gao@gmail.com>) id 1hlOHN-00062s-W0
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhangfei.gao@gmail.com>) id 1hlOHM-00046L-OG
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:53:49 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhangfei.gao@gmail.com>)
 id 1hlOHM-000458-Jh; Wed, 10 Jul 2019 21:53:48 -0400
Received: by mail-io1-xd43.google.com with SMTP id i10so8991483iol.13;
 Wed, 10 Jul 2019 18:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Es0Wtn4JN9EHXFe85J1N6WEDUP7z/C4Ydh/XQ51XykY=;
 b=U91na2lNCQdCwoRsJSc+NFxKvGYkw2iE6EqdT0nXFXQNcoAU1fyzqErifW9rkRunIh
 NqM+h3098fLcGUxFVSRUkfpvzqneY1fF6fztlGC3s7nIRgaHIkL+a3LmTcSGbom6EKN8
 kFL3ybJoKNtj1reL7fB7m8igx0lgwllhqSS6sVDa6KvHOCFRYe9E4gqISrVImWxJgBGr
 8pZKWhkBxos1uYG+qOGoZpxZaNbGmwVQlcuNsytkIureNQVAqWBx1wCPlpZXCKpCRpLl
 FspVt4PM35NbyvCHwXVMcnkbLODms3UgD9xnhz2HphqEKdVaKWEUblcP4n5HjgCgdDmy
 6NoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Es0Wtn4JN9EHXFe85J1N6WEDUP7z/C4Ydh/XQ51XykY=;
 b=QaxV0PD5RuqzCfT1KDB5NqLPc+7K0LriokBNTAqQOq2Qse+7deph1vGNfHl759aXcI
 JCgo22TTyTg71GPeIBH+/xCi5c+hSgFXb/1nEVx8EH08ewFNN+chXvVAG4SoNIL4XRwr
 OpBueUTR44DftmjeDE6QBtLgXuG4epY6oBgI6LPCZcO7i7sFL+TTQXPoxciVauKAOtH3
 KLa/VV+hYNV+4ehy4OpcvPOuR+bX6bsDnLyzM3dq3jDoNUXCFX+cSlIYknKC6okTFSz4
 sDhYet7sgGA7kFnnZ/eXxGfRo8yxjVFfcyPmKo8cKvHElwv/P6fJDRx+1pwDMkir7Tq7
 ccEw==
X-Gm-Message-State: APjAAAUyYmhf+wh5qFYDyCEAz6GCM18de2MY9j8wzrD/cj2e65Song0V
 H47pDtd0mVyQA+HrYZHI3VyxRLnhhCsCIrIIeKA=
X-Google-Smtp-Source: APXvYqw+6n7FIl0E5DRwhVYeUULnc2IRJcidDMShWA7dxI1ddmkhZU9k61NqGzon2PKHRHS+WfXX8tDMqoEPHlbpe4U=
X-Received: by 2002:a6b:d008:: with SMTP id x8mr1342557ioa.129.1562810026308; 
 Wed, 10 Jul 2019 18:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190527114203.2762-1-eric.auger@redhat.com>
In-Reply-To: <20190527114203.2762-1-eric.auger@redhat.com>
From: Zhangfei Gao <zhangfei.gao@gmail.com>
Date: Thu, 11 Jul 2019 09:53:35 +0800
Message-ID: <CAMj5BkgsJxKY89hURnf3dp2GE0quLr-NOPtQsYFQjOPEx6=Cqw@mail.gmail.com>
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [RFC v4 00/27] vSMMUv3/pSMMUv3 2 stage VFIO
 integration
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
Cc: Peter Maydell <peter.maydell@linaro.org>, drjones@redhat.com,
 yi.l.liu@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com, qemu-devel@nongnu.org,
 peterx@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 vincent.stehle@arm.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 27, 2019 at 7:44 PM Eric Auger <eric.auger@redhat.com> wrote:
>
> Up to now vSMMUv3 has not been integrated with VFIO. VFIO
> integration requires to program the physical IOMMU consistently
> with the guest mappings. However, as opposed to VTD, SMMUv3 has
> no "Caching Mode" which allows easy trapping of guest mappings.
> This means the vSMMUV3 cannot use the same VFIO integration as VTD.
>
> However SMMUv3 has 2 translation stages. This was devised with
> virtualization use case in mind where stage 1 is "owned" by the
> guest whereas the host uses stage 2 for VM isolation.
>
> This series sets up this nested translation stage. It only works
> if there is one physical SMMUv3 used along with QEMU vSMMUv3 (in
> other words, it does not work if there is a physical SMMUv2).
>
> The series uses a new kernel user API [1], still under definition.
>
> - We force the host to use stage 2 instead of stage 1, when we
>   detect a vSMMUV3 is behind a VFIO device. For a VFIO device
>   without any virtual IOMMU, we still use stage 1 as many existing
>   SMMUs expect this behavior.
> - We introduce new IOTLB "config" notifiers, requested to notify
>   changes in the config of a given iommu memory region. So now
>   we have notifiers for IOTLB changes and config changes.
> - vSMMUv3 calls config notifiers when STE (Stream Table Entries)
>   are updated by the guest.
> - We implement a specific UNMAP notifier that conveys guest
>   IOTLB invalidations to the host
> - We implement a new MAP notifiers only used for MSI IOVAs so
>   that the host can build a nested stage translation for MSI IOVAs
> - As the legacy MAP notifier is not called anymore, we must make
>   sure stage 2 mappings are set. This is achieved through another
>   memory listener.
> - Physical SMMUs faults are reported to the guest via en eventfd
>   mechanism and reinjected into this latter.
>
> Note: The first patch is a code cleanup and was sent separately.
>
> Best Regards
>
> Eric
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/v4.0.0-2stage-rfcv4
>
> Compatible with kernel series:
> [PATCH v8 00/29] SMMUv3 Nested Stage Setup
> (https://lkml.org/lkml/2019/5/26/95)
>

Have tested vfio mode in qemu on arm64 platform.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
qemu: https://github.com/eauger/qemu/tree/v4.0.0-2stage-rfcv4
kernel: https://github.com/eauger/linux/tree/v5.2-rc1-2stage-v8

