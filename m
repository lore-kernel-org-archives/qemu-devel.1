Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8448C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 20:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7EC206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 20:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7EC206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIfrP-0004U0-BM
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 16:48:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hIfpQ-0002vr-Qs
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 16:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hIfbz-0003FQ-Ed
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 16:32:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dan.streetman@canonical.com>)
	id 1hIfbz-0003Cz-9d
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 16:32:23 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <dan.streetman@canonical.com>) id 1hIfbw-00065n-1K
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 20:32:20 +0000
Received: by mail-it1-f197.google.com with SMTP id s1so13672032itl.1
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 13:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=UzO3LqHsETKbE6+oQmQ4qXvpjgRr5BoI69iUGjCkedc=;
	b=snwp7upaQMg5I++RJtuKBUO8nKhvRxHlvt80NRQbcC+9FVArMDO27uDH5m9VWXXQG9
	mx/EhsJoNO13tF3N/OroFc9Ry4BRCsPBv20bLki+XAZHOsQ6hlB5hWcTTREX4Nb3/FL2
	L9f91Z2fpOTniJBgl+nnbUUF+56FscOPFQlAqzT1ech5hHfizb5EPt76xapPP04B+6ni
	rkl66eMrnjGHPp9ZMrvdiJ4HmULOgmy/08qZOzO8rXExc9yY5rihq3vkbRa4c5iyuCJg
	zSEGiwKPH91flhN7kW93889h81fgqYC7u1QoHjWyX1hy2Gpx316vn+JVtOCAT7YXNOUS
	UPfA==
X-Gm-Message-State: APjAAAXBFpRyBuJhxmX8O+Ku7A9gznljiKUXRaV5H5POtFJdM40Ud3RU
	DgEw74gBQD02RCuOPhZHn6KvraoN9TFN4GEtB7z7HQ0VIfFbDs0lE+cte6KxlWF4GAoswjLpJHb
	sfcCPHlKwM0NjcTJmVeVarsTitAkmy1WumRiirS00Dl9PgUrX
X-Received: by 2002:a02:1142:: with SMTP id 63mr9099469jaf.19.1555965139058;
	Mon, 22 Apr 2019 13:32:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4mKHTJN4+URRdSsWJKCwnLj8ecWwNZ025jkRBUeV+5Q7Y04GHOtfC1m4baP4sCKz/Ce0AIZ2MQFXDoOjeN0Y=
X-Received: by 2002:a02:1142:: with SMTP id 63mr9099456jaf.19.1555965138822;
	Mon, 22 Apr 2019 13:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190416184624.15397-1-dan.streetman@canonical.com>
	<20190416184624.15397-2-dan.streetman@canonical.com>
	<20190419191328-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190419191328-mutt-send-email-mst@kernel.org>
From: Dan Streetman <dan.streetman@canonical.com>
Date: Mon, 22 Apr 2019 16:31:42 -0400
Message-ID:
 <CAOZ2QJMvPj1VPoiezHjiQpU3m7HMk_i6G=LEUvmi3m_QWM=e8A@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
Subject: Re: [Qemu-devel] [PATCH 1/2] add VirtIONet vhost_stopped flag to
 prevent multiple stops
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422203142.HNXJTjtIlx7aOjilenLzQ7g3d25FzSatPpIsJTQ9CEs@z>

On Fri, Apr 19, 2019 at 7:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 16, 2019 at 02:46:23PM -0400, Dan Streetman wrote:
> > From: Dan Streetman <ddstreet@canonical.com>
> >
> > Buglink: https://launchpad.net/bugs/1823458
> >
> > There is a race condition when using the vhost-user driver, between a guest
> > shutdown and the vhost-user interface being closed.  This is explained in
> > more detail at the bug link above; the short explanation is the vhost-user
> > device can be closed while the main thread is in the middle of stopping
> > the vhost_net.  In this case, the main thread handling shutdown will
> > enter virtio_net_vhost_status() and move into the n->vhost_started (else)
> > block, and call vhost_net_stop(); while it is running that function,
> > another thread is notified that the vhost-user device has been closed,
> > and (indirectly) calls into virtio_net_vhost_status() also.  Since the
> > vhost_net status hasn't yet changed, the second thread also enters
> > the n->vhost_started block, and also calls vhost_net_stop().  This
> > causes problems for the second thread when it tries to stop the network
> > that's already been stopped.
> >
> > This adds a flag to the struct that's atomically set to prevent more than
> > one thread from calling vhost_net_stop().  The atomic_fetch_inc() is likely
> > overkill and probably could be done with a simple check-and-set, but
> > since it's a race condition there would still be a (very, very) small
> > window without using an atomic to set it.
>
> How? Isn't all this under the BQL?

I don't think so, although I'm not deeply familiar with the code.
Note the code path listed in my last email, run from
aio_bh_schedule_oneshot() - does that hold the bql while running?

>
> >
> > Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> > ---
> >  hw/net/virtio-net.c            | 3 ++-
> >  include/hw/virtio/virtio-net.h | 1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index ffe0872fff..d36f50d5dd 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -13,6 +13,7 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "qemu/iov.h"
> > +#include "qemu/atomic.h"
> >  #include "hw/virtio/virtio.h"
> >  #include "net/net.h"
> >  #include "net/checksum.h"
> > @@ -240,7 +241,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
> >                           "falling back on userspace virtio", -r);
> >              n->vhost_started = 0;
> >          }
> > -    } else {
> > +    } else if (atomic_fetch_inc(&n->vhost_stopped) == 0) {
> >          vhost_net_stop(vdev, n->nic->ncs, queues);
> >          n->vhost_started = 0;
> >      }
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> > index b96f0c643f..d03fd933d0 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -164,6 +164,7 @@ struct VirtIONet {
> >      uint8_t nouni;
> >      uint8_t nobcast;
> >      uint8_t vhost_started;
> > +    int vhost_stopped;
> >      struct {
> >          uint32_t in_use;
> >          uint32_t first_multi;
>
> OK questions same as any state:
>
> - do we need to migrate this?
> - reset it on device reset?
>
> > --
> > 2.20.1

