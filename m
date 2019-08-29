Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353FBC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0602054F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0602054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i396e-0003WN-0u
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 21:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i395h-00035A-Us
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i395f-00021Y-MQ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:19:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i395e-0001za-Sk
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:19:07 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD35EC0568FD
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 01:19:03 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id q67so1134356pfc.10
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 18:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TFebKm8t2JEA1ZtygUlY9r6izUXMjEJUGbwi1oAD0Ig=;
 b=l3av9e7fkNeimj6cLbSuGnooueqqltXaoKIM6q9qv7eTbxq/4/vP5DUGXujFYkDHgh
 OEXhSqeBsI+VAsA+G0vni1+Uauoj2RLPqhFc42Uj2bMMkZ9zeqcJ8MsF+vgoDr6htaWU
 99DydyCsMjJcK1iPe0cn+4Wzqf+deLwyRvXB3ITwZwYj/PwExJdnI+W4kGxM+9oeqLcI
 gTbt5OiZ/MzWqpZ3KwaFNYqYgs/uiQPnanR2eTVCUp2bgsBtZPBW7WMdp+loBcCoQKe1
 JthETCeb3o8u4XRlAsBtcsrAOeU588NDHGtaRHAs4uSe73uOCN6AZqySSfY3+kRqHqte
 6PHA==
X-Gm-Message-State: APjAAAXdOboV6+YSA3lBuG9XUhVHAlINr8pqk1U5Khc/nhcZw8NQaV2y
 i8aKEDG0Ya1lHElA+jG9/gXCDUZV5SSRvSGD3twSwUkP3cC+cv/5q/ofLUOQhdzuYdaG9psVomC
 lGP2URV3Iv7J7hMU=
X-Received: by 2002:a17:902:be12:: with SMTP id
 r18mr6928027pls.341.1567041542572; 
 Wed, 28 Aug 2019 18:19:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzS9RAFWmhbIda/zU6hxr3RX4qfcHz0f7tETXcWrAxGL6hOYJ4qEoXhU16PrpbhheMWENcxg==
X-Received: by 2002:a17:902:be12:: with SMTP id
 r18mr6928003pls.341.1567041542385; 
 Wed, 28 Aug 2019 18:19:02 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e6sm761725pfl.37.2019.08.28.18.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 18:19:01 -0700 (PDT)
Date: Thu, 29 Aug 2019 09:18:51 +0800
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190829011850.GC8729@xz-x1>
References: <20190812074531.28970-1-peterx@redhat.com>
 <319f1d6a-ef55-cc1b-98d6-f99b365bd88a@redhat.com>
 <e128decc-8b40-160e-fe8e-673682530750@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e128decc-8b40-160e-fe8e-673682530750@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 0/4] intel_iommu: Do sanity check of
 vfio-pci earlier
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bandan Das <bsd@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 28, 2019 at 02:59:45PM +0200, Auger Eric wrote:
> Hi Peter,

Hi, Eric,

[...]

> In
> [PATCH v4 2/5] memory: Add IOMMU_ATTR_HW_NESTED_PAGING IOMMU memory
> region attribute (https://patchwork.kernel.org/patch/11109701/)

[1]

> 
> [PATCH v4 3/5] hw/vfio/common: Fail on VFIO/HW nested paging detection
> (https://patchwork.kernel.org/patch/11109697/)
> 
> I proposed to introduce a new IOMMU MR attribute to retrieve whether the
> vIOMMU uses HW nested paging to integrate with VFIO. I wonder whether
> this kind of solution would fit your need too.
> 
> Assuming we would rename the attribute (whose name is challenged by
> Peter anyway) into something like IOMMU_ATTR_PHYS_MAP_MODE
> taking the possible values: NONE, CM, HW_NESTED_PAGING. SMMUv3 would
> return HW_NESTED_PAGING, Intel IOMMU would return CM if CM is enabled or
> NONE in the negative. Then we could implement the check directly in VFIO
> common.c. That way I don't think you would need the new notifiers and
> this would satisfy both requirements?

IMHO it'll suffer from the similar issue we have now with
flag_changed, because at the very beginning of x86 system boots DMAR
is not yet enabled, the intel-iommu device is using the same mode as
its passthrough mode so there's no IOMMU memory region at all in the
DMA address spaces of the devices.  Hence even with patch [1] above we
still can't really reach the get_attr() check until DMAR enabled?

Maybe we can figure out a good way to expose IOMMU attributes rather
than the IOMMU memory region attributes then we let vfio to pick that
up, but I'm not very sure whether that's clean enough.

Thanks,

-- 
Peter Xu

