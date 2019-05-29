Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2352AC04AB6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 02:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB9621019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 02:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB9621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45984 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVoeD-0005cL-Rc
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 22:49:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVodK-0005JG-Tf
	for qemu-devel@nongnu.org; Tue, 28 May 2019 22:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVodH-0008CK-RE
	for qemu-devel@nongnu.org; Tue, 28 May 2019 22:48:06 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hVodG-00085y-FA
	for qemu-devel@nongnu.org; Tue, 28 May 2019 22:48:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id 14so826337qtf.0
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 19:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=Gx6s3toXdO2Z0dlyfVbQbgjO/9OCSFv/a1EOUnN1SeU=;
	b=J7zQhevIC/HeVau4sElt2uL+sMRfLhrwbFwmTy9yZmhp8k768GscmpwTJqpmiaoENX
	/6g7PsQxRSG34GNUNRARYG5I3QMnwnjKzTFVWAEBTgtCPOcJPlE0YslJjspcCuQ5Bc1n
	hyUDI16CJSEAkewYP+A02A0/6yW5pLf5FmG739KkurhjwmR0isGnWwCUKpxW16vmlRy8
	JB6Km7fTklLQ8CuCtXyOJWE18uoe+0auCxxZb+fzthaabZZ158DWGKUEZo/wxB7cB6KS
	FiGXSCemNkULJnDnA7zBdgnkKOgKxmiDWgTBxGHUp3s5g40UI3RGlIY7EHrJcCxG4Ctd
	V2FQ==
X-Gm-Message-State: APjAAAW7q7kkPM5hPzsrroJMi6K3vNn6fRGJbn88Jy4BWukD1SJFYxfr
	ppOPdceX8o2Ut2JE+ctI7J31Jg==
X-Google-Smtp-Source: APXvYqwZlX5pecraFPTE/ARcqnmLwkaT7UdicK31sgBl7z0jzaT4ulmXz3IGdZoCh3SdNGLjebXKuQ==
X-Received: by 2002:ac8:4701:: with SMTP id f1mr11093811qtp.126.1559098081765; 
	Tue, 28 May 2019 19:48:01 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	n124sm6189642qkf.31.2019.05.28.19.48.00
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 28 May 2019 19:48:00 -0700 (PDT)
Date: Tue, 28 May 2019 22:47:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: si-wei liu <si-wei.liu@oracle.com>
Message-ID: <20190528224639-mutt-send-email-mst@kernel.org>
References: <20190322134447.14831-1-jfreimann@redhat.com>
	<20190404082933.ke7tvryocpdd2h54@jenstp.localdomain>
	<20190405085628.GA2819@work-vm>
	<20190405191850-mutt-send-email-mst@kernel.org>
	<0dd75e65-6cf3-893f-a907-d9dc13f10ff5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd75e65-6cf3-893f-a907-d9dc13f10ff5@oracle.com>
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
Cc: pkrempa@redhat.com, ehabkost@redhat.com, armbru@redhat.com,
	qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com,
	liran.alon@oracle.com, laine@redhat.com, ogerlitz@mellanox.com,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 05:35:26PM -0700, si-wei liu wrote:
> 
> 
> On 4/5/2019 4:22 PM, Michael S. Tsirkin wrote:
> > On Fri, Apr 05, 2019 at 09:56:29AM +0100, Dr. David Alan Gilbert wrote:
> > > * Jens Freimann (jfreimann@redhat.com) wrote:
> > > > ping
> > > > 
> > > > FYI: I'm also working on a few related tools to detect driver behaviour when
> > > > assigning a MAC to the vf device. Code is at https://github.com/jensfr/netfailover_driver_detect
> > > Hi Jens,
> > >    I've not been following this too uch, but:
> > > 
> > > > regards,
> > > > Jens
> > > > 
> > > > On Fri, Mar 22, 2019 at 02:44:45PM +0100, Jens Freimann wrote:
> > > > > This is another attempt at implementing the host side of the
> > > > > net_failover concept
> > > > > (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
> > > > > 
> > > > > The general idea is that we have a pair of devices, a vfio-pci and a
> > > > > emulated device. Before migration the vfio device is unplugged and data
> > > > > flows to the emulated device, on the target side another vfio-pci device
> > > > > is plugged in to take over the data-path. In the guest the net_failover
> > > > > module will pair net devices with the same MAC address.
> > > > > 
> > > > > * In the first patch the infrastructure for hiding the device is added
> > > > >   for the qbus and qdev APIs. A "hidden" boolean is added to the device
> > > > >   state and it is set based on a callback to the standby device which
> > > > >   registers itself for handling the assessment: "should the primary device
> > > > >   be hidden?" by cross validating the ids of the devices.
> > > > > 
> > > > > * In the second patch the virtio-net uses the API to hide the vfio
> > > > >   device and unhides it when the feature is acked.
> > > > > 
> > > > > Previous discussion: https://patchwork.ozlabs.org/cover/989098/
> > > > > 
> > > > > To summarize concerns/feedback from previous discussion:
> > > > > 1.- guest OS can reject or worse _delay_ unplug by any amount of time.
> > > > >   Migration might get stuck for unpredictable time with unclear reason.
> > > > >   This approach combines two tricky things, hot/unplug and migration.
> > > > >   -> We can surprise-remove the PCI device and in QEMU we can do all
> > > > >      necessary rollbacks transparent to management software. Will it be
> > > > >      easy, probably not.
> > > This sounds 'fun' - bonus cases are things like what happens if the
> > > guest gets rebooted somewhere during the process or if it's currently
> > > sitting in the bios/grub/etc
> > Um, during which process? Guests are gradually fixed to support
> > surprise removal well. Part of it is thunderbolt which makes
> > it incredibly easy. Yes - bios/grub will need to learn to
> > handle this well.
> I shared the same concern. As device emulator (QEMU), you know where guest
> would reject or delay - it's even agnostic bios/grub should respond to hot
> plug or not. You don't even know whether guest has the support for ACPI
> hotplug, surprise removal, do you? How QEMU infer what is the right
> disposition by telling apart these guest states?
> 
> -Siwei

We can always add a feature bit for that :)
No feature bit -> primary stays hidden.


