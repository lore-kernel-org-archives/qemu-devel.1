Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5BEC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92168206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5uWbaR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92168206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxj4-0007IV-PD
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaM-0005s9-0S
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaL-0001qD-Ch
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id j5so1957041wrq.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K2W6c/wRHRvfgMBsEqNk4piQsgMLLq388yiEXTec9L4=;
 b=u5uWbaR4wpAsdeB0XIECEKbFFLmtzY8xfHTkhDhkuIeK05IqucZExyaPbUWoypJEBS
 dmTiCH4mADX5TdNO4oP7fv7xBl8SrwIaZPRPXoNVBtPgivHDHy4jirVtH9Zj4cZeymX3
 tc1hff0XJLgUh4aGLYD8Q05Y4Lv4AxXsoMHXSvAz2uLPL/D45Ssp3AItJSfexHB/7Ha2
 8zQEzcTH7SU00LflQEnZRtWe2/o60X5mQ89l8C2xfSiZ7zsLc6aTc5ujHUvYvBUGaNki
 9vmgmlDpOC0caYpkwGYSVLZItIP80Y6zB9bQOPxfKtGTrb9JNWEr9gVuM+ugQPzQIQOV
 zsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=K2W6c/wRHRvfgMBsEqNk4piQsgMLLq388yiEXTec9L4=;
 b=Qem3OvAf7LSfe5WUw5bYGbIYu0F/u037GmWdmx2WBbbSI20QKcBIMSzgLiGmr83KlJ
 74gawibag3w7yKmp7la+9SsuJ2CFS5a0v6lm/+GmtWZcUQ7db4RHoGlEpjNfnCk3kf7O
 bLX9foAWTyahTkQg7x5+Ro604lraGvyK7tESlexVRXFs05azw1fprD81cf/VeHURoxKi
 uNAqQvYUuN8WU2XlpBR71KXmnY2Herv8ZVn8nQHl2bDiG3136ezq8IYUjjYrvTEcjros
 wogKmoSgz7QqSlBQTfe4CHryncbT0T3/SubkWwmOeGNBOfkcymDBbm5fUgkLBeJ5B/ok
 VJng==
X-Gm-Message-State: AGi0PubYMvHvnEwFgVWEwH3/u+T4chxGWalGPfKeQnSPlmqXBZDLkzeu
 OqKRcOzkSp12X/xwBRl7LsEhW8/s
X-Google-Smtp-Source: APiQypLjQmxVkF6euodeoI4gg/5gVp8B/GT1UPWYQKWP89yuPEza5C/Zb9DLQ7hgmjrNRKRQPC8wvQ==
X-Received: by 2002:adf:ea4d:: with SMTP id j13mr3766872wrn.193.1588685168008; 
 Tue, 05 May 2020 06:26:08 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n6sm3427424wrs.81.2020.05.05.06.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 06:26:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] audio: Let capture_callback handler use const buffer
 argument
Date: Tue,  5 May 2020 15:25:58 +0200
Message-Id: <20200505132603.8575-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200505132603.8575-1-f4bug@amsat.org>
References: <20200505132603.8575-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

The buffer is the captured input to pass to backends.
As we should not modify it, mark the argument const.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 audio/audio.h      | 2 +-
 audio/wavcapture.c | 2 +-
 ui/vnc.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index f27a12298f..b883ebfb1f 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -60,7 +60,7 @@ typedef enum {
 
 struct audio_capture_ops {
     void (*notify) (void *opaque, audcnotification_e cmd);
-    void (*capture) (void *opaque, void *buf, int size);
+    void (*capture) (void *opaque, const void *buf, int size);
     void (*destroy) (void *opaque);
 };
 
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 8d7ce2eda1..17e87ed6f4 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -71,7 +71,7 @@ static void wav_destroy (void *opaque)
     g_free (wav->path);
 }
 
-static void wav_capture (void *opaque, void *buf, int size)
+static void wav_capture(void *opaque, const void *buf, int size)
 {
     WAVState *wav = opaque;
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 1d7138a3a0..12a12714e1 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1177,7 +1177,7 @@ static void audio_capture_destroy(void *opaque)
 {
 }
 
-static void audio_capture(void *opaque, void *buf, int size)
+static void audio_capture(void *opaque, const void *buf, int size)
 {
     VncState *vs = opaque;
 
-- 
2.21.3


