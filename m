Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7D9C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB43206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1OUPrME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB43206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyi8-0005Go-8g
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybB-0004xZ-8J
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb9-00072b-OK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:17 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igyb9-00072H-J8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:15 -0500
Received: by mail-pf1-x441.google.com with SMTP id 2so6361575pfg.12
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lsCNvFrnH2M18XdHCXW5ZamBsqq1c0FHuOYep4yKETk=;
 b=M1OUPrMEEdTWjq9e9kBnv9dRB2o0OsoH21mIPE3FnQ8a2f4PDm1MY6/3FroKZE1lL3
 YrJiUTaITQbM9vJg+H0t2SyHJhWGIB0OPdpYWJ2hcCdIKI8iFAPhejlXi6GPQ8Pp8MWB
 hDcXQ8ErVaMLkOL99Nrj45rng+IU4UKjPVm5shQGlHz+B0l4SChaXF5r8tZQ3zENvuzW
 cgzQXsHF53XPVMIuwlKj8nFmDi7n0B+8/sULxt92IyT0lhFbLShF8KtD5yKTBSNRSRo0
 ySM5b+5R+JuDbZK+S1Mbv9nFKBaCkNmIS3H+r51SFmAf251hRnkPyeIjKd6DzkYAChWs
 Kfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lsCNvFrnH2M18XdHCXW5ZamBsqq1c0FHuOYep4yKETk=;
 b=K93+Pyhr1HkiC6sPEhdceTyN19FIRaX3HWhNSo9+xssjyrcGW+sDAPWMYCPONgzB6G
 Fc8a/RTkKgZWfDPAjOy2NPSfAtLAXUKSgzEAAtTpDd5t1fK2lkiZY91TzQUUFY5zbHSj
 v0c/xXyWQt25pkSaGOAytpSgP61y0LQqu5idkFHwansd3IKf8WzyG3bTLF7AiWjPo/h0
 t2SF+zwTA+jetayAavqIPVthf9iyvoUUujdptg5DK2KjuxdjmdSlR0eIAZSllvhXBZzt
 gUeFn7sk3TvncaMySvL/lC1oWMyV6JhGqeJ3d5kMgtnvUfC6uUY3gJkvxtXYUu4ekb9f
 ecNA==
X-Gm-Message-State: APjAAAWNE1RUAbluk3yjj87RaeQ4o7WGmGd9LGFcbXYUwZsxqkKGtVba
 g7bAHUYO1MuVjtqOMEcOBZR5pQkYP+A=
X-Google-Smtp-Source: APXvYqz1pwc5LRanoNAd12hu9TKM78dWDZv3oCTgMt9WgmRX4jUUnaIXjAHpaFhl+SG8SlR5YwoI4w==
X-Received: by 2002:a63:2ccc:: with SMTP id s195mr20644457pgs.75.1576534334271; 
 Mon, 16 Dec 2019 14:12:14 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/28] target/i386: Use cpu_*_mmuidx_ra instead of templates
Date: Mon, 16 Dec 2019 12:11:38 -1000
Message-Id: <20191216221158.29572-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not use exec/cpu_ldst_{,useronly_}template.h directly,
but instead use the functional interface.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
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


