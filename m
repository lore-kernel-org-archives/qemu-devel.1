Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E092C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704DE217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704DE217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCL2C-0004Nz-Du
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:21:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hCL1J-000411-2Y
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hCL1H-0007r3-NA
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:20:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1hCL1G-0007nj-Te
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:20:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97F6B81E17;
	Fri,  5 Apr 2019 09:20:16 +0000 (UTC)
Received: from localhost (dhcp-192-206.str.redhat.com [10.33.192.206])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D233A60CA9;
	Fri,  5 Apr 2019 09:20:11 +0000 (UTC)
Date: Fri, 5 Apr 2019 11:20:10 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190405092010.2hnwu36w4ited4rl@jenstp.localdomain>
References: <20190322134447.14831-1-jfreimann@redhat.com>
	<20190404082933.ke7tvryocpdd2h54@jenstp.localdomain>
	<20190405085628.GA2819@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <20190405085628.GA2819@work-vm>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 05 Apr 2019 09:20:16 +0000 (UTC)
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
	qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com,
	armbru@redhat.com, liran.alon@oracle.com, laine@redhat.com,
	ogerlitz@mellanox.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405092010.okb4ZqFAbyDdcJ8wv3uapcd5u28w1vm2opMld0l_E5I@z>

On Fri, Apr 05, 2019 at 09:56:29AM +0100, Dr. David Alan Gilbert wrote:
>* Jens Freimann (jfreimann@redhat.com) wrote:
[...]
>> > To summarize concerns/feedback from previous discussion:
>> > 1.- guest OS can reject or worse _delay_ unplug by any amount of time.
>> >  Migration might get stuck for unpredictable time with unclear reason.
>> >  This approach combines two tricky things, hot/unplug and migration.
>> >  -> We can surprise-remove the PCI device and in QEMU we can do all
>> >     necessary rollbacks transparent to management software. Will it be
>> >     easy, probably not.
>
>This sounds 'fun' - bonus cases are things like what happens if the
>guest gets rebooted somewhere during the process or if it's currently
>sitting in the bios/grub/etc

Yeah, I have to think about this...

>> > 2. PCI devices are a precious ressource. The primary device should never
>> >  be added to QEMU if it won't be used by guest instead of hiding it in
>> >  QEMU.
>> >  -> We only hotplug the device when the standby feature bit was
>> >     negotiated. We save the device cmdline options until we need it for
>> >     qdev_device_add()
>> >     Hiding a device can be a useful concept to model. For example a
>> >     pci device in a powered-off slot could be marked as hidden until the slot is
>> >     powered on (mst).
>
>Are they really that precious? Personally it's not something I'd worry
>about.
>
>> > 3. Management layer software should handle this. Open Stack already has
>> >  components/code to handle unplug/replug VFIO devices and metadata to
>> >  provide to the guest for detecting which devices should be paired.
>> >  -> An approach that includes all software from firmware to
>> >     higher-level management software wasn't tried in the last years. This is
>> >     an attempt to keep it simple and contained in QEMU as much as possible.
>> > 4. Hotplugging a device and then making it part of a failover setup is
>> >   not possible
>> >  -> addressed by extending qdev hotplug functions to check for hidden
>> >     attribute, so e.g. device_add can be used to plug a device.
>> >
>> > There are still some open issues:
>> >
>> > Migration: I'm looking for something like a pre-migration hook that I
>> > could use to unplug the vfio-pci device. I tried with a migration
>> > notifier but it is called to late, i.e. after migration is aborted due
>> > to vfio-pci marked unmigrateable. I worked around this by setting it
>> > to migrateable and used a migration notifier on the virtio-net device.
>
>Why not just let this happen at the libvirt level; then you do the
>hotunplug etc before you actually tell qemu anything about starting a
>migration?

Yes...the goal was to see if we can contain changes to QEMU (to keep
it simple, although it seems that covering all error cases won't be that simple :).
But I don't see a mechanism to trigger the unplug at the right moment
yet.  So yes, maybe there's no way around involving libvirt at least
for this part...

>> > Commandline: There is a dependency between vfio-pci and virtio-net
>> > devices. One points to the other via new parameters
>> > primar=<primary qdev id> and standby='<standby qdev id>'. This means
>> > that the primary device needs to be specified after standby device on
>> > the qemu command line. Not sure how to solve this.
>> >
>> > Error handling: Patches don't cover all possible error scenarios yet.
>> >
>> > I have tested this with a mlx5 NIC and was able to migrate the VM with
>> > above mentioned workarounds for open problems.
>> >
>> > Command line example:
>> >
>> > qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
>> >        -machine q35,kernel-irqchip=split -cpu host   \
>> >        -k fr   \
>> >        -serial stdio   \
>> >        -net none \
>> >        -qmp unix:/tmp/qmp.socket,server,nowait \
>> >        -monitor telnet:127.0.0.1:5555,server,nowait \
>> >        -device pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
>> >        -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
>> >        -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
>> >        -netdev tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
>> >        -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,primary=hostdev0 \
>> >        -device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1 \
>
>Yes, that's a bit grim; it's circular dependency on the 'hostdev0' and
>'net1' id's.  cc'ing in Markus.

Dan had an idea how to avoid having to specify the id for the
virtio-net device. I'm currently looking into it, but it seems like it
should work. 


regards,
Jens 

