Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F019C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 08:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51BB220685
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 08:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BB220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50265 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIrAw-0002nk-KU
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 04:53:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hIr8T-0000fv-Qf
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hIr8Q-0004iw-86
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:50:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dan.streetman@canonical.com>)
	id 1hIr8O-0004hd-Tw
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:50:37 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <dan.streetman@canonical.com>) id 1hIr8M-00010K-VI
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:50:35 +0000
Received: by mail-it1-f197.google.com with SMTP id j8so14938872ita.5
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 01:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=sRYu2rEezoRwg+JLYmIIjLNCGbuPmfLWJsA1Oys7jaY=;
	b=FSYi1XchEz3irS1+WkXCL+1EBqO7a+eDrHACuC1ScvVxRtH2NCsuRRfWmnf4pCdQUn
	yyYijL67k50fUwdLpWL2xea2roavNtMeNmHHYYMCwoPWrlAJRejd3ZhGJEpKY4L4qRN/
	l/2V/qedmb9hw0UbG/8leJ9bGBQFvbC/mZbLORaaGD3GKTWJIHs6x36kQRBEmAnnJW4u
	wtMfZDPMWg1EhXgi61OeZog8abCfQxegdBEKATFeSkW/+DUwc4U9/HB70ADhk2tmKesp
	9djj/FeLpaMq9aE0PRYEkxPMNO/zrKcCmT5gHaugy6skYe3cHCOqD0Hd+zxXqKOPwrC+
	sDOw==
X-Gm-Message-State: APjAAAWxDZiAghqis3haTvbTX+brENMcQL4e5ym8jDeK6h2uD5CBZPzo
	C9T/zMdqbu0nkOO9n9YfISFDmlAh6vOa/cX2RzcfkuELHzq2hQNe55kCzARsxzi2cJDmvkmJFTl
	8sridkfLlCmrV8C4GL8DvhRzdoHd4+UJSyVZ+GAz92OcVmMpp
X-Received: by 2002:a6b:3a8b:: with SMTP id
	h133mr16757506ioa.160.1556009433983; 
	Tue, 23 Apr 2019 01:50:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzEuz03Do5HzbakHd2uv42QsyyN15quKmbs/oHjyfd5g8e4mpOLANjkLgh7J0+kfgul3ZOEmzfluPlNFMspy1I=
X-Received: by 2002:a6b:3a8b:: with SMTP id
	h133mr16757497ioa.160.1556009433679; 
	Tue, 23 Apr 2019 01:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190416184624.15397-1-dan.streetman@canonical.com>
	<20190416184624.15397-2-dan.streetman@canonical.com>
	<9f3dac2a-15fe-8463-6aee-f6916b8d5e1c@redhat.com>
	<CAOZ2QJO5-V4xydkVxKTC-1qnhqhUEMck04D=6+PFkhP9Z9+vmA@mail.gmail.com>
	<ec53494d-99fc-d7b2-987d-ccd79ee47652@redhat.com>
In-Reply-To: <ec53494d-99fc-d7b2-987d-ccd79ee47652@redhat.com>
From: Dan Streetman <dan.streetman@canonical.com>
Date: Tue, 23 Apr 2019 04:49:57 -0400
Message-ID:
 <CAOZ2QJMKO8_8ygcycNf7xVWYWE8GX1PAk7hePB9D8Q5XCq1=yA@mail.gmail.com>
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
Cc: =?UTF-8?Q?marcandre=2Elureau=40redhat=2Ecom_=3E=3E_Marc=2DAndr=C3=A9_Lureau?=
	<marcandre.lureau@redhat.com>, qemu-stable@nongnu.org,
	qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423084957.9hKrEVal_mHU92n1_-B2qRmZGywGrLE4hE4Ob6ITXI8@z>

On Mon, Apr 22, 2019 at 10:59 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/4/23 =E4=B8=8A=E5=8D=884:14, Dan Streetman wrote:
> > On Sun, Apr 21, 2019 at 10:50 PM Jason Wang <jasowang@redhat.com> wrote=
:
> >>
> >> On 2019/4/17 =E4=B8=8A=E5=8D=882:46, Dan Streetman wrote:
> >>> From: Dan Streetman <ddstreet@canonical.com>
> >>>
> >>> Buglink: https://launchpad.net/bugs/1823458
> >>>
> >>> There is a race condition when using the vhost-user driver, between a=
 guest
