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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B7C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51648208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLWRQjRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51648208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB485-0006hl-UT
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3uq-0002oz-KN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3uo-0000ex-9O
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:40 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iB3um-0000bf-5o
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:24:37 -0400
Received: by mail-wr1-x42f.google.com with SMTP id h7so4600542wrw.8
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I1lTNtGdmCXDaEAxgrssEq6HlR95R7rdwP0M4w4IEEo=;
 b=SLWRQjRfTBl2M1TNSdQ4dKVNKSadRdGd+XpCibc1dpzIi5FfTtJ/ULTJn4fjhsvEs3
 uzTKHeQ2fL0RRmoXHYy+HNbFOgNRHhodDXoBJ2Dfok4q9GZsFkC5OlgHhTD9OiDFq+mv
 C4RcvvJzRSktwEuF8hiQ78zgftN/R7iIPX0HQsy6F76Rf35J96k7rqUyd6+sVySAso0S
 c+D93kxq06GvJ9V9mbEhIcRZoVKRMgU3WinQhRnlngAUqn1skdNhXBMPZokW/WR7LWck
 yOfsRx0pqhjmowZimLz94L0O2lUIJj79QppziDTuPPm+BGgxr2k4TglgBLUs8vAAwA8l
 /0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I1lTNtGdmCXDaEAxgrssEq6HlR95R7rdwP0M4w4IEEo=;
 b=BY8Ea6ujYBATKGKiCt5kIDz0oLiOffQfPjAKnR7DOKLozGBh8M58QBbj9wIVJFFHsZ
 KsoqT9Edc0UVOkYax8AjVoloe65SU5bM0a6Dgikg8L/DiL3g1b0JuEcSV/FtN4GA/oLS
 3uTFOiWdbbylb9Tk3vR15NuC4LFRrlXZ6dkgisxbhAjg28AXhFWaCvkLrla++0sfYNlc
 1IdgYu0hbmL+CXToqaQGAMaugeEMuYV9nuhKXQ2wbwexSwWoZJuLH3+qVYWaaILGC7Fe
 3V7dQSJ6rmZ7kaMumdHBZIGKxV7m2TGEr98W2lTTKTfxPiXi5Ha8ZaE+jvZkkFKUo/ny
 V4fw==
X-Gm-Message-State: APjAAAVh+geQuuAiLzkd31HfnhbiofVPAxW/4ZiV7CDsAdikpqzOxiZY
 x7ktVZMaWq20euv3GonnWBDa81sd
X-Google-Smtp-Source: APXvYqx2l8reSeyBKZTu2QZYuXmUiH6QPK6syP7WnrUufcjbh2Jp4OP7CSVONRUGLYxiS4jRjxX0WA==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr7861038wru.86.1568928272515; 
 Thu, 19 Sep 2019 14:24:32 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id w125sm13191292wmg.32.2019.09.19.14.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:24:31 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/24] wavaudio: port to the new audio backend api
Date: Thu, 19 Sep 2019 23:24:18 +0200
Message-Id: <eede77aeb9c17b379948b0b6d2ac10f45d74fa62.1568927990.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568927990.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

Notes:
    Changes from v3:
    
    * fix compilation on 32-bit targets

 audio/wavaudio.c | 54 ++++++++----------------------------------------
 1 file changed, 9 insertions(+), 45 deletions(-)

diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index b6eeeb4e26..78af2f1338 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -36,52 +36,28 @@ typedef struct WAVVoiceOut {
     HWVoiceOut hw;
     FILE *f;
     int64_t old_ticks;
-    void *pcm_buf;
     int total_samples;
 } WAVVoiceOut;
 
-static size_t wav_run_out(HWVoiceOut *hw, size_t live)
+static size_t wav_write_out(HWVoiceOut *hw, void *buf, size_t len)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
-    size_t rpos, decr, samples;
-    uint8_t *dst;
-    struct st_sample *src;
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     int64_t ticks = now - wav->old_ticks;
     int64_t bytes =
         muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECOND);
 
-    if (bytes > INT_MAX) {
-        samples = INT_MAX >> hw->info.shift;
-    }
-    else {
-        samples = bytes >> hw->info.shift;
-    }
-
+    bytes = MIN(bytes, len);
+    bytes = bytes >> hw->info.shift << hw->info.shift;
     wav->old_ticks = now;
-    decr = MIN (live, samples);
-    samples = decr;
-    rpos = hw->rpos;
-    while (samples) {
-        int left_till_end_samples = hw->samples - rpos;
-        int convert_samples = MIN (samples, left_till_end_samples);
-
-        src = hw->mix_buf + rpos;
-        dst = advance (wav->pcm_buf, rpos << hw->info.shift);
-
-        hw->clip (dst, src, convert_samples);
-        if (fwrite (dst, convert_samples << hw->info.shift, 1, wav->f) != 1) {
-            dolog ("wav_run_out: fwrite of %d bytes failed\nReaons: %s\n",
-                   convert_samples << hw->info.shift, strerror (errno));
-        }
 
-        rpos = (rpos + convert_samples) % hw->samples;
-        samples -= convert_samples;
-        wav->total_samples += convert_samples;
+    if (bytes && fwrite(buf, bytes, 1, wav->f) != 1) {
+        dolog("wav_write_out: fwrite of %" PRId64 " bytes failed\nReason: %s\n",
+              bytes, strerror(errno));
     }
 
-    hw->rpos = rpos;
-    return decr;
+    wav->total_samples += bytes >> hw->info.shift;
+    return bytes;
 }
 
 /* VICE code: Store number as little endian. */
@@ -137,13 +113,6 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
     audio_pcm_init_info (&hw->info, &wav_as);
 
     hw->samples = 1024;
-    wav->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
-    if (!wav->pcm_buf) {
-        dolog("Could not allocate buffer (%zu bytes)\n",
-              hw->samples << hw->info.shift);
-        return -1;
-    }
-
     le_store (hdr + 22, hw->info.nchannels, 2);
     le_store (hdr + 24, hw->info.freq, 4);
     le_store (hdr + 28, hw->info.freq << (bits16 + stereo), 4);
@@ -153,8 +122,6 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
     if (!wav->f) {
         dolog ("Failed to open wave file `%s'\nReason: %s\n",
                wav_path, strerror(errno));
-        g_free (wav->pcm_buf);
-        wav->pcm_buf = NULL;
         return -1;
     }
 
@@ -208,9 +175,6 @@ static void wav_fini_out (HWVoiceOut *hw)
                wav->f, strerror (errno));
     }
     wav->f = NULL;
-
-    g_free (wav->pcm_buf);
-    wav->pcm_buf = NULL;
 }
 
 static int wav_ctl_out (HWVoiceOut *hw, int cmd, ...)
@@ -234,7 +198,7 @@ static void wav_audio_fini (void *opaque)
 static struct audio_pcm_ops wav_pcm_ops = {
     .init_out = wav_init_out,
     .fini_out = wav_fini_out,
-    .run_out  = wav_run_out,
+    .write    = wav_write_out,
     .ctl_out  = wav_ctl_out,
 };
 
-- 
2.23.0


