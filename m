Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7DDC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CF520838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LST3JD1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CF520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLc0-0008H0-AT
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLGS-00067O-Tt
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLGR-0001qE-FK
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:56 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:44419)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLGR-0001lv-8N
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:55 -0500
Received: by mail-pg1-x529.google.com with SMTP id x7so16254096pgl.11
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gwNisjSCbkUpTKZI0ymm9h7t/G0Gf4eKOZKY9iP+SJQ=;
 b=LST3JD1TEwjhpy0cfp4U0VpM16RLIlsyN4RUKoEuRp/YQvUMabIN2muW4dnsql7i6T
 JxhKYc1V7sIdWR0aBtgqfiJGNfOVajlA/DHkDzhbauDzRfOmhA1dfUDAPgSCojEvAnHs
 U5NP+hB0aRCNsIGjdTER+L9CIUF3IFZ1+U/2OV6pb5D3JjNqiodE2fWX0VrdZGk15Zqg
 J/aU1AN7XHLgtQaVMwg6PX1NdiqICt/YdBT0BFZh4LGz3mzNUV7d8w2ITvjMoTKsOwW9
 TpfsorR2Afz07D2/6rtF/Of95JO/xHo+2M9h+mPIhPxdowrG9J6GCdCa3Vtz/jbICnmv
 w08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gwNisjSCbkUpTKZI0ymm9h7t/G0Gf4eKOZKY9iP+SJQ=;
 b=BfNIqwMp3E1vAZFEYskpDYO4ZokaqdQB5Y11geUrnRfNznp3sI+X67P8azNWgH65aT
 Gv/fGSIDszV26N0fWWOtbRNZNWN4Kl03bHZ9Cc+fNern7RGaSYOloGY71qDW0onU/sGL
 HJ5Maooce1RXX5rSpKc29H7bOpNkzfwXpPQqSIOkvQCzzKSQPjLsOOvVcnkqgeTr6Tfs
 9eZau6bQUBGLdC826zae1RkKU45oaWoejOiudFHqxyinCvRYY9diQx3DWJUjfCntXTgi
 RsZnpolmLLd7SYBuR2xtwLaLq/BYB3R1FDYKrfBj49YAjOPftp4LfPDbayb0uPOuyMFv
 lMAQ==
X-Gm-Message-State: APjAAAUThI4rhLp569NOOHF4oRJIGwWXg7mgZPX34GOrOBhDOTkdLp90
 HIUcpWhoa94g5Cz73G6Jme5/JNeH/B0=
X-Google-Smtp-Source: APXvYqzVM7xw7UFJH18+oHMqKZKpB678PdDfLhKFdwgWzjTteTOB0zyqPTqpGstSWbE20NxUrcCb5w==
X-Received: by 2002:a63:7985:: with SMTP id
 u127mr61686341pgc.169.1577574773984; 
 Sat, 28 Dec 2019 15:12:53 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 28/29] cputlb: Remove support for MMU_MODE*_SUFFIX
Date: Sun, 29 Dec 2019 10:11:23 +1100
Message-Id: <20191228231124.18307-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All users have now been converted to cpu_*_mmuidx_ra.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 230 ----------------------------------------
 1 file changed, 230 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 0f3c49a005..cf4652bf48 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -271,236 +271,6 @@ void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
 void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
                        int mmu_idx, uintptr_t retaddr);
 
-#ifdef MMU_MODE0_SUFFIX
-#define CPU_MMU_INDEX 0
-#define MEMSUFFIX MMU_MODE0_SUFFIX
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
-
-#if (NB_MMU_MODES >= 2) && defined(MMU_MODE1_SUFFIX)
-#define CPU_MMU_INDEX 1
-#define MEMSUFFIX MMU_MODE1_SUFFIX
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
-
-#if (NB_MMU_MODES >= 3) && defined(MMU_MODE2_SUFFIX)
-
-#define CPU_MMU_INDEX 2
-#define MEMSUFFIX MMU_MODE2_SUFFIX
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
-#endif /* (NB_MMU_MODES >= 3) */
-
-#if (NB_MMU_MODES >= 4) && defined(MMU_MODE3_SUFFIX)
-
-#define CPU_MMU_INDEX 3
-#define MEMSUFFIX MMU_MODE3_SUFFIX
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
-#endif /* (NB_MMU_MODES >= 4) */
-
-#if (NB_MMU_MODES >= 5) && defined(MMU_MODE4_SUFFIX)
-
-#define CPU_MMU_INDEX 4
-#define MEMSUFFIX MMU_MODE4_SUFFIX
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
-#endif /* (NB_MMU_MODES >= 5) */
-
-#if (NB_MMU_MODES >= 6) && defined(MMU_MODE5_SUFFIX)
-
-#define CPU_MMU_INDEX 5
-#define MEMSUFFIX MMU_MODE5_SUFFIX
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
-#endif /* (NB_MMU_MODES >= 6) */
-
-#if (NB_MMU_MODES >= 7) && defined(MMU_MODE6_SUFFIX)
-
-#define CPU_MMU_INDEX 6
-#define MEMSUFFIX MMU_MODE6_SUFFIX
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
-#endif /* (NB_MMU_MODES >= 7) */
-
-#if (NB_MMU_MODES >= 8) && defined(MMU_MODE7_SUFFIX)
-
-#define CPU_MMU_INDEX 7
-#define MEMSUFFIX MMU_MODE7_SUFFIX
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
-#endif /* (NB_MMU_MODES >= 8) */
-
-#if (NB_MMU_MODES >= 9) && defined(MMU_MODE8_SUFFIX)
-
-#define CPU_MMU_INDEX 8
-#define MEMSUFFIX MMU_MODE8_SUFFIX
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
-#endif /* (NB_MMU_MODES >= 9) */
-
-#if (NB_MMU_MODES >= 10) && defined(MMU_MODE9_SUFFIX)
-
-#define CPU_MMU_INDEX 9
-#define MEMSUFFIX MMU_MODE9_SUFFIX
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
-#endif /* (NB_MMU_MODES >= 10) */
-
-#if (NB_MMU_MODES >= 11) && defined(MMU_MODE10_SUFFIX)
-
-#define CPU_MMU_INDEX 10
-#define MEMSUFFIX MMU_MODE10_SUFFIX
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
-#endif /* (NB_MMU_MODES >= 11) */
-
-#if (NB_MMU_MODES >= 12) && defined(MMU_MODE11_SUFFIX)
-
-#define CPU_MMU_INDEX 11
-#define MEMSUFFIX MMU_MODE11_SUFFIX
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
-#endif /* (NB_MMU_MODES >= 12) */
-
-#if (NB_MMU_MODES > 12)
-#error "NB_MMU_MODES > 12 is not supported for now"
-#endif /* (NB_MMU_MODES > 12) */
-
 /* these access are slower, they must be as rare as possible */
 #define CPU_MMU_INDEX (cpu_mmu_index(env, false))
 #define MEMSUFFIX _data
-- 
2.20.1