> >>> shutdown and the vhost-user interface being closed.  This is explaine=
d in
> >>> more detail at the bug link above; the short explanation is the vhost=
-user
> >>> device can be closed while the main thread is in the middle of stoppi=
ng
> >>> the vhost_net.  In this case, the main thread handling shutdown will
> >>> enter virtio_net_vhost_status() and move into the n->vhost_started (e=
lse)
> >>> block, and call vhost_net_stop(); while it is running that function,
> >>> another thread is notified that the vhost-user device has been closed=
,
> >>> and (indirectly) calls into virtio_net_vhost_status() also.
> >>
> >> I think we need figure out why there are multiple vhost_net_stop() cal=
ls
> >> simultaneously. E.g vhost-user register fd handlers like:
> >>
> >>           qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
> >>                                    net_vhost_user_event, NULL, nc0->na=
me,
> >> NULL,
> >>                                    true);
> >>
> >> which uses default main context, so it should only be called only in
> >> main thread.
> > net_vhost_user_event() schedules chr_closed_bh() to do its bottom half
> > work; does aio_bh_schedule_oneshot() execute its events from the main
> > thread?
>
>
> I think so if net_vhost_user_event() was called in main thread (it calls
> qemu_get_current_aio_context()).

ok, I'll check that, thanks!

I think my other patch, to remove the vhost_user_stop() call
completely from the net_vhost_user_event() handler for
CHR_EVENT_CLOSED, is still relevant; do you have thoughts on that?

>
>
> >
> > For reference, the call chain is:
> >
> > chr_closed_bh()
> >    qmp_set_link()
> >      nc->info->link_status_changed() -> virtio_net_set_link_status()
> >        virtio_net_set_status()
> >          virtio_net_vhost_status()
>
>
> The code was added by Marc since:
>
> commit e7c83a885f865128ae3cf1946f8cb538b63cbfba
> Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Date:   Mon Feb 27 14:49:56 2017 +0400
>
>      vhost-user: delay vhost_user_stop
>
> Cc him for more thoughts.
>
> Thanks
>
>
> >> Thanks
> >>
> >>
> >>>    Since the
> >>> vhost_net status hasn't yet changed, the second thread also enters
> >>> the n->vhost_started block, and also calls vhost_net_stop().  This
> >>> causes problems for the second thread when it tries to stop the netwo=
rk
> >>> that's already been stopped.
> >>>
> >>> This adds a flag to the struct that's atomically set to prevent more =
than
> >>> one thread from calling vhost_net_stop().  The atomic_fetch_inc() is =
likely
> >>> overkill and probably could be done with a simple check-and-set, but
> >>> since it's a race condition there would still be a (very, very) small
> >>> window without using an atomic to set it.
> >>>
> >>> Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> >>> ---
> >>>    hw/net/virtio-net.c            | 3 ++-
> >>>    include/hw/virtio/virtio-net.h | 1 +
> >>>    2 files changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >>> index ffe0872fff..d36f50d5dd 100644
> >>> --- a/hw/net/virtio-net.c
> >>> +++ b/hw/net/virtio-net.c
> >>> @@ -13,6 +13,7 @@
> >>>
> >>>    #include "qemu/osdep.h"
> >>>    #include "qemu/iov.h"
> >>> +#include "qemu/atomic.h"
> >>>    #include "hw/virtio/virtio.h"
> >>>    #include "net/net.h"
> >>>    #include "net/checksum.h"
> >>> @@ -240,7 +241,7 @@ static void virtio_net_vhost_status(VirtIONet *n,=
 uint8_t status)
> >>>                             "falling back on userspace virtio", -r);
> >>>                n->vhost_started =3D 0;
> >>>            }
> >>> -    } else {
> >>> +    } else if (atomic_fetch_inc(&n->vhost_stopped) =3D=3D 0) {
> >>>            vhost_net_stop(vdev, n->nic->ncs, queues);
> >>>            n->vhost_started =3D 0;
> >>>        }
> >>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virti=
o-net.h
> >>> index b96f0c643f..d03fd933d0 100644
> >>> --- a/include/hw/virtio/virtio-net.h
> >>> +++ b/include/hw/virtio/virtio-net.h
> >>> @@ -164,6 +164,7 @@ struct VirtIONet {
> >>>        uint8_t nouni;
> >>>        uint8_t nobcast;
> >>>        uint8_t vhost_started;
> >>> +    int vhost_stopped;
> >>>        struct {
> >>>            uint32_t in_use;
> >>>            uint32_t first_multi;

