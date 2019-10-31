Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC8CA9ECE
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851E820873
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="wwUEUce2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851E820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQBP2-0005of-Gh
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 10:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1iQBHS-0006If-Rr
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iQBHQ-0005Us-OB
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:18:30 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:58222)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iQBHQ-0005O7-3k
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:18:28 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id F3E074BAC9;
 Fri,  1 Nov 2019 01:18:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1572531505;
 bh=ZPk98vtnDF+ci/hc8kXZ7WsHFHLOENNcqmSAp9FYJ2s=;
 h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
 b=wwUEUce2J/evAxcAZdRrqQiWgcV24+GJt/n2n9dWpqN3WkNBy5JPEQy0fvpBWpW7y
 ny3iNxGTOQ7fWwHAE4HuyrV0IDpwbBuwlRXLAo57veqF/gwVJFpE1fEhtYHnNTBTsS
 vFnH0HBMYqaQQ9QMuNH7rDg6IcMyFixyu4G3ug0A=
Received: by www1.hostfission.com (Postfix, from userid 1000)
 id EBA1080CC0; Fri,  1 Nov 2019 01:18:24 +1100 (AEDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: RFC: New device for zero-copy VM memory access
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Nov 2019 01:18:24 +1100
From: geoff@hostfission.com
Cc: qemu-devel@nongnu.org
In-Reply-To: <20191031132443.GB3128@work-vm>
References: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
 <20191030185248.GC3114@work-vm>
 <88f1c3701740665b0ebe2f24c8ce7ade@hostfission.com>
 <20191031132443.GB3128@work-vm>
Message-ID: <b36330ecd38ce872982df4d41d3d4695@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.2.3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 139.99.139.48
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019-11-01 00:24, Dr. David Alan Gilbert wrote:
> * geoff@hostfission.com (geoff@hostfission.com) wrote:
>> Hi Dave,
>> 
>> On 2019-10-31 05:52, Dr. David Alan Gilbert wrote:
>> > * geoff@hostfission.com (geoff@hostfission.com) wrote:
>> > > Hi All,
>> > >
>> > > Over the past week, I have been working to come up with a solution
>> > > to the
>> > > memory transfer performance issues that hinder the Looking Glass
>> > > Project.
>> > >
>> > > Currently Looking Glass works by using the IVSHMEM shared memory
>> > > device
>> > > which
>> > > is fed by an application that captures the guest's video output.
>> > > While this
>> > > works it is sub-optimal because we first have to perform a CPU copy
>> > > of the
>> > > captured frame into shared RAM, and then back out again for display.
>> > > Because
>> > > the destination buffers are allocated by closed proprietary code
>> > > (DirectX,
>> > > or
>> > > NVidia NvFBC) there is no way to have the frame placed directly into
>> > > the
>> > > IVSHMEM shared ram.
>> > >
>> > > This new device, currently named `introspection` (which needs a more
>> > > suitable
>> > > name, porthole perhaps?), provides a means of translating guest
>> > > physical
>> > > addresses to host virtual addresses, and finally to the host offsets
>> > > in RAM
>> > > for
>> > > file-backed memory guests. It does this by means of a simple
>> > > protocol over a
>> > > unix socket (chardev) which is supplied the appropriate fd for the
>> > > VM's
>> > > system
>> > > RAM. The guest (in this case, Windows), when presented with the
>> > > address of a
>> > > userspace buffer and size, will mlock the appropriate pages into RAM
>> > > and
>> > > pass
>> > > guest physical addresses to the virtual device.
>> >
>> > Hi Geroggrey,
>> >   I wonder if the same thing can be done by using the existing
>> > vhost-user
>> > mechanism.
>> >
>> >   vhost-user is intended for implementing a virtio device outside of the
>> > qemu process; so it has a character device that qemu passes commands
>> > down
>> > to the other process, where qemu mostly passes commands via the virtio
>> > queues.   To be able to read the virtio queues, the external process
>> > mmap's the same memory as the guest - it gets passed a 'set mem table'
>> > command by qemu that includes fd's for the RAM, and includes base/offset
>> > pairs saying that a particular chunk of RAM is mapped at a particular
>> > guest physical address.
>> >
>> >   Whether or not you make use of virtio queues, I think the mechanism
>> > for the device to tell the external process the mappings might be what
>> > you're after.
>> >
>> > Dave
>> >
>> 
>> While normally I would be all for re-using such code, the vhost-user 
>> while
>> being very feature-complete from what I understand is overkill for our
>> requirements. It will still allocate a communication ring and an 
>> events
>> system
>> that we will not be using. The goal of this device is to provide a 
>> dumb &
>> simple method of sharing system ram, both for this project and for 
>> others
>> that
>> work on a simple polling mechanism, it is not intended to be an 
>> end-to-end
>> solution like vhost-user is.
>> 
>> If you still believe that vhost-user should be used, I will do what I 
>> can to
>> implement it, but for such a simple device I honestly believe it is
>> overkill.
> 
> It's certainly worth having a look at vhost-user even if you don't use
> most of it;  you can configure it down to 1 (maybe 0?) queues if you're
> really desperate - and you might find it comes in useful!  The actual
> setup is pretty easy.
> 
> The process of synchronising with (potentially changing) host memory
> mapping is a bit hairy; so if we can share it with vhost it's probably
> worth it.

Thanks, I will have a deeper dive into it, however the issues with
changing host memory, migration, and all that extra is of no concern or
use to us.

The audience that will be using this interface is not interested in
such features as the primary reason for Looking Glass is to allow a for
high-performance windows workstation for gaming and proprietary windows
only software. In these scenarios features like ram ballooning are
avoided like the plague as it hampers performance for use cases that
require consistent low latency for competitive gameplay.

As the author of Looking Glass, I also have to consider the maintenance
and the complexity of implementing the vhost protocol into the project.
At this time a complete Porthole client can be implemented in 150 lines
of C without external dependencies, and most of that is boilerplate
socket code. This IMO is a major factor in deciding to avoid vhost-user.

I also have to weigh up the cost of developing and maintaining the
windows driver for this device. I am very green when it comes to Windows
driver programming, it took weeks to write the first IVSHMEM driver, and
several days to write the Porthole driver which is far simpler than the
IVSHMEM driver. I'd hate to think of the time investment in maintaining
the vhost integration also (yes, I am aware there is a library).

These drivers are not complex and I am sure an experienced windows
driver developer could have thrown them together in a few hours, but
since our requirements are so niche and of little commercial value those
in our community that are using this project do not have the time and/or
ability to assist with the drivers.

 From my point of view, avoiding vhost-use seems like a better path to
take as I am able (and willing) to maintain the Porthole device in QEMU,
the OS drivers, and client interface. The Porthole device also doesn't
have any special or complex features keeping it very simple to maintain
and keeping the client protocol very simple.

There is also an open-source audio driver for windows called SCREAM
that was initially designed for broadcasting audio over a network,
however, it's authors have also implemented transport via shared RAM.
While vhost-user would make much more sense here as vring buffers
would be very useful, the barrier to entry is too high and as such the
developers have instead opted to use the simple IVSHMEM device instead.

That said, I will still have a deeper look into vhost-user but I hope
the above shows the merits of this simple method of guest ram access.

-Geoff

> 
> Dave
> 
>> -Geoff
>> 
>> > > This device and the windows driver have been designed in such a way
>> > > that
>> > > it's a
>> > > utility device for any project and/or application that could make
>> > > use of it.
>> > > The PCI subsystem vendor and device ID are used to provide a means
>> > > of device
>> > > identification in cases where multiple devices may be in use for
>> > > differing
>> > > applications. This also allows one common driver to be used for any
>> > > other
>> > > projects wishing to build on this device.
>> > >
>> > > My ultimate goal is to get this to a state where it could be accepted
>> > > upstream
>> > > into Qemu at which point Looking Glass would be modified to use it
>> > > instead
>> > > of
>> > > the IVSHMEM device.
>> > >
>> > > My git repository with the new device can be found at:
>> > > https://github.com/gnif/qemu
>> > >
>> > > The new device is:
>> > > https://github.com/gnif/qemu/blob/master/hw/misc/introspection.c
>> > >
>> > > Looking Glass:
>> > > https://looking-glass.hostfission.com/
>> > >
>> > > The windows driver, while working, needs some cleanup before the
>> > > source is
>> > > published. I intend to maintain both this device and the windows
>> > > driver
>> > > including producing a signed Windows 10 driver if Redhat are
>> > > unwilling or
>> > > unable.
>> > >
>> > > Kind Regards,
>> > > Geoffrey McRae
>> > >
>> > > HostFission
>> > > https://hostfission.com
>> > >
>> > --
>> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

