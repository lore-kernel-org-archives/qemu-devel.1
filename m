Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA859C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB0421479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB0421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrER-0002Cj-NJ
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 18:58:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hSrDW-0001lB-6d
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hSrDS-0000sy-Aj
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:57:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hSrDQ-0000qy-GN
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:57:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E40CD85539
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 22:57:05 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B4EB1001E73;
	Mon, 20 May 2019 22:56:57 +0000 (UTC)
Date: Mon, 20 May 2019 16:56:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190520165657.2293c5d7@x1.home>
In-Reply-To: <20190517125820.2885-1-jfreimann@redhat.com>
References: <20190517125820.2885-1-jfreimann@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Mon, 20 May 2019 22:57:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
	mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org,
	laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 14:58:16 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

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

Is this standby= option only valid for Network/Ethernet class code
devices?  If so, perhaps vfio-pci code should reject the option on any
non-ethernet devices.  The option is also non-intuitive for users, only
through examples like above can we see it relates to the id of the
secondary device.  Could we instead name it something like
"standby_net_failover_pair_id="?

Also, this feature requires matching MAC addresses per the description,
where is that done?  Is it the user's responsibility to set the MAC on
the host device prior to the device_add?  If so, is this actually not
only specific to ethernet devices, but ethernet VFs?

Finally, please copy me on code touching vfio.  Thanks,

Alex

