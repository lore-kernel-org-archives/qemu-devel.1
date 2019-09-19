Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920BEC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BEB121848
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPYEeQ6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEB121848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAqyG-0006yS-3q
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 03:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iAqvN-0005Pg-TF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iAqvF-0006gD-9A
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:32:21 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:37971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iAqvD-0006f4-9c
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:32:11 -0400
Received: by mail-oi1-x230.google.com with SMTP id m16so403944oic.5
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 00:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hZuZF17ARcUyDtNBVv6mXKCoFPF4MRUs6E4JhaZIdZE=;
 b=gPYEeQ6WAamjQZgTz+S+o8LfWpk20G9T+UUcoeTrRq8oJRe1Z05MXYK1T9yS7NEjzD
 CqQf1wtirlBoZWyiWswOOqdUmNmr/hk/Qx91JhikW1VRwpLbNGBXru68PhiuWyPBTN76
 djXNb/VA9HUJusn5buWmFLO6sVShapBeNSkxDzfZApsV6fKyp4snYMrHSrO1bs7mvhQW
 qDBVlH7l6erqcUI4J6v5/BfEaqc6cNM1dFqQVIPqEbKq+F6cKh7uGfmdD/R5ehD0+xKK
 W0fOP/41Tss5ygwT29y0iQHPiJ/th3BTFbQACWe7QjrJsdmJkD8v0gTR7c372HzsQl5A
 O3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hZuZF17ARcUyDtNBVv6mXKCoFPF4MRUs6E4JhaZIdZE=;
 b=X0AuSCiVx+lC1wcC/ZwvucngzSxLRA+zShw1kM02Bl0Nbj4Luoh40gI0rgCNBNM1d/
 TzihAys7F3ADCwybGP1stfB7WT+TYzUVSQRGtQVFKsBpJLWzMmDIS++PE01Dg+IHPK4v
 sq+yIdusi5VKn6AhdhMf74X+tdj5HHU0eaNXAg4fb5Ide1aJfvrd6i/v4y6HqHtmf3YS
 c6jKGjJ+cd8IXW0r9KsVM/tOQkusHcm5FRIOGsOSuyYTI2syS+i62Z4OD+kB4PDaJGvR
 gqIhWZHOQyuLMttjRu+VaOqGbMYfHo+G6g9g8ll3l/hh2frftSgEtU27HmGeBpAe4vZQ
 lFLQ==
X-Gm-Message-State: APjAAAVfcEzeSzcwDst3A9huQE5VgVhUr9jRmHqoq+Tss5TG3ypNWFxW
 2y+juir3hzRKBzU4DykSlqYcSPwJulMNTyHZJzo=
X-Google-Smtp-Source: APXvYqxdNfYOq4JAI/LYHRhusLequKH8/kIcgblq6aVpfOj/1BhG6qBnDDllvvJrI17mUNwD4Q7FIUgU0LyACheaVM4=
X-Received: by 2002:aca:3684:: with SMTP id d126mr1237445oia.157.1568878328838; 
 Thu, 19 Sep 2019 00:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190919070918.16059-1-kraxel@redhat.com>
 <20190919070918.16059-5-kraxel@redhat.com>
In-Reply-To: <20190919070918.16059-5-kraxel@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 19 Sep 2019 15:31:32 +0800
Message-ID: <CAKXe6SK3rkYnUzz--QhZLrV=FFANZ6UayrWuuYvnk9o1xdxxhA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Ying Fang <fangying1@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PULL 4/4] vnc: fix memory leak when vnc disconnect
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=8819=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:12=E5=86=99=E9=81=93=EF=BC=9A

> From: Li Qiang <liq3ea@163.com>
>
> Currently when qemu receives a vnc connect, it creates a 'VncState' to
> represent this connection. In 'vnc_worker_thread_loop' it creates a
> local 'VncState'. The connection 'VcnState' and local 'VncState' exchange
> data in 'vnc_async_encoding_start' and 'vnc_async_encoding_end'.
> In 'zrle_compress_data' it calls 'deflateInit2' to allocate the libz
> library
> opaque data. The 'VncState' used in 'zrle_compress_data' is the local
> 'VncState'. In 'vnc_zrle_clear' it calls 'deflateEnd' to free the libz
> library opaque data. The 'VncState' used in 'vnc_zrle_clear' is the
> connection
> 'VncState'. In currently implementation there will be a memory leak when
> the
> vnc disconnect. Following is the asan output backtrack:
>
> Direct leak of 29760 byte(s) in 5 object(s) allocated from:
>     0 0xffffa67ef3c3 in __interceptor_calloc (/lib64/libasan.so.4+0xd33c3=
)
>     1 0xffffa65071cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb)
>     2 0xffffa5e968f7 in deflateInit2_ (/lib64/libz.so.1+0x78f7)
>     3 0xaaaacec58613 in zrle_compress_data ui/vnc-enc-zrle.c:87
>     4 0xaaaacec58613 in zrle_send_framebuffer_update ui/vnc-enc-zrle.c:34=
4
>     5 0xaaaacec34e77 in vnc_send_framebuffer_update ui/vnc.c:919
>     6 0xaaaacec5e023 in vnc_worker_thread_loop ui/vnc-jobs.c:271
>     7 0xaaaacec5e5e7 in vnc_worker_thread ui/vnc-jobs.c:340
>     8 0xaaaacee4d3c3 in qemu_thread_start util/qemu-thread-posix.c:502
>     9 0xffffa544e8bb in start_thread (/lib64/libpthread.so.0+0x78bb)
>     10 0xffffa53965cb in thread_start (/lib64/libc.so.6+0xd55cb)
>
> This is because the opaque allocated in 'deflateInit2' is not freed in
> 'deflateEnd'. The reason is that the 'deflateEnd' calls 'deflateStateChec=
k'
> and in the latter will check whether 's->strm !=3D strm'(libz's data
> structure).
> This check will be true so in 'deflateEnd' it just return 'Z_STREAM_ERROR=
'
> and
> not free the data allocated in 'deflateInit2'.
>
> The reason this happens is that the 'VncState' contains the whole
> 'VncZrle',
> so when calling 'deflateInit2', the 's->strm' will be the local address.
> So 's->strm !=3D strm' will be true.
>
> To fix this issue, we need to make 'zrle' of 'VncState' to be a pointer.
> Then the connection 'VncState' and local 'VncState' exchange mechanism wi=
ll
> work as expection. The 'tight' of 'VncState' has the same issue, let's
> also turn
> it to a pointer.
>
>
Hello Gerd,

Please make sure this patch doesn't introduce race condition between main
thread and vnc thread which
I have pointed out in two different email threads.

Thanks,
Li Qiang



