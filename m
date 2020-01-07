Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47375C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E4B207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVjxiN6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E4B207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iom1a-0003aR-BC
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ioloq-0001kH-5c
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ioloo-0005xW-MS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:10:35 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ioloo-0005vp-B7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:10:34 -0500
Received: by mail-wm1-x342.google.com with SMTP id p9so18272089wmc.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=YEFNM/oy8Cq7YUXJMV4fPNXxRE6yOF0JHPTPbwWQ/Wk=;
 b=oVjxiN6pox1UL+86wboFMZ0EFcCAwlMoRKMJpVZ/r1Pn57cAKc9Ow+bWZrDQeeY8ug
 o9hBh9lp0gwVmDIG0wR9NtfJvOpxdGZX/lfOQW+uT7Z4/z5maHoIV8q+V2SNGYay1Uh4
 zvRiP2rx47NtHvoGt7WWw/6dD++f07Xdshaw9fPxHC/AsB26LoRok0l9QlYxbrKvFipm
 F8uv3iQXYcTanGSoncRJLkiYYCeBBBbsSGfSElNJBbRcWwmcHb388e0mEYJpzn5ZWweT
 x2dolzPJdGs+iuVgbS6bXhMXZtGcOsng3MW0n/rMCnlYkmzuwMQXd3rgU9wbikvIZKht
 KT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YEFNM/oy8Cq7YUXJMV4fPNXxRE6yOF0JHPTPbwWQ/Wk=;
 b=TgFEi0eBwzhGQqZwpkNzJr2+iPUNyed5NylBmQTna4ebdL5zdtH7i9nLEAyYj8zaK4
 0b88q4Ysfc1P/XZmUVNTqcghB9x3epPrEMHN2F47BtOdbDdx4q8katTpdBPqyyX5LboK
 9D1jFQcADBolHr7JH/mxjtFZAnKZJZWJarryQnv5/IWqFeS30RIZXoLblqVSFd7bvkQE
 OemXZ95jBSA2yvHt8NW/TMg5bJoBs3IUofoJRQ4bmfsk76GFjkKpmRArTR5YTt0Vayok
 ao2Xf8PWjWwoRzI90sWQ6UUCxQcn0XyOSUQGHT6/lhE/v7WrkoaY9WBE3E+wsG1EF5by
 cx7A==
X-Gm-Message-State: APjAAAV/O38Eos3q2B8JY5VLNHGMpl97DfgtyUQxZcDJ0QdPtC4QHm8E
 6wZ8+RjimCWYTsZcZywJDS9dJg==
X-Google-Smtp-Source: APXvYqw4W95ZsciRHupbCwXa3shUmCBpe2DbVJssL3LpAOOsyrbqjA8bxjh/Iw75OulytnEels6wxw==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr39069782wmi.152.1578391831321; 
 Tue, 07 Jan 2020 02:10:31 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id h8sm78750914wrx.63.2020.01.07.02.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 02:10:30 -0800 (PST)
Date: Tue, 7 Jan 2020 11:10:24 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
Message-ID: <20200107101024.GB832497@myrica>
References: <20191210193342.GJ3352@xz-x1>
 <44c0041d-68ad-796f-16cc-4bab7ba0f164@redhat.com>
 <20191219133308.GA4246@xz-x1>
 <9d58b293-ada0-353e-bba2-ad1f538dfc62@redhat.com>
 <20191219144936.GB50561@xz-x1>
 <9ec9d0d5-062b-f96b-c72c-4d15865ff9a1@redhat.com>
 <20191220162642.GA2626852@myrica> <20191220165100.GA3780@xz-x1>
 <20200106170634.GF2062@myrica> <20200106175850.GC219677@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106175850.GC219677@xz-x1>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 Auger Eric <eric.auger@redhat.com>, bharatb.linux@gmail.com,
 qemu-arm@nongnu.org, dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 06, 2020 at 12:58:50PM -0500, Peter Xu wrote:
> On Mon, Jan 06, 2020 at 06:06:34PM +0100, Jean-Philippe Brucker wrote:
> > On Fri, Dec 20, 2019 at 11:51:00AM -0500, Peter Xu wrote:
> > > On Fri, Dec 20, 2019 at 05:26:42PM +0100, Jean-Philippe Brucker wrote:
> > > > There is at the virtio transport level: the driver sets status to
> > > > FEATURES_OK once it accepted the feature bits, and to DRIVER_OK once its
> > > > fully operational. The virtio-iommu spec says:
> > > > 
> > > >   If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
> > > >   device SHOULD NOT let endpoints access the guest-physical address space.
> > > > 
> > > > So before features negotiation, there is no access. Afterwards it depends
> > > > if the VIRTIO_IOMMU_F_BYPASS has been accepted by the driver.
> > > 
> > > Before enabling virtio-iommu device, should we still let the devices
> > > to access the whole system address space?  I believe that's at least
> > > what Intel IOMMUs are doing.  From code-wise, its:
> > > 
> > >     if (likely(s->dmar_enabled)) {
> > >         success = vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn,
> > >                                          addr, flag & IOMMU_WO, &iotlb);
> > >     } else {
> > >         /* DMAR disabled, passthrough, use 4k-page*/
> > >         iotlb.iova = addr & VTD_PAGE_MASK_4K;
> > >         iotlb.translated_addr = addr & VTD_PAGE_MASK_4K;
> > >         iotlb.addr_mask = ~VTD_PAGE_MASK_4K;
> > >         iotlb.perm = IOMMU_RW;
> > >         success = true;
> > >     }
> > > 
> > > From hardware-wise, an IOMMU should be close to transparent if you
> > > never enable it, imho.
> > 
> > For hardware that's not necessarily the best choice. As cited in my
> > previous reply it has been shown to introduce vulnerabilities since
> > malicious devices can DMA during boot, before the OS takes control of the
> > IOMMU. The Arm SMMU allows an implementation to adopt a deny policy by
> > default.
> 
> I see.  But then how to read a sector from the block to at least boot
> an OS if we use a default-deny policy?  Does it still need a mapping
> that is established somehow by someone before hand?

Yes, it looks like EDK II uses IOMMU operations in order to access those
devices on platforms where the IOMMU isn't default-bypass (AMD SEV support
is provided by edk2, and a VT-d driver seems provided by edk2-platforms).
However for OVMF we could just set the bypass feature bit in virtio-iommu
device, which doesn't even requires setting up the virtqueue.

I'm missing a piece of the puzzle for Arm platforms though, because it
looks like Trusted Firmware-A sets up the default-deny policy on reset
even when it wasn't hardwired, but doesn't provide a service to create
SMMUv3 mappings for the bootloader.

Thanks,
Jean

