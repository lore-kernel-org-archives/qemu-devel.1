Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6725CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F38E208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F38E208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8MP-0001WT-Gq
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iP7QB-0006QP-LD
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iP7Q8-0004EB-A5
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:59:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28580)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iP7Q6-0004BQ-2F
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:59:04 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1250D8553D
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 15:59:00 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id a13so8283410qkc.17
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nMWAnY6McylHcGTvc+B7VrN+HbqR4plgo+YW/WXOm7U=;
 b=rMIe3RXUlfUKB5gWBC6s80CMv7OhFzIM4Xj7uPFOqS6GZLf9rNtuOV6fZQs+YECS11
 nN36oFR1pMBnlY4eCLDZY8C3kH5ZXyb3Nqq7TNg1lDiuhSQuiIx4tWJmbvVlskRBjvjV
 DE2ZHVPfCP82Wov2Cyud+iUZfmu9fySOHzWkUzv/bZe+lchFjKyDhG0O469UGlROqsLR
 Rht51I0NSGgyXvjbExxg86AjuciWOzectyVVDH3UvrgfcwYQ0BnWdDG3+gKKhHmblUAx
 zrJz04qD5V+5y8Ovf5aEHnQPgV3HCB9lBwQvmdgAHsJwz3vdsxPaf+vO3wNZMGOF2c1B
 OZrw==
X-Gm-Message-State: APjAAAVaQyw05X3ttBmWLj+hycxnh9vGFcR2Uvqr97iWTr+/hF22T84d
 gujkJ7JVen3RZVh2yjCjLpO3V/YWoQSIx8W7MMP7H6To2lAG0e0268G+ynOuCoCX3g5DTQa7a5z
 0iiNrUDMuBfEXeTY=
X-Received: by 2002:ad4:4d0f:: with SMTP id l15mr10957615qvl.78.1572278339206; 
 Mon, 28 Oct 2019 08:58:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAA1G0s1q3mJXZBoSh/sGMoKtLIOdn/XR+t4enawzGwyaheI0aXNVp2rMIuY7bYzWyYYAKzQ==
X-Received: by 2002:ad4:4d0f:: with SMTP id l15mr10957589qvl.78.1572278338811; 
 Mon, 28 Oct 2019 08:58:58 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 r2sm7522266qtc.28.2019.10.28.08.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:58 -0700 (PDT)
Date: Mon, 28 Oct 2019 11:58:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v6 0/11] add failover feature for assigned network devices
Message-ID: <20191028115750-mutt-send-email-mst@kernel.org>
References: <20191025121930.6855-1-jfreimann@redhat.com>
 <20191028102723.jwfzxp6mav6ce62g@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028102723.jwfzxp6mav6ce62g@jenstp.localdomain>
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
Cc: aadam@redhat.com, ailan@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I see at least comments from Markus.
You answered but don't you need to also tweak the patch?


