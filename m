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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4314CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA2D208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bovBLDSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA2D208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB47s-0006K8-3r
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3uq-0002p1-KV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3uo-0000f5-AX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iB3um-0000c1-6a
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id n14so4593161wrw.9
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9dCYX3ixRkcD+NNYc2l8dezINSISvFmfcL42McUxrm0=;
 b=bovBLDSJNnZOgdbXvDo8RtHwR+LPe/4E4GAsQD0Cc8m4Pg+bf4IrbLTcxMwUGiQE8e
 G/xpt23eZubCz0w1hqlvjr30VNKDxxPAqIJ/WHHhknM0wmdZgUx0bA+CN0VMskTwRMD9
 A9M+3+CmQrh+acr2x1PA3EgzTbCyt+/BQch4P1aafoqiIUHVdG5qLMnqUpJdlOU3zC02
 PMZo7/YBG3RPNb6MId1s8XxaSEhaEMO7QoyWAUVftYVZAt8GB7zdx9vbxV9e52IhBJ+H
 CgMskfQ+qNW2u1X6kt9prMEpaePHPT0CQ+ZnS2J17ASe5FhisLGoxYdt3jOjLwwz/Jbq
 MiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9dCYX3ixRkcD+NNYc2l8dezINSISvFmfcL42McUxrm0=;
 b=oh5HizJZRc/jyFr28t0NyIh7SNdL2QJcxyavCZFC5kDuhhj/tYqd9PuA5iQMR9EOHh
 X93N18SZw0vT9ceAyMVCYf6CUnSKNHSJqqfmUdOD9USaFD+Gs/3y+SKdUjTscGzrP5Hh
 tLQcqJs38w5sfEtanwxeeuei7KhfoVRmiAZsKkLmDDhjrBj2hfR6tchQ8jJLlbRQ0uXS
 OcEItBisbow6dFgW4eH8PXVru+IomLM/D5Uvt9wVZqBX6107MY2Rd9tvvhbEo+EmjWPu
 kax4ySNmSUyhwxIAyx6FFwyPW937W8+U69K6e/FQjlciLtyW2MOV9K9/vkUjgzkPI55G
 uHkA==
X-Gm-Message-State: APjAAAVQGiaF/gRK8pY2EU2HB7pkp8E7ZA1fWJg2sOG9jttod25oKTK6
 PeJ0cARYjMm1OFnDt4rIW8dwU3po
X-Google-Smtp-Source: APXvYqw1z6OfEI2T3e7BW0Ep3EM8RMtg1BGiHKGmZhLHVxnZuroF691FuFpIRmDMW6cE6s53xoaSdQ==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr7984384wru.124.1568928273602; 
 Thu, 19 Sep 2019 14:24:33 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id w125sm13191292wmg.32.2019.09.19.14.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:24:33 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/24] audio: remove remains of the old backend api
Date: Thu, 19 Sep 2019 23:24:19 +0200
Message-Id: <497decab6d0f0fb9529bea63ec7ce0bd7b553038.1568927990.git.DirtY.iCE.hu@gmail.com>
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
 audio/audio.c     | 42 ++++++------------------------------------
 audio/audio_int.h |  7 -------
 2 files changed, 6 insertions(+), 43 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index e29a1e15eb..435bcf20c1 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -541,7 +541,7 @@ static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
     return m;
 }
 
-size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
+static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 {
     size_t live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
     if (audio_bug(__func__, live > hw->samples)) {
@@ -551,29 +551,7 @@ size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
     return live;
 }
 
-size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
-                             size_t live, size_t pending)
-{
-    size_t left = hw->samples - pending;
-    size_t len = MIN (left, live);
-    size_t clipped = 0;
-
-    while (len) {
-        struct st_sample *src = hw->mix_buf + hw->rpos;
-        uint8_t *dst = advance (pcm_buf, hw->rpos << hw->info.shift);
-        size_t samples_till_end_of_buf = hw->samples - hw->rpos;
-        size_t samples_to_clip = MIN (len, samples_till_end_of_buf);
-
-        hw->clip (dst, src, samples_to_clip);
-
-        hw->rpos = (hw->rpos + samples_to_clip) % hw->samples;
-        len -= samples_to_clip;
-        clipped += samples_to_clip;
-    }
-    return clipped;
-}
-
-static void audio_pcm_hw_clip_out2(HWVoiceOut *hw, void *pcm_buf, size_t len)
+static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size_t len)
 {
     size_t clipped = 0;
     size_t pos = hw->rpos;
@@ -1083,7 +1061,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
         }
 
         decr = MIN(size >> hw->info.shift, live);
-        audio_pcm_hw_clip_out2(hw, buf, decr);
+        audio_pcm_hw_clip_out(hw, buf, decr);
         proc = hw->pcm_ops->put_buffer_out(hw, buf, decr << hw->info.shift) >>
             hw->info.shift;
 
@@ -1146,11 +1124,7 @@ static void audio_run_out (AudioState *s)
         }
 
         prev_rpos = hw->rpos;
-        if (hw->pcm_ops->run_out) {
-            played = hw->pcm_ops->run_out(hw, live);
-        } else {
-            played = audio_pcm_hw_run_out(hw, live);
-        }
+        played = audio_pcm_hw_run_out(hw, live);
         replay_audio_out(&played);
         if (audio_bug(__func__, hw->rpos >= hw->samples)) {
             dolog("hw->rpos=%zu hw->samples=%zu played=%zu\n",
@@ -1247,12 +1221,8 @@ static void audio_run_in (AudioState *s)
         size_t captured = 0, min;
 
         if (replay_mode != REPLAY_MODE_PLAY) {
-            if (hw->pcm_ops->run_in) {
-                captured = hw->pcm_ops->run_in(hw);
-            } else {
-                captured = audio_pcm_hw_run_in(
-                    hw, hw->samples - audio_pcm_hw_get_live_in(hw));
-            }
+            captured = audio_pcm_hw_run_in(
+                hw, hw->samples - audio_pcm_hw_get_live_in(hw));
         }
         replay_audio_in(&captured, hw->conv_buf, &hw->wpos, hw->samples);
 
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 8fb1ca8a8d..c76d7c39e8 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -153,7 +153,6 @@ struct audio_driver {
 struct audio_pcm_ops {
     int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque);
     void   (*fini_out)(HWVoiceOut *hw);
-    size_t (*run_out)(HWVoiceOut *hw, size_t live);
     size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
     /*
      * get a buffer that after later can be passed to put_buffer_out; optional
@@ -171,7 +170,6 @@ struct audio_pcm_ops {
 
     int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
     void   (*fini_in) (HWVoiceIn *hw);
-    size_t (*run_in)(HWVoiceIn *hw);
     size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
     void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
     void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
@@ -237,11 +235,6 @@ audio_driver *audio_driver_lookup(const char *name);
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
-size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw);
-
-size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
-                             size_t live, size_t pending);
-
 int audio_bug (const char *funcname, int cond);
 void *audio_calloc (const char *funcname, int nmemb, size_t size);
 
-- 
2.23.0


