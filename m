Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD073C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 18:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE6D26E0B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 18:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE6D26E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47701 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWmUk-0005BN-Np
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 14:43:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hWmTw-0004uE-5c
	for qemu-devel@nongnu.org; Fri, 31 May 2019 14:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hWmTv-0008TF-2v
	for qemu-devel@nongnu.org; Fri, 31 May 2019 14:42:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hWmTu-0008MN-Tl
	for qemu-devel@nongnu.org; Fri, 31 May 2019 14:42:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBC873006372
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 18:42:20 +0000 (UTC)
Received: from localhost (ovpn-120-246.rdu2.redhat.com [10.10.120.246])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 45110600D1;
	Fri, 31 May 2019 18:42:14 +0000 (UTC)
Date: Fri, 31 May 2019 15:42:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190531184212.GE22103@habkost.net>
References: <20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190530134631-mutt-send-email-mst@kernel.org>
	<20190530180022.GB2864@work-vm>
	<20190530140419-mutt-send-email-mst@kernel.org>
	<20190530182210.GA22103@habkost.net>
	<20190530190322-mutt-send-email-mst@kernel.org>
	<20190531170154.GB22103@habkost.net>
	<20190531135059-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531135059-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 31 May 2019 18:42:20 +0000 (UTC)
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
Cc: pkrempa@redhat.com, berrange@redhat.com, aadam@redhat.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-devel@nongnu.org, laine@redhat.com,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 31, 2019 at 02:04:49PM -0400, Michael S. Tsirkin wrote:
> On Fri, May 31, 2019 at 02:01:54PM -0300, Eduardo Habkost wrote:
> > > Yes. It's just lots of extremely low level interfaces
> > > and all rather pointless.
> > > 
> > > And down the road extensions like surprise removal support will make it
> > > all cleaner and more transparent. Floating things up to libvirt means
> > > all these low level details will require more and more hacks.
> > 
> > Why do you call it pointless?
> 
> We'd need APIs to manipulate device visibility to guest, hotplug
> controller state and separately manipulate the resources allocated. This
> is low level stuff that users really have no idea what to do about.
> Exposing such a level of detail to management is imho pointless.
> We are better off with a high level API, see below.

I don't disagree it's low level.  I just disagree it's pointless.
The goal here is to provide an API that management software can
use.

> 
> > If we want this to work before
> > surprise removal is implemented, we need to provide an API that
> > works for management software.
> >  Don't we want to make this work
> > without surprise removal too?
> 
> This patchset adds an optional, off by default support for
> migrating guests with an assigned network device.
> If enabled this requires guest to allow migration.
> 
> Of course this can be viewed as a security problem since it allows guest
> to block migration. We can't detect a malicious guest reliably imho.
> What we can do is report to management when guest allows migration.
> Policy such what to do when this does not happen for a while and
> what timeout to set would be up to management.
> 
> The API in question would be a high level one, something
> along the lines of a single "guest allowed migration" event.

If you want to hide the low level details behind a higher level
API, that's OK.  I just want to be sure we have really listened
to management software developers to confirm the API we're
providing will work for them.

This will probably require documenting the new interface in more
detail (as you have already mentioned in this thread).

-- 
Eduardo

