Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C922C4360D
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046DE216C8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJwP9RhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046DE216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74pI-0006qu-GH
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74e1-0005aZ-PD
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dw-0005r5-Pq
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:49 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:41465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74dw-0005qk-Dh
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:44 -0400
Received: by mail-qt1-x841.google.com with SMTP id j10so13799677qtp.8
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LdkV7peYWx1TqeZs/I0YDxW+2RxSR3SIi+AOG130o8Q=;
 b=PJwP9RhIs/qjJ2xom6h1UF5rh+XBzXBRACJ4mUIi/HhJk/VkIBjnFJDkD1TihJmzNQ
 I91B8edwYMfxKy1s3xqngNiJX1s0oF2/csb7tvL6hhkLQhjgUmzFUxZ4forb/29E+UrQ
 +Fs5N/JwGSUlmGpqBT4CvYJ4V3U8RsTAYzXmbQgJm2NaJc0bWm4kj0KYrjwvJyO5tWSv
 Rtehxf8vbMs407XXHc6Mc5zbsQ8RPwKfLi6d0USmBwtkqJA0h1zo/9ngQNEtz1zAVBOF
 XeLGjKkT3uPJWA3I8HdCPXobh+5jE+AgauyhhPHdHKHJwzUdZ3AogFy9+N7Jn7bQA+LQ
 pXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LdkV7peYWx1TqeZs/I0YDxW+2RxSR3SIi+AOG130o8Q=;
 b=B85xC+M6IWrQ2+XNSS9F83UyGv3Woz6isFVqwxj6x4/xbnf+6G/MNHLA+9RRzBMQwA
 9mBNiqAopye08n4nlZDdiX5Yi9UVu/763ID4jhKmU/64UdvAuwwjZ0NUM+JlVXhS8g6N
 z35xYKFywRBVk1A74jxhxQEwcFXF1ISrKreW7TrxEtW3ISRlrj+19d1ygmBegpjk7Sym
 VhpzQ+71+iwZHSVRuRwCZ3XGlbzmd4JJLZsg4NrDrweAr6tJ3Mg9fJaskyyq8ShZsvyp
 BgZXElEzf8QvQjTJEi6bO0gXmS59mBpB9UjSg1xQDqE5SGJhaSyzIdqN9iwTRVarcA3k
 dp5Q==
X-Gm-Message-State: APjAAAXhnnO7npVw44pDWb11oGFNc5LVMG2xUHUCmQpmfJQOE3NWLIkj
 spRt4Hap/wi69ZWa3kER0DXFEuSP
X-Google-Smtp-Source: APXvYqxtIR/M3BrC+2IPXjg/BtE9dNq49eMJw0Yig4PN+z5nnysm2F02G0ciYeFWF39aoGA4S8PDGA==
X-Received: by 2002:ac8:27c4:: with SMTP id x4mr20686831qtx.69.1567977762918; 
 Sun, 08 Sep 2019 14:22:42 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:42 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:14 +0200
Message-Id: <955e758adbfb8d155d923b1d69af272923b5d389.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v2 14/24] audio: split ctl_* functions into
 enable_* and volume_*
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This way we no longer need vararg functions, improving compile time
error detection.  Also now it's possible to check actually what commands
are supported, without needing to manually update ctl_caps.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/alsaaudio.c      |  62 ++++++++----------
 audio/audio.c          |  45 ++++++++-----
 audio/audio_int.h      |  15 ++---
 audio/audio_template.h |   1 -
 audio/coreaudio.c      |  13 ++--
 audio/dsoundaudio.c    |  50 ++++++---------
 audio/noaudio.c        |  14 ++---
 audio/ossaudio.c       |  79 +++++++++--------------
 audio/paaudio.c        | 139 +++++++++++++++++------------------------
 audio/sdlaudio.c       |  17 +----
 audio/spiceaudio.c     | 102 +++++++++++++-----------------
 audio/wavaudio.c       |   7 +--
 12 files changed, 223 insertions(+), 321 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 19124d09d8..cfe42284a6 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -731,34 +731,28 @@ static int alsa_voice_ctl (snd_pcm_t *handle, const char *typ, int ctl)
     return 0;
 }
 
