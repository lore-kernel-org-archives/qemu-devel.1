Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6224C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7006520768
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnCmcQBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7006520768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jojEe-0004ub-Nr
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 03:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jojDv-0004Mx-8W
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:56:35 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:32806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jojDs-0002y2-KX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:56:34 -0400
Received: by mail-ed1-x544.google.com with SMTP id h28so6222388edz.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 00:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5u38E07NF7bGvPjr2vXllrKTrw+iDRsVFyrwFK7ZHfU=;
 b=rnCmcQBhVXmVjtSg3Ol6m05Ay4NgC77nXEUFVFrBudysDaL+3hjFO5X2aDSnoLCIfh
 JA0sETdJLDkpPGqvB1Nq4M25ztBBjgQwWrKVtnkNrkZ4MbqGhz3XUtqAJXdNAza9x3/a
 vSkZS8ZCenUR0Wx8+qDC7hf9PkCRh5de/ne1/ftpVkQ8crYonp3nAbkj/zwtzn1Z95Et
 Tbf3UGWmw9zssQmdIonQoWFQ5GbwNsPJAEopRmTj6nt+TZacFrCV4oUxEEyhVAZVV1HH
 PywqS+q06O5cx5cK590K3+mNqe4LWnEsSB0gTZNK+0y3n/Y17MgsUMMy0fIGYMfz8T39
 l+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5u38E07NF7bGvPjr2vXllrKTrw+iDRsVFyrwFK7ZHfU=;
 b=uhLxerJx08joL81bULaqiWbPhDqdg1a+wCAF0uj53FpkcixZDQ6llLG1+EdqDFDIhy
 nZG4hwEvu8EhM6b0YUYClhH+arYi8Q/HCjCtLxhRVSHLTelaSGPVoyJ1Iw/wZgv0+dme
 +l9+GYH52JyuTs9GHv3i/ABXWA9hbMFGSlA2pZaAtwOMpcQabWXwvusWuAMkvXOK/tdh
 bmvcUeDKbQsH0Z+6twFyu4Sx9i6aiViWEw4m+jS/gZLxxTcKtz4+VM0qzwu3m5QCAA4E
 jfr8XEphyxSQ1my1gttFZVpIEEVf/sU8jFqOvwgTN9MrokQ6/Z3vMOyeAxDnN1vOOqzJ
 /tqQ==
X-Gm-Message-State: AOAM533W0UVIiv5KZdAjwvI3lS5mDYZBT4e/xxfsHdv9fXLZA1y69V4w
 ZXrKhriv7oMaCLK4HXaJPS/XPQ==
X-Google-Smtp-Source: ABdhPJz8vffmO0SGchMV5l1EW9+sNS1BxWRc9+GP9cOdicoRSXPU9H89VJTq/jt2t2HCT7fE694XBA==
X-Received: by 2002:a50:ee84:: with SMTP id f4mr2016506edr.183.1593158190313; 
 Fri, 26 Jun 2020 00:56:30 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n16sm9714204ejo.54.2020.06.26.00.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 00:56:29 -0700 (PDT)
Date: Fri, 26 Jun 2020 09:56:17 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 0/5] VIRTIO-IOMMU probe request support and MSI bypass
 on ARM
Message-ID: <20200626075617.GB2107508@myrica>
References: <20200624132625.27453-1-eric.auger@redhat.com>
 <20200624094510-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624094510-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=jean-philippe@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 pbonzini@redhat.com, bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 09:47:59AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 24, 2020 at 03:26:20PM +0200, Eric Auger wrote:
> > By default the virtio-iommu translates MSI transactions. This
> > behavior is inherited from ARM SMMU. However the virt machine
> > code knows where the MSI doorbells are, so we can easily
> > declare those regions as VIRTIO_IOMMU_RESV_MEM_T_MSI. With that
> > setting the guest iommu subsystem will not need to map MSIs.
> > This setup will simplify the VFIO integration.
> > 
> > In this series, the ITS or GICV2M doorbells are declared as
> > HW MSI regions to be bypassed by the VIRTIO-IOMMU.
> 
> 
> > This also paves the way to the x86 integration where the MSI
> > region, [0xFEE00000,0xFEEFFFFF], will be exposed by the q35
> > machine.  However this will be handled in a separate series
> > when not-DT support gets resolved.
> 
> What's going on with that btw?
> I think the next step is to put the spec up for virtio tc vote,
> then we can merge that, right? acpi parts will need to be
> ratified by the acpi sig.

Yes I'm being unreasonably slow on this. I'll look at both the virtio spec
and ACPI after coming back from Holiday in July. I'm afraid the situation
for the built-in description will be the same on the Linux side (asked to
use ACPI instead), but it's worth retrying as we have some progress on
ACPI support.

Thanks,
Jean

> 
> > Best Regards
> > 
> > Eric
> > 
> > This series can be found at:
> > https://github.com/eauger/qemu/tree/v5.0.0-virtio-iommu-msi-bypass-v5
> > 
> > History:
> > 
> > v4 -> v5:
> > - Take into account some additional comments from Markus:
> >   - reserved region type becomes an unsigned + some comment/desc
> >     rewording
> >   - assert if the type is not RESERVED or MSI
> > 
> > v3 -> v4:
> > - collected Jean and markus's R-bs
> > - tool into account all Markus' comments in [1/5] (except removal of
> >   goto)
> > - use ':' as delimitor instead of commas
> > - add example in 4/5 commit message as suggested by Markus
> > 
> > v2 -> v3:
> > - Introduce VIRT_MSI_CTRL_NONE in VirtMSIControllerType
> > - do not fill the remainder of the probe buffer
> > 
> > v1 -> v2:
> > - check which MSI controller is in use and advertise the
> >   corresponding MSI doorbell
> > - managed for both ITS and GICv2M
> > - various fixes spotted by Peter and Jean-Philippe, see
> >   individual logs
> > 
> > v1: Most of those patches were respinned from
> >   [PATCH for-5.0 v11 00/20] VIRTIO-IOMMU device
> >   except the last one which is new
> > 
> > 
> > Eric Auger (5):
> >   qdev: Introduce DEFINE_PROP_RESERVED_REGION
> >   virtio-iommu: Implement RESV_MEM probe request
> >   virtio-iommu: Handle reserved regions in the translation process
> >   virtio-iommu-pci: Add array of Interval properties
> >   hw/arm/virt: Let the virtio-iommu bypass MSIs
> > 
> >  include/exec/memory.h            |   6 ++
> >  include/hw/arm/virt.h            |   7 ++
> >  include/hw/qdev-properties.h     |   3 +
> >  include/hw/virtio/virtio-iommu.h |   2 +
> >  include/qemu/typedefs.h          |   1 +
> >  hw/arm/virt.c                    |  18 +++++
> >  hw/core/qdev-properties.c        |  89 ++++++++++++++++++++++++
> >  hw/virtio/virtio-iommu-pci.c     |   3 +
> >  hw/virtio/virtio-iommu.c         | 112 +++++++++++++++++++++++++++++--
> >  hw/virtio/trace-events           |   1 +
> >  10 files changed, 238 insertions(+), 4 deletions(-)
> > 
> > -- 
> > 2.20.1
> 

