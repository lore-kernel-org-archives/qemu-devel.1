Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73278C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6FF20838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAvUPbul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6FF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLU0-000728-Ab
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFo-00055t-Dw
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFn-0006rB-90
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:16 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLFn-0006mv-2b
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:15 -0500
Received: by mail-pj1-x1042.google.com with SMTP id l35so6556610pje.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ldCBPIWc8mhUIrG4FNbVFhLO4ifRLpZg7PBUswXT7Cc=;
 b=rAvUPbulxQ1IDCZxEo3CsHXYgQ0eMBdCYt0KnanZHmD3Qkxx+j95lNQZYXNGzOw8ts
 A92wqy972KKkv2WNMm9FzR3ncl042lClEB/E6jfAvnKy4qTkhd1K3tWe4vHILc/5/Lgk
 PYGuCq6iQkABixfdq4k3lU3gmXOSQ7au3UuQ5QviH7pkZUX+RfA5EefT8TDUTCTmEWHn
 FAlpv7aAptTbCW9u91Vs/nabU0HVMLUIZypvY7qRV6+JVXRp3XQUVV3B/ppi9C2Mr6c9
 AtRRsS2i6mic34GpTB5SfcS2cGRmsFDgzmZLWVcuS5/jmHOwAVaxlEF+UG1Yt/XE+5dt
 ooWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ldCBPIWc8mhUIrG4FNbVFhLO4ifRLpZg7PBUswXT7Cc=;
 b=dAT1SkMagCkCAMog6lYgMgYUDIMvxnVtRiZjWuWbxz9LrH6f/GhMsv1te7jUkqWxUT
 1BlnBMCpzhbWjuc+X3Ct4QmpnkyNEXYNtqszJW27IGPCUZ3M+vowJwAvcJsqMJOfnHLd
 cIi9ahpvfizvv6xRxxMSr1uRvXeA+eaei+1SEasgAbYB5TiAEQ9PdQ26yOEN0LfPMZ8P
 aNe6R0Uh5a4S95+i6dczsf14V2Tvw6ltIegI55Y9eUqMQHWY/LWNQGnrUfcaeNB/SXWR
 5WxtHlOO9MFLtjZi9rhde2VzM47sK5xwkhhoeCwwtXFX7BocFj0MiMk2jYB4cZBdhz3P
 FNPw==
X-Gm-Message-State: APjAAAVmVBWJ5JLguAo5LiwJWZIOFlnM0wJ0espYL0UgmQb6DyxBWk+x
 PferaXRAgSWAvdu85vfpNWjD7MdVYzM=
X-Google-Smtp-Source: APXvYqwXorNy9mnmL6/0PrXsVT63hG8FgJhvHuRDxhbyRySDeDP72YtVKjr9WUGewKF1gpsebYvNKQ==
X-Received: by 2002:a17:90a:c708:: with SMTP id
 o8mr36390626pjt.104.1577574733752; 
 Sat, 28 Dec 2019 15:12:13 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/29] target/i386: Use cpu_*_mmuidx_ra instead of templates
Date: Sun, 29 Dec 2019 10:11:09 +1100
Message-Id: <20191228231124.18307-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not use exec/cpu_ldst_{,useronly_}template.h directly,
but instead use the functional interface.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/seg_helper.c | 56 ++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 87a627f9dc..b96de068ca 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -37,37 +37,37 @@
 # define LOG_PCALL_STATE(cpu) do { } while (0)
 #endif
 
-#ifdef CONFIG_USER_ONLY
-#define MEMSUFFIX _kernel
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_useronly_template.h"
+/*
+ * TODO: Convert callers to compute cpu_mmu_index_kernel once
+ * and use *_mmuidx_ra directly.
+ */
+#define cpu_ldub_kernel_ra(e, p, r) \
+    cpu_ldub_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
+#define cpu_lduw_kernel_ra(e, p, r) \
+    cpu_lduw_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
+#define cpu_ldl_kernel_ra(e, p, r) \
+    cpu_ldl_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
+#define cpu_ldq_kernel_ra(e, p, r) \
+    cpu_ldq_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_useronly_template.h"
+#define cpu_stb_kernel_ra(e, p, v, r) \
+    cpu_stb_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
+#define cpu_stw_kernel_ra(e, p, v, r) \
+    cpu_stw_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
+#define cpu_stl_kernel_ra(e, p, v, r) \
+    cpu_stl_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
+#define cpu_stq_kernel_ra(e, p, v, r) \
+    cpu_stq_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_useronly_template.h"
+#define cpu_ldub_kernel(e, p)    cpu_ldub_kernel_ra(e, p, 0)
+#define cpu_lduw_kernel(e, p)    cpu_lduw_kernel_ra(e, p, 0)
+#define cpu_ldl_kernel(e, p)     cpu_ldl_kernel_ra(e, p, 0)
+#define cpu_ldq_kernel(e, p)     cpu_ldq_kernel_ra(e, p, 0)
 
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_useronly_template.h"
-#undef MEMSUFFIX
-#else
-#define CPU_MMU_INDEX (cpu_mmu_index_kernel(env))
-#define MEMSUFFIX _kernel
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#endif
+#define cpu_stb_kernel(e, p, v)  cpu_stb_kernel_ra(e, p, v, 0)
+#define cpu_stw_kernel(e, p, v)  cpu_stw_kernel_ra(e, p, v, 0)
+#define cpu_stl_kernel(e, p, v)  cpu_stl_kernel_ra(e, p, v, 0)
+#define cpu_stq_kernel(e, p, v)  cpu_stq_kernel_ra(e, p, v, 0)
 
 /* return non zero if error */
 static inline int load_segment_ra(CPUX86State *env, uint32_t *e1_ptr,
-- 
2.20.1


