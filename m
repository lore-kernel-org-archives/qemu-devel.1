Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBEAC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D022217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D022217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKrF-0004hY-Jr
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:09:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCKln-0008LQ-9z
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCKeU-00037c-VV
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:56:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41535)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCKeU-00036E-8f
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:56:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20F244E93D;
	Fri,  5 Apr 2019 08:56:45 +0000 (UTC)
Received: from work-vm (ovpn-117-242.ams2.redhat.com [10.36.117.242])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 50ED9614F2;
	Fri,  5 Apr 2019 08:56:31 +0000 (UTC)
Date: Fri, 5 Apr 2019 09:56:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>, armbru@redhat.com
Message-ID: <20190405085628.GA2819@work-vm>
References: <20190322134447.14831-1-jfreimann@redhat.com>
	<20190404082933.ke7tvryocpdd2h54@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190404082933.ke7tvryocpdd2h54@jenstp.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 05 Apr 2019 08:56:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] implement the failover feature for
 assigned network devices
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
Cc: pkrempa@redhat.com, ehabkost@redhat.com, mst@redhat.com,
	mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org,
	liran.alon@oracle.com, laine@redhat.com, ogerlitz@mellanox.com,
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405085629.GROg5uhBQJVcecwjaufDQvV7EUW-qy3TrRoP80kRLGo@z>

* Jens Freimann (jfreimann@redhat.com) wrote:
> ping
> 
> FYI: I'm also working on a few related tools to detect driver behaviour when
> assigning a MAC to the vf device. Code is at https://github.com/jensfr/netfailover_driver_detect

Hi Jens,
  I've not been following this too uch, but:

> regards,
> Jens
> 
> On Fri, Mar 22, 2019 at 02:44:45PM +0100, Jens Freimann wrote:
> > This is another attempt at implementing the host side of the
> > net_failover concept
> > (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
> > 
> > The general idea is that we have a pair of devices, a vfio-pci and a
> > emulated device. Before migration the vfio device is unplugged and data
> > flows to the emulated device, on the target side another vfio-pci device
> > is plugged in to take over the data-path. In the guest the net_failover
> > module will pair net devices with the same MAC address.
> > 
> > * In the first patch the infrastructure for hiding the device is added
> >  for the qbus and qdev APIs. A "hidden" boolean is added to the device
> >  state and it is set based on a callback to the standby device which
> >  registers itself for handling the assessment: "should the primary device
> >  be hidden?" by cross validating the ids of the devices.
> > 
> > * In the second patch the virtio-net uses the API to hide the vfio
> >  device and unhides it when the feature is acked.
> > 
> > Previous discussion: https://patchwork.ozlabs.org/cover/989098/
> > 
> > To summarize concerns/feedback from previous discussion:
> > 1.- guest OS can reject or worse _delay_ unplug by any amount of time.
> >  Migration might get stuck for unpredictable time with unclear reason.
> >  This approach combines two tricky things, hot/unplug and migration.
> >  -> We can surprise-remove the PCI device and in QEMU we can do all
> >     necessary rollbacks transparent to management software. Will it be
> >     easy, probably not.

This sounds 'fun' - bonus cases are things like what happens if the
guest gets rebooted somewhere during the process or if it's currently
sitting in the bios/grub/etc

> > 2. PCI devices are a precious ressource. The primary device should never
> >  be added to QEMU if it won't be used by guest instead of hiding it in
> >  QEMU.
> >  -> We only hotplug the device when the standby feature bit was
> >     negotiated. We save the device cmdline options until we need it for
> >     qdev_device_add()
> >     Hiding a device can be a useful concept to model. For example a
> >     pci device in a powered-off slot could be marked as hidden until the slot is
> >     powered on (mst).

Are they really that precious? Personally it's not something I'd worry
about.

> > 3. Management layer software should handle this. Open Stack already has
> >  components/code to handle unplug/replug VFIO devices and metadata to
> >  provide to the guest for detecting which devices should be paired.
> >  -> An approach that includes all software from firmware to
> >     higher-level management software wasn't tried in the last years. This is
> >     an attempt to keep it simple and contained in QEMU as much as possible.
> > 4. Hotplugging a device and then making it part of a failover setup is
> >   not possible
> >  -> addressed by extending qdev hotplug functions to check for hidden
> >     attribute, so e.g. device_add can be used to plug a device.
> > 
> > There are still some open issues:
> > 
> > Migration: I'm looking for something like a pre-migration hook that I
> > could use to unplug the vfio-pci device. I tried with a migration
> > notifier but it is called to late, i.e. after migration is aborted due
> > to vfio-pci marked unmigrateable. I worked around this by setting it
> > to migrateable and used a migration notifier on the virtio-net device.

Why not just let this happen at the libvirt level; then you do the
hotunplug etc before you actually tell qemu anything about starting a
migration?

> > Commandline: There is a dependency between vfio-pci and virtio-net
> > devices. One points to the other via new parameters
> > primar=<primary qdev id> and standby='<standby qdev id>'. This means
> > that the primary device needs to be specified after standby device on
> > the qemu command line. Not sure how to solve this.
> > 
> > Error handling: Patches don't cover all possible error scenarios yet.
> > 
> > I have tested this with a mlx5 NIC and was able to migrate the VM with
> > above mentioned workarounds for open problems.
> > 
> > Command line example:
> > 
> > qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
> >        -machine q35,kernel-irqchip=split -cpu host   \
> >        -k fr   \
> >        -serial stdio   \
> >        -net none \
> >        -qmp unix:/tmp/qmp.socket,server,nowait \
> >        -monitor telnet:127.0.0.1:5555,server,nowait \
> >        -device pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
> >        -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
> >        -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
> >        -netdev tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
> >        -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,primary=hostdev0 \
> >        -device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1 \

Yes, that's a bit grim; it's circular dependency on the 'hostdev0' and
'net1' id's.  cc'ing in Markus.

Dave

> >        /root/rhel-guest-image-8.0-1781.x86_64.qcow2
> > 
> > I'm grateful for any remarks or ideas!
> > 
> > Thanks!
> > 
> > regards,
> > Jens
> > 
> > Sameeh Jubran (2):
> >  qdev/qbus: Add hidden device support
> >  net/virtio: add failover support
> > 
> > hw/core/qdev.c                 | 27 ++++++++++
> > hw/net/virtio-net.c            | 95 ++++++++++++++++++++++++++++++++++
> > hw/pci/pci.c                   |  1 +
> > include/hw/pci/pci.h           |  2 +
> > include/hw/qdev-core.h         |  8 +++
> > include/hw/virtio/virtio-net.h |  7 +++
> > qdev-monitor.c                 | 48 +++++++++++++++--
> > vl.c                           |  7 ++-
> > 8 files changed, 189 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 
> > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

