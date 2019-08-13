Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D4EC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5742D20673
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5742D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxUt6-0002A8-LN
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hxUp2-0001Ex-L9
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hxUoy-00058r-Cl
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hxUou-00054U-8v
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DECF230BCB8C;
 Tue, 13 Aug 2019 11:18:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 705AC100195F;
 Tue, 13 Aug 2019 11:18:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EFF349CAA; Tue, 13 Aug 2019 13:18:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:18:07 +0200
Message-Id: <20190813111809.3141-14-kraxel@redhat.com>
In-Reply-To: <20190813111809.3141-1-kraxel@redhat.com>
References: <20190813111809.3141-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 13 Aug 2019 11:18:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/15] audio: use size_t where makes sense
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kővágó@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 77ff4b0fa47bdf2766d2e0d5d3dafe759bd35a39.1564925486.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.h           |   4 +-
 audio/audio_int.h       |  26 +++----
 audio/audio_template.h  |  14 ++--
 audio/mixeng.h          |   9 +--
 audio/rate_template.h   |   2 +-
 include/sysemu/replay.h |   4 +-
 audio/alsaaudio.c       |  26 +++----
 audio/audio.c           | 156 ++++++++++++++++++++--------------------
 audio/coreaudio.c       |  10 +--
 audio/dsoundaudio.c     |  11 +--
 audio/noaudio.c         |  16 ++---
 audio/ossaudio.c        |  45 ++++++------
 audio/paaudio.c         |  44 ++++++------
 audio/sdlaudio.c        |  20 +++---
 audio/spiceaudio.c      |  12 ++--
 audio/wavaudio.c        |   8 +--
 replay/replay-audio.c   |  16 ++---
 replay/replay.c         |   2 +-
 18 files changed, 212 insertions(+), 213 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 4a9575851625..2db27bba7b78 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -112,7 +112,7 @@ SWVoiceOut *AUD_open_out (
     );
=20
 void AUD_close_out (QEMUSoundCard *card, SWVoiceOut *sw);
-int  AUD_write (SWVoiceOut *sw, void *pcm_buf, int size);
+size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
 int  AUD_get_buffer_size_out (SWVoiceOut *sw);
 void AUD_set_active_out (SWVoiceOut *sw, int on);
 int  AUD_is_active_out (SWVoiceOut *sw);
@@ -133,7 +133,7 @@ SWVoiceIn *AUD_open_in (
     );
=20
 void AUD_close_in (QEMUSoundCard *card, SWVoiceIn *sw);
-int  AUD_read (SWVoiceIn *sw, void *pcm_buf, int size);
+size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
 void AUD_set_active_in (SWVoiceIn *sw, int on);
 int  AUD_is_active_in (SWVoiceIn *sw);
