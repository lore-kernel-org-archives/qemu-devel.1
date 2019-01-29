Received: from eggs.gnu.org ([209.51.188.92]:43651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goNXQ-0007l2-US
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 02:10:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goNXQ-0002rI-9L
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 02:10:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190125174653.4604-1-kwolf@redhat.com>
	<20190125174653.4604-3-kwolf@redhat.com>
	<20190128085041.GA16630@andariel.pipo.sk>
	<20190128144147.GA5756@localhost.localdomain>
	<87tvhszpql.fsf@dusky.pond.sub.org>
	<20190128174919.GL5756@localhost.localdomain>
Date: Tue, 29 Jan 2019 08:10:19 +0100
In-Reply-To: <20190128174919.GL5756@localhost.localdomain> (Kevin Wolf's
	message of "Mon, 28 Jan 2019 18:49:19 +0100")
Message-ID: <87womovt0k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] scsi-disk: Add device_id property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: libvir-list@redhat.com, pbonzini@redhat.com, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 28.01.2019 um 17:55 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Am 28.01.2019 um 09:50 hat Peter Krempa geschrieben:
>> [...]
>> >> 2) Is actually using 'scsi-cd'/'scsi-hd' the better option than
>> >> 'scsi-disk'?
>> >
>> > Yes, scsi-disk is a legacy device. Maybe we should formally deprecate
>> > it.
>> 
>> There's an internal use in scsi_bus_legacy_add_drive(), which in turn
>> powers two legacy features:
>> 
>> 1. -drive if=scsi
>> 
>>    Creates scsi-disk frontends.
>> 
>>    Only works with onboard HBAs since commit 14545097267, v2.12.0.
>> 
>> 2. -device usb-storage
>> 
>>    Bad magic: usb-storage pretends to be a block device, but it's really
>>    a SCSI bus that can serve only a single device, which it creates
>>    automatically.
>> 
>> If we deprecate scsi-disk, we should deprecate these, too.  Can't say
>> whether that's practical right now.
>
> Most likely not worth the effort anyway. I don't think it's blocking
> anything.

We could also wean them off the legacy device models.

>> >> 3) Since upstream libvirt supports qemu-1.5 and newer and 'scsi-cd' is
>> >> already supported there, can we assume that all newer versions support
>> >> it? (Basically the question is whether it can be compiled out by
>> >> upstream means).
>> >
>> > I think so.
>> 
>> Compiling out scsi-hd or scsi-cd, but not scsi-disk would be silly.  All
>> three devices are in scsi-disk.c.  You'd have to hack that up to be
>> silly.
>
> I understood this as a question about libvirt, i.e. whether libvirt can
> drop/compile out their scsi-disk code and instead assume that scsi-hd/cd
> are always present. Maybe I misunderstood, though?

If questions remain, I trust Peter will ask.
