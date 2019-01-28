Received: from eggs.gnu.org ([209.51.188.92]:37779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goBEi-00040H-9h
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goB2g-0002WM-VI
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:49:56 -0500
Date: Mon, 28 Jan 2019 18:49:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190128174919.GL5756@localhost.localdomain>
References: <20190125174653.4604-1-kwolf@redhat.com>
	<20190125174653.4604-3-kwolf@redhat.com>
	<20190128085041.GA16630@andariel.pipo.sk>
	<20190128144147.GA5756@localhost.localdomain>
	<87tvhszpql.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvhszpql.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] scsi-disk: Add device_id property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com

Am 28.01.2019 um 17:55 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 28.01.2019 um 09:50 hat Peter Krempa geschrieben:
> [...]
> >> 2) Is actually using 'scsi-cd'/'scsi-hd' the better option than
> >> 'scsi-disk'?
> >
> > Yes, scsi-disk is a legacy device. Maybe we should formally deprecate
> > it.
> 
> There's an internal use in scsi_bus_legacy_add_drive(), which in turn
> powers two legacy features:
> 
> 1. -drive if=scsi
> 
>    Creates scsi-disk frontends.
> 
>    Only works with onboard HBAs since commit 14545097267, v2.12.0.
> 
> 2. -device usb-storage
> 
>    Bad magic: usb-storage pretends to be a block device, but it's really
>    a SCSI bus that can serve only a single device, which it creates
>    automatically.
> 
> If we deprecate scsi-disk, we should deprecate these, too.  Can't say
> whether that's practical right now.

Most likely not worth the effort anyway. I don't think it's blocking
anything.

> >> 3) Since upstream libvirt supports qemu-1.5 and newer and 'scsi-cd' is
> >> already supported there, can we assume that all newer versions support
> >> it? (Basically the question is whether it can be compiled out by
> >> upstream means).
> >
> > I think so.
> 
> Compiling out scsi-hd or scsi-cd, but not scsi-disk would be silly.  All
> three devices are in scsi-disk.c.  You'd have to hack that up to be
> silly.

I understood this as a question about libvirt, i.e. whether libvirt can
drop/compile out their scsi-disk code and instead assume that scsi-hd/cd
are always present. Maybe I misunderstood, though?

Kevin