=20
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 003b7ab8cc6b..a674c5374a06 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -61,12 +61,12 @@ typedef struct HWVoiceOut {
=20
     f_sample *clip;
=20
-    int rpos;
+    size_t rpos;
     uint64_t ts_helper;
=20
     struct st_sample *mix_buf;
=20
-    int samples;
+    size_t samples;
     QLIST_HEAD (sw_out_listhead, SWVoiceOut) sw_head;
     QLIST_HEAD (sw_cap_listhead, SWVoiceCap) cap_head;
     int ctl_caps;
@@ -82,13 +82,13 @@ typedef struct HWVoiceIn {
=20
     t_sample *conv;
=20
-    int wpos;
-    int total_samples_captured;
+    size_t wpos;
+    size_t total_samples_captured;
     uint64_t ts_helper;
=20
     struct st_sample *conv_buf;
=20
-    int samples;
+    size_t samples;
     QLIST_HEAD (sw_in_listhead, SWVoiceIn) sw_head;
     int ctl_caps;
     struct audio_pcm_ops *pcm_ops;
@@ -103,7 +103,7 @@ struct SWVoiceOut {
     int64_t ratio;
     struct st_sample *buf;
     void *rate;
-    int total_hw_samples_mixed;
+    size_t total_hw_samples_mixed;
     int active;
     int empty;
     HWVoiceOut *hw;
@@ -120,7 +120,7 @@ struct SWVoiceIn {
     struct audio_pcm_info info;
     int64_t ratio;
     void *rate;
-    int total_hw_samples_acquired;
+    size_t total_hw_samples_acquired;
     struct st_sample *buf;
     f_sample *clip;
     HWVoiceIn *hw;
@@ -149,12 +149,12 @@ struct audio_driver {
 struct audio_pcm_ops {
     int  (*init_out)(HWVoiceOut *hw, struct audsettings *as, void *drv_o=
paque);
     void (*fini_out)(HWVoiceOut *hw);
-    int  (*run_out) (HWVoiceOut *hw, int live);
+    size_t (*run_out)(HWVoiceOut *hw, size_t live);
     int  (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
=20
     int  (*init_in) (HWVoiceIn *hw, struct audsettings *as, void *drv_op=
aque);
     void (*fini_in) (HWVoiceIn *hw);
-    int  (*run_in)  (HWVoiceIn *hw);
+    size_t (*run_in)(HWVoiceIn *hw);
     int  (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
 };
=20
@@ -208,10 +208,10 @@ audio_driver *audio_driver_lookup(const char *name)=
;
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsetting=
s *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, i=
nt len);
=20
-int  audio_pcm_hw_get_live_in (HWVoiceIn *hw);
+size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw);
=20
-int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
-                           int live, int pending);
+size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
+                             size_t live, size_t pending);
=20
 int audio_bug (const char *funcname, int cond);
 void *audio_calloc (const char *funcname, int nmemb, size_t size);
@@ -224,7 +224,7 @@ void audio_run(AudioState *s, const char *msg);
=20
 #define VOICE_VOLUME_CAP (1 << VOICE_VOLUME)
=20
-static inline int audio_ring_dist (int dst, int src, int len)
+static inline size_t audio_ring_dist(size_t dst, size_t src, size_t len)
 {
     return (dst >=3D src) ? (dst - src) : (len - src + dst);
 }
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 54f07338e76f..2562bf5f0062 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -75,16 +75,16 @@ static void glue (audio_pcm_hw_free_resources_, TYPE)=
 (HW *hw)
     HWBUF =3D NULL;
 }
=20
-static int glue (audio_pcm_hw_alloc_resources_, TYPE) (HW *hw)
+static bool glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
 {
     HWBUF =3D audio_calloc(__func__, hw->samples, sizeof(struct st_sampl=
e));
     if (!HWBUF) {
-        dolog ("Could not allocate " NAME " buffer (%d samples)\n",
-               hw->samples);
-        return -1;
+        dolog("Could not allocate " NAME " buffer (%zu samples)\n",
+              hw->samples);
+        return false;
     }
=20
-    return 0;
+    return true;
 }
=20
 static void glue (audio_pcm_sw_free_resources_, TYPE) (SW *sw)
@@ -265,7 +265,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioSta=
te *s,
     }
=20
     if (audio_bug(__func__, hw->samples <=3D 0)) {
-        dolog ("hw->samples=3D%d\n", hw->samples);
+        dolog("hw->samples=3D%zd\n", hw->samples);
         goto err1;
     }
=20
@@ -279,7 +279,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioSta=
te *s,
         [hw->info.swap_endianness]
         [audio_bits_to_index (hw->info.bits)];
=20
-    if (glue (audio_pcm_hw_alloc_resources_, TYPE) (hw)) {
+    if (!glue(audio_pcm_hw_alloc_resources_, TYPE)(hw)) {
         goto err1;
     }
=20
diff --git a/audio/mixeng.h b/audio/mixeng.h
index b53a5ef99a6a..18e62c7c49e7 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -33,6 +33,7 @@ struct st_sample { mixeng_real l; mixeng_real r; };
 struct mixeng_volume { int mute; int64_t r; int64_t l; };
 struct st_sample { int64_t l; int64_t r; };
 #endif
+typedef struct st_sample st_sample;
=20
 typedef void (t_sample) (struct st_sample *dst, const void *src, int sam=
ples);
 typedef void (f_sample) (void *dst, const struct st_sample *src, int sam=
ples);
@@ -41,10 +42,10 @@ extern t_sample *mixeng_conv[2][2][2][3];
 extern f_sample *mixeng_clip[2][2][2][3];
=20
 void *st_rate_start (int inrate, int outrate);
-void st_rate_flow (void *opaque, struct st_sample *ibuf, struct st_sampl=
e *obuf,
-                   int *isamp, int *osamp);
-void st_rate_flow_mix (void *opaque, struct st_sample *ibuf, struct st_s=
ample *obuf,
-                       int *isamp, int *osamp);
+void st_rate_flow(void *opaque, st_sample *ibuf, st_sample *obuf,
+                  size_t *isamp, size_t *osamp);
+void st_rate_flow_mix(void *opaque, st_sample *ibuf, st_sample *obuf,
+                      size_t *isamp, size_t *osamp);
 void st_rate_stop (void *opaque);
 void mixeng_clear (struct st_sample *buf, int len);
 void mixeng_volume (struct st_sample *buf, int len, struct mixeng_volume=
 *vol);
diff --git a/audio/rate_template.h b/audio/rate_template.h
index 6e93588877d0..f94c940c61b1 100644
--- a/audio/rate_template.h
+++ b/audio/rate_template.h
@@ -28,7 +28,7 @@
  * Return number of samples processed.
  */
 void NAME (void *opaque, struct st_sample *ibuf, struct st_sample *obuf,
-           int *isamp, int *osamp)
+           size_t *isamp, size_t *osamp)
 {
     struct rate *rate =3D opaque;
     struct st_sample *istart, *iend;
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 3a7c58e4238f..5c0a91e44f0a 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -179,9 +179,9 @@ void replay_net_packet_event(ReplayNetState *rns, uns=
igned flags,
 /* Audio */
=20
 /*! Saves/restores number of played samples of audio out operation. */
-void replay_audio_out(int *played);
+void replay_audio_out(size_t *played);
 /*! Saves/restores recorded samples of audio in operation. */
-void replay_audio_in(int *recorded, void *samples, int *wpos, int size);
+void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size=
_t size);
=20
 /* VM state operations */
=20
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index e9e3a4819c82..591344dccd1f 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -681,10 +681,10 @@ static void alsa_write_pending (ALSAVoiceOut *alsa)
     }
 }
=20
-static int alsa_run_out (HWVoiceOut *hw, int live)
+static size_t alsa_run_out(HWVoiceOut *hw, size_t live)
 {
     ALSAVoiceOut *alsa =3D (ALSAVoiceOut *) hw;
-    int decr;
+    size_t decr;
     snd_pcm_sframes_t avail;
=20
     avail =3D alsa_get_avail (alsa->handle);
@@ -739,8 +739,8 @@ static int alsa_init_out(HWVoiceOut *hw, struct audse=
ttings *as,
=20
     alsa->pcm_buf =3D audio_calloc(__func__, obt.samples, 1 << hw->info.=
shift);
     if (!alsa->pcm_buf) {
-        dolog ("Could not allocate DAC buffer (%d samples, each %d bytes=
)\n",
-               hw->samples, 1 << hw->info.shift);
+        dolog("Could not allocate DAC buffer (%zu samples, each %d bytes=
)\n",
+              hw->samples, 1 << hw->info.shift);
         alsa_anal_close1 (&handle);
         return -1;
     }
@@ -841,8 +841,8 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsett=
ings *as, void *drv_opaque)
=20
     alsa->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.=
shift);
     if (!alsa->pcm_buf) {
-        dolog ("Could not allocate ADC buffer (%d samples, each %d bytes=
)\n",
-               hw->samples, 1 << hw->info.shift);
+        dolog("Could not allocate ADC buffer (%zu samples, each %d bytes=
)\n",
+              hw->samples, 1 << hw->info.shift);
         alsa_anal_close1 (&handle);
         return -1;
     }
@@ -863,17 +863,17 @@ static void alsa_fini_in (HWVoiceIn *hw)
     alsa->pcm_buf =3D NULL;
 }
=20
-static int alsa_run_in (HWVoiceIn *hw)
+static size_t alsa_run_in(HWVoiceIn *hw)
 {
     ALSAVoiceIn *alsa =3D (ALSAVoiceIn *) hw;
     int hwshift =3D hw->info.shift;
     int i;
-    int live =3D audio_pcm_hw_get_live_in (hw);
-    int dead =3D hw->samples - live;
-    int decr;
+    size_t live =3D audio_pcm_hw_get_live_in (hw);
+    size_t dead =3D hw->samples - live;
+    size_t decr;
     struct {
-        int add;
-        int len;
+        size_t add;
+        size_t len;
     } bufs[2] =3D {
         { .add =3D hw->wpos, .len =3D 0 },
         { .add =3D 0,        .len =3D 0 }
@@ -913,7 +913,7 @@ static int alsa_run_in (HWVoiceIn *hw)
         }
     }
