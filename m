Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41232C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D92F206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO7i1ymp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D92F206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGeL-0003Xe-9Y
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTv-0001Ex-BC; Tue, 30 Jun 2020 09:39:27 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:33969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTt-0006Jd-Pd; Tue, 30 Jun 2020 09:39:27 -0400
Received: by mail-ed1-x542.google.com with SMTP id a8so15033747edy.1;
 Tue, 30 Jun 2020 06:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VFFOiCizJ+mW5k6WnhghvzdFvmIVL76nU3yTXrPInm0=;
 b=BO7i1ymp9yBffSDllzficR4ZG69UtZZ5R74AqNSXRYh8yUuIGpV8FDDWcdVshR7lJO
 ud8RU7KqCzVcV5rMG4Nbmwt/FwZVPDlyxK+nBEwUg/8vXpMuwlr8PUzX+1hiboXF2NEJ
 nZ4Nu1oUzek7wlaIZjxu/o3ZHnNPjJaSzTDCc9apCxXDRgAxYL+MH/Ge43MbdLJFxmYm
 QRJSYlgHF15tzT/pnn95AScFJ8BDfNsu4GDmiQ565xM0Dbyx4AADHTgKi9jxF1APw+P/
 UHWyrE0HlrQrtpCZ2/qGum2R1hCn0lB4P7/AaisN7MRRF+CaSJZpfP6J56pSL7n/sKPM
 OBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VFFOiCizJ+mW5k6WnhghvzdFvmIVL76nU3yTXrPInm0=;
 b=J+s8UBqxs4Y34KQPuBB6A29eb72MldJth0cGtP8AEMsDfFYIEkK3WqU05HUDk560OA
 OJmpDWgDo99sti+fIIflugeiKXfgI02ER1wcMuYt6eupuXCNQFnqwvV2DCLEheZuyFKN
 syUWqNsBYYE7TDFemsb8hydGhjoJrv2FP8XV2O/UxbzSOCbOfL7CtBQD21J20H0hoGQ2
 tOWZkhjGjCA4zXnftrd/uzYORIHIkh7/mPLD1KMd1kQLXibgy9XeIib1DJCfNzWlfBhI
 m40pqtj2N5uR/uvBTNT+gguNM06t/3ZvOb4n+XHZ8RGStLAVKRQS3x8BBSW4cMcpKcpS
 KDTA==
X-Gm-Message-State: AOAM531wET6YQmdJcvsu0CC3VWxV2oimor2lWaZK16+PCXgt1XwtRTb7
 sVKLqMbq6rR1vgzgjH7bq7NAeu7351E=
X-Google-Smtp-Source: ABdhPJwRdFf/h+UGSi2IZWls9PKOqan0JBjUYiv+eqhH8xA4qmKnc1X36AvIDR+rlcXshLQVKX6Tvw==
X-Received: by 2002:aa7:d049:: with SMTP id n9mr15933117edo.39.1593524363856; 
 Tue, 30 Jun 2020 06:39:23 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 09/17] hw/sd/sdcard: Special case the -ENOMEDIUM error
Date: Tue, 30 Jun 2020 15:39:03 +0200
Message-Id: <20200630133912.9428-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we have no interest in the underlying block geometry,
directly call blk_getlength(). We have to care about machines
creating SD card with not drive attached (probably incorrect
API use). Simply emit a warning when such Frankenstein cards
of zero size are reset.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e5adcc8055..548745614e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -545,18 +545,30 @@ static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
 static void sd_reset(DeviceState *dev)
 {
     SDState *sd = SD_CARD(dev);
-    uint64_t size;
-    uint64_t sect;
 
     trace_sdcard_reset();
     if (sd->blk) {
-        blk_get_geometry(sd->blk, &sect);
-    } else {
-        sect = 0;
-    }
-    size = sect << 9;
+        int64_t size = blk_getlength(sd->blk);
+
+        if (size == -ENOMEDIUM) {
+            /*
+             * FIXME blk should be set once per device in sd_realize(),
+             * and we shouldn't be checking it in sed_reset(). But this
+             * is how the reparent currently works.
+             */
+            char *id = object_get_canonical_path_component(OBJECT(dev));
+
+            warn_report("sd-card '%s' created with no drive.",
+                        id ? id : "unknown");
+            g_free(id);
+            size = 0;
+        }
+        assert(size >= 0);
+        sd->size = size;
+    } else {
+        sd->size = 0;
+    }
 
-    sd->size = size;
     sd->state = sd_idle_state;
     sd->rca = 0x0000;
     sd_set_ocr(sd);
-- 
2.21.3