-static int alsa_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void alsa_enable_out(HWVoiceOut *hw, bool enable)
 {
     ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
     AudiodevAlsaPerDirectionOptions *apdo = alsa->dev->u.alsa.out;
 
-    switch (cmd) {
-    case VOICE_ENABLE:
-        {
-            bool poll_mode = apdo->try_poll;
+    if (enable) {
+        bool poll_mode = apdo->try_poll;
 
-            ldebug ("enabling voice\n");
-            if (poll_mode && alsa_poll_out (hw)) {
-                poll_mode = 0;
-            }
-            hw->poll_mode = poll_mode;
-            return alsa_voice_ctl (alsa->handle, "playback", VOICE_CTL_PREPARE);
+        ldebug("enabling voice\n");
+        if (poll_mode && alsa_poll_out(hw)) {
+            poll_mode = 0;
         }
-
-    case VOICE_DISABLE:
-        ldebug ("disabling voice\n");
+        hw->poll_mode = poll_mode;
+        alsa_voice_ctl(alsa->handle, "playback", VOICE_CTL_PREPARE);
+    } else {
+        ldebug("disabling voice\n");
         if (hw->poll_mode) {
             hw->poll_mode = 0;
-            alsa_fini_poll (&alsa->pollhlp);
+            alsa_fini_poll(&alsa->pollhlp);
         }
-        return alsa_voice_ctl (alsa->handle, "playback", VOICE_CTL_PAUSE);
+        alsa_voice_ctl(alsa->handle, "playback", VOICE_CTL_PAUSE);
     }
-
-    return -1;
 }
 
 static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
@@ -841,35 +835,29 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
     return pos;
 }
 
-static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void alsa_enable_in(HWVoiceIn *hw, bool enable)
 {
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
     AudiodevAlsaPerDirectionOptions *apdo = alsa->dev->u.alsa.in;
 
-    switch (cmd) {
-    case VOICE_ENABLE:
-        {
-            bool poll_mode = apdo->try_poll;
+    if (enable) {
+        bool poll_mode = apdo->try_poll;
 
-            ldebug ("enabling voice\n");
-            if (poll_mode && alsa_poll_in (hw)) {
-                poll_mode = 0;
-            }
-            hw->poll_mode = poll_mode;
-
-            return alsa_voice_ctl (alsa->handle, "capture", VOICE_CTL_START);
+        ldebug("enabling voice\n");
+        if (poll_mode && alsa_poll_in(hw)) {
+            poll_mode = 0;
         }
+        hw->poll_mode = poll_mode;
 
-    case VOICE_DISABLE:
+        alsa_voice_ctl(alsa->handle, "capture", VOICE_CTL_START);
+    } else {
         ldebug ("disabling voice\n");
         if (hw->poll_mode) {
             hw->poll_mode = 0;
-            alsa_fini_poll (&alsa->pollhlp);
+            alsa_fini_poll(&alsa->pollhlp);
         }
-        return alsa_voice_ctl (alsa->handle, "capture", VOICE_CTL_PAUSE);
+        alsa_voice_ctl(alsa->handle, "capture", VOICE_CTL_PAUSE);
     }
-
-    return -1;
 }
 
 static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions *apdo)
@@ -924,12 +912,12 @@ static struct audio_pcm_ops alsa_pcm_ops = {
     .init_out = alsa_init_out,
     .fini_out = alsa_fini_out,
     .write    = alsa_write,
-    .ctl_out  = alsa_ctl_out,
+    .enable_out = alsa_enable_out,
 
     .init_in  = alsa_init_in,
     .fini_in  = alsa_fini_in,
     .read     = alsa_read,
-    .ctl_in   = alsa_ctl_in,
+    .enable_in = alsa_enable_in,
 };
 
 static struct audio_driver alsa_audio_driver = {
diff --git a/audio/audio.c b/audio/audio.c
index abecd1b771..6569ffceb9 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -636,7 +636,7 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t size)
         total += isamp;
     }
 
-    if (!(hw->ctl_caps & VOICE_VOLUME_CAP)) {
+    if (!hw->pcm_ops->volume_in) {
         mixeng_volume (sw->buf, ret, &sw->vol);
     }
 
@@ -723,7 +723,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t size)
     if (swlim) {
         sw->conv (sw->buf, buf, swlim);
 
-        if (!(sw->hw->ctl_caps & VOICE_VOLUME_CAP)) {
+        if (!sw->hw->pcm_ops->volume_out) {
             mixeng_volume (sw->buf, swlim, &sw->vol);
         }
     }
@@ -890,7 +890,9 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
             if (!hw->enabled) {
                 hw->enabled = 1;
                 if (s->vm_running) {
-                    hw->pcm_ops->ctl_out(hw, VOICE_ENABLE);
+                    if (hw->pcm_ops->enable_out) {
+                        hw->pcm_ops->enable_out(hw, true);
+                    }
                     audio_reset_timer (s);
                 }
             }
@@ -935,7 +937,9 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
             if (!hw->enabled) {
                 hw->enabled = 1;
                 if (s->vm_running) {
-                    hw->pcm_ops->ctl_in(hw, VOICE_ENABLE);
+                    if (hw->pcm_ops->enable_in) {
+                        hw->pcm_ops->enable_in(hw, true);
+                    }
                     audio_reset_timer (s);
                 }
             }
@@ -952,7 +956,9 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
 
                 if (nb_active == 1) {
                     hw->enabled = 0;
-                    hw->pcm_ops->ctl_in (hw, VOICE_DISABLE);
+                    if (hw->pcm_ops->enable_in) {
+                        hw->pcm_ops->enable_in(hw, false);
+                    }
                 }
             }
         }
@@ -1100,7 +1106,9 @@ static void audio_run_out (AudioState *s)
 #endif
             hw->enabled = 0;
             hw->pending_disable = 0;