=20
-    decr =3D MIN (dead, avail);
+    decr =3D MIN(dead, avail);
     if (!decr) {
         return 0;
     }
diff --git a/audio/audio.c b/audio/audio.c
index 254499dfa13d..d3c639211d43 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -526,10 +526,10 @@ static int audio_attach_capture (HWVoiceOut *hw)
 /*
  * Hard voice (capture)
  */
-static int audio_pcm_hw_find_min_in (HWVoiceIn *hw)
+static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
 {
     SWVoiceIn *sw;
-    int m =3D hw->total_samples_captured;
+    size_t m =3D hw->total_samples_captured;
=20
     for (sw =3D hw->sw_head.lh_first; sw; sw =3D sw->entries.le_next) {
         if (sw->active) {
@@ -539,28 +539,28 @@ static int audio_pcm_hw_find_min_in (HWVoiceIn *hw)
     return m;
 }
=20
-int audio_pcm_hw_get_live_in (HWVoiceIn *hw)
+size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 {
-    int live =3D hw->total_samples_captured - audio_pcm_hw_find_min_in (=
hw);
-    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-        dolog ("live=3D%d hw->samples=3D%d\n", live, hw->samples);
+    size_t live =3D hw->total_samples_captured - audio_pcm_hw_find_min_i=
n (hw);
+    if (audio_bug(__func__, live > hw->samples)) {
+        dolog("live=3D%zu hw->samples=3D%zu\n", live, hw->samples);
         return 0;
     }
     return live;
 }
=20
-int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pcm_buf,
-                           int live, int pending)
+size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
+                             size_t live, size_t pending)
 {
-    int left =3D hw->samples - pending;
-    int len =3D MIN (left, live);
-    int clipped =3D 0;
+    size_t left =3D hw->samples - pending;
+    size_t len =3D MIN (left, live);
+    size_t clipped =3D 0;
=20
     while (len) {
         struct st_sample *src =3D hw->mix_buf + hw->rpos;
         uint8_t *dst =3D advance (pcm_buf, hw->rpos << hw->info.shift);
-        int samples_till_end_of_buf =3D hw->samples - hw->rpos;
-        int samples_to_clip =3D MIN (len, samples_till_end_of_buf);
+        size_t samples_till_end_of_buf =3D hw->samples - hw->rpos;
+        size_t samples_to_clip =3D MIN (len, samples_till_end_of_buf);
=20
         hw->clip (dst, src, samples_to_clip);
=20
@@ -574,14 +574,14 @@ int audio_pcm_hw_clip_out (HWVoiceOut *hw, void *pc=
m_buf,
 /*
  * Soft voice (capture)
  */
-static int audio_pcm_sw_get_rpos_in (SWVoiceIn *sw)
+static size_t audio_pcm_sw_get_rpos_in(SWVoiceIn *sw)
 {
     HWVoiceIn *hw =3D sw->hw;
-    int live =3D hw->total_samples_captured - sw->total_hw_samples_acqui=
red;
-    int rpos;
+    ssize_t live =3D hw->total_samples_captured - sw->total_hw_samples_a=
cquired;
+    ssize_t rpos;
=20
     if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-        dolog ("live=3D%d hw->samples=3D%d\n", live, hw->samples);
+        dolog("live=3D%zu hw->samples=3D%zu\n", live, hw->samples);
         return 0;
     }
=20
@@ -594,17 +594,17 @@ static int audio_pcm_sw_get_rpos_in (SWVoiceIn *sw)
     }
 }
=20
-static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf, int size)
+static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
 {
     HWVoiceIn *hw =3D sw->hw;
-    int samples, live, ret =3D 0, swlim, isamp, osamp, rpos, total =3D 0=
;
+    size_t samples, live, ret =3D 0, swlim, isamp, osamp, rpos, total =3D=
 0;
     struct st_sample *src, *dst =3D sw->buf;
=20
     rpos =3D audio_pcm_sw_get_rpos_in (sw) % hw->samples;
=20
     live =3D hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-        dolog ("live_in=3D%d hw->samples=3D%d\n", live, hw->samples);
+    if (audio_bug(__func__, live > hw->samples)) {
+        dolog("live_in=3D%zu hw->samples=3D%zu\n", live, hw->samples);
         return 0;
     }
=20
@@ -618,9 +618,9 @@ static int audio_pcm_sw_read(SWVoiceIn *sw, void *buf=
, int size)
=20
     while (swlim) {
         src =3D hw->conv_buf + rpos;
-        isamp =3D hw->wpos - rpos;
-        /* XXX: <=3D ? */
-        if (isamp <=3D 0) {
+        if (hw->wpos > rpos) {
+            isamp =3D hw->wpos - rpos;
+        } else {
             isamp =3D hw->samples - rpos;
         }
=20
@@ -629,11 +629,6 @@ static int audio_pcm_sw_read(SWVoiceIn *sw, void *bu=
f, int size)
         }
         osamp =3D swlim;
=20
-        if (audio_bug(__func__, osamp < 0)) {
-            dolog ("osamp=3D%d\n", osamp);
-            return 0;
-        }
-
         st_rate_flow (sw->rate, src, dst, &isamp, &osamp);
         swlim -=3D osamp;
         rpos =3D (rpos + isamp) % hw->samples;
@@ -654,10 +649,10 @@ static int audio_pcm_sw_read(SWVoiceIn *sw, void *b=
uf, int size)
 /*
  * Hard voice (playback)
  */
-static int audio_pcm_hw_find_min_out (HWVoiceOut *hw, int *nb_livep)
+static size_t audio_pcm_hw_find_min_out (HWVoiceOut *hw, int *nb_livep)
 {
     SWVoiceOut *sw;
-    int m =3D INT_MAX;
+    size_t m =3D SIZE_MAX;
     int nb_live =3D 0;
=20
     for (sw =3D hw->sw_head.lh_first; sw; sw =3D sw->entries.le_next) {
@@ -671,9 +666,9 @@ static int audio_pcm_hw_find_min_out (HWVoiceOut *hw,=
 int *nb_livep)
     return m;
 }
=20
-static int audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
+static size_t audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
 {
-    int smin;
+    size_t smin;
     int nb_live1;
=20
     smin =3D audio_pcm_hw_find_min_out (hw, &nb_live1);
@@ -682,10 +677,10 @@ static int audio_pcm_hw_get_live_out (HWVoiceOut *h=
w, int *nb_live)
     }
=20
     if (nb_live1) {
-        int live =3D smin;
+        size_t live =3D smin;
=20
-        if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-            dolog ("live=3D%d hw->samples=3D%d\n", live, hw->samples);
+        if (audio_bug(__func__, live > hw->samples)) {
+            dolog("live=3D%zu hw->samples=3D%zu\n", live, hw->samples);
             return 0;
         }
         return live;
@@ -696,10 +691,10 @@ static int audio_pcm_hw_get_live_out (HWVoiceOut *h=
w, int *nb_live)
 /*
  * Soft voice (playback)
  */
-static int audio_pcm_sw_write(SWVoiceOut *sw, void *buf, int size)
+static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
 {
-    int hwsamples, samples, isamp, osamp, wpos, live, dead, left, swlim,=
 blck;
-    int ret =3D 0, pos =3D 0, total =3D 0;
+    size_t hwsamples, samples, isamp, osamp, wpos, live, dead, left, swl=
im, blck;
+    size_t ret =3D 0, pos =3D 0, total =3D 0;
=20
     if (!sw) {
         return size;
@@ -708,8 +703,8 @@ static int audio_pcm_sw_write(SWVoiceOut *sw, void *b=
uf, int size)
     hwsamples =3D sw->hw->samples;
=20
     live =3D sw->total_hw_samples_mixed;
-    if (audio_bug(__func__, live < 0 || live > hwsamples)) {
-        dolog ("live=3D%d hw->samples=3D%d\n", live, hwsamples);
+    if (audio_bug(__func__, live > hwsamples)) {
+        dolog("live=3D%zu hw->samples=3D%zu\n", live, hwsamples);
         return 0;
     }
=20
@@ -763,7 +758,7 @@ static int audio_pcm_sw_write(SWVoiceOut *sw, void *b=
uf, int size)
=20
 #ifdef DEBUG_OUT
     dolog (
-        "%s: write size %d ret %d total sw %d\n",
+        "%s: write size %zu ret %zu total sw %zu\n",
         SW_NAME (sw),
         size >> sw->info.shift,
         ret,
@@ -842,7 +837,7 @@ static void audio_timer (void *opaque)
 /*
  * Public API
  */
-int AUD_write (SWVoiceOut *sw, void *buf, int size)
+size_t AUD_write(SWVoiceOut *sw, void *buf, size_t size)
 {
     if (!sw) {
         /* XXX: Consider options */
@@ -857,7 +852,7 @@ int AUD_write (SWVoiceOut *sw, void *buf, int size)
     return audio_pcm_sw_write(sw, buf, size);
 }
=20
-int AUD_read (SWVoiceIn *sw, void *buf, int size)
+size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
 {
     if (!sw) {
         /* XXX: Consider options */
@@ -966,17 +961,17 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
     }
 }
=20
-static int audio_get_avail (SWVoiceIn *sw)
+static size_t audio_get_avail (SWVoiceIn *sw)
 {
-    int live;
+    size_t live;
=20
     if (!sw) {
         return 0;
     }
=20
     live =3D sw->hw->total_samples_captured - sw->total_hw_samples_acqui=
red;
-    if (audio_bug(__func__, live < 0 || live > sw->hw->samples)) {
-        dolog ("live=3D%d sw->hw->samples=3D%d\n", live, sw->hw->samples=
);
+    if (audio_bug(__func__, live > sw->hw->samples)) {
+        dolog("live=3D%zu sw->hw->samples=3D%zu\n", live, sw->hw->sample=
s);
         return 0;
     }
=20
@@ -989,9 +984,9 @@ static int audio_get_avail (SWVoiceIn *sw)
     return (((int64_t) live << 32) / sw->ratio) << sw->info.shift;
 }
=20
-static int audio_get_free (SWVoiceOut *sw)
+static size_t audio_get_free(SWVoiceOut *sw)
 {
-    int live, dead;
+    size_t live, dead;
=20
     if (!sw) {
         return 0;
@@ -999,8 +994,8 @@ static int audio_get_free (SWVoiceOut *sw)
=20
     live =3D sw->total_hw_samples_mixed;
=20
-    if (audio_bug(__func__, live < 0 || live > sw->hw->samples)) {
-        dolog ("live=3D%d sw->hw->samples=3D%d\n", live, sw->hw->samples=
);
+    if (audio_bug(__func__, live > sw->hw->samples)) {
+        dolog("live=3D%zu sw->hw->samples=3D%zu\n", live, sw->hw->sample=
s);
         return 0;
     }
=20
@@ -1015,9 +1010,10 @@ static int audio_get_free (SWVoiceOut *sw)
     return (((int64_t) dead << 32) / sw->ratio) << sw->info.shift;
 }
=20
-static void audio_capture_mix_and_clear (HWVoiceOut *hw, int rpos, int s=
amples)
+static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
+                                        size_t samples)
 {
-    int n;
+    size_t n;
=20
     if (hw->enabled) {
         SWVoiceCap *sc;
@@ -1028,17 +1024,17 @@ static void audio_capture_mix_and_clear (HWVoiceO=
ut *hw, int rpos, int samples)
=20
             n =3D samples;
             while (n) {
-                int till_end_of_hw =3D hw->samples - rpos2;
-                int to_write =3D MIN (till_end_of_hw, n);
-                int bytes =3D to_write << hw->info.shift;
-                int written;
+                size_t till_end_of_hw =3D hw->samples - rpos2;
+                size_t to_write =3D MIN(till_end_of_hw, n);
+                size_t bytes =3D to_write << hw->info.shift;
+                size_t written;
=20
                 sw->buf =3D hw->mix_buf + rpos2;
                 written =3D audio_pcm_sw_write (sw, NULL, bytes);
                 if (written - bytes) {
-                    dolog ("Could not mix %d bytes into a capture "
-                           "buffer, mixed %d\n",
-                           bytes, written);
+                    dolog("Could not mix %zu bytes into a capture "
+                          "buffer, mixed %zu\n",
+                          bytes, written);
                     break;
                 }
                 n -=3D to_write;
@@ -1047,9 +1043,9 @@ static void audio_capture_mix_and_clear (HWVoiceOut=
 *hw, int rpos, int samples)
         }
     }
=20
-    n =3D MIN (samples, hw->samples - rpos);
-    mixeng_clear (hw->mix_buf + rpos, n);
-    mixeng_clear (hw->mix_buf, samples - n);
+    n =3D MIN(samples, hw->samples - rpos);
+    mixeng_clear(hw->mix_buf + rpos, n);
+    mixeng_clear(hw->mix_buf, samples - n);
 }
=20
 static void audio_run_out (AudioState *s)
@@ -1058,16 +1054,16 @@ static void audio_run_out (AudioState *s)
     SWVoiceOut *sw;
=20
     while ((hw =3D audio_pcm_hw_find_any_enabled_out(s, hw))) {
-        int played;
-        int live, free, nb_live, cleanup_required, prev_rpos;
+        size_t played, live, prev_rpos, free;
+        int nb_live, cleanup_required;
=20
         live =3D audio_pcm_hw_get_live_out (hw, &nb_live);
         if (!nb_live) {
             live =3D 0;
         }
=20
-        if (audio_bug(__func__, live < 0 || live > hw->samples)) {
-            dolog ("live=3D%d hw->samples=3D%d\n", live, hw->samples);
+        if (audio_bug(__func__, live > hw->samples)) {
+            dolog ("live=3D%zu hw->samples=3D%zu\n", live, hw->samples);
             continue;
         }
=20
@@ -1102,13 +1098,13 @@ static void audio_run_out (AudioState *s)
         played =3D hw->pcm_ops->run_out (hw, live);
         replay_audio_out(&played);
         if (audio_bug(__func__, hw->rpos >=3D hw->samples)) {
-            dolog ("hw->rpos=3D%d hw->samples=3D%d played=3D%d\n",
-                   hw->rpos, hw->samples, played);
+            dolog("hw->rpos=3D%zu hw->samples=3D%zu played=3D%zu\n",
+                  hw->rpos, hw->samples, played);
             hw->rpos =3D 0;
         }
=20
 #ifdef DEBUG_OUT
-        dolog ("played=3D%d\n", played);
+        dolog("played=3D%zu\n", played);
 #endif
=20
         if (played) {
@@ -1123,8 +1119,8 @@ static void audio_run_out (AudioState *s)
             }
=20
             if (audio_bug(__func__, played > sw->total_hw_samples_mixed)=
) {
-                dolog ("played=3D%d sw->total_hw_samples_mixed=3D%d\n",
-                       played, sw->total_hw_samples_mixed);
+                dolog("played=3D%zu sw->total_hw_samples_mixed=3D%zu\n",
+                      played, sw->total_hw_samples_mixed);
                 played =3D sw->total_hw_samples_mixed;
             }
=20
@@ -1164,7 +1160,7 @@ static void audio_run_in (AudioState *s)
=20
     while ((hw =3D audio_pcm_hw_find_any_enabled_in(s, hw))) {
         SWVoiceIn *sw;
-        int captured =3D 0, min;
+        size_t captured =3D 0, min;
=20
         if (replay_mode !=3D REPLAY_MODE_PLAY) {
             captured =3D hw->pcm_ops->run_in(hw);
@@ -1179,7 +1175,7 @@ static void audio_run_in (AudioState *s)
             sw->total_hw_samples_acquired -=3D min;
=20
             if (sw->active) {
-                int avail;
+                size_t avail;
=20
                 avail =3D audio_get_avail (sw);
                 if (avail > 0) {
@@ -1195,15 +1191,15 @@ static void audio_run_capture (AudioState *s)
     CaptureVoiceOut *cap;
=20
     for (cap =3D s->cap_head.lh_first; cap; cap =3D cap->entries.le_next=
) {
-        int live, rpos, captured;
+        size_t live, rpos, captured;
         HWVoiceOut *hw =3D &cap->hw;
         SWVoiceOut *sw;
=20
         captured =3D live =3D audio_pcm_hw_get_live_out (hw, NULL);
         rpos =3D hw->rpos;
         while (live) {
-            int left =3D hw->samples - rpos;
-            int to_capture =3D MIN (live, left);
+            size_t left =3D hw->samples - rpos;
+            size_t to_capture =3D MIN(live, left);
             struct st_sample *src;
             struct capture_callback *cb;
=20
@@ -1226,8 +1222,8 @@ static void audio_run_capture (AudioState *s)
             }
=20
             if (audio_bug(__func__, captured > sw->total_hw_samples_mixe=
d)) {
-                dolog ("captured=3D%d sw->total_hw_samples_mixed=3D%d\n"=
,
-                       captured, sw->total_hw_samples_mixed);
+                dolog("captured=3D%zu sw->total_hw_samples_mixed=3D%zu\n=
",
+                      captured, sw->total_hw_samples_mixed);
                 captured =3D sw->total_hw_samples_mixed;
             }
=20
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 091fe84a343a..d1be58b40aa8 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -43,9 +43,9 @@ typedef struct coreaudioVoiceOut {
     UInt32 audioDevicePropertyBufferFrameSize;
     AudioStreamBasicDescription outputStreamBasicDescription;
     AudioDeviceIOProcID ioprocid;
-    int live;
-    int decr;
-    int rpos;
+    size_t live;
+    size_t decr;
+    size_t rpos;
 } coreaudioVoiceOut;
=20
 #if MAC_OS_X_VERSION_MAX_ALLOWED >=3D MAC_OS_X_VERSION_10_6
@@ -397,9 +397,9 @@ static int coreaudio_unlock (coreaudioVoiceOut *core,=
 const char *fn_name)
     return 0;
 }
=20
-static int coreaudio_run_out (HWVoiceOut *hw, int live)
+static size_t coreaudio_run_out(HWVoiceOut *hw, size_t live)
 {
-    int decr;
+    size_t decr;
     coreaudioVoiceOut *core =3D (coreaudioVoiceOut *) hw;
=20
     if (coreaudio_lock (core, "coreaudio_run_out")) {
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 11594c3095bf..67aa1d0ad55e 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -454,19 +454,20 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd,=
 ...)
     return 0;
 }
=20
-static int dsound_run_out (HWVoiceOut *hw, int live)
+static size_t dsound_run_out(HWVoiceOut *hw, size_t live)
 {
     int err;
     HRESULT hr;
     DSoundVoiceOut *ds =3D (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb =3D ds->dsound_buffer;
-    int len, hwshift;
+    size_t len;
+    int hwshift;
     DWORD blen1, blen2;
     DWORD len1, len2;
     DWORD decr;
     DWORD wpos, ppos, old_pos;
     LPVOID p1, p2;
-    int bufsize;
+    size_t bufsize;
     dsound *s =3D ds->s;
     AudiodevDsoundOptions *dso =3D &s->dev->u.dsound;
=20
@@ -640,13 +641,13 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, .=
..)
     return 0;
 }
=20
-static int dsound_run_in (HWVoiceIn *hw)
+static size_t dsound_run_in(HWVoiceIn *hw)
 {
     int err;
     HRESULT hr;
     DSoundVoiceIn *ds =3D (DSoundVoiceIn *) hw;
     LPDIRECTSOUNDCAPTUREBUFFER dscb =3D ds->dsound_capture_buffer;
-    int live, len, dead;
+    size_t live, len, dead;
     DWORD blen1, blen2;
     DWORD len1, len2;
     DWORD decr;
diff --git a/audio/noaudio.c b/audio/noaudio.c
index cbb02d9e49a7..0fb2629cf283 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -41,10 +41,10 @@ typedef struct NoVoiceIn {
     int64_t old_ticks;
 } NoVoiceIn;
=20
-static int no_run_out (HWVoiceOut *hw, int live)
+static size_t no_run_out(HWVoiceOut *hw, size_t live)
 {
     NoVoiceOut *no =3D (NoVoiceOut *) hw;
-    int decr, samples;
+    size_t decr, samples;
     int64_t now;
     int64_t ticks;
     int64_t bytes;
@@ -52,7 +52,7 @@ static int no_run_out (HWVoiceOut *hw, int live)
     now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ticks =3D now - no->old_ticks;
     bytes =3D muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER=
_SECOND);
-    bytes =3D MIN(bytes, INT_MAX);
+    bytes =3D MIN(bytes, SIZE_MAX);
     samples =3D bytes >> hw->info.shift;
=20
     no->old_ticks =3D now;
@@ -92,12 +92,12 @@ static void no_fini_in (HWVoiceIn *hw)
     (void) hw;
 }
=20
-static int no_run_in (HWVoiceIn *hw)
+static size_t no_run_in(HWVoiceIn *hw)
 {
     NoVoiceIn *no =3D (NoVoiceIn *) hw;
-    int live =3D audio_pcm_hw_get_live_in (hw);
-    int dead =3D hw->samples - live;
-    int samples =3D 0;
+    size_t live =3D audio_pcm_hw_get_live_in(hw);
+    size_t dead =3D hw->samples - live;
+    size_t samples =3D 0;
=20
     if (dead) {
         int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -106,7 +106,7 @@ static int no_run_in (HWVoiceIn *hw)
             muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_S=
ECOND);
=20
         no->old_ticks =3D now;
-        bytes =3D MIN (bytes, INT_MAX);
+        bytes =3D MIN (bytes, SIZE_MAX);
         samples =3D bytes >> hw->info.shift;
         samples =3D MIN (samples, dead);
     }
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index b99edbec176f..169693368886 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -411,13 +411,14 @@ static void oss_write_pending (OSSVoiceOut *oss)
     }
 }
=20
-static int oss_run_out (HWVoiceOut *hw, int live)
+static size_t oss_run_out(HWVoiceOut *hw, size_t live)
 {
     OSSVoiceOut *oss =3D (OSSVoiceOut *) hw;
-    int err, decr;
+    int err;
+    size_t decr;
     struct audio_buf_info abinfo;
     struct count_info cntinfo;
-    int bufsize;
+    size_t bufsize;
=20
     bufsize =3D hw->samples << hw->info.shift;
=20
@@ -476,8 +477,8 @@ static void oss_fini_out (HWVoiceOut *hw)
         if (oss->mmapped) {
             err =3D munmap (oss->pcm_buf, hw->samples << hw->info.shift)=
;
             if (err) {
-                oss_logerr (errno, "Failed to unmap buffer %p, size %d\n=
",
-                            oss->pcm_buf, hw->samples << hw->info.shift)=
;
+                oss_logerr(errno, "Failed to unmap buffer %p, size %zu\n=
",
+                           oss->pcm_buf, hw->samples << hw->info.shift);
             }
         }
         else {
@@ -543,8 +544,8 @@ static int oss_init_out(HWVoiceOut *hw, struct audset=
tings *as,
             0
             );
         if (oss->pcm_buf =3D=3D MAP_FAILED) {
-            oss_logerr (errno, "Failed to map %d bytes of DAC\n",
-                        hw->samples << hw->info.shift);
+            oss_logerr(errno, "Failed to map %zu bytes of DAC\n",
+                       hw->samples << hw->info.shift);
         }
         else {
             int err;
@@ -568,8 +569,8 @@ static int oss_init_out(HWVoiceOut *hw, struct audset=
tings *as,
             if (!oss->mmapped) {
                 err =3D munmap (oss->pcm_buf, hw->samples << hw->info.sh=
ift);
                 if (err) {
-                    oss_logerr (errno, "Failed to unmap buffer %p size %=
d\n",
-                                oss->pcm_buf, hw->samples << hw->info.sh=
ift);
+                    oss_logerr(errno, "Failed to unmap buffer %p size %z=
u\n",
+                               oss->pcm_buf, hw->samples << hw->info.shi=
ft);
                 }
             }
         }
@@ -581,7 +582,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audset=
tings *as,
                                     1 << hw->info.shift);
         if (!oss->pcm_buf) {
             dolog (
-                "Could not allocate DAC buffer (%d samples, each %d byte=
s)\n",
+                "Could not allocate DAC buffer (%zu samples, each %d byt=
es)\n",
                 hw->samples,
                 1 << hw->info.shift
                 );
@@ -693,8 +694,8 @@ static int oss_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
     hw->samples =3D (obt.nfrags * obt.fragsize) >> hw->info.shift;
     oss->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.s=
hift);
     if (!oss->pcm_buf) {
-        dolog ("Could not allocate ADC buffer (%d samples, each %d bytes=
)\n",
-               hw->samples, 1 << hw->info.shift);
+        dolog("Could not allocate ADC buffer (%zu samples, each %d bytes=
)\n",
+              hw->samples, 1 << hw->info.shift);
         oss_anal_close (&fd);
         return -1;
     }
@@ -714,17 +715,17 @@ static void oss_fini_in (HWVoiceIn *hw)
     oss->pcm_buf =3D NULL;
 }
=20
-static int oss_run_in (HWVoiceIn *hw)
+static size_t oss_run_in(HWVoiceIn *hw)
 {
     OSSVoiceIn *oss =3D (OSSVoiceIn *) hw;
     int hwshift =3D hw->info.shift;
     int i;
-    int live =3D audio_pcm_hw_get_live_in (hw);
-    int dead =3D hw->samples - live;
+    size_t live =3D audio_pcm_hw_get_live_in (hw);
+    size_t dead =3D hw->samples - live;
     size_t read_samples =3D 0;
     struct {
-        int add;
-        int len;
+        size_t add;
+        size_t len;
     } bufs[2] =3D {
         { .add =3D hw->wpos, .len =3D 0 },
         { .add =3D 0,        .len =3D 0 }
@@ -751,9 +752,9 @@ static int oss_run_in (HWVoiceIn *hw)
=20
             if (nread > 0) {
                 if (nread & hw->info.align) {
-                    dolog ("warning: Misaligned read %zd (requested %d),=
 "
-                           "alignment %d\n", nread, bufs[i].add << hwshi=
ft,
-                           hw->info.align + 1);
+                    dolog("warning: Misaligned read %zd (requested %zu),=
 "
+                          "alignment %d\n", nread, bufs[i].add << hwshif=
t,
+                          hw->info.align + 1);
                 }
                 read_samples +=3D nread >> hwshift;
                 hw->conv (hw->conv_buf + bufs[i].add, p, nread >> hwshif=
t);
@@ -766,9 +767,9 @@ static int oss_run_in (HWVoiceIn *hw)
                     case EAGAIN:
                         break;
                     default:
-                        oss_logerr (
+                        oss_logerr(
                             errno,
-                            "Failed to read %d bytes of audio (to %p)\n"=
,
+                            "Failed to read %zu bytes of audio (to %p)\n=
",
                             bufs[i].len, p
                             );
                         break;
diff --git a/audio/paaudio.c b/audio/paaudio.c
index efb72ced30aa..bfef9acaadd0 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -30,30 +30,30 @@ typedef struct {
=20
 typedef struct {
     HWVoiceOut hw;
-    int done;
-    int live;
-    int decr;
-    int rpos;
+    size_t done;
+    size_t live;
+    size_t decr;
+    size_t rpos;
     pa_stream *stream;
     void *pcm_buf;
     struct audio_pt pt;
     paaudio *g;
-    int samples;
+    size_t samples;
 } PAVoiceOut;
=20
 typedef struct {
     HWVoiceIn hw;
-    int done;
-    int dead;
-    int incr;
-    int wpos;
+    size_t done;
+    size_t dead;
+    size_t incr;
+    size_t wpos;
     pa_stream *stream;
     void *pcm_buf;
     struct audio_pt pt;
     const void *read_data;
     size_t read_index, read_length;
     paaudio *g;
-    int samples;
+    size_t samples;
 } PAVoiceIn;
=20
 static void qpa_conn_fini(PAConnection *c);
@@ -219,7 +219,7 @@ static void *qpa_thread_out (void *arg)
     }
=20
     for (;;) {
-        int decr, to_mix, rpos;
+        size_t decr, to_mix, rpos;
=20
         for (;;) {
             if (pa->done) {
@@ -244,7 +244,7 @@ static void *qpa_thread_out (void *arg)
=20
         while (to_mix) {
             int error;
-            int chunk =3D MIN (to_mix, hw->samples - rpos);
+            size_t chunk =3D MIN (to_mix, hw->samples - rpos);
             struct st_sample *src =3D hw->mix_buf + rpos;
=20
             hw->clip (pa->pcm_buf, src, chunk);
@@ -273,9 +273,9 @@ static void *qpa_thread_out (void *arg)
     return NULL;
 }
=20
-static int qpa_run_out (HWVoiceOut *hw, int live)
+static size_t qpa_run_out(HWVoiceOut *hw, size_t live)
 {
-    int decr;
+    size_t decr;
     PAVoiceOut *pa =3D (PAVoiceOut *) hw;
=20
     if (audio_pt_lock(&pa->pt, __func__)) {
@@ -306,7 +306,7 @@ static void *qpa_thread_in (void *arg)
     }
=20
     for (;;) {
-        int incr, to_grab, wpos;
+        size_t incr, to_grab, wpos;
=20
         for (;;) {
             if (pa->done) {
@@ -331,7 +331,7 @@ static void *qpa_thread_in (void *arg)
=20
         while (to_grab) {
             int error;
-            int chunk =3D MIN (to_grab, hw->samples - wpos);
+            size_t chunk =3D MIN (to_grab, hw->samples - wpos);
             void *buf =3D advance (pa->pcm_buf, wpos);
=20
             if (qpa_simple_read (pa, buf,
@@ -359,9 +359,9 @@ static void *qpa_thread_in (void *arg)
     return NULL;
 }
=20
-static int qpa_run_in (HWVoiceIn *hw)
+static size_t qpa_run_in(HWVoiceIn *hw)
 {
-    int live, incr, dead;
+    size_t live, incr, dead;
     PAVoiceIn *pa =3D (PAVoiceIn *) hw;
=20
     if (audio_pt_lock(&pa->pt, __func__)) {
@@ -582,8 +582,8 @@ static int qpa_init_out(HWVoiceOut *hw, struct audset=
tings *as,
     pa->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.sh=
ift);
     pa->rpos =3D hw->rpos;
     if (!pa->pcm_buf) {
-        dolog ("Could not allocate buffer (%d bytes)\n",
-               hw->samples << hw->info.shift);
+        dolog("Could not allocate buffer (%zu bytes)\n",
+              hw->samples << hw->info.shift);
         goto fail2;
     }
=20
@@ -650,8 +650,8 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
     pa->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.sh=
ift);
     pa->wpos =3D hw->wpos;
     if (!pa->pcm_buf) {
-        dolog ("Could not allocate buffer (%d bytes)\n",
-               hw->samples << hw->info.shift);
+        dolog("Could not allocate buffer (%zu bytes)\n",
+              hw->samples << hw->info.shift);
         goto fail2;
     }
=20
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index c7fd487e0ed3..14b11f033521 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -41,8 +41,8 @@
=20
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
-    int live;
-    int decr;
+    size_t live;
+    size_t decr;
 } SDLVoiceOut;
=20
 static struct SDLAudioState {
@@ -184,22 +184,22 @@ static void sdl_callback (void *opaque, Uint8 *buf,=
 int len)
     SDLVoiceOut *sdl =3D opaque;
     SDLAudioState *s =3D &glob_sdl;
     HWVoiceOut *hw =3D &sdl->hw;
-    int samples =3D len >> hw->info.shift;
-    int to_mix, decr;
+    size_t samples =3D len >> hw->info.shift;
+    size_t to_mix, decr;
=20
     if (s->exit || !sdl->live) {
         return;
     }
=20
-    /* dolog ("in callback samples=3D%d live=3D%d\n", samples, sdl->live=
); */
+    /* dolog ("in callback samples=3D%zu live=3D%zu\n", samples, sdl->li=
ve); */
=20
     to_mix =3D MIN(samples, sdl->live);
     decr =3D to_mix;
     while (to_mix) {
-        int chunk =3D MIN(to_mix, hw->samples - hw->rpos);
+        size_t chunk =3D MIN(to_mix, hw->samples - hw->rpos);
         struct st_sample *src =3D hw->mix_buf + hw->rpos;
=20
-        /* dolog ("in callback to_mix %d, chunk %d\n", to_mix, chunk); *=
/
+        /* dolog ("in callback to_mix %zu, chunk %zu\n", to_mix, chunk);=
 */
         hw->clip(buf, src, chunk);
         hw->rpos =3D (hw->rpos + chunk) % hw->samples;
         to_mix -=3D chunk;
@@ -209,7 +209,7 @@ static void sdl_callback (void *opaque, Uint8 *buf, i=
nt len)
     sdl->live -=3D decr;
     sdl->decr +=3D decr;
=20
-    /* dolog ("done len=3D%d\n", len); */
+    /* dolog ("done len=3D%zu\n", len); */
=20
     /* SDL2 does not clear the remaining buffer for us, so do it on our =
own */
     if (samples) {
@@ -217,9 +217,9 @@ static void sdl_callback (void *opaque, Uint8 *buf, i=
nt len)
     }
 }
=20
-static int sdl_run_out (HWVoiceOut *hw, int live)
+static size_t sdl_run_out(HWVoiceOut *hw, size_t live)
 {
-    int decr;
+    size_t decr;
     SDLVoiceOut *sdl =3D (SDLVoiceOut *) hw;
=20
     SDL_LockAudio();
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 6e7f13cffab5..d9db1a39e6b1 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -153,11 +153,11 @@ static void line_out_fini (HWVoiceOut *hw)
     spice_server_remove_interface (&out->sin.base);
 }
=20
-static int line_out_run (HWVoiceOut *hw, int live)
+static size_t line_out_run (HWVoiceOut *hw, size_t live)
 {
     SpiceVoiceOut *out =3D container_of (hw, SpiceVoiceOut, hw);
-    int rpos, decr;
-    int samples;
+    size_t rpos, decr;
+    size_t samples;
=20
     if (!live) {
         return 0;
@@ -276,12 +276,12 @@ static void line_in_fini (HWVoiceIn *hw)
     spice_server_remove_interface (&in->sin.base);
 }
=20
-static int line_in_run (HWVoiceIn *hw)
+static size_t line_in_run(HWVoiceIn *hw)
 {
     SpiceVoiceIn *in =3D container_of (hw, SpiceVoiceIn, hw);
-    int num_samples;
+    size_t num_samples;
     int ready;
-    int len[2];
+    size_t len[2];
     uint64_t delta_samp;
     const uint32_t *samples;
=20
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 17ab921cef85..b6eeeb4e26ef 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -40,10 +40,10 @@ typedef struct WAVVoiceOut {
     int total_samples;
 } WAVVoiceOut;
=20
-static int wav_run_out (HWVoiceOut *hw, int live)
+static size_t wav_run_out(HWVoiceOut *hw, size_t live)
 {
     WAVVoiceOut *wav =3D (WAVVoiceOut *) hw;
-    int rpos, decr, samples;
+    size_t rpos, decr, samples;
     uint8_t *dst;
     struct st_sample *src;
     int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -139,8 +139,8 @@ static int wav_init_out(HWVoiceOut *hw, struct audset=
tings *as,
     hw->samples =3D 1024;
     wav->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.s=
hift);
     if (!wav->pcm_buf) {
-        dolog ("Could not allocate buffer (%d bytes)\n",
-               hw->samples << hw->info.shift);
+        dolog("Could not allocate buffer (%zu bytes)\n",
+              hw->samples << hw->info.shift);
         return -1;
     }
=20
diff --git a/replay/replay-audio.c b/replay/replay-audio.c
index b113836de497..efe1628727ef 100644
--- a/replay/replay-audio.c
+++ b/replay/replay-audio.c
@@ -16,18 +16,18 @@
 #include "sysemu/sysemu.h"
 #include "audio/audio.h"
=20
-void replay_audio_out(int *played)
+void replay_audio_out(size_t *played)
 {
     if (replay_mode =3D=3D REPLAY_MODE_RECORD) {
         g_assert(replay_mutex_locked());
         replay_save_instructions();
         replay_put_event(EVENT_AUDIO_OUT);
-        replay_put_dword(*played);
+        replay_put_qword(*played);
     } else if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
         g_assert(replay_mutex_locked());
         replay_account_executed_instructions();
         if (replay_next_event_is(EVENT_AUDIO_OUT)) {
-            *played =3D replay_get_dword();
+            *played =3D replay_get_qword();
             replay_finish_event();
         } else {
             error_report("Missing audio out event in the replay log");
@@ -36,7 +36,7 @@ void replay_audio_out(int *played)
     }
 }
=20
-void replay_audio_in(int *recorded, void *samples, int *wpos, int size)
+void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size=
_t size)
 {
     int pos;
     uint64_t left, right;
@@ -44,8 +44,8 @@ void replay_audio_in(int *recorded, void *samples, int =
*wpos, int size)
         g_assert(replay_mutex_locked());
         replay_save_instructions();
         replay_put_event(EVENT_AUDIO_IN);
-        replay_put_dword(*recorded);
-        replay_put_dword(*wpos);
+        replay_put_qword(*recorded);
+        replay_put_qword(*wpos);
         for (pos =3D (*wpos - *recorded + size) % size ; pos !=3D *wpos
              ; pos =3D (pos + 1) % size) {
             audio_sample_to_uint64(samples, pos, &left, &right);
@@ -56,8 +56,8 @@ void replay_audio_in(int *recorded, void *samples, int =
*wpos, int size)
         g_assert(replay_mutex_locked());
         replay_account_executed_instructions();
         if (replay_next_event_is(EVENT_AUDIO_IN)) {
-            *recorded =3D replay_get_dword();
-            *wpos =3D replay_get_dword();
+            *recorded =3D replay_get_qword();
+            *wpos =3D replay_get_qword();
             for (pos =3D (*wpos - *recorded + size) % size ; pos !=3D *w=
pos
                  ; pos =3D (pos + 1) % size) {
                 left =3D replay_get_qword();
diff --git a/replay/replay.c b/replay/replay.c
index 8b172b2d1bee..a1135a994304 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -22,7 +22,7 @@
=20
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
-#define REPLAY_VERSION              0xe02007
+#define REPLAY_VERSION              0xe02008
 /* Size of replay log header */
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t)=
)
=20
--=20
2.18.1


