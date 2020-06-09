Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC4FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A8620734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lnj7Pdp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A8620734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikiG-0002Fn-VG
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZI-0007nK-SJ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:56 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:52595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZH-0005by-Qu
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:56 -0400
Received: by mail-pj1-x1042.google.com with SMTP id k2so1863108pjs.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z+OFj29yCFbAWNlzpwiIPBHhzK7hPpPDuoaMSZsMcbg=;
 b=Lnj7Pdp+K51xUfHhblxF7XbUs3dLR9opXx9M+AWdHgBl9VVh+aeAPAmBRamIwP6iyU
 /uqt2K1+opgxJQemvVrnMER/Hv368Znh7CSMuNMAE6S7ekPpzwpxew1+SiCf/pX/m/rg
 K3Qmd+PziI0Eg82RxvuAZYJM92nTH5WDm206RXdpeWHte/y4kMPpQak+scI7j1H04Fmj
 E017CRiRslEP6kbefibu2oSx+4tAuvqnAQYQO/YzTuP97SH6wAC7N5nI44X3J5aVrrGl
 I06mTsqDypbS6gIqUI+KTHRYpnbzbveET5Y84cLl1vDZ0pk+jHeo2LburtNAy2bVQW7J
 CCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z+OFj29yCFbAWNlzpwiIPBHhzK7hPpPDuoaMSZsMcbg=;
 b=WA0I6Ci9R78GrFvTAk2p1xQvOHUtFTGZDousAxIGoe0dgqKKxnCZ6XLZRWCHs0PRJM
 BU6SXhaXM6BHWK4KO+j/soIBwDj2RIUHUVESvpipbn1HJhNwEKAp0zRVYW3vOrskJHEk
 RiCbKXc07ELRJc+FIyjxWlaAFBxgJH5BpboXXXiHBnYfrjKtuK33lBniZdanDelHAle9
 IE4UATUFqz9VjlLZc9VSTxuTeGKEckfjdf0QkkPcY5tDUz90E0mV7AgOzzzs4QZGyfZL
 ECKQ7jxILrooZ47iJhsENoWuE/Lr+APZSm1YEObg8IxOENL7f4b6muuAK8WWNyVjJkoV
 12Xw==
X-Gm-Message-State: AOAM531psS6XHtPIpe8wDoa5wuQFB6pJ+dZJhpk97mstUVhjy9m9ggcX
 7OyiXlhvz957AdInmgXY3EgbaFV2K+iJug==
X-Google-Smtp-Source: ABdhPJyU20Hk8Mos/BIxOTs1ANFg7ICxXFNhwqU8eMRkywfayDgvzFrSrQL5E0SB425Bm4+IskwLOw==
X-Received: by 2002:a17:902:bc84:: with SMTP id bb4mr71130plb.55.1591733394129; 
 Tue, 09 Jun 2020 13:09:54 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1d09:cef2:3b1f:abce])
 by smtp.gmail.com with ESMTPSA id n19sm10523374pfu.194.2020.06.09.13.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:09:53 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/13] include/qemu: Added tsan.h for annotations.
Date: Tue,  9 Jun 2020 16:07:35 -0400
Message-Id: <20200609200738.445-11-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609200738.445-1-robert.foley@linaro.org>
References: <20200609200738.445-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1042.google.com
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
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/tsan.h | 71 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 include/qemu/tsan.h

diff --git a/include/qemu/tsan.h b/include/qemu/tsan.h
new file mode 100644
index 0000000000..09cc665f91
--- /dev/null
+++ b/include/qemu/tsan.h
@@ -0,0 +1,71 @@
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
+ * Annotation examples can be found here:
+ *  https://github.com/llvm/llvm-project/tree/master/compiler-rt/test/tsan
+ * annotate_happens_before.cpp or ignore_race.cpp are good places to start.
+ *
+ * The full set of annotations can be found here in tsan_interface_ann.cpp.
+ *  https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifdef CONFIG_TSAN
+/*
+ * Informs TSan of a happens before/after relationship.
+ */
+#define QEMU_TSAN_ANNOTATE_HAPPENS_BEFORE(addr) \
+    AnnotateHappensBefore(__FILE__, __LINE__, (void *)(addr))
+#define QEMU_TSAN_ANNOTATE_HAPPENS_AFTER(addr) \
+    AnnotateHappensAfter(__FILE__, __LINE__, (void *)(addr))
+/*
+ * Gives TSan more information about thread names it can report the
+ * name of the thread in the warning report.
+ */
+#define QEMU_TSAN_ANNOTATE_THREAD_NAME(name) \
+    AnnotateThreadName(__FILE__, __LINE__, (void *)(name))
+/*
+ * Allows defining a region of code on which TSan will not record memory READS.
+ * This has the effect of disabling race detection for this section of code.
+ */
+#define QEMU_TSAN_ANNOTATE_IGNORE_READS_BEGIN() \
+    AnnotateIgnoreReadsBegin(__FILE__, __LINE__)
+#define QEMU_TSAN_ANNOTATE_IGNORE_READS_END() \
+    AnnotateIgnoreReadsEnd(__FILE__, __LINE__)
+/*
+ * Allows defining a region of code on which TSan will not record memory
+ * WRITES.  This has the effect of disabling race detection for this
+ * section of code.
+ */
+#define QEMU_TSAN_ANNOTATE_IGNORE_WRITES_BEGIN() \
+    AnnotateIgnoreWritesBegin(__FILE__, __LINE__)
+#define QEMU_TSAN_ANNOTATE_IGNORE_WRITES_END() \
+    AnnotateIgnoreWritesEnd(__FILE__, __LINE__)
+#else
+#define QEMU_TSAN_ANNOTATE_HAPPENS_BEFORE(addr)
+#define QEMU_TSAN_ANNOTATE_HAPPENS_AFTER(addr)
+#define QEMU_TSAN_ANNOTATE_THREAD_NAME(name)
+#define QEMU_TSAN_ANNOTATE_IGNORE_READS_BEGIN()
+#define QEMU_TSAN_ANNOTATE_IGNORE_READS_END()
+#define QEMU_TSAN_ANNOTATE_IGNORE_WRITES_BEGIN()
+#define QEMU_TSAN_ANNOTATE_IGNORE_WRITES_END()
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


