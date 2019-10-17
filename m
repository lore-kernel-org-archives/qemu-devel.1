Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D674ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C3E21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oAEcbGqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C3E21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL76X-0003kH-Kb
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wJ-00064d-5e
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wH-0004aR-3L
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5wF-0004XW-1G
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id y135so7060148wmc.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P3Npp9kH1WEA99RC652KClnJyNjkx/khNWALo0be13M=;
 b=oAEcbGqYG6oxYP68i32TzoR4Erhb3LaCyXOWnKK8XBW94sX+eHcY87oFcYUCMyxQaP
 Dj2i58Do/ZsjlK7YGyR/H7/PX72sMA5VFIgxiA/S+H+Ja+vuEPj4G3MeTlzShIRfLo2c
 bhbCYObE9qYIQfpLcetLgHEv8pzN6PrBzP1AGTYXWtwU3G2qM5yNvfAmepEp+GjSpQ55
 BDbnwU4/7wL2LLtExcT1jwsStlKSo2rzjwKpvwGiri2KJsLmFJcQSXZYxeFSedxRdVPI
 B/7mk7O45r+wIKgXfGiDMDmad4fx9kStYpgztef8OGhgRpbCxCp24Hs0ePEtFgkvlahI
 dTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P3Npp9kH1WEA99RC652KClnJyNjkx/khNWALo0be13M=;
 b=s5xCHCZ0uRzJfFHADehy9lZhRPpYwM5SdmCdgEPWaimbES48MQZCCGL3rb2DqKwckL
 hvxsXGNntIHEGGZ+HHLp/SgyOHWQmR/IrD3dhVqRRRoBtsINSN/ekPb7jIfFT2n+CXwB
 RDuOCw9Lh1uF2QTdJA9Szni6KdfJt6cuQwA5cX0OVrMtHcjQP9/FWsGrXW1aZnL08tox
 Wptv91K51agFbM9AWsWHRkUTYenx6l8iG2QpZJKsRFe+4ZcLlRhxn6rj1iQu64R5QWmm
 Tl35PqXwYfjpmvgDwDsNOQVHRa1A14COdIUYnU49wox06ghPoFRUSxFyuWgyfVKya44V
 5cSA==
X-Gm-Message-State: APjAAAVdhs357W7C0qB6GHFfUDq1FLU8oop1pyVQmCTqWhL6P1C27tYU
 UU9wMwK0DBYFRQ4gC9dKiDcRCg==
X-Google-Smtp-Source: APXvYqwwG8c6BZ1mAUEP3xnxs91n9I40k1hGkg86vhdLUA/NC/8FYng3NEJ8Prqbii8gRnikrhktXw==
X-Received: by 2002:a1c:7401:: with SMTP id p1mr2843267wmc.144.1571319332534; 
 Thu, 17 Oct 2019 06:35:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t13sm2573167wra.70.2019.10.17.06.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8AA251FFA3;
 Thu, 17 Oct 2019 14:16:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 17/54] translate-all: notify plugin code of tb_flush
Date: Thu, 17 Oct 2019 14:15:38 +0100
Message-Id: <20191017131615.19660-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Plugins might allocate per-TB data that then they get passed each
time a TB is executed (via the *userdata pointer).

Notify plugin code every time a code cache flush occurs, so
that plugins can then reclaim the memory of the per-TB data.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/translate-all.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 0a08fcda3e..6d1b0ecd69 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1231,6 +1231,8 @@ static gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
+    bool did_flush = false;
+
     mmap_lock();
     /* If it is already been done on request of another CPU,
      * just retry.
@@ -1238,6 +1240,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     if (tb_ctx.tb_flush_count != tb_flush_count.host_int) {
         goto done;
     }
+    did_flush = true;
 
     if (DEBUG_TB_FLUSH_GATE) {
         size_t nb_tbs = tcg_nb_tbs();
@@ -1262,6 +1265,9 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 
 done:
     mmap_unlock();
+    if (did_flush) {
+        qemu_plugin_flush_cb();
+    }
 }
 
 void tb_flush(CPUState *cpu)
-- 
2.20.1


