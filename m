Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C65DC74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 19:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D558520844
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 19:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeCrJ8v6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D558520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlIMq-0005IY-A1
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 15:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40620)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIJi-0004IK-0s
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIJc-0000rr-G1
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:31:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hlIJb-0007tO-T2
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:31:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id n4so3691375wrs.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 12:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=l9jfOuF9F+oEhMEszPmujyvHXu3mktQWP7BZkQdbTU4=;
 b=ZeCrJ8v6GxsaLag9PICBfmsEkGlk+++xhk3Xk/JRHbBt1DhxVacSkY0x01gB4pMCK/
 DKtZOt6VEXCQY1kDJ4WZbAkDsaUJ7goz+hW073PbRnH5taEN1YT+XErHOy/5+V2zx8mX
 VXWPzIVPnh13Z+ntJEn7y8KzKEmz9PrNkV6jm6V5blH+8NUMeaovS0jovF2qErsX9tqq
 8g0+OGjV2n1HjhVHHPPpN0QvggeWOhw7azaVwWfaRAbzyIi7e4lfbUbmSwW4y/DDy9C9
 rln1IXCuQRkaBUmi7RD/Ji/M/+CToXTq+rc6CyhKl26oMK+/J87MaM1g7PcHOsYi3ngM
 86lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l9jfOuF9F+oEhMEszPmujyvHXu3mktQWP7BZkQdbTU4=;
 b=PMEIgH0M3IM884YGrv1jZcM6pzErT6UthnN/UnzFvBtKHBoiqpHHtRMHBm0G0wOPQT
 mkSWgEyxmLTbW/ROkVSBLaXjf5kvk8FX9+jVu5vFO/LDA2c4Hn/VJwPDumCKYjlqihQU
 0OOdIGutWX8OB82Ev8D+9RgxIy5MItei+1oa0Zxzb/ifMn1CaTzNMIXEmb+inSsXTCRS
 A+QnbZDsU1o9HlAqQ9JDYArFB8lh6Te1b2vNtulEtgLj2h14QEoTGW4Nbz8wP6je0zAH
 DwjvCCTsf3pNbx7zb8ct1Inj2LLZ9DylYzfhh3/+xmKhaZmZ2GxZnM64vo85GPO7yFA8
 cX5A==
X-Gm-Message-State: APjAAAV8vZeZ27fRAu2OgsAGKaxPBJL6qirUmA70q3C/N0LcXMKJHkNq
 gyz20UbKslog/K1bszOggCzjyfqnYjrVFXKAtf4=
X-Google-Smtp-Source: APXvYqydq+pDozLk4Cgfo3wH8YfVERozdvCnyJuDgtTWXrfImotTR7gRYYIJ+a18d/Vvi1Z1xqhJBaX9/9Zd5ldLSYI=
X-Received: by 2002:a5d:6650:: with SMTP id f16mr805202wrw.89.1562787041364;
 Wed, 10 Jul 2019 12:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <25d0165508ec9a4dbac572adcee97dd4c342b55b.1562695780.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <25d0165508ec9a4dbac572adcee97dd4c342b55b.1562695780.git.DirtY.iCE.hu@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 10 Jul 2019 23:30:29 +0400
Message-ID: <CAJ+F1C+A72=W1XscymUQe6UXijVBgXUDC3EPnb1YLxsVC_DXAA@mail.gmail.com>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 04/11] audio: audiodev= parameters no
 longer optional when -audiodev present
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
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 9, 2019 at 11:00 PM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.i=
ce.hu@gmail.com> wrote:
>
> This means you should probably stop using -soundhw (as it doesn't allow
> you to specify any options) and add the device manually with -device.
> The exception is pcspk, it's currently not possible to manually add it.
> To use it with audiodev, use something like this:
>
>     -audiodev id=3Dfoo,... -global isa-pcspk.audiodev=3Dfoo -soundhw pcsp=
k

Can you seperate the paaudio changes to ease review?

