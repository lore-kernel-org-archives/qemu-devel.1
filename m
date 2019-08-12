Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C098C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 14:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF4F20679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 14:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF4F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxBiU-0001xE-78
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 10:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38161)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hxBi4-0001XJ-6c
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hxBi2-0007yg-AT
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:54:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hxBi2-0007yL-6B
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:54:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id v38so10675339qtb.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 07:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=chaha37BOvm6uH7hzHSHuzYukUJUn9WAu/Bntbdtsvg=;
 b=YRztPox/hI+xr7lzejSZv918lUuXZgV+o2/moEk5Ywetcb6Xk7b9AsI7AZ+7emH5qk
 AzhYNTQLUV9Nn9CtjUBQFGnVLu6MUj49/S9qwUI/SAg+ox219ULtigz6e7ePt/tByLNn
 E/W+k/H0DFw4aQIU44a4O/ykwukMISazUsvVtO+pI1KRSXxEUa/wrUdqxrjzY4ttD831
 Yl6K2CTlf7tSjPX5HiFhtLHydGOvtlrkHAnr3SU7GK54Kj99envdfYh9YlzhWJXBuh2w
 eWD9CEhvhw6O43toBkTPHz7deizjvIVa073wSGf1S2djwUyyssGYbdGuz2y+qQgPWS41
 BuRQ==
X-Gm-Message-State: APjAAAUcvH0ZFAUoHqWMS72NmZlmuMVxHKquq+SQ6lEKVy+ubKym0yzT
 rmTpJHQ7VGveayKs2pqXE9kGtw==
X-Google-Smtp-Source: APXvYqzlRl2YaVxUCsHppTvq6Qp3cF2ElYaxRb1h1lhgjW6IO4/jUCtyc6MOJ8ani5mzwPbHAPYMBQ==
X-Received: by 2002:a0c:b755:: with SMTP id q21mr30070846qve.92.1565621644828; 
 Mon, 12 Aug 2019 07:54:04 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 p3sm68437575qta.12.2019.08.12.07.54.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 07:54:03 -0700 (PDT)
