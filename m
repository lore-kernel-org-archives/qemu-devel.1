Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2FFC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E0322B48
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZ5H+lA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E0322B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFtr-0003iE-41
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFf7-00011c-Aq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFf6-0004Ob-2J
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:13 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFf1-0004Kz-KI
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:11 -0500
Received: by mail-pf1-x442.google.com with SMTP id 2so33576pfx.6
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pZRCwuJZhFmLfLLVDEuLYlambcalO9LoW5IlxLfh4Nc=;
 b=rZ5H+lA3kapvBSWY7KT5uGguRo2GsFoq5lA2ejPx/tPfSoNGkvSIwzkMusFKOfUli7
 /zOEltbX/tpRnmgRzeY0xiBGKcfk0tnNqE9QTgPhDsW15kK5wsZuqr065HDdeD2f7b93
 xlSPw7lI1QKHwq3pPHw1EWKcEBjyf2xi1Ox1Eg1JeqKmWdR+a+6jXeq66laN46KBWlVc
 hyWIeSGKEZfR9sNBhU09RrtMLLQOstGE0WRfxJ3d5chhiFhIGlJDt64TQ7aXRvSdfcHa
 jR9RR/cwrzonsm46F1W2xRp/eBgx2QGKyXFQVX7dmZP76e/Qny2Y2Qu/LHVyuEs5DnfH
 2rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pZRCwuJZhFmLfLLVDEuLYlambcalO9LoW5IlxLfh4Nc=;
 b=S9iqYv2UoZ5hUhl8WN7hCwu0g/xC5GStxkI9aH8cMrApidXBAXAtNMaxuQXef4GUu0
 VMJmJTUZM00+0b4C3XCjAbYMF6Qf7oMdmPSQTlvjG74Cd1u4uy8D5r9JJfchBJrsADrU
 POJY0K4atnyLTIgOGKzhLXRvmX+VQ38bgSxb/eGGkfF0g5A9xJMqJC7iJfzPGE8c4ZyJ
 H9dfOdbSE061ntt9JN0Jpk2rPhLh/fqIeeFkHN+Qh911gdqMKzs9deXL3sYEEi7GHstL
 vsCTzDghJAn8QW81Gmwcb/wcVaRuzM82NtQtchZsikj5N2EGf9oQazPHCrk0saYFFj1F
 NQrg==
X-Gm-Message-State: APjAAAUZR1fOvUQIWEeYgvu0BlVBQFFriK2itgUND5A+J1zXtbxa4r36
 6afYn0/xNI5AF7KAqTGlNNBrp/D0qRs=
X-Google-Smtp-Source: APXvYqztAsUlrWajNIKrSS/JEoXpWBk067YS3nl42NUNVTo3Mil/0ewASnN/ojOufSlIqjMfgFBYuQ==
X-Received: by 2002:a63:ed48:: with SMTP id m8mr7986303pgk.399.1576123266252; 
 Wed, 11 Dec 2019 20:01:06 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:01:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/28] target/sh4: Remove MMU_MODE{0,1}_SUFFIX
Date: Wed, 11 Dec 2019 20:00:31 -0800
Message-Id: <20191212040039.26546-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index ecaa7a18a9..452a596e67 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -254,8 +254,6 @@ void cpu_load_tlb(CPUSH4State * env);
 #define cpu_list sh4_cpu_list
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index (CPUSH4State *env, bool ifetch)
 {
-- 
2.20.1


