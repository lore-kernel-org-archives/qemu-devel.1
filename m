Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF8EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FC920879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op8Ex2qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FC920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTot9-0008PL-IB
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:40:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hToqm-0006jo-RQ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hToqd-0001Hc-Q8
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:37:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hToqd-0001GM-Jk
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:37:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id m3so6569247wrv.2
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=eJIJDQqFppwljJjar5r90nYbVx2OX6wIQ7/uP+NLAPo=;
	b=Op8Ex2qe/HzcpXRyRDQ0YodduQONy0F8eP4iZv/ZX9m1KZRAUVDLNAmJvTnn5Q8POD
	5LmAr2XVOXg6v2rmE/YO9U4PZHVQpf2D7vmDwF2e2CVFVS7YFSv+F5DZxGEQURpUl1On
	m1DpNWZeDCqaPH7i6qUKFzPifY7hJoxkXsXqftUU5NDo3b3ei1iBGdRK8VGCaPwdlAgH
	NtrXRE7fKfExNUvucSUL/mRO+DNvGoKJYlpkQCPY/zswSR/cXuxlw3kTmNLJYlTuFCER
	AU3+k/LUGekRmHq0+9R3pW4QNOSxsrky5xFIIf4ckC4fiqi07ZzRAU0hAt6ixLVdyF2c
	6gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=eJIJDQqFppwljJjar5r90nYbVx2OX6wIQ7/uP+NLAPo=;
	b=KzwjKotG0Wskerazpq/tWiNNQEuZJE5I7eUc9xTkdZGOYnoPp5FSFM51KfQ92ifwsv
	bvXVXeGKuAf/ZHYTaBVj9JJfrp5UwIVy7Y0RSBEQ34nsebY4P3dstArsCChNGAem+8jL
	r0sybkpYmtmHHvcMWr3TS3wM++4KLEBYYBfNZgESOlDdNOw63FlVdDeLDKv2o09cIkrw
	Bw+tHD7WiW1Snvbqy9hCQa0xiJa2DGFSW8MbGGxQwWZbDEe5dEPLlDKoFECEwgmMgble
	pfbuP5+rkP3gbpFlh59739z5Pl2PloQy90RV3kqJrGMswtRsr/1V0LXvxFO0t8BxaQhr
	AE8Q==
X-Gm-Message-State: APjAAAWXmf5sHuxmLaznENSJFinskQamgZl5D6AM8l2QmFhYZcZnVnCB
	QZ+OnayJiDjWuKSETeQqL7Ykw0FVbmjvtIVcdcM=
X-Google-Smtp-Source: APXvYqy7nQaV5+18pZpOl/PgQlu5j0qx73KDX5I3MTQOc4SxAXcOew5Eb8Mdalw81P3HxiC8keCxxKQ8U/xPbXrIE00=
X-Received: by 2002:adf:9d8a:: with SMTP id p10mr32281777wre.31.1558622253987; 
	Thu, 23 May 2019 07:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190523110434.23830-1-gert.wollny@collabora.com>
	<CAJ+F1C+=89nSeEyiBowdOsqr5HBtvvNnXp3ZWHBGV_WYYH9kgA@mail.gmail.com>
	<721f520106a799afe003b3b8d3ce4de12daf04f5.camel@collabora.com>
In-Reply-To: <721f520106a799afe003b3b8d3ce4de12daf04f5.camel@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 May 2019 16:37:22 +0200
Message-ID: <CAJ+F1C+vjg47SyBdb7EtvM3JFPpddkko=gXGbsGNqbn0M1u1-Q@mail.gmail.com>
To: Gert Wollny <gert.wollny@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Hi

On Thu, May 23, 2019 at 4:17 PM Gert Wollny <gert.wollny@collabora.com> wro=
te:
>
> Am Donnerstag, den 23.05.2019, 16:01 +0200 schrieb Marc-Andr=C3=A9 Lureau=
:
> > Hi
> >
> > On Thu, May 23, 2019 at 3:27 PM Gert Wollny <
> > gert.wollny@collabora.com> wrote:
> > > The default fence poll time of 10ms (100 Hz) is sufficent for
> > > normal
> > > work loads, but if one wants to play games within the virtual
> > > machine
> > > this value might be too high, so make it possible to configure this
> > > value by using the environment variable QEMU_VIRGL_POLL_FREQ where
> > > the
> > > poll is given in Hz. To acommodate higher poll frequencies also
> > > change
> > > the timer to use micro seconds as base instead of milliseconds.
> > >
> > >
> >
> > This is what VIRGL_RENDERER_THREAD_SYNC helps with. You don't need to
> > do regular polling, but I think it is currently limited to
> > Linux/eventfd only.
>
> As far as I can see only vtest uses this, not qemu.

