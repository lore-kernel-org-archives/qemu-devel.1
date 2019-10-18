Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86A2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E6C20869
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNMbParS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E6C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWiR-0001EO-My
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWJ5-0006mG-0k
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWJ4-0005aY-3z
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:54 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLWJ2-0005Wz-C7
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:54 -0400
Received: by mail-pg1-x542.google.com with SMTP id 23so3765086pgk.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bIwXZuVFcex8c2gsnRtwJL32LXPTCWgJCQzC/Gsa6O8=;
 b=SNMbParSoCGF7WYBp3B8k5/vpmixY7ksuS18lVNemz2GZPYdU1q4SLEZ3ccNRRRfmo
 pqgShOKXVlAxY94DrdCeiqMAxvUOZpUPf4F0BDFvqEDSDP9KS5EcqUn9sRioOFpdnRyl
 ytbmSy2RJONilmLS3nU5rmxUn/7dPyt86YaMZqT4ggKNerRCXGkKiTuUI4OX52VE1N9v
 RVdAaJeEr+OHeET0kRH4F8VuqTn/Y73EPVL/NsVy+afUAyLrjvEf3m5yG7YLt9mzxTAT
 dVLWRMHVzmrzd3htQCSqon1g0C3jaXzxPCZ42vTOcOj7r4G5zV0wGIStZnUAHnHMYW1p
 fRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bIwXZuVFcex8c2gsnRtwJL32LXPTCWgJCQzC/Gsa6O8=;
 b=i4iEGftzR3J1P6iGXvavAPE61zrcLpK4u0JnofVz+h92ia2zobxwDbGbwKQr4eswpI
 ZooNeytALL1Ha5vTImtirliDGHOn1bYAphYe93HA4IIqIUQC/PFW5A2ydOC45yzISwBx
 9OjFqzsfrQNWoI1D39eGSaRr2+sRR2Yg9KkzZMlXkXC5bETIH5U2R/xDS43q0C0WnPfM
 qFTejlJDfFwMQZ8bDFCqXWJQF/A8rbQrGGs/m+kA8chZjagLlLVXlQH0cQkF6E5ewkxq
 UEUD4/LSVaCwt8xavywKs/Pbf1nwWgIBDj9kxvZ+DWqNgk8tHS/dP5KymzaXD3iH5oXt
 dcrw==
X-Gm-Message-State: APjAAAV9RHeXtQVjYqah0NJcuNq+8VJvJjZDr+nW9JsGU9i0MuHPTmqB
 Ta++j+MdznDBiXDRi++Smc5Acwkv5Mk=
X-Google-Smtp-Source: APXvYqxdBMJQXqfViC5XJeYTkwi0lH4byylV6XM3ASAzGFTdov3hCRGgDC+GYFsnN/9qaHO9Ir6JJw==
X-Received: by 2002:a17:90a:86c2:: with SMTP id
 y2mr12391573pjv.105.1571420689679; 
 Fri, 18 Oct 2019 10:44:49 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d20sm7857534pfq.88.2019.10.18.10.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 10:44:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 14/22] target/arm: Hoist store to cs_base in
 cpu_get_tb_cpu_state
Date: Fri, 18 Oct 2019 10:44:23 -0700
Message-Id: <20191018174431.1784-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018174431.1784-1-richard.henderson@linaro.org>
References: <20191018174431.1784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By performing this store early, we avoid having to save and restore
the register holding the address around any function calls.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f7d3f257d..37424e3d4d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11225,6 +11225,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 {
     uint32_t flags, pstate_for_ss;
 
+    *cs_base = 0;
     flags = rebuild_hflags_internal(env);
 
     if (is_a64(env)) {
@@ -11298,7 +11299,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     }
 
     *pflags = flags;
-    *cs_base = 0;
 }
 
 #ifdef TARGET_AARCH64
-- 
2.17.1


