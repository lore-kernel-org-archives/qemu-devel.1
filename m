Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DCEC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D2B2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrpL+xPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D2B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGUR3-00079H-JQ
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 17:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGUPn-0006UK-Th
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGUPl-0002td-Pc
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:15:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGUPl-0002t6-M8
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584998117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGbQgAQPzvtdnu3KVl+qv+4VeoEOezAcBEU3LZxKrOI=;
 b=KrpL+xPNpnIvb/FhYIt3zztXx/6uBQaKC2i3FMCtYiPjPp/maNiukvYWyURbM6IFT+gCMp
 daFYgHFS960w2fPVfpprdu5Udpb0PHd0ruqY+SIafFjwyDZOK5O/aiY8PRoSPPLNoyUjrY
 zqyI/1k3c3xOTg/5mOSTU8uoPGJ5/00=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-GLThB7asMga9fF5fMuPFTg-1; Mon, 23 Mar 2020 17:15:15 -0400
X-MC-Unique: GLThB7asMga9fF5fMuPFTg-1
Received: by mail-wm1-f69.google.com with SMTP id m4so437214wmi.5
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 14:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DC8AvxEzNplngpy9CnmfYZ+2jV5WDw9rMwFeaQnkgB0=;
 b=EP3crWqAQKXx8FUikKCW/emtBMvEFzxC/kEmRjHm+S/J0GvOSIbp3AhxdEhuWkb3xM
 XeCyKilb/Bu9QCUApdVrrF8k8HIjdbVmH9UE9mhbD9WTWpH1FeW9u1eg+xLKsRCgMCu5
 U6m2icCnApO7iE5H0hnT5KEXeZkqgLVUfHy7E0iaB5YkNcDdn/+UOvie38Y9B1Gk4AD3
 TulD20YEhxK8szSmzTncBr7FFyvgaqBWEN/r/YQK1AqCOqBt1cWvUHEJ+X+AfF0908eW
 IVVBh6EWTKzXd0U4sMe3476b0xzL4mveKap+EtYNNAbRHW6OTiP4MCoRYF0K4b2VlP5/
 91Nw==
X-Gm-Message-State: ANhLgQ0gfVODkisfj+kRvgcSxtUt8l7KwRSyiLU8EIwzlgMud2Ur519m
 F5a+2g7zVXCTT6cd4ClwDn0uQkkaJB0rsPCnMGEcOQv/VmDVtaHGDDFehWYtIZeWrd0ZZV6ojVo
 rPLJD2nvz5rg+ZEk=
X-Received: by 2002:a5d:624f:: with SMTP id m15mr21578882wrv.56.1584998114436; 
 Mon, 23 Mar 2020 14:15:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvj6ocWHkvYJUnrAJtCrEuf/EChbCJZzzpvia6Dum9XkjCe45SBbAHrLXix0dsiy235hO6/CA==
X-Received: by 2002:a5d:624f:: with SMTP id m15mr21578857wrv.56.1584998114240; 
 Mon, 23 Mar 2020 14:15:14 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id t81sm1135196wmb.15.2020.03.23.14.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 14:15:13 -0700 (PDT)
Date: Mon, 23 Mar 2020 17:15:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 06/22] hw/pci: introduce
 pci_device_set/unset_iommu_context()
Message-ID: <20200323211509.GP127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-7-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-7-git-send-email-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, hao.wu@intel.com, yi.y.sun@intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 22, 2020 at 05:36:03AM -0700, Liu Yi L wrote:

[...]

> +AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +{
> +    PCIBus *bus;
> +    uint8_t devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &bus, &devfn);
> +    if (bus && bus->iommu_ops &&
> +                     bus->iommu_ops->get_address_space) {

Nit: Since we're moving it around, maybe re-align it to left bracket?
Same to below two places.

With the indent fixed:

Reviewed-by: Peter Xu <peterx@redhat.com>

> +        return bus->iommu_ops->get_address_space(bus,
> +                                bus->iommu_opaque, devfn);
>      }
>      return &address_space_memory;
>  }

--=20
Peter Xu


