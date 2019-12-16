Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227D4C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BFD206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wyuaflLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BFD206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyuI-00047z-TR
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybd-0005lM-Tl
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybc-0007mx-Dy
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:45 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:45433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybc-0007mn-86
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:44 -0500
Received: by mail-pg1-x533.google.com with SMTP id b9so4480231pgk.12
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YTuCdqr9DEUMKluaH9JJH2GYVGYBP4+e1sXlxhX3YMM=;
 b=wyuaflLbQ0n+753IJD9gYKpglKib62zcMroJoS+viMHwKapoHvdt5AfI0ebPPHMVjr
 UIvCvs3MONOFPjq+SHqKYa9N0uy0cblwekkcKIK20lkYsdz3+sg5+smNono27rOIkJes
 weMUi6CM5Rh9xyMKVnEvwoznF7JE57CsODSvpn3ArN02Lot43nk1HjFBrdI/i8S4gyei
 K9Eu4zXBsGtjLfrhvrbMgRIskgc3onCMKZt+T/+rI/pbhPhXEWlXYgeHDlcuMCeMQFK/
 7xe/ZuIaLk7qzvzo0ZX7WtQCTJ24CzY0q8x6PEHhey/T6uy90sr3xtZThZaC76rPSRlI
 AFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YTuCdqr9DEUMKluaH9JJH2GYVGYBP4+e1sXlxhX3YMM=;
 b=Ckq08K2JIGTAmgExMbaXghuo6M4GKeeiKO4RdrfRFDEYuoPzND/ypXGX2Ziad9fShI
 mBc1o/EDtnwA+F+6sI/dw+PnnAA+RGERVGq5yKvE/igChNHlB8qsqUr318VpXIKFbnQo
 cHvJLpzRhwJRmX07xrseHCvzfaS2NHn4K8IJ64HhXuhCIYQpKnWjk4BdA3siQhgfcwoJ
 BHA3oKo2skPS9OMLqMCTd9+Z/Tjp+KjEM9cX9rtAiMnxsnTU2dCy5VZyz0DFgT9uwUM6
 1AveonxVUFSuFGGDKZ4Sh+RXiOOQFw3YQOKE6rHBIk2o75WRGgtpp7BaWAbL15a0zyVy
 KZmw==
X-Gm-Message-State: APjAAAWVEhyvSnstA4vbfVALsrnGGrvPASp9BgsiHT8xLjoU+ELO3+rN
 PADI2Sk5+UClt1wecWUOTrZvhMfclkg=
X-Google-Smtp-Source: APXvYqzt4s71Q/gtn5c50oxurvcE4c8wyoWQcvmj6ZiTYAY6i6KzD0n8UZYT4NoanPqEghPftjAoZA==
X-Received: by 2002:aa7:94b0:: with SMTP id a16mr18583691pfl.35.1576534362770; 
 Mon, 16 Dec 2019 14:12:42 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 27/28] cputlb: Remove support for MMU_MODE*_SUFFIX
Date: Mon, 16 Dec 2019 12:11:57 -1000
Message-Id: <20191216221158.29572-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::533
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All users have now been converted to cpu_*_mmuidx_ra.

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


