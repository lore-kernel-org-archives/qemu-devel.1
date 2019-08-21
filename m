Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D3DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90F42332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90F42332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0MTh-00030b-2M
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0MBR-00044H-7J
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0MBO-00059X-3P
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42002)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0MBN-00059A-Qk
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2509B89F38E;
 Wed, 21 Aug 2019 08:41:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C51A7987;
 Wed, 21 Aug 2019 08:41:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0937E31E8F; Wed, 21 Aug 2019 10:41:14 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 10:41:08 +0200
Message-Id: <20190821084113.1840-11-kraxel@redhat.com>
In-Reply-To: <20190821084113.1840-1-kraxel@redhat.com>
References: <20190821084113.1840-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Wed, 21 Aug 2019 08:41:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/15] audio: remove audio_MIN, audio_MAX
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kővágó@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

There's already a MIN and MAX macro in include/qemu/osdep.h, use them
instead.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 303222477df6f7373217e0df768635fab5855745.1566168923.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.h             | 17 -----------------
 audio/alsaaudio.c         |  6 +++---
 audio/audio.c             | 20 ++++++++++----------
 audio/coreaudio.c         |  2 +-
 audio/dsoundaudio.c       |  2 +-
 audio/noaudio.c           | 10 +++++-----
 audio/ossaudio.c          |  6 +++---
 audio/paaudio.c           | 12 ++++++------
 audio/sdlaudio.c          |  6 +++---
 audio/spiceaudio.c        | 10 +++++-----
 audio/wavaudio.c          |  4 ++--
 hw/audio/ac97.c           | 10 +++++-----
 hw/audio/adlib.c          |  4 ++--
 hw/audio/cs4231a.c        |  4 ++--
 hw/audio/es1370.c         |  6 +++---
 hw/audio/gus.c            |  6 +++---
 hw/audio/hda-codec.c      | 16 ++++++++--------
 hw/audio/milkymist-ac97.c |  8 ++++----
 hw/audio/pcspk.c          |  2 +-
 hw/audio/sb16.c           |  2 +-
 hw/audio/wm8750.c         |  4 ++--
 21 files changed, 70 insertions(+), 87 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 3257165b0541..96e22887a061 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -147,23 +147,6 @@ static inline void *advance (void *p, int incr)
     return (d + incr);
 }
=20
-#ifdef __GNUC__
-#define audio_MIN(a, b) ( __extension__ ({      \
-    __typeof (a) ta =3D a;                        \
-    __typeof (b) tb =3D b;                        \
-    ((ta)>(tb)?(tb):(ta));                      \
-}))
-
-#define audio_MAX(a, b) ( __extension__ ({      \
-    __typeof (a) ta =3D a;                        \
-    __typeof (b) tb =3D b;                        \
-    ((ta)<(tb)?(tb):(ta));                      \
-}))
-#else
-#define audio_MIN(a, b) ((a)>(b)?(b):(a))
-#define audio_MAX(a, b) ((a)<(b)?(b):(a))
-#endif
-
 int wav_start_capture(AudioState *state, CaptureState *s, const char *pa=
th,
                       int freq, int bits, int nchannels);
=20
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 3745c823ad37..6b9e0f06af47 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -634,7 +634,7 @@ static void alsa_write_pending (ALSAVoiceOut *alsa)
=20
     while (alsa->pending) {
         int left_till_end_samples =3D hw->samples - alsa->wpos;
-        int len =3D audio_MIN (alsa->pending, left_till_end_samples);
+        int len =3D MIN (alsa->pending, left_till_end_samples);
         char *src =3D advance (alsa->pcm_buf, alsa->wpos << hw->info.shi=
ft);
=20
         while (len) {
@@ -697,7 +697,7 @@ static int alsa_run_out (HWVoiceOut *hw, int live)
         return 0;
     }
=20
-    decr =3D audio_MIN (live, avail);
+    decr =3D MIN (live, avail);
     decr =3D audio_pcm_hw_clip_out (hw, alsa->pcm_buf, decr, alsa->pendi=
ng);
     alsa->pending +=3D decr;
     alsa_write_pending (alsa);
@@ -915,7 +915,7 @@ static int alsa_run_in (HWVoiceIn *hw)
         }
     }
