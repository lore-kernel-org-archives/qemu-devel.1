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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9372EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555A920863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkgAW6Kk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555A920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToYk-0006Nn-HY
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:19:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hToHY-0006Er-Kx
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hToHX-0004To-Ed
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hToHX-0004SM-4L
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id d18so6419045wrs.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=JbQfnIca/4wOKmTHDjL9IGcKmYMym0Lae3dzCKiXErA=;
	b=EkgAW6KkPXCvPru3fPUdrNPOOasAlVs4hqPY5qTSZJj+hCJcjdo+Le0Is9aik3+68I
	HDniOz5dHqR1TtnTPHA9VMm2Ae6uR/mkbhf29GqHmNWgw4Vra8mpUvf3rRZ9bhEN1ie8
	t6HaeQSwhDpGWiTE3Vg5H5vcyCbZWX13Tw9+jEg1HFmvhssZjQrt+jzQA8EQJvWhq5cW
	2V2+SfMgs+JYBQ27kbO10fDHcFVONhkXm+tJLYIvDDitf819vFl14PcVcmv9vlGQS4lk
	jWoRwxSXwMhLGEsYCSc27xwbGB5RUYQSWnJWLbu/kKK7Dsln5ykM07FQYHN3Gf3fqzro
	5wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=JbQfnIca/4wOKmTHDjL9IGcKmYMym0Lae3dzCKiXErA=;
	b=k01G0b4E+NlJy5Ln3RARc/xJVtw0U1OX4HWJ9pVK6LnaAIvgLjlpW4nkhQ4DneyO0g
	m90qzWTkHcqF2ZLZYKIVsX096cn2McIj1j3pzcyQgTMEYvvvSzO0udshAonG9ksF8Fq+
	t3Vbvza4f5Kp42Cxl2sXkCY7jgoCaTcDYObZH4Yxwav1DIpWx/qIHgcFgJhIORT+yomc
	W9FVsDSN54W43Yh2r1Z9AxyB84VQhb6UIvAOoY2qWlLH3neAaARWTXbiNMa7G16ioG89
	+5GvsHfPWegTq1gYJyVFvYs75+SowSMNnEShUc9ynH6ym8sFfrrJMAqiSV0ihfOrrD1i
	IprA==
X-Gm-Message-State: APjAAAUe4LBSpvpKxfe5TLqH8rpGUyd21YQcmKlzonK7o0f9bULrjnBk
	ApWFsjIDDy5+bK6apysZruBHx9fM+4Z4JZ6vVYKr30iaA6s=
X-Google-Smtp-Source: APXvYqxESkBxbYsRlDvOYmDcL3A8wJ0r53R0T16/k/nJhQziMV+/u4WzD4lPfvbA60EJI2dHzAlXYyyWVW+fb0cbxk0=
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr401143wru.18.1558620075476;
	Thu, 23 May 2019 07:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190523110434.23830-1-gert.wollny@collabora.com>
In-Reply-To: <20190523110434.23830-1-gert.wollny@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 May 2019 16:01:03 +0200
Message-ID: <CAJ+F1C+=89nSeEyiBowdOsqr5HBtvvNnXp3ZWHBGV_WYYH9kgA@mail.gmail.com>
To: Gert Wollny <gert.wollny@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
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

On Thu, May 23, 2019 at 3:27 PM Gert Wollny <gert.wollny@collabora.com> wro=
te:
>
> The default fence poll time of 10ms (100 Hz) is sufficent for normal
> work loads, but if one wants to play games within the virtual machine
> this value might be too high, so make it possible to configure this
> value by using the environment variable QEMU_VIRGL_POLL_FREQ where the
> poll is given in Hz. To acommodate higher poll frequencies also change
> the timer to use micro seconds as base instead of milliseconds.
>
>

This is what VIRGL_RENDERER_THREAD_SYNC helps with. You don't need to
do regular polling, but I think it is currently limited to
Linux/eventfd only.

fwiw, vhost-user-gpu uses it.


> Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
> ---
>  hw/display/virtio-gpu-3d.c     | 18 ++++++++++++++++--
>  include/hw/virtio/virtio-gpu.h |  1 +
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index 5ee3566ae0..120e593e76 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -17,6 +17,7 @@
>  #include "trace.h"
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-gpu.h"
> +#include "qemu/cutils.h"
>
>  #ifdef CONFIG_VIRGL
>
> @@ -580,7 +581,8 @@ static void virtio_gpu_fence_poll(void *opaque)
>      virgl_renderer_poll();
>      virtio_gpu_process_cmdq(g);
>      if (!QTAILQ_EMPTY(&g->cmdq) || !QTAILQ_EMPTY(&g->fenceq)) {
> -        timer_mod(g->fence_poll, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +=
 1);
> +        timer_mod(g->fence_poll, qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) +
> +                                 g->fence_poll_timeout);
>      }
>  }
>
> @@ -605,13 +607,25 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
>  int virtio_gpu_virgl_init(VirtIOGPU *g)
>  {
>      int ret;
> +    const char *val;
>
>      ret =3D virgl_renderer_init(g, 0, &virtio_gpu_3d_cbs);
>      if (ret !=3D 0) {
>          return ret;
>      }
>
> -    g->fence_poll =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
> +    g->fence_poll_timeout =3D 10000; /* default 10 ms */
> +    val =3D getenv("QEMU_VIRGL_POLL_FREQ");
> +    if (val) {
> +        unsigned long long poll_freq;
> +        if (parse_uint_full(val, &poll_freq, 10) || poll_freq > UINT32_M=
AX) {
> +            fprintf(stderr, "VIRGL_POLL_FREQ: Invalid integer `%s'\n", v=
al);
> +            exit(1);
> +        }
> +        g->fence_poll_timeout =3D 1000000 / (uint32_t)poll_freq;
> +    }
> +
> +    g->fence_poll =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
>                                   virtio_gpu_fence_poll, g);
>
>      if (virtio_gpu_stats_enabled(g->conf)) {
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 60425c5d58..a9e03b25aa 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -116,6 +116,7 @@ typedef struct VirtIOGPU {
>      bool renderer_reset;
>      QEMUTimer *fence_poll;
>      QEMUTimer *print_stats;
> +    uint32_t fence_poll_timeout;
>
>      uint32_t inflight;
>      struct {
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

