Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F7DC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 19:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA792075C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 19:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA792075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56581 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYEh9-0002DK-S5
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 15:02:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hYEg1-0001hi-VC
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 15:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hYEg0-00073A-O7
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 15:00:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hYEg0-0006s1-Eb
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 15:00:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D246C7EBC4
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 19:00:31 +0000 (UTC)
Received: from work-vm (ovpn-117-216.ams2.redhat.com [10.36.117.216])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4562B60C91;
	Tue,  4 Jun 2019 19:00:21 +0000 (UTC)
Date: Tue, 4 Jun 2019 20:00:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190604190019.GM3851@work-vm>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190531214748.GN22103@habkost.net>
	<20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
	<20190603193648.GQ22103@habkost.net>
	<20190604134321.txlw7wjwe247g5ug@jenstp.localdomain>
	<20190604125037-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604125037-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 04 Jun 2019 19:00:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] net/virtio: add failover support
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
Cc: pkrempa@redhat.com, berrange@redhat.com,
	Eduardo Habkost <ehabkost@redhat.com>, aadam@redhat.com,
	qemu-devel@nongnu.org, laine@redhat.com,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Tue, Jun 04, 2019 at 03:43:21PM +0200, Jens Freimann wrote:
> > On Mon, Jun 03, 2019 at 04:36:48PM -0300, Eduardo Habkost wrote:
> > > On Mon, Jun 03, 2019 at 10:24:56AM +0200, Jens Freimann wrote:
> > > > On Fri, May 31, 2019 at 06:47:48PM -0300, Eduardo Habkost wrote:
> > > > > On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote:
> > > > > > On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrote:
> > > > > > > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilbert wrote:
> > > > > > > > * Jens Freimann (jfreimann@redhat.com) wrote:
> > > > Why is it bad to fully re-create the device in case of a failed migration?
> > > 
> > > Bad or not, I thought the whole point of doing it inside QEMU was
> > > to do something libvirt wouldn't be able to do (namely,
> > > unplugging the device while not freeing resources).  If we are
> > > doing something that management software is already capable of
> > > doing, what's the point?
> > 
> > Event though management software seems to be capable of it, a failover
> > implementation has never happened. As Michael says network failover is
> > a mechanism (there's no good reason not to use a PT device if it is
> > available), not a policy. We are now trying to implement it in a
> > simple way, contained within QEMU.
> > 
> > > Quoting a previous message from this thread:
> > > 
> > > On Thu, May 30, 2019 at 02:09:42PM -0400, Michael S. Tsirkin wrote:
> > > | > On Thu, May 30, 2019 at 07:00:23PM +0100, Dr. David Alan Gilbert wrote:
> > > | > >  This patch series is very
> > > | > > odd precisely because it's trying to do the unplug itself in the
> > > | > > migration phase rather than let the management layer do it - so unless
> > > | > > it's nailed down how to make sure that's really really bullet proof
> > > | > > then we've got to go back and ask the question about whether we should
> > > | > > really fix it so it can be done by the management layer.
> > > | > >
> > > | > > Dave
> > > | >
> > > | > management already said they can't because files get closed and
> > > | > resources freed on unplug and so they might not be able to re-add device
> > > | > on migration failure. We do it in migration because that is
> > > | > where failures can happen and we can recover.
> > 
> > This is something that I can work on as well, but it doesn't have to
> > be part of this patch set in my opinion. Let's say migration fails and we can't
> > re-plug the primary device. We can still use the standby (virtio-net)
> > device which would only mean slower networking. How likely is it that
> > the primary device is grabbed by another VM between unplugging and
> > migration failure anyway?
> > 
> > regards,
> > Jens
> 
> I think I agree with Eduardo it's very important to handle this corner
> case correctly. Fast networking outside migration is why people use
> failover at all.  Someone who can live with a slower virtio would use
> just that.
> 
> And IIRC this corner case is exactly why libvirt could not
> implement it correctly itself and had to push it up the stack
> until it fell off the cliff :).

So I think we need to have the code that shows we can cope with the
corner cases - or provide a way for libvirt to handle it (which is
my strong preference).

Dave


> > 
> > > 
> > > -- 
> > > Eduardo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

