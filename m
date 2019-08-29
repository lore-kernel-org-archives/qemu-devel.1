Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED345C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 08:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78A523404
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 08:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78A523404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Fhv-0000mS-AB
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 04:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i3Fh4-0000LB-2P
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i3Fh1-0000h8-T0
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:22:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i3Fh1-0000ga-L1
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:22:07 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A1D3887638
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 08:22:06 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id l11so1543824pgc.14
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 01:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6/H9vdsKKute8lIvk5UGbeNiN7h+3MJRe9RgaPzBQqc=;
 b=pr+flJycBfQtZCgyqpvkvIu08BT/lhzHCYq/niTQivvHKRdV3FyD4iwqeZUKwOMo7E
 c1/W6duggcNroYS2BTm7JKygJfniCqDe9r2Z2E2OWuiJeyTvQA1FCGrApY9x1NUNNLPZ
 q4yJS/7IdQfu4PWadmqDh5f141XDgar/10PrkGGhk709w8hYx2tt7YpixFfVS/eMfTuC
 i5hEqYcsGyPdr/F+TbLQkNozAls7AohoqghpE70ei7KQ9aFzJ8zEOuDo2wvlSJSqN1Mv
 tFZqcHT3PwGX9jLzKzmYak6dDAu71UqB+9abrI3IOa4uRI9zvLcgB2COslSxm+4PYqAl
 hJug==
X-Gm-Message-State: APjAAAUywbRNyvFYzZHnthPwruxSNFN1OBLgM89DRxbpq4BDiFGkwHIV
 lN+H7uy6nDFIAwT/FShKVEcO6FoLgR/sBWAYA42CHF+nt82kXp0BiINsxdx7SBk9uMREuB35q93
 N3DR0a7Y8aEaGvZk=
X-Received: by 2002:a17:902:7c0b:: with SMTP id
 x11mr8054161pll.73.1567066926159; 
 Thu, 29 Aug 2019 01:22:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzuCncyJtICP/TMJShqDszDw2NYv7rEHBpDealZL38prL1nuFINItbTtwzVBB7OZZBsuU0RMA==
X-Received: by 2002:a17:902:7c0b:: with SMTP id
 x11mr8054135pll.73.1567066925826; 
 Thu, 29 Aug 2019 01:22:05 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 22sm4084232pfv.134.2019.08.29.01.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 01:22:04 -0700 (PDT)
Date: Thu, 29 Aug 2019 16:21:53 +0800
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190829082153.GH8729@xz-x1>
References: <20190812074531.28970-1-peterx@redhat.com>
 <319f1d6a-ef55-cc1b-98d6-f99b365bd88a@redhat.com>
 <e128decc-8b40-160e-fe8e-673682530750@redhat.com>
 <20190829011850.GC8729@xz-x1>
 <ba2df187-81cd-6dbb-992b-6ae9a7b35e37@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba2df187-81cd-6dbb-992b-6ae9a7b35e37@redhat.com>
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Bandan Das <bsd@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 29, 2019 at 10:05:27AM +0200, Auger Eric wrote:
> Hi Peter,

Hi, Eric,

> On 8/29/19 3:18 AM, Peter Xu wrote:
> > On Wed, Aug 28, 2019 at 02:59:45PM +0200, Auger Eric wrote:
> >> Hi Peter,
> > 
> > Hi, Eric,
> > 
> > [...]
> > 
> >> In
> >> [PATCH v4 2/5] memory: Add IOMMU_ATTR_HW_NESTED_PAGING IOMMU memory
> >> region attribute (https://patchwork.kernel.org/patch/11109701/)
> > 
> > [1]
> > 
> >>
> >> [PATCH v4 3/5] hw/vfio/common: Fail on VFIO/HW nested paging detection
> >> (https://patchwork.kernel.org/patch/11109697/)
> >>
> >> I proposed to introduce a new IOMMU MR attribute to retrieve whether the
> >> vIOMMU uses HW nested paging to integrate with VFIO. I wonder whether
> >> this kind of solution would fit your need too.
> >>
> >> Assuming we would rename the attribute (whose name is challenged by
> >> Peter anyway) into something like IOMMU_ATTR_PHYS_MAP_MODE
> >> taking the possible values: NONE, CM, HW_NESTED_PAGING. SMMUv3 would
> >> return HW_NESTED_PAGING, Intel IOMMU would return CM if CM is enabled or
> >> NONE in the negative. Then we could implement the check directly in VFIO
> >> common.c. That way I don't think you would need the new notifiers and
> >> this would satisfy both requirements?
> > 
> > IMHO it'll suffer from the similar issue we have now with
> > flag_changed, because at the very beginning of x86 system boots DMAR
> > is not yet enabled, the intel-iommu device is using the same mode as
> > its passthrough mode so there's no IOMMU memory region at all in the
> > DMA address spaces of the devices.
> 
> Ah OK I did not get this initially. We don't have this issue with SMMUv3
> as the IOMMU MR exists from the very beginning and does not depend on
> its enablement by the guest. Also it stays there. So the detection can
> be made immediatly.

True.  With that, I'm a bit curious on whether ARM should implement
something like PT mode of Intel's.  For example, have you tried to run
a ARM guest with both a vSMMU and a vfio-pci inside, however keep DMAR
disabled?  IIUC in that case there will be no mapping at all for the
assigned device, then would that work?  Or is there any magic for ARM?

Regards,

-- 
Peter Xu