-            hw->pcm_ops->ctl_out (hw, VOICE_DISABLE);
+            if (hw->pcm_ops->enable_out) {
+                hw->pcm_ops->enable_out(hw, false);
+            }
             for (sc = hw->cap_head.lh_first; sc; sc = sc->entries.le_next) {
                 sc->sw.active = 0;
                 audio_recalc_and_notify_capture (sc->cap);
@@ -1465,15 +1473,18 @@ static void audio_vm_change_state_handler (void *opaque, int running,
     AudioState *s = opaque;
     HWVoiceOut *hwo = NULL;
     HWVoiceIn *hwi = NULL;
-    int op = running ? VOICE_ENABLE : VOICE_DISABLE;
 
     s->vm_running = running;
     while ((hwo = audio_pcm_hw_find_any_enabled_out(s, hwo))) {
-        hwo->pcm_ops->ctl_out(hwo, op);
+        if (hwo->pcm_ops->enable_out) {
+            hwo->pcm_ops->enable_out(hwo, running);
+        }
     }
 
     while ((hwi = audio_pcm_hw_find_any_enabled_in(s, hwi))) {
-        hwi->pcm_ops->ctl_in(hwi, op);
+        if (hwi->pcm_ops->enable_in) {
+            hwi->pcm_ops->enable_in(hwi, running);
+        }
     }
     audio_reset_timer (s);
 }
@@ -1493,8 +1504,8 @@ static void free_audio_state(AudioState *s)
     QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
         SWVoiceCap *sc;
 
-        if (hwo->enabled) {
-            hwo->pcm_ops->ctl_out (hwo, VOICE_DISABLE);
+        if (hwo->enabled && hwo->pcm_ops->enable_out) {
+            hwo->pcm_ops->enable_out(hwo, false);
         }
         hwo->pcm_ops->fini_out (hwo);
 
@@ -1510,8 +1521,8 @@ static void free_audio_state(AudioState *s)
     }
 
     QLIST_FOREACH_SAFE(hwi, &s->hw_head_in, entries, hwin) {
-        if (hwi->enabled) {
-            hwi->pcm_ops->ctl_in (hwi, VOICE_DISABLE);
+        if (hwi->enabled && hwi->pcm_ops->enable_in) {
+            hwi->pcm_ops->enable_in(hwi, false);
         }
         hwi->pcm_ops->fini_in (hwi);
         QLIST_REMOVE(hwi, entries);
@@ -1833,8 +1844,8 @@ void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol)
         sw->vol.l = nominal_volume.l * lvol / 255;
         sw->vol.r = nominal_volume.r * rvol / 255;
 
-        if (hw->pcm_ops->ctl_out) {
-            hw->pcm_ops->ctl_out (hw, VOICE_VOLUME, sw);
+        if (hw->pcm_ops->volume_out) {
+            hw->pcm_ops->volume_out(hw, &sw->vol);
         }
     }
 }
@@ -1848,8 +1859,8 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
         sw->vol.l = nominal_volume.l * lvol / 255;
         sw->vol.r = nominal_volume.r * rvol / 255;
 
-        if (hw->pcm_ops->ctl_in) {
-            hw->pcm_ops->ctl_in (hw, VOICE_VOLUME, sw);
+        if (hw->pcm_ops->volume_in) {
+            hw->pcm_ops->volume_in(hw, &sw->vol);
         }
     }
 }
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 778615ccaf..22a703c13e 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -74,7 +74,6 @@ typedef struct HWVoiceOut {
     size_t samples;
     QLIST_HEAD (sw_out_listhead, SWVoiceOut) sw_head;
     QLIST_HEAD (sw_cap_listhead, SWVoiceCap) cap_head;
-    int ctl_caps;
     struct audio_pcm_ops *pcm_ops;
     QLIST_ENTRY (HWVoiceOut) entries;
 } HWVoiceOut;
@@ -96,7 +95,6 @@ typedef struct HWVoiceIn {
 
     size_t samples;
     QLIST_HEAD (sw_in_listhead, SWVoiceIn) sw_head;
-    int ctl_caps;
     struct audio_pcm_ops *pcm_ops;
     QLIST_ENTRY (HWVoiceIn) entries;
 } HWVoiceIn;
@@ -148,7 +146,6 @@ struct audio_driver {
     int max_voices_in;
     int voice_size_out;
     int voice_size_in;
-    int ctl_caps;
     QLIST_ENTRY(audio_driver) next;
 };
 
