Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647B2C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 19:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB5E24D96
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 19:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB5E24D96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40169 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXt6V-0000G5-JB
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 15:58:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hXsyx-0002yh-UM
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 15:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hXslj-0004NO-9Y
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 15:37:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hXslj-0003VU-1R
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 15:37:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B76F31628E3
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 19:36:59 +0000 (UTC)
Received: from localhost (ovpn-120-246.rdu2.redhat.com [10.10.120.246])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4D56F5D6A9;
	Mon,  3 Jun 2019 19:36:51 +0000 (UTC)
Date: Mon, 3 Jun 2019 16:36:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190603193648.GQ22103@habkost.net>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190531214748.GN22103@habkost.net>
	<20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 03 Jun 2019 19:36:59 +0000 (UTC)
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
Cc: pkrempa@redhat.com, berrange@redhat.com, mst@redhat.com, aadam@redhat.com,
	qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, laine@redhat.com,
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 10:24:56AM +0200, Jens Freimann wrote:
> On Fri, May 31, 2019 at 06:47:48PM -0300, Eduardo Habkost wrote:
> > On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote:
> > > On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilbert wrote:
> > > > > * Jens Freimann (jfreimann@redhat.com) wrote:
> > [...]
> > > > > > +    }
> > > > > > +    if (migration_in_setup(s) && !should_be_hidden && n->primary_dev) {
> > > > > > +        qdev_unplug(n->primary_dev, &err);
> > > > >
> > > > > Not knowing unplug well; can you just explain - is that device hard
> > > > > unplugged and it's gone by the time this function returns or is it still
> > > > > hanging around for some indeterminate time?
> > > 
> > > Qemu will trigger an unplug request via pcie attention button in which case
> > > there could be a delay by the guest operating system. We could give it some
> > > amount of time and if nothing happens try surpise removal or handle the
> > > error otherwise.
> > 
> > I'm missing something here:
> > 
> > Isn't the whole point of the new device-hiding infrastructure to
> > prevent QEMU from closing the VFIO until migration ended
> > successfully?
> 
> No. The point of hiding it is to only add the VFIO (that is configured
> with the same MAC as the virtio-net device) until the
> VIRTIO_NET_F_STANDBY feature is negotiated. We don't want to expose to
> devices with the same MAC to guests who can't handle it.
> 
> > What exactly is preventing QEMU from closing the host VFIO device
> > after the guest OS has handled the unplug request?
> 
> We qdev_unplug() the VFIO device and want the virtio-net standby device to
> take over. If something goes wrong with unplug or
> migration in general we have to qdev_plug() the device back.
> 
> This series does not try to implement new functionality to close a
> device without freeing the resources.
> 
> From the discussion in this thread I understand that is what libvirt
> needs though. Something that will trigger the unplug from the
> guest but not free the devices resources in the host system (which is
> what qdev_unplug() does). Correct?

This is what I understand we need, but this is not what
qdev_unplug() does.

> 
> Why is it bad to fully re-create the device in case of a failed migration?

Bad or not, I thought the whole point of doing it inside QEMU was
to do something libvirt wouldn't be able to do (namely,
unplugging the device while not freeing resources).  If we are
doing something that management software is already capable of
doing, what's the point?

Quoting a previous message from this thread:

On Thu, May 30, 2019 at 02:09:42PM -0400, Michael S. Tsirkin wrote:
| > On Thu, May 30, 2019 at 07:00:23PM +0100, Dr. David Alan Gilbert wrote:
| > >  This patch series is very
| > > odd precisely because it's trying to do the unplug itself in the
| > > migration phase rather than let the management layer do it - so unless
| > > it's nailed down how to make sure that's really really bullet proof
| > > then we've got to go back and ask the question about whether we should
| > > really fix it so it can be done by the management layer.
| > > 
| > > Dave
| > 
| > management already said they can't because files get closed and
| > resources freed on unplug and so they might not be able to re-add device
| > on migration failure. We do it in migration because that is
| > where failures can happen and we can recover.


-- 
Eduardo

