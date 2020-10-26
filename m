Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC85C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD7C2224A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iK3l6n7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD7C2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5MY-0007xZ-1F
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kX5EO-0004EY-4L
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kX5ED-0008Vy-Pg
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603729212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVYVXN+VdlIVX2StSCRXHS6thPmT3rFbTAnHRUM57gA=;
 b=iK3l6n7YxkKrLc5c4kjsY7c8pxsxB3RYUOz7Sf47doi8OCEYknF40yS6RDY9fVh/RQsgYl
 TqTXpNguLdBEhQC4kyVFz7C4QfM4cgB5Ztj0aVXqeFHmTzy/eG6XIkMUh9aqWIRashcUOd
 7fmdIrcb33eniK2f8QN/U0CXX+4iknw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-MIS_qzwZMqia2T_x6f2ECQ-1; Mon, 26 Oct 2020 12:20:10 -0400
X-MC-Unique: MIS_qzwZMqia2T_x6f2ECQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2ACD1084C8E;
 Mon, 26 Oct 2020 16:20:05 +0000 (UTC)
Received: from gondolin (ovpn-113-108.ams2.redhat.com [10.36.113.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B50619D6C;
 Mon, 26 Oct 2020 16:19:50 +0000 (UTC)
Date: Mon, 26 Oct 2020 17:19:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH 00/13] s390x/pci: s390-pci updates for kernel 5.10-rc1
Message-ID: <20201026171947.0f302dcc.cohuck@redhat.com>
In-Reply-To: <1603726481-31824-1-git-send-email-mjrosato@linux.ibm.com>
References: <1603726481-31824-1-git-send-email-mjrosato@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 11:34:28 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Combined set of patches that exploit vfio/s390-pci features available in
> kernel 5.10-rc1.  This patch set is a combination of 
> 
> [PATCH v4 0/5] s390x/pci: Accomodate vfio DMA limiting
> 
> and
> 
> [PATCH v3 00/10] Retrieve zPCI hardware information from VFIO
> 
> with duplicate patches removed and a single header sync.  All patches have
> prior maintainer reviews except for:
> 
> - Patch 1 (update-linux-headers change to add new file) 

That one has ;)

> - Patch 2 (header sync against 5.10-rc1)

I'm still unsure about the rdma/(q)atomic stuff -- had we reached any
conclusion there?

> - Patch 13 - contains a functional (debug) change; I switched from using
>   DPRINTFs to using trace events per Connie's request.
> 
> 
> 
> Matthew Rosato (10):
>   update-linux-headers: Add vfio_zdev.h
>   linux-headers: update against 5.10-rc1
>   s390x/pci: Move header files to include/hw/s390x
>   vfio: Create shared routine for scanning info capabilities
>   vfio: Find DMA available capability
>   s390x/pci: Add routine to get the vfio dma available count
>   s390x/pci: Honor DMA limits set by vfio
>   s390x/pci: clean up s390 PCI groups
>   vfio: Add routine for finding VFIO_DEVICE_GET_INFO capabilities
>   s390x/pci: get zPCI function info from host
> 
> Pierre Morel (3):
>   s390x/pci: create a header dedicated to PCI CLP
>   s390x/pci: use a PCI Group structure
>   s390x/pci: use a PCI Function structure
> 
>  MAINTAINERS                                        |   1 +
>  hw/s390x/meson.build                               |   1 +
>  hw/s390x/s390-pci-bus.c                            |  91 ++++++-
>  hw/s390x/s390-pci-inst.c                           |  78 ++++--
>  hw/s390x/s390-pci-vfio.c                           | 276 +++++++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c                         |   2 +-
>  hw/s390x/trace-events                              |   6 +
>  hw/vfio/common.c                                   |  62 ++++-
>  {hw => include/hw}/s390x/s390-pci-bus.h            |  22 ++
>  .../hw/s390x/s390-pci-clp.h                        | 123 +--------
>  include/hw/s390x/s390-pci-inst.h                   | 119 +++++++++
>  include/hw/s390x/s390-pci-vfio.h                   |  23 ++
>  include/hw/vfio/vfio-common.h                      |   4 +
>  .../drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h |  14 +-
>  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h        |   2 +-
>  include/standard-headers/linux/ethtool.h           |   2 +
>  include/standard-headers/linux/fuse.h              |  50 +++-
>  include/standard-headers/linux/input-event-codes.h |   4 +
>  include/standard-headers/linux/pci_regs.h          |   6 +-
>  include/standard-headers/linux/virtio_fs.h         |   3 +
>  include/standard-headers/linux/virtio_gpu.h        |  19 ++
>  include/standard-headers/linux/virtio_mmio.h       |  11 +
>  include/standard-headers/linux/virtio_pci.h        |  11 +-
>  linux-headers/asm-arm64/kvm.h                      |  25 ++
>  linux-headers/asm-arm64/mman.h                     |   1 +
>  linux-headers/asm-generic/hugetlb_encode.h         |   1 +
>  linux-headers/asm-generic/unistd.h                 |  18 +-
>  linux-headers/asm-mips/unistd_n32.h                |   1 +
>  linux-headers/asm-mips/unistd_n64.h                |   1 +
>  linux-headers/asm-mips/unistd_o32.h                |   1 +
>  linux-headers/asm-powerpc/unistd_32.h              |   1 +
>  linux-headers/asm-powerpc/unistd_64.h              |   1 +
>  linux-headers/asm-s390/unistd_32.h                 |   1 +
>  linux-headers/asm-s390/unistd_64.h                 |   1 +
>  linux-headers/asm-x86/kvm.h                        |  20 ++
>  linux-headers/asm-x86/unistd_32.h                  |   1 +
>  linux-headers/asm-x86/unistd_64.h                  |   1 +
>  linux-headers/asm-x86/unistd_x32.h                 |   1 +
>  linux-headers/linux/kvm.h                          |  19 ++
>  linux-headers/linux/mman.h                         |   1 +
>  linux-headers/linux/vfio.h                         |  29 ++-
>  linux-headers/linux/vfio_zdev.h                    |  78 ++++++
>  scripts/update-linux-headers.sh                    |   2 +-
>  43 files changed, 961 insertions(+), 173 deletions(-)
>  create mode 100644 hw/s390x/s390-pci-vfio.c
>  rename {hw => include/hw}/s390x/s390-pci-bus.h (94%)
>  rename hw/s390x/s390-pci-inst.h => include/hw/s390x/s390-pci-clp.h (59%)
>  create mode 100644 include/hw/s390x/s390-pci-inst.h
>  create mode 100644 include/hw/s390x/s390-pci-vfio.h
>  create mode 100644 linux-headers/linux/vfio_zdev.h
> 


