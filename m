Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18CDC432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D42720820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NY+RhAnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D42720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXMO-0007Ks-CS
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJX-0005Rx-BL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJW-000815-8H
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJW-00080h-2I
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:14 -0400
Received: by mail-pg1-x544.google.com with SMTP id i30so4573pgl.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5Kl11ZmsMIccTxhXV5md4kUi848D5Wwz0Vh+1GCVY20=;
 b=NY+RhAnUVegbSZ++M38hCn07AAmF9N20PcXLqREfICQIWIkg0+4VRaKv9aYF37Hb3r
 2WObegdpu5p1sNo4kso5lrgGD9LNwh4wZ8plzDixSyfOVtrzDyOM+PgWW8XscZ5VJP/B
 OM0ZbEQUS5YB0PXUvb7mK+Wes4ZjINW2dx0FSyYUYXdetHk1tx3UiizySGXXaNuSCFrl
 IhU8wR2/t/SnZCo2f3fE0H9hJG8NZ7Q5CfNsK2wRVzFpU6qNyr4oFXaHmS9I5S2s5zlH
 vFY4M25VX22Ruyk1yBmumklzcRqK8ttJ5wzNp96HNsUejCgW87dwq7p0iQeKDok2WSck
 2kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5Kl11ZmsMIccTxhXV5md4kUi848D5Wwz0Vh+1GCVY20=;
 b=lXHxtJ0IVX0mnz0K0M/KV+WwOUXGSDxRKRtcVYATGQUD1DO4IAICYGgLNjZegxwh/+
 aZ8oXUhJ/8Lul1Ntk3kju6P3jLdmeOGEEbRtgXaB3lUKGZxmQRn7wKJ6YefxlH8MK/Wn
 RKLIs1x0GvETMaO4NU7Z+WbMcLjbR32yUaKmcyABgspOPtgJK+u4eXav/qbbmULxA83t
 y44e1FExqO337gPElbgWeSNkmbkiHOWVld+SLv6j+N7tZH+NC72reo9uaD6etXRRC7H7
 v4/MYwBShh9kLvNNJBOpjoTUqdeBp8de8so7EU+K04JEJC9j7RHxt3E+x9PWbIGyM8uN
 ZwPw==
X-Gm-Message-State: APjAAAVbQGsAPua8e7s4Ydt8L+rOF5EO8R8htAu3RUKq8BNBp9HkAtSy
 1D3luY2WPgq0ws0sm+v+K+SyXmew5zs=
X-Google-Smtp-Source: APXvYqy/XAM4d9FSDJViOlGxGyqDasp5Oio62vJR5qwzIKyxFs3orjrNfzCaC4r8ly1Le1zTVccHFQ==
X-Received: by 2002:a63:505:: with SMTP id 5mr2189265pgf.297.1569279612724;
 Mon, 23 Sep 2019 16:00:12 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/16] qemu/compiler.h: Add optimize_away
Date: Mon, 23 Sep 2019 15:59:51 -0700
Message-Id: <20190923230004.9231-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923230004.9231-1-richard.henderson@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use this as a compile-time assert that a particular
code path is not reachable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 20780e722d..6604ccea92 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -221,4 +221,19 @@
 #define QEMU_GENERIC9(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC8(x, __VA_ARGS__))
 #define QEMU_GENERIC10(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC9(x, __VA_ARGS__))
 
+/**
+ * optimize_away()
+ *
+ * The compiler, during optimization, is expected to prove that a call
+ * to this function cannot be reached and remove it.  If the compiler
+ * supports QEMU_ERROR, this will be reported at compile time; otherwise
+ * this will be reported at link time, due to the missing symbol.
+ */
+#ifdef __OPTIMIZE__
+extern void QEMU_NORETURN QEMU_ERROR("code path is reachable")
+    optimize_away(void);
+#else
+#define optimize_away()  g_assert_not_reached()
+#endif
+
 #endif /* COMPILER_H */
-- 
2.17.1


