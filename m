Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E2C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 14:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964DA2488E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 14:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964DA2488E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53199 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYA9A-0008Ms-Gk
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 10:10:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYA8N-0007zt-Kd
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYA8M-0001d1-Ny
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:09:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hYA8M-0001aO-It
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:09:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECA103092667
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 14:09:38 +0000 (UTC)
Received: from localhost (ovpn-120-246.rdu2.redhat.com [10.10.120.246])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D7B431001947;
	Tue,  4 Jun 2019 14:09:31 +0000 (UTC)
Date: Tue, 4 Jun 2019 11:09:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190604140930.GA22103@habkost.net>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190531214748.GN22103@habkost.net>
	<20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
	<20190603193648.GQ22103@habkost.net>
	<20190604134321.txlw7wjwe247g5ug@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604134321.txlw7wjwe247g5ug@jenstp.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 04 Jun 2019 14:09:44 +0000 (UTC)
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

I don't think this is a strong enough reason to move complexity
to QEMU.

This might look like it's reducing complexity in the
QEMU<->libvirt interface, but having QEMU unplugging/plugging
devices automatically without libvirt involvement is actually
complicating that interface.

That said, I won't try to prevent this from being merged if the
maintainers and libvirt developers agree on this interface.

-- 
Eduardo

