Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD848C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 20:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E2E26E5F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 20:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E2E26E5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48895 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWoMo-0002kv-HE
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 16:43:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hWoLu-0002D6-N8
	for qemu-devel@nongnu.org; Fri, 31 May 2019 16:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hWo9x-0000tN-4U
	for qemu-devel@nongnu.org; Fri, 31 May 2019 16:29:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hWo9w-0000sc-TE
	for qemu-devel@nongnu.org; Fri, 31 May 2019 16:29:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE24D20276
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 20:29:41 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C5455D71B;
	Fri, 31 May 2019 20:29:34 +0000 (UTC)
Date: Fri, 31 May 2019 14:29:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190531142933.248cbd17@x1.home>
In-Reply-To: <20190531184512.GN3169@work-vm>
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
	<20190531184512.GN3169@work-vm>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 31 May 2019 20:29:46 +0000 (UTC)
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
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, aadam@redhat.com,
	qemu-devel@nongnu.org, laine@redhat.com, jdenemar@redhat.com,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 May 2019 19:45:13 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Fri, May 31, 2019 at 02:01:54PM -0300, Eduardo Habkost wrote:  
> > > > Yes. It's just lots of extremely low level interfaces
> > > > and all rather pointless.
> > > > 
> > > > And down the road extensions like surprise removal support will make it
> > > > all cleaner and more transparent. Floating things up to libvirt means
> > > > all these low level details will require more and more hacks.  
> > > 
> > > Why do you call it pointless?  
> > 
> > We'd need APIs to manipulate device visibility to guest, hotplug
> > controller state and separately manipulate the resources allocated. This
> > is low level stuff that users really have no idea what to do about.
> > Exposing such a level of detail to management is imho pointless.
> > We are better off with a high level API, see below.  
> 
> so I don't know much about vfio; but to me it strikes me that
> you wouldn't need that low level detail if we just reworked vfio
> to look more like all our other devices;

I don't understand what this means, I thought vfio-pci followed a very
standard device model.

> something like:
> 
>   -vfiodev  host=02:00.0,id=gpu
>   -device vfio-pci,dev=gpu
>
> The 'vfiodev' would own the resources; so to do this trick, the
> management layer would:
>    hotunplug the vfio-pci
>    migrate
> 
> if anything went wrong it would
>    hotplug the vfio-pci backin
> 
> you wouldn't have free'd up any resources because they belonged
> to the vfiodev.

So you're looking more for some sort of frontend-backend separation, we
hot-unplug the frontend device that's exposed to the guest while the
backend device that holds the host resources is still attached.  I
would have hardly guessed that's "like all our other devices".  I was
under the impression (from previous discussions mostly) that the device
removal would be caught before actually allowing the device to finalize
and exit, such that with a failed migration, re-adding the device would
be deterministic since the device is never released back to the host.
I expected that could be done within QEMU, but I guess that's what
we're getting into here is how management tools specify that eject w/o
release semantic.  I don't know what this frontend/backend rework would
look like for vfio-pci, but it seems non-trivial for this one use case
and I don't see that it adds any value outside of this use case,
perhaps quite the opposite, it's an overly complicated interface for
the majority of use cases so we either move to a more complicated
interface or maintain both.  Poor choices either way.  Thanks,

Alex

