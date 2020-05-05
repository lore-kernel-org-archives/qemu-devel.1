Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC930C47258
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89DA2073B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9rUkkLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89DA2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxdu-00027u-TA
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaS-00066M-Pa
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVxaR-0002UZ-Pm
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:26:16 -0400
Received: by mail-wm1-x342.google.com with SMTP id r26so2357626wmh.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g+biD/0WLVeYiErHCpqybenqY21TPO7hOVUcj0/N2cI=;
 b=F9rUkkLyXU9zbzd+ayRbfob6YYG0gvE+B/oQOdN3Ga29hdRAVsfRHfHi6JR+Szh9qA
 cB4dDAoZ7oPhwynvbbwH15tyz9W8DsSqhOxplcUQ7UnqJnmt79qOJz9VW+7HJ4UqDzTa
 MSQ2SC1mLL74S/A8V9bCoqcqPAroAuXgd/3WWbXocVSWWE+j/AfsWHhqFYu7H75Ujw9W
 GOUx35ATpEersH5WqhOM4xIwcJDVf9bPUjL5wBn8sIsvW4ggnQT5pW86dQqz8WFgDf9L
 Jdg6mGG1zMfvRpWDxj10JH+eEK7JBcTFC3oBLmqJOc3x9KpBQ4BecTM9RCkZLyK7cdPW
 jDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=g+biD/0WLVeYiErHCpqybenqY21TPO7hOVUcj0/N2cI=;
 b=N5kPnx4n7HhWJrzehZBPXHvFKz3SLeyX/YJeFxJxXGNmCn1jTaSSRVg2EcTb4smv70
 zXCwsQu7KqTW37Fyj2PA5DpFLbHrNqYC1bYyoOQ5uf5CjCBcYZGa3089HoNrbtha9gqO
 D5vkGFwXiizMeq2/M7lUqBmOH4gcUgBiw4ZIL1V+WFN4Fc9JS08hCo/vxi1wbfb3/MJj
 xJE3vW7yReI56ASjqNdkfC1KtOBURTCv51k498Hu1mhLmwyINSpjIgLb9HZ7dParXR7q
 +W5lNJNAf9Y09uE4MmdxF6w574rSwETbutuw4GmMDJelhepAYsPeMOi4Akqm47g7/Mb4
 JTtA==
X-Gm-Message-State: AGi0PuZL+Avx5uUHBzHVCk3q2Tel/n0kbbuDF/hD7TOCKglzBPUafj2T
 vcsRDwlUk2XLAjZ68/K9C3X/gQRi
X-Google-Smtp-Source: APiQypJhsSxpQ/lVr1Q49xgr+HCka+5SYORYglGzD95getHkuX51gjLQZjtR38kxRDkLc2ALgMI2Ug==
X-Received: by 2002:a1c:1fcf:: with SMTP id f198mr3585939wmf.16.1588685174056; 
 Tue, 05 May 2020 06:26:14 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n6sm3427424wrs.81.2020.05.05.06.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 06:26:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] audio: Expose 'audio/audio.h' under the include/ directory
Date: Tue,  5 May 2020 15:26:03 +0200
Message-Id: <20200505132603.8575-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200505132603.8575-1-f4bug@amsat.org>
References: <20200505132603.8575-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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

The 'audio/audio.h' header is consumed by the hardware models:

  $ git grep -l audio/audio.h hw/
  hw/arm/omap2.c
  hw/arm/palm.c
  hw/arm/spitz.c
  hw/arm/z2.c
  hw/audio/ac97.c
  hw/audio/adlib.c
  hw/audio/cs4231a.c
  hw/audio/es1370.c
  hw/audio/gus.c
  hw/audio/hda-codec.c
  hw/audio/lm4549.c
  hw/audio/lm4549.h
  hw/audio/marvell_88w8618.c
  hw/audio/milkymist-ac97.c
  hw/audio/pcspk.c
  hw/audio/sb16.c
  hw/audio/wm8750.c
  hw/core/qdev-properties-system.c
  hw/input/tsc210x.c
  hw/mips/mips_fulong2e.c
  hw/usb/dev-audio.c

Move it to the public include/ directory.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 {audio => include/audio}/audio.h | 2 +-
 audio/alsaaudio.c                | 2 +-
 audio/audio.c                    | 2 +-
 audio/audio_legacy.c             | 2 +-
 audio/audio_win_int.c            | 2 +-
 audio/coreaudio.c                | 2 +-
 audio/dsoundaudio.c              | 2 +-
 audio/mixeng.c                   | 2 +-
 audio/noaudio.c                  | 2 +-
 audio/ossaudio.c                 | 2 +-
 audio/paaudio.c                  | 2 +-
 audio/sdlaudio.c                 | 2 +-
 audio/spiceaudio.c               | 2 +-
 audio/wavaudio.c                 | 2 +-
 audio/wavcapture.c               | 2 +-
 MAINTAINERS                      | 1 +
 16 files changed, 16 insertions(+), 15 deletions(-)
 rename {audio => include/audio}/audio.h (100%)

