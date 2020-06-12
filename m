Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DA3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C119820792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HIeWdS5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C119820792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjp3N-0003BM-1f
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjp2M-0001rk-2C
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:08:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43566)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjp2K-0007ar-04
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:08:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so10819431wrr.10
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pOTNVC0J3mJ6YGdmpXPCtwPf6rnAZM/12o6pgw/fmt0=;
 b=HIeWdS5NVdv+L1Z4u3dquqHJUxFGe0J8Dh2e8RJec6ngzTPqhlFa98nZDgpt4gjIkz
 Zu6ePg4OdKWN2rFNJcWotJ8y8v13bqilhoz1o1YIQvPfTG02MvvwPLxJetenVKlHMWDe
 +Ab08U3FEDN8tSFEySsXqZn0ARvQnYsNm1wX8/UrrFccqcGrjVUV6S2vqZ7uDirzYaf6
 qHk7TRj78abemoYuVv6c0U19NILudt9REeB3YHGRGjYPNCJsZkBsfRqdcW4TDabX/4fx
 6QtPrFyHTtgUWHtUx4QePgKMrVWcqExOWt56oRhtT35G8Nn+M62oehbpn0XTVJJXXY2g
 2uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pOTNVC0J3mJ6YGdmpXPCtwPf6rnAZM/12o6pgw/fmt0=;
 b=UGjwQLDc8eJnRshFFEcBqVXC58LTHfAieX+uRKMhcpdNN05vgtym1+q6zWjLigome7
 sye2EIijiLj1Hp81dPsbrelKbgjlDax1tO5qCP1z25xFsOXq7x+7APTXzA5iX7eKxzTQ
 l8ARuPrNnzmCyuDZCYHnxAyPaVqWwuCgD9s9aBkrpoQgjricM/x7ccUrxbRomIdCCqm4
 XlYeA3LLLiduK7c7BxaOUF4KftplqNZv034LX/7YGt87Fclb/mZoO9kDZ14JoU+/R6l/
 vKrz3D3NHxgiOvItTnHiLjXkfruTDFgkNhheSkvmEaQ2cGNB8kUodfX4MMHvIIneUJgm
 VQnQ==
X-Gm-Message-State: AOAM5302Yb2bpbe6+ZA8Et3EYibcsV3LvALFcd49/7b2oUYMhZ5DynXp
 0aA/EJl7ahSKSfdT1TdG+d0jew==
X-Google-Smtp-Source: ABdhPJzrfm1v1HeA7iW5y8bdM/qd9XhJ+XaSPpmfOOm4KwmzETxjNGTyuIelAW/m9/5oDhogHeTXhQ==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr15690114wrp.136.1591988892483; 
 Fri, 12 Jun 2020 12:08:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm10293830wmd.28.2020.06.12.12.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:08:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 396C31FF9B;
 Fri, 12 Jun 2020 20:02:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 13/18] include/qemu: Added tsan.h for annotations.
Date: Fri, 12 Jun 2020 20:02:32 +0100
Message-Id: <20200612190237.30436-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612190237.30436-1-alex.bennee@linaro.org>
References: <20200612190237.30436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

These annotations will allow us to give tsan
additional hints.  For example, we can inform
tsan about reads/writes to ignore to silence certain
classes of warnings.
We can also annotate threads so that the proper thread
naming shows up in tsan warning results.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200609200738.445-11-robert.foley@linaro.org>
---
 include/qemu/tsan.h | 71 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 include/qemu/tsan.h

diff --git a/include/qemu/tsan.h b/include/qemu/tsan.h
new file mode 100644
index 00000000000..09cc665f91d
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
2.20.1


