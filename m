Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1259BC47258
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0991206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6yIwQow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0991206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxi8-0006K8-R1
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaL-0005s1-Lt
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:09 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaK-0001l9-NP
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id k12so2288430wmj.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oqvwShux9LDNmahM4qg2/vpiuCh8jcL3zHNsGjzvE7U=;
 b=N6yIwQowLQUHtdJt/xYFpn9ccEoNmRmI8q6vcIqGCq1RteQJk+fXlXmVrSeFR54UZD
 BJ9kTUbpk+YhCR06/SBp+smklA894p6XqOyGvp3JDrrLS9Gib9nb5lDsSaCpwYuQs2sk
 yEUHaRdXdnKW5hxz7qETI+iIxjhSF9sKwpCWDThJbBSaFB7Acksk0dK8odHCn8tbOyVd
 H1Ar3dby52L00NUwf4IOCi2AQo8veeASqxsz/GoVOVjJ8c8CMIa1sIVGp/CLVmayQK5Y
 beQ2LmXzk/1s3mpjwwjo/ySb9opfQlEjbtTbeR1ndahqKVTttHcHluPZyM9Nuv+y84mH
 yn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oqvwShux9LDNmahM4qg2/vpiuCh8jcL3zHNsGjzvE7U=;
 b=uhfC2lrqmsLfyyapkxvGL+niWLuePrVYD+PMH4Ngf8MDibcFVS3icMOSSi4sMt/xMx
 izZtyu6QKM3nrM17GRLOxHlcbhvNQc08RYF3ISDSjYqo9wifjnF2VhjI1eCc8/JvRPCX
 SPWne20e0IM9mDRddTMZVkhoV5unpuh2NIFKnS0wsR9Dq84nxzmW//SN523zhQXgbyoa
 ocO1bbMYlhBMx9tsTUy3S/JFSGKBTYrLdQjJ15fTFK+Gl0b/4SWKwZo+hPcfNg1i2C3N
 u9ujLd5slGU43rZZECVUoMhkN0754XJhzh9z5AQF2dNWc55t2X9EDYC9Ton65cgmy9Se
 J8Ng==
X-Gm-Message-State: AGi0PuauULJi92RKU9kbkBhTlFRzkUFLG3JjIxS+D94F4JBoZp9N8IHW
 LR6qI23cjhEY+J5OsUXYVf81u+HG
X-Google-Smtp-Source: APiQypJnNx2njHHEiZuDoGYrdLC8jwzQ8cx+QCP55qWw/MbJEND6BnjGhDc7w82/K48EFOZntt6YbA==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr3548134wmm.150.1588685166817; 
 Tue, 05 May 2020 06:26:06 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n6sm3427424wrs.81.2020.05.05.06.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 06:26:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] audio: Let audio_sample_to_uint64() use const samples
 argument
Date: Tue,  5 May 2020 15:25:57 +0200
Message-Id: <20200505132603.8575-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200505132603.8575-1-f4bug@amsat.org>
References: <20200505132603.8575-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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

The samples are the input to convert to u64. As we should
not modify them, mark the argument const.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 audio/audio.h  | 2 +-
 audio/mixeng.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 0db3c7dd5e..f27a12298f 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -163,7 +163,7 @@ int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
 bool audio_is_cleaning_up(void);
 void audio_cleanup(void);
 
-void audio_sample_to_uint64(void *samples, int pos,
+void audio_sample_to_uint64(const void *samples, int pos,
                             uint64_t *left, uint64_t *right);
 void audio_sample_from_uint64(void *samples, int pos,
                             uint64_t left, uint64_t right);
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 739a500449..75f000e49f 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -338,10 +338,10 @@ f_sample *mixeng_clip_float[2] = {
     clip_natural_float_from_stereo,
 };
 
-void audio_sample_to_uint64(void *samples, int pos,
+void audio_sample_to_uint64(const void *samples, int pos,
                             uint64_t *left, uint64_t *right)
 {
-    struct st_sample *sample = samples;
+    const struct st_sample *sample = samples;
     sample += pos;
 #ifdef FLOAT_MIXENG
     error_report(
-- 
2.21.3


