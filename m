Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B87C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327692070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nzc7aLYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327692070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2gC-0006Ez-8z
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Im-0004ai-Ig
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Il-0003QK-5O
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:36 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:45074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Ik-0003Or-TD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:35 -0500
Received: by mail-pg1-x536.google.com with SMTP id b9so851831pgk.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UNrK4ZquBPwuG+9pKKZp2KPV+Uf9shFIJ31MhFoEhsY=;
 b=nzc7aLYXFi7mkTuqyvsQf9GXdE71CREQsWnW0Y0SjrxrtHJCPpk/cBpfkUNRwHHlso
 luOIxjxbnOOrZXqFQ0fTVhHpkkvdViD+8GJPOn1+Ci+P16yaYZ1UMr0Gr1Vw/xEd5yP7
 H4wq+t1RcHJB6pc/qgFBHAC85FKoW84wzsEazgL3ku3cGK8mV6cDSG7o9m3hG9F+wTjS
 9vaR9TikYpW0sGm4TP80quW/c9VONVgqLKtUTWZqXC82lw9cJSbYa+4o4K683C4iWYOy
 iteOIYazzswl4oVVkJGHJfJJ6IRF3LC+vgBXLd3xAXIMisunVG3dagHLIbQ9G0/CzYJN
 Jc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UNrK4ZquBPwuG+9pKKZp2KPV+Uf9shFIJ31MhFoEhsY=;
 b=AihvJicWOJRVgdpDAied1sktue55d4wcHLkfrd8A66kOa6yN/k9HQFUf2VWa9PIeCi
 sWDzCOl2YBtK2Qpv5GmRSFs8b+OUOcMOQZElSzn502fZMnc2QZ4cM2+a/6mtLolvD+4Q
 wr7/FV2EkxFTyJnl+//vRNdtXZj1PFF6CBcb7/DtVURmdrtMzhXEYmqvvkA0inUrfST3
 6eLQJUkIYAB8iMPzDeq3V0/Iz/+wImVe1Rmb+3RUZEgfF1MietUvDUsKkUIQW4/jVun1
 0AG1HyDYH7r4owGSRNKu6T8YRQlvIVBEzCiLjYbf2u0deI1dFAB79VJAm7OLKLs+B3vf
 R1gQ==
X-Gm-Message-State: APjAAAV1Cyl8E4LhXyZgW/HUQb0vi7empjPP1KHACDGXAf9XnpHVPMza
 ZRlxFlNtdgcbvJrkUFWiNy3IKbnvkWwemg==
X-Google-Smtp-Source: APXvYqy39oA8xd7SPOMQMWt5M7e1Ka/KwZX+8mi8Msyko7VOoZASHpBJHCkIeV4VuRTWSTvDxOnM9Q==
X-Received: by 2002:a62:62c4:: with SMTP id w187mr2943240pfb.216.1578455193742; 
 Tue, 07 Jan 2020 19:46:33 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/41] target/i386: Use cpu_*_mmuidx_ra instead of templates
Date: Wed,  8 Jan 2020 14:45:03 +1100
Message-Id: <20200108034523.17349-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::536
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not use exec/cpu_ldst_{,useronly_}template.h directly,
but instead use the functional interface.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


