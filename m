Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A590C46460
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E70F217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhEzya3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E70F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49291 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPBjO-0003MJ-8q
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:02:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPBhk-0002SB-Jq
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPBhh-0002UX-F6
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hPBhd-0002QC-RW
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id j187so8604743wmj.1
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=P6OpXLABH0bE0gbKxQnLm+pXDLfhXNolnZxvDMNERq8=;
	b=xhEzya3U9fREEkpXMVzA1gW7VCa1JRlmW+ax4krdH1cg6AfVfG+pRTIADUgvrwP3ui
	wY2i0oSPOacSY2m4GajImz3JrG5CKdrSBmV5Z2P/OPpmS+BtVN06A21Yp6AWDqjd1saU
	sciyBX6CQV1VaqlnlDXVDwzmjsTgHjez5t8RzfrQOFE2lGYhzrGtM+38fCT+0ZqE+n4s
	g9NMU6SPP+OlchhNRq0K5K4rxnY13SFjCqSFN3BdgYzn6ND5tsS7OLGPWjhicjJaANsT
	6KLke5mTmGNfZGqZvhq2yg1zIcD1BmUY7ms1hus77DcYZEBNrnpd+5EWNKXfQ6N7pHGz
	t8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=P6OpXLABH0bE0gbKxQnLm+pXDLfhXNolnZxvDMNERq8=;
	b=nNiXuA2qaSyIkvfflGFfbTzdPmsumY2neMEJeaKcTl3LrGaWlNKaIbpfXWqymsFV/1
	kdE2q7RI5FtUOaB4vPJWMdN8hdBKVdFdx3+gktf4hp1VRjAnmjBmmJxGpy4O27qlUNPs
	BDjp6EQMWV36i2eYkE8s9aIto4x9yC/x7Eniqv3qBGg1zBJU/GaGAJIUOOhrHdfOov1R
	BWUvnmYZ0OGIVq/VaGKJ6XpvRNwS9qnOlHV+9W7WHGJjqeP2/1R8ntv1PZKIcrfRSPJZ
	+bdtvCKUnw1fA7hfZ6Y70vyS2qB5cXj6gakXPbFQBx3+lra/4g0Y4FQ5u9+1XrOzxxU2
	w5Dg==
X-Gm-Message-State: APjAAAUNMBz8ztdBAY3OUi0GKdxmjxckfXznMADKVqR1Y8w77E4Tq7QV
	mUtEoPQokGkLLQvrKZLuutH2kQ==
X-Google-Smtp-Source: APXvYqwCu5mhIa6kBL1ZH+y9XQaX2oLvrikJsJu5jvhcN0saWhHCSC3IHDrTJShfsx7Qh6FCEnwOUw==
X-Received: by 2002:a05:600c:1191:: with SMTP id
	i17mr318389wmf.84.1557518467333; 
	Fri, 10 May 2019 13:01:07 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b10sm11569023wrh.59.2019.05.10.13.01.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 13:01:06 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 428801FF92;
	Fri, 10 May 2019 21:01:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 10 May 2019 21:01:01 +0100
Message-Id: <20190510200101.31096-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510200101.31096-1-alex.bennee@linaro.org>
References: <20190510200101.31096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PULL 5/5] cputlb: Do unaligned store recursion to
 outermost function
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This is less tricky than for loads, because we always fall
back to single byte stores to implement unaligned stores.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e4d0c943011..a0833247684 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1413,9 +1413,9 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
  * Store Helpers
  */
 
-static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
-                         TCGMemOpIdx oi, uintptr_t retaddr, size_t size,
-                         bool big_endian)
+static inline void __attribute__((always_inline))
+store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+             TCGMemOpIdx oi, uintptr_t retaddr, size_t size, bool big_endian)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1514,7 +1514,7 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
                 /* Little-endian extract.  */
                 val8 = val >> (i * 8);
             }
-            store_helper(env, addr + i, val8, oi, retaddr, 1, big_endian);
+            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
         }
         return;
     }
-- 
2.20.1