=20
-    decr =3D audio_MIN (dead, avail);
+    decr =3D MIN (dead, avail);
     if (!decr) {
         return 0;
     }
diff --git a/audio/audio.c b/audio/audio.c
index c99e4ddea4c3..38267695f788 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -535,7 +535,7 @@ static int audio_pcm_hw_find_min_in (HWVoiceIn *hw)
=20
     for (sw =3D hw->sw_head.lh_first; sw; sw =3D sw->entries.le_next) {
         if (sw->active) {
-            m =3D audio_MIN (m, sw->total_hw_samples_acquired);
+            m =3D MIN (m, sw->total_hw_samples_acquired);
         }
     }
     return m;
@@ -555,14 +555,14 @@ int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pc=
m_buf,
                            int live, int pending)
 {
     int left =3D hw->samples - pending;
-    int len =3D audio_MIN (left, live);
+    int len =3D MIN (left, live);
     int clipped =3D 0;
=20
     while (len) {
         struct st_sample *src =3D hw->mix_buf + hw->rpos;
         uint8_t *dst =3D advance (pcm_buf, hw->rpos << hw->info.shift);
         int samples_till_end_of_buf =3D hw->samples - hw->rpos;
-        int samples_to_clip =3D audio_MIN (len, samples_till_end_of_buf)=
;
+        int samples_to_clip =3D MIN (len, samples_till_end_of_buf);
=20
         hw->clip (dst, src, samples_to_clip);
=20
@@ -616,7 +616,7 @@ int audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int =
size)
     }
=20
     swlim =3D (live * sw->ratio) >> 32;
-    swlim =3D audio_MIN (swlim, samples);
+    swlim =3D MIN (swlim, samples);
=20
     while (swlim) {
         src =3D hw->conv_buf + rpos;
@@ -664,7 +664,7 @@ static int audio_pcm_hw_find_min_out (HWVoiceOut *hw,=
 int *nb_livep)
=20
     for (sw =3D hw->sw_head.lh_first; sw; sw =3D sw->entries.le_next) {
         if (sw->active || !sw->empty) {
-            m =3D audio_MIN (m, sw->total_hw_samples_mixed);
+            m =3D MIN (m, sw->total_hw_samples_mixed);
             nb_live +=3D 1;
         }
     }
@@ -727,7 +727,7 @@ int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, in=
t size)
=20
     dead =3D hwsamples - live;
     swlim =3D ((int64_t) dead << 32) / sw->ratio;
-    swlim =3D audio_MIN (swlim, samples);
+    swlim =3D MIN (swlim, samples);
     if (swlim) {
         sw->conv (sw->buf, buf, swlim);
=20
@@ -739,7 +739,7 @@ int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, in=
t size)
     while (swlim) {
         dead =3D hwsamples - live;
         left =3D hwsamples - wpos;
-        blck =3D audio_MIN (dead, left);
+        blck =3D MIN (dead, left);
         if (!blck) {
             break;
         }
@@ -1031,7 +1031,7 @@ static void audio_capture_mix_and_clear (HWVoiceOut=
 *hw, int rpos, int samples)
             n =3D samples;
             while (n) {
                 int till_end_of_hw =3D hw->samples - rpos2;
-                int to_write =3D audio_MIN (till_end_of_hw, n);
+                int to_write =3D MIN (till_end_of_hw, n);
                 int bytes =3D to_write << hw->info.shift;
                 int written;
=20
@@ -1049,7 +1049,7 @@ static void audio_capture_mix_and_clear (HWVoiceOut=
 *hw, int rpos, int samples)
         }
     }
=20
-    n =3D audio_MIN (samples, hw->samples - rpos);
+    n =3D MIN (samples, hw->samples - rpos);
     mixeng_clear (hw->mix_buf + rpos, n);
     mixeng_clear (hw->mix_buf, samples - n);
 }
