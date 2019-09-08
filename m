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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BDAC433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A720A218AE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gifTcttm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A720A218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i750C-0008PO-P9
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74e2-0005am-6a
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74e0-0005sm-6G
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:49 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:40647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74e0-0005sd-1l
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:48 -0400
Received: by mail-qk1-x741.google.com with SMTP id y144so3036782qkb.7
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Et30A368zWMscvfqdouhH9DBBManGFD5PH3diqSLdfk=;
 b=gifTcttm871a3Mv5ihL7E/vIPCXuhy3vLLnYDH9mV+KSX3R/Qvd3et4huKOb9ym336
 nyprJ5zZfTAul160eM5fCki8P0w1JvaB7bihAqP5JZAgSpduX1FUSJYULBfgfr34jMZi
 /kBTrOkfg3hc1l7Mvnm1l7VBMz3WfdfhTuvQMg35PqrQfHXwnssD3I+sa6aOJ9Va21KV
 NDJVqYmDUg5FqVUhZtbq2hW2FYTzD1hU+76B0wTUikXaGn6GJB9NpgV4z3MOzMZfJdNS
 Y6FnI+wk1w+SV858P9J9mIGoxwQxij0wCSXPzOQo35nNDgE3G3+Z2Lxaov8pPx8tmXgP
 +iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Et30A368zWMscvfqdouhH9DBBManGFD5PH3diqSLdfk=;
 b=mGfabtrPHstktO9UTZ1lyUxT2B5VSvsiL7dCbbz6B48p3MYVu/eUKJ4etzDesgbCn7
 Cx2guHkL34gU9ZQrgsfr9j2jwYB2ThTD7I67aJN1o3wtNpSL3BYDPCWNHivQKu+cI8Ql
 qZc1u/UNNdh5Xcm6BUuPIsh4Lh0ALrbZZ6rsxBjL/8I9dfIifMKFBS3Q8Uay0P4PaHW/
 2ltWaBTKYMaGYcp777qhp+/OZ60qdD7SYdzCgc0fPK2sL7yMjYiG9daEelxVuTbnDxyg
 I1YfLqL11x/9P3qPrDf1iU0G4cOfX0D5prTaOW52f/2Ex3LetbV/T/9kfi9TSyhcXFdK
 dsLw==
X-Gm-Message-State: APjAAAVJqBJAVtr+RklyQcSRBQi1QW1QwW6xXrlUw9iJ8FO0tU+GMARM
 xJSpCJyV5qdXnBhEHVBqMgHNT+QS
X-Google-Smtp-Source: APXvYqz1qZ2hW+pedtgICOX0StFTTCO0pxvGT+/9ojE3G0Uw+K1kVpR7J6DLNOWvzGBcIWuC36ZP+A==
X-Received: by 2002:a37:b981:: with SMTP id
 j123mr17629718qkf.201.1567977767367; 
 Sun, 08 Sep 2019 14:22:47 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:47 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:18 +0200
Message-Id: <4b9119f77e671bf3a74b64e851514ef4bf56a9ba.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [PATCH v2 18/24] audio: support more than two channels
 in volume setting
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

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.c      | 30 ++++++++++++++++++++++--------
 audio/audio.h      | 10 ++++++++++
 audio/audio_int.h  |  4 ++--
 audio/paaudio.c    | 20 ++++++++++++--------
 audio/spiceaudio.c | 14 ++++++++------
 5 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index b7d14d0ef7..1284ae4d8f 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1886,31 +1886,45 @@ void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
 }
 
 void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol)
+{
+    Volume vol = { .mute = mute, .channels = 2, .vol = { lvol, rvol } };
+    audio_set_volume_out(sw, &vol);
+}
+
+void audio_set_volume_out(SWVoiceOut *sw, Volume *vol)
 {
     if (sw) {
         HWVoiceOut *hw = sw->hw;
 
-        sw->vol.mute = mute;
-        sw->vol.l = nominal_volume.l * lvol / 255;
-        sw->vol.r = nominal_volume.r * rvol / 255;
+        sw->vol.mute = vol->mute;
+        sw->vol.l = nominal_volume.l * vol->vol[0] / 255;
+        sw->vol.r = nominal_volume.l * vol->vol[vol->channels > 1 ? 1 : 0] /
+            255;
 
         if (hw->pcm_ops->volume_out) {
-            hw->pcm_ops->volume_out(hw, &sw->vol);
+            hw->pcm_ops->volume_out(hw, vol);
         }
     }
 }
 
 void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
+{
+    Volume vol = { .mute = mute, .channels = 2, .vol = { lvol, rvol } };
+    audio_set_volume_in(sw, &vol);
+}
+
+void audio_set_volume_in(SWVoiceIn *sw, Volume *vol)
 {
     if (sw) {
         HWVoiceIn *hw = sw->hw;
 
-        sw->vol.mute = mute;
-        sw->vol.l = nominal_volume.l * lvol / 255;
-        sw->vol.r = nominal_volume.r * rvol / 255;
+        sw->vol.mute = vol->mute;
+        sw->vol.l = nominal_volume.l * vol->vol[0] / 255;
+        sw->vol.r = nominal_volume.r * vol->vol[vol->channels > 1 ? 1 : 0] /
+            255;
 
         if (hw->pcm_ops->volume_in) {
-            hw->pcm_ops->volume_in(hw, &sw->vol);
+            hw->pcm_ops->volume_in(hw, vol);
         }
     }
 }
