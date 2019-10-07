Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8D1ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D10D20700
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIGMGrUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D10D20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHV8A-0003vi-1J
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwP-0002g8-0J
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwN-0005DJ-Lk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:50904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUwN-0005Cq-EV
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:51 -0400
Received: by mail-wm1-x331.google.com with SMTP id 5so13176013wmg.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YDBJO83fFMPFHsguCkuLARuLU3nbWbIEfUOqbeuNP6c=;
 b=TIGMGrUW9sr9ncmhU4HLzl6a0/7ts2oEV5UuyE2MWL+4XtI7gv7vJcHCcuGtExwHvg
 lvmXv5G4Gl4XRg+PbNhu5NN7kBGnsEEbBKVMg1+LNnwPZkLK9kR7DDD0ORiZaAQxq7Me
 R2ERPOsSCb7A6hoslnhWyxlxa+4Ar3Nq54INfJxMcePPvzUGcDWktSxKELdHBdefCvdX
 Rj/C72DM+nNnlXH0pIUXzWHoHYHjHbl6d1CRskHiXi+Sbi+6e0f3X/qbVAzMsSXMkkK0
 EYDBKnzApZ6zcgTH5yXWIIcvxR5L7xj83A7Rgkslv3sDuFcAoKeBkSEGhNTM8wtwMkju
 j0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YDBJO83fFMPFHsguCkuLARuLU3nbWbIEfUOqbeuNP6c=;
 b=LifjM8YsxkWrEOGczdIBbFfLiXohAmPus8K0kIFbLyWM25mX5rgqAWvBuBnpD5YwaB
 Scou2J5uIpXFcDQd77CRsUAkaX20MJ7dO79tAObiOceW5St3jBGKHAbq7NuSLWXqvocm
 2QGQb+AkjrZc5pt7nCkyOqpoQOQR4fiVf2hpDaPQmygAtJgxEGZYfbcQi3k6NdJwfrjZ
 GPbZlkWU02gy9JsksWQ0zYKayKeIDiUMvdAxWdbgFIM9aoqPVQ8aH1e0r60Oh/HMIXyh
 1rHq/xGWt1qcnalsnGeASX5LqmsbDuwm4QBj1aNqmCiU4KBTYAeAlw3Ma6DxGvPS6vmX
 Jovg==
X-Gm-Message-State: APjAAAWYj+Vg1oon/gd8+4x9mfBCC5v/Cc7fs8zrgA6yWxHRfuzVjYmc
 vCPe9xCBvCOAq1zLQOW65rcpeQ==
X-Google-Smtp-Source: APXvYqyC4tfwDE522+pyTvwHuqGfFMgYbV7fX3Knr53kAlSyKPKsPoXdBl0m+qKza6/OV6EMtJIK4w==
X-Received: by 2002:a1c:5fd6:: with SMTP id
 t205mr20768288wmb.124.1570462130265; 
 Mon, 07 Oct 2019 08:28:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r140sm14661979wme.47.2019.10.07.08.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:28:47 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9EEC71FF87;
 Mon,  7 Oct 2019 16:28:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v9 12/13] tb-stats: adding TBStatistics info into perf dump
Date: Mon,  7 Oct 2019 16:28:38 +0100
Message-Id: <20191007152839.30804-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007152839.30804-1-alex.bennee@linaro.org>
References: <20191007152839.30804-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>

Adding TBStatistics information to linux perf TB's symbol names.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190830121903.17585-3-vandersonmr2@gmail.com>
[AJB: fix authorship, auto-strings]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
AJB:
  - use g_string and auto free
---
 accel/tcg/perf/jitdump.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/perf/jitdump.c b/accel/tcg/perf/jitdump.c
index e1d6f2214e..e7b86173e0 100644
--- a/accel/tcg/perf/jitdump.c
+++ b/accel/tcg/perf/jitdump.c
@@ -146,7 +146,20 @@ void start_jitdump_file(void)
 
 void append_load_in_jitdump_file(TranslationBlock *tb)
 {
-    gchar *func_name = g_strdup_printf("TB virt:0x"TARGET_FMT_lx, tb->pc);
+    g_autoptr(GString) func_name = g_string_new("TB virt:");
+
+    g_string_append_printf(func_name, "0x"TARGET_FMT_lx, tb->pc);
+
+    if (tb->tb_stats) {
+        TBStatistics *tbs = tb->tb_stats;
+        unsigned g = stat_per_translation(tbs, code.num_guest_inst);
+        unsigned ops = stat_per_translation(tbs, code.num_tcg_ops);
+        unsigned ops_opt = stat_per_translation(tbs, code.num_tcg_ops_opt);
+        unsigned spills = stat_per_translation(tbs, code.spills);
+
+        g_string_append_printf(func_name, " (g:%u op:%u opt:%u spills:%d)",
+                               g, ops, ops_opt, spills);
+    }
 
     /* Serialise the writing of the dump file */
     qemu_mutex_lock(&dumpfile_lock);
@@ -167,7 +180,6 @@ void append_load_in_jitdump_file(TranslationBlock *tb)
     fwrite(func_name->str, func_name->len + 1, 1, dumpfile);
     fwrite(tb->tc.ptr, tb->tc.size, 1, dumpfile);
 
-    g_free(func_name);
     fflush(dumpfile);
 
     qemu_mutex_unlock(&dumpfile_lock);
-- 
2.20.1


