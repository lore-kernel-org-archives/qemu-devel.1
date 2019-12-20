Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EB2C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C833206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuCRJ7HV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C833206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiL7n-0001UH-6C
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1iiL76-0000ea-Fp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1iiL74-00029k-Hk
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:26:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1iiL74-00027Q-8n
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:26:50 -0500
Received: by mail-wm1-x342.google.com with SMTP id u2so9830488wmc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6nefJcLqMROs7pgWhMAAFl5DrgNVFm5Hyez90MlqG6M=;
 b=RuCRJ7HVSGtE/esNWSKUp2xkuuQwDFQAzzfIpq/sfMtWT0zmgRpYdBiywv67ju+kX+
 UpuvG2cvlLz6UVtmPZxbDwmu9stIgbfU2wvhAikF0HxgoneswGc/3w7m3ESCcp67x03R
 uPWeM/blvyDxyxN4aPFFaw9qkgAeBEEgk4g14u7TedV90RmFvULmYZX8koKstnEgz+Oi
 hYb8lMbGZdufuGwXfKH7OSKlJomWTt6iH8GeZRlRSJ3nJtzDsHVDUIA+I5Ha5Fko407N
 SuMZvIVqCFP7dSntaXeyH/Kwzm+SL9DS4zZnYxb4b72G3QbKMNerZ7g7fM6IjnzIV+I1
 f9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6nefJcLqMROs7pgWhMAAFl5DrgNVFm5Hyez90MlqG6M=;
 b=oclLEUnQp7sq96SOVQqej6HshBYPY8rRyJ/jcf+6qteYNlyfw2FudQEseUnGlvMrq6
 kmFM/T6d6AkQx8cfWcIB14wZ6dh9rjVIYk2uNNclmnq1a5Af5oARsAN9I2cmSQC7BgVl
 gDvAPpFVJgzGfOLaIxwkvlLwiKL/JibNp8T7qZpJzA83hYjij2wvAO+5ec1sUsQn4bNJ
 tpuRNDi3GPaWo4dsQI7NejiZKXtEMkIV4dk847UYfhxdeCU9w0Nj6Q/cS39SIxE+L3qz
 kI93BDWBCO8o4LqKxobwCv+WuSkAPuzNHB1/y3wxsz3Xhfo9MOrcinaN5Tc4F7WBdumg
 F1oA==
X-Gm-Message-State: APjAAAWWO1FTLAemB6NLZAlYQV5x18R5+1xb9e0YNMb3RYGg4THydBHn
 yOQSlgp+Y3Xj+bKzBCwYUippSg==
X-Google-Smtp-Source: APXvYqzG1u8xLpVW4q2hoefFvPF0Y3nTpkmHNaD3GGip5BCNmqCpKpjLamZ7HTs+d029nAtWv02yUw==
X-Received: by 2002:a1c:3d07:: with SMTP id k7mr18505026wma.79.1576859208456; 
 Fri, 20 Dec 2019 08:26:48 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id g25sm14129132wmh.3.2019.12.20.08.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 08:26:47 -0800 (PST)
Date: Fri, 20 Dec 2019 17:26:42 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
Message-ID: <20191220162642.GA2626852@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-9-eric.auger@redhat.com>
 <20191210193342.GJ3352@xz-x1>
 <44c0041d-68ad-796f-16cc-4bab7ba0f164@redhat.com>
 <20191219133308.GA4246@xz-x1>
 <9d58b293-ada0-353e-bba2-ad1f538dfc62@redhat.com>
 <20191219144936.GB50561@xz-x1>
 <9ec9d0d5-062b-f96b-c72c-4d15865ff9a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ec9d0d5-062b-f96b-c72c-4d15865ff9a1@redhat.com>
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
 quintela@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 04:09:47PM +0100, Auger Eric wrote:
