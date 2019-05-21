Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596DEC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2248721773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2248721773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50627 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1m2-00075B-8N
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:13:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT1j3-0004k0-Lt
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT1j2-0002yp-4G
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:10:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hT1j1-0002xq-WF
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:10:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id z6so10640741qkl.10
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=JlTLQqm5Q1So/Z4/KmDfyVgO0zaxsHBwEZLn9UUKVXU=;
	b=Qnwm8q1E/8r3Z1JzS3hVfqePfSS4VibDYVS5YNSWZ+eiIdsyF54aPWKgYkyy+wbp7d
	MEV7sxV+PdOBLIvzV/hFz8eVY+W8XCiEZEmgwG22sfWkrYDdKFIG3DV+FLJAZ4L8GADG
	feMkCZdQDaRu60QHEquSdG3xPijlIZnAW8tbEhRYqSpRn5NojyxN8hsboJGXIY7Zuwoe
	GxyhNHuuNO/qcaF/A2vk1ve9LRsKXhiPue+Nz6mOfqIjhnOM+q4pAFgSyA6v/KUi7a2y
	h32bdf8fdguupBtklXxuIEpE0foNwztFjFBUiHkSSqfWTL8rGtQ0XWqyO3pZxxEx63Az
	7n9g==
X-Gm-Message-State: APjAAAXWUQ7zIL/7wAwlplVhvZNJtteQQPJuFlgP9OeQVs6RakoMSBAw
	0v/jmJURxCZczTntcEhaqTKyhw==
X-Google-Smtp-Source: APXvYqwXLvZniFQDBAMgWF40cbZ04B3ve+IDqana/BRhCOYpHMOfcTeND1lxKyP8y4cFMPGcAQw4NQ==
X-Received: by 2002:a05:620a:13fc:: with SMTP id
	h28mr39765274qkl.164.1558433427383; 
	Tue, 21 May 2019 03:10:27 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	h20sm11558585qtc.16.2019.05.21.03.10.25
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 21 May 2019 03:10:26 -0700 (PDT)
Date: Tue, 21 May 2019 06:10:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190521060725-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517125820.2885-1-jfreimann@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.196
Subject: Re: [Qemu-devel] [PATCH 0/4] add failover feature for assigned
 network devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	aadam@redhat.com, qemu-devel@nongnu.org, laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 02:58:16PM +0200, Jens Freimann wrote:
> This is another attempt at implementing the host side of the
> net_failover concept
> (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
> 
> Changes since last RFC:
> - work around circular dependency of commandline options. Just add
>   failover=on to the virtio-net standby options and reference it from
>   primary (vfio-pci) device with standby=<id>  
> - add patch 3/4 to allow migration of vfio-pci device when it is part of a
>   failover pair, still disallow for all other devices
> - add patch 4/4 to allow unplug of device during migrationm, make an
>   exception for failover primary devices. I'd like feedback on how to
>   solve this more elegant. I added a boolean to DeviceState, have it
>   default to false for all devices except for primary devices. 
> - not tested yet with surprise removal
> - I don't expect this to go in as it is, still needs more testing but
>   I'd like to get feedback on above mentioned changes.
> 
> The general idea is that we have a pair of devices, a vfio-pci and a
> emulated device. Before migration the vfio device is unplugged and data
> flows to the emulated device, on the target side another vfio-pci device
> is plugged in to take over the data-path. In the guest the net_failover
> module will pair net devices with the same MAC address.
> 
> * In the first patch the infrastructure for hiding the device is added
>   for the qbus and qdev APIs. 
> 
> * In the second patch the virtio-net uses the API to defer adding the vfio
>   device until the VIRTIO_NET_F_STANDBY feature is acked.
> 
> Previous discussion: 
>   RFC v1 https://patchwork.ozlabs.org/cover/989098/
>   RFC v2 https://www.mail-archive.com/qemu-devel@nongnu.org/msg606906.html
> 
> To summarize concerns/feedback from previous discussion:
> 1.- guest OS can reject or worse _delay_ unplug by any amount of time.
>   Migration might get stuck for unpredictable time with unclear reason.
>   This approach combines two tricky things, hot/unplug and migration. 
>   -> We can surprise-remove the PCI device and in QEMU we can do all
>      necessary rollbacks transparent to management software. Will it be
>      easy, probably not.
> 2. PCI devices are a precious ressource. The primary device should never
>   be added to QEMU if it won't be used by guest instead of hiding it in
>   QEMU. 
>   -> We only hotplug the device when the standby feature bit was
>      negotiated. We save the device cmdline options until we need it for
>      qdev_device_add()
>      Hiding a device can be a useful concept to model. For example a
>      pci device in a powered-off slot could be marked as hidden until the slot is
>      powered on (mst).
> 3. Management layer software should handle this. Open Stack already has
>   components/code to handle unplug/replug VFIO devices and metadata to
>   provide to the guest for detecting which devices should be paired.
>   -> An approach that includes all software from firmware to
>      higher-level management software wasn't tried in the last years. This is
>      an attempt to keep it simple and contained in QEMU as much as possible.
> 4. Hotplugging a device and then making it part of a failover setup is
>    not possible
>   -> addressed by extending qdev hotplug functions to check for hidden
>      attribute, so e.g. device_add can be used to plug a device.
> 
> 
> I have tested this with a mlx5 NIC and was able to migrate the VM with
> above mentioned workarounds for open problems.
> 
> Command line example:
> 
> qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
>         -machine q35,kernel-irqchip=split -cpu host   \
>         -k fr   \
>         -serial stdio   \
>         -net none \
>         -qmp unix:/tmp/qmp.socket,server,nowait \
>         -monitor telnet:127.0.0.1:5555,server,nowait \
>         -device pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
>         -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
>         -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
>         -netdev tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
>         -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,failover=on \                                                                                    
>         /root/rhel-guest-image-8.0-1781.x86_64.qcow2
> 
> Then the primary device can be hotplugged via
>  (qemu) device_add vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1
> 
> 
> I'm grateful for any remarks or ideas!
> 
> Thanks!

Hi Jens!
Overall I like the patches. Thanks!

Could you please tell us a bit more about other hardware: does this work
more or less universally across vendors? were any other cards tested?

Thanks in advance.

> 
> Jens Freimann (4):
>   migration: allow unplug during migration for failover devices
>   qdev/qbus: Add hidden device support
>   net/virtio: add failover support
>   vfio: unplug failover primary device before migration
> 
>  hw/core/qdev.c                 |  20 ++++++
>  hw/net/virtio-net.c            | 117 +++++++++++++++++++++++++++++++++
>  hw/vfio/pci.c                  |  25 ++++++-
>  hw/vfio/pci.h                  |   2 +
>  include/hw/qdev-core.h         |  10 +++
>  include/hw/virtio/virtio-net.h |  12 ++++
>  qdev-monitor.c                 |  43 ++++++++++--
>  vl.c                           |   6 +-
>  8 files changed, 228 insertions(+), 7 deletions(-)
> 
> -- 
> 2.21.0

