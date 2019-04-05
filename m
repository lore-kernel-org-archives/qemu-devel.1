Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3D2C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380262175B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380262175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCYBI-0001Pf-Jl
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 19:23:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCYAU-00018a-Iq
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCYAS-0006Rl-Kh
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:22:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCYAQ-0006NM-JB
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:22:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so1021992qtn.3
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=xUEMLMg9gZVPg6TjjoZl9FS0kFlF006aCKcgFs/GzBk=;
	b=FsnenPEoeE1Unf2bjVe9wV2LOrXge4Tm1aHkbmRuHDfvXbpL8WolqVO8Q4JTB9xHIJ
	NAr3ios1rJtKYug12u/+o8L0mT09TsBUI0uD8woBm2GAryYk/NkV/jyM4wNnunM4r3fo
	DgFOLTphxCvqodfGTlo9ql4fy9AUXV/DQ3BfGQOJ3LnedBjb6I9GR5OaI2cd1Oia9Sm3
	aZ+Q97GFQi4PKWm2vo5F3khzk0HjMZWETIdRkkYULkrom4iBZCc704lwbNMi2j6gs9Nl
	/Gu5mLcNQZq27PNh/HTN2yULz9kFOVmE9V3l2xxl7f0Ki1eVyBL+Ti/qVfUbG2eoXCCA
	Jh2Q==
X-Gm-Message-State: APjAAAVM/dUlQOPHGpvgGMcDQlWgED0Cvo8gREel6UJug7Zr5Tep4Pjl
	2/53N4FbELHhk7yxSX6qV+c2Bg==
X-Google-Smtp-Source: APXvYqz1FmdYomunO5g0Yp1x3aemoaGWZecmTL6nra4zN+eYvLbq21BWK7FoX7b30CuqC3FIGwj1gQ==
X-Received: by 2002:ac8:f24:: with SMTP id e33mr14038975qtk.256.1554506557982; 
	Fri, 05 Apr 2019 16:22:37 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	46sm16489642qtz.87.2019.04.05.16.22.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 16:22:37 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:22:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190405191850-mutt-send-email-mst@kernel.org>
References: <20190322134447.14831-1-jfreimann@redhat.com>
	<20190404082933.ke7tvryocpdd2h54@jenstp.localdomain>
	<20190405085628.GA2819@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190405085628.GA2819@work-vm>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
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
Cc: pkrempa@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
	mdroth@linux.vnet.ibm.com, armbru@redhat.com,
	liran.alon@oracle.com, laine@redhat.com, ogerlitz@mellanox.com,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405232235.yQvNuxKeLx38DeBSiIAgw7e3fOyye-tT9r_ova0kCwo@z>

