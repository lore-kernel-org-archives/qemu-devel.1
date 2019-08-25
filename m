Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A81C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C35C206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHdQaZNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C35C206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1xjv-0007uO-KK
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 14:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXN-0001Ku-4d
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXK-0004qK-KV
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:48 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i1xXK-0004qF-En
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:46 -0400
Received: by mail-qt1-x842.google.com with SMTP id k13so15898787qtm.12
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QWx7MtqrRc8xgEdiyrtd5mUXPk2saBAqXwz+E0km/ck=;
 b=XHdQaZNMPWEOj3+35f0S5s+qlEjPhEszc20Vh0vWrldwhSx1gqg2q+5PJmLPzF2WMl
 I8KgvmeTZcXEFRzI/sJQCFT1+nukNg3Bp/lgDM/2TAesybSnehECoWSKwr9sz+s94orm
 nTOgbgyl4ccZXf7gPwcNkvFZBsJVLKYcs9V7VD+FVsnk6LuXcsttsb8a05/J4Ujes8v1
 SUO5wEM/pfw3g88AwUnfxrWaEvD6JPKT/Tr0HS6IPQxJLsNlykn/gtfLdmcPsVt9tYqQ
 05RsnMhwR1Q2Q7TevzTzasN17eXZtuzIxVPQ9DrBe1iXGKbn8F+u775gSU8SM8o3gEGq
 L0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QWx7MtqrRc8xgEdiyrtd5mUXPk2saBAqXwz+E0km/ck=;
 b=kPLURhJaRXfGmgk+6AlIYttuELpkASgn1y/6KQ+DgipszXqHFa2AmYgwD5ZKOzdydd
 efGnkyqkrJJKzaIOm/19FCoRQgv/2Pazhr4SlFH+f0Z0nm3jrNqLHSHjJHbQWSVouxEP
 6nFKiopcvydG6Fkb9C63jqJ6aGetfHAe3c56Mw2MCXRAyHJRgnIuVJTzjk6x3K2hmxSw
 90H/ZoYJ3CnztWnM0wqBViierGqGZS0wBfrOhUZibF+Ay1+iHOiDJF0kQKjkaVie9bSB
 Q6VTM0PeFuzZW+y3+a29SYZczT3lpBZEVIjXdMZ2f7vYBrcfo7GysrglhpZhhFJ2PT+y
 ox9A==
X-Gm-Message-State: APjAAAVXk1BvT9ngV10NOQPxwjGlWupG8QEFOQFTvA7Zl96EpSnqgPKS
 HrNneiDSlS1Kian7T5t59pGfNiLFRus=
X-Google-Smtp-Source: APXvYqzu8mXR04814JV7aOMtN9L9IxgYKXOvDpSy39jNb3d0QzkAi10/yEjW+K2yujYpN+D2gH5VhA==
X-Received: by 2002:ac8:2b47:: with SMTP id 7mr14834697qtv.116.1566758805621; 
 Sun, 25 Aug 2019 11:46:45 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id d3sm5348870qtq.32.2019.08.25.11.46.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:46:45 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 20:46:15 +0200
Message-Id: <13e6e43861c2868b65ba580e8104e6ad7ed7e7ad.1566755452.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH 13/25] audio: remove hw->samples,
 buffer_size_in/out pcm_ops
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

This patch removes the samples member from HWVoiceIn and HWVoiceOut.
Backends can specify buffer size via the newly added buffer_size_in and
buffer_size_out functions in audio_pcm_ops.  They are optional, if not
defined qemu will fall back to some built-in constant.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---

