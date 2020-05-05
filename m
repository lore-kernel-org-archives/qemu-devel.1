Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517F1C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0FF206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgDI4E9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0FF206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxlR-0001yX-7Z
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaQ-00060V-Gp
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaP-0002Gd-AY
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:14 -0400
Received: by mail-wm1-x343.google.com with SMTP id y24so2326746wma.4
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sBpc5qlzjGqkmrHk8rD3OooXVUoJuabxAfTsEBnyYZk=;
 b=VgDI4E9Zz2O4SFW1sz6gdFVSrJAMPiBrsfnkIYykLC+HNBRqyY9F32EoJqUSKw6OSU
 X43aGmUUsMceYu27PQW72vtsKsauyTdTZCX8PWPFJyboV/Xouga0Xw+ohFn5phCMJ9qQ
 PKZUkFpH4XEJtKyIgtcKinpsOg55+zCz/qI5NLawk1+z6i7tG6k6060ZYOisbbsk2I/T
 kQ+xhOS0ysJzaLtn/WMpvMdHBvDKagoPioUOy9rS4etjKS1nP8O2uKzA2scUBzhdaeY4
 GgcoxiCpcVKLLHK4WC33/KWoHbGkSvZxACinU9oEaTCTP0jj90Emi7hPe5VdZxGBJvGU
 g/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sBpc5qlzjGqkmrHk8rD3OooXVUoJuabxAfTsEBnyYZk=;
 b=mPU1dqggck7eMH0/DMnY+LCT4f6V3+YJWbZMiig8x+teivzWFRbzVEAMKl1sPeEk8Y
 SUqvv/LkFVEYxMJyy8dYNHpSLZ0pfR3xoaLIL5mzimvPsprROZTym0iynzpMsyut4gVi
 AKw4mKzLsuOoIM3NUyTYtjg2iw2fHMfINvPP53Kzr37+nBbYaTFLlXPrl371xfDcb2YS
 zTvZ3OqsTut5UtWy10+/gve2WGVnlRRt446Ie3+/73l1AIobUfB4vcAN9R9Hi8qZ2QOq
 /OHskr/rEmrnPeL+OzW5FEsHGVyfsQeUDLqwZrOdZO45hd+EYaMaHvgFN62zBfKufaQP
 X23Q==
X-Gm-Message-State: AGi0Pua2TcdWMkIJ1gGyp93vdr7+0j1dM5ZLpopQXxSpdbYIW/27O/Dn
 IjfF2W5Z50K/UtV2xT+fGtuOwUNu
X-Google-Smtp-Source: APiQypIKXOPRrVr8kimDuwztc2W8JAGeGxvUPRDvJi40iYhBxMRz4/xBaz8MJNvpHM2f5ERAb+k9fw==
X-Received: by 2002:a1c:5446:: with SMTP id p6mr3501348wmi.172.1588685171597; 
 Tue, 05 May 2020 06:26:11 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n6sm3427424wrs.81.2020.05.05.06.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 06:26:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] audio: Let HWVoice write() handlers take a const buffer
