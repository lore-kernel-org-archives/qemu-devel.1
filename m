Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874B8C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDDC21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thvKs0pI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDDC21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB3xs-0004wk-0Y
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3ud-0002cv-Hc
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3ub-0000Wq-HC
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iB3ub-0000WK-87
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id i18so4581290wru.11
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lDG6NNDECQDn4/nyyITVRisGzx5VHFjiAPGOHzavck0=;
 b=thvKs0pIyIyVv1m8fezY2Nr8CChsknXBFFY70PtiE8MhXDIhBaqMr5LRC4C+NtcWwB
 fVKtBtyOcr5uAAiBY7UVtiWmDbJftkGjxap8A7YLX4qUORrC8d75dfu43CJn+D/roA4X
 AoGGZxhar/J4hoDy/PUxaq94WjNKXCKIJ4dOkCs6tleHis27pt8bl6x5EUdJg/4OOdBZ
 Y5jz9gAfO0GUGU/rAxEyhbXfbiqOGAr4BYmQcGxxyLfukDxMAccWSYlLrY6ltkrRZrJe
 gDaEuLNZbKQ9Nb/H75siG2lYBd5ol3OcSZroAFqVfnV4m08cF4pgsbqWtAx4QpP6lKIN
 EFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lDG6NNDECQDn4/nyyITVRisGzx5VHFjiAPGOHzavck0=;
 b=E1rArIWO6taKv9b/xndKoxvzN4bn3q9X7M741v3rO7j04EoImSxUgm1GIdd6aRXNs8
 E+pdAF0XJIdRh5Xry09Ls7ReHPfJjt27h5Q+FTtFgqNCY0OePPvHR+UlvYb75t4Jl+lr
 3XqbpksPuvG0cu/vYnl5PfHoWjeXP3cLatin4PVphH0NtKN/lfU/zI7ubkNe9BpL+u3/
 XC1nH0AO9HnC7yfRFkvdbDhP9vgykKjZCmdjR3wxyMu3Qr+HYuIh9TJQvLAovo74OV48
 GECZFhxNSNwEh94p8NHSL3jEB6sjKrKIpnGpqo87RMrkJb7hy+3i7axG18n8Fko1N2pM
 VdLQ==
X-Gm-Message-State: APjAAAUMT/e2ArXvhM9htdLJdGC608caOanWsMVmHI6RFy4y9E600u4w
 CthUzvRh9Meq7rb8OB/5XQQVJAy/
X-Google-Smtp-Source: APXvYqzAWOFVKNkSMLP0QvUgLap/aN6esDeycJPFeA7zG6H9TFmLO4wM9yPule/BKR/XwZHnPZaCOA==
X-Received: by 2002:adf:fa90:: with SMTP id h16mr1372999wrr.52.1568928263962; 
 Thu, 19 Sep 2019 14:24:23 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id w125sm13191292wmg.32.2019.09.19.14.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:24:23 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/24] alsaaudio: port to the new audio backend api
