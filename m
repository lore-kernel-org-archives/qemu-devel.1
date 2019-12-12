Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA005C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823FE2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9ifO4x8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823FE2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFgh-0002Rk-V0
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFef-0000mS-Hf
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFee-0003qQ-5X
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:45 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFed-0003oo-V5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:44 -0500
Received: by mail-pf1-x443.google.com with SMTP id s18so28492pfd.8
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k7TVKqC6wpnG6/oe5COCiVkS66yxk1gF0iSSBffTaF8=;
 b=D9ifO4x8Xh5HI25dUv+e8Tai+TGpxXXG8oTF+hw+0uAvkV8339NGkCvhlnrmwB7+uz
 dsKQknGzebL//SWhY/XHBrG+0i3oP+RfelBJdxMrQQ6sXpgLxGZtYvHtFVPF904Tn2sN
 kog5EAb4Z4SzmJzulxyVlSZobBfaueiYwDxo0MQ+UME2ZzE0V/3nHICNpVmOYkW/lQOx
 qZQ006BJvdBo1jmupk3GV5X30vcXt1ZJuGEUJrU8WdTgnFqqBjXHhv+XQG0E0ls9mg7/
 5seGp49L8aeKUG6X85Uuel+U2ij7bXL/7HxaDyUdUWFBzelhQ3ZbMCmNXhNsNeGJ2Y1D
 +xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k7TVKqC6wpnG6/oe5COCiVkS66yxk1gF0iSSBffTaF8=;
 b=hvnPyb7eTMibu5vwREh1vIWkDeZB8eaPCc+V1UUwOuYnXAPmjGatGOH/0MrJZtn+3w
 gr8P4CwmVfCweResho7UCccowOFbl77jzzTgZBBbfrl+HN41dGRwMe0d1kErcwWYo/vf
 mGPt5BvOEJbx5VRoQ57ahlWsmYZ4vKNqpqDSYObSF7xDqQyfrZH9Gd8wcPHi5vjQfOw6
 MYymlN9um3HbhOyddrmxdw83VTsJSIWQzBN5QKf8lYDgISqP2H6OyF5TP7a4FLbZmTV0
 YWJWG/YYazrUgtaYsvumcZuGvqwJSvj8v6zIKt2fMjF0m7PQg82L7tjG2dTmTMW2bLIp
 SW8Q==
X-Gm-Message-State: APjAAAVsl3po1p0GKLwhYwhXiViEuRawBc/3A6CSh9a8c4sESO1q0BM3
 t8gN7O3C7nw/aRmcWLXdq6WZpqqSmHU=
X-Google-Smtp-Source: APXvYqzhPbWJq6v87XLvD7wLopriI3V8ug25HVvvr9x/eRmhvGYyJ2gJpA6Edv17FTxLfjatZjQtWA==
X-Received: by 2002:a62:33c6:: with SMTP id z189mr7684937pfz.246.1576123242515; 
 Wed, 11 Dec 2019 20:00:42 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:00:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/28] target/xtensa: Use probe_access for itlb_hit_test
Date: Wed, 11 Dec 2019 20:00:12 -0800
Message-Id: <20191212040039.26546-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 2607:f8b0:4864:20::443
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

Cc: Max Filippov <jcmvbkbc@gmail.com>
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


