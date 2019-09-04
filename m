Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DC7C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 05:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35ADD20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 05:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ADD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Nzo-0002C8-Cd
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 01:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i5Nz5-0001hp-JW
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i5Nz4-0003CA-CJ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:37:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53104)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i5Nz4-0003Bn-45
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:37:34 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 418BF3C919
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 05:37:33 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id z13so12821694pfr.15
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 22:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7Xok+yVyZiHneq3LIxnYfTEQeUGrDhjEYQBclKpyfow=;
 b=fLAWrcKp2zrmI8pLXiZ33wLwdhGNfcZgUJnJodbShFcIfnv+sUDiB6+psbs7r1yF1I
 yogTzpcXfEOBN80Qd/ZbFV7tZ5ZO/M+HqJvdtTdyuR1RNEgCBLN1gPW/FL0PrDl/lMBi
 /k3TZgayz8++nxEz7ZONfcRRQjiobOJsO5xYugy/9CyJKCz7kxaNpRqMhZ4l+TuspqMb
 38A0MrFqTjnOjdIoTtIeUBAeJMWHorN3zIkGq8E/HY4fjnSDMFJYCc2pYdmc6DRPhYxY
 G/D/IzO8HWfa9lPnH4wJEVBoTw/MmlYCmQFhrI8LanvnLzWWZspftWEg/Pq2PhWilJKg
 GvMQ==
X-Gm-Message-State: APjAAAXBFx+NNam0RvYOFDmQa3oAWAx52p23maxtsu30ART8YGjYyigW
 AN36Mb52f1DGzEGQm1MvktJcZ/b3l5zy80yzlwBOH28gJhLj0plbqgolKkCz0NxGhadPIehvfzq
 tgC82YGjLyau4ncQ=
X-Received: by 2002:a17:90a:36ae:: with SMTP id
 t43mr3130343pjb.7.1567575452782; 
 Tue, 03 Sep 2019 22:37:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzW56BTfwF78nOwopA6XKobjQVflEO/3NlYpNzLtFdnErpwfto8Xo2/g1hoaR5qB5KwXGyN8g==
X-Received: by 2002:a17:90a:36ae:: with SMTP id
 t43mr3130314pjb.7.1567575452475; 
 Tue, 03 Sep 2019 22:37:32 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c1sm21790274pfd.117.2019.09.03.22.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 22:37:31 -0700 (PDT)