Date: Thu, 19 Sep 2019 23:24:10 +0200
Message-Id: <ab9768e73dfe7b7305bd6a51629846e0d77622a5.1568927990.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 audio/alsaaudio.c | 302 ++++++++++++----------------------------------
 1 file changed, 80 insertions(+), 222 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 591344dccd..19124d09d8 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -44,9 +44,6 @@ struct pollhlp {
 
 typedef struct ALSAVoiceOut {
     HWVoiceOut hw;
-    int wpos;
-    int pending;
-    void *pcm_buf;
     snd_pcm_t *handle;
     struct pollhlp pollhlp;
     Audiodev *dev;
@@ -55,7 +52,6 @@ typedef struct ALSAVoiceOut {
 typedef struct ALSAVoiceIn {
     HWVoiceIn hw;
     snd_pcm_t *handle;
-    void *pcm_buf;
     struct pollhlp pollhlp;
     Audiodev *dev;
 } ALSAVoiceIn;
@@ -602,102 +598,64 @@ static int alsa_open(bool in, struct alsa_params_req *req,
     return -1;
 }
 
-static snd_pcm_sframes_t alsa_get_avail (snd_pcm_t *handle)
+static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
 {
-    snd_pcm_sframes_t avail;
-
-    avail = snd_pcm_avail_update (handle);
-    if (avail < 0) {
-        if (avail == -EPIPE) {
-            if (!alsa_recover (handle)) {
-                avail = snd_pcm_avail_update (handle);
-            }
-        }
-
-        if (avail < 0) {
-            alsa_logerr (avail,
-                         "Could not obtain number of available frames\n");
-            return -1;
-        }
-    }
+    ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
+    size_t pos = 0;
+    size_t len_frames = len >> hw->info.shift;
+
+    while (len_frames) {
+        char *src = advance(buf, pos);
+        snd_pcm_sframes_t written;
+
+        written = snd_pcm_writei(alsa->handle, src, len_frames);
+
+        if (written <= 0) {
+            switch (written) {
+            case 0:
+                trace_alsa_wrote_zero(len_frames);
+                return pos;
+
+            case -EPIPE:
+                if (alsa_recover(alsa->handle)) {
+                    alsa_logerr(written, "Failed to write %zu frames\n",
+                                len_frames);
+                    return pos;
+                }
+                trace_alsa_xrun_out();
+                continue;
+
+            case -ESTRPIPE:
+                /*
+                 * stream is suspended and waiting for an application
+                 * recovery
+                 */
+                if (alsa_resume(alsa->handle)) {
+                    alsa_logerr(written, "Failed to write %zu frames\n",
+                                len_frames);
+                    return pos;
+                }
+                trace_alsa_resume_out();
+                continue;
 
-    return avail;
-}
+            case -EAGAIN:
+                return pos;
 
-static void alsa_write_pending (ALSAVoiceOut *alsa)
-{
-    HWVoiceOut *hw = &alsa->hw;
-
-    while (alsa->pending) {
-        int left_till_end_samples = hw->samples - alsa->wpos;
-        int len = MIN (alsa->pending, left_till_end_samples);
-        char *src = advance (alsa->pcm_buf, alsa->wpos << hw->info.shift);
-
-        while (len) {
-            snd_pcm_sframes_t written;
-
-            written = snd_pcm_writei (alsa->handle, src, len);
-
-            if (written <= 0) {
-                switch (written) {
-                case 0:
-                    trace_alsa_wrote_zero(len);
-                    return;
-
-                case -EPIPE:
-                    if (alsa_recover (alsa->handle)) {
-                        alsa_logerr (written, "Failed to write %d frames\n",
-                                     len);
-                        return;
-                    }
-                    trace_alsa_xrun_out();
-                    continue;
-
-                case -ESTRPIPE:
-                    /* stream is suspended and waiting for an
-                       application recovery */
-                    if (alsa_resume (alsa->handle)) {
-                        alsa_logerr (written, "Failed to write %d frames\n",
-                                     len);
-                        return;
-                    }
-                    trace_alsa_resume_out();
-                    continue;
-
-                case -EAGAIN:
-                    return;
-
-                default:
-                    alsa_logerr (written, "Failed to write %d frames from %p\n",
-                                 len, src);
-                    return;
-                }
+            default:
+                alsa_logerr(written, "Failed to write %zu frames from %p\n",
+                            len, src);
+                return pos;
             }
-
-            alsa->wpos = (alsa->wpos + written) % hw->samples;
-            alsa->pending -= written;
-            len -= written;
         }
-    }
-}
-
-static size_t alsa_run_out(HWVoiceOut *hw, size_t live)
-{
-    ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
-    size_t decr;
-    snd_pcm_sframes_t avail;
 
-    avail = alsa_get_avail (alsa->handle);
-    if (avail < 0) {
-        dolog ("Could not get number of available playback frames\n");
-        return 0;
+        pos += written << hw->info.shift;
+        if (written < len_frames) {
+            break;
+        }
+        len_frames -= written;
     }
 
-    decr = MIN (live, avail);
-    decr = audio_pcm_hw_clip_out (hw, alsa->pcm_buf, decr, alsa->pending);
-    alsa->pending += decr;
-    alsa_write_pending (alsa);
-    return decr;
+    return pos;
 }
 
 static void alsa_fini_out (HWVoiceOut *hw)
@@ -706,9 +664,6 @@ static void alsa_fini_out (HWVoiceOut *hw)
 
     ldebug ("alsa_fini\n");
     alsa_anal_close (&alsa->handle, &alsa->pollhlp);
-
-    g_free(alsa->pcm_buf);
-    alsa->pcm_buf = NULL;
 }
 
 static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
@@ -737,14 +692,6 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples = obt.samples;
 
-    alsa->pcm_buf = audio_calloc(__func__, obt.samples, 1 << hw->info.shift);
-    if (!alsa->pcm_buf) {
-        dolog("Could not allocate DAC buffer (%zu samples, each %d bytes)\n",
-              hw->samples, 1 << hw->info.shift);
-        alsa_anal_close1 (&handle);
-        return -1;
-    }
-
     alsa->pollhlp.s = hw->s;
     alsa->handle = handle;
     alsa->dev = dev;
@@ -839,14 +786,6 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples = obt.samples;
 
-    alsa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
-    if (!alsa->pcm_buf) {
-        dolog("Could not allocate ADC buffer (%zu samples, each %d bytes)\n",
-              hw->samples, 1 << hw->info.shift);
-        alsa_anal_close1 (&handle);
-        return -1;
-    }
-
     alsa->pollhlp.s = hw->s;
     alsa->handle = handle;
     alsa->dev = dev;
@@ -858,129 +797,48 @@ static void alsa_fini_in (HWVoiceIn *hw)
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
 
     alsa_anal_close (&alsa->handle, &alsa->pollhlp);
-
-    g_free(alsa->pcm_buf);
-    alsa->pcm_buf = NULL;
 }
 
-static size_t alsa_run_in(HWVoiceIn *hw)
+static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
 {
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
-    int hwshift = hw->info.shift;
-    int i;
-    size_t live = audio_pcm_hw_get_live_in (hw);
-    size_t dead = hw->samples - live;
-    size_t decr;
-    struct {
-        size_t add;
-        size_t len;
-    } bufs[2] = {
-        { .add = hw->wpos, .len = 0 },
-        { .add = 0,        .len = 0 }
-    };
-    snd_pcm_sframes_t avail;
-    snd_pcm_uframes_t read_samples = 0;
-
-    if (!dead) {
-        return 0;
-    }
+    size_t pos = 0;
 
-    avail = alsa_get_avail (alsa->handle);
-    if (avail < 0) {
-        dolog ("Could not get number of captured frames\n");
-        return 0;
-    }
-
-    if (!avail) {
-        snd_pcm_state_t state;
-
-        state = snd_pcm_state (alsa->handle);
-        switch (state) {
-        case SND_PCM_STATE_PREPARED:
-            avail = hw->samples;
-            break;
-        case SND_PCM_STATE_SUSPENDED:
-            /* stream is suspended and waiting for an application recovery */
-            if (alsa_resume (alsa->handle)) {
-                dolog ("Failed to resume suspended input stream\n");
-                return 0;
-            }
-            trace_alsa_resume_in();
-            break;
-        default:
-            trace_alsa_no_frames(state);
-            return 0;
-        }
-    }
+    while (len) {
+        void *dst = advance(buf, pos);
+        snd_pcm_sframes_t nread;
 
-    decr = MIN(dead, avail);
-    if (!decr) {
-        return 0;
-    }
+        nread = snd_pcm_readi(alsa->handle, dst, len >> hw->info.shift);
 
-    if (hw->wpos + decr > hw->samples) {
-        bufs[0].len = (hw->samples - hw->wpos);
-        bufs[1].len = (decr - (hw->samples - hw->wpos));
-    }
-    else {
-        bufs[0].len = decr;
-    }
+        if (nread <= 0) {
+            switch (nread) {
+            case 0:
+                trace_alsa_read_zero(len);
+                return pos;;
 
-    for (i = 0; i < 2; ++i) {
-        void *src;
-        struct st_sample *dst;
-        snd_pcm_sframes_t nread;
-        snd_pcm_uframes_t len;
-
-        len = bufs[i].len;
-
-        src = advance (alsa->pcm_buf, bufs[i].add << hwshift);
-        dst = hw->conv_buf + bufs[i].add;
-
-        while (len) {
-            nread = snd_pcm_readi (alsa->handle, src, len);
-
-            if (nread <= 0) {
-                switch (nread) {
-                case 0:
-                    trace_alsa_read_zero(len);
-                    goto exit;
-
-                case -EPIPE:
-                    if (alsa_recover (alsa->handle)) {
-                        alsa_logerr (nread, "Failed to read %ld frames\n", len);
-                        goto exit;
-                    }
-                    trace_alsa_xrun_in();
-                    continue;
-
-                case -EAGAIN:
-                    goto exit;
-
-                default:
-                    alsa_logerr (
-                        nread,
-                        "Failed to read %ld frames from %p\n",
-                        len,
-                        src
-                        );
-                    goto exit;
+            case -EPIPE:
+                if (alsa_recover(alsa->handle)) {
+                    alsa_logerr(nread, "Failed to read %zu frames\n", len);
+                    return pos;
                 }
-            }
+                trace_alsa_xrun_in();
+                continue;
 
-            hw->conv (dst, src, nread);
+            case -EAGAIN:
+                return pos;
 
-            src = advance (src, nread << hwshift);
-            dst += nread;
-
-            read_samples += nread;
-            len -= nread;
+            default:
+                alsa_logerr(nread, "Failed to read %zu frames to %p\n",
+                            len, dst);
+                return pos;;
+            }
         }
+
+        pos += nread << hw->info.shift;
+        len -= nread << hw->info.shift;
     }
 
- exit:
-    hw->wpos = (hw->wpos + read_samples) % hw->samples;
-    return read_samples;
+    return pos;
 }
 
 static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
@@ -1065,12 +923,12 @@ static void alsa_audio_fini (void *opaque)
 static struct audio_pcm_ops alsa_pcm_ops = {
     .init_out = alsa_init_out,
     .fini_out = alsa_fini_out,
-    .run_out  = alsa_run_out,
+    .write    = alsa_write,
     .ctl_out  = alsa_ctl_out,
 
     .init_in  = alsa_init_in,
     .fini_in  = alsa_fini_in,
-    .run_in   = alsa_run_in,
+    .read     = alsa_read,
     .ctl_in   = alsa_ctl_in,
 };
 
-- 
2.23.0


