Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FAEC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5A52080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5A52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hajYL-0001Jg-OS
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37162)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1haj3h-0004yd-Ht
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1haj3f-0001we-GN
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:51:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1haj3d-0001uv-1w
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:51:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id c70so7948788qkg.7
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 08:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lvIy1k9eXyf8mxbSREsbnvsCP+G0xAZID5k8sr2+Ov8=;
 b=kxvEqhUSQFK4Oi42xYSdhotqrQ3BfbbO3d/HfvryQxk2MEgS3wN8gI4A2excdw1AZZ
 0udiZFem6MpK49V7cOr79BNIf4YvdsnJRE8ZtNuD3vJkDLUBaylHfoDzh1MvEZ4peRER
 CgnTiDW65oGPNjvvvdt+GfZUZL3zC2gp2Wx4HoBIV/SzsKVcDudGbMZ3Xbo0fGgzBO0d
 3snSJjujMXOUOqM6c/Og6dWJ2KaapVpIGSpdt9myKzPS3NHtgLXCkoMWWWUSyw8I6xJX
 hN/Tr5GHzAKdJ9Y/UvrM1joyYKXsCeidJ2G6i4Wf3/2pSR0i/R++K+2mcKAm4//Y2rGb
 uLQQ==
X-Gm-Message-State: APjAAAUm2fS6NM/1RMY1Kq2BPWDbHCk+GBtczOsawp/a8hTHWQJBFH0Z
 1A+J+b8vl+aifl+rzorYWTNaaw==
X-Google-Smtp-Source: APXvYqy7mp0Njd0cttEWSglgrL1kNS1eAnfAYH+1S3kcm5EDyin3w0cJuRmJsNSJ9O32friYJyUMWQ==
X-Received: by 2002:a37:482:: with SMTP id 124mr2572311qke.1.1560268291512;
 Tue, 11 Jun 2019 08:51:31 -0700 (PDT)
Received: from redhat.com ([66.187.232.66])
 by smtp.gmail.com with ESMTPSA id c18sm3030594qkk.73.2019.06.11.08.51.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 11 Jun 2019 08:51:29 -0700 (PDT)
Date: Tue, 11 Jun 2019 11:51:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laine Stump <laine@redhat.com>
Message-ID: <20190611115009-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
 <646d0bf1-2fbb-1adb-d5d3-3ef3944376b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646d0bf1-2fbb-1adb-d5d3-3ef3944376b5@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.193
Subject: Re: [Qemu-devel] [PATCH 0/4] add failover feature for assigned
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
 aadam@redhat.com, qemu-devel@nongnu.org, Jens Freimann <jfreimann@redhat.com>,
 ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 11, 2019 at 11:42:54AM -0400, Laine Stump wrote:
