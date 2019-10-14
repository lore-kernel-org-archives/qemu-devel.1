Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC8EC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BB22067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTnz/Zbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BB22067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1A1-0000Zr-JG
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hikarupsp@gmail.com>) id 1iK19J-0008W2-K3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hikarupsp@gmail.com>) id 1iK19G-0005cF-VH
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:16:36 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hikarupsp@gmail.com>) id 1iK19E-0005WG-UI
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:16:34 -0400
Received: by mail-pg1-x544.google.com with SMTP id k20so2858099pgi.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VvzTHTPEJXjxLzWTP5iUofPpBYVSl/nZaLqu/Soms0k=;
 b=VTnz/Zbv5t0M2hPyiXomhTVAuTTK1fykglwGI9FlpxJESFsSNwT0qV/h70PgT0aPgE
 oHsjS5tGPawbJANboRARQENBmU60KXTL+puez4PH8WKOK7aOIFofTt00Nrld35tmuMae
 Dfa1qldIGbFQ8Li1TYHJWJp5gmEVEEEL4sVpTX2TRo3XctqzbJ05hNDvZba7NA48vwDp
 QmRuNiuM8vu28XfBLB4BXWz+vtgjIILxa5cRLEpYTyLwq6n7DmFJXAz0LwxHSiOyWfXk
 jMVmPYK9HQ7e2Nqu8/oR+dw8BVZlvGmdhNIsePAT/LFjSIqHAM8gsBJwAVqVwZ5AYuDh
 n/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VvzTHTPEJXjxLzWTP5iUofPpBYVSl/nZaLqu/Soms0k=;
 b=D+NFa7FdiliSCAcgqmzM17W+GNG/Ko0PDJpIZBwdFDJqNzL5kyu9jTujWdiMWaqbGC
 FxH5HKXKml+R8hvJnzNMk5LuVoWHsZtVnRh7h0CruNSQyP8tsNyutot3x5uAwbKtrnSJ
 vJAEL4GCU4s+7wXyOv0UUNWLHmb/kiRWR8pyrN7Mthvo5te+DWxfMCsP9IF8p9RP7QfE
 Yq18jqVY7zJvfmwD66dxWY8qJEathw1t6FLJPapp4I5epUkif4IRbuFCKNRFLw0agr80
 v+PTrfXdPjDCPBX4dAFht5yzjsGL5GxxJQUwCr37vIiTL4WWVqLHSS+a+o0FErBCIgOP
 m3cg==
X-Gm-Message-State: APjAAAUR9mjz3+Mp1vQpkNMfHF31KEnKv57HkSidEUpokV8LAGdQYg30
 Fvlmg2FH8abooey63FanN3aSKydomWk=
X-Google-Smtp-Source: APXvYqyyzL8V+kJtf96Kd9np8zoznExIAJUVo6/JTGkqDB6lkbpFb1PV5NnJMGFLmQzCls6p1MsOsA==
X-Received: by 2002:a63:4383:: with SMTP id
 q125mr33156593pga.373.1571062587966; 
 Mon, 14 Oct 2019 07:16:27 -0700 (PDT)
Received: from t03.z01.hikalium.com.com (113x36x63x49.ap113.ftth.ucom.ne.jp.
 [113.36.63.49])
 by smtp.gmail.com with ESMTPSA id d10sm20950446pfh.8.2019.10.14.07.16.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 07:16:27 -0700 (PDT)
From: hikarupsp@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2] ui: Fix hanging up Cocoa display on macOS 10.15 (Catalina)
Date: Mon, 14 Oct 2019 23:16:08 +0900
Message-Id: <20191014141608.80923-1-hikarupsp@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
 Hikaru Nishida <hikarupsp@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hikaru Nishida <hikarupsp@gmail.com>

macOS API documentation says that before applicationDidFinishLaunching
is called, any events will not be processed. However, some events are
fired before it is called in macOS Catalina. This causes deadlock of
iothread_lock in handleEvent while it will be released after the
app_started_sem is posted.
This patch avoids processing events before the app_started_sem is
posted to prevent this deadlock.

Buglink: https://bugs.launchpad.net/qemu/+bug/1847906
Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
---
 ui/cocoa.m | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index f12e21df6e..bccd861d16 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -134,6 +134,7 @@
 
 static QemuSemaphore display_init_sem;
 static QemuSemaphore app_started_sem;
+volatile sig_atomic_t allow_events;
 
 // Utility functions to run specified code block with iothread lock held
 typedef void (^CodeBlock)(void);
@@ -729,6 +730,16 @@ - (void) handleMonitorInput:(NSEvent *)event
 
 - (bool) handleEvent:(NSEvent *)event
 {
+    if(!allow_events) {
+        /*
+         * Just let OSX have all events that arrive before
+         * applicationDidFinishLaunching.
+         * This avoids a deadlock on the iothread lock, which cocoa_display_init()
+         * will not drop until after the app_started_sem is posted. (In theory
+         * there should not be any such events, but OSX Catalina now emits some.)
+         */
+        return false;
+    }
     return bool_with_iothread_lock(^{
         return [self handleEventLocked:event];
     });
@@ -1156,6 +1167,7 @@ - (void) dealloc
 - (void)applicationDidFinishLaunching: (NSNotification *) note
 {
     COCOA_DEBUG("QemuCocoaAppController: applicationDidFinishLaunching\n");
+    allow_events = true;
     /* Tell cocoa_display_init to proceed */
     qemu_sem_post(&app_started_sem);
 }
-- 
2.21.0 (Apple Git-122)


