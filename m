Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B26BC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0DA20661
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJUYNhWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0DA20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxbK-00077E-2l
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaN-0005tj-D9
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:11 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:37509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaM-0001ui-MW
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:11 -0400
Received: by mail-wm1-x330.google.com with SMTP id z6so2346454wml.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rAEuZ8BlbOB2hvjhhWM7SZsUeKxbxuDnArENiMPJJhA=;
 b=vJUYNhWcVOm7HfQJOjUP99kvxBwwUngDNSwCUsdU5UWdtue4++0j3OEUf2XyNyuYAU
 uLEyUmN9eaPJO1i0AVqkTpo5rlgdVv43xMcwyL90gbi+xSbplw6f0UJyCnSUiE++Wy3A
 BcuIhyAb9xouASIyFadGBkz3Q1fgBDPhU0O2DPLECk48BhV+OaCgzZyQs/v5kbzeAAEe
 mOPfu7VUXl3T1pa0nG6xTsdoUrnnzSbBg0efojBm9Cdx2oyi1L77kkdzPio8FPGS3aTk
 5geHdjGnQemwUw535yXSZGhsNLbtXZ/sIyVTv0y05/utZ9BvRn9rlDpt0d71jewv8VJc
 xX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rAEuZ8BlbOB2hvjhhWM7SZsUeKxbxuDnArENiMPJJhA=;
 b=dbFLdJ8iYZWK7lodnX2tAkRauQRGEYTdzzvctJJs6fzRYUdQGax6dT9Vg/ve2Gew7+
 gO8d7pdL8rbFEQbAR8nHB+oCnCjt4vE9BrYo3heQYPh/eUHv+Bwg1ncbQtiu9RRqzk91
 9hp34DlwCZMuN3o3HUR+lsp+AdQajRRz59cshzJ73kK0H9OoZFChcTgFRVOFywfRTWq3
 0wfb7qMHwnKVcAm626s1DR0seJy/jsJlXDYT4MZHjNxqvEY5vtImSWsxpBpHRf6WgGVK
 HKI52OGhT3TazK6OARu/xsAsP0VPeyHp20OgX3Q8jPlxYFPvqh2WWo+Us+Fu2kMRNdc2
 ZxhQ==
X-Gm-Message-State: AGi0Puabc5VUUJ7uBmDmdNvBwSSKG5Egpibamk0gZ3F/uUkxbmwtqsSp
 zun7D0K/wg44gaSGp7+gKk2vR58Q
X-Google-Smtp-Source: APiQypIYAmGSAIQskk2Pf3gAWM82WkkJrLyeYJxFeqacpmLQ+QxCK1ho1iPJ46HJ+qhFopjkymYBmQ==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr3600149wmg.114.1588685169067; 
 Tue, 05 May 2020 06:26:09 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n6sm3427424wrs.81.2020.05.05.06.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 06:26:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] audio: Move advance() helper to 'audio_int.h'
Date: Tue,  5 May 2020 15:25:59 +0200
Message-Id: <20200505132603.8575-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200505132603.8575-1-f4bug@amsat.org>
References: <20200505132603.8575-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x330.google.com
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

The advance() helper is only used by the audio backends.
Restrict its use by moving it to the "audio_int.h" header.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 audio/audio.h     | 6 ------
 audio/audio_int.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index b883ebfb1f..9d759d644b 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -151,12 +151,6 @@ int  AUD_is_active_in (SWVoiceIn *sw);
 void     AUD_init_time_stamp_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
 uint64_t AUD_get_elapsed_usec_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
 
-static inline void *advance (void *p, int incr)
-{
-    uint8_t *d = p;
-    return (d + incr);
-}
-
 int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
                       int freq, int bits, int nchannels);
 
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 4775857bf2..fb6947c435 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -255,6 +255,12 @@ static inline size_t audio_ring_dist(size_t dst, size_t src, size_t len)
     return (dst >= src) ? (dst - src) : (len - src + dst);
 }
 
+static inline void *advance(void *p, int incr)
+{
+    uint8_t *d = p;
+    return d + incr;
+}
+
 #define dolog(fmt, ...) AUD_log(AUDIO_CAP, fmt, ## __VA_ARGS__)
 
 #ifdef DEBUG
-- 
2.21.3


