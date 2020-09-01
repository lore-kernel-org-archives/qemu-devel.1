Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F58AC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B99F206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxkfmvoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B99F206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD4P9-0000MX-5J
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD4Nv-0007S2-Hx
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:23:31 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD4Nt-0007M1-J8
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:23:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id l9so772585wme.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 04:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wv1z8GkqgKsVjWiNC8qcp304rCEdC3vesjm2CjFcbdc=;
 b=oxkfmvoc+tv49In4qw4RDwiaxAjyQZdtCm0U6wwY2KAU7/3aJUnQfFldVDFvBNtdWs
 1eiTvzlijjRR+aKowxntfv3OPlEEVhUmM1giUxmJ64vF5HQKmr0KkLDgkrgAcf8Vy7Y7
 ThFoZDCm98syWMiUq/rilytk+0wSIN2sEJwnTs0+T5LQcjSx6X0tw7h2jDkpNErcXBj/
 Bq9tcDwkXCYhe49+d6ihP6HmXUnNTt8vfiE/oG75LwjLABZyilAODNeabla4tkVe1vEj
 h/ShW9HP7o8jb/nrafK784zQV5h/Vkw/rtXodlMJmcDLT7MsKZI+JOPupwR2stTAPFM6
 18kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wv1z8GkqgKsVjWiNC8qcp304rCEdC3vesjm2CjFcbdc=;
 b=nHNQKRj/WjAuIECgc6v0iXzSWuIWGrNjjAaDMJpGekd9daZZiQq18+KmDTr+rNklUx
 k1Hxy7CPDneNOVQlLbu3Z33IY+ALZNtMYW0+dXAYuq88eSGWF1cgM/tr2nRiFHxtJyNQ
 TZRZx91MzTTXI4UrrZ8bmbhUuqfJkQYM7VpyKAij6AJAE2YO3lOnn4H7U4qSPM/s4DgV
 7ol9ezWiT6wzFQlNWUOh1U90HLV5/lF2ocf0+42oRlZ03sJdCouBgr+2Wm6YEESBpv6R
 i/z3INBVrcTKhTngHZ5WAypYokEA/kgQxAVfYRMQ6t1Ch69KUXPKC3l2S5PL5TIfVcyj
 juZA==
X-Gm-Message-State: AOAM53331yJgo8FbC4TOX28gcpSPaCAqkZKyMs1Ao/gHJBjEU5bk/Xsw
 jcDsOp+XeJlfJ40znDbQztpaCHzJnHU=
X-Google-Smtp-Source: ABdhPJyGlSVinMA/VUn7EvaA52UiwCjrpJJ0OmHvaOL+ZeoBX8O+Jj8iMeTjifKCP5b5qSfH8SmNPA==
X-Received: by 2002:a1c:28d5:: with SMTP id o204mr1395173wmo.104.1598959407941; 
 Tue, 01 Sep 2020 04:23:27 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id n11sm1769124wrx.91.2020.09.01.04.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 04:23:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/core: Move hw_error() out of cpus.c
Date: Tue,  1 Sep 2020 13:23:23 +0200
Message-Id: <20200901112323.94969-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901112323.94969-1-f4bug@amsat.org>
References: <20200901112323.94969-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As hw_error() is unrelated to CPU error - for which we have
cpu_abort() - move it out of cpus.c, under the hw/ directory.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Couldn't find better file/name to put it in...
---
 hw/core/error.c     | 38 ++++++++++++++++++++++++++++++++++++++
 softmmu/cpus.c      | 12 ------------
 hw/core/meson.build |  1 +
 3 files changed, 39 insertions(+), 12 deletions(-)
 create mode 100644 hw/core/error.c

diff --git a/hw/core/error.c b/hw/core/error.c
new file mode 100644
index 00000000000..5a783c82dff
--- /dev/null
+++ b/hw/core/error.c
@@ -0,0 +1,38 @@
+/*
+ * Peripheral error reporting
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+
+void hw_error(const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    fprintf(stderr, "qemu: hardware error: ");
+    vfprintf(stderr, fmt, ap);
+    fprintf(stderr, "\n");
+    va_end(ap);
+    abort();
+}
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index c96a04d7f18..eca57c76c9b 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -59,7 +59,6 @@
 #include "sysemu/replay.h"
 #include "sysemu/runstate.h"
 #include "hw/boards.h"
-#include "hw/hw.h"
 
 #include "sysemu/cpu-throttle.h"
 
@@ -910,17 +909,6 @@ static void stop_tcg_kick_timer(void)
 }
 
 /***********************************************************/
-void hw_error(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    fprintf(stderr, "qemu: hardware error: ");
-    vfprintf(stderr, fmt, ap);
-    fprintf(stderr, "\n");
-    va_end(ap);
-    abort();
-}
 
 void cpu_synchronize_all_states(void)
 {
diff --git a/hw/core/meson.build b/hw/core/meson.build
index fc91f980758..99466dc93fd 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -1,6 +1,7 @@
 # core qdev-related obj files, also used by *-user and unit tests
 hwcore_files = files(
   'bus.c',
+  'error.c',
   'fw-path-provider.c',
   'hotplug.c',
   'qdev-properties.c',
-- 
2.26.2


