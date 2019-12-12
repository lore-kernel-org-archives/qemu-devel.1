Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325A7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5AC206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zLNZwvnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5AC206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFvO-0005qN-Mi
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFfD-000192-1N
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFfB-0004a6-8y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:18 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:33834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFfB-0004YG-2A
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:17 -0500
Received: by mail-pl1-x62a.google.com with SMTP id x17so11610pln.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SlhvR/93XuswRqdgG5vpGH1hywauX0iU3FE7RaogKGg=;
 b=zLNZwvnKB387m+0wk5lGlh77frGIEKkNE1kcFsydepLKR6AJDa7qfiV5jYFbF1q/WN
 hZvkHQAPnU2T4hEneQZ4oPPiPpcpq5Wk/BVy9CrEkwloOTRrrwvoCQwKdYZoN70V7BE2
 w9nh4+Fa83ZJa7s2b5Us6NjLOqWLExAEzNhSVnIE12fLK/8bIXjtwLR+tryqLhRbF4sN
 vn2Cw3TTCpasPUOz1LmUwhjubPZohTwryOY4npEdkU4D/qxQRLtkMM3xhZeI5jQ9to6k
 1YNW3e8vmZ8Fw7Z7z3XWDBip/aZ9/CpwxvF0BHL2/yeWWKenbbIAkcPU7tzkYUjOS9F9
 Ow8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SlhvR/93XuswRqdgG5vpGH1hywauX0iU3FE7RaogKGg=;
 b=EyOAmQnS5whD4Kt9EYqH/ke3fIOawv/sizHJUi24+7hWURqr4E1pjt8UOB7daSd3Py
 VYEFmVQSBNHDMHf3A2PHvPcuKSIkaEYFjYw8OarUL3DQrHQkYZx182Muu444MCeNkJMJ
 x7o19mMqm42qloPD/l+FN2ZsXOhyv1cThJicfZ/I8A/Yu2+IBepMqpHb+SPD/WayOBxB
 I8PsmUDto4oGe5FdmuBvyToSe62IvTx8/3qiRSGRR7qER3MIge4ARQYiNTNjn17PvtlJ
 a6sezuugbFHNR5yfeTfzg+JP1WANP0ud9etDAzVX3K7X9xU0rbuZ5yLJsooMchdbRkag
 bpIQ==
X-Gm-Message-State: APjAAAWptSoYKzlEF5TZ026CR7+AenV/TzNVfteZCfVCnh6su3cJaMeo
 ZbrT/fwiNlvnXyU1TJ0fktBucWTx4kM=
X-Google-Smtp-Source: APXvYqzqp9afJdiLHL9kYKgiN0fLAWktKNrlqfGRqo7Q2J1xXegRwK7P9O1qegHYwUUqJoGQ4C6tNQ==
X-Received: by 2002:a17:902:b101:: with SMTP id
 q1mr7411639plr.258.1576123275661; 
 Wed, 11 Dec 2019 20:01:15 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.01.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:01:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/28] cputlb: Remove support for MMU_MODE*_SUFFIX
Date: Wed, 11 Dec 2019 20:00:38 -0800
Message-Id: <20191212040039.26546-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
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
index 5a638fd8d6..eb2756e214 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -275,236 +275,6 @@ void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
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


