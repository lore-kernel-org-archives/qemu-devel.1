Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B19C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA656221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eub6lCLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA656221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRjk-0000Ca-OB
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYRdJ-00012s-H1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYRdH-0001eg-1O
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604053662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=65nP2oj8Anbq++XyhT+a7wHS+bvup33fv24cxypeHHY=;
 b=eub6lCLAgouSWi1giXG9OprhZNLy+zVqYNk+j4cgRa+qtsiZoUQNuPCAO+PfxUYleMHUTO
 nXKE2J2MU1md2tSB6zeyjEXGKVjdcOSO+090GcvDtj3oDtbrbzEfTj6k9Qm/Ge9Sb67X2r
 mmmnPgaytKRWJrKqqjvvoC+78hgEqME=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-e5FSFLNANv2om7tGbJNxFA-1; Fri, 30 Oct 2020 06:27:40 -0400
X-MC-Unique: e5FSFLNANv2om7tGbJNxFA-1
Received: by mail-wm1-f72.google.com with SMTP id s12so1579324wmj.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=65nP2oj8Anbq++XyhT+a7wHS+bvup33fv24cxypeHHY=;
 b=BYK1196df1Cg7ubt4K9M3j9Jcry+Va6Cy9GtlkuyoxkuXPf9ki3Rxapnr5qRUR9jWk
 BTlMATecGerzMTXDKHoI+vABaYvjFFnQLD6WCSeoBUzW9Mmmf/V+6cD1ilSAy7d5k+PG
 TFM0hgf1W8XoVNaoJt6vibdRNpLnlD3cnZ1fjIiU3xJr8uFwlf6Lu4/bkbAk8WCbbx6L
 o7KMsX2qyypILc0HsCG41iRrFRKU0sD2PX9wtOiG1bRCs4hbGLi7L0gpxZK9YoRE82fG
 hkHvS+tUpIUrIRdWqrmxGZPrlp7j7dV/U2N2fHrUG9zd3ZN5S4LHqghBIqPGnA2UBPBN
 9Gsw==
X-Gm-Message-State: AOAM533LyA3pL8YLqMHzDsK7PN6HLCCFvZPmWSvunQ0brasDW/IR4HRv
 MKmmjWFhWWVwqJVeQhfWAUhCX/oeTgQHceo3CZC7xS4MpPI91WPObtuRpkckCv7nifCOBPJOhSB
 rtYgyIIwdTj9PnmQ=
X-Received: by 2002:adf:f9cf:: with SMTP id w15mr2215447wrr.185.1604053658877; 
 Fri, 30 Oct 2020 03:27:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu1GH3KEzhvAX/Bb0lHsrVG+Eu8aXq9E6i9aAIW32Q3gWM9xPewFNO1Amcoga6mPXRmlkCdw==
X-Received: by 2002:adf:f9cf:: with SMTP id w15mr2215424wrr.185.1604053658714; 
 Fri, 30 Oct 2020 03:27:38 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id m12sm4129649wmi.33.2020.10.30.03.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 03:27:38 -0700 (PDT)
Date: Fri, 30 Oct 2020 06:27:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 00/10] virtio-iommu: VFIO integration
Message-ID: <20201030062714-mutt-send-email-mst@kernel.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-1-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 08, 2020 at 07:15:48PM +0200, Jean-Philippe Brucker wrote:
> This series adds support for VFIO endpoints to virtio-iommu.
> 
> Versions 1 to 9 were posted by Bharat Bhushan, but I am taking over for
> now since he doesn't have much time to spend on it. Thanks again Bharat
> for the work!

ok so just minor things left, correct? Do you plan to post v11?

> Two major changes since [v9]:
> 
> * Don't use per-endoint page_size_mask properties. Instead keep a global
>   page size for the virtio-iommu device, updated when adding a VFIO
>   endpoint. Reject hotplug if the page size is incompatible.
> 
> * Try to make the MAP/UNMAP paths more efficient, by keeping track of
>   memory region within the endpoint structure.
> 
> More testing would be appreciated, since I can only test using a software
> model as host at the moment. But it does seem to hold well with PCIe
> hotplug/unplug, and pass-through to guest userspace, which are no mean
> feat.
> 
> Note that one page size combination is not supported: host 64kB guest
> 4kB cannot work, because the host IOMMU driver will automatically pick
> 64kB pages which prevents mapping at a smaller granule. Supporting this
> case would require introducing a page size negotiation mechanism from
> the guest all the way to the host IOMMU driver. Possible, but not
> planned at the moment.
> 
> [v9] https://lore.kernel.org/qemu-devel/20200323084617.1782-1-bbhushan2@marvell.com/
> 
> Bharat Bhushan (7):
>   virtio-iommu: Add memory notifiers for map/unmap
>   virtio-iommu: Call memory notifiers in attach/detach
>   virtio-iommu: Add replay() memory region callback
>   virtio-iommu: Add notify_flag_changed() memory region callback
>   memory: Add interface to set iommu page size mask
>   vfio: Set IOMMU page size as per host supported page size
>   virtio-iommu: Set supported page size mask
> 
> Jean-Philippe Brucker (3):
>   virtio-iommu: Fix virtio_iommu_mr()
>   virtio-iommu: Store memory region in endpoint struct
>   vfio: Don't issue full 2^64 unmap
> 
>  include/exec/memory.h    |  26 +++++
>  hw/vfio/common.c         |  19 ++++
>  hw/virtio/virtio-iommu.c | 204 ++++++++++++++++++++++++++++++++++++++-
>  softmmu/memory.c         |  13 +++
>  hw/virtio/trace-events   |   5 +
>  5 files changed, 265 insertions(+), 2 deletions(-)
> 
> -- 
> 2.28.0


