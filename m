Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF83C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DCF20863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DCF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTobR-0000Mh-S1
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:21:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gert.wollny@collabora.com>) id 1hToXX-0005cJ-DC
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gert.wollny@collabora.com>) id 1hToXV-0002cD-FR
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:17:51 -0400
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3]:60888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gert.wollny@collabora.com>)
	id 1hToXT-0002Yw-QW
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:17:49 -0400
Received: from Isengard (unknown [IPv6:2a02:810a:940:4421:55f7:11f5:99cb:72c6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested) (Authenticated sender: gerddie)
	by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 807B92639CC;
	Thu, 23 May 2019 15:17:43 +0100 (BST)
Message-ID: <721f520106a799afe003b3b8d3ce4de12daf04f5.camel@collabora.com>
From: Gert Wollny <gert.wollny@collabora.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Date: Thu, 23 May 2019 16:17:41 +0200
In-Reply-To: <CAJ+F1C+=89nSeEyiBowdOsqr5HBtvvNnXp3ZWHBGV_WYYH9kgA@mail.gmail.com>
References: <20190523110434.23830-1-gert.wollny@collabora.com>
	<CAJ+F1C+=89nSeEyiBowdOsqr5HBtvvNnXp3ZWHBGV_WYYH9kgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1098:0:82:1000:25:2eeb:e3e3
Subject: Re: [Qemu-devel] [PATCH] virtio_gpu_3d: make it possible to
 configure the fence poll time
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Donnerstag, den 23.05.2019, 16:01 +0200 schrieb Marc-Andr=C3=A9 Lureau=
:
> Hi
>=20
> On Thu, May 23, 2019 at 3:27 PM Gert Wollny <
> gert.wollny@collabora.com> wrote:
> > The default fence poll time of 10ms (100 Hz) is sufficent for
> > normal
> > work loads, but if one wants to play games within the virtual
> > machine
> > this value might be too high, so make it possible to configure this
> > value by using the environment variable QEMU_VIRGL_POLL_FREQ where
> > the
> > poll is given in Hz. To acommodate higher poll frequencies also
> > change
> > the timer to use micro seconds as base instead of milliseconds.
> >=20
> >=20
>=20
> This is what VIRGL_RENDERER_THREAD_SYNC helps with. You don't need to
> do regular polling, but I think it is currently limited to
> Linux/eventfd only.

As far as I can see only vtest uses this, not qemu.=20

>=20
> fwiw, vhost-user-gpu uses it.

Yeah, I tested it on Intel, but AFAICS this hasn't landed yet, no? OTOH
the drm calls were only implemented for Intel, and I have no idea how
to implement this for other hardware, like e.g. radeonsi, or even the
Nvidia blob ...

Best,=20
Gert=20


>=20
>=20
> > Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
> > ---
> >  hw/display/virtio-gpu-3d.c     | 18 ++++++++++++++++--
> >  include/hw/virtio/virtio-gpu.h |  1 +
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-
> > 3d.c
> > index 5ee3566ae0..120e593e76 100644
> > --- a/hw/display/virtio-gpu-3d.c
> > +++ b/hw/display/virtio-gpu-3d.c
> > @@ -17,6 +17,7 @@
> >  #include "trace.h"
> >  #include "hw/virtio/virtio.h"
> >  #include "hw/virtio/virtio-gpu.h"
> > +#include "qemu/cutils.h"
> >=20
> >  #ifdef CONFIG_VIRGL
> >=20
> > @@ -580,7 +581,8 @@ static void virtio_gpu_fence_poll(void *opaque)
> >      virgl_renderer_poll();
> >      virtio_gpu_process_cmdq(g);
> >      if (!QTAILQ_EMPTY(&g->cmdq) || !QTAILQ_EMPTY(&g->fenceq)) {
> > -        timer_mod(g->fence_poll,
> > qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1);
> > +        timer_mod(g->fence_poll,
> > qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) +
> > +                                 g->fence_poll_timeout);
> >      }
> >  }
> >=20
> > @@ -605,13 +607,25 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
> >  int virtio_gpu_virgl_init(VirtIOGPU *g)
> >  {
> >      int ret;
> > +    const char *val;
> >=20
> >      ret =3D virgl_renderer_init(g, 0, &virtio_gpu_3d_cbs);
> >      if (ret !=3D 0) {
> >          return ret;
> >      }
> >=20
> > -    g->fence_poll =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
> > +    g->fence_poll_timeout =3D 10000; /* default 10 ms */
> > +    val =3D getenv("QEMU_VIRGL_POLL_FREQ");
> > +    if (val) {
> > +        unsigned long long poll_freq;
> > +        if (parse_uint_full(val, &poll_freq, 10) || poll_freq >
> > UINT32_MAX) {
> > +            fprintf(stderr, "VIRGL_POLL_FREQ: Invalid integer
> > `%s'\n", val);
> > +            exit(1);
> > +        }
> > +        g->fence_poll_timeout =3D 1000000 / (uint32_t)poll_freq;
> > +    }
> > +
> > +    g->fence_poll =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> >                                   virtio_gpu_fence_poll, g);
> >=20
> >      if (virtio_gpu_stats_enabled(g->conf)) {
> > diff --git a/include/hw/virtio/virtio-gpu.h
> > b/include/hw/virtio/virtio-gpu.h
> > index 60425c5d58..a9e03b25aa 100644
> > --- a/include/hw/virtio/virtio-gpu.h
> > +++ b/include/hw/virtio/virtio-gpu.h
> > @@ -116,6 +116,7 @@ typedef struct VirtIOGPU {
> >      bool renderer_reset;
> >      QEMUTimer *fence_poll;
> >      QEMUTimer *print_stats;
> > +    uint32_t fence_poll_timeout;
> >=20
> >      uint32_t inflight;
> >      struct {
> > --
> > 2.20.1
> >=20
> >=20
>=20
>=20