On Mon, Oct 28, 2019 at 11:27:23AM +0100, Jens Freimann wrote:
> Hi Michael,
> 
> I addressed all comments and feedback and think this can be merged but
> I'm unclear about which tree it should go to. Will you merge it into
> the virtio-tree?
> 
> regards,
> Jens
> 
> On Fri, Oct 25, 2019 at 02:19:19PM +0200, Jens Freimann wrote:
> > This is implementing the host side of the net_failover concept
> > (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
> > 
> > Changes since v5:
> > * rename net_failover_pair_id parameter/property to failover_pair_id
> > * in PCI code use pci_bus_is_express(). This won't fail on functions > 0
> > * make sure primary and standby can't be added to same PCI slot
> > * add documentation file in docs/ to virtio-net patch, add file to
> >   MAINTAINERS (added to networking devices section)
> > * add comment to QAPI event for failover negotiation, try to improve
> >   commit message
> > 
> > The general idea is that we have a pair of devices, a vfio-pci and a
> > virtio-net device. Before migration the vfio device is unplugged and data
> > flows to the virtio-net device, on the target side another vfio-pci device
> > is plugged in to take over the data-path. In the guest the net_failover
> > module will pair net devices with the same MAC address.
> > 
> > * Patch 1 adds the infrastructure to hide the device for the qbus and qdev APIs
> > 
> > * Patch 2 adds checks to PCIDevice for only allowing ethernet devices as
> >  failover primary and only PCIExpress capable devices
> > 
> > * Patch 3 sets a new flag for PCIDevice 'partially_hotplugged' which we
> >  use to skip the unrealize code path when doing a unplug of the primary
> >  device
> > 
> > * Patch 4 sets the pending_deleted_event before triggering the guest
> >  unplug request
> > 
> > * Patch 5 and 6 add new qmp events, one sends the device id of a device
> >  that was just requested to be unplugged from the guest and another one
> >  to let libvirt know if VIRTIO_NET_F_STANDBY was negotiated
> > 
> > * Patch 7 make sure that we can unplug the vfio-device before
> >  migration starts
> > 
> > * Patch 8 adds a new migration state that is entered while we wait for
> >  devices to be unplugged by guest OS
> > 
> > * Patch 9 just adds the new migration state to a check in libqos code
> > 
> > * Patch 10 In the second patch the virtio-net uses the API to defer adding the vfio
> >  device until the VIRTIO_NET_F_STANDBY feature is acked. It also
> >  implements the migration handler to unplug the device from the guest and
> >  re-plug in case of migration failure
> > 
> > * Patch 11 allows migration for failover vfio-pci devices
> > 
> > Previous discussion:
> >  RFC v1 https://patchwork.ozlabs.org/cover/989098/
> >  RFC v2 https://www.mail-archive.com/qemu-devel@nongnu.org/msg606906.html
> >  v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03968.html
> >  v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg635214.html
> >  v3: https://patchew.org/QEMU/20191011112015.11785-1-jfreimann@redhat.com/
> >  v4: https://patchew.org/QEMU/20191018202040.30349-1-jfreimann@redhat.com/
> >  v5: https://patchew.org/QEMU/20191023082711.16694-1-jfreimann@redhat.com/
> > 
> > To summarize concerns/feedback from previous discussion:
> > 1.- guest OS can reject or worse _delay_ unplug by any amount of time.
> >  Migration might get stuck for unpredictable time with unclear reason.
> >  This approach combines two tricky things, hot/unplug and migration.
> >  -> We need to let libvirt know what's happening. Add new qmp events
> >     and a new migration state. When a primary device is (partially)
> >     unplugged (only from guest) we send a qmp event with the device id. When
> >     it is unplugged from the guest the DEVICE_DELETED event is sent.
> >     Migration will enter the wait-unplug state while waiting for the guest
> >     os to unplug all primary devices and then move on with migration.
> > 2. PCI devices are a precious ressource. The primary device should never
> >  be added to QEMU if it won't be used by guest instead of hiding it in
> >  QEMU.
> >  -> We only hotplug the device when the standby feature bit was
> >     negotiated. We save the device cmdline options until we need it for
> >     qdev_device_add()
> >     Hiding a device can be a useful concept to model. For example a
> >     pci device in a powered-off slot could be marked as hidden until the slot is
> >     powered on (mst).
> > 3. Management layer software should handle this. Open Stack already has
> >  components/code to handle unplug/replug VFIO devices and metadata to
> >  provide to the guest for detecting which devices should be paired.
> >  -> An approach that includes all software from firmware to
> >     higher-level management software wasn't tried in the last years. This is
> >     an attempt to keep it simple and contained in QEMU as much as possible.
> >     One of the problems that stopped management software and libvirt from
> >     implementing this idea is that it can't be sure that it's possible to
> >     re-plug the primary device. By not freeing the devices resources in QEMU
> >     and only asking the guest OS to unplug it is possible to re-plug the
> >     device in case of a migration failure.
> > 4. Hotplugging a device and then making it part of a failover setup is
> >   not possible
> >  -> addressed by extending qdev hotplug functions to check for hidden
> >     attribute, so e.g. device_add can be used to plug a device.
> > 
> > 
> > I have tested this with a mlx5 and igb NIC and was able to migrate the VM.
> > 
> > Command line example:
> > 
> > qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
> >        -machine q35,kernel-irqchip=split -cpu host   \
> >        -serial stdio   \
> >        -net none \
> >        -qmp unix:/tmp/qmp.socket,server,nowait \
> >        -monitor telnet:127.0.0.1:5555,server,nowait \
> >        -device pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
> >        -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
> >        -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
> >        -netdev tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
> >        -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,failover=on \
> > 	-device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,failover_pair_id =net1 \
> >        /root/rhel-guest-image-8.0-1781.x86_64.qcow2
> > 
> > I'm grateful for any remarks or ideas!
> > 
> > Thanks!
> > 
> > regards,
> > Jens
> > 
> > 
> > Jens Freimann (11):
> >  qdev/qbus: add hidden device support
> >  pci: add option for net failover
> >  pci: mark devices partially unplugged
> >  pci: mark device having guest unplug request pending
> >  qapi: add unplug primary event
> >  qapi: add failover negotiated event
> >  migration: allow unplug during migration for failover devices
> >  migration: add new migration state wait-unplug
> >  libqos: tolerate wait-unplug migration state
> >  net/virtio: add failover support
> >  vfio: unplug failover primary device before migration
> > 
> > MAINTAINERS                    |   1 +
> > docs/virtio-net-failover.rst   |  68 ++++++++
> > hw/core/qdev.c                 |  25 +++
> > hw/net/virtio-net.c            | 302 +++++++++++++++++++++++++++++++++
> > hw/pci/pci.c                   |  32 ++++
> > hw/pci/pcie.c                  |   6 +
> > hw/vfio/pci.c                  |  26 ++-
> > hw/vfio/pci.h                  |   1 +
> > include/hw/pci/pci.h           |   4 +
> > include/hw/qdev-core.h         |  30 ++++
> > include/hw/virtio/virtio-net.h |  12 ++
> > include/hw/virtio/virtio.h     |   1 +
> > include/migration/vmstate.h    |   2 +
> > migration/migration.c          |  21 +++
> > migration/migration.h          |   3 +
> > migration/savevm.c             |  36 ++++
> > migration/savevm.h             |   2 +
> > qapi/migration.json            |  24 ++-
> > qapi/net.json                  |  19 +++
> > qdev-monitor.c                 |  43 ++++-
> > tests/libqos/libqos.c          |   3 +-
> > vl.c                           |   6 +-
> > 22 files changed, 652 insertions(+), 15 deletions(-)
> > create mode 100644 docs/virtio-net-failover.rst
> > 
> > -- 
> > 2.21.0
> > 
> > 
> 
> 