diff --git a/audio/audio.h b/include/audio/audio.h
similarity index 100%
rename from audio/audio.h
rename to include/audio/audio.h
index 7956b32d0a..b5c51d87b6 100644
--- a/audio/audio.h
+++ b/include/audio/audio.h
@@ -95,6 +95,7 @@ void AUD_log (const char *cap, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 
 void AUD_register_card (const char *name, QEMUSoundCard *card);
 void AUD_remove_card (QEMUSoundCard *card);
+
 CaptureVoiceOut *AUD_add_capture(
     AudioState *s,
     struct audsettings *as,
@@ -111,7 +112,6 @@ SWVoiceOut *AUD_open_out (
     audio_callback_fn callback_fn,
     struct audsettings *settings
     );
-
 void AUD_close_out (QEMUSoundCard *card, SWVoiceOut *sw);
 size_t AUD_write (SWVoiceOut *sw, const void *pcm_buf, size_t size);
 int  AUD_get_buffer_size_out (SWVoiceOut *sw);
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 7692ee5524..72b0a37dad 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -26,7 +26,7 @@
 #include <alsa/asoundlib.h>
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "audio.h"
+#include "audio/audio.h"
 #include "trace.h"
 
 #pragma GCC diagnostic ignored "-Waddress"
diff --git a/audio/audio.c b/audio/audio.c
index 2672cf0885..d0fb794378 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "audio.h"
+#include "audio/audio.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qemu/timer.h"
diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index ebd7d9fa0d..4321a84b47 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "audio.h"
+#include "audio/audio.h"
 #include "audio_int.h"
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
diff --git a/audio/audio_win_int.c b/audio/audio_win_int.c
index b938fd667b..cd8cde527b 100644
--- a/audio/audio_win_int.c
+++ b/audio/audio_win_int.c
@@ -7,7 +7,7 @@
 #include <windows.h>
 #include <mmsystem.h>
 
-#include "audio.h"
+#include "audio/audio.h"
 #include "audio_int.h"
 #include "audio_win_int.h"
 
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 5258871c9c..f1656bb98b 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -27,7 +27,7 @@
 #include <pthread.h>            /* pthread_X */
 
 #include "qemu/module.h"
-#include "audio.h"
+#include "audio/audio.h"
 
 #define AUDIO_CAP "coreaudio"
 #include "audio_int.h"
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index bba6bafda4..3c0b4f0f9b 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -27,7 +27,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "audio.h"
+#include "audio/audio.h"
 
 #define AUDIO_CAP "dsound"
 #include "audio_int.h"
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 75f000e49f..5a47594fa0 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bswap.h"
 #include "qemu/error-report.h"
-#include "audio.h"
+#include "audio/audio.h"
 
 #define AUDIO_CAP "mixeng"
 #include "audio_int.h"
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 21995c7d9b..e6a5e35060 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
-#include "audio.h"
+#include "audio/audio.h"
 #include "qemu/timer.h"
 
 #define AUDIO_CAP "noaudio"
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 97bde0256e..7dddbd11d1 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -28,7 +28,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/host-utils.h"
-#include "audio.h"
+#include "audio/audio.h"
 #include "trace.h"
 
 #define AUDIO_CAP "oss"
diff --git a/audio/paaudio.c b/audio/paaudio.c
index b50df15ea7..63b97c93df 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -3,7 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu-common.h"
-#include "audio.h"
+#include "audio/audio.h"
 #include "qapi/opts-visitor.h"
 
 #include <pulse/pulseaudio.h>
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 9d740186cc..4c4d58457d 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -26,7 +26,7 @@
 #include <SDL.h>
 #include <SDL_thread.h>
 #include "qemu/module.h"
-#include "audio.h"
+#include "audio/audio.h"
 
 #ifndef _WIN32
 #ifdef __sun__
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 0aa6a0a671..5802f60d1d 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -25,7 +25,7 @@
 #include "ui/qemu-spice.h"
 
 #define AUDIO_CAP "spice"
-#include "audio.h"
+#include "audio/audio.h"
 #include "audio_int.h"
 
 #if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 64d7142a97..4241f1ad96 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -27,7 +27,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qapi/opts-visitor.h"
-#include "audio.h"
+#include "audio/audio.h"
 
 #define AUDIO_CAP "wav"
 #include "audio_int.h"
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 17e87ed6f4..c0ad928e80 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -2,7 +2,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "audio.h"
+#include "audio/audio.h"
 
 typedef struct {
     FILE *f;
diff --git a/MAINTAINERS b/MAINTAINERS
index 8aa8efaf1d..b332611717 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1927,6 +1927,7 @@ M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
 F: audio/
 F: hw/audio/
+F: include/audio/
 F: include/hw/audio/
 F: tests/qtest/ac97-test.c
 F: tests/qtest/es1370-test.c
-- 
2.21.3