Date: Wed, 4 Sep 2019 13:37:20 +0800
From: Peter Xu <peterx@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Message-ID: <20190904053720.GG30402@xz-x1>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-9-eric.auger@redhat.com>
 <20190819081143.GA13560@xz-x1>
 <b5e2ff32-eed8-829e-ffd4-2b62ed6b2fda@redhat.com>
 <20190904014416.GB30402@xz-x1>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D561F28@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D561F28@SHSMSX104.ccr.corp.intel.com>
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Auger Eric <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 04, 2019 at 04:23:50AM +0000, Tian, Kevin wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Wednesday, September 4, 2019 9:44 AM
> > 
> > On Tue, Sep 03, 2019 at 01:37:11PM +0200, Auger Eric wrote:
> > > Hi Peter,
> > >
> > > On 8/19/19 10:11 AM, Peter Xu wrote:
> > > > On Tue, Jul 30, 2019 at 07:21:30PM +0200, Eric Auger wrote:
> > > >
> > > > [...]
> > > >
> > > >> +    mapping = g_tree_lookup(domain->mappings, (gpointer)(&interval));
> > > >> +
> > > >> +    while (mapping) {
> > > >> +        viommu_interval current;
> > > >> +        uint64_t low  = mapping->virt_addr;
> > > >> +        uint64_t high = mapping->virt_addr + mapping->size - 1;
> > > >> +
> > > >> +        current.low = low;
> > > >> +        current.high = high;
> > > >> +
> > > >> +        if (low == interval.low && size >= mapping->size) {
> > > >> +            g_tree_remove(domain->mappings, (gpointer)(&current));
> > > >> +            interval.low = high + 1;
> > > >> +            trace_virtio_iommu_unmap_left_interval(current.low,
> > current.high,
> > > >> +                interval.low, interval.high);
> > > >> +        } else if (high == interval.high && size >= mapping->size) {
> > > >> +            trace_virtio_iommu_unmap_right_interval(current.low,
> > current.high,
> > > >> +                interval.low, interval.high);
> > > >> +            g_tree_remove(domain->mappings, (gpointer)(&current));
> > > >> +            interval.high = low - 1;
> > > >> +        } else if (low > interval.low && high < interval.high) {
> > > >> +            trace_virtio_iommu_unmap_inc_interval(current.low,
> > current.high);
> > > >> +            g_tree_remove(domain->mappings, (gpointer)(&current));
> > > >> +        } else {
> > > >> +            break;
> > > >> +        }
> > > >> +        if (interval.low >= interval.high) {
> > > >> +            return VIRTIO_IOMMU_S_OK;
> > > >> +        } else {
> > > >> +            mapping = g_tree_lookup(domain->mappings,
> > (gpointer)(&interval));
> > > >> +        }
> > > >> +    }
> > > >> +
> > > >> +    if (mapping) {
> > > >> +        qemu_log_mask(LOG_GUEST_ERROR,
> > > >> +                      "****** %s: Unmap 0x%"PRIx64" size=0x%"PRIx64
> > > >> +                     " from 0x%"PRIx64" size=0x%"PRIx64" is not supported\n",
> > > >> +                     __func__, interval.low, size,
> > > >> +                     mapping->virt_addr, mapping->size);
> > > >> +    } else {
> > > >> +        return VIRTIO_IOMMU_S_OK;
> > > >> +    }
> > > >> +
> > > >> +    return VIRTIO_IOMMU_S_INVAL;
> > > >
> > > > Could the above chunk be simplified as something like below?
> > > >
> > > >   while ((mapping = g_tree_lookup(domain->mappings, &interval))) {
> > > >     g_tree_remove(domain->mappings, mapping);
> > > >   }
> > > Indeed the code could be simplified. I only need to make sure I don't
> > > split an existing mapping.
> > 
> > Hmm... Do we need to still split an existing mapping if necessary?
> > For example when with this mapping:
> > 
> >   iova=0x1000, size=0x2000, phys=ADDR1, flags=FLAGS1
> > 
> > And if we want to unmap the range (iova=0, size=0x2000), then we
> > should split the existing mappping and leave this one:
> > 
> >   iova=0x2000, size=0x1000, phys=(ADDR1+0x1000), flags=FLAGS1
> > 
> > Right?
> > 
> 
> virtio-iommu spec explicitly disallows partial unmap.
> 
> 5.11.6.6.1 Driver Requirements: UNMAP request
> 
> The first address of a range MUST either be the first address of a 
> mapping or be outside any mapping. The last address of a range 
> MUST either be the last address of a mapping or be outside any 
> mapping.
> 
> 5.11.6.6.2 Device Requirements: UNMAP request
> 
> If a mapping affected by the range is not covered in its entirety 
> by the range (the UNMAP request would split the mapping), 
> then the device SHOULD set the request status to VIRTIO_IOMMU
> _S_RANGE, and SHOULD NOT remove any mapping.

I see, thanks Kevin.

Though why so strict?  (Sorry if I missed some discussions
... pointers welcomed...)

What I'm thinking is when we want to allocate a bunch of buffers
(e.g., 1M) while we will also need to be able to free them with
smaller chunks (e.g., 4K), then it would be even better that we allow
to allocate a whole 1M buffer within the guest and map it as a whole,
then we can selectively unmap the pages after used.  If with the
strict rule, we'll need to map one by one, that can be a total of
1M/4K roundtrips.

Regards,

-- 
Peter Xu

