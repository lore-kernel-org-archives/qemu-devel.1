Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1FCC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616B721481
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IijN0XCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616B721481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUxcl-0004Hb-9k
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 15:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUxYr-0000FQ-6T
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUxYl-0001y3-RK
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 15:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603223079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=88R+z3Z9IAgzZQX23fabbfwgKU8Bj3qVHwwmGhWeEaM=;
 b=IijN0XCv1jyCtCD/MYVZfz2PcvyY2deihULU0rL6GFoheiOgZmWzsmwy9Iq+jcd52ZL4ZL
 TZ9NSU0AZszUuiExu3G7U1SsqRY3+WotciQiZPY0o5Jkf0MciL40EvuI6uvwRlYjoXQrMN
 DT5PFvf60XVj0+ABifWYKtpU+5kKkgE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-oE5L92oUPReRjiSTyIXlBA-1; Tue, 20 Oct 2020 15:44:37 -0400
X-MC-Unique: oE5L92oUPReRjiSTyIXlBA-1
Received: by mail-qv1-f69.google.com with SMTP id l47so1938725qve.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 12:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=88R+z3Z9IAgzZQX23fabbfwgKU8Bj3qVHwwmGhWeEaM=;
 b=hCkAxYgENI8spTkpMmLW/gHcSmtG6XoHPtXaz1HYtTjiRwIOafCWgZVT48WfQBgi6a
 Hrum0hFyKrVLSVi+f8GdQJ59B2VfEPIP8ZBSRYt347OylZ9I69lPI3F/AfWJYFR7IKsO
 6CTZg8JtJi/yGpb6a1/W18ciXAzyJqki4ubQWEQmJ6Tt58j/S3LTMY4gWCs+9adnU0fR
 s+0YfXItXeFq/9hf0U0JgaFzKrujl66CN+H2sLDC9eqrxNDYgd0VsIxfGHfHI6tpqNUm
 sAPL7vuOiguhzWy++Zik37WuYFiU/W5/t+PRPnnuYvg7JCR8upXaglGizAgRGAkF2GL9
 6QoA==
X-Gm-Message-State: AOAM531QKqlwzLovXsGo1iPk2OE4UnmGcugwv6IM12447sebNECWbezY
 RV/oNsD4bX++93ujW4zKKb/UVIBY7myO0ZdWdfNyRujG2n1ZQzIY9zrVRlaNqATALtcswK0/BfL
 fvKnjHiN+sYrPh3Y=
X-Received: by 2002:ac8:3ac4:: with SMTP id x62mr3979587qte.347.1603223076858; 
 Tue, 20 Oct 2020 12:44:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztfG7xmIbe7lfyv/OpDOUx9dsT3gF8yrfGn+7ngRAKLMXxrjY4XEYtIeMpC8kfpxX/xWP0og==
X-Received: by 2002:ac8:3ac4:: with SMTP id x62mr3979576qte.347.1603223076620; 
 Tue, 20 Oct 2020 12:44:36 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id k16sm1264470qtu.45.2020.10.20.12.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 12:44:35 -0700 (PDT)
Date: Tue, 20 Oct 2020 15:44:34 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH PROTOTYPE 3/6] vfio: Implement support for sparse RAM
 memory regions
Message-ID: <20201020194434.GD200400@xz-x1>
References: <20200924160423.106747-1-david@redhat.com>
 <20200924160423.106747-4-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924160423.106747-4-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Luiz Capitulino <lcapitulino@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 06:04:20PM +0200, David Hildenbrand wrote:
> Implement support for sparse RAM, to be used by virtio-mem. Handling
> is somewhat-similar to memory_region_is_iommu() handling, which also
> notifies on changes.
> 
> Instead of mapping the whole region, we only map selected pieces (and
> unmap previously selected pieces) when notified by the SparseRAMHandler.

It works with vIOMMU too, right? :) As long as vfio_get_vaddr() works as
expected with virtio-mem plugging new memories, then I think the answer should
be yes.

If it's true, maybe worth mention it somewhere either in the commit message or
in the code comment, because it seems not that obvious.

So if you have plan to do some real IOs in your future tests, may also worth
try with the "-device intel-iommu" and intel_iommu=on in the guest against the
same test.

Thanks,

-- 
Peter Xu