> > 
> > > > > 2. PCI devices are a precious ressource. The primary device should never
> > > > >   be added to QEMU if it won't be used by guest instead of hiding it in
> > > > >   QEMU.
> > > > >   -> We only hotplug the device when the standby feature bit was
> > > > >      negotiated. We save the device cmdline options until we need it for
> > > > >      qdev_device_add()
> > > > >      Hiding a device can be a useful concept to model. For example a
> > > > >      pci device in a powered-off slot could be marked as hidden until the slot is
> > > > >      powered on (mst).
> > > Are they really that precious? Personally it's not something I'd worry
> > > about.
> > > 
> > > > > 3. Management layer software should handle this. Open Stack already has
> > > > >   components/code to handle unplug/replug VFIO devices and metadata to
> > > > >   provide to the guest for detecting which devices should be paired.
> > > > >   -> An approach that includes all software from firmware to
> > > > >      higher-level management software wasn't tried in the last years. This is
> > > > >      an attempt to keep it simple and contained in QEMU as much as possible.
> > > > > 4. Hotplugging a device and then making it part of a failover setup is
> > > > >    not possible
> > > > >   -> addressed by extending qdev hotplug functions to check for hidden
> > > > >      attribute, so e.g. device_add can be used to plug a device.
> > > > > 
> > > > > There are still some open issues:
> > > > > 
> > > > > Migration: I'm looking for something like a pre-migration hook that I
> > > > > could use to unplug the vfio-pci device. I tried with a migration
> > > > > notifier but it is called to late, i.e. after migration is aborted due
> > > > > to vfio-pci marked unmigrateable. I worked around this by setting it
> > > > > to migrateable and used a migration notifier on the virtio-net device.
> > > Why not just let this happen at the libvirt level; then you do the
> > > hotunplug etc before you actually tell qemu anything about starting a
> > > migration?
> > If qemu frees up resources (as it does on unplug) then libvirt
> > is not guaranteed it can roll the change back on e.g.
> > migration failure.
> > 
> > But really another issue is simply that it's a mechanism,
> > there's no policy that management needs to decide on.
> > Doing it at lowest possible level ensures all
> > upper layers benefit with minimal pain.
> > 
> > > > > Commandline: There is a dependency between vfio-pci and virtio-net
> > > > > devices. One points to the other via new parameters
> > > > > primar=<primary qdev id> and standby='<standby qdev id>'. This means
> > > > > that the primary device needs to be specified after standby device on
> > > > > the qemu command line. Not sure how to solve this.
> > > > > 
> > > > > Error handling: Patches don't cover all possible error scenarios yet.
> > > > > 
> > > > > I have tested this with a mlx5 NIC and was able to migrate the VM with
> > > > > above mentioned workarounds for open problems.
> > > > > 
> > > > > Command line example:
> > > > > 
> > > > > qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
> > > > >         -machine q35,kernel-irqchip=split -cpu host   \
> > > > >         -k fr   \
> > > > >         -serial stdio   \
> > > > >         -net none \
> > > > >         -qmp unix:/tmp/qmp.socket,server,nowait \
> > > > >         -monitor telnet:127.0.0.1:5555,server,nowait \
> > > > >         -device pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
> > > > >         -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
> > > > >         -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
> > > > >         -netdev tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
> > > > >         -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,primary=hostdev0 \
> > > > >         -device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1 \
> > > Yes, that's a bit grim; it's circular dependency on the 'hostdev0' and
> > > 'net1' id's.  cc'ing in Markus.
> > > 
> > > Dave
> > > 
> > > > >         /root/rhel-guest-image-8.0-1781.x86_64.qcow2
> > > > > 
> > > > > I'm grateful for any remarks or ideas!
> > > > > 
> > > > > Thanks!
> > > > > 
> > > > > regards,
> > > > > Jens
> > > > > 
> > > > > Sameeh Jubran (2):
> > > > >   qdev/qbus: Add hidden device support
> > > > >   net/virtio: add failover support
> > > > > 
> > > > > hw/core/qdev.c                 | 27 ++++++++++
> > > > > hw/net/virtio-net.c            | 95 ++++++++++++++++++++++++++++++++++
> > > > > hw/pci/pci.c                   |  1 +
> > > > > include/hw/pci/pci.h           |  2 +
> > > > > include/hw/qdev-core.h         |  8 +++
> > > > > include/hw/virtio/virtio-net.h |  7 +++
> > > > > qdev-monitor.c                 | 48 +++++++++++++++--
> > > > > vl.c                           |  7 ++-
> > > > > 8 files changed, 189 insertions(+), 6 deletions(-)
> > > > > 
> > > > > -- 
> > > > > 2.20.1
> > > > > 
> > > > > 
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