@@ -168,14 +165,16 @@ struct audio_pcm_ops {
      * size may be smaller
      */
     size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
-    int    (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
+    void   (*enable_out)(HWVoiceOut *hw, bool enable);
+    void   (*volume_out)(HWVoiceOut *hw, struct mixeng_volume *vol);
 
     int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
     void   (*fini_in) (HWVoiceIn *hw);
     size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
     void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
     void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
-    int    (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
+    void   (*enable_in)(HWVoiceIn *hw, bool enable);
+    void   (*volume_in)(HWVoiceIn *hw, struct mixeng_volume *vol);
 };
 
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
@@ -251,12 +250,6 @@ void audio_rate_start(RateCtl *rate);
 size_t audio_rate_get_bytes(struct audio_pcm_info *info, RateCtl *rate,
                             size_t bytes_avail);
 
-#define VOICE_ENABLE 1
-#define VOICE_DISABLE 2
-#define VOICE_VOLUME 3
-
-#define VOICE_VOLUME_CAP (1 << VOICE_VOLUME)
-
 static inline size_t audio_ring_dist(size_t dst, size_t src, size_t len)
 {
     return (dst >= src) ? (dst - src) : (len - src + dst);
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 87c6d2d271..235d1acbbe 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -254,7 +254,6 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
 
     hw->s = s;
     hw->pcm_ops = drv->pcm_ops;
-    hw->ctl_caps = drv->ctl_caps;
 
     QLIST_INIT (&hw->sw_head);
 #ifdef DAC
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 5cde42f982..1427c9f622 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -648,13 +648,12 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
     }
 }
 
-static int coreaudio_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
 {
     OSStatus status;
     coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
 
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         /* start playback */
         if (!isPlaying(core->outputDeviceID)) {
             status = AudioDeviceStart(core->outputDeviceID, core->ioprocid);
@@ -662,9 +661,7 @@ static int coreaudio_ctl_out (HWVoiceOut *hw, int cmd, ...)
                 coreaudio_logerr (status, "Could not resume playback\n");
             }
         }
-        break;
-
-    case VOICE_DISABLE:
+    } else {
         /* stop playback */
         if (!audio_is_cleaning_up()) {
             if (isPlaying(core->outputDeviceID)) {
@@ -675,9 +672,7 @@ static int coreaudio_ctl_out (HWVoiceOut *hw, int cmd, ...)
                 }
             }
         }
-        break;
     }
-    return 0;
 }
 
 static void *coreaudio_audio_init(Audiodev *dev)
@@ -695,7 +690,7 @@ static struct audio_pcm_ops coreaudio_pcm_ops = {
     .write    = coreaudio_write,
     .get_buffer_out = coreaudio_get_buffer_out,
     .put_buffer_out = coreaudio_put_buffer_out_nowrite,
-    .ctl_out  = coreaudio_ctl_out
+    .enable_out = coreaudio_enable_out
 };
 
 static struct audio_driver coreaudio_audio_driver = {
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 96693a97e5..adee53ceb7 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -361,7 +361,7 @@ static int dsound_open (dsound *s)
     return 0;
 }
 
-static int dsound_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void dsound_enable_out(HWVoiceOut *hw, bool enable)
 {
     HRESULT hr;
     DWORD status;
@@ -371,18 +371,17 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd, ...)
 
     if (!dsb) {
         dolog ("Attempt to control voice without a buffer\n");
-        return 0;
+        return;
     }
 
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         if (dsound_get_status_out (dsb, &status, s)) {
-            return -1;
+            return;
         }
 
         if (status & DSBSTATUS_PLAYING) {
             dolog ("warning: Voice is already playing\n");
-            return 0;
+            return;
         }
 
         dsound_clear_sample (hw, dsb, s);
@@ -390,28 +389,24 @@ static int dsound_ctl_out (HWVoiceOut *hw, int cmd, ...)
         hr = IDirectSoundBuffer_Play (dsb, 0, 0, DSBPLAY_LOOPING);
         if (FAILED (hr)) {
             dsound_logerr (hr, "Could not start playing buffer\n");
-            return -1;
+            return;
         }
-        break;
-
-    case VOICE_DISABLE:
+    } else {
         if (dsound_get_status_out (dsb, &status, s)) {
-            return -1;
+            return;
         }
 
         if (status & DSBSTATUS_PLAYING) {
             hr = IDirectSoundBuffer_Stop (dsb);
             if (FAILED (hr)) {
                 dsound_logerr (hr, "Could not stop playing buffer\n");
-                return -1;
+                return;
             }
         }
         else {
             dolog ("warning: Voice is not playing\n");
         }
-        break;
     }
-    return 0;
 }
 
 static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
@@ -461,7 +456,7 @@ static size_t dsound_put_buffer_out(HWVoiceOut *hw, void *buf, size_t len)
     return len;
 }
 
-static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void dsound_enable_in(HWVoiceIn *hw, bool enable)
 {
     HRESULT hr;
     DWORD status;
@@ -470,18 +465,17 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
 
     if (!dscb) {
         dolog ("Attempt to control capture voice without a buffer\n");
-        return -1;
+        return;
     }
 
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         if (dsound_get_status_in (dscb, &status)) {
-            return -1;
+            return;
         }
 
         if (status & DSCBSTATUS_CAPTURING) {
             dolog ("warning: Voice is already capturing\n");
-            return 0;
+            return;
         }
 
         /* clear ?? */
@@ -489,28 +483,24 @@ static int dsound_ctl_in (HWVoiceIn *hw, int cmd, ...)
         hr = IDirectSoundCaptureBuffer_Start (dscb, DSCBSTART_LOOPING);
         if (FAILED (hr)) {
             dsound_logerr (hr, "Could not start capturing\n");
-            return -1;
+            return;
         }
-        break;
-
-    case VOICE_DISABLE:
+    } else {
         if (dsound_get_status_in (dscb, &status)) {
-            return -1;
+            return;
         }
 
         if (status & DSCBSTATUS_CAPTURING) {
             hr = IDirectSoundCaptureBuffer_Stop (dscb);
             if (FAILED (hr)) {
                 dsound_logerr (hr, "Could not stop capturing\n");
-                return -1;
+                return;
             }
         }
         else {
             dolog ("warning: Voice is not capturing\n");
         }
-        break;
     }