>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
> ---
>  audio/audio.c   |  24 ++--
>  audio/paaudio.c | 329 +++++++++++++++++++++++++++---------------------
>  2 files changed, 203 insertions(+), 150 deletions(-)
>
> diff --git a/audio/audio.c b/audio/audio.c
> index e9dd7c8b32..82dd0e3e13 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -101,6 +101,8 @@ const struct mixeng_volume nominal_volume =3D {
>  #endif
>  };
>
> +static bool legacy_config =3D true;
> +
>  #ifdef AUDIO_IS_FLAWLESS_AND_NO_CHECKS_ARE_REQURIED
>  #error No its not
>  #else
> @@ -1392,7 +1394,7 @@ static AudiodevListEntry *audiodev_find(
>   * if dev =3D=3D NULL =3D> legacy implicit initialization, return the al=
ready created
>   *   state or create a new one
>   */
> -static AudioState *audio_init(Audiodev *dev)
> +static AudioState *audio_init(Audiodev *dev, const char *name)
>  {
>      static bool atexit_registered;
>      size_t i;
> @@ -1406,12 +1408,13 @@ static AudioState *audio_init(Audiodev *dev)
>
>      if (dev) {
>          /* -audiodev option */
> +        legacy_config =3D false;
>          drvname =3D AudiodevDriver_str(dev->driver);
>      } else if (!QTAILQ_EMPTY(&audio_states)) {
> -        /*
> -         * todo: check for -audiodev once we have normal audiodev select=
ion
> -         * support
> -         */
> +        if (!legacy_config) {
> +            dolog("You must specify an audiodev=3D for the device %s\n",=
 name);
> +            exit(1);
> +        }
>          return QTAILQ_FIRST(&audio_states);
>      } else {
>          /* legacy implicit initialization */
> @@ -1518,7 +1521,7 @@ void audio_free_audiodev_list(AudiodevListHead *hea=
d)
>  void AUD_register_card (const char *name, QEMUSoundCard *card)
>  {
>      if (!card->state) {
> -        card->state =3D audio_init(NULL);
> +        card->state =3D audio_init(NULL, name);
>      }
>
>      card->name =3D g_strdup (name);
> @@ -1544,8 +1547,11 @@ CaptureVoiceOut *AUD_add_capture(
>      struct capture_callback *cb;
>
>      if (!s) {
> -        /* todo: remove when we have normal audiodev selection support *=
/
> -        s =3D audio_init(NULL);
> +        if (!legacy_config) {
> +            dolog("You must specify audiodev when trying to capture\n");
> +            return NULL;
> +        }
> +        s =3D audio_init(NULL, NULL);
>      }
>
>      if (audio_validate_settings (as)) {
> @@ -1776,7 +1782,7 @@ void audio_init_audiodevs(void)
>      AudiodevListEntry *e;
>
>      QSIMPLEQ_FOREACH(e, &audiodevs, next) {
> -        audio_init(e->dev);
> +        audio_init(e->dev, NULL);
>      }
>  }
>
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 5fc886bb33..cc3a34c2ea 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -11,10 +11,21 @@
>  #include "audio_int.h"
>  #include "audio_pt_int.h"
>
> -typedef struct {
> -    Audiodev *dev;
> +typedef struct PAConnection {
> +    char *server;
> +    int refcount;
> +    QTAILQ_ENTRY(PAConnection) list;
> +
>      pa_threaded_mainloop *mainloop;
>      pa_context *context;
> +} PAConnection;
> +
> +static QTAILQ_HEAD(PAConnectionHead, PAConnection) pa_conns =3D
> +    QTAILQ_HEAD_INITIALIZER(pa_conns);
> +
> +typedef struct {
> +    Audiodev *dev;
> +    PAConnection *conn;
>  } paaudio;
>
>  typedef struct {
> @@ -45,7 +56,7 @@ typedef struct {
>      int samples;
>  } PAVoiceIn;
>
> -static void qpa_audio_fini(void *opaque);
> +static void qpa_conn_fini(PAConnection *c);
>
>  static void GCC_FMT_ATTR (2, 3) qpa_logerr (int err, const char *fmt, ..=
.)
>  {
> @@ -108,11 +119,11 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state=
_t x)
>
>  static int qpa_simple_read (PAVoiceIn *p, void *data, size_t length, int=
 *rerror)
>  {
> -    paaudio *g =3D p->g;
> +    PAConnection *c =3D p->g->conn;
>
> -    pa_threaded_mainloop_lock (g->mainloop);
> +    pa_threaded_mainloop_lock(c->mainloop);
>
> -    CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
> +    CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
>
>      while (length > 0) {
>          size_t l;
> @@ -121,11 +132,11 @@ static int qpa_simple_read (PAVoiceIn *p, void *dat=
a, size_t length, int *rerror
>              int r;
>
>              r =3D pa_stream_peek (p->stream, &p->read_data, &p->read_len=
gth);
> -            CHECK_SUCCESS_GOTO (g, rerror, r =3D=3D 0, unlock_and_fail);
> +            CHECK_SUCCESS_GOTO(c, rerror, r =3D=3D 0, unlock_and_fail);
>
>              if (!p->read_data) {
> -                pa_threaded_mainloop_wait (g->mainloop);
> -                CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
> +                pa_threaded_mainloop_wait(c->mainloop);
> +                CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
>              } else {
>                  p->read_index =3D 0;
>              }
> @@ -148,53 +159,53 @@ static int qpa_simple_read (PAVoiceIn *p, void *dat=
a, size_t length, int *rerror
>              p->read_length =3D 0;
>              p->read_index =3D 0;
>
> -            CHECK_SUCCESS_GOTO (g, rerror, r =3D=3D 0, unlock_and_fail);
> +            CHECK_SUCCESS_GOTO(c, rerror, r =3D=3D 0, unlock_and_fail);
>          }
>      }
>
> -    pa_threaded_mainloop_unlock (g->mainloop);
> +    pa_threaded_mainloop_unlock(c->mainloop);
>      return 0;
>
>  unlock_and_fail:
> -    pa_threaded_mainloop_unlock (g->mainloop);
> +    pa_threaded_mainloop_unlock(c->mainloop);
>      return -1;
>  }
>
>  static int qpa_simple_write (PAVoiceOut *p, const void *data, size_t len=
gth, int *rerror)
>  {
> -    paaudio *g =3D p->g;
> +    PAConnection *c =3D p->g->conn;
>
> -    pa_threaded_mainloop_lock (g->mainloop);
> +    pa_threaded_mainloop_lock(c->mainloop);
>
> -    CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
> +    CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
>
>      while (length > 0) {
>          size_t l;
>          int r;
>
>          while (!(l =3D pa_stream_writable_size (p->stream))) {
> -            pa_threaded_mainloop_wait (g->mainloop);
> -            CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
> +            pa_threaded_mainloop_wait(c->mainloop);
> +            CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
>          }
>
> -        CHECK_SUCCESS_GOTO (g, rerror, l !=3D (size_t) -1, unlock_and_fa=
il);
> +        CHECK_SUCCESS_GOTO(c, rerror, l !=3D (size_t) -1, unlock_and_fai=
l);
>
>          if (l > length) {
>              l =3D length;
>          }
>
>          r =3D pa_stream_write (p->stream, data, l, NULL, 0LL, PA_SEEK_RE=
LATIVE);
> -        CHECK_SUCCESS_GOTO (g, rerror, r >=3D 0, unlock_and_fail);
> +        CHECK_SUCCESS_GOTO(c, rerror, r >=3D 0, unlock_and_fail);
>
>          data =3D (const uint8_t *) data + l;
>          length -=3D l;
>      }
>
> -    pa_threaded_mainloop_unlock (g->mainloop);
> +    pa_threaded_mainloop_unlock(c->mainloop);
>      return 0;
>
>  unlock_and_fail:
> -    pa_threaded_mainloop_unlock (g->mainloop);
> +    pa_threaded_mainloop_unlock(c->mainloop);
>      return -1;
>  }
>
> @@ -432,13 +443,13 @@ static AudioFormat pa_to_audfmt (pa_sample_format_t=
 fmt, int *endianness)
>
>  static void context_state_cb (pa_context *c, void *userdata)
>  {
> -    paaudio *g =3D userdata;
> +    PAConnection *conn =3D userdata;
>
>      switch (pa_context_get_state(c)) {
>      case PA_CONTEXT_READY:
>      case PA_CONTEXT_TERMINATED:
>      case PA_CONTEXT_FAILED:
> -        pa_threaded_mainloop_signal (g->mainloop, 0);
> +        pa_threaded_mainloop_signal(conn->mainloop, 0);
>          break;
>
>      case PA_CONTEXT_UNCONNECTED:
> @@ -451,14 +462,14 @@ static void context_state_cb (pa_context *c, void *=
userdata)
>
>  static void stream_state_cb (pa_stream *s, void * userdata)
>  {
> -    paaudio *g =3D userdata;
> +    PAConnection *c =3D userdata;
>
>      switch (pa_stream_get_state (s)) {
>
>      case PA_STREAM_READY:
>      case PA_STREAM_FAILED:
>      case PA_STREAM_TERMINATED:
> -        pa_threaded_mainloop_signal (g->mainloop, 0);
> +        pa_threaded_mainloop_signal(c->mainloop, 0);
>          break;
>
>      case PA_STREAM_UNCONNECTED:
> @@ -469,13 +480,13 @@ static void stream_state_cb (pa_stream *s, void * u=
serdata)
>
>  static void stream_request_cb (pa_stream *s, size_t length, void *userda=
ta)
>  {
> -    paaudio *g =3D userdata;
> +    PAConnection *c =3D userdata;
>
> -    pa_threaded_mainloop_signal (g->mainloop, 0);
> +    pa_threaded_mainloop_signal(c->mainloop, 0);
>  }
>
>  static pa_stream *qpa_simple_new (
> -        paaudio *g,
> +        PAConnection *c,
>          const char *name,
>          pa_stream_direction_t dir,
>          const char *dev,
> @@ -486,50 +497,48 @@ static pa_stream *qpa_simple_new (
>  {
>      int r;
>      pa_stream *stream;
> +    pa_stream_flags_t flags;
>
> -    pa_threaded_mainloop_lock (g->mainloop);
> +    pa_threaded_mainloop_lock(c->mainloop);
>
> -    stream =3D pa_stream_new (g->context, name, ss, map);
> +    stream =3D pa_stream_new(c->context, name, ss, map);
>      if (!stream) {
>          goto fail;
>      }
>
> -    pa_stream_set_state_callback (stream, stream_state_cb, g);
> -    pa_stream_set_read_callback (stream, stream_request_cb, g);
> -    pa_stream_set_write_callback (stream, stream_request_cb, g);
> +    pa_stream_set_state_callback(stream, stream_state_cb, c);
> +    pa_stream_set_read_callback(stream, stream_request_cb, c);
> +    pa_stream_set_write_callback(stream, stream_request_cb, c);
> +
> +    flags =3D
> +        PA_STREAM_INTERPOLATE_TIMING
> +#ifdef PA_STREAM_ADJUST_LATENCY
> +        | PA_STREAM_ADJUST_LATENCY
> +#endif
> +        | PA_STREAM_AUTO_TIMING_UPDATE;
>
>      if (dir =3D=3D PA_STREAM_PLAYBACK) {
> -        r =3D pa_stream_connect_playback (stream, dev, attr,
> -                                        PA_STREAM_INTERPOLATE_TIMING
> -#ifdef PA_STREAM_ADJUST_LATENCY
> -                                        |PA_STREAM_ADJUST_LATENCY
> -#endif
> -                                        |PA_STREAM_AUTO_TIMING_UPDATE, N=
ULL, NULL);
> +        r =3D pa_stream_connect_playback(stream, dev, attr, flags, NULL,=
 NULL);
>      } else {
> -        r =3D pa_stream_connect_record (stream, dev, attr,
> -                                      PA_STREAM_INTERPOLATE_TIMING
> -#ifdef PA_STREAM_ADJUST_LATENCY
> -                                      |PA_STREAM_ADJUST_LATENCY
> -#endif
> -                                      |PA_STREAM_AUTO_TIMING_UPDATE);
> +        r =3D pa_stream_connect_record(stream, dev, attr, flags);
>      }
>
>      if (r < 0) {
>        goto fail;
>      }
>
> -    pa_threaded_mainloop_unlock (g->mainloop);
> +    pa_threaded_mainloop_unlock(c->mainloop);
>
>      return stream;
>
>  fail:
> -    pa_threaded_mainloop_unlock (g->mainloop);
> +    pa_threaded_mainloop_unlock(c->mainloop);
>
>      if (stream) {
>          pa_stream_unref (stream);
>      }
>
> -    *rerror =3D pa_context_errno (g->context);
> +    *rerror =3D pa_context_errno(c->context);
>
>      return NULL;
>  }
> @@ -545,6 +554,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audset=
tings *as,
>      paaudio *g =3D pa->g =3D drv_opaque;
>      AudiodevPaOptions *popts =3D &g->dev->u.pa;
>      AudiodevPaPerDirectionOptions *ppdo =3D popts->out;
> +    PAConnection *c =3D g->conn;
>
>      ss.format =3D audfmt_to_pa (as->fmt, as->endianness);
>      ss.channels =3D as->nchannels;
> @@ -558,7 +568,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audset=
tings *as,
>      obt_as.fmt =3D pa_to_audfmt (ss.format, &obt_as.endianness);
>
>      pa->stream =3D qpa_simple_new (
> -        g,
> +        c,
>          "qemu",
>          PA_STREAM_PLAYBACK,
>          ppdo->has_name ? ppdo->name : NULL,
> @@ -612,6 +622,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
>      paaudio *g =3D pa->g =3D drv_opaque;
>      AudiodevPaOptions *popts =3D &g->dev->u.pa;
>      AudiodevPaPerDirectionOptions *ppdo =3D popts->in;
> +    PAConnection *c =3D g->conn;
>
>      ss.format =3D audfmt_to_pa (as->fmt, as->endianness);
>      ss.channels =3D as->nchannels;
> @@ -625,7 +636,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
>      obt_as.fmt =3D pa_to_audfmt (ss.format, &obt_as.endianness);
>
>      pa->stream =3D qpa_simple_new (
> -        g,
> +        c,
>          "qemu",
>          PA_STREAM_RECORD,
>          ppdo->has_name ? ppdo->name : NULL,
> @@ -714,7 +725,7 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
>      PAVoiceOut *pa =3D (PAVoiceOut *) hw;
>      pa_operation *op;
>      pa_cvolume v;
> -    paaudio *g =3D pa->g;
> +    PAConnection *c =3D pa->g->conn;
>
>  #ifdef PA_CHECK_VERSION    /* macro is present in 0.9.16+ */
>      pa_cvolume_init (&v);  /* function is present in 0.9.13+ */
> @@ -734,28 +745,29 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ..=
.)
>              v.values[0] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vo=
l.l) / UINT32_MAX;
>              v.values[1] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vo=
l.r) / UINT32_MAX;
>
> -            pa_threaded_mainloop_lock (g->mainloop);
> +            pa_threaded_mainloop_lock(c->mainloop);
>
> -            op =3D pa_context_set_sink_input_volume (g->context,
> +            op =3D pa_context_set_sink_input_volume(c->context,
>                  pa_stream_get_index (pa->stream),
>                  &v, NULL, NULL);
> -            if (!op)
> -                qpa_logerr (pa_context_errno (g->context),
> -                            "set_sink_input_volume() failed\n");
> -            else
> -                pa_operation_unref (op);
> +            if (!op) {
> +                qpa_logerr(pa_context_errno(c->context),
> +                           "set_sink_input_volume() failed\n");
> +            } else {
> +                pa_operation_unref(op);
> +            }
>
> -            op =3D pa_context_set_sink_input_mute (g->context,
> +            op =3D pa_context_set_sink_input_mute(c->context,
>                  pa_stream_get_index (pa->stream),
>                 sw->vol.mute, NULL, NULL);
>              if (!op) {
> -                qpa_logerr (pa_context_errno (g->context),
> -                            "set_sink_input_mute() failed\n");
> +                qpa_logerr(pa_context_errno(c->context),
> +                           "set_sink_input_mute() failed\n");
>              } else {
> -                pa_operation_unref (op);
> +                pa_operation_unref(op);
>              }
>
> -            pa_threaded_mainloop_unlock (g->mainloop);
> +            pa_threaded_mainloop_unlock(c->mainloop);
>          }
>      }
>      return 0;
> @@ -766,7 +778,7 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
>      PAVoiceIn *pa =3D (PAVoiceIn *) hw;
>      pa_operation *op;
>      pa_cvolume v;
> -    paaudio *g =3D pa->g;
> +    PAConnection *c =3D pa->g->conn;
>
>  #ifdef PA_CHECK_VERSION
>      pa_cvolume_init (&v);
> @@ -786,29 +798,29 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
>              v.values[0] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vo=
l.l) / UINT32_MAX;
>              v.values[1] =3D ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vo=
l.r) / UINT32_MAX;
>
> -            pa_threaded_mainloop_lock (g->mainloop);
> +            pa_threaded_mainloop_lock(c->mainloop);
>
> -            op =3D pa_context_set_source_output_volume (g->context,
> -                pa_stream_get_index (pa->stream),
> +            op =3D pa_context_set_source_output_volume(c->context,
> +                pa_stream_get_index(pa->stream),
>                  &v, NULL, NULL);
>              if (!op) {
> -                qpa_logerr (pa_context_errno (g->context),
> -                            "set_source_output_volume() failed\n");
> +                qpa_logerr(pa_context_errno(c->context),
> +                           "set_source_output_volume() failed\n");
>              } else {
>                  pa_operation_unref(op);
>              }
>
> -            op =3D pa_context_set_source_output_mute (g->context,
> +            op =3D pa_context_set_source_output_mute(c->context,
>                  pa_stream_get_index (pa->stream),
>                  sw->vol.mute, NULL, NULL);
>              if (!op) {
> -                qpa_logerr (pa_context_errno (g->context),
> -                            "set_source_output_mute() failed\n");
> +                qpa_logerr(pa_context_errno(c->context),
> +                           "set_source_output_mute() failed\n");
>              } else {
>                  pa_operation_unref (op);
>              }
>
> -            pa_threaded_mainloop_unlock (g->mainloop);
> +            pa_threaded_mainloop_unlock(c->mainloop);
>          }
>      }
>      return 0;
> @@ -828,11 +840,75 @@ static int qpa_validate_per_direction_opts(Audiodev=
 *dev,
>      return 1;
>  }
>
> +/* common */
> +static void *qpa_conn_init(const char *server)
> +{
> +    PAConnection *c =3D g_malloc0(sizeof(PAConnection));
> +    QTAILQ_INSERT_TAIL(&pa_conns, c, list);
> +
> +    c->mainloop =3D pa_threaded_mainloop_new();
> +    if (!c->mainloop) {
> +        goto fail;
> +    }
> +
> +    c->context =3D pa_context_new(pa_threaded_mainloop_get_api(c->mainlo=
op),
> +                                server);
> +    if (!c->context) {
> +        goto fail;
> +    }
> +
> +    pa_context_set_state_callback(c->context, context_state_cb, c);
> +
> +    if (pa_context_connect(c->context, server, 0, NULL) < 0) {
> +        qpa_logerr(pa_context_errno(c->context),
> +                   "pa_context_connect() failed\n");
> +        goto fail;
> +    }
> +
> +    pa_threaded_mainloop_lock(c->mainloop);
> +
> +    if (pa_threaded_mainloop_start(c->mainloop) < 0) {
> +        goto unlock_and_fail;
> +    }
> +
> +    for (;;) {
> +        pa_context_state_t state;
> +
> +        state =3D pa_context_get_state(c->context);
> +
> +        if (state =3D=3D PA_CONTEXT_READY) {
> +            break;
> +        }
> +
> +        if (!PA_CONTEXT_IS_GOOD(state)) {
> +            qpa_logerr(pa_context_errno(c->context),
> +                       "Wrong context state\n");
> +            goto unlock_and_fail;
> +        }
> +
> +        /* Wait until the context is ready */
> +        pa_threaded_mainloop_wait(c->mainloop);
> +    }
> +
> +    pa_threaded_mainloop_unlock(c->mainloop);
> +    return c;
> +
> +unlock_and_fail:
> +    pa_threaded_mainloop_unlock(c->mainloop);
> +fail:
> +    AUD_log (AUDIO_CAP, "Failed to initialize PA context");
> +    qpa_conn_fini(c);
> +    return NULL;
> +}
> +
>  static void *qpa_audio_init(Audiodev *dev)
>  {
>      paaudio *g;
>      AudiodevPaOptions *popts =3D &dev->u.pa;
>      const char *server;
> +    PAConnection *c;
> +
> +    assert(dev->driver =3D=3D AUDIODEV_DRIVER_PA);
>
>      if (!popts->has_server) {
>          char pidfile[64];
> @@ -849,93 +925,64 @@ static void *qpa_audio_init(Audiodev *dev)
>          }
>      }
>
> -    assert(dev->driver =3D=3D AUDIODEV_DRIVER_PA);
> -
> -    g =3D g_malloc(sizeof(paaudio));
> -    server =3D popts->has_server ? popts->server : NULL;
> -
>      if (!qpa_validate_per_direction_opts(dev, popts->in)) {
> -        goto fail;
> +        return NULL;
>      }
>      if (!qpa_validate_per_direction_opts(dev, popts->out)) {
> -        goto fail;
> +        return NULL;
>      }
>
> +    g =3D g_malloc0(sizeof(paaudio));
> +    server =3D popts->has_server ? popts->server : NULL;
> +
>      g->dev =3D dev;
> -    g->mainloop =3D NULL;
> -    g->context =3D NULL;
>
> -    g->mainloop =3D pa_threaded_mainloop_new ();
> -    if (!g->mainloop) {
> -        goto fail;
> -    }
> -
> -    g->context =3D pa_context_new (pa_threaded_mainloop_get_api (g->main=
loop),
> -                                 server);
> -    if (!g->context) {
> -        goto fail;
> -    }
> -
> -    pa_context_set_state_callback (g->context, context_state_cb, g);
> -
> -    if (pa_context_connect(g->context, server, 0, NULL) < 0) {
> -        qpa_logerr (pa_context_errno (g->context),
> -                    "pa_context_connect() failed\n");
> -        goto fail;
> -    }
> -
> -    pa_threaded_mainloop_lock (g->mainloop);
> -
> -    if (pa_threaded_mainloop_start (g->mainloop) < 0) {
> -        goto unlock_and_fail;
> -    }
> -
> -    for (;;) {
> -        pa_context_state_t state;
> -
> -        state =3D pa_context_get_state (g->context);
> -
> -        if (state =3D=3D PA_CONTEXT_READY) {
> +    QTAILQ_FOREACH(c, &pa_conns, list) {
> +        if (server =3D=3D NULL || c->server =3D=3D NULL ?
> +            server =3D=3D c->server :
> +            strcmp(server, c->server) =3D=3D 0) {
> +            g->conn =3D c;
>              break;
>          }
> -
> -        if (!PA_CONTEXT_IS_GOOD (state)) {
> -            qpa_logerr (pa_context_errno (g->context),
> -                        "Wrong context state\n");
> -            goto unlock_and_fail;
> -        }
> -
> -        /* Wait until the context is ready */
> -        pa_threaded_mainloop_wait (g->mainloop);
> +    }
> +    if (!g->conn) {
> +        g->conn =3D qpa_conn_init(server);
> +    }
> +    if (!g->conn) {
> +        g_free(g);
> +        return NULL;
>      }
>
> -    pa_threaded_mainloop_unlock (g->mainloop);
> -
> +    ++g->conn->refcount;
>      return g;
> +}
>
> -unlock_and_fail:
> -    pa_threaded_mainloop_unlock (g->mainloop);
> -fail:
> -    AUD_log (AUDIO_CAP, "Failed to initialize PA context");
> -    qpa_audio_fini(g);
> -    return NULL;
> +static void qpa_conn_fini(PAConnection *c)
> +{
> +    if (c->mainloop) {
> +        pa_threaded_mainloop_stop(c->mainloop);
> +    }
> +
> +    if (c->context) {
> +        pa_context_disconnect(c->context);
> +        pa_context_unref(c->context);
> +    }
> +
> +    if (c->mainloop) {
> +        pa_threaded_mainloop_free(c->mainloop);
> +    }
> +
> +    QTAILQ_REMOVE(&pa_conns, c, list);
> +    g_free(c);
>  }
>
>  static void qpa_audio_fini (void *opaque)
>  {
>      paaudio *g =3D opaque;
> +    PAConnection *c =3D g->conn;
>
> -    if (g->mainloop) {
> -        pa_threaded_mainloop_stop (g->mainloop);
> -    }
> -
> -    if (g->context) {
> -        pa_context_disconnect (g->context);
> -        pa_context_unref (g->context);
> -    }
> -
> -    if (g->mainloop) {
> -        pa_threaded_mainloop_free (g->mainloop);
> +    if (--c->refcount =3D=3D 0) {
> +        qpa_conn_fini(c);
>      }
>
>      g_free(g);
> --
> 2.22.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

