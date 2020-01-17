Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF1BC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C05A2072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uS/2mREI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C05A2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isXJT-0005g1-DA
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 14:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40082)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <30woiXgMKCmgPQfMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--jkz.bounces.google.com>)
 id 1isXI6-0004QO-Rb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <30woiXgMKCmgPQfMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--jkz.bounces.google.com>)
 id 1isXI5-0003xw-Jd
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:22 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649]:41703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <30woiXgMKCmgPQfMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--jkz.bounces.google.com>)
 id 1isXI5-0003wV-Ea
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:21 -0500
Received: by mail-pl1-x649.google.com with SMTP id p6so624079pls.8
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 11:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=hijhxrQMtQ0keTaHnJ/kYAmvv9buqL/qn4fGTZDsadU=;
 b=uS/2mREI86NxVD6/QP5O/imRqqTh1uw85eJ8OcYBLT+ai+/iXti9Aq1zQWhae0xQ99
 KpWx5m7FnQ8Dmorply2yGt0uJcK85FBjVBkbZZO2y/zJBbBp1qwnx0DYhGvr2p80jxRS
 Tzi/bOU+sZmoEa2IxsSurAZyCSBGWAtV/5Wx7Qx751hfF0csh09vYMx8MSCP27BS8jNx
 O6Ml2KUMF/10C5VxDG3fkfQrCMHrwfh/Yxpkn5f1UhNwqPGCTuhFxXI2equJju5Xnmj9
 roCEBGDZ/NDuf7Nik12ddBmPTz1RPUzjFHzb6sZ6CSTn9PRM5yYuRTRTsTcNJ/QMZfqy
 UQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=hijhxrQMtQ0keTaHnJ/kYAmvv9buqL/qn4fGTZDsadU=;
 b=i4tRP4B5udxBzIXxuai4O83OliL/pJ7xsg8/iSPAaozacJSLHRUKg57P9zdEPwJcMd
 nLY7JGVEld/cVloHvTgR8W12bEdU3bHRHtrncdUtwIq6xECOPW59y8GrLHqpQg06qamW
 FKZWRneQgcKyROTlv9MMjKQP289krsaAXceiwcnIPhoZPAIBAQqsEG8yG5rUmTAiKKMl
 5cTzIdJjHgDCRqNfyZ5zshW7H5LdMB1zqR/kH3SJ4tD+5gXDo88dnBhjF5Cc9q2zjSCw
 zbrOToY59E6Lln6tyQaQcLQRZL4PdgrMZF+AYeWoSBFaxRnlOzbWwiOcurc2AVF65XIa
 FrRA==
X-Gm-Message-State: APjAAAVjtcY/o1HXvXOzHzTm7TDvcafEcW//QA7XtGVjAfP/q0kmsag2
 D8MvC6U9DNUtCG+P+I3fbyOyFniFwWIb3FoC0/Cq8/NZMAX1saza/j2gmzBM6f/de3DlNLyiz1W
 XQzt3FZQFbzeKOe8e8FOZVR3PYZ+HxDpndna7G/EsDUk7x/2JHRvg
X-Google-Smtp-Source: APXvYqwz/2MzZl7I4142uyEknwHFd8iimkEp1f9b+iqNp2ArkRq8FrLfcexiTW8koNuWzzIzrakticc=
X-Received: by 2002:a63:cf41:: with SMTP id b1mr46565654pgj.53.1579289299984; 
 Fri, 17 Jan 2020 11:28:19 -0800 (PST)
Date: Fri, 17 Jan 2020 11:28:07 -0800
In-Reply-To: <20200117192808.129398-1-jkz@google.com>
Message-Id: <20200117192808.129398-4-jkz@google.com>
Mime-Version: 1.0
References: <20200117192808.129398-1-jkz@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 3/4] linux-user: remove gemu_log from the linux-user tree
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 armbru@redhat.com, imp@bsdimp.com, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::649
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that all uses have been migrated to `qemu_log' it is no longer
needed.

Signed-off-by: Josh Kunz <jkz@google.com>
---
 linux-user/main.c | 9 ---------
 linux-user/qemu.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 8f1d07cdd6..22578b1633 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -112,15 +112,6 @@ const char *qemu_uname_release;
    by remapping the process stack directly at the right place */
 unsigned long guest_stack_size = 8 * 1024 * 1024UL;
 
-void gemu_log(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    vfprintf(stderr, fmt, ap);
-    va_end(ap);
-}
-
 #if defined(TARGET_I386)
 int cpu_get_pic_interrupt(CPUX86State *env)
 {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 02c6890c8a..329b409e65 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -210,7 +210,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8);
-void gemu_log(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 extern __thread CPUState *thread_cpu;
 void cpu_loop(CPUArchState *env);
 const char *target_strerror(int err);
-- 
2.25.0.341.g760bfbb309-goog