@@ -1205,7 +1205,7 @@ static void audio_run_capture (AudioState *s)
         rpos =3D hw->rpos;
         while (live) {
             int left =3D hw->samples - rpos;
-            int to_capture =3D audio_MIN (live, left);
+            int to_capture =3D MIN (live, left);
             struct st_sample *src;
             struct capture_callback *cb;
=20
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 4bec6c8c5c13..f0ab4014a85d 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -413,7 +413,7 @@ static int coreaudio_run_out (HWVoiceOut *hw, int liv=
e)
                 core->live);
     }
=20
-    decr =3D audio_MIN (core->decr, live);
+    decr =3D MIN (core->decr, live);
     core->decr -=3D decr;
=20
     core->live =3D live - decr;
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 5da4c864c3f2..07260f881eaa 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -707,7 +707,7 @@ static int dsound_run_in (HWVoiceIn *hw)
     if (!len) {
         return 0;
     }
-    len =3D audio_MIN (len, dead);
+    len =3D MIN (len, dead);
=20
     err =3D dsound_lock_in (
         dscb,
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 9b195dc52ca3..14a0e4ab29f4 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -52,11 +52,11 @@ static int no_run_out (HWVoiceOut *hw, int live)
     now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ticks =3D now - no->old_ticks;
     bytes =3D muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER=
_SECOND);
-    bytes =3D audio_MIN(bytes, INT_MAX);
+    bytes =3D MIN(bytes, INT_MAX);
     samples =3D bytes >> hw->info.shift;
=20
     no->old_ticks =3D now;
-    decr =3D audio_MIN (live, samples);
+    decr =3D MIN (live, samples);
     hw->rpos =3D (hw->rpos + decr) % hw->samples;
     return decr;
 }
@@ -111,9 +111,9 @@ static int no_run_in (HWVoiceIn *hw)
             muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_S=
ECOND);
=20
         no->old_ticks =3D now;
-        bytes =3D audio_MIN (bytes, INT_MAX);
+        bytes =3D MIN (bytes, INT_MAX);
         samples =3D bytes >> hw->info.shift;
-        samples =3D audio_MIN (samples, dead);
+        samples =3D MIN (samples, dead);
     }
     return samples;
 }
@@ -124,7 +124,7 @@ static int no_read (SWVoiceIn *sw, void *buf, int siz=
e)
      * useless resampling/mixing */
     int samples =3D size >> sw->info.shift;
     int total =3D sw->hw->total_samples_captured - sw->total_hw_samples_=
acquired;
-    int to_clear =3D audio_MIN (samples, total);
+    int to_clear =3D MIN (samples, total);
     sw->total_hw_samples_acquired +=3D total;
     audio_pcm_info_clear_buf (&sw->info, buf, to_clear);
     return to_clear << sw->info.shift;
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index c0af065b6ff2..29139ef1f5cd 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -388,7 +388,7 @@ static void oss_write_pending (OSSVoiceOut *oss)
         int samples_written;
         ssize_t bytes_written;
         int samples_till_end =3D hw->samples - oss->wpos;
-        int samples_to_write =3D audio_MIN (oss->pending, samples_till_e=
nd);
+        int samples_to_write =3D MIN (oss->pending, samples_till_end);
         int bytes_to_write =3D samples_to_write << hw->info.shift;
         void *pcm =3D advance (oss->pcm_buf, oss->wpos << hw->info.shift=
);
=20
@@ -437,7 +437,7 @@ static int oss_run_out (HWVoiceOut *hw, int live)
=20
         pos =3D hw->rpos << hw->info.shift;
         bytes =3D audio_ring_dist (cntinfo.ptr, pos, bufsize);
-        decr =3D audio_MIN (bytes >> hw->info.shift, live);
+        decr =3D MIN (bytes >> hw->info.shift, live);
     }
     else {
         err =3D ioctl (oss->fd, SNDCTL_DSP_GETOSPACE, &abinfo);
@@ -456,7 +456,7 @@ static int oss_run_out (HWVoiceOut *hw, int live)
             return 0;
         }
=20
-        decr =3D audio_MIN (abinfo.bytes >> hw->info.shift, live);
+        decr =3D MIN (abinfo.bytes >> hw->info.shift, live);
         if (!decr) {
             return 0;
         }
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 1d68173636ed..f3864e1d5038 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -235,7 +235,7 @@ static void *qpa_thread_out (void *arg)
             }
         }