Notes:
    Not sure if this is necessary.  At first it seemed like a good idea to
    have a function so that backends can compute the size on demand when
    needed and things like that, but currently it's just a burden.  The only
    good feature is that it allows a backend to not define a function and
    let the audio subsystem choose a default value, but the same could be
    achieved by specifying that hw->samples = 0 means use a default value.
    
    So if you guys agree, I'll remove this patch.  Maybe add an -audiodev
    parameter to change it, overriding whatever the backends supplies.

 audio/audio_int.h       |  5 +++--
 audio/audio_template.h  | 24 +++++++++++++++---------
 audio/dsound_template.h |  8 +++++++-
 audio/alsaaudio.c       | 20 ++++++++++++++++++--
 audio/audio.c           |  2 --
 audio/coreaudio.c       | 10 +++++++++-
 audio/dsoundaudio.c     |  4 ++++
 audio/noaudio.c         |  2 --
 audio/ossaudio.c        | 22 +++++++++++++++++++---
 audio/paaudio.c         | 19 +++++++++++++++++--
 audio/sdlaudio.c        | 10 +++++++++-
 audio/spiceaudio.c      | 14 ++++++++++++--
 audio/wavaudio.c        |  1 -
 13 files changed, 113 insertions(+), 28 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 20021df9e8..65112b490a 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -71,7 +71,6 @@ typedef struct HWVoiceOut {
     void *buf_emul;
     size_t pos_emul, pending_emul, size_emul;
 
-    size_t samples;
     QLIST_HEAD (sw_out_listhead, SWVoiceOut) sw_head;
     QLIST_HEAD (sw_cap_listhead, SWVoiceCap) cap_head;
     int ctl_caps;
@@ -94,7 +93,6 @@ typedef struct HWVoiceIn {
     void *buf_emul;
     size_t pos_emul, pending_emul, size_emul;
 
-    size_t samples;
     QLIST_HEAD (sw_in_listhead, SWVoiceIn) sw_head;
     int ctl_caps;
     struct audio_pcm_ops *pcm_ops;
@@ -156,6 +154,8 @@ struct audio_pcm_ops {
     int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque);
     void   (*fini_out)(HWVoiceOut *hw);
     size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
+    /* get the optimal buffer size in samples; optional */
+    size_t (*buffer_size_out)(HWVoiceOut *hw);
     /*
      * get a buffer that after later can be passed to put_buffer_out; optional
      * returns the buffer, and writes it's size to size (in bytes)
@@ -173,6 +173,7 @@ struct audio_pcm_ops {
     int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
     void   (*fini_in) (HWVoiceIn *hw);
     size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
+    size_t (*buffer_size_in)(HWVoiceIn *hw);
     void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
     void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
     int    (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 87c6d2d271..700732dc17 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -78,7 +78,20 @@ static void glue (audio_pcm_hw_free_resources_, TYPE) (HW *hw)
 
 static void glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
 {
-    size_t samples = hw->samples;
+    size_t samples;
+    if (!hw->pcm_ops) {
+        /*
+         * We should only end up here when using wavcapture hmp command (and not
+         * the wavcapture audio backend).
+         * It needs a lot of samples, otherwise you'll end up with "Could not
+         * mix X bytes into a capture buffer" warnings and a garbled capture.
+         */
+        samples = 4096 * 4;
+    } else if (hw->pcm_ops->glue(buffer_size_, TYPE)) {
+        samples = hw->pcm_ops->glue(buffer_size_, TYPE)(hw);
+    } else {
+        samples = 1024; /* todo better default */
+    }
     if (audio_bug(__func__, samples == 0)) {
         dolog("Attempted to allocate empty buffer\n");
     }
@@ -264,11 +277,6 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
         goto err0;
     }
 
-    if (audio_bug(__func__, hw->samples <= 0)) {
-        dolog("hw->samples=%zd\n", hw->samples);
-        goto err1;
-    }
-
 #ifdef DAC
     hw->clip = mixeng_clip
 #else
@@ -288,9 +296,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
 #endif
     return hw;
 
- err1:
-    glue (hw->pcm_ops->fini_, TYPE) (hw);
- err0:
+err0:
     g_free (hw);
     return NULL;
 }
diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index 9f10b688df..8cc5d69f36 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -254,7 +254,7 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
             );
     }
     hw->size_emul = bc.dwBufferBytes;
