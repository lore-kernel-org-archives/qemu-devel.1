Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F81ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7D8214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7D8214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvw8-0006cI-49
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIvun-0005vp-NI
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIvuk-00061z-WA
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:29:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIvuk-00061X-Mr
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:29:06 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E016CA380
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 14:29:05 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id 59so9605975qtc.5
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 07:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pJ+0lE4051l8ew2szHzavu90Jwmg0rZjsyua5bK7odI=;
 b=jYYEKFXTTy1A1ZltVtY1YsRvP+HV2C+M+5z+Gg0lx4gSGcIw7MNCY9vlrzs8jYFTGF
 F7aK1ZR6W0qqe82O+oJLi4UW6wzQTbkxtx5vEexZ+3hWu94tKNanK+RfsIpGmvlt1QIv
 GfudrHQfwSQYTOtgeA9hE9PWl1tV5MxFDtm2GXEFgxN3dvYbCbEj58NtKomVIUfnvxOb
 tGP7da0RWHRoLFnuODx+HHN5UaDkvzfOXuVQ49VagB8QdGCvJLoHtpIDanT74cdn5BvY
 u6u2okPMKR9iOTDCGLV2P7S0Dur7aRDW8xk/MJ3ZJOR7Upm2Z8FfiLby9d+tucz3G7hj
 rk8A==
X-Gm-Message-State: APjAAAXYhPyKiJ0l72CI/BEoCtDnkRAUzxMf13vhdLeSWcDJun7Cx+DP
 6gN2glk8S91XTiv45OxcCgryf9mK5bCjvFO0cGrPoqyJORNc7UBX09Sb01dBddn7EkpD9fZ3Ydr
 rD1cL8jGpUBQE408=
X-Received: by 2002:ac8:7302:: with SMTP id x2mr16994174qto.323.1570804144657; 
 Fri, 11 Oct 2019 07:29:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybJYQ313FsqpnKERwMCP5RTyn7AxQPzWwA/DqgVVwEqZVcjp+JsKFntRqSjrwiQf/C/EIExA==
X-Received: by 2002:ac8:7302:: with SMTP id x2mr16994122qto.323.1570804144309; 
 Fri, 11 Oct 2019 07:29:04 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 p56sm5965213qtp.81.2019.10.11.07.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 07:29:03 -0700 (PDT)
