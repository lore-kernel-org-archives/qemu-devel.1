Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A00C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 930AE20673
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBXdWNFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930AE20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJk70-0002Rn-GP
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 16:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iJk0M-0005SA-Qf
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iJk0L-0003Fe-3N
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iJk0K-0003EN-T4
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id v8so17255140wrt.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hBNbSNYdRxpi4YPwJzeBrQcOF4eLYJl4drOoaIZgmh0=;
 b=PBXdWNFzUkyjmNRugR4G7C1VODFBO7+giz6OiOV1A8WqaqZ+gkZURKZAZwutTB9AwO
 bJAhLA33EFucfYVEGhltwwyhI2PV7Vi0gkeD3ZN5D1Egf7iY80EOY7kOJidsctufM3/w
 /JmhwlkyO9G1EVkdaY3fj8dBeYhaxl/7qXdEFbnUGupmc1xKTDJnc7iEkI/CyJccbUKR
 PKJFGRBuNDa8fjBkJdc11eGJUajRaUqyIfx2FWV72PWzLvMXYdskUELeMck5nyRj3aq2
 TXV7ggi4T69HuQFdcJa3SyX245bJ5kXogROib+oMHB2Uwe8yHbpCCcxUScXiFODULj/n
 19xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hBNbSNYdRxpi4YPwJzeBrQcOF4eLYJl4drOoaIZgmh0=;
 b=jPl8ja4QVeE77RTMPQRPJcEvgICJe2nR79OrQqX4LKMIfRVDi79pCkD6aZB+raD0lq
 cM+u9Fhm78n3IWPUylgAuCboSGWp46WCnUH+olumnQlcpqwe5/KRZinQ5hLnXuOvjN4i
 SRYuLfV2Q/hNu/QjN7qp/TUeZ9NYPaVsiaYWAYOYVWwa3Wp97sG8Gdj84WrmvsjD/FaV
 CDRNWVNkzNxgKYREZu2OMyS/evXGRSTrb9LG4xTnHb6l02wK1Zp/22/5Unn9/RDUc0DP
 g96hD0KLBf6ldDk/IkgJW8RbGNiAx5DKhHi3dxOfn3ocYWLFb5WbDp84WbwQR4eJ6LTa
 UiLg==
X-Gm-Message-State: APjAAAV1ZBxtSyT5LPbDIZ/t4D9EuAwK09yLcCi17iRQ9hFTbHqXX9nE
 QhwMreD5PDsA1+YSNcAPjoubfNIm
X-Google-Smtp-Source: APXvYqx2kLo+WBVKqnH2TfDqWEWdI1mVAl91yNb8ALMatjo8Wfg4NGpjODZ88S1YWaAcKuYHag2V+g==
X-Received: by 2002:a5d:420c:: with SMTP id n12mr22103076wrq.85.1570996691684; 
 Sun, 13 Oct 2019 12:58:11 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-0052-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:52::5])
 by smtp.gmail.com with ESMTPSA id x129sm29941857wmg.8.2019.10.13.12.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 12:58:11 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/10] audio: support more than two channels in volume
 setting
Date: Sun, 13 Oct 2019 21:58:01 +0200
Message-Id: <5d3dd2ee3baaa62805e79c3901abb7415ae32461.1570996490.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570996490.git.DirtY.iCE.hu@gmail.com>
References: <cover.1570996490.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
index d616a4af98..f1c145dfcd 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1891,31 +1891,45 @@ void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
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
index 9860f9c5e1..6ed7f7a79e 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -179,13 +179,14 @@ static void line_out_enable(HWVoiceOut *hw, bool enable)
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
@@ -262,13 +263,14 @@ static void line_in_enable(HWVoiceIn *hw, bool enable)
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


