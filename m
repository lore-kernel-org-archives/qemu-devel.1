Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE02C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE24E20679
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWLw29C5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE24E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVIn-0004Yc-K6
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwL-0002bT-G8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwJ-0005BF-QH
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUwJ-0005An-IS
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:47 -0400
Received: by mail-wm1-x341.google.com with SMTP id v17so12819265wml.4
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hggjK8Ae7uaAUz2uVJWEK720XDx0HS+iysTy3zwJ5bU=;
 b=MWLw29C5a2/tlUtOGDP/AnatDJmaxu0PByRmZLHFIsv+fah23hB3Q2g8z4cbTD/LpR
 BftdHZtbtz0OvC+5HOdflMFx5fn8Va8EgNyFEkiot5GoQdnbh8oKYTEbrwGB9lIfW7wl
 g0mOQerJ/niZ585wyebpDqijrjySlMafW/wsv9iruG8kpIyHV7tYD16RnUkTSRJbYFb2
 CBcJ9t+4+QSM91Pr+Z42ztrGeOVGirFNyk5WtK9wIpgasjTVUKbiLPkdwSSF3+3+B11b
 UZqxQaZGKtJv9HtIazpiKLkoMiMBnrQX1DD1kcRAvDoCE2rwYmbucOSNqwSN0FdbTd4w
 5N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hggjK8Ae7uaAUz2uVJWEK720XDx0HS+iysTy3zwJ5bU=;
 b=JO8eJPixliPUkg05AWCmWZHgOzEpVmvR7JgVUBt4j4Iy83Uh3XMHPKrYG74mySmhq7
 jyPJ+VQ4DuAYAIlzecNRQHA71S48lo6IY7k3Tz04IFSFvpQiaU+8OR83jnYYPhKv9nQR
 yNFg1KXceOU3el+6gWbR3rHROeKhcGKcCugMvNPx3pCfTsspREPqmDLrul7Q/EZEhON4
 3riBfHllr8oOrq2zoNS8srwBJq/9HeJvX20PPKL7nmG3a4/fmA9ssnAqpB21o631Vp90
 4CAdZco1U/vjVlRlw6MQ+4Gy5i9fvDB+HeFJ595JYe7L2AhbYhQaa5MaVATFxvheAxi1
 iLdg==
X-Gm-Message-State: APjAAAUX1+zLSQNlE5qJjYmnfweCPX74lYdOljyhp2AI6x0gUuNWu+UZ
 5gjtM3XGb4AdTcJm14h+RgpgGQ==
X-Google-Smtp-Source: APXvYqz4zPDjbhCqy5hBdXcWCGhQ9m9CvQOX8K050s4Gh2Eyw2G+jazsFdpmxZpuT/UinBaR68omwA==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr17163987wme.137.1570462126494; 
 Mon, 07 Oct 2019 08:28:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y13sm21402104wrg.8.2019.10.07.08.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:28:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 23B8E1FF98;
 Mon,  7 Oct 2019 16:28:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v9 08/13] tb-stats: reset the tracked TBs on a tb_flush
Date: Mon,  7 Oct 2019 16:28:34 +0100
Message-Id: <20191007152839.30804-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007152839.30804-1-alex.bennee@linaro.org>
References: <20191007152839.30804-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We keep track of translations but can only do so up until the
translation cache is flushed. At that point we really have no idea if
we can re-create a translation because all the active tracking
information has been reset.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/tb-stats.c      | 19 +++++++++++++++++++
 accel/tcg/translate-all.c |  2 +-
 include/exec/tb-stats.h   |  8 ++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index dabc5150f9..f08e5f2540 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -247,6 +247,25 @@ void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
     g_free(cmdinfo);
 }
 
+/*
+ * We have to reset the tbs array on a tb_flush as those
+ * TranslationBlocks no longer exist and we no loner know if the
+ * current mapping is still valid.
+ */
+
+static void reset_tbs_array(void *p, uint32_t hash, void *userp)
+{
+    TBStatistics *tbs = p;
+    g_ptr_array_set_size(tbs->tbs, 0);
+}
+
+void tbstats_reset_tbs(void)
+{
+    if (tb_ctx.tb_stats.map) {
+        qht_iter(&tb_ctx.tb_stats, reset_tbs_array, NULL);
+    }
+}
+
 void init_tb_stats_htable_if_not(void)
 {
     if (tb_stats_collection_enabled() && !tb_ctx.tb_stats.map) {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 396e63c3e7..871d91d559 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1273,7 +1273,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 
     qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     page_flush_tb();
-
+    tbstats_reset_tbs();
     tcg_region_reset_all();
     /* XXX: flush processor icache at this point if cache flush is
        expensive */
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 921da38c97..c20a3e6439 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -125,4 +125,12 @@ struct TbstatsCommand {
 
 void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd);
 
+/**
+ * tbstats_reset_tbs: reset the linked array of TBs
+ *
+ * Reset the list of tbs for a given array. Should be called from
+ * safe work during tb_flush.
+ */
+void tbstats_reset_tbs(void);
+
 #endif
-- 
2.20.1


