Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5619C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DCD20700
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DCD20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48367 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCYcW-0007TU-EO
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 19:51:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hCYax-0006OM-AJ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hCYYG-0003Pt-3O
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:47:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hCYYC-00030O-Es
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:47:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D749A3066482;
	Fri,  5 Apr 2019 23:47:08 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CAB5419C56;
	Fri,  5 Apr 2019 23:47:01 +0000 (UTC)
Date: Fri, 5 Apr 2019 20:46:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190405234659.GJ7238@habkost.net>
References: <20190322134447.14831-1-jfreimann@redhat.com>
	<20190404082933.ke7tvryocpdd2h54@jenstp.localdomain>
	<20190405085628.GA2819@work-vm>
	<20190405191850-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190405191850-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 05 Apr 2019 23:47:08 +0000 (UTC)
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
	mdroth@linux.vnet.ibm.com, liran.alon@oracle.com,
	laine@redhat.com, ogerlitz@mellanox.com,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405234659.9etQ8YH_HgvWay7UUns62wlSAYn3ups6xg79ZUXvZvs@z>

On Fri, Apr 05, 2019 at 07:22:35PM -0400, Michael S. Tsirkin wrote:
> On Fri, Apr 05, 2019 at 09:56:29AM +0100, Dr. David Alan Gilbert wrote:
> > * Jens Freimann (jfreimann@redhat.com) wrote:
> > > On Fri, Mar 22, 2019 at 02:44:45PM +0100, Jens Freimann wrote:
[...]
> > > > 3. Management layer software should handle this. Open Stack already has
> > > >  components/code to handle unplug/replug VFIO devices and metadata to
> > > >  provide to the guest for detecting which devices should be paired.
> > > >  -> An approach that includes all software from firmware to
> > > >     higher-level management software wasn't tried in the last years. This is
> > > >     an attempt to keep it simple and contained in QEMU as much as possible.
> > > > 4. Hotplugging a device and then making it part of a failover setup is
> > > >   not possible
> > > >  -> addressed by extending qdev hotplug functions to check for hidden
> > > >     attribute, so e.g. device_add can be used to plug a device.
> > > > 
> > > > There are still some open issues:
> > > > 
> > > > Migration: I'm looking for something like a pre-migration hook that I
> > > > could use to unplug the vfio-pci device. I tried with a migration
> > > > notifier but it is called to late, i.e. after migration is aborted due
> > > > to vfio-pci marked unmigrateable. I worked around this by setting it
> > > > to migrateable and used a migration notifier on the virtio-net device.
> > 
> > Why not just let this happen at the libvirt level; then you do the
> > hotunplug etc before you actually tell qemu anything about starting a
> > migration?
> 
> If qemu frees up resources (as it does on unplug) then libvirt
> is not guaranteed it can roll the change back on e.g.
> migration failure.

Why should we always free up resources on unplug?

Unplug of a disk device doesn't close the corresponding -blockdev.
Unplug of a serial device doesn't close the corresponding -chardev.
Unplug of a memory device doesn't close the corresponding memory backend.
Unplug of a crypto device doesn't close the corresponding crypto backend.

Why do we expect device_del of a passthrough PCI device to always
release the host side PCI device?  We can provide a better API
than that.


> 
> But really another issue is simply that it's a mechanism,
> there's no policy that management needs to decide on.
> Doing it at lowest possible level ensures all
> upper layers benefit with minimal pain.

I don't see a problem in trying to make this work with surprise
removal too.  But if it is also possible to make this work
without surprise removal support on the guest side, why not
provide the mechanisms for the management layer to implement it?

-- 
Eduardo