=20
-        decr =3D to_mix =3D audio_MIN(pa->live, pa->samples >> 5);
+        decr =3D to_mix =3D MIN(pa->live, pa->samples >> 5);
         rpos =3D pa->rpos;
=20
         if (audio_pt_unlock(&pa->pt, __func__)) {
@@ -244,7 +244,7 @@ static void *qpa_thread_out (void *arg)
=20
         while (to_mix) {
             int error;
-            int chunk =3D audio_MIN (to_mix, hw->samples - rpos);
+            int chunk =3D MIN (to_mix, hw->samples - rpos);
             struct st_sample *src =3D hw->mix_buf + rpos;
=20
             hw->clip (pa->pcm_buf, src, chunk);
@@ -282,7 +282,7 @@ static int qpa_run_out (HWVoiceOut *hw, int live)
         return 0;
     }
=20
-    decr =3D audio_MIN (live, pa->decr);
+    decr =3D MIN (live, pa->decr);
     pa->decr -=3D decr;
     pa->live =3D live - decr;
     hw->rpos =3D pa->rpos;
@@ -327,7 +327,7 @@ static void *qpa_thread_in (void *arg)
             }
         }
=20
-        incr =3D to_grab =3D audio_MIN(pa->dead, pa->samples >> 5);
+        incr =3D to_grab =3D MIN(pa->dead, pa->samples >> 5);
         wpos =3D pa->wpos;
