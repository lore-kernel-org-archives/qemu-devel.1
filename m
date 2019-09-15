Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5039BC4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8D120830
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxrc3HbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8D120830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9aM4-00048N-PD
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7j-00064t-F6
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7i-000205-7T
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:51 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:43268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i9a7i-0001zm-1J
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:50 -0400
Received: by mail-ed1-x544.google.com with SMTP id r9so2479943edl.10
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9dCYX3ixRkcD+NNYc2l8dezINSISvFmfcL42McUxrm0=;
 b=Oxrc3HbDFv0VE8A1hAuYbG+RvILfBVc5EV9WDqUev2C2h5UVlo17gVBYlqUfZZbo8I
 waZoLme/ubAFLHkJuDYrkfW6usx47CwdH+VQE3U+w53bt4f6brIKEbcpRH6Vi/kQtO9m
 ZAmfTJQJI+gxca740PNxbkeU/kLoc1cLT7JbcOhKpQDjymKlo7Eb/SZWChXjhAmjNY3i
 1hYe2lZPb51PDdnRvjRH+QeEH5WH+9eFJtfsh5M8tQ+vyhShf4OxToDhUWvxBPj6ik/S
 Ngy0+tD1MXos2oHusyGMfyewYxgw1omNygwlrq/ajwsn0gBZNIZAKpJp21IfnTEjdjgB
 KckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9dCYX3ixRkcD+NNYc2l8dezINSISvFmfcL42McUxrm0=;
 b=nSTbFNyK1T3KtfjMezTiV/Mlv/RR0dHPajYWm0pQOSzu2hX7fsh2Kzjl/FA7OSu0mU
 bok5EB6jfgu+oijHJVRE7ji1wvZF7Evqr1IOltnTQQFmovwXKpyQ6eEChUhWdBzbM9bR
 S4XKDoV31tbSOBsJZLRKsH8iEU14VPg2BeyQ8SXRVPPF+mVmSLmO/NuLL8YPf1jWcD1q
 d3ScAEVBA79rBcsHaBEl55x6vRs69vfjip8xZY3KIMmpRs+CRp5mAnga7X6kXCNcbBMl
 hnGix6RpUlG9QgJAeuoTAV40/M/Uch3jYasGpV6JC/d3m0jnl9Ri6sgk+DseUEPRWQcf
 JrXg==
X-Gm-Message-State: APjAAAXInJNglB6fCbpot2+AaY5YxHXFt2sw9dD+Tfe3xO5dciW/CHhD
 Mw3jSX3AvNVtJBN4M+UjgTxt5j5y
X-Google-Smtp-Source: APXvYqyzBNQj4bwnj0LksNURWUvCwp07+Aq8CBg1kbCUlwLMTSKCvr0qTmQEXjSqPhGzpwO2lLmSbQ==
X-Received: by 2002:a05:6402:1854:: with SMTP id
 v20mr58357072edy.43.1568575428840; 
 Sun, 15 Sep 2019 12:23:48 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id j20sm6480562edy.95.2019.09.15.12.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 12:23:48 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 21:23:27 +0200
Message-Id: <3c160307074a29e5826a89994ab7cfdee7b8ccf8.1568574965.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: [Qemu-devel] [PATCH v3 11/24] audio: remove remains of the old
 backend api
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


