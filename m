Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102C2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655E22225B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHsBk1Ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655E22225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyrr-0002pc-Bb
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 16:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kQyKK-0004JA-8F
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kQyKA-0003t4-1x
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cKUJR8ESOdeQSt4KgC8NYFM4qieGHwpkRv8fcbTkjXY=;
 b=MHsBk1FtShkgS6ztiOYlCXamnWYWPi5tcnW3aokQ2j6LlZ7gP3D+LPIdALoTt4R9ifVDVP
 MQVkX0GeXtxN3ZrC22fHS1mrNaJ5LOZe5Rudco03YIpR7jKOyXBFVKaqODCJ1ziM/GaFzC
 RKbzdKndU1XH37D7bquWz329bKZrSJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-9-o4W1A7P5GsaFmUbO_QXA-1; Fri, 09 Oct 2020 15:45:03 -0400
X-MC-Unique: 9-o4W1A7P5GsaFmUbO_QXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 116D856B2C;
 Fri,  9 Oct 2020 19:45:02 +0000 (UTC)
Received: from x1.home (ovpn-113-35.phx2.redhat.com [10.3.113.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A414F6EF77;
 Fri,  9 Oct 2020 19:44:49 +0000 (UTC)
Date: Fri, 9 Oct 2020 13:44:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Requirements for out-of-process device emulation
Message-ID: <20201009134449.041b5e71@x1.home>
In-Reply-To: <20201009161815.GA321402@stefanha-x1.localdomain>
References: <20201009161815.GA321402@stefanha-x1.localdomain>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
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
Cc: John G Johnson <john.g.johnson@oracle.com>,
 Daniele Buono <dbuono@us.ibm.com>, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 Hubertus Franke <frankeh@us.ibm.com>, rust-vmm@lists.opendev.org,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 17:18:15 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Device emulation
> ----------------
> Device resources
> ````````````````
> Devices provide resources that drivers interact with such as hardware
> registers, memory, or interrupts. The fundamental requirement of
> out-of-process device emulation is exposing device resources.
> 
> The following types of device resources are needed:
> 
> Synchronous MMIO/PIO accesses
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> The most basic device emulation operation is the hardware register
> access. This is a memory-mapped I/O (MMIO) or programmed I/O (PIO)
> access to the device. A read loads a value from a device register. A
> write stores a value to a device register. These operations are
> synchronous because the vCPU is paused until completion.
> Asynchronous doorbells
> 
> Devices often have doorbell registers, allowing the driver to inform the
> device that new requests are ready for processing. The vCPU does not
> need to wait since the access is a posted write.
> 
> The kvm.ko ioeventfd mechanism can be used to implement asynchronous
> doorbells.
> 
> Shared device memory
> ~~~~~~~~~~~~~~~~~~~~
> Devices may have memory-like regions that the CPU can access (such as
> PCI Memory BARs). The device emulation process therefore needs to share
> a region of its memory space with the VMM so the guest can access it.
> This mechanism also allows device emulation to busy wait (poll) instead
> of using synchronous MMIO/PIO accesses or asynchronous doorbells for
> notifications.
> 
> Direct Memory Access (DMA)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~
> Devices often require read and write access to a memory address space
> belonging to the CPU. This allows network cards to transmit packet
> payloads that are located in guest RAM, for example.
> 
> Early out-of-process device emulation interfaces simply shared guest
> RAM. The allowed DMA to any guest physical memory address. More advanced
> IOMMU and address space identifier mechanisms are now becoming
> ubiquitous. Therefore, new out-of-process device emulation interfaces
> should incorporate IOMMU functionality.
> 
> The key requirement for IOMMU mechanisms is allowing the VMM to grant
> access to a region of memory so the device emulation process can read
> from and/or write to it.
> 
> Interrupts
> ~~~~~~~~~~
> Devices notify the CPU using interrupts. An interrupt is simply a
> message sent by the device emulation process to the VMM. Interrupt
> configuration is flexible on modern devices, meaning the driver may be
> able to select the number of interrupts and a mapping (using one
> interrupt with multiple event sources). This can be implemented using
> the Linux eventfd mechanism or via in-band device emulation protocol
> messages, for example.
> 
> Extensibility for new bus types
> ```````````````````````````````
> It should be possible to support multiple bus types. vhost-user only
> supports vhost devices. VFIO is more extensible but currently focussed
> on PCI devices.

Wait a sec, the vfio API essentially deconstructs devices into exactly
the resources you've outlined above.  We not only have a vfio-pci
device convention within vfio, but we've defined vfio-platform,
vfio-amba, vfio-ccw, vfio-ap, and we'll likely be adding vfio-fsl-mc in
the next kernel.  The core device, group, and container model within
vfio is completely device/bus agnostic.  So while it's true that
vfio-pci is the most mature and featureful convention, that's largely a
reflection that PCI is the most ubiquitous device interface currently
available.  Thanks,

Alex


