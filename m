Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF2CC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB4221835
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBNnvLPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB4221835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igycO-0006K8-H5
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb0-0004l7-84
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igyaz-0006ux-56
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:05 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igyaz-0006uM-09
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:05 -0500
Received: by mail-pf1-x442.google.com with SMTP id y206so6391479pfb.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mkGQo9JLGR6e+tkSUmklU8FYrD77VgZJcPg0K42unB0=;
 b=ZBNnvLPc3i/1x2D21xmEqk2Y0xOIwQ3QoZVxwjkpg6uHJmNsz6ogUhm5qgovjNao2Q
 DuUDp++WaI7lviLQ7EfApsaKyDjkR/9Ssvs40eXPUaRBALOWQI1KkGr8EZjf7QoqwYUz
 TJNEv0ZONze7XUVmIY3qRh9Nw1DL3VICtzJ370oWEO+Fo0BOs6If7GvWJK5fH+UuD9BG
 CcVoiRtge2De1DpEdINLVi5b7gByoJAUWniEjAJH437teDQ/dp0Xqswxm1SZ+4Tj2nCe
 mA1BNr8RLamBHLnBLPy6JGb6slR30DjJqibQJ2u4CKpwEEjp5RHY9qoY7Cqlw5DrxZ5P
 8krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mkGQo9JLGR6e+tkSUmklU8FYrD77VgZJcPg0K42unB0=;
 b=DPZYeW1wq1zfr48iOT5qWbgMgMzVGeU7zo6cleBRhJNsqdmA88GkoOYQ9+J8Gkg+KE
 yL4ndgTPy8XVNmdfQJY+9G/H9rZ3iKjw3aRKy08koyo5xCiPSMMyInP1Qs2VY8enbpbP
 O0GzNpeDw5ocOxmIbId1/j5unEl7UyIAUHbquNGRKyDNORdyflwWIbFoTb+UBorH72Ht
 RF48yGq9MPYjtZJXO0WClna6p3hUpRirruIJ7rSet9s9EvG+a9Hl+ELaZbKrMrCVBUA5
 ni0vWTJ3y8xm7jllqxfXpPdfFa9L0HUCbVAojYbdNzJx+yxvxG24PVxV8AcYA02p7uv8
 UvXQ==
X-Gm-Message-State: APjAAAURLRWOkgKru1a430DAXgumkSC6ykKa9BvXbhVjPqIdLt1Fflv9
 0tL7PJhVQBqY+3Ee/f5kwfkiNpnrQXg=
X-Google-Smtp-Source: APXvYqw5SerGq1TVHD77BdfSZwC65r4VM/DDx/rwiBUZNxDB3U4LLwRDgfXlmFv3SomGA8ILe4Wi5A==
X-Received: by 2002:aa7:8a88:: with SMTP id a8mr18783531pfc.224.1576534323719; 
 Mon, 16 Dec 2019 14:12:03 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/28] target/xtensa: Use probe_access for itlb_hit_test
Date: Mon, 16 Dec 2019 12:11:31 -1000
Message-Id: <20191216221158.29572-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't actually need the result of the read, only to probe that the
memory mapping exists.  This is exactly what probe_access does.

This is also the only user of any cpu_ld*_code_ra function.
Removing this allows the interface to be removed shortly.

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/mmu_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index f15bff306f..b01ff9399a 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -63,10 +63,11 @@
 void HELPER(itlb_hit_test)(CPUXtensaState *env, uint32_t vaddr)
 {
     /*
-     * Attempt the memory load; we don't care about the result but
+     * Probe the memory; we don't care about the result but
      * only the side-effects (ie any MMU or other exception)
      */
-    cpu_ldub_code_ra(env, vaddr, GETPC());
+    probe_access(env, vaddr, 1, MMU_INST_FETCH,
+                 cpu_mmu_index(env, true), GETPC());
 }
 
 void HELPER(wsr_rasid)(CPUXtensaState *env, uint32_t v)
-- 
2.20.1


