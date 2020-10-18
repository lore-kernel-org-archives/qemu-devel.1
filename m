Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E69C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 16:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAD42222B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 16:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZPBPwuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAD42222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUBsE-00011z-GC
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 12:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUBrO-0000VY-2S
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 12:48:42 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:32971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUBrM-0001d1-B9
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 12:48:41 -0400
Received: by mail-pl1-x643.google.com with SMTP id b19so3788268pld.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wqSq45uGxu7te8be5v9k72eIGT8u20SWPT2IAx16W70=;
 b=NZPBPwuwUdJuMTA+smOVMh13sjoEc31o6wgYZUqTS17DHoQXCZRU93GM9BlSmvVahd
 69NsO+hGWtheYvTcDB2IGerIfrlDcYT8XfuOMRnlASyH9cvibKVmCOHGVy3KOdZoDQ6f
 tdnz2U/s4LbBwFCvp7HQVw1r42mZC3+FUDy18dp+sLlvjEPDcUIZJSGvwiOrSqT8SQdQ
 kNiGVyX3Z9bUV5jCB8i3cx3LgYyiNFSgQ7pNnvkZHH+HVr20RUlAesXo2xQvz4F8jNVM
 vcvdWlQJroZ6Ki6MCt/Ja5Tio5I6RvHjaxdrwc4ggFOJXSnrJdblnojhM9TR/dqkgw1G
 kU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wqSq45uGxu7te8be5v9k72eIGT8u20SWPT2IAx16W70=;
 b=QulVdLY7UH25DPjOA4zaNcG3UARpFfy9CoIbRw4PD7ohS2D3s1RTp0DulfCiy2Nqut
 1Zx7qd3RJ394txzCpDKsKCf2FdePl2jDWqAJ8/dF7HUUAU7JNOQBKQxJci5BW0u3ah8Q
 qd6TexAFz9LcAmhlDUn4P+fry9agqaFnDQb4iXW8TwWopm1Sqj7ofBx+Dh3jNLeE/SVT
 PL6IJK1jWibJfjz1c7FbIi3Boxoo8SfE6Rn6b8X93aMpc9POJgbsTcYqkni4dxGk8RSx
 cmjIG/J52L18DbN4t1H6DXfRuoj/1DICiiosNlmjF8bblPALaNdBTgnZSSl4+ylDSfGN
 x1ww==
X-Gm-Message-State: AOAM532l1uhtc7wPI7cZaehqOwGL64SHiO/cH3PJ1uc1JeCqd0DwSfJz
 unRVr0i3fYZDXHgxYLAWoqYnotqdkJjw3g==
X-Google-Smtp-Source: ABdhPJzYf3810XMeqr8NFQW7BP7pvpkhnU8f4OkyMxROzyAkocxeBLJy/03NveIF8/1pheXwKmEg/w==
X-Received: by 2002:a17:90a:fb92:: with SMTP id
 cp18mr14194815pjb.228.1603039718072; 
 Sun, 18 Oct 2020 09:48:38 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v13sm1947996pgl.6.2020.10.18.09.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 09:48:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] util/oslib-win32: Use _aligned_malloc for qemu_try_memalign
Date: Sun, 18 Oct 2020 09:48:36 -0700
Message-Id: <20201018164836.1149452-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do not need or want to be allocating page sized quanta.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Include <malloc.h>; use g_assert not assert.
---
 util/oslib-win32.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index e99debfb8d..29dd05d59d 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -39,6 +39,7 @@
 #include "trace.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
+#include <malloc.h>
 
 /* this must come after including "trace.h" */
 #include <shlobj.h>
@@ -56,10 +57,8 @@ void *qemu_try_memalign(size_t alignment, size_t size)
 {
     void *ptr;
 
-    if (!size) {
-        abort();
-    }
-    ptr = VirtualAlloc(NULL, size, MEM_COMMIT, PAGE_READWRITE);
+    g_assert(size != 0);
+    ptr = _aligned_malloc(alignment, size);
     trace_qemu_memalign(alignment, size, ptr);
     return ptr;
 }
@@ -93,9 +92,7 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared)
 void qemu_vfree(void *ptr)
 {
     trace_qemu_vfree(ptr);
-    if (ptr) {
-        VirtualFree(ptr, 0, MEM_RELEASE);
-    }
+    _aligned_free(ptr);
 }
 
 void qemu_anon_ram_free(void *ptr, size_t size)
-- 
2.25.1


