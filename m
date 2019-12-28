Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB0BC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67B620838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K18rOLca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67B620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLXo-0003qp-Rd
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLGD-0005iD-MU
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLGC-0000cE-KZ
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:41 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLGC-0000WN-DA
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:40 -0500
Received: by mail-pg1-x541.google.com with SMTP id r11so16286588pgf.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8KeHM8r9FEkQ6hmUzWzLeevN843jeEXpnBlHeCgI2Kw=;
 b=K18rOLcaFMcmeiexDbtG44mhMsxyg2gDLESkb8lMKrNwWhjoLx42kZPq8pXdzmtsqC
 kaH/TEQ7nLYmFq0vfM3LWx81/zrqjTm8fIE5nBRbpbVWgXJa443QP8wWQJAmhQVb80ZS
 AX+Mm7yxRdpO9Gvge66uke+oFV3t+5cyXGh0G1DByVC4uKwTyGzfrDlvZOf260Xyr1fs
 cU7D8i87rp7PbpR2DVx4WTN33gsFV4/0ZyrdblOjYseNvpTSmWIjFxN3koQ4ShSQQ+uZ
 UgdGq3PRlM96X+Iacn9dQNgODIPWiW2kK/r1WNWEC8WDdLqZTVNH0jXcmFVVajVUu5Zk
 zQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8KeHM8r9FEkQ6hmUzWzLeevN843jeEXpnBlHeCgI2Kw=;
 b=qZzgB+IdpEdMhgkIKP+D2v1ra03AVPM4IOAzzRcpO4YayOW5loE7+b8MtLb7wCJtF5
 Ru0ZKdrJOs+ERPGnVcgWOW5VmuqbSiZEI+h3AAtOJ1rdOGANxD5oMMhf8GyIS1iPZ7rX
 /+OtFF0KA7yDtecBMy5sQ8tptJjtmZCmoRXn9lFohMoip0TyQWEKYUfZ1OwYXlbv79n2
 gN1QILedmVhJfGDswa2HNHaLUsc2tC3UyhoDnLCN02DYY5sGhLjlQGw9cfk0v0aRa/03
 ccL4Pbn7JB4LgBbxbTZyEQbNOGkqeIb+P96c/TEjCQ2k7NaHdtuTP1uHCN0l0MlsTUv5
 1KZQ==
X-Gm-Message-State: APjAAAXGr3lUU+N+8mwc2NAiUQ2OCxb54r54IH/p4erdC69xfX58+dWZ
 UMzBOmnFdmVOcbi13JeI6IL/ck3hARQ=
X-Google-Smtp-Source: APXvYqy3v3jHmCrNcTqrzwBW7/J3+fRy+E5RKZjgS4MPVlG3KCgJQIRAB5riyF2Zlfm39yU4YBEi4g==
X-Received: by 2002:a63:5657:: with SMTP id g23mr61718623pgm.452.1577574759032; 
 Sat, 28 Dec 2019 15:12:39 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 23/29] target/xtensa: Remove MMU_MODE{0,1,2,3}_SUFFIX
Date: Sun, 29 Dec 2019 10:11:18 +1100
Message-Id: <20191228231124.18307-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index b363ffcf10..f5a7ea48bb 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -685,10 +685,6 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 }
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _ring0
-#define MMU_MODE1_SUFFIX _ring1
-#define MMU_MODE2_SUFFIX _ring2
-#define MMU_MODE3_SUFFIX _ring3
 #define MMU_USER_IDX 3
 
 static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
-- 
2.20.1


