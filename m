Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6D7C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 04:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB7C4214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 04:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7C4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hki48-0004iB-TC
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 00:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41890)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hki2h-0003id-6n
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hki2g-00005F-Az
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:47:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hki2g-0008W9-5J
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:47:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so9406875plp.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 21:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QNbrzB+/bPBWg3QE0yjGSY8stZC5Z6uXlKMCTpdJeVg=;
 b=MloxT3hNGvxbdO6Rf1cLcMCSYjooSeI1GtTEbYroMkl49rR5Hj8vPbD4xUhELil4Lg
 rqI9kWmETh2puP+SDvQMFIE4tD9V38InQw1qChOFWWFJM/nPgt6JIahWqVes353nPL4f
 kGfiGes6KMfZDvH66YNTzwtagVdGld7xHO6KPaJdyLRmgchylV7rU+3PACrKvRU+dcmY
 6csTdOWQZTeoHp6RDoWqLZDPOd9jWnKf93945v7QNdXK0YedU7tj4caDjZytDdhmziYT
 MT2bWuhFFkHEPL3CUCuCkWZ/mIla5NO3uFfPtqoLpxfHp9VaYwX0TVyDUapUfvgLxZDz
 +xPA==
X-Gm-Message-State: APjAAAWRj/EkBpyncZRtUvJpde3dO9K33DQzFd+YIeO6BdNMvKXnP6w6
 qZCOmk1gn5CLGUQ29ObqL6zLIw==
X-Google-Smtp-Source: APXvYqyejTegq1bLYU9a0KpYiBvfYeKowVQ1I1tWM5iBqpvuejXSJdcQ31i84YJASz8aoU1UQHxxNw==
X-Received: by 2002:a17:902:e210:: with SMTP id
 ce16mr29869188plb.335.1562647668752; 
 Mon, 08 Jul 2019 21:47:48 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o24sm14302620pfp.135.2019.07.08.21.47.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 08 Jul 2019 21:47:48 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Tue, 9 Jul 2019 12:47:37 +0800
To: Liu Yi L <yi.l.liu@intel.com>
Message-ID: <20190709044737.GE5178@xz-x1>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-10-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1562324511-2910-10-git-send-email-yi.l.liu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.195
Subject: Re: [Qemu-devel] [RFC v1 09/18] intel_iommu: process pasid cache
 invalidation
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

On Fri, Jul 05, 2019 at 07:01:42PM +0800, Liu Yi L wrote:
> +static bool vtd_process_pasid_desc(IntelIOMMUState *s,
> +                                   VTDInvDesc *inv_desc)
> +{
> +    if ((inv_desc->val[0] & VTD_INV_DESC_PASIDC_RSVD_VAL0) ||
> +        (inv_desc->val[1] & VTD_INV_DESC_PASIDC_RSVD_VAL1) ||
> +        (inv_desc->val[2] & VTD_INV_DESC_PASIDC_RSVD_VAL2) ||
> +        (inv_desc->val[3] & VTD_INV_DESC_PASIDC_RSVD_VAL3)) {
> +        trace_vtd_inv_desc("non-zero-field-in-pc_inv_desc",
> +                            inv_desc->val[1], inv_desc->val[0]);

The first parameter of trace_vtd_inv_desc() should be the type.

Can use error_report_once() here.

> +        return false;
> +    }
> +
> +    switch (inv_desc->val[0] & VTD_INV_DESC_PASIDC_G) {
> +    case VTD_INV_DESC_PASIDC_DSI:
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_PASID_SI:
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_GLOBAL:
> +        break;
> +
> +    default:
> +        trace_vtd_inv_desc("invalid-inv-granu-in-pc_inv_desc",
> +                            inv_desc->val[1], inv_desc->val[0]);

Here too.

> +        return false;
> +    }
> +
> +    return true;
> +}

Regards,

-- 
Peter Xu