> On 5/17/19 8:58 AM, Jens Freimann wrote:
> > This is another attempt at implementing the host side of the
> > net_failover concept
> > (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
> > 
> > Changes since last RFC:
> > - work around circular dependency of commandline options. Just add
> >    failover=on to the virtio-net standby options and reference it from
> >    primary (vfio-pci) device with standby=<id>
> > - add patch 3/4 to allow migration of vfio-pci device when it is part of a
> >    failover pair, still disallow for all other devices
> > - add patch 4/4 to allow unplug of device during migrationm, make an
> >    exception for failover primary devices. I'd like feedback on how to
> >    solve this more elegant. I added a boolean to DeviceState, have it
> >    default to false for all devices except for primary devices.
> > - not tested yet with surprise removal
> > - I don't expect this to go in as it is, still needs more testing but
> >    I'd like to get feedback on above mentioned changes.
> > 
> > The general idea is that we have a pair of devices, a vfio-pci and a
> > emulated device. Before migration the vfio device is unplugged and data
> > flows to the emulated device, on the target side another vfio-pci device
> > is plugged in to take over the data-path. In the guest the net_failover
> > module will pair net devices with the same MAC address.
> > 
> > * In the first patch the infrastructure for hiding the device is added
> >    for the qbus and qdev APIs.
> > 
> > * In the second patch the virtio-net uses the API to defer adding the vfio
> >    device until the VIRTIO_NET_F_STANDBY feature is acked.
> > 
> > Previous discussion:
> >    RFC v1 https://patchwork.ozlabs.org/cover/989098/
> >    RFC v2 https://www.mail-archive.com/qemu-devel@nongnu.org/msg606906.html
> > 
> > To summarize concerns/feedback from previous discussion:
> > 1.- guest OS can reject or worse _delay_ unplug by any amount of time.
> >    Migration might get stuck for unpredictable time with unclear reason.
> >    This approach combines two tricky things, hot/unplug and migration.
> >    -> We can surprise-remove the PCI device and in QEMU we can do all
> >       necessary rollbacks transparent to management software. Will it be
> >       easy, probably not.
> > 2. PCI devices are a precious ressource. The primary device should never
> >    be added to QEMU if it won't be used by guest instead of hiding it in
> >    QEMU.
> >    -> We only hotplug the device when the standby feature bit was
> >       negotiated. We save the device cmdline options until we need it for
> >       qdev_device_add()
> >       Hiding a device can be a useful concept to model. For example a
> >       pci device in a powered-off slot could be marked as hidden until the slot is
> >       powered on (mst).
> > 3. Management layer software should handle this. Open Stack already has
> >    components/code to handle unplug/replug VFIO devices and metadata to
> >    provide to the guest for detecting which devices should be paired.
> >    -> An approach that includes all software from firmware to
> >       higher-level management software wasn't tried in the last years. This is
> >       an attempt to keep it simple and contained in QEMU as much as possible.
> > 4. Hotplugging a device and then making it part of a failover setup is
> >     not possible
> >    -> addressed by extending qdev hotplug functions to check for hidden
> >       attribute, so e.g. device_add can be used to plug a device.
> > 
> > 
> > I have tested this with a mlx5 NIC and was able to migrate the VM with
> > above mentioned workarounds for open problems.
> > 
> > Command line example:
> > 
> > qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
> >          -machine q35,kernel-irqchip=split -cpu host   \
> >          -k fr   \
> >          -serial stdio   \
> >          -net none \
> >          -qmp unix:/tmp/qmp.socket,server,nowait \
> >          -monitor telnet:127.0.0.1:5555,server,nowait \
> >          -device pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
> >          -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
> >          -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
> >          -netdev tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
> >          -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,failover=on \
> >          /root/rhel-guest-image-8.0-1781.x86_64.qcow2
> > 
> > Then the primary device can be hotplugged via
> >   (qemu) device_add vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1
> 
> 
> I guess this is the commandline on the migration destination, and as far as
> I understand from this example, on the destination we (meaning libvirt or
> higher level management application) must *not* include the assigned device
> on the qemu commandline, but must instead hotplug the device later after the
> guest CPUs have been restarted on the destination.
> 
> So if I'm understanding correctly, the idea is that on the migration source,
> the device may have been hotplugged, or may have been included when qemu was
> originally started. Then qemu automatically handles the unplug of the device
> on the source, but it seems qemu does nothing on the destination, leaving
> that up to libvirt or a higher layer to implement.

Good point. I don't see why it would not work just as well
with device present straight away.

Did I miss something?

I think Jens was just testing local machine migration
and of course you can only assign a device to 1 VM at a time.

> Then in order for this to work, libvirt (or OpenStack or oVirt or whoever)
> needs to understand that the device in the libvirt config (it will still be
> in the libvirt config, since from libvirt's POV it hasn't been unplugged):
> 
> 1) shouldn't be included in the qemu commandline on the destination,
> 
> 2) will almost surely need to be replaced with a different device on the
> destination (since it's almost certain that the destination won't have an
> available device at the same PCI address)
> 
> 3) will probably need to be unbinded from the VF net driver (does this need
> to happen before migration is finished? If we want to lower the probability
> of a failure after we're already committed to the migration, then I think we
> must, but libvirt isn't set up for that in any way).
> 
> 4) will need to be hotplugged after the migration has finished *and* after
> the guest CPUs have been restarted on the destination.
> 
> 
> While it will be possible to assure that there is a destination device, and
> to replace the old device with new in the config (and maybe, either with
> some major reworking of device assignment code, or offloading the
> responsibility to the management application(s), possible to re-bind the
> device to the vfio-pci driver), prior to marking the migration as
> "successful" (thus committing to running it on the destination), we can't
> say as much for actually assigning the device. So if the assignment fails,
> then what happens?
> 
> 
> So a few issues I see that will need to be solved by [someone] (apparently
> either libvirt or management):
> 
> a) there isn't anything in libvirt's XML grammar that allows us to signify a
> device that is "present in the config but shouldn't be included in the
> commandline"
> 
> b) someone will need to replace the device from the source with an
> equivalent device on the destination in the libvirt XML. There are other
> cases of management modifying the XML during migration (I think), but this
> does point out that putting the "auto-unplug code into qemu isn't turning
> this into a trivial
> 
> c) there is nothing in libvirt's migration logic that can cause a device to
> be re-binded to vfio-pci prior to completion of a migration. Unless this is
> added to libvirt (or the re-bind operation is passed off to the management
> application), we will need to live with the possibility that hotplugging the
> device will fail due to failed re-bind *after* we've committed to the
> migration.
> 
> d) once the guest CPUs are restarted on the destination, [someone] (libvirt
> or management) needs to hotplug the new device on the destination. (I'm
> guessing that a hotplug can only be done while the guest CPUs are running;
> correct me if this is wrong!)
> 
> This sounds like a lot of complexity for something that was supposed to be
> handled completely/transparently by qemu :-P.