On Fri, Apr 05, 2019 at 09:56:29AM +0100, Dr. David Alan Gilbert wrote:
> * Jens Freimann (jfreimann@redhat.com) wrote:
> > ping
> > 
> > FYI: I'm also working on a few related tools to detect driver behaviour when
> > assigning a MAC to the vf device. Code is at https://github.com/jensfr/netfailover_driver_detect
> 
> Hi Jens,
>   I've not been following this too uch, but:
> 
> > regards,
> > Jens
> > 
> > On Fri, Mar 22, 2019 at 02:44:45PM +0100, Jens Freimann wrote:
> > > This is another attempt at implementing the host side of the
> > > net_failover concept
> > > (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
> > > 
> > > The general idea is that we have a pair of devices, a vfio-pci and a
> > > emulated device. Before migration the vfio device is unplugged and data
> > > flows to the emulated device, on the target side another vfio-pci device
> > > is plugged in to take over the data-path. In the guest the net_failover
> > > module will pair net devices with the same MAC address.
> > > 
> > > * In the first patch the infrastructure for hiding the device is added
> > >  for the qbus and qdev APIs. A "hidden" boolean is added to the device
> > >  state and it is set based on a callback to the standby device which
> > >  registers itself for handling the assessment: "should the primary device
> > >  be hidden?" by cross validating the ids of the devices.
> > > 
> > > * In the second patch the virtio-net uses the API to hide the vfio
> > >  device and unhides it when the feature is acked.
> > > 
> > > Previous discussion: https://patchwork.ozlabs.org/cover/989098/
> > > 
> > > To summarize concerns/feedback from previous discussion:
> > > 1.- guest OS can reject or worse _delay_ unplug by any amount of time.
> > >  Migration might get stuck for unpredictable time with unclear reason.
> > >  This approach combines two tricky things, hot/unplug and migration.
> > >  -> We can surprise-remove the PCI device and in QEMU we can do all
> > >     necessary rollbacks transparent to management software. Will it be
> > >     easy, probably not.
> 
> This sounds 'fun' - bonus cases are things like what happens if the
> guest gets rebooted somewhere during the process or if it's currently
> sitting in the bios/grub/etc

Um, during which process? Guests are gradually fixed to support
surprise removal well. Part of it is thunderbolt which makes
it incredibly easy. Yes - bios/grub will need to learn to
handle this well.

> > > 2. PCI devices are a precious ressource. The primary device should never
> > >  be added to QEMU if it won't be used by guest instead of hiding it in
> > >  QEMU.
> > >  -> We only hotplug the device when the standby feature bit was
> > >     negotiated. We save the device cmdline options until we need it for
> > >     qdev_device_add()
> > >     Hiding a device can be a useful concept to model. For example a
> > >     pci device in a powered-off slot could be marked as hidden until the slot is
> > >     powered on (mst).
> 
> Are they really that precious? Personally it's not something I'd worry
> about.
> 
> > > 3. Management layer software should handle this. Open Stack already has
> > >  components/code to handle unplug/replug VFIO devices and metadata to
> > >  provide to the guest for detecting which devices should be paired.
> > >  -> An approach that includes all software from firmware to
> > >     higher-level management software wasn't tried in the last years. This is
> > >     an attempt to keep it simple and contained in QEMU as much as possible.
> > > 4. Hotplugging a device and then making it part of a failover setup is
> > >   not possible
> > >  -> addressed by extending qdev hotplug functions to check for hidden
> > >     attribute, so e.g. device_add can be used to plug a device.
> > > 
> > > There are still some open issues:
> > > 
> > > Migration: I'm looking for something like a pre-migration hook that I
> > > could use to unplug the vfio-pci device. I tried with a migration
> > > notifier but it is called to late, i.e. after migration is aborted due
> > > to vfio-pci marked unmigrateable. I worked around this by setting it
> > > to migrateable and used a migration notifier on the virtio-net device.
> 
> Why not just let this happen at the libvirt level; then you do the
> hotunplug etc before you actually tell qemu anything about starting a
> migration?

If qemu frees up resources (as it does on unplug) then libvirt
is not guaranteed it can roll the change back on e.g.
migration failure.

But really another issue is simply that it's a mechanism,
there's no policy that management needs to decide on.
Doing it at lowest possible level ensures all
upper layers benefit with minimal pain.

> > > Commandline: There is a dependency between vfio-pci and virtio-net
> > > devices. One points to the other via new parameters
> > > primar=<primary qdev id> and standby='<standby qdev id>'. This means
> > > that the primary device needs to be specified after standby device on
> > > the qemu command line. Not sure how to solve this.
> > > 
> > > Error handling: Patches don't cover all possible error scenarios yet.
> > > 
> > > I have tested this with a mlx5 NIC and was able to migrate the VM with
> > > above mentioned workarounds for open problems.
> > > 
> > > Command line example:
> > > 
> > > qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
> > >        -machine q35,kernel-irqchip=split -cpu host   \
> > >        -k fr   \
> > >        -serial stdio   \
> > >        -net none \
> > >        -qmp unix:/tmp/qmp.socket,server,nowait \
> > >        -monitor telnet:127.0.0.1:5555,server,nowait \
> > >        -device pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
> > >        -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
> > >        -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
> > >        -netdev tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
> > >        -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,primary=hostdev0 \
> > >        -device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1 \
> 
> Yes, that's a bit grim; it's circular dependency on the 'hostdev0' and
> 'net1' id's.  cc'ing in Markus.
> 
> Dave
> 
> > >        /root/rhel-guest-image-8.0-1781.x86_64.qcow2
> > > 
> > > I'm grateful for any remarks or ideas!
> > > 
> > > Thanks!
> > > 
> > > regards,
> > > Jens
> > > 
> > > Sameeh Jubran (2):
> > >  qdev/qbus: Add hidden device support
> > >  net/virtio: add failover support
> > > 
> > > hw/core/qdev.c                 | 27 ++++++++++
> > > hw/net/virtio-net.c            | 95 ++++++++++++++++++++++++++++++++++
> > > hw/pci/pci.c                   |  1 +
> > > include/hw/pci/pci.h           |  2 +
> > > include/hw/qdev-core.h         |  8 +++
> > > include/hw/virtio/virtio-net.h |  7 +++
> > > qdev-monitor.c                 | 48 +++++++++++++++--
> > > vl.c                           |  7 ++-
> > > 8 files changed, 189 insertions(+), 6 deletions(-)
> > > 
> > > -- 
> > > 2.20.1
> > > 
> > > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

