Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D81C3A5A2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 01:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960742077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 01:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960742077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5KNM-00007D-O9
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 21:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i5KLZ-0007nk-Tp
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 21:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i5KLX-000683-Gn
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 21:44:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i5KLX-00067P-9V
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 21:44:31 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3865368CF
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 01:44:29 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id t24so5204956pfe.23
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 18:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4o8FHxgaqFbS/PgjXmIAyIKGNCQJb6xAwRHqIacJmR4=;
 b=IoFCJVo+Ji12C6eV2HkXgrXPYKKeRcBnaBV0XNruUDp2Nn5Hh1d5PyEa6Mz3oUaYcU
 KEXLlDQrIxradlst5fCzgzsWGyysGucYGjCCyt8e5ekU8dmrjxnP7oNUAkeEkT7T+q8k
 cS79/SFa9gIUu3rwhd5mnYa0UAALdE0cqQZOjF+oPE2/mRpxXsSiQIlCtN5dKoM9+EXh
 EL8m3G/GXMm2B8UzUIwaNrFtoRiowMWPk6op6uc/rVIhuHDgm2Fyt7JvZiUgnsSGtLlq
 fvqTY/7ntgD4gFs5l/iIMoVB7pkiYvDzM8FBSV5FcOCi1NILlyUVnth3kiyJioSDkYei
 3brw==
X-Gm-Message-State: APjAAAXBTRakZlGu1WLahECIlE4sMKev5F1y/gCMRla03D31Gw8w07Uv
 Yd4EZb/03+THZbbxjhbIsVgZ8sBVrNJ5mvZQ0fNEAPxS4bIzzEfniWOFAfHiClmgPalqNklS/0P
 y/kiPsE/WWIYwlf8=
X-Received: by 2002:aa7:908b:: with SMTP id i11mr41686330pfa.199.1567561469304; 
 Tue, 03 Sep 2019 18:44:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQiKGO6lteuXApmjmh9TKN7aOS3CJc5HNY38iZ8+1EjYK9Gcnj6PmYdFPX4TZx0cjmlCEqYA==
X-Received: by 2002:aa7:908b:: with SMTP id i11mr41686315pfa.199.1567561469099; 
 Tue, 03 Sep 2019 18:44:29 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c138sm394749pfc.80.2019.09.03.18.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 18:44:28 -0700 (PDT)
Date: Wed, 4 Sep 2019 09:44:16 +0800
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190904014416.GB30402@xz-x1>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-9-eric.auger@redhat.com>
 <20190819081143.GA13560@xz-x1>
 <b5e2ff32-eed8-829e-ffd4-2b62ed6b2fda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5e2ff32-eed8-829e-ffd4-2b62ed6b2fda@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 08/15] virtio-iommu: Implement
 map/unmap
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 tn@semihalf.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 01:37:11PM +0200, Auger Eric wrote:
> Hi Peter,
> 
> On 8/19/19 10:11 AM, Peter Xu wrote:
> > On Tue, Jul 30, 2019 at 07:21:30PM +0200, Eric Auger wrote:
> > 
> > [...]
> > 
> >> +    mapping = g_tree_lookup(domain->mappings, (gpointer)(&interval));
> >> +
> >> +    while (mapping) {
> >> +        viommu_interval current;
> >> +        uint64_t low  = mapping->virt_addr;
> >> +        uint64_t high = mapping->virt_addr + mapping->size - 1;
> >> +
> >> +        current.low = low;
> >> +        current.high = high;
> >> +
> >> +        if (low == interval.low && size >= mapping->size) {
> >> +            g_tree_remove(domain->mappings, (gpointer)(&current));
> >> +            interval.low = high + 1;
> >> +            trace_virtio_iommu_unmap_left_interval(current.low, current.high,
> >> +                interval.low, interval.high);
> >> +        } else if (high == interval.high && size >= mapping->size) {
> >> +            trace_virtio_iommu_unmap_right_interval(current.low, current.high,
> >> +                interval.low, interval.high);
> >> +            g_tree_remove(domain->mappings, (gpointer)(&current));
> >> +            interval.high = low - 1;
> >> +        } else if (low > interval.low && high < interval.high) {
> >> +            trace_virtio_iommu_unmap_inc_interval(current.low, current.high);
> >> +            g_tree_remove(domain->mappings, (gpointer)(&current));
> >> +        } else {
> >> +            break;
> >> +        }
> >> +        if (interval.low >= interval.high) {
> >> +            return VIRTIO_IOMMU_S_OK;
> >> +        } else {
> >> +            mapping = g_tree_lookup(domain->mappings, (gpointer)(&interval));
> >> +        }
> >> +    }
> >> +
> >> +    if (mapping) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR,
> >> +                      "****** %s: Unmap 0x%"PRIx64" size=0x%"PRIx64
> >> +                     " from 0x%"PRIx64" size=0x%"PRIx64" is not supported\n",
> >> +                     __func__, interval.low, size,
> >> +                     mapping->virt_addr, mapping->size);
> >> +    } else {
> >> +        return VIRTIO_IOMMU_S_OK;
> >> +    }
> >> +
> >> +    return VIRTIO_IOMMU_S_INVAL;
> > 
> > Could the above chunk be simplified as something like below?
> > 
> >   while ((mapping = g_tree_lookup(domain->mappings, &interval))) {
> >     g_tree_remove(domain->mappings, mapping);
> >   }
> Indeed the code could be simplified. I only need to make sure I don't
> split an existing mapping.

Hmm... Do we need to still split an existing mapping if necessary?
For example when with this mapping:

  iova=0x1000, size=0x2000, phys=ADDR1, flags=FLAGS1

And if we want to unmap the range (iova=0, size=0x2000), then we
should split the existing mappping and leave this one:

  iova=0x2000, size=0x1000, phys=(ADDR1+0x1000), flags=FLAGS1

Right?

> 
> Also I needed to use g_tree_lookup_extended to retrieve the actual key
> to remove. The usage of g_tree_lookup_extended() allows me to remove the
> virt_addr and size fields from the mapping value value struct as those
> info can be retrieved from the key.

True.  Thanks,

-- 
Peter Xu

