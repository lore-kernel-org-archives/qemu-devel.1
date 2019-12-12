Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F975C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBB3206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+L1V1lP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBB3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFw6-0006Xo-Te
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFf0-0000xR-LD
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFez-0004Fz-52
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:06 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFex-0004Ct-HD
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:03 -0500
Received: by mail-pf1-x444.google.com with SMTP id 2so20764pfg.12
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s8SYA9/Rwv4ZxWRA0n9zn8WOO8ULkXoz56NCsZvZKnc=;
 b=m+L1V1lPPJdVwCUWhqAkxFcLbXkRRDuX0jhJoJurdgs0RXfMeGuKNK1edDmaZDcI2E
 fcQgHY+nYfRbxA7NljJS2upmr4LJUBbaQa2QQJrZ0tjjputmeprADIFHnFiTa+yclGkc
 XVd7uQMLoraCjw83lSeoY4rafJ5pLeAGOuQ5tFYU1YmMiabbL/WQ5BmS9+DV5isJFg2Q
 dvPrLo7KT9TSIIWH5p+vctjqZys3HRfwK+hef2dtlnBohtdHNosIdel31bpIKxOliQhj
 156q3FM+jaq4x6DEfCP0NdjLD92dJtuBVEc7+1MO2Wnrh7B92YCUo8CXFrbS8zSiXhsY
 L4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s8SYA9/Rwv4ZxWRA0n9zn8WOO8ULkXoz56NCsZvZKnc=;
 b=fWjh9rJz22fR6vg18yDOp0/IcIeRZxZGyBXUSYUpOtKPGvz5QP59I6HBXx/wZsC3Vq
 c090f1g9UvMfNbvFRTQTDgXYgq534J75yxPA31P0ua6CciXB0QNYjOi7FxbvDM3DDDx0
 zMg/g8jpIAaJjpiiqGwfvdCISLt7wMjPzgy8MqGt4FxUC2RA+Slrag63S4In9+lXbjx1
 zQHs8D3uIDTfoG76No4CLYve7Mc8+zH6DL+fWdFRsJblqkwln8WQoxQ51bCrZSWG3C1Y
 ITddSBZzBD6am7yUm9xC1zewHM/k02B1Zq3PAlHoZRE+boclqS6FXTHMHRY2PuQXqyvY
 c9ug==
X-Gm-Message-State: APjAAAUbd70/RMU9n9K8w4gI6M4GMZ/CEDjyvPiZQAlb9T4WK2PYA6zN
 HK5JhgqvvTzrJF0QxQ2ZK1eKQg3WYRc=
X-Google-Smtp-Source: APXvYqxepNn82AW+9Ljc3G8bxodXlyGzRUuD1phZLW93szJpb3ykBY0WsaI6ts+xV1aZ/TsMg7+tJg==
X-Received: by 2002:a65:4206:: with SMTP id c6mr6595055pgq.46.1576123262179;
 Wed, 11 Dec 2019 20:01:02 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:01:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/28] target/cris: Remove MMU_MODE{0,1}_SUFFIX
Date: Wed, 11 Dec 2019 20:00:28 -0800
Message-Id: <20191212040039.26546-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index aba0a66474..bc43bc23a1 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -252,8 +252,6 @@ enum {
 #define cpu_signal_handler cpu_cris_signal_handler
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
 {
-- 
2.20.1


