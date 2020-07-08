Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ABCC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C5520772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKhnEX7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C5520772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIY5-0006co-70
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtI8P-0002Xh-TA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:01:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtI8N-0006eV-Vl
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GJbdaA1ZrI8/WGO6p7DQkEuHxQcDEw/FrVIeotNsvdI=;
 b=JKhnEX7ESAnpZQ+LTvhFJTE23LxvvbZQXNmAKo2ikTHBlC2K+6tDQbiUG56/KwBghpbVgM
 b32h9AHYIu1qnZhkFKG/hOIObYdGRKiooZs5gz1KIdk7+1U2vm7lvrzHO0bKZqJltIv8uI
 QIngb2/K5hNWIQAiMF1CyOSJ+aY7fHA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-iWeZBFcZPLS2h8_i53phbg-1; Wed, 08 Jul 2020 06:59:46 -0400
X-MC-Unique: iWeZBFcZPLS2h8_i53phbg-1
Received: by mail-wr1-f72.google.com with SMTP id d11so34127497wrw.12
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 03:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GJbdaA1ZrI8/WGO6p7DQkEuHxQcDEw/FrVIeotNsvdI=;
 b=aLp2aIuz5x8bP1jEZkOFDhw8y/v8MWNTtON2DZiPeHd0xhuq3/KDAYzHg0iRntt9yz
 6YLJ9lgEjlDQOa1OL1hlgWQikE2HolxjnpHKTd2mIOISl8aKQW2hQpxeopzedrpolQQY
 o1s5mNl7rB5ZiSElEjakwDjoSM3qtCJScKIMognnC4eRtTnKr+CzupDX75tIcqbVyCDB
 Up8xG0BbtClJlWfz8gjXkhHjTlA90phNt8CjJKTxJhT5S5UBCIdNwL3GD83qCMPwaZFH
 J0bZETuewfO6qXVoGtkGOsGWOXtIBFyboAWsI+RKduxQaz1ig0EnC+AqEBYYbjQTnbFz
 s2XQ==
X-Gm-Message-State: AOAM531YNphLGgpX1t685neKmKcfHDT3t96lvVP9BjbmiyUHu/1bQFWa
 ON9zq9bwv2dYSXrAg1XLmH9EUvu7/qavwHPdIJVgX1u5JHmkGdtpOjRLbchRgAwD2wxe+XieYQJ
 pdgCNpSBibRIg7oM=
X-Received: by 2002:adf:e7c8:: with SMTP id e8mr57000779wrn.20.1594205985681; 
 Wed, 08 Jul 2020 03:59:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygUTbrwWORHy1WZ6oRdnxIczvkO0RDYFkFOb6l9XpMOJJv1RUPfs3HEjqvMVZu2VOdhCtCIw==
X-Received: by 2002:adf:e7c8:: with SMTP id e8mr57000744wrn.20.1594205985459; 
 Wed, 08 Jul 2020 03:59:45 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 69sm2036989wma.16.2020.07.08.03.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 03:59:44 -0700 (PDT)
Date: Wed, 8 Jul 2020 06:59:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5 0/5] virtio-pci: enable blk and scsi multi-queue by
 default
