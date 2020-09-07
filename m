Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEACDC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3038A2080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY9Afm58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3038A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5Ya-0003EP-7c
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF5Xm-0002NC-W4; Sun, 06 Sep 2020 21:02:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF5Xk-0001hY-Qk; Sun, 06 Sep 2020 21:02:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id s13so12785831wmh.4;
 Sun, 06 Sep 2020 18:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vWtZijcXDpyF8N5x5cBJXC3hkGzf/vTxCrAXrlAJYHc=;
 b=HY9Afm58oC7YBks8dw/HeX/gzx/AceREP8ZE/1LLJwEtI9U/gQKDW3jySSmk6I34x5
 5+HmzxpdPFwImcF83oiTZWPT43FN2DC3PP/keZhlcpq3ZwmgvDlCrLQ8MkrFvePgwpFr
 4g4hHXe5MFYFP+2yh0QXT1sq2YoUCfWYI+4h194OW742pUWHRQP865KNv45CJC3ps1B2
 NmbcoXVpAoa5oWqRGoY7d05rORUhT4XIVEvzRbnOawlnTi6Schao3Yz9TA1jcObB8R9G
 tagCLmXMFs6xUny4oFYGKARdSfiqvAsqQn3pqFPEJakYcDk17Mx4jhThoOcEIUTzHgnu
 rGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=vWtZijcXDpyF8N5x5cBJXC3hkGzf/vTxCrAXrlAJYHc=;
 b=RZjY0K6Hw4Ysr47c4GKwovFMDvU07ZqVKz57aBF0tAeoKdjAGkpuAnVR6Gb6DEjbXV
 jhcdJLAcK3K/TyW0Rbvn/ui8Qv33bPn2AaRK49acHF/NdB4D8p0TVRTv1O0ORdq0+tUc
 hhlbOjnGjbY1kihSdFNnvH67ikkTZrUj1fqxnpDVaukN2WO8aq3/dNfZiNXBtUmoji8H
 Us0fRWcuJNDs2VBgPxQfSueXx/hE1mTEYJeegdPy2+ovGqgQFeY5TiLoipFE3GUc4uIf
 r5MCX2D+J+GMg8Dvtd35aGvLg3LsrGIT0dmgNZUgRjYBrNKOiXT+I0HMLL4hUXRFtWMT
 9Fgg==
X-Gm-Message-State: AOAM532vSN5AVCNtKoKVqFhsJjgzCrYwzhez6xaQmRY9Hx/oFpQ/CFsw
 rUvoqgpRTCcKdqDhmfRS0wDKkul3Q3E=
X-Google-Smtp-Source: ABdhPJxIgZcXrbG9m4W5mWtXM539pmqr2aTBVv66avDiE8egMiSk0SDCCjZrNq2xMzxeLLplBfG4tA==
X-Received: by 2002:a1c:a90a:: with SMTP id s10mr18107430wme.11.1599440518243; 
 Sun, 06 Sep 2020 18:01:58 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o16sm23736024wrp.52.2020.09.06.18.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 18:01:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/input/tsc2xxx: Reduce MouseTransformInfo structure exposure
Date: Mon,  7 Sep 2020 03:01:55 +0200
Message-Id: <20200907010155.815131-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit a5d7eb6534a ("Add TSC2301 touchscreen & keypad controller")
added the MouseTransformInfo declaration in "ui/console.h",
however it is only used in "hw/input/tsc2xxx.h".
Reduce the structure exposure by moving it to the single include
where it is used.

This should fix a build failure on OpenBSD:

  In file included from hw/arm/nseries.c:30:
  In file included from include/hw/arm/omap.h:24:
  In file included from include/hw/input/tsc2xxx.h:14:
  include/ui/console.h:11:11: fatal error: 'epoxy/gl.h' file not found
  # include <epoxy/gl.h>
            ^~~~~~~~~~~~
  1 error generated.
  gmake: *** [Makefile.ninja:1735:
  libqemu-aarch64-softmmu.fa.p/hw_arm_nseries.c.o] Error 1

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/input/tsc2xxx.h | 8 +++++++-
 include/ui/console.h       | 8 --------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/hw/input/tsc2xxx.h b/include/hw/input/tsc2xxx.h
index 3cd8f1bf55b..5b76ebc1776 100644
--- a/include/hw/input/tsc2xxx.h
+++ b/include/hw/input/tsc2xxx.h
@@ -11,7 +11,13 @@
 #ifndef HW_INPUT_TSC2XXX_H
 #define HW_INPUT_TSC2XXX_H
 
-#include "ui/console.h"
+typedef struct MouseTransformInfo {
+    /* Touchscreen resolution */
+    int x;
+    int y;
+    /* Calibration values as used/generated by tslib */
+    int a[7];
+} MouseTransformInfo;
 
 typedef struct uWireSlave {
     uint16_t (*receive)(void *opaque);
diff --git a/include/ui/console.h b/include/ui/console.h
index f35b4fc082b..30eed00dfcd 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -65,14 +65,6 @@ void qemu_remove_led_event_handler(QEMUPutLEDEntry *entry);
 
 void kbd_put_ledstate(int ledstate);
 
-typedef struct MouseTransformInfo {
-    /* Touchscreen resolution */
-    int x;
-    int y;
-    /* Calibration values as used/generated by tslib */
-    int a[7];
-} MouseTransformInfo;
-
 void hmp_mouse_set(Monitor *mon, const QDict *qdict);
 
 /* keysym is a unicode code except for special keys (see QEMU_KEY_xxx
-- 
2.26.2


