Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346CEC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75175223B0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdvoL+Vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75175223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZZXY-0003k4-0E
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 08:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZZWt-0003LT-T3
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:05:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZZWr-00021w-Lf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604322344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWKUhCdaPrZlq8S524CZCYDlrDMIf0QXF7jDlI8f57Y=;
 b=UdvoL+Vwiigdu7ni9k+hydkhYdwo0THFbgimHzBoSuG24aDxCeS4OUf1hrfA9TBJR80/Uq
 OnrHhhqe2MMXwDZWRY2CBOVj+m71qC8TBNpBFhMQfSZBPU810SDJ96FTI1+rZgvHTFvKST
 zuTxLjXZ7MbEp/mIGDQNMRgsV4X7dxQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-R7YAMDypP9GYOCfIHLYkWQ-1; Mon, 02 Nov 2020 08:05:42 -0500
X-MC-Unique: R7YAMDypP9GYOCfIHLYkWQ-1
Received: by mail-wr1-f72.google.com with SMTP id 2so6442313wrd.14
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 05:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QWKUhCdaPrZlq8S524CZCYDlrDMIf0QXF7jDlI8f57Y=;
 b=gxGMUxvCXVBIb36ADZIkIfLudtgkkHokMXpuZaLoMMaviCa2f8JAB24Vrmimzpc3f+
 XrEEVNjhSIcNx5ZQGqJpumtOwX7CdWl11buwOJ/kDHT2e/CHUQvwDEEq33aXX7nUnPJM
 lTU5IAmRrHuZseGDQnOvfegyvZXd9LdvvcdJAjX0siykMmeABWAcNzukn1sTqeNYLsIy
 43CyNfpc1TVp4dv6pIXCYi/B/7Oubb3CWT8fKLHkKje6F2NG/cnejgM96udz5lKnWQRo
 4okcQARLQuQ2jB8i8eOXO4URM+soI/bpqDwplJbDy8KNfs1EA4ZtIFYzxRKL+K4Uq5B4
 P9WA==
X-Gm-Message-State: AOAM530SfCBWYOJ1aO3C8qBoG91WVxJARELWRZLQhPei1UbvAdMob9AK
 nU4t7VYVZ1V6GPFsqs8jXBC+D6sGXRCOIadnIKnBnWAWmLQ5axod4rRWo9P/4n/5X46O5DcTdYG
 Bzi2q2CJ0lrwK8TM=
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr18425375wmb.114.1604320646982; 
 Mon, 02 Nov 2020 04:37:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyww2BEfexRlcXZQ8n0Q0zJKbQWRcINwpw4IIUSLMPCaESI+JBO1eirQ00oE/LDs822fD3GoA==
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr18425357wmb.114.1604320646807; 
 Mon, 02 Nov 2020 04:37:26 -0800 (PST)
Received: from redhat.com (bzq-79-181-134-187.red.bezeqint.net.
 [79.181.134.187])
 by smtp.gmail.com with ESMTPSA id a17sm22483057wra.29.2020.11.02.04.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 04:37:25 -0800 (PST)
Date: Mon, 2 Nov 2020 07:37:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/6] virtio-mem: block size and address-assignment
 optimizations
Message-ID: <20201102073715-mutt-send-email-mst@kernel.org>
References: <20201008083029.9504-1-david@redhat.com>
 <242d30e9-f22b-d570-0186-629792f5bdf1@redhat.com>
 <58aa0883-ec4c-d118-4485-042a2482822b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <58aa0883-ec4c-d118-4485-042a2482822b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 01:20:11PM +0100, David Hildenbrand wrote:
> On 22.10.20 10:10, David Hildenbrand wrote:
> > On 08.10.20 10:30, David Hildenbrand wrote:
> > > 
> > > 
> > > Let's try to detect the actual THP size and use it as default block size
> > > (unless the page size of the backend indicates that THP don't apply).
> > > Always allow to set a block size of 1 MiB, but warn if the configured block
> > > size is smaller than the default. Handle large block sizes better, avoiding
> > > a virtio-spec violation and optimizing address auto-detection.
> > > 
> > > For existing setups (x86-64), the default block size won't change (was, and
> > > will be 2 MiB on anonymous memory). For existing x86-64 setups, the address
> > > auto-detection won't change in relevant setups (esp., anonymous memory
> > > and hugetlbfs with 2 MiB pages and no manual configuration of the block
> > > size). I don't see the need for compatibility handling (especially, as
> > > virtio-mem is still not considered production-ready).
> > > 
> > > Most of this is a preparation for future architectures, using hugetlbfs
> > > to full extend, and using manually configured, larger block sizes
> > > (relevant for vfio in the future).
> > 
> > Ping.
> > 
> 
> Ping, MST?

Applied, thanks!

> -- 
> Thanks,
> 
> David / dhildenb