> Reported-by: Ying Fang <fangying1@huawei.com>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> Message-id: 20190831153922.121308-1-liq3ea@163.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/vnc.h              |   4 +-
>  ui/vnc-enc-tight.c    | 219 +++++++++++++++++++++---------------------
>  ui/vnc-enc-zlib.c     |  11 ++-
>  ui/vnc-enc-zrle.c     |  68 ++++++-------
>  ui/vnc-enc-zrle.inc.c |   2 +-
>  ui/vnc.c              |  28 +++---
>  6 files changed, 170 insertions(+), 162 deletions(-)
>
> diff --git a/ui/vnc.h b/ui/vnc.h
> index 86438609673a..fea79c2fc998 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -338,10 +338,10 @@ struct VncState
>      /* Encoding specific, if you add something here, don't forget to
>       *  update vnc_async_encoding_start()
>       */
> -    VncTight tight;
> +    VncTight *tight;
>      VncZlib zlib;
>      VncHextile hextile;
> -    VncZrle zrle;
> +    VncZrle *zrle;
>      VncZywrle zywrle;
>
>      Notifier mouse_mode_notifier;
> diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
> index 9084c2201b31..1e0851826a84 100644
> --- a/ui/vnc-enc-tight.c
> +++ b/ui/vnc-enc-tight.c
> @@ -116,7 +116,7 @@ static int send_png_rect(VncState *vs, int x, int y,
> int w, int h,
>
>  static bool tight_can_send_png_rect(VncState *vs, int w, int h)
>  {
> -    if (vs->tight.type !=3D VNC_ENCODING_TIGHT_PNG) {
> +    if (vs->tight->type !=3D VNC_ENCODING_TIGHT_PNG) {
>          return false;
>      }
>
> @@ -144,7 +144,7 @@ tight_detect_smooth_image24(VncState *vs, int w, int =
h)
>      int pixels =3D 0;
>      int pix, left[3];
>      unsigned int errors;
> -    unsigned char *buf =3D vs->tight.tight.buffer;
> +    unsigned char *buf =3D vs->tight->tight.buffer;
>
>      /*
>       * If client is big-endian, color samples begin from the second
> @@ -215,7 +215,7 @@ tight_detect_smooth_image24(VncState *vs, int w, int =
h)
>          int pixels =3D 0;                                               =
  \
>          int sample, sum, left[3];                                       =
\
>          unsigned int errors;                                            =
\
> -        unsigned char *buf =3D vs->tight.tight.buffer;                  =
  \
> +        unsigned char *buf =3D vs->tight->tight.buffer;                 =
   \
>                                                                          =
\
>          endian =3D 0; /* FIXME */                                       =
  \
>                                                                          =
\
> @@ -296,8 +296,8 @@ static int
>  tight_detect_smooth_image(VncState *vs, int w, int h)
>  {
>      unsigned int errors;
> -    int compression =3D vs->tight.compression;
> -    int quality =3D vs->tight.quality;
> +    int compression =3D vs->tight->compression;
> +    int quality =3D vs->tight->quality;
>
>      if (!vs->vd->lossy) {
>          return 0;
> @@ -309,7 +309,7 @@ tight_detect_smooth_image(VncState *vs, int w, int h)
>          return 0;
>      }
>
> -    if (vs->tight.quality !=3D (uint8_t)-1) {
> +    if (vs->tight->quality !=3D (uint8_t)-1) {
>          if (w * h < VNC_TIGHT_JPEG_MIN_RECT_SIZE) {
>              return 0;
>          }
> @@ -320,9 +320,9 @@ tight_detect_smooth_image(VncState *vs, int w, int h)
>      }
>
>      if (vs->client_pf.bytes_per_pixel =3D=3D 4) {
> -        if (vs->tight.pixel24) {
> +        if (vs->tight->pixel24) {
>              errors =3D tight_detect_smooth_image24(vs, w, h);
> -            if (vs->tight.quality !=3D (uint8_t)-1) {
> +            if (vs->tight->quality !=3D (uint8_t)-1) {
>                  return (errors < tight_conf[quality].jpeg_threshold24);
>              }
>              return (errors <
> tight_conf[compression].gradient_threshold24);
> @@ -352,7 +352,7 @@ tight_detect_smooth_image(VncState *vs, int w, int h)
>          uint##bpp##_t c0, c1, ci;                                       =
\
>          int i, n0, n1;                                                  =
\
>                                                                          =
\
> -        data =3D (uint##bpp##_t *)vs->tight.tight.buffer;               =
  \
> +        data =3D (uint##bpp##_t *)vs->tight->tight.buffer;              =
  \
>                                                                          =
\
>          c0 =3D data[0];                                                 =
  \
>          i =3D 1;                                                        =
  \
> @@ -423,9 +423,9 @@ static int tight_fill_palette(VncState *vs, int x, in=
t
> y,
>  {
>      int max;
>
> -    max =3D count /
> tight_conf[vs->tight.compression].idx_max_colors_divisor;
> +    max =3D count /
> tight_conf[vs->tight->compression].idx_max_colors_divisor;
>      if (max < 2 &&
> -        count >=3D tight_conf[vs->tight.compression].mono_min_rect_size)=
 {
> +        count >=3D tight_conf[vs->tight->compression].mono_min_rect_size=
) {
>          max =3D 2;
>      }
>      if (max >=3D 256) {
> @@ -558,7 +558,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf,
> int w, int h)
>      int x, y, c;
>
>      buf32 =3D (uint32_t *)buf;
> -    memset(vs->tight.gradient.buffer, 0, w * 3 * sizeof(int));
> +    memset(vs->tight->gradient.buffer, 0, w * 3 * sizeof(int));
>
>      if (1 /* FIXME */) {
>          shift[0] =3D vs->client_pf.rshift;
> @@ -575,7 +575,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf,
> int w, int h)
>              upper[c] =3D 0;
>              here[c] =3D 0;
>          }
> -        prev =3D (int *)vs->tight.gradient.buffer;
> +        prev =3D (int *)vs->tight->gradient.buffer;
>          for (x =3D 0; x < w; x++) {
>              pix32 =3D *buf32++;
>              for (c =3D 0; c < 3; c++) {
> @@ -615,7 +615,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf,
> int w, int h)
>          int prediction;                                                 =
\
>          int x, y, c;                                                    =
\
>                                                                          =
\
> -        memset (vs->tight.gradient.buffer, 0, w * 3 * sizeof(int));     =
\
> +        memset(vs->tight->gradient.buffer, 0, w * 3 * sizeof(int));     =
\
>                                                                          =
\
>          endian =3D 0; /* FIXME */                                       =
  \
>                                                                          =
\
> @@ -631,7 +631,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf,
> int w, int h)
>                  upper[c] =3D 0;                                         =
  \
>                  here[c] =3D 0;                                          =
  \
>              }                                                           =
\
> -            prev =3D (int *)vs->tight.gradient.buffer;                  =
  \
> +            prev =3D (int *)vs->tight->gradient.buffer;                 =
   \
>              for (x =3D 0; x < w; x++) {                                 =
  \
>                  pix =3D *buf;                                           =
  \
>                  if (endian) {                                           =
\
> @@ -785,7 +785,7 @@ static void extend_solid_area(VncState *vs, int x, in=
t
> y, int w, int h,
>  static int tight_init_stream(VncState *vs, int stream_id,
>                               int level, int strategy)
>  {
> -    z_streamp zstream =3D &vs->tight.stream[stream_id];
> +    z_streamp zstream =3D &vs->tight->stream[stream_id];
>
>      if (zstream->opaque =3D=3D NULL) {
>          int err;
> @@ -803,15 +803,15 @@ static int tight_init_stream(VncState *vs, int
> stream_id,
>              return -1;
>          }
>
> -        vs->tight.levels[stream_id] =3D level;
> +        vs->tight->levels[stream_id] =3D level;
>          zstream->opaque =3D vs;
>      }
>
> -    if (vs->tight.levels[stream_id] !=3D level) {
> +    if (vs->tight->levels[stream_id] !=3D level) {
>          if (deflateParams(zstream, level, strategy) !=3D Z_OK) {
>              return -1;
>          }
> -        vs->tight.levels[stream_id] =3D level;
> +        vs->tight->levels[stream_id] =3D level;
>      }
>      return 0;
>  }
> @@ -839,11 +839,11 @@ static void tight_send_compact_size(VncState *vs,
> size_t len)
>  static int tight_compress_data(VncState *vs, int stream_id, size_t bytes=
,
>                                 int level, int strategy)
>  {
> -    z_streamp zstream =3D &vs->tight.stream[stream_id];
> +    z_streamp zstream =3D &vs->tight->stream[stream_id];
>      int previous_out;
>
>      if (bytes < VNC_TIGHT_MIN_TO_COMPRESS) {
> -        vnc_write(vs, vs->tight.tight.buffer, vs->tight.tight.offset);
> +        vnc_write(vs, vs->tight->tight.buffer, vs->tight->tight.offset);
>          return bytes;
>      }
>
> @@ -852,13 +852,13 @@ static int tight_compress_data(VncState *vs, int
> stream_id, size_t bytes,
>      }
>
>      /* reserve memory in output buffer */
> -    buffer_reserve(&vs->tight.zlib, bytes + 64);
> +    buffer_reserve(&vs->tight->zlib, bytes + 64);
>
>      /* set pointers */
> -    zstream->next_in =3D vs->tight.tight.buffer;
> -    zstream->avail_in =3D vs->tight.tight.offset;
> -    zstream->next_out =3D vs->tight.zlib.buffer + vs->tight.zlib.offset;
> -    zstream->avail_out =3D vs->tight.zlib.capacity - vs->tight.zlib.offs=
et;
> +    zstream->next_in =3D vs->tight->tight.buffer;
> +    zstream->avail_in =3D vs->tight->tight.offset;
> +    zstream->next_out =3D vs->tight->zlib.buffer + vs->tight->zlib.offse=
t;
> +    zstream->avail_out =3D vs->tight->zlib.capacity -
> vs->tight->zlib.offset;
>      previous_out =3D zstream->avail_out;
>      zstream->data_type =3D Z_BINARY;
>
> @@ -868,14 +868,14 @@ static int tight_compress_data(VncState *vs, int
> stream_id, size_t bytes,
>          return -1;
>      }
>
> -    vs->tight.zlib.offset =3D vs->tight.zlib.capacity - zstream->avail_o=
ut;
> +    vs->tight->zlib.offset =3D vs->tight->zlib.capacity -
> zstream->avail_out;
>      /* ...how much data has actually been produced by deflate() */
>      bytes =3D previous_out - zstream->avail_out;
>
>      tight_send_compact_size(vs, bytes);
> -    vnc_write(vs, vs->tight.zlib.buffer, bytes);
> +    vnc_write(vs, vs->tight->zlib.buffer, bytes);
>
> -    buffer_reset(&vs->tight.zlib);
> +    buffer_reset(&vs->tight->zlib);
>
>      return bytes;
>  }
> @@ -927,16 +927,17 @@ static int send_full_color_rect(VncState *vs, int x=
,
> int y, int w, int h)
>
>      vnc_write_u8(vs, stream << 4); /* no flushing, no filter */
>
> -    if (vs->tight.pixel24) {
> -        tight_pack24(vs, vs->tight.tight.buffer, w * h,
> &vs->tight.tight.offset);
> +    if (vs->tight->pixel24) {
> +        tight_pack24(vs, vs->tight->tight.buffer, w * h,
> +                     &vs->tight->tight.offset);
>          bytes =3D 3;
>      } else {
>          bytes =3D vs->client_pf.bytes_per_pixel;
>      }
>
>      bytes =3D tight_compress_data(vs, stream, w * h * bytes,
> -
> tight_conf[vs->tight.compression].raw_zlib_level,
> -                                Z_DEFAULT_STRATEGY);
> +
> tight_conf[vs->tight->compression].raw_zlib_level,
> +                            Z_DEFAULT_STRATEGY);
>
>      return (bytes >=3D 0);
>  }
> @@ -947,14 +948,14 @@ static int send_solid_rect(VncState *vs)
>
>      vnc_write_u8(vs, VNC_TIGHT_FILL << 4); /* no flushing, no filter */
>
> -    if (vs->tight.pixel24) {
> -        tight_pack24(vs, vs->tight.tight.buffer, 1,
> &vs->tight.tight.offset);
> +    if (vs->tight->pixel24) {
> +        tight_pack24(vs, vs->tight->tight.buffer, 1,
> &vs->tight->tight.offset);
>          bytes =3D 3;
>      } else {
>          bytes =3D vs->client_pf.bytes_per_pixel;
>      }
>
> -    vnc_write(vs, vs->tight.tight.buffer, bytes);
> +    vnc_write(vs, vs->tight->tight.buffer, bytes);
>      return 1;
>  }
>
> @@ -963,7 +964,7 @@ static int send_mono_rect(VncState *vs, int x, int y,
>  {
>      ssize_t bytes;
>      int stream =3D 1;
> -    int level =3D tight_conf[vs->tight.compression].mono_zlib_level;
> +    int level =3D tight_conf[vs->tight->compression].mono_zlib_level;
>
>  #ifdef CONFIG_VNC_PNG
>      if (tight_can_send_png_rect(vs, w, h)) {
> @@ -991,26 +992,26 @@ static int send_mono_rect(VncState *vs, int x, int =
y,
>          uint32_t buf[2] =3D {bg, fg};
>          size_t ret =3D sizeof (buf);
>
> -        if (vs->tight.pixel24) {
> +        if (vs->tight->pixel24) {
>              tight_pack24(vs, (unsigned char*)buf, 2, &ret);
>          }
>          vnc_write(vs, buf, ret);
>
> -        tight_encode_mono_rect32(vs->tight.tight.buffer, w, h, bg, fg);
> +        tight_encode_mono_rect32(vs->tight->tight.buffer, w, h, bg, fg);
>          break;
>      }
>      case 2:
>          vnc_write(vs, &bg, 2);
>          vnc_write(vs, &fg, 2);
> -        tight_encode_mono_rect16(vs->tight.tight.buffer, w, h, bg, fg);
> +        tight_encode_mono_rect16(vs->tight->tight.buffer, w, h, bg, fg);
>          break;
>      default:
>          vnc_write_u8(vs, bg);
>          vnc_write_u8(vs, fg);
> -        tight_encode_mono_rect8(vs->tight.tight.buffer, w, h, bg, fg);
> +        tight_encode_mono_rect8(vs->tight->tight.buffer, w, h, bg, fg);
>          break;
>      }
> -    vs->tight.tight.offset =3D bytes;
> +    vs->tight->tight.offset =3D bytes;
>
>      bytes =3D tight_compress_data(vs, stream, bytes, level,
> Z_DEFAULT_STRATEGY);
>      return (bytes >=3D 0);
> @@ -1040,7 +1041,7 @@ static void write_palette(int idx, uint32_t color,
> void *opaque)
>  static bool send_gradient_rect(VncState *vs, int x, int y, int w, int h)
>  {
>      int stream =3D 3;
> -    int level =3D tight_conf[vs->tight.compression].gradient_zlib_level;
> +    int level =3D tight_conf[vs->tight->compression].gradient_zlib_level=
;
>      ssize_t bytes;
>
>      if (vs->client_pf.bytes_per_pixel =3D=3D 1) {
> @@ -1050,23 +1051,23 @@ static bool send_gradient_rect(VncState *vs, int
> x, int y, int w, int h)
>      vnc_write_u8(vs, (stream | VNC_TIGHT_EXPLICIT_FILTER) << 4);
>      vnc_write_u8(vs, VNC_TIGHT_FILTER_GRADIENT);
>
> -    buffer_reserve(&vs->tight.gradient, w * 3 * sizeof (int));
> +    buffer_reserve(&vs->tight->gradient, w * 3 * sizeof(int));
>
> -    if (vs->tight.pixel24) {
> -        tight_filter_gradient24(vs, vs->tight.tight.buffer, w, h);
> +    if (vs->tight->pixel24) {
> +        tight_filter_gradient24(vs, vs->tight->tight.buffer, w, h);
>          bytes =3D 3;
>      } else if (vs->client_pf.bytes_per_pixel =3D=3D 4) {
> -        tight_filter_gradient32(vs, (uint32_t *)vs->tight.tight.buffer,
> w, h);
> +        tight_filter_gradient32(vs, (uint32_t *)vs->tight->tight.buffer,
> w, h);
>          bytes =3D 4;
>      } else {
> -        tight_filter_gradient16(vs, (uint16_t *)vs->tight.tight.buffer,
> w, h);
> +        tight_filter_gradient16(vs, (uint16_t *)vs->tight->tight.buffer,
> w, h);
>          bytes =3D 2;
>      }
>
> -    buffer_reset(&vs->tight.gradient);
> +    buffer_reset(&vs->tight->gradient);
>
>      bytes =3D w * h * bytes;
> -    vs->tight.tight.offset =3D bytes;
> +    vs->tight->tight.offset =3D bytes;
>
>      bytes =3D tight_compress_data(vs, stream, bytes,
>                                  level, Z_FILTERED);
> @@ -1077,7 +1078,7 @@ static int send_palette_rect(VncState *vs, int x,
> int y,
>                               int w, int h, VncPalette *palette)
>  {
>      int stream =3D 2;
> -    int level =3D tight_conf[vs->tight.compression].idx_zlib_level;
> +    int level =3D tight_conf[vs->tight->compression].idx_zlib_level;
>      int colors;
>      ssize_t bytes;
>
> @@ -1104,12 +1105,12 @@ static int send_palette_rect(VncState *vs, int x,
> int y,
>          palette_iter(palette, write_palette, &priv);
>          vnc_write(vs, header, sizeof(header));
>
> -        if (vs->tight.pixel24) {
> +        if (vs->tight->pixel24) {
>              tight_pack24(vs, vs->output.buffer + old_offset, colors,
> &offset);
>              vs->output.offset =3D old_offset + offset;
>          }
>
> -        tight_encode_indexed_rect32(vs->tight.tight.buffer, w * h,
> palette);
> +        tight_encode_indexed_rect32(vs->tight->tight.buffer, w * h,
> palette);
>          break;
>      }
>      case 2:
> @@ -1119,7 +1120,7 @@ static int send_palette_rect(VncState *vs, int x,
> int y,
>
>          palette_iter(palette, write_palette, &priv);
>          vnc_write(vs, header, sizeof(header));
> -        tight_encode_indexed_rect16(vs->tight.tight.buffer, w * h,
> palette);
> +        tight_encode_indexed_rect16(vs->tight->tight.buffer, w * h,
> palette);
>          break;
>      }
>      default:
> @@ -1127,7 +1128,7 @@ static int send_palette_rect(VncState *vs, int x,
> int y,
>          break;
>      }
>      bytes =3D w * h;
> -    vs->tight.tight.offset =3D bytes;
> +    vs->tight->tight.offset =3D bytes;
>
>      bytes =3D tight_compress_data(vs, stream, bytes,
>                                  level, Z_DEFAULT_STRATEGY);
> @@ -1146,7 +1147,7 @@ static int send_palette_rect(VncState *vs, int x,
> int y,
>  static void jpeg_init_destination(j_compress_ptr cinfo)
>  {
>      VncState *vs =3D cinfo->client_data;
> -    Buffer *buffer =3D &vs->tight.jpeg;
> +    Buffer *buffer =3D &vs->tight->jpeg;
>
>      cinfo->dest->next_output_byte =3D (JOCTET *)buffer->buffer +
> buffer->offset;
>      cinfo->dest->free_in_buffer =3D (size_t)(buffer->capacity -
> buffer->offset);
> @@ -1156,7 +1157,7 @@ static void jpeg_init_destination(j_compress_ptr
> cinfo)
>  static boolean jpeg_empty_output_buffer(j_compress_ptr cinfo)
>  {
>      VncState *vs =3D cinfo->client_data;
> -    Buffer *buffer =3D &vs->tight.jpeg;
> +    Buffer *buffer =3D &vs->tight->jpeg;
>
>      buffer->offset =3D buffer->capacity;
>      buffer_reserve(buffer, 2048);
> @@ -1168,7 +1169,7 @@ static boolean
> jpeg_empty_output_buffer(j_compress_ptr cinfo)
>  static void jpeg_term_destination(j_compress_ptr cinfo)
>  {
>      VncState *vs =3D cinfo->client_data;
> -    Buffer *buffer =3D &vs->tight.jpeg;
> +    Buffer *buffer =3D &vs->tight->jpeg;
>
>      buffer->offset =3D buffer->capacity - cinfo->dest->free_in_buffer;
>  }
> @@ -1187,7 +1188,7 @@ static int send_jpeg_rect(VncState *vs, int x, int
> y, int w, int h, int quality)
>          return send_full_color_rect(vs, x, y, w, h);
>      }
>
> -    buffer_reserve(&vs->tight.jpeg, 2048);
> +    buffer_reserve(&vs->tight->jpeg, 2048);
>
>      cinfo.err =3D jpeg_std_error(&jerr);
>      jpeg_create_compress(&cinfo);
> @@ -1222,9 +1223,9 @@ static int send_jpeg_rect(VncState *vs, int x, int
> y, int w, int h, int quality)
>
>      vnc_write_u8(vs, VNC_TIGHT_JPEG << 4);
>
> -    tight_send_compact_size(vs, vs->tight.jpeg.offset);
> -    vnc_write(vs, vs->tight.jpeg.buffer, vs->tight.jpeg.offset);
> -    buffer_reset(&vs->tight.jpeg);
> +    tight_send_compact_size(vs, vs->tight->jpeg.offset);
> +    vnc_write(vs, vs->tight->jpeg.buffer, vs->tight->jpeg.offset);
> +    buffer_reset(&vs->tight->jpeg);
>
>      return 1;
>  }
> @@ -1240,7 +1241,7 @@ static void write_png_palette(int idx, uint32_t pix=
,
> void *opaque)
>      VncState *vs =3D priv->vs;
>      png_colorp color =3D &priv->png_palette[idx];
>
> -    if (vs->tight.pixel24)
> +    if (vs->tight->pixel24)
>      {
>          color->red =3D (pix >> vs->client_pf.rshift) & vs->client_pf.rma=
x;
>          color->green =3D (pix >> vs->client_pf.gshift) & vs->client_pf.g=
max;
> @@ -1267,10 +1268,10 @@ static void png_write_data(png_structp png_ptr,
> png_bytep data,
>  {
>      VncState *vs =3D png_get_io_ptr(png_ptr);
>
> -    buffer_reserve(&vs->tight.png, vs->tight.png.offset + length);
> -    memcpy(vs->tight.png.buffer + vs->tight.png.offset, data, length);
> +    buffer_reserve(&vs->tight->png, vs->tight->png.offset + length);
> +    memcpy(vs->tight->png.buffer + vs->tight->png.offset, data, length);
>
> -    vs->tight.png.offset +=3D length;
> +    vs->tight->png.offset +=3D length;
>  }
>
>  static void png_flush_data(png_structp png_ptr)
> @@ -1295,8 +1296,8 @@ static int send_png_rect(VncState *vs, int x, int y=
,
> int w, int h,
>      png_infop info_ptr;
>      png_colorp png_palette =3D NULL;
>      pixman_image_t *linebuf;
> -    int level =3D tight_png_conf[vs->tight.compression].png_zlib_level;
> -    int filters =3D tight_png_conf[vs->tight.compression].png_filters;
> +    int level =3D tight_png_conf[vs->tight->compression].png_zlib_level;
> +    int filters =3D tight_png_conf[vs->tight->compression].png_filters;
>      uint8_t *buf;
>      int dy;
>
> @@ -1340,21 +1341,23 @@ static int send_png_rect(VncState *vs, int x, int
> y, int w, int h,
>          png_set_PLTE(png_ptr, info_ptr, png_palette,
> palette_size(palette));
>
>          if (vs->client_pf.bytes_per_pixel =3D=3D 4) {
> -            tight_encode_indexed_rect32(vs->tight.tight.buffer, w * h,
> palette);
> +            tight_encode_indexed_rect32(vs->tight->tight.buffer, w * h,
> +                                        palette);
>          } else {
> -            tight_encode_indexed_rect16(vs->tight.tight.buffer, w * h,
> palette);
> +            tight_encode_indexed_rect16(vs->tight->tight.buffer, w * h,
> +                                        palette);
>          }
>      }
>
>      png_write_info(png_ptr, info_ptr);
>
> -    buffer_reserve(&vs->tight.png, 2048);
> +    buffer_reserve(&vs->tight->png, 2048);
>      linebuf =3D qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, w);
>      buf =3D (uint8_t *)pixman_image_get_data(linebuf);
>      for (dy =3D 0; dy < h; dy++)
>      {
>          if (color_type =3D=3D PNG_COLOR_TYPE_PALETTE) {
> -            memcpy(buf, vs->tight.tight.buffer + (dy * w), w);
> +            memcpy(buf, vs->tight->tight.buffer + (dy * w), w);
>          } else {
>              qemu_pixman_linebuf_fill(linebuf, vs->vd->server, w, x, y +
> dy);
>          }
> @@ -1372,27 +1375,27 @@ static int send_png_rect(VncState *vs, int x, int
> y, int w, int h,
>
>      vnc_write_u8(vs, VNC_TIGHT_PNG << 4);
>
> -    tight_send_compact_size(vs, vs->tight.png.offset);
> -    vnc_write(vs, vs->tight.png.buffer, vs->tight.png.offset);
> -    buffer_reset(&vs->tight.png);
> +    tight_send_compact_size(vs, vs->tight->png.offset);
> +    vnc_write(vs, vs->tight->png.buffer, vs->tight->png.offset);
> +    buffer_reset(&vs->tight->png);
>      return 1;
>  }
>  #endif /* CONFIG_VNC_PNG */
>
>  static void vnc_tight_start(VncState *vs)
>  {
> -    buffer_reset(&vs->tight.tight);
> +    buffer_reset(&vs->tight->tight);
>
>      // make the output buffer be the zlib buffer, so we can compress it
> later
> -    vs->tight.tmp =3D vs->output;
> -    vs->output =3D vs->tight.tight;
> +    vs->tight->tmp =3D vs->output;
> +    vs->output =3D vs->tight->tight;
>  }
>
>  static void vnc_tight_stop(VncState *vs)
>  {
>      // switch back to normal output/zlib buffers
> -    vs->tight.tight =3D vs->output;
> -    vs->output =3D vs->tight.tmp;
> +    vs->tight->tight =3D vs->output;
> +    vs->output =3D vs->tight->tmp;
>  }
>
>  static int send_sub_rect_nojpeg(VncState *vs, int x, int y, int w, int h=
,
> @@ -1426,9 +1429,9 @@ static int send_sub_rect_jpeg(VncState *vs, int x,
> int y, int w, int h,
>      int ret;
>
>      if (colors =3D=3D 0) {
> -        if (force || (tight_jpeg_conf[vs->tight.quality].jpeg_full &&
> +        if (force || (tight_jpeg_conf[vs->tight->quality].jpeg_full &&
>                        tight_detect_smooth_image(vs, w, h))) {
> -            int quality =3D tight_conf[vs->tight.quality].jpeg_quality;
> +            int quality =3D tight_conf[vs->tight->quality].jpeg_quality;
>
>              ret =3D send_jpeg_rect(vs, x, y, w, h, quality);
>          } else {
> @@ -1440,9 +1443,9 @@ static int send_sub_rect_jpeg(VncState *vs, int x,
> int y, int w, int h,
>          ret =3D send_mono_rect(vs, x, y, w, h, bg, fg);
>      } else if (colors <=3D 256) {
>          if (force || (colors > 96 &&
> -                      tight_jpeg_conf[vs->tight.quality].jpeg_idx &&
> +                      tight_jpeg_conf[vs->tight->quality].jpeg_idx &&
>                        tight_detect_smooth_image(vs, w, h))) {
> -            int quality =3D tight_conf[vs->tight.quality].jpeg_quality;
> +            int quality =3D tight_conf[vs->tight->quality].jpeg_quality;
>
>              ret =3D send_jpeg_rect(vs, x, y, w, h, quality);
>          } else {
> @@ -1480,20 +1483,20 @@ static int send_sub_rect(VncState *vs, int x, int
> y, int w, int h)
>          qemu_thread_atexit_add(&vnc_tight_cleanup_notifier);
>      }
>
> -    vnc_framebuffer_update(vs, x, y, w, h, vs->tight.type);
> +    vnc_framebuffer_update(vs, x, y, w, h, vs->tight->type);
>
>      vnc_tight_start(vs);
>      vnc_raw_send_framebuffer_update(vs, x, y, w, h);
>      vnc_tight_stop(vs);
>
>  #ifdef CONFIG_VNC_JPEG
> -    if (!vs->vd->non_adaptive && vs->tight.quality !=3D (uint8_t)-1) {
> +    if (!vs->vd->non_adaptive && vs->tight->quality !=3D (uint8_t)-1) {
>          double freq =3D vnc_update_freq(vs, x, y, w, h);
>
> -        if (freq < tight_jpeg_conf[vs->tight.quality].jpeg_freq_min) {
> +        if (freq < tight_jpeg_conf[vs->tight->quality].jpeg_freq_min) {
>              allow_jpeg =3D false;
>          }
> -        if (freq >=3D
> tight_jpeg_conf[vs->tight.quality].jpeg_freq_threshold) {
> +        if (freq >=3D
> tight_jpeg_conf[vs->tight->quality].jpeg_freq_threshold) {
>              force_jpeg =3D true;
>              vnc_sent_lossy_rect(vs, x, y, w, h);
>          }
> @@ -1503,7 +1506,7 @@ static int send_sub_rect(VncState *vs, int x, int y=
,
> int w, int h)
>      colors =3D tight_fill_palette(vs, x, y, w * h, &bg, &fg,
> color_count_palette);
>
>  #ifdef CONFIG_VNC_JPEG
> -    if (allow_jpeg && vs->tight.quality !=3D (uint8_t)-1) {
> +    if (allow_jpeg && vs->tight->quality !=3D (uint8_t)-1) {
>          ret =3D send_sub_rect_jpeg(vs, x, y, w, h, bg, fg, colors,
>                                   color_count_palette, force_jpeg);
>      } else {
> @@ -1520,7 +1523,7 @@ static int send_sub_rect(VncState *vs, int x, int y=
,
> int w, int h)
>
>  static int send_sub_rect_solid(VncState *vs, int x, int y, int w, int h)
>  {
> -    vnc_framebuffer_update(vs, x, y, w, h, vs->tight.type);
> +    vnc_framebuffer_update(vs, x, y, w, h, vs->tight->type);
>
>      vnc_tight_start(vs);
>      vnc_raw_send_framebuffer_update(vs, x, y, w, h);
> @@ -1538,8 +1541,8 @@ static int send_rect_simple(VncState *vs, int x, in=
t
> y, int w, int h,
>      int rw, rh;
>      int n =3D 0;
>
> -    max_size =3D tight_conf[vs->tight.compression].max_rect_size;
> -    max_width =3D tight_conf[vs->tight.compression].max_rect_width;
> +    max_size =3D tight_conf[vs->tight->compression].max_rect_size;
> +    max_width =3D tight_conf[vs->tight->compression].max_rect_width;
>
>      if (split && (w > max_width || w * h > max_size)) {
>          max_sub_width =3D (w > max_width) ? max_width : w;
> @@ -1648,16 +1651,16 @@ static int tight_send_framebuffer_update(VncState
> *vs, int x, int y,
>
>      if (vs->client_pf.bytes_per_pixel =3D=3D 4 && vs->client_pf.rmax =3D=
=3D 0xFF
> &&
>          vs->client_pf.bmax =3D=3D 0xFF && vs->client_pf.gmax =3D=3D 0xFF=
) {
> -        vs->tight.pixel24 =3D true;
> +        vs->tight->pixel24 =3D true;
>      } else {
> -        vs->tight.pixel24 =3D false;
> +        vs->tight->pixel24 =3D false;
>      }
>
>  #ifdef CONFIG_VNC_JPEG
> -    if (vs->tight.quality !=3D (uint8_t)-1) {
> +    if (vs->tight->quality !=3D (uint8_t)-1) {
>          double freq =3D vnc_update_freq(vs, x, y, w, h);
>
> -        if (freq >
> tight_jpeg_conf[vs->tight.quality].jpeg_freq_threshold) {
> +        if (freq >
> tight_jpeg_conf[vs->tight->quality].jpeg_freq_threshold) {
>              return send_rect_simple(vs, x, y, w, h, false);
>          }
>      }
> @@ -1669,8 +1672,8 @@ static int tight_send_framebuffer_update(VncState
> *vs, int x, int y,
>
>      /* Calculate maximum number of rows in one non-solid rectangle. */
>
> -    max_rows =3D tight_conf[vs->tight.compression].max_rect_size;
> -    max_rows /=3D MIN(tight_conf[vs->tight.compression].max_rect_width, =
w);
> +    max_rows =3D tight_conf[vs->tight->compression].max_rect_size;
> +    max_rows /=3D MIN(tight_conf[vs->tight->compression].max_rect_width,=
 w);
>
>      return find_large_solid_color_rect(vs, x, y, w, h, max_rows);
>  }
> @@ -1678,33 +1681,33 @@ static int tight_send_framebuffer_update(VncState
> *vs, int x, int y,
>  int vnc_tight_send_framebuffer_update(VncState *vs, int x, int y,
>                                        int w, int h)
>  {
> -    vs->tight.type =3D VNC_ENCODING_TIGHT;
> +    vs->tight->type =3D VNC_ENCODING_TIGHT;
>      return tight_send_framebuffer_update(vs, x, y, w, h);
>  }
>
>  int vnc_tight_png_send_framebuffer_update(VncState *vs, int x, int y,
>                                            int w, int h)
>  {
> -    vs->tight.type =3D VNC_ENCODING_TIGHT_PNG;
> +    vs->tight->type =3D VNC_ENCODING_TIGHT_PNG;
>      return tight_send_framebuffer_update(vs, x, y, w, h);
>  }
>
>  void vnc_tight_clear(VncState *vs)
>  {
>      int i;
> -    for (i=3D0; i<ARRAY_SIZE(vs->tight.stream); i++) {
> -        if (vs->tight.stream[i].opaque) {
> -            deflateEnd(&vs->tight.stream[i]);
> +    for (i =3D 0; i < ARRAY_SIZE(vs->tight->stream); i++) {
> +        if (vs->tight->stream[i].opaque) {
> +            deflateEnd(&vs->tight->stream[i]);
>          }
>      }
>
> -    buffer_free(&vs->tight.tight);
> -    buffer_free(&vs->tight.zlib);
> -    buffer_free(&vs->tight.gradient);
> +    buffer_free(&vs->tight->tight);
> +    buffer_free(&vs->tight->zlib);
> +    buffer_free(&vs->tight->gradient);
>  #ifdef CONFIG_VNC_JPEG
> -    buffer_free(&vs->tight.jpeg);
> +    buffer_free(&vs->tight->jpeg);
>  #endif
>  #ifdef CONFIG_VNC_PNG
> -    buffer_free(&vs->tight.png);
> +    buffer_free(&vs->tight->png);
>  #endif
>  }
> diff --git a/ui/vnc-enc-zlib.c b/ui/vnc-enc-zlib.c
> index 33e9df2f6ade..900ae5b30f6b 100644
> --- a/ui/vnc-enc-zlib.c
> +++ b/ui/vnc-enc-zlib.c
> @@ -76,7 +76,8 @@ static int vnc_zlib_stop(VncState *vs)
>          zstream->zalloc =3D vnc_zlib_zalloc;
>          zstream->zfree =3D vnc_zlib_zfree;
>
> -        err =3D deflateInit2(zstream, vs->tight.compression, Z_DEFLATED,
> MAX_WBITS,
> +        err =3D deflateInit2(zstream, vs->tight->compression, Z_DEFLATED=
,
> +                           MAX_WBITS,
>                             MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY);
>
>          if (err !=3D Z_OK) {
> @@ -84,16 +85,16 @@ static int vnc_zlib_stop(VncState *vs)
>              return -1;
>          }
>
> -        vs->zlib.level =3D vs->tight.compression;
> +        vs->zlib.level =3D vs->tight->compression;
>          zstream->opaque =3D vs;
>      }
>
> -    if (vs->tight.compression !=3D vs->zlib.level) {
> -        if (deflateParams(zstream, vs->tight.compression,
> +    if (vs->tight->compression !=3D vs->zlib.level) {
> +        if (deflateParams(zstream, vs->tight->compression,
>                            Z_DEFAULT_STRATEGY) !=3D Z_OK) {
>              return -1;
>          }
> -        vs->zlib.level =3D vs->tight.compression;
> +        vs->zlib.level =3D vs->tight->compression;
>      }
>
>      // reserve memory in output buffer
> diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
> index 7493a8472306..17fd28a2e2b0 100644
> --- a/ui/vnc-enc-zrle.c
> +++ b/ui/vnc-enc-zrle.c
> @@ -37,18 +37,18 @@ static const int bits_per_packed_pixel[] =3D {
>
>  static void vnc_zrle_start(VncState *vs)
>  {
> -    buffer_reset(&vs->zrle.zrle);
> +    buffer_reset(&vs->zrle->zrle);
>
>      /* make the output buffer be the zlib buffer, so we can compress it
> later */
> -    vs->zrle.tmp =3D vs->output;
> -    vs->output =3D vs->zrle.zrle;
> +    vs->zrle->tmp =3D vs->output;
> +    vs->output =3D vs->zrle->zrle;
>  }
>
>  static void vnc_zrle_stop(VncState *vs)
>  {
>      /* switch back to normal output/zlib buffers */
> -    vs->zrle.zrle =3D vs->output;
> -    vs->output =3D vs->zrle.tmp;
> +    vs->zrle->zrle =3D vs->output;
> +    vs->output =3D vs->zrle->tmp;
>  }
>
>  static void *zrle_convert_fb(VncState *vs, int x, int y, int w, int h,
> @@ -56,24 +56,24 @@ static void *zrle_convert_fb(VncState *vs, int x, int
> y, int w, int h,
>  {
>      Buffer tmp;
>
> -    buffer_reset(&vs->zrle.fb);
> -    buffer_reserve(&vs->zrle.fb, w * h * bpp + bpp);
> +    buffer_reset(&vs->zrle->fb);
> +    buffer_reserve(&vs->zrle->fb, w * h * bpp + bpp);
>
>      tmp =3D vs->output;
> -    vs->output =3D vs->zrle.fb;
> +    vs->output =3D vs->zrle->fb;
>
>      vnc_raw_send_framebuffer_update(vs, x, y, w, h);
>
> -    vs->zrle.fb =3D vs->output;
> +    vs->zrle->fb =3D vs->output;
>      vs->output =3D tmp;
> -    return vs->zrle.fb.buffer;
> +    return vs->zrle->fb.buffer;
>  }
>
>  static int zrle_compress_data(VncState *vs, int level)
>  {
> -    z_streamp zstream =3D &vs->zrle.stream;
> +    z_streamp zstream =3D &vs->zrle->stream;
>
> -    buffer_reset(&vs->zrle.zlib);
> +    buffer_reset(&vs->zrle->zlib);
>
>      if (zstream->opaque !=3D vs) {
>          int err;
> @@ -93,13 +93,13 @@ static int zrle_compress_data(VncState *vs, int level=
)
>      }
>
>      /* reserve memory in output buffer */
> -    buffer_reserve(&vs->zrle.zlib, vs->zrle.zrle.offset + 64);
> +    buffer_reserve(&vs->zrle->zlib, vs->zrle->zrle.offset + 64);
>
>      /* set pointers */
> -    zstream->next_in =3D vs->zrle.zrle.buffer;
> -    zstream->avail_in =3D vs->zrle.zrle.offset;
> -    zstream->next_out =3D vs->zrle.zlib.buffer + vs->zrle.zlib.offset;
> -    zstream->avail_out =3D vs->zrle.zlib.capacity - vs->zrle.zlib.offset=
;
> +    zstream->next_in =3D vs->zrle->zrle.buffer;
> +    zstream->avail_in =3D vs->zrle->zrle.offset;
> +    zstream->next_out =3D vs->zrle->zlib.buffer + vs->zrle->zlib.offset;
> +    zstream->avail_out =3D vs->zrle->zlib.capacity - vs->zrle->zlib.offs=
et;
>      zstream->data_type =3D Z_BINARY;
>
>      /* start encoding */
> @@ -108,8 +108,8 @@ static int zrle_compress_data(VncState *vs, int level=
)
>          return -1;
>      }
>
> -    vs->zrle.zlib.offset =3D vs->zrle.zlib.capacity - zstream->avail_out=
;
> -    return vs->zrle.zlib.offset;
> +    vs->zrle->zlib.offset =3D vs->zrle->zlib.capacity - zstream->avail_o=
ut;
> +    return vs->zrle->zlib.offset;
>  }
>
>  /* Try to work out whether to use RLE and/or a palette.  We do this by
> @@ -259,14 +259,14 @@ static int zrle_send_framebuffer_update(VncState
> *vs, int x, int y,
>      size_t bytes;
>      int zywrle_level;
>
> -    if (vs->zrle.type =3D=3D VNC_ENCODING_ZYWRLE) {
> -        if (!vs->vd->lossy || vs->tight.quality =3D=3D (uint8_t)-1
> -            || vs->tight.quality =3D=3D 9) {
> +    if (vs->zrle->type =3D=3D VNC_ENCODING_ZYWRLE) {
> +        if (!vs->vd->lossy || vs->tight->quality =3D=3D (uint8_t)-1
> +            || vs->tight->quality =3D=3D 9) {
>              zywrle_level =3D 0;
> -            vs->zrle.type =3D VNC_ENCODING_ZRLE;
> -        } else if (vs->tight.quality < 3) {
> +            vs->zrle->type =3D VNC_ENCODING_ZRLE;
> +        } else if (vs->tight->quality < 3) {
>              zywrle_level =3D 3;
> -        } else if (vs->tight.quality < 6) {
> +        } else if (vs->tight->quality < 6) {
>              zywrle_level =3D 2;
>          } else {
>              zywrle_level =3D 1;
> @@ -337,30 +337,30 @@ static int zrle_send_framebuffer_update(VncState
> *vs, int x, int y,
>
>      vnc_zrle_stop(vs);
>      bytes =3D zrle_compress_data(vs, Z_DEFAULT_COMPRESSION);
> -    vnc_framebuffer_update(vs, x, y, w, h, vs->zrle.type);
> +    vnc_framebuffer_update(vs, x, y, w, h, vs->zrle->type);
>      vnc_write_u32(vs, bytes);
> -    vnc_write(vs, vs->zrle.zlib.buffer, vs->zrle.zlib.offset);
> +    vnc_write(vs, vs->zrle->zlib.buffer, vs->zrle->zlib.offset);
>      return 1;
>  }
>
>  int vnc_zrle_send_framebuffer_update(VncState *vs, int x, int y, int w,
> int h)
>  {
> -    vs->zrle.type =3D VNC_ENCODING_ZRLE;
> +    vs->zrle->type =3D VNC_ENCODING_ZRLE;
>      return zrle_send_framebuffer_update(vs, x, y, w, h);
>  }
>
>  int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int w=
,
> int h)
>  {
> -    vs->zrle.type =3D VNC_ENCODING_ZYWRLE;
> +    vs->zrle->type =3D VNC_ENCODING_ZYWRLE;
>      return zrle_send_framebuffer_update(vs, x, y, w, h);
>  }
>
>  void vnc_zrle_clear(VncState *vs)
>  {
> -    if (vs->zrle.stream.opaque) {
> -        deflateEnd(&vs->zrle.stream);
> +    if (vs->zrle->stream.opaque) {
> +        deflateEnd(&vs->zrle->stream);
>      }
> -    buffer_free(&vs->zrle.zrle);
> -    buffer_free(&vs->zrle.fb);
> -    buffer_free(&vs->zrle.zlib);
> +    buffer_free(&vs->zrle->zrle);
> +    buffer_free(&vs->zrle->fb);
> +    buffer_free(&vs->zrle->zlib);
>  }
> diff --git a/ui/vnc-enc-zrle.inc.c b/ui/vnc-enc-zrle.inc.c
> index abf6b86e4eba..c107d8affcff 100644
> --- a/ui/vnc-enc-zrle.inc.c
> +++ b/ui/vnc-enc-zrle.inc.c
> @@ -96,7 +96,7 @@ static void ZRLE_ENCODE(VncState *vs, int x, int y, int
> w, int h,
>  static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int =
h,
>                               int zywrle_level)
>  {
> -    VncPalette *palette =3D &vs->zrle.palette;
> +    VncPalette *palette =3D &vs->zrle->palette;
>
>      int runs =3D 0;
>      int single_pixels =3D 0;
> diff --git a/ui/vnc.c b/ui/vnc.c
> index bc43c4ca16bf..87b8045afec2 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1307,6 +1307,8 @@ void vnc_disconnect_finish(VncState *vs)
>      object_unref(OBJECT(vs->sioc));
>      vs->sioc =3D NULL;
>      vs->magic =3D 0;
> +    g_free(vs->zrle);
> +    g_free(vs->tight);
>      g_free(vs);
>  }
>
> @@ -2058,8 +2060,8 @@ static void set_encodings(VncState *vs, int32_t
> *encodings, size_t n_encodings)
>
>      vs->features =3D 0;
>      vs->vnc_encoding =3D 0;
> -    vs->tight.compression =3D 9;
> -    vs->tight.quality =3D -1; /* Lossless by default */
> +    vs->tight->compression =3D 9;
> +    vs->tight->quality =3D -1; /* Lossless by default */
>      vs->absolute =3D -1;
>
>      /*
> @@ -2127,11 +2129,11 @@ static void set_encodings(VncState *vs, int32_t
> *encodings, size_t n_encodings)
>              vs->features |=3D VNC_FEATURE_LED_STATE_MASK;
>              break;
>          case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_ENCODING_COMPRESSLEVEL0
> + 9:
> -            vs->tight.compression =3D (enc & 0x0F);
> +            vs->tight->compression =3D (enc & 0x0F);
>              break;
>          case VNC_ENCODING_QUALITYLEVEL0 ... VNC_ENCODING_QUALITYLEVEL0 +
> 9:
>              if (vs->vd->lossy) {
> -                vs->tight.quality =3D (enc & 0x0F);
> +                vs->tight->quality =3D (enc & 0x0F);
>              }
>              break;
>          default:
> @@ -3034,6 +3036,8 @@ static void vnc_connect(VncDisplay *vd,
> QIOChannelSocket *sioc,
>      int i;
>
>      trace_vnc_client_connect(vs, sioc);
> +    vs->zrle =3D g_new0(VncZrle, 1);
> +    vs->tight =3D g_new0(VncTight, 1);
>      vs->magic =3D VNC_MAGIC;
>      vs->sioc =3D sioc;
>      object_ref(OBJECT(vs->sioc));
> @@ -3045,19 +3049,19 @@ static void vnc_connect(VncDisplay *vd,
> QIOChannelSocket *sioc,
>      buffer_init(&vs->output,         "vnc-output/%p", sioc);
>      buffer_init(&vs->jobs_buffer,    "vnc-jobs_buffer/%p", sioc);
>
> -    buffer_init(&vs->tight.tight,    "vnc-tight/%p", sioc);
> -    buffer_init(&vs->tight.zlib,     "vnc-tight-zlib/%p", sioc);
> -    buffer_init(&vs->tight.gradient, "vnc-tight-gradient/%p", sioc);
> +    buffer_init(&vs->tight->tight,    "vnc-tight/%p", sioc);
> +    buffer_init(&vs->tight->zlib,     "vnc-tight-zlib/%p", sioc);
> +    buffer_init(&vs->tight->gradient, "vnc-tight-gradient/%p", sioc);
>  #ifdef CONFIG_VNC_JPEG
> -    buffer_init(&vs->tight.jpeg,     "vnc-tight-jpeg/%p", sioc);
> +    buffer_init(&vs->tight->jpeg,     "vnc-tight-jpeg/%p", sioc);
>  #endif
>  #ifdef CONFIG_VNC_PNG
> -    buffer_init(&vs->tight.png,      "vnc-tight-png/%p", sioc);
> +    buffer_init(&vs->tight->png,      "vnc-tight-png/%p", sioc);
>  #endif
>      buffer_init(&vs->zlib.zlib,      "vnc-zlib/%p", sioc);
> -    buffer_init(&vs->zrle.zrle,      "vnc-zrle/%p", sioc);
> -    buffer_init(&vs->zrle.fb,        "vnc-zrle-fb/%p", sioc);
> -    buffer_init(&vs->zrle.zlib,      "vnc-zrle-zlib/%p", sioc);
> +    buffer_init(&vs->zrle->zrle,      "vnc-zrle/%p", sioc);
> +    buffer_init(&vs->zrle->fb,        "vnc-zrle-fb/%p", sioc);
> +    buffer_init(&vs->zrle->zlib,      "vnc-zrle-zlib/%p", sioc);
>
>      if (skipauth) {
>          vs->auth =3D VNC_AUTH_NONE;
> --
> 2.18.1
>
>
>
