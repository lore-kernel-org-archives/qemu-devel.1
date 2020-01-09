Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCE2C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 08:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 883F72067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 08:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWdA4ary"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883F72067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipTTp-000263-NV
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 03:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ipTTC-0001YD-IL
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 03:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ipTTB-00043o-0R
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 03:47:10 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ipTTA-0003yh-NG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 03:47:08 -0500
Received: by mail-wm1-x344.google.com with SMTP id 20so1838383wmj.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 00:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=gpSRAQfJfeKKZ93LqY3GL5Wc3kKXc5o+oUtpcCD6J6w=;
 b=eWdA4aryHboefFwAe9I/qHO+XoWD7hr78KArKePtWtuntA+eXQ6hw9441qE4eyn20s
 V88No0spFygp7X+YZpT4ejtUTFk1kpOVcORW0m2A5S4aOMJhdzP37pXCurAYldCH7I8A
 0efGdmsvKShhGOiJL4Yo3bmK/6m0KMCO/G49zoEmrtoOKHS/5hjk+C8ZGnWTOJhUVVmw
 R9u6l1kdOnbIDbPDaxtGGBXr3v/STwqvExHWrNDZesY4tclIFvPQC3tmiUTb9x5uXUfS
 XCJ8Zqy4zDDY7+kP9cmTPoPYM22McdWr9UN3GiGbe+dCUnEsLTjAqlna9E1IE05z2vzp
 4Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gpSRAQfJfeKKZ93LqY3GL5Wc3kKXc5o+oUtpcCD6J6w=;
 b=CC+72UoqRc11nlrfFlVyqntcAy9R9G375hw54vjIueynqxsO490vInHFFKo+R3/bY1
 hdxHwmqe2AAjFxFCw7LVLE5JFXGcJpi2hsRdeNjRLwGn7weVaeYclFu+bd/IUfhT39D+
 r/2cRcv+56xUTPdQW/rj/pvacfHAvo4RcCvSsCNgdfVonJhYBzzUTFXBeBw3dvuEKCu5
 C82iKEqYSo8mPy9edQ08RZJcWVPxQq8GKS1YhSYfHliWSMyN9kl3z0F78qJs3vZoV8Rn
 vamoumTSZIssZ3GtLxlUkXEsPivSZ2f0PTLZwQlAUQqQs2/lwr5rafLllk1y82+RzH6r
 tJrg==
X-Gm-Message-State: APjAAAUZWUPNhS+QM5HcZhb7R0+URSxx+JN7TVU8tMDxUwG0C3hqDgsn
 qKFnwozvOE3CB/lCPhOX+1YXSA==
X-Google-Smtp-Source: APXvYqxijMSnBqGSdcWzzCqaEMPJ1pHJ1VDrgMDNCKtwvJINwMJ0MC1NPK/3LONfIeUMKpURFxFr1w==
X-Received: by 2002:a1c:6809:: with SMTP id d9mr3461873wmc.70.1578559627288;
 Thu, 09 Jan 2020 00:47:07 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id s15sm7442925wrp.4.2020.01.09.00.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 00:47:06 -0800 (PST)
Date: Thu, 9 Jan 2020 09:47:00 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
Message-ID: <20200109084700.GA934975@myrica>
References: <20191219133308.GA4246@xz-x1>
 <9d58b293-ada0-353e-bba2-ad1f538dfc62@redhat.com>
 <20191219144936.GB50561@xz-x1>
 <9ec9d0d5-062b-f96b-c72c-4d15865ff9a1@redhat.com>
 <20191220162642.GA2626852@myrica> <20191220165100.GA3780@xz-x1>
 <20200106170634.GF2062@myrica> <20200106175850.GC219677@xz-x1>
 <20200107101024.GB832497@myrica>
 <aa5fa9e6-6efd-e1a3-96c6-d02ba8eab4c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa5fa9e6-6efd-e1a3-96c6-d02ba8eab4c8@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 08, 2020 at 05:55:52PM +0100, Auger Eric wrote:
