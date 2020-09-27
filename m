Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDCAC4741F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 09:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2780B2389F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 09:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL+rwC+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2780B2389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMSgQ-0006G3-59
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 05:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMSfV-0004Zh-J7
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 05:08:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMSfU-00029t-5j
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 05:08:29 -0400
Received: by mail-wm1-x342.google.com with SMTP id s13so3349172wmh.4
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 02:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t3BREwZtlazYO80VUKfXukPFJ19pqUVUnt1RMwbxcUM=;
 b=SL+rwC+XFiGvq5yE0OJaxyFRRXicxzbYUhe7t0JtPPMFhc8PbWEK0m/3o4tIbMXKhV
 XZjvaf9wb656+H7EfHcKit4Cz1phJNU6vQJF8CKWbhFUgzVk1C9vDuhJrSirEU/CToqY
 re7uJfr6PBfRIpRK4exMIucLuffOSI4ARlj+0mr03LA4yhGkDyGbUb5TqCvlhnJP0cRJ
 eQ0hHqumqj4mhgBCuff+b7esWZQCPybpGu1AUMGcvcH3UsHSBovsYj6CeaaBiuzwkttc
 AsgXny808rjLmgKkBfaXphTw2QAELHKmdbFan7mvTIpayr6kAOj1iYVsptG4cr/Cy7VO
 LXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=t3BREwZtlazYO80VUKfXukPFJ19pqUVUnt1RMwbxcUM=;
 b=CXQd33xsb2wPCI9FNA36v5j/sUIK8CP+b7u/gllrkEZxgW5fS9Ijy6auYRXdyE/uln
 rXcvogdBbeVFiqIVQs/ZgyI2zdrjqdsvw2i3R6TPucx7SLv+ZSzwJirRSmcAfOWB/SK0
 9xAourEvNSWhOelRb35rgb73VTLnv1W1IfUhRiP6ZafhpFmPcZz//XvzE1qFVxS/BOz6
 xlt0GUmPuNcfQ/7CCTsWE90QoF/bqm5ALHQA1oyco5Mg80ZjxYoG10ZlDLZ5N8E4tVZ5
 2df32+YEz5GIQatzVAGBM1P7cf1ZPViseRmTzNvjJy1C0VQeBjos4knzikEwltD15nv9
 smgg==
X-Gm-Message-State: AOAM5313b7PFZDX3VDWvzSEo4kVXyHRa4MZqXVaoDEK/9nub1gUvx9Zj
 QEiK+jAkQDVoChfx9QKwrUZyNm403bM=
X-Google-Smtp-Source: ABdhPJyAO6B3/PsaFvI5o0iZWWAVH+pvG4PCweOMTLUpLnb5WiEy44yJ7nYxjGnFMHxWYX0tDMWIRA==
X-Received: by 2002:a1c:9d42:: with SMTP id g63mr6267355wme.20.1601197706424; 
 Sun, 27 Sep 2020 02:08:26 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id y6sm9007187wrn.41.2020.09.27.02.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 02:08:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/qdev-clock: Display error hint when clock is missing
 from device
Date: Sun, 27 Sep 2020 11:08:20 +0200
Message-Id: <20200927090820.61859-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200927090820.61859-1-f4bug@amsat.org>
References: <20200927090820.61859-1-f4bug@amsat.org>
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Tyrone Ting <kfting@nuvoton.com>, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of directly aborting, display a hint to help the developer
figure out the problem (likely trying to connect a clock to a device
pre-dating the Clock API, thus not expecting clocks).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/qdev-clock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 47ecb5b4fae..33bd4a9d520 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
@@ -153,6 +154,11 @@ Clock *qdev_get_clock_in(DeviceState *dev, const char *name)
     assert(name);
 
     ncl = qdev_get_clocklist(dev, name);
+    if (!ncl) {
+        error_report("can not find clock-in '%s' for device type '%s'",
+                     name, object_get_typename(OBJECT(dev)));
+        abort();
+    }
     assert(!ncl->output);
 
     return ncl->clock;
@@ -165,6 +171,11 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char *name)
     assert(name);
 
     ncl = qdev_get_clocklist(dev, name);
+    if (!ncl) {
+        error_report("can not find clock-out '%s' for device type '%s'",
+                     name, object_get_typename(OBJECT(dev)));
+        abort();
+    }
     assert(ncl->output);
 
     return ncl->clock;
-- 
2.26.2


