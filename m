Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D1EC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 08:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75E52085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 08:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75E52085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzcmR-0002qj-SS
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 04:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hzclh-0002Ev-9K
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hzclg-0003Tx-7N
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:11:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hzclf-0003T3-Vi
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:11:56 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 940D8796E4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 08:11:54 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id d6so1584946pls.17
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 01:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XSXy7pHdR1hvvQkKuZCXV9uOJTR18d6BKBzT0zCNiwU=;
 b=KfR4h6lM+g5DO7bHpWqZutsEqmlmY9kUECzLu7VmyESiMsvcyNNAFz1A13zfJ1b6SC
 SC6KP61vocY4OtYReDpW+bcRiasyr9oTFIVQ716nER6yfUKoqNUpcPkezTgiySWlJzYT
 oxzQjR/AQ5FLi/N4TzorLJSxbIP1G2eCxfYhEbd5JY1RyvXvsRa/h0jqmq8RZkgkb5bU
 vkauttpJQWX1YsIolaINYSlzo07G6Yd8nPljGrT/2z3+okemHFVjiGFyShDIG6IHwgMS
 qCZl6NOyeBJdZFLVXUZ2P/vNoV3rUlt8UzqBw7ryEw09IYV30Ql4069VQaAv1H8j3gvG
 OrmA==
X-Gm-Message-State: APjAAAWquXDTW3OsAqxlbUCAsCiTWF5wGHxCjLknITbmzLsyVdZCYxpL
 G5OHxCorBJqtTHLCNHKbMDcjUlbTiDmFoFCEVYomYWW/SFyNQQaeM/tPWw5Uofi/QiIAfuuBfzi
 IkVrQ6kRN1mGCteE=
X-Received: by 2002:a17:90a:e2c5:: with SMTP id
 fr5mr5710963pjb.122.1566202314108; 
 Mon, 19 Aug 2019 01:11:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYKH9U95db2gQGENyE8U7ULIPG8RngVyUgFUGmzKNrP+JnQ7ok2hIMVMuN7ZIElYT5evwSXQ==
X-Received: by 2002:a17:90a:e2c5:: with SMTP id
 fr5mr5710945pjb.122.1566202313830; 
 Mon, 19 Aug 2019 01:11:53 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 185sm22329016pff.54.2019.08.19.01.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 01:11:53 -0700 (PDT)
Date: Mon, 19 Aug 2019 16:11:43 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190819081143.GA13560@xz-x1>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-9-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730172137.23114-9-eric.auger@redhat.com>
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

On Tue, Jul 30, 2019 at 07:21:30PM +0200, Eric Auger wrote:

[...]

> +    mapping = g_tree_lookup(domain->mappings, (gpointer)(&interval));
> +
> +    while (mapping) {
> +        viommu_interval current;
> +        uint64_t low  = mapping->virt_addr;
> +        uint64_t high = mapping->virt_addr + mapping->size - 1;
> +
> +        current.low = low;
> +        current.high = high;
> +
> +        if (low == interval.low && size >= mapping->size) {
> +            g_tree_remove(domain->mappings, (gpointer)(&current));
> +            interval.low = high + 1;
> +            trace_virtio_iommu_unmap_left_interval(current.low, current.high,
> +                interval.low, interval.high);
> +        } else if (high == interval.high && size >= mapping->size) {
> +            trace_virtio_iommu_unmap_right_interval(current.low, current.high,
> +                interval.low, interval.high);
> +            g_tree_remove(domain->mappings, (gpointer)(&current));
> +            interval.high = low - 1;
> +        } else if (low > interval.low && high < interval.high) {
> +            trace_virtio_iommu_unmap_inc_interval(current.low, current.high);
> +            g_tree_remove(domain->mappings, (gpointer)(&current));
> +        } else {
> +            break;
> +        }
> +        if (interval.low >= interval.high) {
> +            return VIRTIO_IOMMU_S_OK;
> +        } else {
> +            mapping = g_tree_lookup(domain->mappings, (gpointer)(&interval));
> +        }
> +    }
> +
> +    if (mapping) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "****** %s: Unmap 0x%"PRIx64" size=0x%"PRIx64
> +                     " from 0x%"PRIx64" size=0x%"PRIx64" is not supported\n",
> +                     __func__, interval.low, size,
> +                     mapping->virt_addr, mapping->size);
> +    } else {
> +        return VIRTIO_IOMMU_S_OK;
> +    }
> +
> +    return VIRTIO_IOMMU_S_INVAL;

Could the above chunk be simplified as something like below?

  while ((mapping = g_tree_lookup(domain->mappings, &interval))) {
    g_tree_remove(domain->mappings, mapping);
  }

Thanks,

-- 
Peter Xu