-    return 0;
 }
 
 static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t *size)
@@ -674,14 +664,14 @@ static struct audio_pcm_ops dsound_pcm_ops = {
     .write    = audio_generic_write,
     .get_buffer_out = dsound_get_buffer_out,
     .put_buffer_out = dsound_put_buffer_out,
-    .ctl_out  = dsound_ctl_out,
+    .enable_out = dsound_enable_out,
 
     .init_in  = dsound_init_in,
     .fini_in  = dsound_fini_in,
     .read     = audio_generic_read,
     .get_buffer_in = dsound_get_buffer_in,
     .put_buffer_in = dsound_put_buffer_in,
-    .ctl_in   = dsound_ctl_in
+    .enable_in = dsound_enable_in,
 };
 
 static struct audio_driver dsound_audio_driver = {
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 9f1cc67df9..ec8a287f36 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -62,14 +62,13 @@ static void no_fini_out (HWVoiceOut *hw)
     (void) hw;
 }
 
-static int no_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void no_enable_out(HWVoiceOut *hw, bool enable)
 {
     NoVoiceOut *no = (NoVoiceOut *) hw;
 
-    if (cmd == VOICE_ENABLE) {
+    if (enable) {
         audio_rate_start(&no->rate);
     }
-    return 0;
 }
 
 static int no_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
@@ -96,14 +95,13 @@ static size_t no_read(HWVoiceIn *hw, void *buf, size_t size)
     return bytes;
 }
 
-static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void no_enable_in(HWVoiceIn *hw, bool enable)
 {
     NoVoiceIn *no = (NoVoiceIn *) hw;
 
-    if (cmd == VOICE_ENABLE) {
+    if (enable) {
         audio_rate_start(&no->rate);
     }
-    return 0;
 }
 
 static void *no_audio_init(Audiodev *dev)
@@ -120,12 +118,12 @@ static struct audio_pcm_ops no_pcm_ops = {
     .init_out = no_init_out,
     .fini_out = no_fini_out,
     .write    = no_write,
-    .ctl_out  = no_ctl_out,
+    .enable_out = no_enable_out,
 
     .init_in  = no_init_in,
     .fini_in  = no_fini_in,
     .read     = no_read,
-    .ctl_in   = no_ctl_in
+    .enable_in = no_enable_in
 };
 
 static struct audio_driver no_audio_driver = {
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 76c082d5e2..6ff3fc0dfa 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -563,60 +563,50 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
     return 0;
 }
 
-static int oss_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void oss_enable_out(HWVoiceOut *hw, bool enable)
 {
     int trig;
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
     AudiodevOssPerDirectionOptions *opdo = oss->dev->u.oss.out;
 
-    switch (cmd) {
-    case VOICE_ENABLE:
-        {
-            bool poll_mode = opdo->try_poll;
+    if (enable) {
+        bool poll_mode = opdo->try_poll;
 
-            ldebug ("enabling voice\n");
-            if (poll_mode) {
-                oss_poll_out (hw);
-                poll_mode = 0;
-            }
-            hw->poll_mode = poll_mode;
-
-            if (!oss->mmapped) {
-                return 0;
-            }
+        ldebug("enabling voice\n");
+        if (poll_mode) {
+            oss_poll_out(hw);
+            poll_mode = 0;
+        }
+        hw->poll_mode = poll_mode;
 
-            audio_pcm_info_clear_buf(
-                &hw->info, hw->buf_emul, hw->mix_buf->size);
-            trig = PCM_ENABLE_OUTPUT;
-            if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
-                oss_logerr (
-                    errno,
-                    "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed\n"
-                    );
-                return -1;
-            }
+        if (!oss->mmapped) {
+            return;
         }
-        break;
 
-    case VOICE_DISABLE:
+        audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->mix_buf->size);
+        trig = PCM_ENABLE_OUTPUT;
+        if (ioctl(oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
+            oss_logerr(errno,
+                       "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed\n");
+            return;
+        }
+    } else {
         if (hw->poll_mode) {
             qemu_set_fd_handler (oss->fd, NULL, NULL, NULL);
             hw->poll_mode = 0;
         }
 
         if (!oss->mmapped) {
-            return 0;
+            return;
         }
 
         ldebug ("disabling voice\n");
         trig = 0;
         if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
             oss_logerr (errno, "SNDCTL_DSP_SETTRIGGER 0 failed\n");
-            return -1;
+            return;
         }
-        break;
     }
-    return 0;
 }
 
 static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
@@ -703,32 +693,25 @@ static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
     return pos;
 }
 
