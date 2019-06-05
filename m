Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6AFC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE78206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE78206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYX3R-00006n-Nv
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:38:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYX1i-0007VI-CB
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYX1g-0001m1-FT
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:36:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYX1e-0001bc-IZ
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:36:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EFB75945D
	for <qemu-devel@nongnu.org>; Wed,  5 Jun 2019 14:36:18 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A4285C260;
	Wed,  5 Jun 2019 14:36:07 +0000 (UTC)
Date: Wed, 5 Jun 2019 15:36:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190605143605.GC8956@redhat.com>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190531214748.GN22103@habkost.net>
	<20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
	<20190603193648.GQ22103@habkost.net>
	<20190604134321.txlw7wjwe247g5ug@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604134321.txlw7wjwe247g5ug@jenstp.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 05 Jun 2019 14:36:18 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: pkrempa@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com,
	aadam@redhat.com, qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, laine@redhat.com,
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 04, 2019 at 03:43:21PM +0200, Jens Freimann wrote:
> On Mon, Jun 03, 2019 at 04:36:48PM -0300, Eduardo Habkost wrote:
> > On Mon, Jun 03, 2019 at 10:24:56AM +0200, Jens Freimann wrote:
> > > On Fri, May 31, 2019 at 06:47:48PM -0300, Eduardo Habkost wrote:
> > > > On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote:
> > > > > On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrote:
> > > > > > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilbert wrote:
> > > > > > > * Jens Freimann (jfreimann@redhat.com) wrote:
> > > Why is it bad to fully re-create the device in case of a failed migration?
> > 
> > Bad or not, I thought the whole point of doing it inside QEMU was
> > to do something libvirt wouldn't be able to do (namely,
> > unplugging the device while not freeing resources).  If we are
> > doing something that management software is already capable of
> > doing, what's the point?
> 
> Event though management software seems to be capable of it, a failover
> implementation has never happened. As Michael says network failover is
> a mechanism (there's no good reason not to use a PT device if it is
> available), not a policy. We are now trying to implement it in a
> simple way, contained within QEMU.
> 
> > Quoting a previous message from this thread:
> > 
> > On Thu, May 30, 2019 at 02:09:42PM -0400, Michael S. Tsirkin wrote:
> > | > On Thu, May 30, 2019 at 07:00:23PM +0100, Dr. David Alan Gilbert wrote:
> > | > >  This patch series is very
> > | > > odd precisely because it's trying to do the unplug itself in the
> > | > > migration phase rather than let the management layer do it - so unless
> > | > > it's nailed down how to make sure that's really really bullet proof
> > | > > then we've got to go back and ask the question about whether we should
> > | > > really fix it so it can be done by the management layer.
> > | > >
> > | > > Dave
> > | >
> > | > management already said they can't because files get closed and
> > | > resources freed on unplug and so they might not be able to re-add device
> > | > on migration failure. We do it in migration because that is
> > | > where failures can happen and we can recover.
> 
> This is something that I can work on as well, but it doesn't have to
> be part of this patch set in my opinion. Let's say migration fails and we can't
> re-plug the primary device. We can still use the standby (virtio-net)
> device which would only mean slower networking. How likely is it that
> the primary device is grabbed by another VM between unplugging and
> migration failure anyway?

The case of another VM taking the primary device is *not* a problem for
libvirt. We keep track of which device is allocated for use by which
guest, so even if its not currently plugged into the guest, we won't
give it away to a second guest.

The failure scenario is the edge cases where replugging the device fails
for some reason more outside libvirt's control. Running out of file
descriptors, memory allocation failure when pinning guest RAM. Essentially
any failure path that may arise from "device-add vfio..."

In such a case the device won't get replugged. So the mgmt app will think
the migration was rolled back, but the rollback won't be complete as the
original device will be missing.

I guess the question is whether that's really something to worry about ?

Can we justifiably just leave this as a docs problem give that it would
be very rare failure ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