=20
         if (audio_pt_unlock(&pa->pt, __func__)) {
@@ -336,7 +336,7 @@ static void *qpa_thread_in (void *arg)
=20
         while (to_grab) {
             int error;
-            int chunk =3D audio_MIN (to_grab, hw->samples - wpos);
+            int chunk =3D MIN (to_grab, hw->samples - wpos);
             void *buf =3D advance (pa->pcm_buf, wpos);
=20
             if (qpa_simple_read (pa, buf,
@@ -375,7 +375,7 @@ static int qpa_run_in (HWVoiceIn *hw)
=20
     live =3D audio_pcm_hw_get_live_in (hw);
     dead =3D hw->samples - live;
-    incr =3D audio_MIN (dead, pa->incr);
+    incr =3D MIN (dead, pa->incr);
     pa->incr -=3D incr;
     pa->dead =3D dead - incr;
     hw->wpos =3D pa->wpos;
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index e7179ff1d410..42f7614124c6 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -193,10 +193,10 @@ static void sdl_callback (void *opaque, Uint8 *buf,=
 int len)
=20
     /* dolog ("in callback samples=3D%d live=3D%d\n", samples, sdl->live=
); */
=20
-    to_mix =3D audio_MIN(samples, sdl->live);
+    to_mix =3D MIN(samples, sdl->live);
     decr =3D to_mix;
     while (to_mix) {
-        int chunk =3D audio_MIN(to_mix, hw->samples - hw->rpos);
+        int chunk =3D MIN(to_mix, hw->samples - hw->rpos);
         struct st_sample *src =3D hw->mix_buf + hw->rpos;
=20
         /* dolog ("in callback to_mix %d, chunk %d\n", to_mix, chunk); *=
/
@@ -236,7 +236,7 @@ static int sdl_run_out (HWVoiceOut *hw, int live)
                 sdl->live);
     }
=20
-    decr =3D audio_MIN (sdl->decr, live);
+    decr =3D MIN (sdl->decr, live);
     sdl->decr -=3D decr;
=20
     sdl->live =3D live;
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index ec1c8fe93696..5672e12dc3a2 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -163,20 +163,20 @@ static int line_out_run (HWVoiceOut *hw, int live)
     }
=20
     decr =3D rate_get_samples (&hw->info, &out->rate);
-    decr =3D audio_MIN (live, decr);
+    decr =3D MIN (live, decr);
=20
     samples =3D decr;
     rpos =3D hw->rpos;
     while (samples) {
         int left_till_end_samples =3D hw->samples - rpos;
-        int len =3D audio_MIN (samples, left_till_end_samples);
+        int len =3D MIN (samples, left_till_end_samples);
=20
         if (!out->frame) {
             spice_server_playback_get_buffer (&out->sin, &out->frame, &o=
ut->fsize);
             out->fpos =3D out->frame;
         }
         if (out->frame) {
-            len =3D audio_MIN (len, out->fsize);
+            len =3D MIN (len, out->fsize);
             hw->clip (out->fpos, hw->mix_buf + rpos, len);
             out->fsize -=3D len;
             out->fpos  +=3D len;
@@ -294,7 +294,7 @@ static int line_in_run (HWVoiceIn *hw)
     }
=20
     delta_samp =3D rate_get_samples (&hw->info, &in->rate);
-    num_samples =3D audio_MIN (num_samples, delta_samp);
+    num_samples =3D MIN (num_samples, delta_samp);
=20
     ready =3D spice_server_record_get_samples (&in->sin, in->samples, nu=
m_samples);
     samples =3D in->samples;
@@ -304,7 +304,7 @@ static int line_in_run (HWVoiceIn *hw)
         ready =3D LINE_IN_SAMPLES;
     }
=20
-    num_samples =3D audio_MIN (ready, num_samples);
+    num_samples =3D MIN (ready, num_samples);
=20
     if (hw->wpos + num_samples > hw->samples) {
         len[0] =3D hw->samples - hw->wpos;
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 803b6cb1f3d0..bbf3f3b3462f 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -59,12 +59,12 @@ static int wav_run_out (HWVoiceOut *hw, int live)
     }
=20
     wav->old_ticks =3D now;
-    decr =3D audio_MIN (live, samples);
+    decr =3D MIN (live, samples);
     samples =3D decr;
     rpos =3D hw->rpos;
     while (samples) {
         int left_till_end_samples =3D hw->samples - rpos;
-        int convert_samples =3D audio_MIN (samples, left_till_end_sample=
s);
+        int convert_samples =3D MIN (samples, left_till_end_samples);
=20
         src =3D hw->mix_buf + rpos;
         dst =3D advance (wav->pcm_buf, rpos << hw->info.shift);
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index b4c0b690d720..a136b97f684e 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -965,7 +965,7 @@ static int write_audio (AC97LinkState *s, AC97BusMast=
erRegs *r,
     uint32_t temp =3D r->picb << 1;
     uint32_t written =3D 0;
     int to_copy =3D 0;
-    temp =3D audio_MIN (temp, max);
+    temp =3D MIN (temp, max);
=20
     if (!temp) {
         *stop =3D 1;
@@ -974,7 +974,7 @@ static int write_audio (AC97LinkState *s, AC97BusMast=
erRegs *r,
=20
     while (temp) {
         int copied;
-        to_copy =3D audio_MIN (temp, sizeof (tmpbuf));
+        to_copy =3D MIN (temp, sizeof (tmpbuf));
         pci_dma_read (&s->dev, addr, tmpbuf, to_copy);
         copied =3D AUD_write (s->voice_po, tmpbuf, to_copy);
         dolog ("write_audio max=3D%x to_copy=3D%x copied=3D%x\n",
@@ -1020,7 +1020,7 @@ static void write_bup (AC97LinkState *s, int elapse=
d)
     }
=20
     while (elapsed) {
-        int temp =3D audio_MIN (elapsed, sizeof (s->silence));
+        int temp =3D MIN (elapsed, sizeof (s->silence));
         while (temp) {
             int copied =3D AUD_write (s->voice_po, s->silence, temp);
             if (!copied)
@@ -1041,7 +1041,7 @@ static int read_audio (AC97LinkState *s, AC97BusMas=
terRegs *r,
     int to_copy =3D 0;
     SWVoiceIn *voice =3D (r - s->bm_regs) =3D=3D MC_INDEX ? s->voice_mc =
: s->voice_pi;
=20
-    temp =3D audio_MIN (temp, max);
+    temp =3D MIN (temp, max);
=20
     if (!temp) {
         *stop =3D 1;
@@ -1050,7 +1050,7 @@ static int read_audio (AC97LinkState *s, AC97BusMas=
terRegs *r,
=20
     while (temp) {
         int acquired;
-        to_copy =3D audio_MIN (temp, sizeof (tmpbuf));
+        to_copy =3D MIN (temp, sizeof (tmpbuf));
         acquired =3D AUD_read (voice, tmpbuf, to_copy);
         if (!acquired) {
             *stop =3D 1;
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 64a1060b807a..cb4178d86150 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -195,7 +195,7 @@ static void adlib_callback (void *opaque, int free)
         return;
     }
=20
-    to_play =3D audio_MIN (s->left, samples);
+    to_play =3D MIN (s->left, samples);
     while (to_play) {
         written =3D write_audio (s, to_play);
=20
@@ -210,7 +210,7 @@ static void adlib_callback (void *opaque, int free)
         }
     }
=20
-    samples =3D audio_MIN (samples, s->samples - s->pos);
+    samples =3D MIN (samples, s->samples - s->pos);
     if (!samples) {
         return;
     }
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 5b7baeae256d..c7b8067489ad 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -536,7 +536,7 @@ static int cs_write_audio (CSState *s, int nchan, int=
 dma_pos,
         int copied;
         size_t to_copy;
=20
-        to_copy =3D audio_MIN (temp, left);
+        to_copy =3D MIN (temp, left);
         if (to_copy > sizeof (tmpbuf)) {
             to_copy =3D sizeof (tmpbuf);
         }
@@ -579,7 +579,7 @@ static int cs_dma_read (void *opaque, int nchan, int =
dma_pos, int dma_len)
         till =3D (s->dregs[Playback_Lower_Base_Count]
             | (s->dregs[Playback_Upper_Base_Count] << 8)) << s->shift;
         till -=3D s->transferred;
-        copy =3D audio_MIN (till, copy);
+        copy =3D MIN (till, copy);
     }
=20
     if ((copy <=3D 0) || (dma_len <=3D 0)) {
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 88f886491b96..f9e9f2a3b33d 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -645,7 +645,7 @@ static void es1370_transfer_audio (ES1370State *s, st=
ruct chan *d, int loop_sel,
     int size =3D d->frame_cnt & 0xffff;
     int left =3D ((size - cnt + 1) << 2) + d->leftover;
     int transferred =3D 0;
-    int temp =3D audio_MIN (max, audio_MIN (left, csc_bytes));
+    int temp =3D MIN (max, MIN (left, csc_bytes));
     int index =3D d - &s->chan[0];
=20
     addr +=3D (cnt << 2) + d->leftover;
@@ -654,7 +654,7 @@ static void es1370_transfer_audio (ES1370State *s, st=
ruct chan *d, int loop_sel,
         while (temp) {
             int acquired, to_copy;
=20
-            to_copy =3D audio_MIN ((size_t) temp, sizeof (tmpbuf));
+            to_copy =3D MIN ((size_t) temp, sizeof (tmpbuf));
             acquired =3D AUD_read (s->adc_voice, tmpbuf, to_copy);
             if (!acquired)
                 break;
@@ -672,7 +672,7 @@ static void es1370_transfer_audio (ES1370State *s, st=
ruct chan *d, int loop_sel,
         while (temp) {
             int copied, to_copy;
=20
-            to_copy =3D audio_MIN ((size_t) temp, sizeof (tmpbuf));
+            to_copy =3D MIN ((size_t) temp, sizeof (tmpbuf));
             pci_dma_read (&s->dev, addr, tmpbuf, to_copy);
             copied =3D AUD_write (voice, tmpbuf, to_copy);
             if (!copied)
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index effec31d356d..2b6b7c4e3f90 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -119,7 +119,7 @@ static void GUS_callback (void *opaque, int free)
     GUSState *s =3D opaque;
=20
     samples =3D free >> s->shift;
-    to_play =3D audio_MIN (samples, s->left);
+    to_play =3D MIN (samples, s->left);
=20
     while (to_play) {
         int written =3D write_audio (s, to_play);
@@ -134,7 +134,7 @@ static void GUS_callback (void *opaque, int free)
         net +=3D written;
     }
=20
-    samples =3D audio_MIN (samples, s->samples);
+    samples =3D MIN (samples, s->samples);
     if (samples) {
         gus_mixvoices (&s->emu, s->freq, samples, s->mixbuf);
=20
@@ -194,7 +194,7 @@ static int GUS_read_DMA (void *opaque, int nchan, int=
 dma_pos, int dma_len)
     ldebug ("read DMA %#x %d\n", dma_pos, dma_len);
     mode =3D k->has_autoinitialization(s->isa_dma, s->emu.gusdma);
     while (left) {
-        int to_copy =3D audio_MIN ((size_t) left, sizeof (tmpbuf));
+        int to_copy =3D MIN ((size_t) left, sizeof (tmpbuf));
         int copied;
=20
         ldebug ("left=3D%d to_copy=3D%d pos=3D%d\n", left, to_copy, pos)=
;
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 68fe1de987c2..f17e8d8dcea2 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -235,10 +235,10 @@ static void hda_audio_input_timer(void *opaque)
         goto out_timer;
     }
=20
-    int64_t to_transfer =3D audio_MIN(wpos - rpos, wanted_rpos - rpos);
+    int64_t to_transfer =3D MIN(wpos - rpos, wanted_rpos - rpos);
     while (to_transfer) {
         uint32_t start =3D (rpos & B_MASK);
-        uint32_t chunk =3D audio_MIN(B_SIZE - start, to_transfer);
+        uint32_t chunk =3D MIN(B_SIZE - start, to_transfer);
         int rc =3D hda_codec_xfer(
                 &st->state->hda, st->stream, false, st->buf + start, chu=
nk);
         if (!rc) {
@@ -263,13 +263,13 @@ static void hda_audio_input_cb(void *opaque, int av=
ail)
     int64_t wpos =3D st->wpos;
     int64_t rpos =3D st->rpos;
=20
-    int64_t to_transfer =3D audio_MIN(B_SIZE - (wpos - rpos), avail);
+    int64_t to_transfer =3D MIN(B_SIZE - (wpos - rpos), avail);
=20
     hda_timer_sync_adjust(st, -((wpos - rpos) + to_transfer - (B_SIZE >>=
 1)));
=20
     while (to_transfer) {
         uint32_t start =3D (uint32_t) (wpos & B_MASK);
-        uint32_t chunk =3D (uint32_t) audio_MIN(B_SIZE - start, to_trans=
fer);
+        uint32_t chunk =3D (uint32_t) MIN(B_SIZE - start, to_transfer);
         uint32_t read =3D AUD_read(st->voice.in, st->buf + start, chunk)=
;
         wpos +=3D read;
         to_transfer -=3D read;
@@ -299,10 +299,10 @@ static void hda_audio_output_timer(void *opaque)
         goto out_timer;
     }
=20
-    int64_t to_transfer =3D audio_MIN(B_SIZE - (wpos - rpos), wanted_wpo=
s - wpos);
+    int64_t to_transfer =3D MIN(B_SIZE - (wpos - rpos), wanted_wpos - wp=
os);
     while (to_transfer) {
         uint32_t start =3D (wpos & B_MASK);
-        uint32_t chunk =3D audio_MIN(B_SIZE - start, to_transfer);
+        uint32_t chunk =3D MIN(B_SIZE - start, to_transfer);
         int rc =3D hda_codec_xfer(
                 &st->state->hda, st->stream, true, st->buf + start, chun=
k);
         if (!rc) {
@@ -327,7 +327,7 @@ static void hda_audio_output_cb(void *opaque, int ava=
il)
     int64_t wpos =3D st->wpos;
     int64_t rpos =3D st->rpos;
=20
-    int64_t to_transfer =3D audio_MIN(wpos - rpos, avail);
+    int64_t to_transfer =3D MIN(wpos - rpos, avail);
=20
     if (wpos - rpos =3D=3D B_SIZE) {
         /* drop buffer, reset timer adjust */
@@ -342,7 +342,7 @@ static void hda_audio_output_cb(void *opaque, int ava=
il)
=20
     while (to_transfer) {
         uint32_t start =3D (uint32_t) (rpos & B_MASK);
-        uint32_t chunk =3D (uint32_t) audio_MIN(B_SIZE - start, to_trans=
fer);
+        uint32_t chunk =3D (uint32_t) MIN(B_SIZE - start, to_transfer);
         uint32_t written =3D AUD_write(st->voice.out, st->buf + start, c=
hunk);
         rpos +=3D written;
         to_transfer -=3D written;
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index 853b4ed8746b..6d409eff1b1c 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -185,7 +185,7 @@ static void ac97_in_cb(void *opaque, int avail_b)
     MilkymistAC97State *s =3D opaque;
     uint8_t buf[4096];
     uint32_t remaining =3D s->regs[R_U_REMAINING];
-    int temp =3D audio_MIN(remaining, avail_b);
+    int temp =3D MIN(remaining, avail_b);
     uint32_t addr =3D s->regs[R_U_ADDR];
     int transferred =3D 0;
=20
@@ -199,7 +199,7 @@ static void ac97_in_cb(void *opaque, int avail_b)
     while (temp) {
         int acquired, to_copy;
=20
-        to_copy =3D audio_MIN(temp, sizeof(buf));
+        to_copy =3D MIN(temp, sizeof(buf));
         acquired =3D AUD_read(s->voice_in, buf, to_copy);
         if (!acquired) {
             break;
@@ -228,7 +228,7 @@ static void ac97_out_cb(void *opaque, int free_b)
     MilkymistAC97State *s =3D opaque;
     uint8_t buf[4096];
     uint32_t remaining =3D s->regs[R_D_REMAINING];
-    int temp =3D audio_MIN(remaining, free_b);
+    int temp =3D MIN(remaining, free_b);
     uint32_t addr =3D s->regs[R_D_ADDR];
     int transferred =3D 0;
=20
@@ -242,7 +242,7 @@ static void ac97_out_cb(void *opaque, int free_b)
     while (temp) {
         int copied, to_copy;
=20
-        to_copy =3D audio_MIN(temp, sizeof(buf));
+        to_copy =3D MIN(temp, sizeof(buf));
         cpu_physical_memory_read(addr, buf, to_copy);
         copied =3D AUD_write(s->voice_out, buf, to_copy);
         if (!copied) {
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 307c6647254a..d773eb80de57 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -103,7 +103,7 @@ static void pcspk_callback(void *opaque, int free)
     }
=20
     while (free > 0) {
-        n =3D audio_MIN(s->samples - s->play_pos, (unsigned int)free);
+        n =3D MIN(s->samples - s->play_pos, (unsigned int)free);
         n =3D AUD_write(s->voice, &s->sample_buf[s->play_pos], n);
         if (!n)
             break;
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 7e50ab8a84a3..a354f94acb27 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1169,7 +1169,7 @@ static int write_audio (SB16State *s, int nchan, in=
t dma_pos,
         int copied;
         size_t to_copy;
=20
-        to_copy =3D audio_MIN (temp, left);
+        to_copy =3D MIN (temp, left);
         if (to_copy > sizeof (tmpbuf)) {
             to_copy =3D sizeof (tmpbuf);
         }
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index a8725abf6a37..601ed04aff49 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -70,7 +70,7 @@ static inline void wm8750_in_load(WM8750State *s)
 {
     if (s->idx_in + s->req_in <=3D sizeof(s->data_in))
         return;
-    s->idx_in =3D audio_MAX(0, (int) sizeof(s->data_in) - s->req_in);
+    s->idx_in =3D MAX(0, (int) sizeof(s->data_in) - s->req_in);
     AUD_read(*s->in[0], s->data_in + s->idx_in,
              sizeof(s->data_in) - s->idx_in);
 }
@@ -101,7 +101,7 @@ static void wm8750_audio_out_cb(void *opaque, int fre=
e_b)
         wm8750_out_flush(s);
     } else
         s->req_out =3D free_b - s->idx_out;
-=20
+
     s->data_req(s->opaque, s->req_out >> 2, s->req_in >> 2);
 }
=20
--=20
2.18.1


