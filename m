Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FBBC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8812C206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTHcj9MB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8812C206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58935 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYWF-0003AF-LH
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKM-0006uQ-MW
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKL-0001bb-Gj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:06 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:46266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKL-0001bL-Cu
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:05 -0400
Received: by mail-qk1-x743.google.com with SMTP id u4so8131113qkj.13
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4qeIcEWpz8LKLMc/KvwaeZt/B8JbWVxadE/kdF7i8Q0=;
 b=UTHcj9MBsYf+7QJwkvCxEr+sJmI3dRAByba5AEmoCeBB8ywc4Rh9Z+UxzC17HO3NvU
 p6QeKPbba1ry2xUy/JXcQYGmPH25xLnBgs7cK3OGfLbhKqQVeKcL/UaxlGrn9Au1Dd7I
 Tr3GFvkXP0X2/hos4poYuS8cGBfm4bajJ4CkrxmEYwPyWQT15M+WuX8PoOoJ/8rvf1La
 bqZESQZUXKCHynOlC4ZxGa5p6sWD9g6hGKapjx7W4foDBYnTgSexIjoqAFHcmQ3CkscI
 IfNkPOnozCi0fG1PFau/CgEvTjpAxYcVlu/ElEWq3EVIX78CHN35ihDsAV/zyhvDMGIK
 Mg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4qeIcEWpz8LKLMc/KvwaeZt/B8JbWVxadE/kdF7i8Q0=;
 b=oLfH+r22qV59ew5k1eviVsXeS3bFm+BykHn1/NRnNPhZvV9OqlTxwrR/F5jV/gZGm8
 Mz0r9kOrHMWdoo+AqI5aSBLLnL95XXaBFWHAElYGwKpIcUo2TBk6Q6gMnIWqF9gPXeJW
 BO3xdxcp7HCQamWGVkH0xACL1kaD+bS4YiTUIPsnv1ULSHB3nzKzAyCOInsLNlX60EaV
 Mz3HDucIDRfiQb14fq+gO7Lhp6PpQlfFrwj288UNlRu3Aa0MxMX0qUKFGgH0/cTqmIoJ
 skam2BUojmfsS/0WVf4qdT6UtZ9U/sPqHzcIz+YCMFS291NDtnMxhvPQ94K9IV7VPWoE
 q0rg==
X-Gm-Message-State: ANhLgQ2MhczQbmU4/45pWHwACQAzgEJtzVQM7KKgxTa+lru4WYAAt9v8
 2w7MPD1b0genkc2XtzV/heXK9wqznvDQWw==
X-Google-Smtp-Source: ADFU+vssGlGcQrtAXwfOBKC6vxNMvU2j0nhq0CMOtVOsZgk2+zsZoIV+aRpFCqs7Yltk7bP3r2OHrw==
X-Received: by 2002:a37:9dc9:: with SMTP id g192mr10247137qke.50.1585251484598; 
 Thu, 26 Mar 2020 12:38:04 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:04 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 23/74] m68k: convert to cpu_halted
Date: Thu, 26 Mar 2020 15:31:05 -0400
Message-Id: <20200326193156.4322-24-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>, "Emilio G. Cota" <cota@braap.org>,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/m68k/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 202498deb5..4a032a150e 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -222,7 +222,7 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
                 do_m68k_semihosting(env, env->dregs[0]);
                 return;
             }
-            cs->halted = 1;
+            cpu_halted_set(cs, 1);
             cs->exception_index = EXCP_HLT;
             cpu_loop_exit(cs);
             return;
-- 
2.17.1