-    hw->samples = bc.dwBufferBytes >> hw->info.shift;
+    ds->samples = bc.dwBufferBytes >> hw->info.shift;
     ds->s = s;
 
 #ifdef DEBUG_DSOUND
@@ -268,6 +268,12 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
     return -1;
 }
 
+static size_t glue(dsound_buffer_size_, TYPE)(HWVOICE *hw)
+{
+    DSOUNDVOICE *ds = (DSOUNDVOICE *) hw;
+    return ds->samples;
+}
+
 #undef NAME
 #undef NAME2
 #undef TYPE
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 19124d09d8..4b16869a1d 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -45,6 +45,7 @@ struct pollhlp {
 typedef struct ALSAVoiceOut {
     HWVoiceOut hw;
     snd_pcm_t *handle;
+    size_t samples;
     struct pollhlp pollhlp;
     Audiodev *dev;
 } ALSAVoiceOut;
@@ -52,6 +53,7 @@ typedef struct ALSAVoiceOut {
 typedef struct ALSAVoiceIn {
     HWVoiceIn hw;
     snd_pcm_t *handle;
+    size_t samples;
     struct pollhlp pollhlp;
     Audiodev *dev;
 } ALSAVoiceIn;
@@ -690,7 +692,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
     obt_as.endianness = obt.endianness;
 
     audio_pcm_init_info (&hw->info, &obt_as);
-    hw->samples = obt.samples;
+    alsa->samples = obt.samples;
 
     alsa->pollhlp.s = hw->s;
     alsa->handle = handle;
@@ -698,6 +700,12 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
     return 0;
 }
 
+static size_t alsa_buffer_size_out(HWVoiceOut *hw)
+{
+    ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
+    return alsa->samples;
+}
+
 #define VOICE_CTL_PAUSE 0
 #define VOICE_CTL_PREPARE 1
 #define VOICE_CTL_START 2
@@ -784,7 +792,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     obt_as.endianness = obt.endianness;
 
     audio_pcm_init_info (&hw->info, &obt_as);
-    hw->samples = obt.samples;
+    alsa->samples = obt.samples;
 
     alsa->pollhlp.s = hw->s;
     alsa->handle = handle;
@@ -792,6 +800,12 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     return 0;
 }
 
+static size_t alsa_buffer_size_in(HWVoiceIn *hw)
+{
+    ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
+    return alsa->samples;
+}
+
 static void alsa_fini_in (HWVoiceIn *hw)
 {
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
@@ -923,11 +937,13 @@ static void alsa_audio_fini (void *opaque)
 static struct audio_pcm_ops alsa_pcm_ops = {
     .init_out = alsa_init_out,
     .fini_out = alsa_fini_out,
+    .buffer_size_out = alsa_buffer_size_out,
     .write    = alsa_write,
     .ctl_out  = alsa_ctl_out,
 
     .init_in  = alsa_init_in,
     .fini_in  = alsa_fini_in,
+    .buffer_size_in = alsa_buffer_size_in,
     .read     = alsa_read,
     .ctl_in   = alsa_ctl_in,
 };
diff --git a/audio/audio.c b/audio/audio.c
index e571eba6a1..2b77a87823 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1761,8 +1761,6 @@ CaptureVoiceOut *AUD_add_capture(
         QLIST_INIT (&hw->sw_head);
         QLIST_INIT (&cap->cb_head);
 
-        /* XXX find a more elegant way */
-        hw->samples = 4096 * 4;
         audio_pcm_hw_alloc_resources_out(hw);
 
         audio_pcm_init_info (&hw->info, as);
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 5cde42f982..f60b87a938 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -43,6 +43,7 @@ typedef struct coreaudioVoiceOut {
     UInt32 audioDevicePropertyBufferFrameSize;
     AudioStreamBasicDescription outputStreamBasicDescription;
     AudioDeviceIOProcID ioprocid;
+    size_t samples;
 } coreaudioVoiceOut;
 
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_6
@@ -557,7 +558,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
                            "Could not get device buffer frame size\n");
         return -1;
     }