> Hi Jean-Philippe, Peter,
> 
> On 1/7/20 11:10 AM, Jean-Philippe Brucker wrote:
> > On Mon, Jan 06, 2020 at 12:58:50PM -0500, Peter Xu wrote:
> >> On Mon, Jan 06, 2020 at 06:06:34PM +0100, Jean-Philippe Brucker wrote:
> >>> On Fri, Dec 20, 2019 at 11:51:00AM -0500, Peter Xu wrote:
> >>>> On Fri, Dec 20, 2019 at 05:26:42PM +0100, Jean-Philippe Brucker wrote:
> >>>>> There is at the virtio transport level: the driver sets status to
> >>>>> FEATURES_OK once it accepted the feature bits, and to DRIVER_OK once its
> >>>>> fully operational. The virtio-iommu spec says:
> >>>>>
> >>>>>   If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
> >>>>>   device SHOULD NOT let endpoints access the guest-physical address space.
> >>>>>
> >>>>> So before features negotiation, there is no access. Afterwards it depends
> >>>>> if the VIRTIO_IOMMU_F_BYPASS has been accepted by the driver.
> >>>>
> >>>> Before enabling virtio-iommu device, should we still let the devices
> >>>> to access the whole system address space?  I believe that's at least
> >>>> what Intel IOMMUs are doing.  From code-wise, its:
> >>>>
> >>>>     if (likely(s->dmar_enabled)) {
> >>>>         success = vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn,
> >>>>                                          addr, flag & IOMMU_WO, &iotlb);
> >>>>     } else {
> >>>>         /* DMAR disabled, passthrough, use 4k-page*/
> >>>>         iotlb.iova = addr & VTD_PAGE_MASK_4K;
> >>>>         iotlb.translated_addr = addr & VTD_PAGE_MASK_4K;
> >>>>         iotlb.addr_mask = ~VTD_PAGE_MASK_4K;
> >>>>         iotlb.perm = IOMMU_RW;
> >>>>         success = true;
> >>>>     }
> >>>>
> >>>> From hardware-wise, an IOMMU should be close to transparent if you
> >>>> never enable it, imho.
> >>>
> >>> For hardware that's not necessarily the best choice. As cited in my
> >>> previous reply it has been shown to introduce vulnerabilities since
> >>> malicious devices can DMA during boot, before the OS takes control of the
> >>> IOMMU. The Arm SMMU allows an implementation to adopt a deny policy by
> >>> default.
> >>
> >> I see.  But then how to read a sector from the block to at least boot
> >> an OS if we use a default-deny policy?  Does it still need a mapping
> >> that is established somehow by someone before hand?
> > 
> > Yes, it looks like EDK II uses IOMMU operations in order to access those
> > devices on platforms where the IOMMU isn't default-bypass (AMD SEV support
> > is provided by edk2, and a VT-d driver seems provided by edk2-platforms).
> > However for OVMF we could just set the bypass feature bit in virtio-iommu
> > device, which doesn't even requires setting up the virtqueue.
> > 
> > I'm missing a piece of the puzzle for Arm platforms though, because it
> > looks like Trusted Firmware-A sets up the default-deny policy on reset
> > even when it wasn't hardwired, but doesn't provide a service to create
> > SMMUv3 mappings for the bootloader.
> > 
> > Thanks,
> > Jean
> > 
> 
> I think we have a concrete example for the above discussion. The AHCI.
> When running the virtio-iommu on x86 I get messages like:
> 
> virtio_iommu_translate sid=250 is not known!!
> no buffer available in event queue to report event
> 
> and a bunch of "AHCI: Failed to start FIS receive engine: bad FIS
> receive buffer address" messages (For each port)
> 
> This was reported in my cover letter (*). This happens very early in the
> boot process, before the OS get the hand and before the virtio-iommu
> driver creates any mapping. It does not prevent the guest from booting
> though.
> 
> Currently the virtio-iommu device checks the VIRTIO_IOMMU_F_BYPASS. If I
> overwrite it to true in the device, then, the guest boots without those
> messages.

Oh that's good, I was afraid it was an issue in Linux.

> I share Peter's concern about having a different default policy than x86.

Yes I'd say just align with whatever policy is already in place. Do you
think we could add a command-line option to let people disable
default-bypass, though?  That would be a convenient way to make the IOMMU
protection airtight for those who need it.

Thanks,
Jean