> >>>>>> @@ -412,19 +412,80 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
> >>>>>>                                              int iommu_idx)
> >>>>>>  {
> >>>>>>      IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> >>>>>> +    viommu_interval interval, *mapping_key;
> >>>>>> +    viommu_mapping *mapping_value;
> >>>>>> +    VirtIOIOMMU *s = sdev->viommu;
> >>>>>> +    viommu_endpoint *ep;
> >>>>>> +    bool bypass_allowed;
> >>>>>>      uint32_t sid;
> >>>>>> +    bool found;
> >>>>>> +
> >>>>>> +    interval.low = addr;
> >>>>>> +    interval.high = addr + 1;
> >>>>>>  
> >>>>>>      IOMMUTLBEntry entry = {
> >>>>>>          .target_as = &address_space_memory,
> >>>>>>          .iova = addr,
> >>>>>>          .translated_addr = addr,
> >>>>>> -        .addr_mask = ~(hwaddr)0,
> >>>>>> +        .addr_mask = (1 << ctz32(s->config.page_size_mask)) - 1,
> >>>>>>          .perm = IOMMU_NONE,
> >>>>>>      };
> >>>>>>  
> >>>>>> +    bypass_allowed = virtio_has_feature(s->acked_features,
> >>>>>> +                                        VIRTIO_IOMMU_F_BYPASS);
> >>>>>> +
> >>>>>
> >>>>> Would it be easier to check bypass_allowed here once and then drop the
> >>>>> latter [1] and [2] check?
> >>>> bypass_allowed does not mean you systematically bypass. You bypass if
> >>>> the SID is unknown or if the device is not attached to any domain.
> >>>> Otherwise you translate. But maybe I miss your point.
> >>>
> >>> Ah ok, then could I ask how will this VIRTIO_IOMMU_F_BYPASS be used?
> >>> For example, I think VT-d defines passthrough in a totally different
> >>> way in that the PT mark will be stored in the per-device context
> >>> entries, then we can allow a specific device to be pass-through when
> >>> doing DMA.  That information is explicit (e.g., unknown SID will
> >>> always fail the DMA), and per-device.
> >>>
> >>> Here do you mean that you just don't put a device into any domain to
> >>> show it wants to use PT?  Then I'm not sure how do you identify
> >>> whether this is a legal PT or a malicious device (e.g., an unknown
> >>> device that even does not have any driver bound to it, which will also
> >>> satisfy "unknown SID" and "not attached to any domain", iiuc).
> >>
> >> The virtio-iommu spec currently says:
> >>
> >> "If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, all accesses from
> >> unattached endpoints are
> >> allowed and translated by the IOMMU using the identity function. If the
> >> feature is not negotiated, any
> >> memory access from an unattached endpoint fails. Upon attaching an
> >> endpoint in bypass mode to a new
> >> domain, any memory access from the endpoint fails, since the domain does
> >> not contain any mapping.
> >> "
> >>
> >> I guess this can serve the purpose of devices doing early accesses,
> >> before the guest OS gets the hand and maps them?
> > 
> > OK, so there's no global enablement knob for virtio-iommu? Hmm... Then:

There is at the virtio transport level: the driver sets status to
FEATURES_OK once it accepted the feature bits, and to DRIVER_OK once its
fully operational. The virtio-iommu spec says:

  If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
  device SHOULD NOT let endpoints access the guest-physical address space.

So before features negotiation, there is no access. Afterwards it depends
if the VIRTIO_IOMMU_F_BYPASS has been accepted by the driver.

> well this is a global knob. If this is bot negotiated any unmapped
> device can PT.
> 
> My assumption above must be wrong as this is a negotiated feature so
> anyway the virtio-iommu driver should be involved.
> 
> I don't really remember the rationale of the feature bit tbh.

I don't remember writing down a rationale for this bit, it was in the very
first version (I think someone suggested it during the initial internal
discussion) and I didn't remove it afterwards because it seems useful:

Say a guest only wants to use the vIOMMU for userspace assignment and
wants all other endpoints to bypass translation, which is our primary
use-case. In other words booting Linux with iommu.passthrough=1. It can
either create an identity domain for each endpoint (one MAP request with
VA==PA) or it can set the VIRTIO_IOMMU_F_BYPASS bit. The device-side
implementation should be more efficient with the latter, since you don't
need to lookup the domain + address space for each access.

> In "[virtio-dev] RE: [RFC] virtio-iommu version 0.4 " Jean discussed
> that with Kevein. Sorry I cannot find the link.
> 
> " If the endpoint is not attached to any address space,
> then the device MAY abort the transaction."

Hmm, that was regarding a "bypass" reserved memory region, which isn't in
the current spec.

> Kevin> From definition of BYPASS, it's orthogonal to whether there is an
> address space attached, then should we still allow "May abort" behavior?
> 
> Jean> The behavior is left as an implementation choice, and I'm not sure
> it's worth enforcing in the architecture. If the endpoint isn't attached
> to any domain then (unless VIRTIO_IOMMU_F_BYPASS is negotiated), it
> isn't necessarily able to do DMA at all. The virtio-iommu device may
> setup DMA mastering lazily, in which case any DMA transaction would
> abort, or have setup DMA already, in which case the endpoint can access
> MEM_T_BYPASS regions.
> 
> Hopefully Jean will remember and comment on this.
> 
> Thanks
> 
> Eric
> 
> > 
> >   - This flag is a must for all virtio-iommu emulation, right?
> >     (otherwise I can't see how system bootstraps..)

What do you mean by system bootstrap?

One thing I've been wondering, and may be related, is how to handle a
bootloader that wants to read for example an initrd from a virtio-block
device that's behind the IOMMU. Either we allow the device to let any DMA
bypass the device until FEATURES_OK, which is a source of vulnerabilities
[1], or we have to implement some support for the virtio-iommu in the
BIOS. Again the F_BYPASS bit would help for this, since all the BIOS has
to do is set it on boot. However, F_BYPASS is optional, and more complex
support is needed for setting up identity mappings.

[1] See "IOMMU protection against I/O attacks: a vulnerability and a proof
of concept" by Morgan et al, where a malicious device bypassing the IOMMU
overwrites the IOMMU configuration as it is being created by the OS.
Arguably we're not too concerned about malicious devices at the moment,
but I'm not comfortable relaxing this.

> >   - Should this flag be gone right after OS starts (otherwise I think
> >     we still have the issue that any malicious device can be seen as
> >     in PT mode as default)?  How is that done?

Yes bypass mode assumes that devices and drivers aren't malicious, and the
IOMMU is only used for things like assigning devices to guest userspace,
or having large contiguous DMA buffers.

Thanks,
Jean


