Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73132C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 03:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9EA216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 03:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9EA216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkhDG-0006zO-IT
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 23:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40729)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hkfcP-0007We-ET
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 22:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hkfcO-0001nl-7A
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 22:12:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41169)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hkfcN-0001iI-W6
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 22:12:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so5552976pls.8
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 19:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=p4fDztI4yK31b1rF1iA4XA0Zx6iti4MMOhx5dDcCLyE=;
 b=nyLXNMyFA1QY2/4Jq+IRBegAjr0IcXsuzrPRlb0bw2PnktUVerGXVxFQE4no3ZCPQu
 2P0H33YmeumCndWIIfA9kG4F/yvxvV+PlSJRwChC1nJjV24DdXpaoSa8K0xT+Kb0ig+g
 LYaDw97l2uM2OnFUyCasau0fhvThQUHJOODDelH6MeKl+YbFp8MpucaqlAF5AfdA0XRY
 mDZgMR/wcTyn7uqIHrPPNeSJmkqPvGWj5FLeBmO2/3EuUMThuBQVQB8USZyfGMpKoCt+
 zJEav2s86yxP9sPTkuJY/ZPjaHOS25XGJPK4MNdy6VlFdxxG1gIuZITmq0u4BaTVFJKY
 /2ng==
X-Gm-Message-State: APjAAAU2VoEY3iok8AasCxFsjvTbp7gCFaU6NYBMJKInoBlXWZG4kUyq
 7jqwJqULgq8OE2XYhvshI5zVig==
X-Google-Smtp-Source: APXvYqyDXF+Yj2ZJU2o9g+rr0hX8h4xaruANo3s6o4ynyp6Dm020aqXWZ83GJ+YvwWGkq45XhF1A5A==
X-Received: by 2002:a17:902:7043:: with SMTP id
 h3mr29873175plt.10.1562638340979; 
 Mon, 08 Jul 2019 19:12:20 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 34sm7144861pgl.15.2019.07.08.19.12.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 08 Jul 2019 19:12:20 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Tue, 9 Jul 2019 10:12:09 +0800
To: Liu Yi L <yi.l.liu@intel.com>
Message-ID: <20190709021209.GA5178@xz-x1>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-4-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1562324511-2910-4-git-send-email-yi.l.liu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
X-Mailman-Approved-At: Mon, 08 Jul 2019 23:51:52 -0400
Subject: Re: [Qemu-devel] [RFC v1 03/18] hw/pci: introduce PCIPASIDOps to
 PCIDevice
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 05, 2019 at 07:01:36PM +0800, Liu Yi L wrote:
> +void pci_setup_pasid_ops(PCIDevice *dev, PCIPASIDOps *ops)
> +{
> +    assert(ops && !dev->pasid_ops);
> +    dev->pasid_ops = ops;
> +}
> +
> +bool pci_device_is_ops_set(PCIBus *bus, int32_t devfn)

Name should be "pci_device_is_pasid_ops_set".  Or maybe you can simply
drop this function because as long as you check it in helper functions
like [1] below always then it seems even unecessary.

> +{
> +    PCIDevice *dev;
> +
> +    if (!bus) {
> +        return false;
> +    }
> +
> +    dev = bus->devices[devfn];
> +    return !!(dev && dev->pasid_ops);
> +}
> +
> +int pci_device_request_pasid_alloc(PCIBus *bus, int32_t devfn,
> +                                   uint32_t min_pasid, uint32_t max_pasid)

From VT-d spec I see that the virtual command "allocate pasid" does
not have bdf information so it's global, but here we've got bus/devfn.
I'm curious is that reserved for ARM or some other arch?

> +{
> +    PCIDevice *dev;
> +
> +    if (!bus) {
> +        return -1;
> +    }
> +
> +    dev = bus->devices[devfn];
> +    if (dev && dev->pasid_ops && dev->pasid_ops->alloc_pasid) {

[1]

> +        return dev->pasid_ops->alloc_pasid(bus, devfn, min_pasid, max_pasid);
> +    }
> +    return -1;
> +}
> +
> +int pci_device_request_pasid_free(PCIBus *bus, int32_t devfn,
> +                                  uint32_t pasid)
> +{
> +    PCIDevice *dev;
> +
> +    if (!bus) {
> +        return -1;
> +    }
> +
> +    dev = bus->devices[devfn];
> +    if (dev && dev->pasid_ops && dev->pasid_ops->free_pasid) {
> +        return dev->pasid_ops->free_pasid(bus, devfn, pasid);
> +    }
> +    return -1;
> +}
> +
>  static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
>  {
>      Range *range = opaque;
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index d082707..16e5b8e 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -262,6 +262,13 @@ struct PCIReqIDCache {
>  };
>  typedef struct PCIReqIDCache PCIReqIDCache;
>  
> +typedef struct PCIPASIDOps PCIPASIDOps;
> +struct PCIPASIDOps {
> +    int (*alloc_pasid)(PCIBus *bus, int32_t devfn,
> +                         uint32_t min_pasid, uint32_t max_pasid);
> +    int (*free_pasid)(PCIBus *bus, int32_t devfn, uint32_t pasid);
> +};
> +
>  struct PCIDevice {
>      DeviceState qdev;
>  
> @@ -351,6 +358,7 @@ struct PCIDevice {
>      MSIVectorUseNotifier msix_vector_use_notifier;
>      MSIVectorReleaseNotifier msix_vector_release_notifier;
>      MSIVectorPollNotifier msix_vector_poll_notifier;
> +    PCIPASIDOps *pasid_ops;
>  };
>  
>  void pci_register_bar(PCIDevice *pci_dev, int region_num,
> @@ -484,6 +492,12 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>  void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
>  
> +void pci_setup_pasid_ops(PCIDevice *dev, PCIPASIDOps *ops);
> +bool pci_device_is_ops_set(PCIBus *bus, int32_t devfn);
> +int pci_device_request_pasid_alloc(PCIBus *bus, int32_t devfn,
> +                                   uint32_t min_pasid, uint32_t max_pasid);
> +int pci_device_request_pasid_free(PCIBus *bus, int32_t devfn, uint32_t pasid);
> +
>  static inline void
>  pci_set_byte(uint8_t *config, uint8_t val)
>  {
> -- 
> 2.7.4
> 

Regards,

-- 
Peter Xu

