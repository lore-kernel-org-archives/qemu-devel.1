Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB551C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 20:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E7B20693
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 20:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E7B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43810 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIfRN-0007IN-Qm
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 16:21:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hIfPs-0005wn-V2
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 16:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hIfLE-0006TY-Lt
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 16:15:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dan.streetman@canonical.com>)
	id 1hIfLE-0006So-FO
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 16:15:04 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <dan.streetman@canonical.com>) id 1hIfLC-0004Ta-Tb
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 20:15:03 +0000
Received: by mail-it1-f200.google.com with SMTP id m128so13600852itm.6
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 13:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=aP0GmNLorwZhKysslzgPhJ+XcjI5NgqebVYknxY/tJU=;
	b=NkKA6YIs7vNqxV3RWWyzn2cjJDe+epUIkDGPXykfCfbesN5YH22J5g40bHTlzQGDQT
	iavft/6dTbpcOPHEPsY0wF3p0+P/2L1cxYCwEJRwB77hvfeA9j3ybgDHKBv3Dlt9wn+2
	uge/zfTN2CfQN4opxrsRwu3S+usBziRNUioUVpStQA0Bzg+VaC18gH7YVO9I/CQkw1Pt
	0tFaX4vdz8UriZaX2OWbAL3Nl13EBRBeQ/ePoLThTkNgcDRdG1kTDwm4c31xELuZ26fG
	NRgzDLw9XR4urasINXvAxUxk355mHRv3g626rW53nqAgc1to7cBGjueeKHieUTZPP3R4
	VCSw==
X-Gm-Message-State: APjAAAUWENl9ZzT7tsF1tFrKgfyr2dwjrRl158IJqYSWIzZMDQBYuv/j
	eUGNGQXdo8fjgyF3vHypP/fDCDVCndJ3IKHOExGTweltG0aC2PyYwlMPVOhJPLPdulTcH6Kdols
	ODDL9WvoEnCKFIiVCX/wOderr/llhV/AsEB68OyvztFYSVXYs
X-Received: by 2002:a02:ad07:: with SMTP id s7mr5840222jan.103.1555964101846; 
	Mon, 22 Apr 2019 13:15:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQxsdQXVntrAqfjClMeW4mnUwY9/NLWbr8FUnz/bQet017IhYL2J1grW/cFeaPKnW1kjJbpEDdBz9tYNr6ePA=
X-Received: by 2002:a02:ad07:: with SMTP id s7mr5840212jan.103.1555964101527; 
	Mon, 22 Apr 2019 13:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190416184624.15397-1-dan.streetman@canonical.com>
	<20190416184624.15397-2-dan.streetman@canonical.com>
	<9f3dac2a-15fe-8463-6aee-f6916b8d5e1c@redhat.com>
In-Reply-To: <9f3dac2a-15fe-8463-6aee-f6916b8d5e1c@redhat.com>
From: Dan Streetman <dan.streetman@canonical.com>
Date: Mon, 22 Apr 2019 16:14:25 -0400
Message-ID:
 <CAOZ2QJO5-V4xydkVxKTC-1qnhqhUEMck04D=6+PFkhP9Z9+vmA@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422201425.srHNSS211G7XhJYgkglQoseexMDcPt8R7opCuITIuTI@z>

On Sun, Apr 21, 2019 at 10:50 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/4/17 =E4=B8=8A=E5=8D=882:46, Dan Streetman wrote:
> > From: Dan Streetman <ddstreet@canonical.com>
> >
> > Buglink: https://launchpad.net/bugs/1823458
> >
> > There is a race condition when using the vhost-user driver, between a g=
uest
> > shutdown and the vhost-user interface being closed.  This is explained =
in
> > more detail at the bug link above; the short explanation is the vhost-u=
ser
> > device can be closed while the main thread is in the middle of stopping
> > the vhost_net.  In this case, the main thread handling shutdown will
> > enter virtio_net_vhost_status() and move into the n->vhost_started (els=
e)
> > block, and call vhost_net_stop(); while it is running that function,
> > another thread is notified that the vhost-user device has been closed,
> > and (indirectly) calls into virtio_net_vhost_status() also.
>
>
> I think we need figure out why there are multiple vhost_net_stop() calls
> simultaneously. E.g vhost-user register fd handlers like:
>
>          qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
>                                   net_vhost_user_event, NULL, nc0->name,
> NULL,
>                                   true);
>
> which uses default main context, so it should only be called only in
> main thread.

net_vhost_user_event() schedules chr_closed_bh() to do its bottom half
work; does aio_bh_schedule_oneshot() execute its events from the main
thread?

For reference, the call chain is:

chr_closed_bh()
  qmp_set_link()
    nc->info->link_status_changed() -> virtio_net_set_link_status()
      virtio_net_set_status()
        virtio_net_vhost_status()

>
> Thanks
>
>
> >   Since the
> > vhost_net status hasn't yet changed, the second thread also enters
> > the n->vhost_started block, and also calls vhost_net_stop().  This
> > causes problems for the second thread when it tries to stop the network
> > that's already been stopped.
> >
> > This adds a flag to the struct that's atomically set to prevent more th=
an
> > one thread from calling vhost_net_stop().  The atomic_fetch_inc() is li=
kely
> > overkill and probably could be done with a simple check-and-set, but
> > since it's a race condition there would still be a (very, very) small
> > window without using an atomic to set it.
> >
> > Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> > ---
> >   hw/net/virtio-net.c            | 3 ++-
> >   include/hw/virtio/virtio-net.h | 1 +
> >   2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index ffe0872fff..d36f50d5dd 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -13,6 +13,7 @@
> >
> >   #include "qemu/osdep.h"
> >   #include "qemu/iov.h"
> > +#include "qemu/atomic.h"
> >   #include "hw/virtio/virtio.h"
> >   #include "net/net.h"
> >   #include "net/checksum.h"
> > @@ -240,7 +241,7 @@ static void virtio_net_vhost_status(VirtIONet *n, u=
int8_t status)
> >                            "falling back on userspace virtio", -r);
> >               n->vhost_started =3D 0;
> >           }
> > -    } else {
> > +    } else if (atomic_fetch_inc(&n->vhost_stopped) =3D=3D 0) {
> >           vhost_net_stop(vdev, n->nic->ncs, queues);
> >           n->vhost_started =3D 0;
> >       }
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> > index b96f0c643f..d03fd933d0 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -164,6 +164,7 @@ struct VirtIONet {
> >       uint8_t nouni;
> >       uint8_t nobcast;
> >       uint8_t vhost_started;
> > +    int vhost_stopped;
> >       struct {
> >           uint32_t in_use;
> >           uint32_t first_multi;