Date: Fri, 11 Oct 2019 10:28:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v3 0/10] add failover feature for assigned network devices
Message-ID: <20191011102725-mutt-send-email-mst@kernel.org>
References: <20191011112015.11785-1-jfreimann@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011112015.11785-1-jfreimann@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: parav@mellanox.com, aadam@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 01:20:05PM +0200, Jens Freimann wrote:
> This is implementing the host side of the net_failover concept
> (https://www.kernel.org/doc/html/latest/networking/net_failover.html)


I posted a comment about the migration changes.
Besides that this looks good to me.
I did not look at VFIO parts at all yet.
Alex, could you pls review/ack the VFIO patch?


> Changes since v2:
> * back out of creating failover pair when it is a non-networking
>   vfio-pci device (Alex W)
> * handle migration state change from within the migration thread. I do a
>   timed wait on a semaphore and then check if all unplugs were
>   succesful. Added a new function to each device that checks the device
>   if the unplug for it has happened. When all devices report the succesful
>   unplug *or* the time/retries is up, continue with the migration or
>   cancel. When not all devices could be unplugged I am cancelling at the
>   moment. It is likely that we can't plug it back at the destination which
>   would result in degraded network performance.
> * fix a few bugs regarding re-plug on migration source and target 
> * run full set of tests including migration tests
> * add patch for libqos to tolerate new migration state
> * squashed patch 1 and 2, added patch 8 
>  
> The general idea is that we have a pair of devices, a vfio-pci and a
> virtio-net device. Before migration the vfio device is unplugged and data
> flows to the virtio-net device, on the target side another vfio-pci device
> is plugged in to take over the data-path. In the guest the net_failover
> module will pair net devices with the same MAC address.
> 
> * Patch 1 adds the infrastructure to hide the device for the qbus and qdev APIs
> 
> * Patch 2 sets a new flag for PCIDevice 'partially_hotplugged' which we
>   use to skip the unrealize code path when doing a unplug of the primary
>   device
> 
> * Patch 3 sets the pending_deleted_event before triggering the guest
>   unplug request
> 
> * Patch 4 and 5 add new qmp events, one sends the device id of a device
>   that was just requested to be unplugged from the guest and another one
>   to let libvirt know if VIRTIO_NET_F_STANDBY was negotiated
> 
> * Patch 6 make sure that we can unplug the vfio-device before
>   migration starts
> 
> * Patch 7 adds a new migration state that is entered while we wait for
>   devices to be unplugged by guest OS
> 
> * Patch 8 just adds the new migration state to a check in libqos code
> 
> * Patch 9 In the second patch the virtio-net uses the API to defer adding the vfio
>   device until the VIRTIO_NET_F_STANDBY feature is acked. It also
>   implements the migration handler to unplug the device from the guest and
>   re-plug in case of migration failure
> 
> * Patch 10 allows migration for failover vfio-pci devices, but only when it is
>   a networking device 
> 
> Previous discussion:
>   RFC v1 https://patchwork.ozlabs.org/cover/989098/
>   RFC v2 https://www.mail-archive.com/qemu-devel@nongnu.org/msg606906.html
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03968.html
>   v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg635214.html
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
> I have tested this with a mlx5 and igb NIC and was able to migrate the VM.
> 
> Command line example:
> 
> qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
>         -machine q35,kernel-irqchip=split -cpu host   \
>         -serial stdio   \
>         -net none \
>         -qmp unix:/tmp/qmp.socket,server,nowait \
>         -monitor telnet:127.0.0.1:5555,server,nowait \
>         -device pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
>         -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
>         -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
>         -netdev tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
>         -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,failover=on \
> 	-device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,net_failover_pair_id =net1 \
>         /root/rhel-guest-image-8.0-1781.x86_64.qcow2
> 
> I'm grateful for any remarks or ideas!
> 
> Thanks!
> 
> regards,
> Jens 
> 
> 
> Jens Freimann (10):
>   qdev/qbus: add hidden device support
>   pci: mark devices partially unplugged
>   pci: mark device having guest unplug request pending
>   qapi: add unplug primary event
>   qapi: add failover negotiated event
>   migration: allow unplug during migration for failover devices
>   migration: add new migration state wait-unplug
>   libqos: tolerate wait-unplug migration state
>   net/virtio: add failover support
>   vfio: unplug failover primary device before migration
> 
>  hw/core/qdev.c                 |  20 +++
>  hw/net/virtio-net.c            | 267 +++++++++++++++++++++++++++++++++
>  hw/pci/pci.c                   |   2 +
>  hw/pci/pcie.c                  |   6 +
>  hw/vfio/pci.c                  |  35 ++++-
>  hw/vfio/pci.h                  |   2 +
>  include/hw/pci/pci.h           |   1 +
>  include/hw/qdev-core.h         |  10 ++
>  include/hw/virtio/virtio-net.h |  12 ++
>  include/hw/virtio/virtio.h     |   1 +
>  include/migration/vmstate.h    |   2 +
>  migration/migration.c          |  34 +++++
>  migration/migration.h          |   3 +
>  migration/savevm.c             |  36 +++++
>  migration/savevm.h             |   1 +
>  qapi/migration.json            |  24 ++-
>  qapi/net.json                  |  16 ++
>  qdev-monitor.c                 |  43 +++++-
>  tests/libqos/libqos.c          |   3 +-
>  vl.c                           |   6 +-
>  20 files changed, 515 insertions(+), 9 deletions(-)
> 
> -- 
> 2.21.0