-static int oss_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void oss_enable_in(HWVoiceIn *hw, bool enable)
 {
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
     AudiodevOssPerDirectionOptions *opdo = oss->dev->u.oss.out;
 
-    switch (cmd) {
-    case VOICE_ENABLE:
-        {
-            bool poll_mode = opdo->try_poll;
+    if (enable) {
+        bool poll_mode = opdo->try_poll;
 
-            if (poll_mode) {
-                oss_poll_in (hw);
-                poll_mode = 0;
-            }
-            hw->poll_mode = poll_mode;
+        if (poll_mode) {
+            oss_poll_in (hw);
+            poll_mode = 0;
         }
-        break;
-
-    case VOICE_DISABLE:
+        hw->poll_mode = poll_mode;
+    } else {
         if (hw->poll_mode) {
             hw->poll_mode = 0;
             qemu_set_fd_handler (oss->fd, NULL, NULL, NULL);
         }
-        break;
     }
-    return 0;
 }
 
 static void oss_init_per_direction(AudiodevOssPerDirectionOptions *opdo)
@@ -767,12 +750,12 @@ static struct audio_pcm_ops oss_pcm_ops = {
     .write    = oss_write,
     .get_buffer_out = oss_get_buffer_out,
     .put_buffer_out = oss_put_buffer_out,
-    .ctl_out  = oss_ctl_out,
+    .enable_out = oss_enable_out,
 
     .init_in  = oss_init_in,
     .fini_in  = oss_fini_in,
     .read     = oss_read,
-    .ctl_in   = oss_ctl_in
+    .enable_in = oss_enable_in
 };
 
 static struct audio_driver oss_audio_driver = {
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 75fce53202..ed31f863f7 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -452,7 +452,7 @@ static void qpa_fini_in (HWVoiceIn *hw)
     }
 }
 
-static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void qpa_volume_out(HWVoiceOut *hw, struct mixeng_volume *vol)
 {
     PAVoiceOut *pa = (PAVoiceOut *) hw;
     pa_operation *op;
@@ -463,49 +463,36 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
     pa_cvolume_init (&v);  /* function is present in 0.9.13+ */
 #endif
 
-    switch (cmd) {
-    case VOICE_VOLUME:
-        {
-            SWVoiceOut *sw;
-            va_list ap;
-
-            va_start (ap, cmd);
-            sw = va_arg (ap, SWVoiceOut *);
-            va_end (ap);
-
-            v.channels = 2;
-            v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.l) / UINT32_MAX;
-            v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.r) / UINT32_MAX;
-
-            pa_threaded_mainloop_lock(c->mainloop);
-
-            op = pa_context_set_sink_input_volume(c->context,
-                pa_stream_get_index (pa->stream),
-                &v, NULL, NULL);
-            if (!op) {
-                qpa_logerr(pa_context_errno(c->context),
-                           "set_sink_input_volume() failed\n");
-            } else {
-                pa_operation_unref(op);
-            }
-
-            op = pa_context_set_sink_input_mute(c->context,
-                pa_stream_get_index (pa->stream),
-               sw->vol.mute, NULL, NULL);
-            if (!op) {
-                qpa_logerr(pa_context_errno(c->context),
-                           "set_sink_input_mute() failed\n");
-            } else {
-                pa_operation_unref(op);
-            }
-
-            pa_threaded_mainloop_unlock(c->mainloop);
-        }
+    v.channels = 2;
+    v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->l) / UINT32_MAX;
+    v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->r) / UINT32_MAX;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    op = pa_context_set_sink_input_volume(c->context,
+                                          pa_stream_get_index(pa->stream),
+                                          &v, NULL, NULL);
+    if (!op) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "set_sink_input_volume() failed\n");
+    } else {
+        pa_operation_unref(op);
     }
-    return 0;
+
+    op = pa_context_set_sink_input_mute(c->context,
+                                        pa_stream_get_index(pa->stream),
+                                        vol->mute, NULL, NULL);
+    if (!op) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "set_sink_input_mute() failed\n");
+    } else {
+        pa_operation_unref(op);
+    }
+
+    pa_threaded_mainloop_unlock(c->mainloop);
 }
 
