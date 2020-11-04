Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1993C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338A3221F8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiK+gY1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338A3221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFEj-0002mE-7F
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 04:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kaFCo-0000Aq-LP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:35:50 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:55556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kaFCm-0003vU-VO
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:35:50 -0500
Received: by mail-wm1-x336.google.com with SMTP id c9so1671955wml.5
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 01:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oU5UbR5ntNYy2SUlvhi9joWPDwzoXedtc395+AIU/FU=;
 b=UiK+gY1qMkcIbHe1lyQpWs29c7MRIx27Dij2gKezrDhPavG0xGQKeMc0HH2O+FwWMW
 Oqxz0cDeFupQQe1oowuGa7VtSaEaGaUwNLvjLNxUQ7egRr09C6tzhe487ZIHZVMQ0Uku
 Rl6/fEoYVA6TW1rk/b+opnauZsaCrIeqC7wgJlwqppDeMcWBnxp/6CvJ3XfpfW8gDsu1
 g778ReZj4T2sof/byrtun6WMsbOHpfVi7BSJECB5ZIJQWO8a7/Sp7Avpg9Pobu9ofdVk
 vN+Lmmj9+qcOLLGEo/oyFFCMmLMwUTwdCxr7dpAfjnNqUuT7jakrLmZ+N17hyUM2fdGG
 ++ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oU5UbR5ntNYy2SUlvhi9joWPDwzoXedtc395+AIU/FU=;
 b=PJQmVF+Dpgs207jRMnnoMrvam4ywAvhYyyuxVXui5a3iijweK5OHBQo0dyh6+OpMke
 auanlZtwX9bJa/1zOq6enDry4W9TRuyf9UhSK6iaqEIbOjJxUGau3N4fr/tblwZu7DAi
 RFxADc0GdTvBei6m/pm6Do5VAY6hAd42CcjlDOfn5VdTw9wWppprTY5L4ER2fqD37xst
 /Gu/mxnOdbb6CIoJHLP38tXnFj9riiXl+RC6Vz71YXRl53noY1VzCoCgquHP7NDsegTD
 xKi7lrUayZ7njdoJf/EVrL8C1U2DfQaSd+FfU8ksCyAGDVC/t70gUEqOJCzPEU9u7rCq
 fNRA==
X-Gm-Message-State: AOAM533FIRMRRz91paRQgYJz71bQrQI2BVi4RDnd0fTAhf4MVNrzs2YS
 iO82Qd0KSWCLKOQb7ztZ0IYMH7p3wnw=
X-Google-Smtp-Source: ABdhPJxWPCt9IvKwbjlLBPh1mfSeLVBntguEsuqGa2yUdgaZq5uJP32JjIg87gu8rd6/ThFGw2hKxg==
X-Received: by 2002:a1c:b387:: with SMTP id c129mr3759443wmf.66.1604482547100; 
 Wed, 04 Nov 2020 01:35:47 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id r1sm1772468wro.18.2020.11.04.01.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 01:35:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] exec: Ensure variable page size is only used with
 TARGET_PAGE_BITS_VARY
Date: Wed,  4 Nov 2020 10:35:34 +0100
Message-Id: <20201104093534.3064440-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104093534.3064440-1-f4bug@amsat.org>
References: <20201104093534.3064440-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If TARGET_PAGE_BITS_VARY is not supported, machines should not
intent to modify the target page size.
As set_preferred_target_page_bits() is supposed to return 'false'
on failure (documented in "qemu-common.h"), return false to
indicate failure if this ever happens.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu-common.h | 4 +++-
 exec-vary.c           | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index fda7dc6ca77..3ea616d4567 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -70,7 +70,9 @@ void cpu_exec_step_atomic(CPUState *cpu);
  * size may be smaller than any given CPU's preference).
  * Returns true on success, false on failure (which can only happen
  * if this is called after the system has already finalized its
- * choice of page size and the requested page size is smaller than that).
+ * choice of page size and the requested page size is smaller than
+ * that). Only target supporting variable page size should set a
+ * preferred target page size.
  */
 bool set_preferred_target_page_bits(int bits);
 
diff --git a/exec-vary.c b/exec-vary.c
index ff905f2a8fb..4b0b7f193af 100644
--- a/exec-vary.c
+++ b/exec-vary.c
@@ -86,8 +86,10 @@ bool set_preferred_target_page_bits(int bits)
         }
         init_target_page.bits = bits;
     }
-#endif
     return true;
+#else
+    return false;
+#endif
 }
 
 void finalize_target_page_bits(void)
-- 
2.26.2


