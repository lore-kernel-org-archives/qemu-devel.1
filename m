Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBA9C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684BC207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDkQ1wQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684BC207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyiO-0005ZY-82
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybV-0005Xw-Bn
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybU-0007cc-DI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:37 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybU-0007au-7z
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:36 -0500
Received: by mail-pf1-x442.google.com with SMTP id l127so4589840pfl.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RdINugPS7BTi3ugzwRFiwRgkZkC17AvAn9JuWLfSCDM=;
 b=MDkQ1wQI5owBVSezTGfopmtJhXbnUJ9OuAadvRmCVwh+wextdJo8GNsAcBndYW2f44
 GbPwTcrYLSDNpv7A3gLSxMntvrCKNWoF/y8uAuWKAV0DEZOBcVro30qQQhkd7F+SLHJQ
 wmZlhmMjkAqIYGMqZhvzn8rvNLqhhkAZPdFm2md616jmnsHBhPM0isCp4jBWHQsATyif
 vRw2jS71Lm3Tw+Y29ze1sxt0dCOqNfSD7O56ghaLB9eEylP2phCXak4aY8nJe9yIZmH7
 pWZxfh7uIk5RDGrJt7Kv3vzFNXimifGKG05bnur/NdQYrH3qjXRlC9Jjcf2FqDglhSc4
 kbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RdINugPS7BTi3ugzwRFiwRgkZkC17AvAn9JuWLfSCDM=;
 b=UdsYlHZCHX6D90k9npZggdkZYTqkA2dIilcMflTRNrjWEcijjcGYixQDdnMgNKwiqd
 RF8vQoG8ofj+fdGfTRPG/51LTHewewD/DpcRGntzzBPm3QNLNEoYibakb/7jVAxOJE1s
 8VMCDxXYL+TmxULrSFJ29Cvi8OSPiSieVsMhxieKuFB2EHQX+s+NnAYfqNBgHC5K+Ohr
 hmTjz7p4sRdiJk3Fm/ryxmTl1jz4WNZ5+ynsAXopjWFS9LYQJu7Q1pFWxLiFm5Qfpd6c
 4SjF3CpmWQaL6SwtinPcHSeC7xRWJJqjgcQ/BCqn1JvYRQjBsU6Or82+UNZO8v5i067o
 oBPg==
X-Gm-Message-State: APjAAAXuFrGz9A5m8Q6ghQqxThrFRyXOxUGn3/swpcJjZJCrEz73xWms
 Jag1oF/8em8d5u5CMCJJDnFB8eqjQBg=
X-Google-Smtp-Source: APXvYqzCzbIfSPotmRwMJdVjI1Zug+nYq2fDcvwDxNG/jDA3HMR15/O2ZO1ndDdiDr52TGSHQbaHAg==
X-Received: by 2002:a62:16d1:: with SMTP id 200mr18736289pfw.235.1576534355142; 
 Mon, 16 Dec 2019 14:12:35 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 22/28] target/xtensa: Remove MMU_MODE{0,1,2,3}_SUFFIX
Date: Mon, 16 Dec 2019 12:11:52 -1000
Message-Id: <20191216221158.29572-23-richard.henderson@linaro.org>
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

The functions generated by these macros are unused.

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
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


