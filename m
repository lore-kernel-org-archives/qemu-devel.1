Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98694C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661332070A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIQSD87L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661332070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfuB-0000kV-Ij
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEn-0004VF-1D
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:50 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:44478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEj-0000Nh-PI
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:48 -0400
Received: by mail-qk1-x741.google.com with SMTP id b4so3459387qkn.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b2xeW1FaDB2PR1E4Ymub3nePuzIlXe65/BuJe3DDIkY=;
 b=ZIQSD87LAmmPZtdpcbAKBzJo9w6PtLrbHTREwy1cFiP4Qsx+hehp85X/ycyuslgWDN
 6rXGwKkZwl96xGeM2jx9HRl25o1ItzEHTgPMrq+JnMmNQWOs0yeQPZrt8P9+z7u80CkK
 mkwDC7P3yXeHXv1ESDwb9EWZT2y87P7DnKqdZxgXBSWLlt7+rfWZQAwjPdVuZPhHXSlt
 BbzmtXBQja8eyG2BEDC+087dOrYgvtJBEHe8ulbwlJrF7LP0tuAcZxsLUYzDq1S1mmmI
 UjYmNXQl6blnmJ+iNcr2vylLs9jqFnyFk34JY/tweuw92dMLTWKZhIxZ9tiUOn5/AGhC
 TZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b2xeW1FaDB2PR1E4Ymub3nePuzIlXe65/BuJe3DDIkY=;
 b=DQnvI6o3r0mYkT4XBvaWAn5Qg2jqhYc94fEBxaXg57+3Wwhp2bD62mJ3XChIkDj1Ok
 reNzxZO9s4FVlC5oEi5Tp9dBLq8Shk1cre+BRWsCzZGY+/JOIyaGGLIq5RtN1qS5Mh6N
 9heEzax1XeI8gntOxCLTw5G8TLm9GqZidXx+94QSoELb1t5RSsEzcjqlb0pfwL7/mFN0
 sBrmVAjZb23YX5Xzc/fWASL7MLypDu0fW4reZldDLaTcK/FmbCOa0GXr/W1HlxZvjy+m
 KrdwJx1A887EuHn8J5Gmuufln1kxAnDM/zOu3WSBBXDmtDWjwvSB+GogjGzIBY1W+7Ky
 kvwQ==
X-Gm-Message-State: AOAM532S8Te4LUFJb/mOhy23S6lMQFBNdnykpLRylAUNRwk8iU1eUm2+
 Mm0gf/5BdhXkT6h7J8pj4r89zAq96/yYkw==
X-Google-Smtp-Source: ABdhPJwPMylsKqsiMX109wPlTPAq5KFJ/glBKr/TjnDtjv7j4/necsC/sEBUqST7SyIhtKxQn10CEw==
X-Received: by 2002:a37:9ad5:: with SMTP id c204mr550641qke.413.1592427883491; 
 Wed, 17 Jun 2020 14:04:43 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:43 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 61/73] cpu: call .cpu_has_work with the CPU lock held
Date: Wed, 17 Jun 2020 17:02:19 -0400
Message-Id: <20200617210231.4393-62-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x741.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: robert.foley@linaro.org, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/hw/core/cpu.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6f2c005171..79da78cd10 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -80,7 +80,8 @@ struct TranslationBlock;
  * instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @has_work: Callback for checking if there is work to do.
+ * @has_work: Callback for checking if there is work to do. Called with the
+ * CPU lock held.
  * @do_interrupt: Callback for interrupt handling.
  * @do_unaligned_access: Callback for unaligned access handling, if
  * the target defines #TARGET_ALIGNED_ONLY.
@@ -804,9 +805,16 @@ const char *parse_cpu_option(const char *cpu_option);
 static inline bool cpu_has_work(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    bool ret;
 
     g_assert(cc->has_work);
-    return cc->has_work(cpu);
+    if (cpu_mutex_locked(cpu)) {
+        return cc->has_work(cpu);
+    }
+    cpu_mutex_lock(cpu);
+    ret = cc->has_work(cpu);
+    cpu_mutex_unlock(cpu);
+    return ret;
 }
 
 /**
-- 
2.17.1