diff --git a/audio/audio.h b/audio/audio.h
index c74abb8c47..0db3c7dd5e 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -124,6 +124,16 @@ uint64_t AUD_get_elapsed_usec_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
 void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_t rvol);
 void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol);
 
+#define AUDIO_MAX_CHANNELS 16
+typedef struct Volume {
+    bool mute;
+    int channels;
+    uint8_t vol[AUDIO_MAX_CHANNELS];
+} Volume;
+
+void audio_set_volume_out(SWVoiceOut *sw, Volume *vol);
+void audio_set_volume_in(SWVoiceIn *sw, Volume *vol);
+
 SWVoiceIn *AUD_open_in (
     QEMUSoundCard *card,
     SWVoiceIn *sw,
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 22a703c13e..9176db249b 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -166,7 +166,7 @@ struct audio_pcm_ops {
      */
     size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
     void   (*enable_out)(HWVoiceOut *hw, bool enable);
-    void   (*volume_out)(HWVoiceOut *hw, struct mixeng_volume *vol);
+    void   (*volume_out)(HWVoiceOut *hw, Volume *vol);
 
     int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
     void   (*fini_in) (HWVoiceIn *hw);
@@ -174,7 +174,7 @@ struct audio_pcm_ops {
     void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
     void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
     void   (*enable_in)(HWVoiceIn *hw, bool enable);
-    void   (*volume_in)(HWVoiceIn *hw, struct mixeng_volume *vol);
+    void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
 };
 
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 6ccdf31415..d195b1caa8 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -531,20 +531,22 @@ static void qpa_fini_in (HWVoiceIn *hw)
     }
 }
 
-static void qpa_volume_out(HWVoiceOut *hw, struct mixeng_volume *vol)
+static void qpa_volume_out(HWVoiceOut *hw, Volume *vol)
 {
     PAVoiceOut *pa = (PAVoiceOut *) hw;
     pa_operation *op;
     pa_cvolume v;
     PAConnection *c = pa->g->conn;
+    int i;
 
 #ifdef PA_CHECK_VERSION    /* macro is present in 0.9.16+ */
     pa_cvolume_init (&v);  /* function is present in 0.9.13+ */
 #endif
 
-    v.channels = 2;
-    v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->l) / UINT32_MAX;
-    v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->r) / UINT32_MAX;
+    v.channels = vol->channels;
+    for (i = 0; i < vol->channels; ++i) {
+        v.values[i] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->vol[i]) / 255;
+    }
 
     pa_threaded_mainloop_lock(c->mainloop);
 
@@ -571,20 +573,22 @@ static void qpa_volume_out(HWVoiceOut *hw, struct mixeng_volume *vol)
     pa_threaded_mainloop_unlock(c->mainloop);
 }
 
-static void qpa_volume_in(HWVoiceIn *hw, struct mixeng_volume *vol)
+static void qpa_volume_in(HWVoiceIn *hw, Volume *vol)
 {
     PAVoiceIn *pa = (PAVoiceIn *) hw;
     pa_operation *op;
     pa_cvolume v;
     PAConnection *c = pa->g->conn;
+    int i;
 
 #ifdef PA_CHECK_VERSION
     pa_cvolume_init (&v);
 #endif
 
-    v.channels = 2;
-    v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->l) / UINT32_MAX;
-    v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->r) / UINT32_MAX;
+    v.channels = vol->channels;
+    for (i = 0; i < vol->channels; ++i) {
+        v.values[i] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * vol->vol[i]) / 255;
+    }
 
     pa_threaded_mainloop_lock(c->mainloop);
 
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 5fff0b7653..71af90ec56 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -175,13 +175,14 @@ static void line_out_enable(HWVoiceOut *hw, bool enable)
 }
 
 #if ((SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && (SPICE_INTERFACE_PLAYBACK_MINOR >= 2))
-static void line_out_volume(HWVoiceOut *hw, struct mixeng_volume *vol)
+static void line_out_volume(HWVoiceOut *hw, Volume *vol)
 {
     SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
     uint16_t svol[2];
 
-    svol[0] = vol->l / ((1ULL << 16) + 1);
-    svol[1] = vol->r / ((1ULL << 16) + 1);
+    assert(vol->channels == 2);
+    svol[0] = vol->vol[0] * 257;
+    svol[1] = vol->vol[1] * 257;
     spice_server_playback_set_volume(&out->sin, 2, svol);
     spice_server_playback_set_mute(&out->sin, vol->mute);
 }
@@ -258,13 +259,14 @@ static void line_in_enable(HWVoiceIn *hw, bool enable)
 }
 
 #if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
-static void line_in_volume(HWVoiceIn *hw, struct mixeng_volume *vol)
+static void line_in_volume(HWVoiceIn *hw, Volume *vol)
 {
     SpiceVoiceIn *in = container_of(hw, SpiceVoiceIn, hw);
     uint16_t svol[2];
 
-    svol[0] = vol->l / ((1ULL << 16) + 1);
-    svol[1] = vol->r / ((1ULL << 16) + 1);
+    assert(vol->channels == 2);
+    svol[0] = vol->vol[0] * 257;
+    svol[1] = vol->vol[1] * 257;
     spice_server_record_set_volume(&in->sin, 2, svol);
     spice_server_record_set_mute(&in->sin, vol->mute);
 }
-- 
2.23.0


