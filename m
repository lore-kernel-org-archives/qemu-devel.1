Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F96C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1D6214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1D6214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhv2T-0000v0-Eq
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51499)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hhuzY-0008VR-Em
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hhuzX-00079D-Du
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:01:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hhuzX-00078h-4C
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:01:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id p15so14303773qtl.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 05:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DuhTqQNwJBGAbA8hroGBSQ4pk0XeJoZgIPu9sH4gkcg=;
 b=qUxM+HJA9AuUnbXA5PnDuNl64spWsIaINpL5LLy4VZzJ6XyuAI6++qWK6iCgy/yEu4
 i+eDN8dzD0aOH+xGyxatiUZD4Mf6pwl97Q3fKpvI+LTdu9UNmAFWA2gYkncjQDqQkIJw
 2QgIaRChVSF/55W+WmE/mf4FD09LoiEMyc8dTZxhBVDJZUabvwmd2D5sZKPp4wgu1CC8
 mAb5WI2dIFQXbR8UQYmTL4llGLuubNYNu9vRWOQkkX7sUc/QWVXMMCTFCMBJJpoJkX9C
 wAqrSHAwhOd7YvKRDyWhQBH8mgGfJ5lh5B3cayfd5wNTCi65vwwmdyq83E396QlP/64H
 qzHg==
X-Gm-Message-State: APjAAAV+F45JjlWj11M5mJsMYFqHlD+Cs7/+90g+2mqAll2Bdz5yVaR2
 /FcDeB7fOatkxrKBeXj1lu4mdg==
X-Google-Smtp-Source: APXvYqwJa4PCc4qIHCj3H0qyKKkS9l2HBXccvGetGezThJel1SF9SxvoblumOwssy7WL/g2pC8Q65w==
X-Received: by 2002:a0c:bd1f:: with SMTP id m31mr21293613qvg.54.1561982462583; 
 Mon, 01 Jul 2019 05:01:02 -0700 (PDT)
Received: from redhat.com ([37.26.146.159])
 by smtp.gmail.com with ESMTPSA id v72sm4741863qkb.0.2019.07.01.05.00.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 05:01:01 -0700 (PDT)
Date: Mon, 1 Jul 2019 08:00:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190701080038-mutt-send-email-mst@kernel.org>
References: <20190624091811.30412-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624091811.30412-1-peterx@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH v2 0/2] intel_iommu: Fix unexpected unmaps
 during global unmap
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yan Zhao <yan.y.zhao@intel.com>, qemu-devel@nongnu.org,
 Auger Eric <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 05:18:09PM +0800, Peter Xu wrote:
> v2:
> - rename helper to get_naturally_aligned_size(), simplify the
>   codes as suggested [Paolo]
> - check against vtd page size when looping over for unmaps [Yan]
> - add r-b for Eric
> 
> Please review, thanks.

Series:
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Peter Xu (1):
>   intel_iommu: Fix unexpected unmaps during global unmap
> 
> Yan Zhao (1):
>   intel_iommu: Fix incorrect "end" for vtd_address_space_unmap
> 
>  hw/i386/intel_iommu.c | 71 ++++++++++++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 28 deletions(-)
> 
> -- 
> 2.21.0

