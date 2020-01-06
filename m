Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0DFC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8656824676
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzBvyGj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8656824676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioX8V-00080t-5q
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3k-0001TD-LO
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3j-0003iA-Li
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:00 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34]:43832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX3j-0003ho-Hv; Mon, 06 Jan 2020 13:24:59 -0500
Received: by mail-qv1-xf34.google.com with SMTP id p2so19406856qvo.10;
 Mon, 06 Jan 2020 10:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b3ezhmI6tKSWqDJ/WfwsteLWfxOpOCrsFHh/gbYbAF0=;
 b=tzBvyGj+wo2T2PolIlgntJfnn2j0wmFIzjfVA/xfbb6SHdEOj3ECGjiDut4B2xfRUx
 HvfWVudIb33UJYVpg64NVRCAF90YRNV59v/jWQ1BvCig2z2ObX0JQzfK/zpBhdjzU+E3
 IvbB5oOLuvl9rUo+OHQTWip3yVc44k7Hs5AKXtOIQkNBzFPKD4Xt/PEYT0iBGPJxPpVF
 6x8lz/kRro2g5UIqTVg87FoAJ+EGGk301p/uPY6NV9w31M3hBgbcutVG2/fUra3E+23Z
 BuFkuj/XsU4YjvjNKGl4RDTX49CxhILyGAp+KyveD+J+XAburCq05wAMAtMBlGzVI8Qg
 u2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b3ezhmI6tKSWqDJ/WfwsteLWfxOpOCrsFHh/gbYbAF0=;
 b=t10rjgl4vNYfAbqRkzoSThgUeWQcmYPBK7ZhYzb+qjdU5BUVOwX8plv25XxwomPpos
 zoKUt/MEAqfFNTYuyoKdeNWGtMCy4DOocPuNlQCpdjzGL1SF/Q9vhMMA7Jt5L2Qv8pm8
 /3fe3EE0Me3NFpHuaF7YZ2Tb6KWYyA7GqG7fIOCPYyneJVqs/Hi58uQ36uwtAGLk9EAT
 wnbSzXTI+kHgAE1Wz3hqQak1m+Jeoa5DpZpDBEluB9O3EdAilNPrTy5cuhuP16qpC02C
 my30IKNw/6KNtrozVTnDApayQBQTTRmGjAqUSeEaSYntml9+FA++QAFyN+6ka6Yg8g/Z
 z0rg==
X-Gm-Message-State: APjAAAU7lG0pGGMeSSopkQ3HYceD6UngohKWTnC9TUQ9aForHyfM0lz8
 ycJZ248i3uJN52Hv2uDzPgB8eroU
X-Google-Smtp-Source: APXvYqxa8alPkC2npZOI2FQeAkrumgVeX/miC9HIetSqUniM1Jt1AOLEdKApQV2OAJgr2qzoUR3JLA==
X-Received: by 2002:ad4:58e1:: with SMTP id di1mr65547720qvb.201.1578335098883; 
 Mon, 06 Jan 2020 10:24:58 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:24:58 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/59] paaudio.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:23:30 -0300
Message-Id: <20200106182425.20312-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f34
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Label 'fail1' in qpa_init_out() and qpa_init_in() can be replaced
by 'return -1'.

CC: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 audio/paaudio.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 55a91f8980..8f42b2079c 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -470,7 +470,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
         );
     if (!pa->stream) {
         qpa_logerr (error, "pa_simple_new for playback failed\n");
-        goto fail1;
+        return -1;
     }
 
     audio_pcm_init_info (&hw->info, &obt_as);
@@ -479,9 +479,6 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
         &obt_as, ppdo->buffer_length);
 
     return 0;
-
- fail1:
-    return -1;
 }
 
 static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
@@ -518,7 +515,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
         );
     if (!pa->stream) {
         qpa_logerr (error, "pa_simple_new for capture failed\n");
-        goto fail1;
+        return -1;
     }
 
     audio_pcm_init_info (&hw->info, &obt_as);
@@ -527,9 +524,6 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
         &obt_as, ppdo->buffer_length);
 
     return 0;
-
- fail1:
-    return -1;
 }
 
 static void qpa_simple_disconnect(PAConnection *c, pa_stream *stream)
-- 
2.24.1


