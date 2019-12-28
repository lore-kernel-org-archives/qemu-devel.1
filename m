Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3395BC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB1020838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1ZCVm39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB1020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLW0-0001CY-P8
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLG7-0005ac-LY
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLG6-00006W-Iw
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:35 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:50337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLG6-0008Uf-AQ
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:34 -0500
Received: by mail-pj1-x1043.google.com with SMTP id r67so6313399pjb.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YdXEJZRP1IFp2O0duDOqWUbcJqfKg7Q1OugwBf6nt/k=;
 b=t1ZCVm39F1TsyYG8sRXZ3aeX+iyx5BTRE8oGn9RC7rtEl7XNvT+K+V5zM5I9XQprKU
 RL7okSD9wZO83LP0LATHuxkSoKScSQOJ8J+BpdobG0stNrHMAt3EmQJCax/QBJoks6+T
 GJNgXaKBJ0w8E/JJbUj9xz5wtb44Q9rZQvLMMOdy7Jk+8g7srsYDwPVB7xm4BdbWxX0T
 moqlt4FztbAjdpjHBuC6j8MeoxbeGP0rJp9XHH+NyTngMK5/P4ZyhIDBoNbqV+lCewhk
 ivFW/J+8hzyLZiHY4JCVFZkeKB9V9Bh++sXmn2cibv/yNv0zkgpOIcZ1gAPr7oTsWpXL
 bEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YdXEJZRP1IFp2O0duDOqWUbcJqfKg7Q1OugwBf6nt/k=;
 b=sB8IZ7zHh7CUQp7ixNrQ8YuEI5MEDD3eGwqRUUq+On0UrFqyyTuf5A8z1glwNCBC22
 HA3EWek+h/1uYZNj+LhJj4lH+8ezfoAspKZzKvj+9dIZBRAYmFYYaxDqe8OCbKxwDy0q
 RwiWTfddy1nzAP6IND9eIevGB1PUMBc8CQLEu8QAeK2fBcfIfLExTzZ0U2rRA6rPn/j3
 zYIPIeadIzjbOqpCiFxLCJKJPz4jxHy84BB+omEW5n47wMPNh2Oi+6rHngUR2qu13Jqs
 i4aQgj5aumFpheZW8lt0or3UOf9AX0q8rJuQK4J1b1zExyndcGWaRG4Aj+woLrDOALiN
 Q4Hg==
X-Gm-Message-State: APjAAAU6hDBxbY/Kwv4T4z1nXJgMUve95gPHGt75kPD7fzFUi12N3+ao
 nVMsyeZSOPFDQh3UE/USFu5cBCqjMd0=
X-Google-Smtp-Source: APXvYqyDBTytU+q3/fEM4RGjNNrtL98emhj+zwGgbuMNo6MjmFmTrx6ZbiPNEsX+vNVdhB8q2PKUxA==
X-Received: by 2002:a17:902:b08d:: with SMTP id
 p13mr60534411plr.109.1577574753090; 
 Sat, 28 Dec 2019 15:12:33 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 21/29] target/sh4: Remove MMU_MODE{0,1}_SUFFIX
Date: Sun, 29 Dec 2019 10:11:16 +1100
Message-Id: <20191228231124.18307-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