-    hw->samples = (cpdo->has_buffer_count ? cpdo->buffer_count : 4) *
+    core->samples = (cpdo->has_buffer_count ? cpdo->buffer_count : 4) *
         core->audioDevicePropertyBufferFrameSize;
 
     /* get StreamFormat */
@@ -617,6 +618,12 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
     return 0;
 }
 
+static size_t coreaudio_buffer_size_out(HWVoiceOut *hw)
+{
+    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
+    return core->samples;
+}
+
 static void coreaudio_fini_out (HWVoiceOut *hw)
 {
     OSStatus status;
@@ -693,6 +700,7 @@ static struct audio_pcm_ops coreaudio_pcm_ops = {
     .init_out = coreaudio_init_out,
     .fini_out = coreaudio_fini_out,
     .write    = coreaudio_write,
+    .buffer_size_out = coreaudio_buffer_size_out,
     .get_buffer_out = coreaudio_get_buffer_out,
     .put_buffer_out = coreaudio_put_buffer_out_nowrite,
     .ctl_out  = coreaudio_ctl_out
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 96693a97e5..b0d3d97eac 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -54,12 +54,14 @@ typedef struct {
     HWVoiceOut hw;
     LPDIRECTSOUNDBUFFER dsound_buffer;
     dsound *s;
+    size_t samples;
 } DSoundVoiceOut;
 
 typedef struct {
     HWVoiceIn hw;
     LPDIRECTSOUNDCAPTUREBUFFER dsound_capture_buffer;
     dsound *s;
+    size_t samples;
 } DSoundVoiceIn;
 
 static void dsound_log_hresult (HRESULT hr)
@@ -672,6 +674,7 @@ static struct audio_pcm_ops dsound_pcm_ops = {
     .init_out = dsound_init_out,
     .fini_out = dsound_fini_out,
     .write    = audio_generic_write,
+    .buffer_size_out = dsound_buffer_size_out,
     .get_buffer_out = dsound_get_buffer_out,
     .put_buffer_out = dsound_put_buffer_out,
     .ctl_out  = dsound_ctl_out,
@@ -679,6 +682,7 @@ static struct audio_pcm_ops dsound_pcm_ops = {
     .init_in  = dsound_init_in,
     .fini_in  = dsound_fini_in,
     .read     = audio_generic_read,
+    .buffer_size_in = dsound_buffer_size_in,
     .get_buffer_in = dsound_get_buffer_in,
     .put_buffer_in = dsound_put_buffer_in,
     .ctl_in   = dsound_ctl_in
diff --git a/audio/noaudio.c b/audio/noaudio.c
index b054fd225b..f4b9d09d84 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -59,7 +59,6 @@ static size_t no_write(HWVoiceOut *hw, void *buf, size_t len)
 static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
 {
     audio_pcm_init_info (&hw->info, as);
-    hw->samples = 1024;
     return 0;
 }
 
@@ -78,7 +77,6 @@ static int no_ctl_out (HWVoiceOut *hw, int cmd, ...)
 static int no_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 {
     audio_pcm_init_info (&hw->info, as);
-    hw->samples = 1024;
     return 0;
 }
 
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 76c082d5e2..fc401baa14 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -44,6 +44,7 @@ typedef struct OSSVoiceOut {
     int nfrags;
     int fragsize;
     int mmapped;
+    size_t samples;
     Audiodev *dev;
 } OSSVoiceOut;
 
@@ -52,6 +53,7 @@ typedef struct OSSVoiceIn {
     int fd;
     int nfrags;
     int fragsize;
+    size_t samples;
     Audiodev *dev;
 } OSSVoiceIn;
 
@@ -511,11 +513,11 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
                obt.nfrags * obt.fragsize, hw->info.align + 1);
     }
 
-    hw->samples = (obt.nfrags * obt.fragsize) >> hw->info.shift;
+    oss->samples = (obt.nfrags * obt.fragsize) >> hw->info.shift;
 
     oss->mmapped = 0;
     if (oopts->has_try_mmap && oopts->try_mmap) {
-        hw->size_emul = hw->samples << hw->info.shift;
+        hw->size_emul = oss->samples << hw->info.shift;
         hw->buf_emul = mmap(
             NULL,
             hw->size_emul,
@@ -563,6 +565,12 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
     return 0;
 }
 
+static size_t oss_buffer_size_out(HWVoiceOut *hw)
+{
+    OSSVoiceOut *oss = (OSSVoiceOut *) hw;
+    return oss->samples;
+}
+
 static int oss_ctl_out (HWVoiceOut *hw, int cmd, ...)
 {
     int trig;
@@ -659,13 +667,19 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
                obt.nfrags * obt.fragsize, hw->info.align + 1);
     }
 
-    hw->samples = (obt.nfrags * obt.fragsize) >> hw->info.shift;
+    oss->samples = (obt.nfrags * obt.fragsize) >> hw->info.shift;
 
     oss->fd = fd;
     oss->dev = dev;
     return 0;
 }
 
+static size_t oss_buffer_size_in(HWVoiceIn *hw)
+{
+    OSSVoiceIn *oss = (OSSVoiceIn *) hw;
+    return oss->samples;
+}
+
 static void oss_fini_in (HWVoiceIn *hw)
 {
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
@@ -765,6 +779,7 @@ static struct audio_pcm_ops oss_pcm_ops = {
     .init_out = oss_init_out,
     .fini_out = oss_fini_out,
     .write    = oss_write,
+    .buffer_size_out = oss_buffer_size_out,
     .get_buffer_out = oss_get_buffer_out,
     .put_buffer_out = oss_put_buffer_out,
     .ctl_out  = oss_ctl_out,
@@ -772,6 +787,7 @@ static struct audio_pcm_ops oss_pcm_ops = {
     .init_in  = oss_init_in,
     .fini_in  = oss_fini_in,
     .read     = oss_read,
+    .buffer_size_in = oss_buffer_size_in,
     .ctl_in   = oss_ctl_in
 };
 
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 75fce53202..977a464650 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -352,7 +352,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
     }
 
     audio_pcm_init_info (&hw->info, &obt_as);
-    hw->samples = pa->samples = audio_buffer_samples(
+    pa->samples = audio_buffer_samples(
         qapi_AudiodevPaPerDirectionOptions_base(ppdo),
         &obt_as, ppdo->buffer_length);
 
@@ -362,6 +362,13 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
     return -1;
 }
 
+static size_t qpa_buffer_size_out(HWVoiceOut *hw)
+{
+    PAVoiceOut *pa = (PAVoiceOut *) hw;
+    return pa->samples;
+}
+
+
 static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 {
     int error;
@@ -401,7 +408,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     }
 
     audio_pcm_init_info (&hw->info, &obt_as);
-    hw->samples = pa->samples = audio_buffer_samples(
+    pa->samples = audio_buffer_samples(
         qapi_AudiodevPaPerDirectionOptions_base(ppdo),
         &obt_as, ppdo->buffer_length);
 
@@ -411,6 +418,12 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     return -1;
 }
 
+static size_t qpa_buffer_size_in(HWVoiceIn *hw)
+{
+    PAVoiceIn *pa = (PAVoiceIn *) hw;
+    return pa->samples;
+}
+
 static void qpa_simple_disconnect(PAConnection *c, pa_stream *stream)
 {
     int err;
@@ -724,11 +737,13 @@ static struct audio_pcm_ops qpa_pcm_ops = {
     .init_out = qpa_init_out,
     .fini_out = qpa_fini_out,
     .write    = qpa_write,
+    .buffer_size_out = qpa_buffer_size_out,
     .ctl_out  = qpa_ctl_out,
 
     .init_in  = qpa_init_in,
     .fini_in  = qpa_fini_in,
     .read     = qpa_read,
+    .buffer_size_in = qpa_buffer_size_in,
     .ctl_in   = qpa_ctl_in
 };
 
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index f7ac8cd101..560fb0a95d 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -41,6 +41,7 @@
 
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
+    size_t samples;
 } SDLVoiceOut;
 
 static struct SDLAudioState {
@@ -277,7 +278,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
     obt_as.endianness = endianness;
 
     audio_pcm_init_info (&hw->info, &obt_as);
-    hw->samples = obt.samples;
+    sdl->samples = obt.samples;
 
     s->initialized = 1;
     s->exit = 0;
@@ -285,6 +286,12 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
     return 0;
 }
 
+static size_t sdl_buffer_size_out(HWVoiceOut *hw)
+{
+    SDLVoiceOut *sdl = (SDLVoiceOut *) hw;
+    return sdl->samples;
+}
+
 static int sdl_ctl_out (HWVoiceOut *hw, int cmd, ...)
 {
     (void) hw;
@@ -332,6 +339,7 @@ static struct audio_pcm_ops sdl_pcm_ops = {
     .init_out = sdl_init_out,
     .fini_out = sdl_fini_out,
     .write    = sdl_write,
+    .buffer_size_out = sdl_buffer_size_out,
     .get_buffer_out = sdl_get_buffer_out,
     .put_buffer_out = sdl_put_buffer_out_nowrite,
     .ctl_out  = sdl_ctl_out,
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 092ad27e20..02e97095fc 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -133,7 +133,6 @@ static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
     settings.endianness = AUDIO_HOST_ENDIANNESS;
 
     audio_pcm_init_info (&hw->info, &settings);
-    hw->samples = LINE_OUT_SAMPLES;
     out->active = 0;
 
     out->sin.base.sif = &playback_sif.base;
@@ -144,6 +143,11 @@ static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
     return 0;
 }
 
+static size_t line_out_buffer_size(HWVoiceOut *hw)
+{
+    return LINE_OUT_SAMPLES;
+}
+
 static void line_out_fini (HWVoiceOut *hw)
 {
     SpiceVoiceOut *out = container_of (hw, SpiceVoiceOut, hw);
@@ -248,7 +252,6 @@ static int line_in_init(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     settings.endianness = AUDIO_HOST_ENDIANNESS;
 
     audio_pcm_init_info (&hw->info, &settings);
-    hw->samples = LINE_IN_SAMPLES;
     in->active = 0;
 
     in->sin.base.sif = &record_sif.base;
@@ -259,6 +262,11 @@ static int line_in_init(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     return 0;
 }
 
+static size_t line_in_buffer_size(HWVoiceIn *hw)
+{
+    return LINE_IN_SAMPLES;
+}
+
 static void line_in_fini (HWVoiceIn *hw)
 {
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
@@ -329,6 +337,7 @@ static struct audio_pcm_ops audio_callbacks = {
     .init_out = line_out_init,
     .fini_out = line_out_fini,
     .write    = audio_generic_write,
+    .buffer_size_out = line_out_buffer_size,
     .get_buffer_out = line_out_get_buffer,
     .put_buffer_out = line_out_put_buffer,
     .ctl_out  = line_out_ctl,
@@ -336,6 +345,7 @@ static struct audio_pcm_ops audio_callbacks = {
     .init_in  = line_in_init,
     .fini_in  = line_in_fini,
     .read     = line_in_read,
+    .buffer_size_in = line_in_buffer_size,
     .ctl_in   = line_in_ctl,
 };
 
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 7816097db8..427825c8d8 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -112,7 +112,6 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
     wav_as.endianness = 0;
     audio_pcm_init_info (&hw->info, &wav_as);
 
-    hw->samples = 1024;
     le_store (hdr + 22, hw->info.nchannels, 2);
     le_store (hdr + 24, hw->info.freq, 4);
     le_store (hdr + 28, hw->info.freq << (bits16 + stereo), 4);
-- 
2.22.0


