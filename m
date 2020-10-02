Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1B9C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 19:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344AE20758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 19:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcmH51FG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344AE20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOQTW-0006zc-8A
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 15:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kOQSw-0006Yn-N6
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 15:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kOQSu-0005lC-6p
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 15:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601665895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5jMj9ravR/j8gGzBBZSxL6rkyn7HRg2l8FWfLinyE0=;
 b=fcmH51FGo0u+7m6UoB3wMpP/XPF9Sp7Z+qH8V435lh79KCt+SUmW11s5epd8kSTUMyj9DK
 UKGwVCjj/CWXzJRkIK/6R+Sjj7N8cEXyPGV9/QDyW/GB7HTifPPFnOh0Wyi7EubiY3EA++
 HFzLD9QZRQ1mVccI5prPiVJfHA7Ri90=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-hv3PREipNUSrJvY4DQ8OIg-1; Fri, 02 Oct 2020 15:11:33 -0400
X-MC-Unique: hv3PREipNUSrJvY4DQ8OIg-1
Received: by mail-qt1-f197.google.com with SMTP id b39so1766404qta.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 12:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G5jMj9ravR/j8gGzBBZSxL6rkyn7HRg2l8FWfLinyE0=;
 b=JA974cQ8y3rXo65laa2r+zpfMVAyhsqziYiZUs3329kyzflzCs2PWVfFJ4BXX404Bq
 u5yePi4blJvoc65LeEx6cnRr5h1f8LvLkgVhUe4e6TaKHBAZZjPae8if0gq0B60rdBNW
 cSyhbfpI8N+ka4OXHWObZWZ+ZZDRAiOgAXC4Iu0yG5CHsCdPFFcz8/1STgek0afObnqz
 o5UnQhVPuAy4VL3rw1XyHxwZD9qfMa6hhCTSdnkHy8ab7ql9yOJR9+05UlPOa2Aw+vif
 zTKFDapLwpSyVdXw4noUSsPXKchcturSjxKzRUdIqKQKzSbLS3cBI7Jc0f2P3MLnRHfT
 8o8w==
X-Gm-Message-State: AOAM532QyjZGSlATYOcbY5JJ6+YoKjIfa73RwEJ8j1cJr2QUXtxOwQiW
 JsO2pKEf3thMeh7zL1yPSOuBihAJVPKao01h8DHGG3voG66yQMtzSiCfQMb9hpZboVaLfwSXsyx
 uabt9z9JMb8Ec2xM=
X-Received: by 2002:a05:620a:919:: with SMTP id
 v25mr3397269qkv.461.1601665892826; 
 Fri, 02 Oct 2020 12:11:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw67QkrMc7jZDgyzZC7cKcO2WWY5IRwA06LcTSZN4wIgzbMhU7WSwSgSwogd/utrI7s6ikDiA==
X-Received: by 2002:a05:620a:919:: with SMTP id
 v25mr3397230qkv.461.1601665892530; 
 Fri, 02 Oct 2020 12:11:32 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca.
 [184.147.14.204])
 by smtp.gmail.com with ESMTPSA id o2sm1701698qkk.42.2020.10.02.12.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 12:11:31 -0700 (PDT)
Date: Fri, 2 Oct 2020 15:11:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Wei Huang <wei.huang2@amd.com>
Subject: Re: [PATCH V2 2/3] amd-iommu: Sync IOVA-to-GPA translation during
 page invalidation
Message-ID: <20201002191130.GF5473@xz-x1>
References: <20201002145907.1294353-1-wei.huang2@amd.com>
 <20201002145907.1294353-3-wei.huang2@amd.com>
MIME-Version: 1.0
In-Reply-To: <20201002145907.1294353-3-wei.huang2@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, pbonzini@redhat.com, Suravee.Suthikulpanit@amd.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 02, 2020 at 09:59:06AM -0500, Wei Huang wrote:
> +static void amdvi_sync_domain(AMDVIState *s, uint32_t domid,
> +                              uint64_t addr, uint16_t flags)
> +{

[...]

> +        /*
> +         * In case of syncing more than a page, we invalidate the entire
> +         * address range and re-walk the whole page table.
> +         */
> +        if (size == AMDVI_PGSZ_ENTIRE) {
> +            IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
> +                amdvi_address_space_unmap(as, n);
> +            }
> +        } else if (size > 0x1000) {
> +            IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
> +                if (n->start <= addr && addr + size < n->end) {
> +                    amdvi_address_space_unmap(as, n);
> +                }
> +            }
> +        }

So this may not work... Because DMA could happen concurrently with the page
sync, so the DMA could fail if the mapping is suddenly gone (even if it's a
very short period).

We encountered this problem on x86 and those will be reported as host DMAR
errors (since those pages were missing), please feel free to have a look at:

  63b88968f1 ("intel-iommu: rework the page walk logic", 2018-05-23)

Majorly this paragraph:

  For each VTDAddressSpace, now we maintain what IOVA ranges we have
  mapped and what we have not.  With that information, now we only send
  MAP or UNMAP when necessary.  Say, we don't send MAP notifies if we
  know we have already mapped the range, meanwhile we don't send UNMAP
  notifies if we know we never mapped the range at all.

So the simple idea is, as long as one page was mapped and it's not unmapped, we
can _never_ unmap it.. because the device might be using it simultaneously.

What VT-d does right now is to maintain a per-device iova tree, so that we know
what exactly have been mapped.  That's kind of an overkill for sure (especially
because vfio kernel module will maintain a similar iova tree, so it's at least
kind of duplicated), however that should fix this problem.

-- 
Peter Xu


