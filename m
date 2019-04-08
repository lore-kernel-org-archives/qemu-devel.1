Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC897C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 05:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9BF20870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 05:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9BF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47721 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDMx6-000893-Kx
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 01:36:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDMw1-0007bw-K4
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDMu5-0001G4-95
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:33:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDMu4-0001Ez-Vb
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:33:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3BAB88AA4;
	Mon,  8 Apr 2019 05:26:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3492B5D70D;
	Mon,  8 Apr 2019 05:26:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id B013C1138648; Mon,  8 Apr 2019 07:26:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190322134447.14831-1-jfreimann@redhat.com>
	<20190404082933.ke7tvryocpdd2h54@jenstp.localdomain>
	<20190405085628.GA2819@work-vm>
	<20190405191850-mutt-send-email-mst@kernel.org>
	<20190405234659.GJ7238@habkost.net>
Date: Mon, 08 Apr 2019 07:26:16 +0200
In-Reply-To: <20190405234659.GJ7238@habkost.net> (Eduardo Habkost's message of
	"Fri, 5 Apr 2019 20:46:59 -0300")
Message-ID: <87sgutjcef.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 08 Apr 2019 05:26:24 +0000 (UTC)
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
Cc: pkrempa@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
	armbru@redhat.com, qemu-devel@nongnu.org,
	mdroth@linux.vnet.ibm.com, liran.alon@oracle.com,
	laine@redhat.com, ogerlitz@mellanox.com,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408052616.TGAe2G3M-Bxxq-sb35DusUBENgZxTlAd9Ltttw0RilI@z>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Apr 05, 2019 at 07:22:35PM -0400, Michael S. Tsirkin wrote:
>> On Fri, Apr 05, 2019 at 09:56:29AM +0100, Dr. David Alan Gilbert wrote:
>> > * Jens Freimann (jfreimann@redhat.com) wrote:
>> > > On Fri, Mar 22, 2019 at 02:44:45PM +0100, Jens Freimann wrote:
> [...]
>> > > > 3. Management layer software should handle this. Open Stack already has
>> > > >  components/code to handle unplug/replug VFIO devices and metadata to
>> > > >  provide to the guest for detecting which devices should be paired.
>> > > >  -> An approach that includes all software from firmware to
>> > > >     higher-level management software wasn't tried in the last years. This is
>> > > >     an attempt to keep it simple and contained in QEMU as much as possible.
>> > > > 4. Hotplugging a device and then making it part of a failover setup is
>> > > >   not possible
>> > > >  -> addressed by extending qdev hotplug functions to check for hidden
>> > > >     attribute, so e.g. device_add can be used to plug a device.
>> > > > 
>> > > > There are still some open issues:
>> > > > 
>> > > > Migration: I'm looking for something like a pre-migration hook that I
>> > > > could use to unplug the vfio-pci device. I tried with a migration
>> > > > notifier but it is called to late, i.e. after migration is aborted due
>> > > > to vfio-pci marked unmigrateable. I worked around this by setting it
>> > > > to migrateable and used a migration notifier on the virtio-net device.
>> > 
>> > Why not just let this happen at the libvirt level; then you do the
>> > hotunplug etc before you actually tell qemu anything about starting a
>> > migration?
>> 
>> If qemu frees up resources (as it does on unplug) then libvirt
>> is not guaranteed it can roll the change back on e.g.
>> migration failure.
>
> Why should we always free up resources on unplug?
>
> Unplug of a disk device doesn't close the corresponding -blockdev.

It does for block backends created with -drive, and that was a mistake
we corrected with -blockdev.

> Unplug of a serial device doesn't close the corresponding -chardev.
> Unplug of a memory device doesn't close the corresponding memory backend.
> Unplug of a crypto device doesn't close the corresponding crypto backend.
>
> Why do we expect device_del of a passthrough PCI device to always
> release the host side PCI device?  We can provide a better API
> than that.

device_del should free what device_add allocates.

Does device_add allocate the host side PCI device?  If yes, should it?

[...]