Date: Mon, 12 Aug 2019 10:53:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190812105321-mutt-send-email-mst@kernel.org>
References: <20190802150605.5880-1-jfreimann@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802150605.5880-1-jfreimann@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
Subject: Re: [Qemu-devel] [PATCH v2 0/9] add failover feature for assigned
 network devices
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 aadam@redhat.com, qemu-devel@nongnu.org, laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 02, 2019 at 05:05:56PM +0200, Jens Freimann wrote:
> This is implementing the host side of the net_failover concept
> (https://www.kernel.org/doc/html/latest/networking/net_failover.html)

Virtio bits look fine. Anyone else wants to comment on
management/migration aspects?
Which tree should this be merged in? Mine?

> Changes since v1:
> - add new QMP events,
>    - one is send when the primary device is unplugged
>    - one is send when VIRTIO_NET_F_STANDBY is not negotiated.
>      This is needed because we hide the primary device until
>      the feature bit is negotiated and then add it with
>      qdev_add_device(). The event is for libvirt to be aware of that.
> - patch 7/9: a new migration state, called wait-unplug.
>   It is entered after SETUP and before ACTIVE. In this phase we check
>   devices for pending guest unplug complete event.
>   This patch still has a problem. It checks in a loop if there are still
>   devices that are not unplugged by the guest. If the guest never
>   returns it will run forever. How to terminate this loop? I thought
>   about a timed wait semaphore or just spinning for a certain amount of time,
>   but nothing seems good. Any ideas here?
> - patch 2/9: When unplugging the primary devices, only do the guest part i.e.
>   call hotplug_handler_unplug_request() which calls the pcie attention
>   button code. The unrealize part is not done so the ressources of the
>   device are not freed.  In case of migration failure we can re-plug the device to
>   the guest with hotplug_handler_hotplug(). I tested migration failure and
>   a following second attempt to migrate that doesn't fail.
> - add the primary device on the target VM, done in runstate change
>   handler.
> - fix error reporting (dgilbert)
> - get rid of timer to add device after feature negotiation
> 
> The general idea is that we have a pair of devices, a vfio-pci and a
> virtio-net device. Before migration the vfio device is unplugged and data
> flows to the virtio-net device, on the target side another vfio-pci device
> is plugged in to take over the data-path. In the guest the net_failover
> module will pair net devices with the same MAC address.
> 
> * Patch 1 adds the infrastructure to hide the device for the qbus and qdev APIs
> 
> * Patch 2 In the second patch the virtio-net uses the API to defer adding the vfio
>   device until the VIRTIO_NET_F_STANDBY feature is acked. It also
>   implements the migration handler to unplug the device from the guest and
>   re-plug in case of migration failure
> 
> * Patch 3 and 4 make sure that we can unplug the vfio-device before
>   migration starts
> 
> * Patch 5 and 6 add new qmp events, one sends the device id of a device
>   that was just requested to be unplugged from the guest and another one
>   to let libvirt know if VIRTIO_NET_F_STANDBY was negotiated
> 
> * Patch 7 adds a new migration state that is entered while we wait for
>   devices to be unplugged by guest OS
> 
> * Patch 8 sets a new flag for PCIDevice 'partially_hotplugged' which we
>   use to skip the unrealize code path when doing a unplug of the primary
>   device
> 
> * Patch 9 sets the pending_deleted_event before triggering the guest
>   unplug request
> 
> Previous discussion:
>   RFC v1 https://patchwork.ozlabs.org/cover/989098/
>   RFC v2 https://www.mail-archive.com/qemu-devel@nongnu.org/msg606906.html
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03968.html
> 
> To summarize concerns/feedback from previous discussion:
> 1.- guest OS can reject or worse _delay_ unplug by any amount of time.
>   Migration might get stuck for unpredictable time with unclear reason.
>   This approach combines two tricky things, hot/unplug and migration.
>   -> We need to let libvirt know what's happening. Add new qmp events
>      and a new migration state. When a primary device is (partially)
>      unplugged (only from guest) we send a qmp event with the device id. When
>      it is unplugged from the guest the DEVICE_DELETED event is sent.
>      Migration will enter the wait-unplug state while waiting for the guest
>      os to unplug all primary devices and then move on with migration.
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
>      One of the problems that stopped management software and libvirt from
>      implementing this idea is that it can't be sure that it's possible to
>      re-plug the primary device. By not freeing the devices resources in QEMU
>      and only asking the guest OS to unplug it is possible to re-plug the
>      device in case of a migration failure.
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
> 	-device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1 \
>         /root/rhel-guest-image-8.0-1781.x86_64.qcow2
> 
> I'm grateful for any remarks or ideas!
> 
> Thanks!
> 
> Changes from RFCv2 to v1:
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
> 
> 
> Jens Freimann (9):
>   qdev/qbus: Add hidden device support
>   net/virtio: add failover support
>   vfio: unplug failover primary device before migration
>   migration: allow unplug during migration for failover devices
>   qapi: add unplug primary event
>   qapi: Add failover negotiated event
>   migration: Add new migration state wait-unplug
>   pci: mark devices partially unplugged
>   pci: mark device having guest unplug request pending
> 
>  hw/core/qdev.c                 |  20 ++++
>  hw/net/virtio-net.c            | 180 +++++++++++++++++++++++++++++++++
>  hw/pci/pci.c                   |   2 +
>  hw/pci/pcie.c                  |   6 ++
>  hw/vfio/pci.c                  |  25 ++++-
>  hw/vfio/pci.h                  |   2 +
>  include/hw/pci/pci.h           |   1 +
>  include/hw/qdev-core.h         |   9 ++
>  include/hw/virtio/virtio-net.h |  13 +++
>  include/hw/virtio/virtio.h     |   1 +
>  include/migration/vmstate.h    |   2 +
>  migration/migration.c          |  14 +++
>  migration/savevm.c             |  18 ++++
>  migration/savevm.h             |   1 +
>  qapi/migration.json            |  24 ++++-
>  qapi/net.json                  |  16 +++
>  qdev-monitor.c                 |  43 +++++++-
>  vl.c                           |   6 +-
>  18 files changed, 375 insertions(+), 8 deletions(-)
> 
> -- 
> 2.21.0

