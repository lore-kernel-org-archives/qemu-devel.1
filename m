Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB927C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1C120663
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G9CmtFg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1C120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAOt-00030k-R6
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKU-00038u-Bc
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:26 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKP-0006Db-FR
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:26 -0400
Received: by mail-pl1-x643.google.com with SMTP id x11so3579198plv.9
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tLifGO+pAQPZlQcKX63d2L4JgerTfPuetScyiOswaLc=;
 b=G9CmtFg1o2wGg+WHrpNPN1h6vLku/VJXlgQXhVPVPeIZzFRRdCpt32OyljhRliJ13t
 Yvjz29IFUXrEqyV+WhUGjCSjtawU9ME7WYcmX04OAk4WZjVbcPcSOzo8z41kMqViYmMP
 OCpi3RWP9L1UJ27YY+1cK0qoUA4xOxafLlq3WPpn7DeLqafqRrb8BCVSKsm1OAndeUhW
 SzvZJw6Bx6cSzhyDQ24Li1xD4Zr/evm/jdZ+uQeqlHgNfznPV3r5A9utR8eJLZlHEsd8
 Uu7/qfW/AuxNU8TGWOpSxae29uHFQrt5SDCSkjwEPnDfAwkbpXYj65ZaQndDGLANp2D3
 urLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tLifGO+pAQPZlQcKX63d2L4JgerTfPuetScyiOswaLc=;
 b=MIgB2R1Rb4dIWhe4R4a/9jwaEw2yjq+AKhTkj5zUQEQExHxSNbiX6GWixZzLKPxG5A
 U9SIxW5o+IQtZweSTxuPxw4lhb67fdd8Kl2ww3FGNG6IiRnAFbaiB5ved/cDwdb8magh
 PTI651AEAMl32cgBY2q4YXEfJ7bdb9uWoJy3/siFBRfBAH7M1wCHhBavYJyJ6BoXDnse
 ZfRY3ovPc6ZD9zr3bQ66jDM+Gdl4JKs6lWfHaLQzzvF0MCCKKUxtE4jOmTmRBO6d2NmA
 pTUYD23XFLHmODLkgLFVZdFgNXpayH6yTSYsQNA0SFYygQH5xmrxXr0dd1GLBWXUuf2k
 +vgA==
X-Gm-Message-State: AOAM5336LRCuliQX+Up/AIkagtGuMTfwNkwMjQxFDzKasTkWGStsR3tl
 IAX2AU3aUM7qs8/D7+IRA9l+TXTjsguHZw==
X-Google-Smtp-Source: ABdhPJyINZ8xwkbbrhL0MVgp6irRJJYrglItnVBoOEKIQpou1F76x3dXbN7h8F7Ij9yj/V4DMESaCw==
X-Received: by 2002:a17:90a:8a0f:: with SMTP id
 w15mr4908406pjn.27.1590164118719; 
 Fri, 22 May 2020 09:15:18 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:18 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/19] include/qemu: Added tsan.h for annotations.
Date: Fri, 22 May 2020 12:07:46 -0400
Message-Id: <20200522160755.886-11-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These annotations will allow us to give tsan
additional hints.  For example, we can inform
tsan about reads/writes to ignore to silence certain
classes of warnings.
We can also annotate threads so that the proper thread
naming shows up in tsan warning results.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/qemu/tsan.h | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 include/qemu/tsan.h

diff --git a/include/qemu/tsan.h b/include/qemu/tsan.h
new file mode 100644
index 0000000000..8b7d0acf3e
--- /dev/null
+++ b/include/qemu/tsan.h
@@ -0,0 +1,48 @@
+#ifndef QEMU_TSAN_H
+#define QEMU_TSAN_H
+/*
+ * tsan.h
+ *
+ * This file defines macros used to give ThreadSanitizer
+ * additional information to help suppress warnings.
+ * This is necessary since TSan does not provide a header file
+ * for these annotations.  The standard way to include these
+ * is via the below macros.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifdef CONFIG_TSAN
+#define TSAN_ANNOTATE_HAPPENS_BEFORE(addr) \
+    AnnotateHappensBefore(__FILE__, __LINE__, (void *)(addr))
+#define TSAN_ANNOTATE_HAPPENS_AFTER(addr) \
+    AnnotateHappensAfter(__FILE__, __LINE__, (void *)(addr))
+#define TSAN_ANNOTATE_THREAD_NAME(name) \
+    AnnotateThreadName(__FILE__, __LINE__, (void *)(name))
+#define TSAN_ANNOTATE_IGNORE_READS_BEGIN() \
+    AnnotateIgnoreReadsBegin(__FILE__, __LINE__)
+#define TSAN_ANNOTATE_IGNORE_READS_END() \
+    AnnotateIgnoreReadsEnd(__FILE__, __LINE__)
+#define TSAN_ANNOTATE_IGNORE_WRITES_BEGIN() \
+    AnnotateIgnoreWritesBegin(__FILE__, __LINE__)
+#define TSAN_ANNOTATE_IGNORE_WRITES_END() \
+    AnnotateIgnoreWritesEnd(__FILE__, __LINE__)
+#else
+#define TSAN_ANNOTATE_HAPPENS_BEFORE(addr)
+#define TSAN_ANNOTATE_HAPPENS_AFTER(addr)
+#define TSAN_ANNOTATE_THREAD_NAME(name)
+#define TSAN_ANNOTATE_IGNORE_READS_BEGIN()
+#define TSAN_ANNOTATE_IGNORE_READS_END()
+#define TSAN_ANNOTATE_IGNORE_WRITES_BEGIN()
+#define TSAN_ANNOTATE_IGNORE_WRITES_END()
+#endif
+
+void AnnotateHappensBefore(const char *f, int l, void *addr);
+void AnnotateHappensAfter(const char *f, int l, void *addr);
+void AnnotateThreadName(const char *f, int l, char *name);
+void AnnotateIgnoreReadsBegin(const char *f, int l);
+void AnnotateIgnoreReadsEnd(const char *f, int l);
+void AnnotateIgnoreWritesBegin(const char *f, int l);
+void AnnotateIgnoreWritesEnd(const char *f, int l);
+#endif
-- 
2.17.1


