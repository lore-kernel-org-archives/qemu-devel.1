Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858D9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F4020723
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiceRRG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F4020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jef6N-0008FN-FW
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezO-0004tN-0r
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:58 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezM-0003he-VZ
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:57 -0400
Received: by mail-pl1-x644.google.com with SMTP id bg4so1164660plb.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AOzUAJyFNQB4L+phqsSsfzj9Z8OtZxOrajLi9NoXesk=;
 b=xiceRRG+/TTDb0OXC244QM/ffSZIlCmPHW6oo5g7ITnFGVML6PJp1sWMy9VZpiC5zP
 UQDKOK/z9g6uFlzNmETiAA6Pl+OtMMtHoJHayDGMwgquXZAkuHqltVnPglKItiJ3Bl/G
 YMDdLs6xAot9CtGYtcJy34U9X2dkQDkJAM+QPs9/S/ElSksPV+F0WnGmIRfwUnZXHCxB
 n82hzUuFs0DUe/9a9rqRfWSItQ+xL1CQ9Uqm9r/J0u1WxtuCiGznSzlfl7kEUtlCapdk
 MFQKKiLplVS+zfIl/B12L5XMzsPhsxKoEHl2v48o9dYv+ULOkPDC5mTlV6B65uIr290v
 Gphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AOzUAJyFNQB4L+phqsSsfzj9Z8OtZxOrajLi9NoXesk=;
 b=bqG7rHc+ncsBtHhwIAthTE2phr0OuayOfP9IoMimmRXdhpAy/ifcjbDTzU7dVcctap
 aqGFvrRkjRpSWwbJXpgnpS7l57kkp8wtpR/Zm4WkVYTOlp8AlSj5VdQm/3EjkAEsMsq/
 tzPN99g6XL6XSOKgj4VyN/wvsalQ5O6uu95oXrquPC38mDntd1t3nuwf6OUaD4gwEiTe
 OV/n+SAklLC3W4VO6xW84AIahmYBqLYOzzU1MlaI6aSCyd8WuiFQ4oQWS2T55RyBP3v6
 OOKvsisjvD/1twM7a55rw6M2OD3PrcBSQ3MEPyw9XYcuQykGh1dS/m9oG90xwfdNsL15
 73iQ==
X-Gm-Message-State: AOAM5327CeWQFpCPR3h295DWKSMs2EiAsoVyHgwtAUud4rEAkTCuxAnc
 df4nruFiqL51BnEy3Tenfbn3F/pialxXmg==
X-Google-Smtp-Source: ABdhPJxLGd/aqRKTgiPPs7yCS8oFgU0orocOOG6wSoIeb8NLWF7EMSUTHzBvTYOP1tHjR3T2XbT33g==
X-Received: by 2002:a17:90a:6f26:: with SMTP id
 d35mr9414092pjk.210.1590758634877; 
 Fri, 29 May 2020 06:23:54 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id e13sm1998686pfd.10.2020.05.29.06.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 06:23:54 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/12] include/qemu: Added tsan.h for annotations.
Date: Fri, 29 May 2020 09:23:40 -0400
Message-Id: <20200529132341.755-10-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529132341.755-1-robert.foley@linaro.org>
References: <20200529132341.755-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x644.google.com
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