-static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
+static void qpa_volume_in(HWVoiceIn *hw, struct mixeng_volume *vol)
 {
     PAVoiceIn *pa = (PAVoiceIn *) hw;
     pa_operation *op;
@@ -516,46 +503,33 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
     pa_cvolume_init (&v);
 #endif
 
-    switch (cmd) {
-    case VOICE_VOLUME:
-        {
-            SWVoiceIn *sw;
-            va_list ap;
-
-            va_start (ap, cmd);
-            sw = va_arg (ap, SWVoiceIn *);
-            va_end (ap);
-
-            v.channels = 2;
-            v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.l) / UINT32_MAX;
-            v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.r) / UINT32_MAX;
-
-            pa_threaded_mainloop_lock(c->mainloop);
-
-            op = pa_context_set_source_output_volume(c->context,
-                pa_stream_get_index(pa->stream),
-                &v, NULL, NULL);
-            if (!op) {
-                qpa_logerr(pa_context_errno(c->context),
-                           "set_source_output_volume() failed\n");
-            } else {
-                pa_operation_unref(op);
-            }
-
-            op = pa_context_set_source_output_mute(c->context,
-                pa_stream_get_index (pa->stream),
-                sw->vol.mute, NULL, NULL);
-            if (!op) {
-                qpa_logerr(pa_context_errno(c->context),
-                           "set_source_output_mute() failed\n");
-            } else {
-                pa_operation_unref (op);
-            }
-
-            pa_threaded_mainloop_unlock(c->mainloop);
-        }
+    v.channels = 2;
+    v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->l) / UINT32_MAX;
+    v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->r) / UINT32_MAX;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    op = pa_context_set_source_output_volume(c->context,
+        pa_stream_get_index(pa->stream),
+        &v, NULL, NULL);
+    if (!op) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "set_source_output_volume() failed\n");
+    } else {
+        pa_operation_unref(op);
     }
-    return 0;
+
+    op = pa_context_set_source_output_mute(c->context,
+        pa_stream_get_index(pa->stream),
+        vol->mute, NULL, NULL);
+    if (!op) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "set_source_output_mute() failed\n");
+    } else {
+        pa_operation_unref(op);
+    }
+
+    pa_threaded_mainloop_unlock(c->mainloop);
 }
 
 static int qpa_validate_per_direction_opts(Audiodev *dev,
@@ -724,12 +698,12 @@ static struct audio_pcm_ops qpa_pcm_ops = {
     .init_out = qpa_init_out,
     .fini_out = qpa_fini_out,
     .write    = qpa_write,
-    .ctl_out  = qpa_ctl_out,
+    .volume_out = qpa_volume_out,
 
     .init_in  = qpa_init_in,
     .fini_in  = qpa_fini_in,
     .read     = qpa_read,
-    .ctl_in   = qpa_ctl_in
+    .volume_in = qpa_volume_in
 };
 
 static struct audio_driver pa_audio_driver = {
@@ -743,7 +717,6 @@ static struct audio_driver pa_audio_driver = {
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof (PAVoiceOut),
     .voice_size_in  = sizeof (PAVoiceIn),
-    .ctl_caps       = VOICE_VOLUME_CAP
 };
 
 static void register_audio_pa(void)
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index f7ac8cd101..5c6bcfcb3e 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -285,20 +285,9 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
     return 0;
 }
 
-static int sdl_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void sdl_enable_out(HWVoiceOut *hw, bool enable)
 {
-    (void) hw;
-
-    switch (cmd) {
-    case VOICE_ENABLE:
-        SDL_PauseAudio (0);
-        break;
-
-    case VOICE_DISABLE:
-        SDL_PauseAudio (1);
-        break;
-    }
-    return 0;
+    SDL_PauseAudio(!enable);
 }
 
 static void *sdl_audio_init(Audiodev *dev)
@@ -334,7 +323,7 @@ static struct audio_pcm_ops sdl_pcm_ops = {
     .write    = sdl_write,
     .get_buffer_out = sdl_get_buffer_out,
     .put_buffer_out = sdl_put_buffer_out_nowrite,
-    .ctl_out  = sdl_ctl_out,
+    .enable_out = sdl_enable_out,
 };
 
 static struct audio_driver sdl_audio_driver = {
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index ea0cb3fa2e..5fff0b7653 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -149,22 +149,20 @@ static size_t line_out_put_buffer(HWVoiceOut *hw, void *buf, size_t size)
     return size;
 }
 
-static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
+static void line_out_enable(HWVoiceOut *hw, bool enable)
 {
     SpiceVoiceOut *out = container_of (hw, SpiceVoiceOut, hw);
 
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         if (out->active) {
-            break;
+            return;
         }
         out->active = 1;
         audio_rate_start(&out->rate);
         spice_server_playback_start (&out->sin);
-        break;
-    case VOICE_DISABLE:
+    } else {
         if (!out->active) {
-            break;
+            return;
         }
         out->active = 0;
         if (out->frame) {
@@ -173,29 +171,21 @@ static int line_out_ctl (HWVoiceOut *hw, int cmd, ...)
             out->frame = NULL;
         }
         spice_server_playback_stop (&out->sin);
-        break;
-    case VOICE_VOLUME:
-        {
-#if ((SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && (SPICE_INTERFACE_PLAYBACK_MINOR >= 2))
-            SWVoiceOut *sw;
-            va_list ap;
-            uint16_t vol[2];
-
-            va_start (ap, cmd);
-            sw = va_arg (ap, SWVoiceOut *);
-            va_end (ap);
-
-            vol[0] = sw->vol.l / ((1ULL << 16) + 1);
-            vol[1] = sw->vol.r / ((1ULL << 16) + 1);
-            spice_server_playback_set_volume (&out->sin, 2, vol);
-            spice_server_playback_set_mute (&out->sin, sw->vol.mute);
-#endif
-            break;
-        }
     }
+}
 
