Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFE4C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB82B21897
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZX5qUuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB82B21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3hYk-0005zu-3u
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 10:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3hQQ-0002WL-DB
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3hQL-0006FD-C9
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:58:48 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:34655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3hQI-000698-FG
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:58:43 -0400
Received: by mail-qt1-x843.google.com with SMTP id a13so7709770qtj.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vRsyyffHf4GorTQg+zQERwHpgqAb86sdgRvKLpX2hVo=;
 b=tZX5qUuJYJ0Ea6VqkNjzhXB73BPTxVBhlVzzTd6QWX4vlSB99CjD1bX82NuXCVz686
 gTU2IYVoEf5EhZE4/zETBf8X1+U1rKMWXRWL38rjgZgGqTTGqN4rRRX/DcVlYRMeKKWH
 3DL8dceatJlIgw1G3+oxAEFdL8nvLfsMQdqhkEizO1Ng4lbfv0innvO2yUndkGbFoe2y
 h1k7pwPJzC1kbO2DybE3n76WwZQ3G1/L7bZKUMQq1nKKFq8okRUZCYyNuk8jjSQ22MVY
 yjLJZ2sMGrJ9OgMYionR3V6PO/quGENQaDOyBaGsxeVy34PgVnFC9ZMf2v548M2R4zz4
 sCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vRsyyffHf4GorTQg+zQERwHpgqAb86sdgRvKLpX2hVo=;
 b=GPQ4csY9+Ky5JkZPjFfTHJkOxAPJTYaO3Q8nxNv1XPZ/KCtdDVWJ5ghYxC5LUk6DVI
 4zU+orhHv2zRbPpE0xjYhIDZWZr8m9Vz0UpC/uXHVzAxYxajoh0jUWZr/KP28rTQlzVB
 JxtmF4VJ+g5GRncda/Z4TWwgMEOxbKIvGUpvsZzT/ZhWuAUzGC6BDsrzE532HGhfhVne
 rz/ICPe82lpWVwxx+g97p7/kYLFaCJVhuSmTbTTwULJLQVQVHodBV3A3WKUn7TFuuEiB
 IZQklLcS+sKHruut2YZlw7ztr+iMftdCSKy2GfdJQWGbXLgdMOasHwrl6yI3/tWkvA92
 1Ihw==
X-Gm-Message-State: APjAAAXTCjNnikhIxHxetkVXQ0IL2/TL/hXkZ6KpL4uIcAGVb91t2uI1
 p7AVhnl4WGmPRay14wNS7VkTr5e/3uNHsA==
X-Google-Smtp-Source: APXvYqwwnvbl5mg2Y+KPhsT9qOAJddRvEMUaoXrL75H7dMCuT4BtWXGTuDouHSW6zWPpycz1cXJdUg==
X-Received: by 2002:ac8:2d2c:: with SMTP id n41mr14934711qta.28.1567167557791; 
 Fri, 30 Aug 2019 05:19:17 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166]) by smtp.googlemail.com with ESMTPSA id
 o127sm3001299qkd.104.2019.08.30.05.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 05:19:17 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 09:19:03 -0300
Message-Id: <20190830121903.17585-3-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190830121903.17585-1-vandersonmr2@gmail.com>
References: <20190830121903.17585-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: [Qemu-devel] [PATCH v2 2/2] tb-stats: adding TBStatistics info into
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
 accel/tcg/perf/jitdump.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/perf/jitdump.c b/accel/tcg/perf/jitdump.c
index 6fb464039d..6a7ca4cf06 100644
--- a/accel/tcg/perf/jitdump.c
+++ b/accel/tcg/perf/jitdump.c
@@ -21,6 +21,7 @@
 #include "disas/disas.h"
 #include "jitdump.h"
 #include "qemu-common.h"
+#include "exec/tb-stats.h"
 
 struct jitheader {
     uint32_t magic;     /* characters "jItD" */
@@ -149,7 +150,20 @@ void start_jitdump_file(void)
 
 void append_load_in_jitdump_file(TranslationBlock *tb)
 {
-    gchar *func_name = g_strdup_printf("TB virt:0x"TARGET_FMT_lx, tb->pc);
+    gchar *func_name;
+    if (tb->tb_stats) {
+        TBStatistics *tbs = tb->tb_stats;
+        unsigned g = stat_per_translation(tbs, code.num_guest_inst);
+        unsigned ops = stat_per_translation(tbs, code.num_tcg_ops);
+        unsigned ops_opt = stat_per_translation(tbs, code.num_tcg_ops_opt);
+        unsigned spills = stat_per_translation(tbs, code.spills);
+
+        func_name = g_strdup_printf(func_name,
+                "TB virt:0x"TARGET_FMT_lx" (g:%u op:%u opt:%u spills:%d)",
+                tb->pc, g, ops, ops_opt, spills);
+    } else {
+        func_name = g_strdup_printf("TB virt:0x"TARGET_FMT_lx, tb->pc);
+    }
 
     struct jr_code_load load_event;
     load_event.p.id = JIT_CODE_LOAD;
-- 
2.22.0


