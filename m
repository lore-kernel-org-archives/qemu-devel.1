Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3BFC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACF7213F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACF7213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52833 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDTug-0000zk-1b
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 09:02:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hDTtl-0000iV-PI
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hDTtg-0005PF-GG
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:01:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1hDTtc-0005Df-LN
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:01:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3988B2D7FB;
	Mon,  8 Apr 2019 13:00:55 +0000 (UTC)
Received: from localhost (dhcp-192-206.str.redhat.com [10.33.192.206])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 59B6B5DA2A;
	Mon,  8 Apr 2019 13:00:51 +0000 (UTC)
Date: Mon, 8 Apr 2019 15:00:50 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190408130050.66zn2725wky3aoqd@jenstp.localdomain>
References: <20190322134447.14831-1-jfreimann@redhat.com>
	<20190404082933.ke7tvryocpdd2h54@jenstp.localdomain>
	<20190405085628.GA2819@work-vm>
	<20190405191850-mutt-send-email-mst@kernel.org>
	<20190408091649.GD2687@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <20190408091649.GD2687@work-vm>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 08 Apr 2019 13:00:55 +0000 (UTC)
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
Cc: pkrempa@redhat.com, ehabkost@redhat.com,
	"Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com,
	qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com,
	liran.alon@oracle.com, laine@redhat.com, ogerlitz@mellanox.com,
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408130050.DZYDLi6nVMAnAWytaXhBWh8bHP6oGRlmPv2wYAVfHao@z>

On Mon, Apr 08, 2019 at 10:16:50AM +0100, Dr. David Alan Gilbert wrote:
>* Michael S. Tsirkin (mst@redhat.com) wrote:
>> On Fri, Apr 05, 2019 at 09:56:29AM +0100, Dr. David Alan Gilbert wrote:
>> > * Jens Freimann (jfreimann@redhat.com) wrote:
>> > > On Fri, Mar 22, 2019 at 02:44:45PM +0100, Jens Freimann wrote:
>> > > > This is another attempt at implementing the host side of the
>> > > > net_failover concept
>> > > > (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
>> > > >
>> > > > The general idea is that we have a pair of devices, a vfio-pci and a
>> > > > emulated device. Before migration the vfio device is unplugged and data
>> > > > flows to the emulated device, on the target side another vfio-pci device
>> > > > is plugged in to take over the data-path. In the guest the net_failover
>> > > > module will pair net devices with the same MAC address.
>> > > >
>> > > > * In the first patch the infrastructure for hiding the device is added
>> > > >  for the qbus and qdev APIs. A "hidden" boolean is added to the device
>> > > >  state and it is set based on a callback to the standby device which
>> > > >  registers itself for handling the assessment: "should the primary device
>> > > >  be hidden?" by cross validating the ids of the devices.
>> > > >
>> > > > * In the second patch the virtio-net uses the API to hide the vfio
>> > > >  device and unhides it when the feature is acked.
>> > > >
>> > > > Previous discussion: https://patchwork.ozlabs.org/cover/989098/
>> > > >
>> > > > To summarize concerns/feedback from previous discussion:
>> > > > 1.- guest OS can reject or worse _delay_ unplug by any amount of time.
>> > > >  Migration might get stuck for unpredictable time with unclear reason.
>> > > >  This approach combines two tricky things, hot/unplug and migration.
>> > > >  -> We can surprise-remove the PCI device and in QEMU we can do all
>> > > >     necessary rollbacks transparent to management software. Will it be
>> > > >     easy, probably not.
>> >
>> > This sounds 'fun' - bonus cases are things like what happens if the
>> > guest gets rebooted somewhere during the process or if it's currently
>> > sitting in the bios/grub/etc
>>
>> Um, during which process? Guests are gradually fixed to support
>> surprise removal well. Part of it is thunderbolt which makes
>> it incredibly easy. Yes - bios/grub will need to learn to
>> handle this well.
>
>Ignoring the actual mechanism of the unplug itself; there are probably
>loads of cases; e.g.
>
>      running with both cards
>      hot unplug real card
>      start migration
>      guest reboots
>        Kernel sees only the virtio card
>      migration completes
>      hotadd the real card back
>
>so the guest has to know to pair the real card even though it booted
>with only the virtio card.

Maybe I misunderstand, but, when the 'real card' is added back after
migration the net_failover driver in the guest will know to pair it
with the virtio card because they have the same MAC address. Did you
mean something else?

>I'm sure there are loads of other corners.

Probably yes.

regards,
Jens 

