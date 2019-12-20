Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96434C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFE12064B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6Wb0GI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFE12064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLhe-0004Ji-2e
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1iiLdm-0000CZ-4Y
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1iiLdk-0007jz-Ep
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:00:37 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1iiLdk-0007hw-3E
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:00:36 -0500
Received: by mail-wr1-x441.google.com with SMTP id b6so10130677wrq.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 09:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WS8ChejV4YO4dWg6kHYPfKg+xFnECZ3CCJJ2MBa8TKg=;
 b=R6Wb0GI3tLLJX1jKbcK6dL58ItO88nB1eLyPF9Xal+jobILpJSw3vgUjiZjljSuPKe
 j2xj5ZZDj1fBgRP1ge6bMhNq6Pa57PW5XG/S55HtjqxPX1/KqiVWr14CdiZQOwaBhbou
 e9CL5yV3YzWwb1CINwwlTS18Y8ZGo9fg75fPqdCojqI/4UdHHlcBsudznM82wbntNJ2H
 hWjCrtmnmMkdZmmL9ZUpWqtl6uUZft91JFAWwJCMojwRgIFvy4G5pgClZeX8EJYd77R0
 hd5la9W/Ys14oieLR8SYbYFM7cSaNG7qG+cCojMEA9AT03FogkPuev5C5iT5oROZVxXE
 rpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WS8ChejV4YO4dWg6kHYPfKg+xFnECZ3CCJJ2MBa8TKg=;
 b=dlcHXLyIEtW18bwtnyGD4YiEbNg6syw1eB+1dOUaXSbiJZWKwl6+M57p7bhoM9x4yS
 fHDErqR/dGLhrYSSYKaWtsGdAhOf5EUFkSeGs/atVFngcJdN2TmlRvZNBWacNiEXEtP+
 spER8ZJAxpCUJ67V+sOwP/obLoPD6imgya8bFHlO4CAz3vpDyO14Xnd1yjE46nYMfYcO
 9813F8TZr6Sju7wtaPB5l44h5D5u3hP+0pNETG16ShndwFVozjf4MtRfx0hsRDR/qiBK
 aXcbmxDXlZDb14oVC1EKBmwNHMPawFZkSk7uqY2D+dZtVY2L6k84+vd1waacMx3eu3GB
 MkFg==
X-Gm-Message-State: APjAAAXnyQbVW36IgqrgoswloYWpGhDoxY4RRTrqFZk/VvONe0rU0/iY
 c3bcmO8lWotANSLd1U9gU/hl8Q==
X-Google-Smtp-Source: APXvYqwnZvVHn8hXeig+Bwh4VMxvawK2cCdKC7uN3pVtR2RbsYsuU75RJD75st50/HbgS3s0iPUbJQ==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr15575656wru.99.1576861234459; 
 Fri, 20 Dec 2019 09:00:34 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id x11sm10337438wmg.46.2019.12.20.09.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 09:00:33 -0800 (PST)
Date: Fri, 20 Dec 2019 18:00:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 05/20] virtio-iommu: Endpoint and domains
 structs and helpers
Message-ID: <20191220170028.GB2626852@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-6-eric.auger@redhat.com>
 <20191210163716.GD277340@myrica>
 <28597404-b9ac-8c16-e9e8-ad5793f2f5a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28597404-b9ac-8c16-e9e8-ad5793f2f5a3@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 07:31:08PM +0100, Auger Eric wrote:
> Hi Jean,
> 
> On 12/10/19 5:37 PM, Jean-Philippe Brucker wrote:
> > On Fri, Nov 22, 2019 at 07:29:28PM +0100, Eric Auger wrote:
> >> +typedef struct viommu_domain {
> >> +    uint32_t id;
> >> +    GTree *mappings;
> >> +    QLIST_HEAD(, viommu_endpoint) endpoint_list;
> >> +} viommu_domain;
> >> +
> >> +typedef struct viommu_endpoint {
> >> +    uint32_t id;
> >> +    viommu_domain *domain;
> >> +    QLIST_ENTRY(viommu_endpoint) next;
> >> +} viommu_endpoint;
> > 
> > There might be a way to merge viommu_endpoint and the IOMMUDevice
> > structure introduced in patch 4, since they both represent one endpoint.
> > Maybe virtio_iommu_find_add_pci_as() could add the IOMMUDevice to
> > s->endpoints, and IOMMUDevice could store the endpoint ID rather than bus
> > and devfn.
> 
> On PCI bus enumeration we locally store the PCI bus hierarchy under the
> form of GHashTable of IOMMUDevice indexed by iommu_pci_bus pointer.
> Those are all the devices attached to the downstream buses. We also use
> an array of iommu pci bus pointers indexed by bus number that is lazily
> populated due to the fact, at enumeration time we do know the bus number
> yet. As you pointed, I haven't used the array of iommu pci bus pointers
> indexed by bus number in this series and I should actually. Currently I
> am not checking on attach that the sid effectively corresponds to a sid
> protected by this iommu. I will add this in my next version. The above
> structures are used in intel_iommu and smmu code as well and I think
> eventually this may be factorized a common base class..
> 
> on the other hand the gtree of viommu_endpoint - soon renamed in
> CamelCase form ;-) - corresponds to the EPs that are actually attached
> to any domain. It is indexed by sid and not by bus pointer. This is more
> adapted to the virtio-iommu case.
> 
> So, despite your suggestion, I am tempted to keep the different
> structures as the first ones are common to all iommu emulation code and
> the last is adapted to the virtio-iommu operations.
> 
> Thoughts?

Makes sense, it seems better to keep them separate. I had missed that the
PCI bus number is resolved later, and started to move the endpoint ID into
IOMMUDevice when adding MMIO support, but I'll need to revisit this.

I'll be off for two weeks, have a nice holiday!

Thanks,
Jean


