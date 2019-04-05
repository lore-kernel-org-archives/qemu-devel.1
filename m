Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F479C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7426B21738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7426B21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38396 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKnf-0001X3-LP
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:06:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCKll-0008LQ-8R
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCKhD-0007V7-Jj
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:59:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCKhC-0007UJ-Ol
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:59:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B875A307D98D;
	Fri,  5 Apr 2019 08:59:33 +0000 (UTC)
Received: from work-vm (ovpn-117-242.ams2.redhat.com [10.36.117.242])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 33B0E1042555;
	Fri,  5 Apr 2019 08:59:27 +0000 (UTC)
Date: Fri, 5 Apr 2019 09:59:24 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190405085924.GB2819@work-vm>
References: <20181210173151.16629-1-dgilbert@redhat.com>
	<20190404152454.3c6b38ce@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190404152454.3c6b38ce@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 05 Apr 2019 08:59:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] virtio-fs: shared file system for
 virtual machines3
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
Cc: sweil@redhat.com, miklos@szeredi.hu, qemu-devel@nongnu.org,
	stefanha@redhat.com, swhiteho@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405085924.thrmMsQU9Uxr5tOZ6d4svyfpATkPuTf-vfl02IeKbMQ@z>

* Greg Kurz (groug@kaod.org) wrote:
> On Mon, 10 Dec 2018 17:31:44 +0000
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Hi,
> >   This is the first RFC for the QEMU side of 'virtio-fs';
> > a new mechanism for mounting host directories into the guest
> > in a fast, consistent and secure manner.  Our primary use
> > case is kata containers, but it should be usable in other scenarios
> > as well.
> > 
> > There are corresponding patches being posted to Linux kernel,
> > libfuse and kata lists.
> > 
> > For a fuller design description, and benchmark numbers, please see
> > Vivek's posting of the kernel set here:
> > 
> > https://marc.info/?l=linux-kernel&m=154446243024251&w=2
> > 
> > We've got a small website with instructions on how to use it, here:
> > 
> > https://virtio-fs.gitlab.io/
> > 
> > and all the code is available on gitlab at:
> > 
> > https://gitlab.com/virtio-fs
> > 
> 
> Hi !
> 
> This looks like a very promising replacement for virtio-9p, at
> least with better chances of reaching a production quality level.
> 
> Not sure I'll have enough time to step in, but please Cc me on
> future posts. As virtio-9p maintainer, I'll be happy to help if
> I can. Also I'll be happy to get rid of the fsdev proxy backend
> at some point (which I already wanted to replace with a vhost
> user based solution :-) ).

Thanks! We'll try and remember to keep you in the loop.
If there are any gotchas that you tripped over in 9p that we should
watch out for then please give us a prod.

Dave


Dave

> Cheers,
> 
> --
> Greg
> 
> > QEMU's changes
> > --------------
> > 
> > The QEMU changes are pretty small; 
> > 
> > There's a new vhost-user device, which is used to carry a stream of
> > FUSE messages to an external daemon that actually performs
> > all the file IO.  The FUSE daemon is an external process in order to
> > achieve better isolation for security and resource control (e.g. number
> > of file descriptors) and also because it's cleaner than trying to
> > integrate libfuse into QEMU.
> > 
> > This device has an extra BAR that contains (up to) 3 regions:
> > 
> >  a) a DAX mapping range ('the cache') - into which QEMU mmap's
> >     files on behalf of the external daemon; those files are
> >     then directly mapped by the guest in a way similar to a DAX
> >     backed file system;  one advantage of this is that multiple
> >     guests all accessing the same files should all be sharing
> >     those pages of host cache.
> > 
> >  b) An experimental set of mappings for use by a metadata versioning
> >     daemon;  this mapping is shared between multiple guests and
> >     the daemon, but only contains a set of version counters that
> >     allow a guest to quickly tell if its metadata is stale.
> > 
> > TODO
> > ----
> > 
> > This is the first RFC, we know we have a bunch of things to clear up:
> > 
> >   a) The virtio device specificiation is still in flux and is expected
> >      to change
> > 
> >   b) We'd like to find ways of reducing the map/unmap latency for DAX
> > 
> >   c) The metadata versioning scheme needs to settle out.
> > 
> >   d) mmap'ing host files has some interesting side effects; for example
> >      if the file gets truncated by the host and then the guest accesses
> >      the mapping, KVM can fail the guest hard.
> > 
> > Dr. David Alan Gilbert (6):
> >   virtio: Add shared memory capability
> >   virtio-fs: Add cache BAR
> >   virtio-fs: Add vhost-user slave commands for mapping
> >   virtio-fs: Fill in slave commands for mapping
> >   virtio-fs: Allow mapping of meta data version table
> >   virtio-fs: Allow mapping of journal
> > 
> > Stefan Hajnoczi (1):
> >   virtio: add vhost-user-fs-pci device
> > 
> >  configure                                   |  10 +
> >  contrib/libvhost-user/libvhost-user.h       |   3 +
> >  docs/interop/vhost-user.txt                 |  35 ++
> >  hw/virtio/Makefile.objs                     |   1 +
> >  hw/virtio/vhost-user-fs.c                   | 517 ++++++++++++++++++++
> >  hw/virtio/vhost-user.c                      |  16 +
> >  hw/virtio/virtio-pci.c                      | 115 +++++
> >  hw/virtio/virtio-pci.h                      |  19 +
> >  include/hw/pci/pci.h                        |   1 +
> >  include/hw/virtio/vhost-user-fs.h           |  79 +++
> >  include/standard-headers/linux/virtio_fs.h  |  48 ++
> >  include/standard-headers/linux/virtio_ids.h |   1 +
> >  include/standard-headers/linux/virtio_pci.h |   9 +
> >  13 files changed, 854 insertions(+)
> >  create mode 100644 hw/virtio/vhost-user-fs.c
> >  create mode 100644 include/hw/virtio/vhost-user-fs.h
> >  create mode 100644 include/standard-headers/linux/virtio_fs.h
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