Date: Tue,  5 May 2020 15:26:01 +0200
Message-Id: <20200505132603.8575-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200505132603.8575-1-f4bug@amsat.org>
References: <20200505132603.8575-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The various write() and put_buffer() handlers should not
modify their buffer argument. Make it const.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 audio/audio_int.h   | 13 +++++++------
 audio/alsaaudio.c   |  2 +-
 audio/audio.c       | 11 ++++++-----
 audio/coreaudio.c   |  5 +++--
 audio/dsoundaudio.c |  2 +-
 audio/noaudio.c     |  2 +-
 audio/ossaudio.c    |  4 ++--
 audio/paaudio.c     |  4 ++--
 audio/sdlaudio.c    |  6 ++++--
 audio/spiceaudio.c  |  2 +-
 audio/wavaudio.c    |  2 +-
 11 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 62829de4e8..d23722ae7c 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -152,7 +152,7 @@ struct audio_driver {
 struct audio_pcm_ops {
     int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque);
     void   (*fini_out)(HWVoiceOut *hw);
-    size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
+    size_t (*write)   (HWVoiceOut *hw, const void *buf, size_t size);
     void   (*run_buffer_out)(HWVoiceOut *hw);
     /*
      * get a buffer that after later can be passed to put_buffer_out; optional
@@ -165,7 +165,7 @@ struct audio_pcm_ops {
      * buf must be equal the pointer returned by get_buffer_out,
      * size may be smaller
      */
-    size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
+    size_t (*put_buffer_out)(HWVoiceOut *hw, const void *buf, size_t size);
     void   (*enable_out)(HWVoiceOut *hw, bool enable);
     void   (*volume_out)(HWVoiceOut *hw, Volume *vol);
 
@@ -173,17 +173,18 @@ struct audio_pcm_ops {
     void   (*fini_in) (HWVoiceIn *hw);
     size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
     void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
-    void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
+    void   (*put_buffer_in)(HWVoiceIn *hw, const void *buf, size_t size);
     void   (*enable_in)(HWVoiceIn *hw, bool enable);
     void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
 };
 
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
-void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
+void audio_generic_put_buffer_in(HWVoiceIn *hw, const void *buf, size_t size);
 void audio_generic_run_buffer_out(HWVoiceOut *hw);
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
-size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size);
-size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size);
+size_t audio_generic_put_buffer_out(HWVoiceOut *hw,
+                                    const void *buf, size_t size);
+size_t audio_generic_write(HWVoiceOut *hw, const void *buf, size_t size);
 size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size);
 
 struct capture_callback {
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index a32db8ff39..7692ee5524 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -608,7 +608,7 @@ static int alsa_open(bool in, struct alsa_params_req *req,
     return -1;
 }
 
-static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
+static size_t alsa_write(HWVoiceOut *hw, const void *buf, size_t len)
 {
     ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
     size_t pos = 0;
diff --git a/audio/audio.c b/audio/audio.c
index c75455bbb5..e2932da4f0 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1253,7 +1253,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
     while (samples) {
         size_t proc;
         size_t size = samples * hw->info.bytes_per_frame;
-        void *buf = hw->pcm_ops->get_buffer_in(hw, &size);
+        const void *buf = hw->pcm_ops->get_buffer_in(hw, &size);
 
         assert(size % hw->info.bytes_per_frame == 0);
         if (size == 0) {
@@ -1425,7 +1425,7 @@ void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size)
     return hw->buf_emul + start;
 }
 
-void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
+void audio_generic_put_buffer_in(HWVoiceIn *hw, const void *buf, size_t size)
 {
     assert(size <= hw->pending_emul);
     hw->pending_emul -= size;
@@ -1468,7 +1468,8 @@ void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
     return hw->buf_emul + hw->pos_emul;
 }
 
-size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
+size_t audio_generic_put_buffer_out(HWVoiceOut *hw,
+                                    const void *buf, size_t size)
 {
     assert(buf == hw->buf_emul + hw->pos_emul &&
            size + hw->pending_emul <= hw->size_emul);
@@ -1479,7 +1480,7 @@ size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
     return size;
 }
 
-size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
+size_t audio_generic_write(HWVoiceOut *hw, const void *buf, size_t size)
 {
     size_t dst_size, copy_size;
     void *dst = hw->pcm_ops->get_buffer_out(hw, &dst_size);
@@ -1491,7 +1492,7 @@ size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
 
 size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
 {
-    void *src = hw->pcm_ops->get_buffer_in(hw, &size);
+    const void *src = hw->pcm_ops->get_buffer_in(hw, &size);
 
     memcpy(buf, src, size);
     hw->pcm_ops->put_buffer_in(hw, src, size);
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 4b4365660f..5258871c9c 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -412,9 +412,10 @@ static int coreaudio_unlock (coreaudioVoiceOut *core, const char *fn_name)
 COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
                        (hw, size))
 COREAUDIO_WRAPPER_FUNC(put_buffer_out, size_t,
-                       (HWVoiceOut *hw, void *buf, size_t size),
+                       (HWVoiceOut *hw, const void *buf, size_t size),
                        (hw, buf, size))
-COREAUDIO_WRAPPER_FUNC(write, size_t, (HWVoiceOut *hw, void *buf, size_t size),
+COREAUDIO_WRAPPER_FUNC(write, size_t,
+                       (HWVoiceOut *hw, const void *buf, size_t size),
                        (hw, buf, size))
 #undef COREAUDIO_WRAPPER_FUNC
 
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 4cdf19ab67..bba6bafda4 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -454,7 +454,7 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
     return ret;
 }
 
-static size_t dsound_put_buffer_out(HWVoiceOut *hw, void *buf, size_t len)
+static size_t dsound_put_buffer_out(HWVoiceOut *hw, const void *buf, size_t len)
 {
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 05798ea210..21995c7d9b 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -41,7 +41,7 @@ typedef struct NoVoiceIn {
     RateCtl rate;
 } NoVoiceIn;
 
-static size_t no_write(HWVoiceOut *hw, void *buf, size_t len)
+static size_t no_write(HWVoiceOut *hw, const void *buf, size_t len)
 {
     NoVoiceOut *no = (NoVoiceOut *) hw;
     return audio_rate_get_bytes(&hw->info, &no->rate, len);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 7778138df5..97bde0256e 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -402,7 +402,7 @@ static void *oss_get_buffer_out(HWVoiceOut *hw, size_t *size)
     }
 }
 
-static size_t oss_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
+static size_t oss_put_buffer_out(HWVoiceOut *hw, const void *buf, size_t size)
 {
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
     if (oss->mmapped) {
@@ -415,7 +415,7 @@ static size_t oss_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
     }
 }
 
-static size_t oss_write(HWVoiceOut *hw, void *buf, size_t len)
+static size_t oss_write(HWVoiceOut *hw, const void *buf, size_t len)
 {
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
     size_t pos;
diff --git a/audio/paaudio.c b/audio/paaudio.c
index b052084698..b50df15ea7 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -125,7 +125,7 @@ unlock_and_fail:
     return NULL;
 }
 
-static void qpa_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
+static void qpa_put_buffer_in(HWVoiceIn *hw, const void *buf, size_t size)
 {
     PAVoiceIn *p = (PAVoiceIn *) hw;
     PAConnection *c = p->g->conn;
@@ -228,7 +228,7 @@ unlock_and_fail:
     return NULL;
 }
 
-static size_t qpa_write(HWVoiceOut *hw, void *data, size_t length)
+static size_t qpa_write(HWVoiceOut *hw, const void *data, size_t length)
 {
     PAVoiceOut *p = (PAVoiceOut *) hw;
     PAConnection *c = p->g->conn;
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 21b7a0484b..9d740186cc 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -256,10 +256,12 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
 SDL_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
                  (hw, size), *size = 0, sdl_unlock)
 SDL_WRAPPER_FUNC(put_buffer_out, size_t,
-                 (HWVoiceOut *hw, void *buf, size_t size), (hw, buf, size),
+                 (HWVoiceOut *hw, const void *buf, size_t size),
+                 (hw, buf, size),
                  /*nothing*/, sdl_unlock_and_post)
 SDL_WRAPPER_FUNC(write, size_t,
-                 (HWVoiceOut *hw, void *buf, size_t size), (hw, buf, size),
+                 (HWVoiceOut *hw, const void *buf, size_t size),
+                 (hw, buf, size),
                  /*nothing*/, sdl_unlock_and_post)
 
 #undef SDL_WRAPPER_FUNC
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index b6b5da4812..0aa6a0a671 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -139,7 +139,7 @@ static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
     return out->frame + out->fpos;
 }
 
-static size_t line_out_put_buffer(HWVoiceOut *hw, void *buf, size_t size)
+static size_t line_out_put_buffer(HWVoiceOut *hw, const void *buf, size_t size)
 {
     SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
 
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 20e6853f85..64d7142a97 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -39,7 +39,7 @@ typedef struct WAVVoiceOut {
     int total_samples;
 } WAVVoiceOut;
 
-static size_t wav_write_out(HWVoiceOut *hw, void *buf, size_t len)
+static size_t wav_write_out(HWVoiceOut *hw, const void *buf, size_t len)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
     int64_t bytes = audio_rate_get_bytes(&hw->info, &wav->rate, len);
-- 
2.21.3