I don't think there is anything preventing qemu from using it, except
the portability which should be taken care more carefully.

>
> >
> > fwiw, vhost-user-gpu uses it.
>
> Yeah, I tested it on Intel, but AFAICS this hasn't landed yet, no? OTOH
> the drm calls were only implemented for Intel, and I have no idea how
> to implement this for other hardware, like e.g. radeonsi, or even the
> Nvidia blob ...

I just sent v8 for review today:
https://patchew.org/QEMU/20190523132035.20559-1-marcandre.lureau@redhat.com=
/

The DRM bits were replaced by GBM usage, which will give some portability.

Note that those bits are for 2d ops only, and have a simpler ram/mem fallba=
ck.


> Best,
> Gert
>
>
> >
> >
> > > Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
> > > ---
> > >  hw/display/virtio-gpu-3d.c     | 18 ++++++++++++++++--
> > >  include/hw/virtio/virtio-gpu.h |  1 +
> > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-
> > > 3d.c
> > > index 5ee3566ae0..120e593e76 100644
> > > --- a/hw/display/virtio-gpu-3d.c
> > > +++ b/hw/display/virtio-gpu-3d.c
> > > @@ -17,6 +17,7 @@
> > >  #include "trace.h"
> > >  #include "hw/virtio/virtio.h"
> > >  #include "hw/virtio/virtio-gpu.h"
> > > +#include "qemu/cutils.h"
> > >
> > >  #ifdef CONFIG_VIRGL
> > >
> > > @@ -580,7 +581,8 @@ static void virtio_gpu_fence_poll(void *opaque)
> > >      virgl_renderer_poll();
> > >      virtio_gpu_process_cmdq(g);
> > >      if (!QTAILQ_EMPTY(&g->cmdq) || !QTAILQ_EMPTY(&g->fenceq)) {
> > > -        timer_mod(g->fence_poll,
> > > qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1);
> > > +        timer_mod(g->fence_poll,
> > > qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) +
> > > +                                 g->fence_poll_timeout);
> > >      }
> > >  }
> > >
> > > @@ -605,13 +607,25 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
> > >  int virtio_gpu_virgl_init(VirtIOGPU *g)
> > >  {
> > >      int ret;
> > > +    const char *val;
> > >
> > >      ret =3D virgl_renderer_init(g, 0, &virtio_gpu_3d_cbs);
> > >      if (ret !=3D 0) {
> > >          return ret;
> > >      }
> > >
> > > -    g->fence_poll =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
> > > +    g->fence_poll_timeout =3D 10000; /* default 10 ms */
> > > +    val =3D getenv("QEMU_VIRGL_POLL_FREQ");
> > > +    if (val) {
> > > +        unsigned long long poll_freq;
> > > +        if (parse_uint_full(val, &poll_freq, 10) || poll_freq >
> > > UINT32_MAX) {
> > > +            fprintf(stderr, "VIRGL_POLL_FREQ: Invalid integer
> > > `%s'\n", val);
> > > +            exit(1);
> > > +        }
> > > +        g->fence_poll_timeout =3D 1000000 / (uint32_t)poll_freq;
> > > +    }
> > > +
> > > +    g->fence_poll =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
> > >                                   virtio_gpu_fence_poll, g);
> > >
> > >      if (virtio_gpu_stats_enabled(g->conf)) {
> > > diff --git a/include/hw/virtio/virtio-gpu.h
> > > b/include/hw/virtio/virtio-gpu.h
> > > index 60425c5d58..a9e03b25aa 100644
> > > --- a/include/hw/virtio/virtio-gpu.h
> > > +++ b/include/hw/virtio/virtio-gpu.h
> > > @@ -116,6 +116,7 @@ typedef struct VirtIOGPU {
> > >      bool renderer_reset;
> > >      QEMUTimer *fence_poll;
> > >      QEMUTimer *print_stats;
> > > +    uint32_t fence_poll_timeout;
> > >
> > >      uint32_t inflight;
> > >      struct {
> > > --
> > > 2.20.1
> > >
> > >
> >
> >
>
>


--=20
Marc-Andr=C3=A9 Lureau