Message-ID: <20200708065841-mutt-send-email-mst@kernel.org>
References: <20200706135650.438362-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200706135650.438362-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 06, 2020 at 02:56:45PM +0100, Stefan Hajnoczi wrote:
> v4:
>  * Sorry for the long delay. I considered replacing this series with a simpler
>    approach. Real hardware ships with a fixed number of queues (e.g. 128). The
>    equivalent can be done in QEMU too. That way we don't need to magically size
>    num_queues. In the end I decided against this approach because the Linux
>    virtio_blk.ko and virtio_scsi.ko guest drivers unconditionally initialized
>    all available queues until recently (it was written with
>    num_queues=num_vcpus in mind). It doesn't make sense for a 1 CPU guest to
>    bring up 128 virtqueues (waste of resources and possibly weird performance
>    effects with blk-mq).
>  * Honor maximum number of MSI-X vectors and virtqueues [Daniel Berrange]
>  * Update commit descriptions to mention maximum MSI-X vector and virtqueue
>    caps [Raphael]
> v3:
>  * Introduce virtio_pci_optimal_num_queues() helper to enforce VIRTIO_QUEUE_MAX
>    in one place
>  * Use VIRTIO_SCSI_VQ_NUM_FIXED constant in all cases [Cornelia]
>  * Update hw/core/machine.c compat properties for QEMU 5.0 [Michael]
> v3:
>  * Add new performance results that demonstrate the scalability
>  * Mention that this is PCI-specific [Cornelia]
> v2:
>  * Let the virtio-DEVICE-pci device select num-queues because the optimal
>    multi-queue configuration may differ between virtio-pci, virtio-mmio, and
>    virtio-ccw [Cornelia]
> 
> Enabling multi-queue on virtio-pci storage devices improves performance on SMP
> guests because the completion interrupt is handled on the vCPU that submitted
> the I/O request.  This avoids IPIs inside the guest.
> 
> Note that performance is unchanged in these cases:
> 1. Uniprocessor guests.  They don't have IPIs.
> 2. Application threads might be scheduled on the sole vCPU that handles
>    completion interrupts purely by chance.  (This is one reason why benchmark
>    results can vary noticably between runs.)
> 3. Users may bind the application to the vCPU that handles completion
>    interrupts.
> 
> Set the number of queues to the number of vCPUs by default on virtio-blk and
> virtio-scsi PCI devices.  Older machine types continue to default to 1 queue
> for live migration compatibility.
> 
> Random read performance:
>       IOPS
> q=1    78k
> q=32  104k  +33%
> 
> Boot time:
>       Duration
> q=1        51s
> q=32     1m41s  +98%
> 
> Guest configuration: 32 vCPUs, 101 virtio-blk-pci disks
> 
> Previously measured results on a 4 vCPU guest were also positive but showed a
> smaller 1-4% performance improvement.  They are no longer valid because
> significant event loop optimizations have been merged.

I'm guessing this should be deferred to the next release as
it (narrowly) missed the freeze window. Does this make sense to you?

> Stefan Hajnoczi (5):
>   virtio-pci: add virtio_pci_optimal_num_queues() helper
>   virtio-scsi: introduce a constant for fixed virtqueues
>   virtio-scsi: default num_queues to -smp N
>   virtio-blk: default num_queues to -smp N
>   vhost-user-blk: default num_queues to -smp N
> 
>  hw/virtio/virtio-pci.h             |  9 +++++++++
>  include/hw/virtio/vhost-user-blk.h |  2 ++
>  include/hw/virtio/virtio-blk.h     |  2 ++
>  include/hw/virtio/virtio-scsi.h    |  5 +++++
>  hw/block/vhost-user-blk.c          |  6 +++++-
>  hw/block/virtio-blk.c              |  6 +++++-
>  hw/core/machine.c                  |  5 +++++
>  hw/scsi/vhost-scsi.c               |  3 ++-
>  hw/scsi/vhost-user-scsi.c          |  5 +++--
>  hw/scsi/virtio-scsi.c              | 13 ++++++++----
>  hw/virtio/vhost-scsi-pci.c         |  9 +++++++--
>  hw/virtio/vhost-user-blk-pci.c     |  4 ++++
>  hw/virtio/vhost-user-scsi-pci.c    |  9 +++++++--
>  hw/virtio/virtio-blk-pci.c         |  7 ++++++-
>  hw/virtio/virtio-pci.c             | 32 ++++++++++++++++++++++++++++++
>  hw/virtio/virtio-scsi-pci.c        |  9 +++++++--
>  16 files changed, 110 insertions(+), 16 deletions(-)
> 
> -- 
> 2.26.2
> 