-    return 0;
+#if ((SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && (SPICE_INTERFACE_PLAYBACK_MINOR >= 2))
+static void line_out_volume(HWVoiceOut *hw, struct mixeng_volume *vol)
+{
+    SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
+    uint16_t svol[2];
+
+    svol[0] = vol->l / ((1ULL << 16) + 1);
+    svol[1] = vol->r / ((1ULL << 16) + 1);
+    spice_server_playback_set_volume(&out->sin, 2, svol);
+    spice_server_playback_set_mute(&out->sin, vol->mute);
 }
+#endif
 
 /* record */
 
@@ -247,48 +237,38 @@ static size_t line_in_read(HWVoiceIn *hw, void *buf, size_t len)
     return ready << 2;
 }
 
-static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
+static void line_in_enable(HWVoiceIn *hw, bool enable)
 {
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
 
-    switch (cmd) {
-    case VOICE_ENABLE:
+    if (enable) {
         if (in->active) {
-            break;
+            return;
         }
         in->active = 1;
         audio_rate_start(&in->rate);
         spice_server_record_start (&in->sin);
-        break;
-    case VOICE_DISABLE:
+    } else {
         if (!in->active) {
-            break;
+            return;
         }
         in->active = 0;
         spice_server_record_stop (&in->sin);
-        break;
-    case VOICE_VOLUME:
-        {
-#if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
-            SWVoiceIn *sw;
-            va_list ap;
-            uint16_t vol[2];
-
-            va_start (ap, cmd);
-            sw = va_arg (ap, SWVoiceIn *);
-            va_end (ap);
-
-            vol[0] = sw->vol.l / ((1ULL << 16) + 1);
-            vol[1] = sw->vol.r / ((1ULL << 16) + 1);
-            spice_server_record_set_volume (&in->sin, 2, vol);
-            spice_server_record_set_mute (&in->sin, sw->vol.mute);
-#endif
-            break;
-        }
     }
+}
 
-    return 0;
+#if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
+static void line_in_volume(HWVoiceIn *hw, struct mixeng_volume *vol)
+{
+    SpiceVoiceIn *in = container_of(hw, SpiceVoiceIn, hw);
+    uint16_t svol[2];
+
+    svol[0] = vol->l / ((1ULL << 16) + 1);
+    svol[1] = vol->r / ((1ULL << 16) + 1);
+    spice_server_record_set_volume(&in->sin, 2, svol);
+    spice_server_record_set_mute(&in->sin, vol->mute);
 }
+#endif
 
 static struct audio_pcm_ops audio_callbacks = {
     .init_out = line_out_init,
@@ -296,12 +276,19 @@ static struct audio_pcm_ops audio_callbacks = {
     .write    = audio_generic_write,
     .get_buffer_out = line_out_get_buffer,
     .put_buffer_out = line_out_put_buffer,
-    .ctl_out  = line_out_ctl,
+    .enable_out = line_out_enable,
+#if (SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && \
+        (SPICE_INTERFACE_PLAYBACK_MINOR >= 2)
+    .volume_out = line_out_volume,
+#endif
 
     .init_in  = line_in_init,
     .fini_in  = line_in_fini,
     .read     = line_in_read,
-    .ctl_in   = line_in_ctl,
+    .enable_in = line_in_enable,
+#if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
+    .volume_in = line_in_volume,
+#endif
 };
 
 static struct audio_driver spice_audio_driver = {
@@ -314,9 +301,6 @@ static struct audio_driver spice_audio_driver = {
     .max_voices_in  = 1,
     .voice_size_out = sizeof (SpiceVoiceOut),
     .voice_size_in  = sizeof (SpiceVoiceIn),
-#if ((SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && (SPICE_INTERFACE_PLAYBACK_MINOR >= 2))
-    .ctl_caps       = VOICE_VOLUME_CAP
-#endif
 };
 
 void qemu_spice_audio_init (void)
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index cb2783e82a..2cc8b137ba 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -173,14 +173,13 @@ static void wav_fini_out (HWVoiceOut *hw)
     wav->f = NULL;
 }
 
-static int wav_ctl_out (HWVoiceOut *hw, int cmd, ...)
+static void wav_enable_out(HWVoiceOut *hw, bool enable)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
 
-    if (cmd == VOICE_ENABLE) {
+    if (enable) {
         audio_rate_start(&wav->rate);
     }
-    return 0;
 }
 
 static void *wav_audio_init(Audiodev *dev)
@@ -198,7 +197,7 @@ static struct audio_pcm_ops wav_pcm_ops = {
     .init_out = wav_init_out,
     .fini_out = wav_fini_out,
     .write    = wav_write_out,
-    .ctl_out  = wav_ctl_out,
+    .enable_out = wav_enable_out,
 };
 
 static struct audio_driver wav_audio_driver = {
-- 
2.23.0


