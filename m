Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583E1C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2213E208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoY8Ekq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2213E208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5jc-0004kj-1X
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1hy5e6-0006jl-QD
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hy5e5-0006Zx-QZ
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:37:46 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:35659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hy5e5-0006ZK-MR
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:37:45 -0400
Received: by mail-qt1-x842.google.com with SMTP id u34so985463qte.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fFC4esQW2qMfDSIJCUM850Bj6YD7rV98KCqVZlJNxBo=;
 b=PoY8Ekq7CJL+AhECNm8TT86vlhkdVpXgNYZUJMoGBfmAmsu738jsGfpVBnXBR4LbBq
 uZ7iCOekmXif4fP/Mf8NHehRvKFTXTb7nyoR/v0Kdm26RMBSu2K9koeTVXZPfM7Lf3xe
 /L7B4ZM5ZV2YSe/NMjGFb+i8IfgLPZoeHTHLoaXehdQLcbzl9pL+LIHDRLo26o5imd4x
 P3S/FfTnDGv6Fg5cGKQh8QVcoLipQrY4qMQqRAZBsJLtCQkwHRpBQ8Owd11GUOvbxL30
 vf/XJ06/aetE8xYlhIOxU2MHfTAMLz6MkLxCJyYVRObkGK9yBJUCK+CiKXq3Jm6f34fG
 2CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fFC4esQW2qMfDSIJCUM850Bj6YD7rV98KCqVZlJNxBo=;
 b=PO7U4hcq1/tKVeL4xjUVK9us3Bz7eeMl3COmLdLLA1og1p8DyE+a5pbBZGrXD0EvL4
 tKAeNKCHrhRXg4NtjoUkJX8JvkTHaL2MZDA0JylRbG413C4Fm+q8HREUMsx2jwbVu4KT
 In8Y4SZwsKWr1q+8iVrUXn7w1V24CL6EzL+aWkjGMbvnWCzob+8r6UQAjRFRGFvaSyfd
 Xq+8PKxhC6/362lN8VsmVSkMKm5GhmLAb8lPiGu7UjewFqDaqHe22pjGmacI0G7sfybw
 xI8LCFhtEhPtOne2UOLCy09+lrZ3u2URukg1kYW53fDmeIykgRut5lZ9VSPy7kWI9jEO
 S6XQ==
X-Gm-Message-State: APjAAAXHIkDtUivg9550LyqHIbA0qrL/KmDVnubrb9p9J4olBaBLfPfJ
 Sh+ASfcMo5lhIDf6PFQ4IeKqm6lj/Tf7hw==
X-Google-Smtp-Source: APXvYqyveCOrWKEtnFw6oh2dtBOLRbnVqP+QvHwiaXUQCEz+HBOuKXO5GUHFb2m9Bey0iJDXFC5qBw==
X-Received: by 2002:aed:3e6f:: with SMTP id m44mr2158452qtf.220.1565836664960; 
 Wed, 14 Aug 2019 19:37:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:121::1])
 by smtp.googlemail.com with ESMTPSA id t24sm764052qto.69.2019.08.14.19.37.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:37:44 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:37:25 -0300
Message-Id: <20190815023725.2659-3-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815023725.2659-1-vandersonmr2@gmail.com>
References: <20190815023725.2659-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH v1 2/2] tb-stats: adding TBStatistics info into
 perf dump
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding TBStatistics information to linux perf TB's symbol names.

This commit depends on the following PATCH:
[PATCH v5 00/10] Measure Tiny Code Generation Quality

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/perf/jitdump.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/perf/jitdump.c b/accel/tcg/perf/jitdump.c
index 6f4c0911c2..b2334fd601 100644
--- a/accel/tcg/perf/jitdump.c
+++ b/accel/tcg/perf/jitdump.c
@@ -8,6 +8,7 @@
 #include <sys/syscall.h>
 #include <elf.h>
 
+#include "exec/tb-stats.h"
 #include "jitdump.h"
 #include "qemu-common.h"
 
@@ -135,7 +136,19 @@ void start_jitdump_file(void)
 void append_load_in_jitdump_file(TranslationBlock *tb)
 {
     GString *func_name = g_string_new(NULL);
-    g_string_printf(func_name, "TB virt:0x"TARGET_FMT_lx"%c", tb->pc, '\0');
+    if (tb->tb_stats) {
+        TBStatistics *tbs = tb->tb_stats;
+        g = stat_per_translation(tbs, code.num_guest_inst);
+        ops = stat_per_translation(tbs, code.num_tcg_ops);
+        ops_opt = stat_per_translation(tbs, code.num_tcg_ops_opt);
+        spills = stat_per_translation(tbs, code.spills);
+
+        g_string_printf(func_name,
+                "TB virt:0x"TARGET_FMT_lx" (g:%u op:%u opt:%u spills:%d)%c",
+                tb->pc, g, ops, ops_opt, spills, '\0');
+    } else {
+        g_string_printf(func_name, "TB virt:0x"TARGET_FMT_lx"%c", tb->pc, '\0');
+    }
 
     struct jr_code_load *load_event = g_new0(struct jr_code_load, 1);
     load_event->p.id = JIT_CODE_LOAD;
-- 
2.22.0


