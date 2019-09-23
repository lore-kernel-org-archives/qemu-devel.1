Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8983EC432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B58D20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jiklDqjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B58D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXMH-0007Gt-7K
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJT-0005Q7-UV
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJS-0007w1-NA
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:11 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJS-0007ur-HM
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:10 -0400
Received: by mail-pg1-x543.google.com with SMTP id i30so4421pgl.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=q+p5QzYNQKTvFHxw7w5r06HbHDvLV91pgGFYaSNj9io=;
 b=jiklDqjNjvOwyGkMWVnwjr0pGn76PejnXREOb3AMWwgrRNKqBmAn7hv08hKIfiRDb5
 Cv7Pt24gCTv5gcQ2yt3ao5qQkLTHhY5QXniNV4lHBp6uG3hMze+AW2A6YXHrcNxckN2n
 a8vScAzUUA/AMuDrfLBQ8ndris44KrlyMUYeTIWNDZUVQYv6cQd/UytSTc6oCciSFi5p
 t6obh3ET2aarXXiuPR8Fkl/O5NvwhNdoC1a5wWxPt63M9KdNc5AeblBYhdgFIl+gT8ua
 z8PQHBvb1U5SDE1voTqS7W1R08sbd5Gtbhmhq/dvToQTYLVbYbw4+ziYICCIDf3Q+Avx
 jTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=q+p5QzYNQKTvFHxw7w5r06HbHDvLV91pgGFYaSNj9io=;
 b=a3zAUtKieWuXoFQpLS/yjjNE2ioyEmMb4EdubbY+fQneaqV5uQAkOVPOB8Zs1EHt1Q
 xI4p9J8uHrlvUNNZgGWVAPz98PwZehc0mo7ijbL+92bpKWmz1b5tbOVIRncY+FoHHUco
 AZOInchoZfnXedZccedMa012/bbGaI536mbKWv9fIpSkjVPT3bJRE0fj9TdDeQg/uRyp
 LCJV9FdHhG0mYJYzZE7skuJjsB9f5N4qQudN/wGeV4IsFyYQkR3KsUOaWTckaw/gFeqF
 hg0T0JKbXq8N5bicJ9xZAAtB9BRI02DQhlZsBvtBydMGq6s19VeEwNwg1/GTKQ9qyg7E
 +t4g==
X-Gm-Message-State: APjAAAU4158HjnynyR9d/OgEUgNAvGN/7by4yL4FXUfrV04TAmDzptTJ
 A3xxnXZhYZrKwur/qlKp2Adt2Zmq8e0=
X-Google-Smtp-Source: APXvYqykLkY3bcaZm1A19kFNcVQ5tt7s0kOkMAB8dENyPtQGTsF5oBVyfPch8kVdAQ+Q3NKBBhGWqg==
X-Received: by 2002:a63:e1a:: with SMTP id d26mr153193pgl.73.1569279609108;
 Mon, 23 Sep 2019 16:00:09 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/16] exec: Use TARGET_PAGE_BITS_MIN for TLB flags
Date: Mon, 23 Sep 2019 15:59:49 -0700
Message-Id: <20190923230004.9231-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923230004.9231-1-richard.henderson@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

These bits do not need to vary with the actual page size
used by the guest.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d2d443c4f9..e0c8dc540c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -317,20 +317,24 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 #if !defined(CONFIG_USER_ONLY)
 
-/* Flags stored in the low bits of the TLB virtual address.  These are
- * defined so that fast path ram access is all zeros.
+/*
+ * Flags stored in the low bits of the TLB virtual address.
+ * These are defined so that fast path ram access is all zeros.
  * The flags all must be between TARGET_PAGE_BITS and
  * maximum address alignment bit.
+ *
+ * Use TARGET_PAGE_BITS_MIN so that these bits are constant
+ * when TARGET_PAGE_BITS_VARY is in effect.
  */
 /* Zero if TLB entry is valid.  */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS - 1))
+#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
 /* Set if TLB entry references a clean RAM page.  The iotlb entry will
    contain the page physical address.  */
-#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS - 2))
+#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
 /* Set if TLB entry is an IO callback.  */
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
+#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
 /* Set if TLB entry contains a watchpoint.  */
-#define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS - 4))
+#define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS_MIN - 4))
 
 /* Use this mask to check interception with an alignment mask
  * in a TCG backend.
-- 
2.17.1


