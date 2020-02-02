Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BAAC35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 23:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5438205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 23:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe/YcyDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5438205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyOGg-00058Y-4s
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 18:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iyOG3-0004hc-ML
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 18:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iyOG2-0007Xi-F3
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 18:02:27 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iyOG2-0007XO-91
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 18:02:26 -0500
Received: by mail-wm1-x341.google.com with SMTP id s10so13877181wmh.3
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 15:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Fmuyz3P5+ywdNdma6wS4elFvf+a58uc9gkhIMU+w1/s=;
 b=Xe/YcyDXAH3p0/D8+GWFPR+yXMNap4CWB+Z2Gu97SROloDCmz26kER3SgLh5IFhONj
 YyDVMfkP+RB59BhFoO2OQ7B1S6Jig5TnLkgv+0BQYZKY9D1o+fsSzrjTqPPlx8qf1Kyw
 HnFcIgpbN5xcBOGZyLOyGN4F/xcK5a2qeWq8dpyGFzhApAIHAWV3Y0DbpdrMRbbsfCfL
 gTk8i9FRljX04M895tjHBcYIvNicL5S76799jE6tksHYaq/J9rWy89sEqBUVb1ClN1/d
 STHKE8TJ5VK8QNhFSnDJ1gyjen6lqANb5VHe1de1z12bt4mELh+sMdK6o8mpN8VOmQfR
 kWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Fmuyz3P5+ywdNdma6wS4elFvf+a58uc9gkhIMU+w1/s=;
 b=CaEAIzDKjTzyPY445Hkc1rDCRZoF28o3zvbp8/P+LbJvPtH6dQlT33xuM+X1ZSBdY0
 C2EQjp8po6rSaOIFkTmFcdpIhy2iTrgsNJhfq0gMCq3d/DuEoInCFxODqH+Jpp+ma2SR
 DZQ/fNgQ6DvMyTKQGf/TPFZoQNyBQe1fp/B2bk3RUVF+iJHcavXVKG4hYB26gQuMYnIx
 myN2iV+nnSz5JnMVojdL5bG9w2oPu8zo/arHqcwoQd4+5YzocgN/mmz9KwgBXumtZ5Bb
 5yltOoIBdC32GRD089X6E9lYpK8TNVgO2u33cEwdQB5CuoD2GG74QJ+10lPfHBVBynjq
 iipw==
X-Gm-Message-State: APjAAAVXXpNKz625MmLW7y8hlM+ICRI2UFQUWS5RkhMQwGqSAjakJqWg
 cGjStuUmlPFWPPJIkl2q5lOez43y
X-Google-Smtp-Source: APXvYqy0/c3mG+Dzqp3muju5D1hqSoRdNmNjDFIL4bjt+zvga/z+d1s6KzO7PD68/IktgAPt4H2Ahg==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr24223074wmj.7.1580684544937;
 Sun, 02 Feb 2020 15:02:24 -0800 (PST)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-48e2-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:48e2::5])
 by smtp.gmail.com with ESMTPSA id l17sm22033276wro.77.2020.02.02.15.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2020 15:02:24 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] audio/dsound: fix invalid parameters error
Date: Mon,  3 Feb 2020 00:02:23 +0100
Message-Id: <fe9744216d9d421a2dbb09bcf5fa0dbd18f77ac5.1580684275.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, KJ Liew <liewkj@yahoo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Windows (unlike wine) bails out when IDirectSoundBuffer8::Lock is called
with zero length.  Also, hw->pos_emul handling was incorrect when
calling this function for the first time.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
Reported-by: KJ Liew <liewkj@yahoo.com>
---

I've tested this patch on wine and a borrowed Windows 8.1 laptop, I
could only test audio playback, not recording.  I've cross-compiled qemu
using the docker image, for 64-bit.

---
 audio/dsound_template.h |  1 +
 audio/audio.c           |  6 ++----
 audio/dsoundaudio.c     | 27 +++++++++++++++++++++++----
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index 7a15f91ce5..9c5ce625ab 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -244,6 +244,7 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
         goto fail0;
     }
 
+    ds->first_time = true;
     obt_as.endianness = 0;
     audio_pcm_init_info (&hw->info, &obt_as);
 
diff --git a/audio/audio.c b/audio/audio.c
index f63f39769a..cb1efc6dc5 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1076,10 +1076,8 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
     while (live) {
         size_t size, decr, proc;
         void *buf = hw->pcm_ops->get_buffer_out(hw, &size);
-        if (!buf) {
-            /* retrying will likely won't help, drop everything. */
-            hw->mix_buf->pos = (hw->mix_buf->pos + live) % hw->mix_buf->size;
-            return clipped + live;
+        if (!buf || size == 0) {
+            break;
         }
 
         decr = MIN(size / hw->info.bytes_per_frame, live);
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index c265c0094b..bd57082a8d 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -53,12 +53,14 @@ typedef struct {
 typedef struct {
     HWVoiceOut hw;
     LPDIRECTSOUNDBUFFER dsound_buffer;
+    bool first_time;
     dsound *s;
 } DSoundVoiceOut;
 
 typedef struct {
     HWVoiceIn hw;
     LPDIRECTSOUNDCAPTUREBUFFER dsound_capture_buffer;
+    bool first_time;
     dsound *s;
 } DSoundVoiceIn;
 
@@ -414,21 +416,32 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
     HRESULT hr;
-    DWORD ppos, act_size;
+    DWORD ppos, wpos, act_size;
     size_t req_size;
     int err;
     void *ret;
 
-    hr = IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL);
+    hr = IDirectSoundBuffer_GetCurrentPosition(
+        dsb, &ppos, ds->first_time ? &wpos : NULL);
     if (FAILED(hr)) {
         dsound_logerr(hr, "Could not get playback buffer position\n");
         *size = 0;
         return NULL;
     }
 
+    if (ds->first_time) {
+        hw->pos_emul = wpos;
+        ds->first_time = false;
+    }
+
     req_size = audio_ring_dist(ppos, hw->pos_emul, hw->size_emul);
     req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
 
+    if (req_size == 0) {
+        *size = 0;
+        return NULL;
+    }
+
     err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
                           &act_size, NULL, false, ds->s);
     if (err) {
@@ -508,18 +521,24 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t *size)
     DSoundVoiceIn *ds = (DSoundVoiceIn *) hw;
     LPDIRECTSOUNDCAPTUREBUFFER dscb = ds->dsound_capture_buffer;
     HRESULT hr;
-    DWORD cpos, act_size;
+    DWORD cpos, rpos, act_size;
     size_t req_size;
     int err;
     void *ret;
 
-    hr = IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, &cpos, NULL);
+    hr = IDirectSoundCaptureBuffer_GetCurrentPosition(
+        dscb, &cpos, ds->first_time ? &rpos : NULL);
     if (FAILED(hr)) {
         dsound_logerr(hr, "Could not get capture buffer position\n");
         *size = 0;
         return NULL;
     }
 
+    if (ds->first_time) {
+        hw->pos_emul = rpos;
+        ds->first_time = false;
+    }
+
     req_size = audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
     req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
 
-- 
2.25.0


